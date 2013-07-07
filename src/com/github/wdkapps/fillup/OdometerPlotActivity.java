/*
 * *****************************************************************************
 * Copyright 2013 William D. Kraemer
 *  
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *    
 * ****************************************************************************
 */

package com.github.wdkapps.fillup;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import com.androidplot.util.PaintUtils;
import com.androidplot.xy.BarFormatter;
import com.androidplot.xy.BarRenderer;
import com.androidplot.xy.BoundaryMode;
import com.androidplot.xy.LineAndPointFormatter;
import com.androidplot.xy.PointLabelFormatter;
import com.androidplot.xy.SimpleXYSeries;
import com.androidplot.xy.XYPlot;
import com.androidplot.xy.XYStepMode;

import android.os.Bundle;
import android.preference.PreferenceManager;
import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.graphics.Color;
import android.util.Log;
import android.view.Display;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * An Activity that displays a graph of odometer data (distance driven).
 */
public class OdometerPlotActivity extends Activity implements OnSharedPreferenceChangeListener {

	/// for logging
	private static final String TAG = OdometerPlotActivity.class.getName();

    /// the plot
    private XYPlot plot;
    
    /// the plot title
    private TextView title;
    
    /// defines how the plot bars are drawn
    BarFormatter plotFormatter;
    
    /// defines how the average line is drawn
    LineAndPointFormatter avgFormatter;
    
    /// average distance driven per month for plot period
    private float average = 0;
    
    /// total distance driven for plot period
    private long sumy = 0;
    
    /// range of y-axis data for the plot period (distance driven)
    private long miny = 0;
    private long maxy = 0;
    
    /// range of x-axis data for the plot period (sequential index [0..n] mapped to months) 
    private long minx = 0;
    private long maxx = 0;

    /// x-axis boundaries of the plot (based on minx/maxx)
    private long lowerboundx = 0;
    private long upperboundx = 0;
    
    /// units of measurement
    private Units units;
    
    /// formatter for x-axis labels - maps from x-axis values to month labels
    private MappedLabelFormat xlabels = new MappedLabelFormat();
    
    /**
     * DESCRIPTION:
     * Creates the graph.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_odometer_plot);
        
        // get current units of measurement
        units = new Units(Settings.KEY_UNITS);
        
        // get current instance of our widgets
        plot = (XYPlot)findViewById(R.id.xyOdometerPlot);
        title = (TextView)findViewById(R.id.titleOdometerPlot);
        
        // create a formatter to use for drawing the plot series 
        plotFormatter = new BarFormatter(
				getResources().getColor(R.color.plot_fill_color),
				getResources().getColor(R.color.plot_line_color));
        
        // create a formatter to use for drawing the average line
        avgFormatter = new LineAndPointFormatter(
        		getResources().getColor(R.color.plot_avgline_color),
        		null,
        		null,
        		(PointLabelFormatter)null);
        
        // white background for the plot
        plot.getGraphWidget().getGridBackgroundPaint().setColor(Color.WHITE);
        
        // remove the series legend
        plot.getLayoutManager().remove(plot.getLegendWidget());

        // make room for bigger labels
        // TODO: is there a better way to do this?
        float width = plot.getGraphWidget().getRangeLabelWidth() * 2f;
        plot.getGraphWidget().setRangeLabelWidth(width);
        width = plot.getGraphWidget().getDomainLabelWidth() * 1.5f;
        plot.getGraphWidget().setDomainLabelWidth(width);
        float margin = plot.getGraphWidget().getMarginTop() * 3f;
        plot.getGraphWidget().setMarginTop(margin);
        margin = plot.getGraphWidget().getMarginBottom() * 3f;
        plot.getGraphWidget().setMarginBottom(margin);
        
        // define plot axis labels
        plot.setRangeLabel(units.getDistanceLabel());
        plot.setDomainLabel(getString(R.string.months_label));
        
        // specify format of axis value labels
        plot.setRangeValueFormat(new DecimalFormat("#######0"));
        plot.setDomainValueFormat(xlabels);
        
        // plot the data
        drawPlot();

        // setup to be notified when plot options change
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);;
		prefs.registerOnSharedPreferenceChangeListener(this);
    }        
    
    /**
     * DESCRIPTION:
     * Performs the steps required to display the data in the plot widget.
     */
    private void drawPlot() {
    	
    	// adjust fonts to reflect preferences
    	setPlotFontSizes();
        
        // add series of data points to plot (x,y)
        plot.addSeries(getPlotSeries(),plotFormatter);

        // set the boundaries for the X and Y-axis based on the data values
        setPlotAxisBoundaries();
        
        // add a line reflecting data average
        if (average > 0) {
        	plot.addSeries(getAverageSeries(),avgFormatter);
        }

        // define the plot title
        setPlotTitle();
    }
    
    /**
     * DESCRIPTION:
     * Clears the plot widget, then plots the data again.
     */
    private void redrawPlot() {
		plot.clear();
		drawPlot();
		plot.redraw();
    }
    
    /**
     * DESCRIPTION:
     * Adjust font sizes used for plot labels to reflect shared
     * preferences.
     */
    private void setPlotFontSizes() {
    	Context context = getApplicationContext();
    	PlotFontSize size = new PlotFontSize(this,Settings.KEY_PLOT_FONT_SIZE);
    	
    	// axis step value labels
        PaintUtils.setFontSizeDp(context,
            	plot.getGraphWidget().getRangeLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(context,
            	plot.getGraphWidget().getDomainLabelPaint(),size.getSizeDp());
        
        // axis origin value labels
        PaintUtils.setFontSizeDp(context,
        		plot.getGraphWidget().getRangeOriginLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(context,
        		plot.getGraphWidget().getDomainOriginLabelPaint(),size.getSizeDp());

        // axis title labels
        PaintUtils.setFontSizeDp(context,
                plot.getRangeLabelWidget().getLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(context,
                plot.getDomainLabelWidget().getLabelPaint(),size.getSizeDp());
        plot.getRangeLabelWidget().pack();
        plot.getDomainLabelWidget().pack();
    }
    
    /**
     * DESCRIPTION:
     * Sets the title of the plot to reflect the average distance per month driven.
     */
    private void setPlotTitle() {

    	String title = null;

    	if (average > 0) {
    		title = String.format(App.getLocale(),getString(R.string.title_plot_odometer),
    				sumy,
    				units.getDistanceLabelLowerCase(),
    				average);
    	} else {
    		title = String.format(App.getLocale(),getString(R.string.title_plot_odometer_noavg),
    				sumy,
    				units.getDistanceLabelLowerCase());
    	}

    	this.title.setText(title);
    }
    
    /**
     * DESCRIPTION:
     * Sets the boundaries for the X and Y-axis based on the data values.
     */
    private void setPlotAxisBoundaries() {
    	
        //set y-axis boundaries
    	long boundy = 100;
    	while (maxy >= boundy) boundy *= 2;
    	plot.setRangeBoundaries(0, boundy, BoundaryMode.FIXED);
    	
    	// set y-axis steps
    	double stepy = ((double)boundy)/10;
        plot.setRangeStep(XYStepMode.INCREMENT_BY_VAL, stepy);
        plot.setTicksPerRangeLabel(2);
        
        // set x-axis boundaries
        lowerboundx = minx - 1;
        upperboundx = maxx + 1;
        plot.setDomainBoundaries(lowerboundx,upperboundx,BoundaryMode.FIXED);
        
        // set x-axis steps
        plot.setDomainStep(XYStepMode.INCREMENT_BY_VAL,1);
        plot.setTicksPerDomainLabel(1);
        
        // determine the number of months being plotted
        long months = maxx - minx + 1;        
        
        // adjust bar thickness based on number of months being plotted
        BarRenderer<?> barRenderer = (BarRenderer<?>)plot.getRenderer(BarRenderer.class);
        if(barRenderer != null) {
        	Display display = getWindowManager().getDefaultDisplay();
        	float displayWidth = Utilities.convertPixelsToDp(display.getWidth());
        	float plotWidth = displayWidth * 0.75f;
            float barWidth = plotWidth / months;
            barRenderer.setBarWidth(barWidth);
        }
        
        // adjust label size based on number of months being plotted
        xlabels.setAbbreviate(months > 6);
    }

    /**
     * DESCRIPTION:
     * Obtains (x,y) values from the current data set for plotting. Also
     * calculates the range (min/max) of x-axis and y-axis values for the series.
     * @return a SimpleXYSeries instance containing (x,y) values to plot.
     */
    private SimpleXYSeries getPlotSeries() {
    	
    	final String tag = TAG + ".getPlotSeries()";
    	
    	// create lists of x-axis, and y-axis numbers to plot
    	List<Number> xNumbers = new LinkedList<Number>();
    	List<Number> yNumbers = new LinkedList<Number>();

    	// get numbers to plot from gas record data, where (x,y) is:
    	// x = sequential index [0..n] with labels mapped to specific months
    	// y = calculated distance driven for that month
    	sumy = 0;    	
    	miny = Long.MAX_VALUE; 
    	maxy = Long.MIN_VALUE;
    	minx = Long.MAX_VALUE; 
    	maxx = Long.MIN_VALUE;
    	xlabels.clear();
    	long x = 0L;
    	long y = 0L;
    	for (Date month : PlotActivity.monthly) {
    		y = PlotActivity.monthly.getTrips(month).getDistance();
    		Log.d(tag,"month="+month.toString()+" x="+x+" y="+y);
    		minx = Math.min(minx, x);
    		maxx = Math.max(maxx, x);
    		miny = Math.min(miny, y);
    		maxy = Math.max(maxy, y);
    		xNumbers.add(x);
    		yNumbers.add(y);
    		sumy += y;
    		xlabels.put(x++,getMonthLabel(month));
    	}

    	// adjust min/max values if no data
    	if (xNumbers.isEmpty()) minx = maxx = 0;
    	if (yNumbers.isEmpty()) miny = maxy = 0;
    	
    	// calculate average for the series
    	average = 0;
    	if (!yNumbers.isEmpty()) {
    		average = sumy / yNumbers.size();
    	}
    	
    	Log.d(tag,"minx="+minx+" maxx="+maxx);
    	Log.d(tag,"miny="+miny+" maxy="+maxy);
    	Log.d(tag,"sumy="+sumy+" size="+yNumbers.size()+" average="+average);

    	// add current month to series after average calculation was performed
    	Date month = new Date();
		y = PlotActivity.monthly.getTrips(month).getDistance();
		Log.d(tag,"month="+month.toString()+" x="+x+" y="+y);
		minx = Math.min(minx, x);
		maxx = Math.max(maxx, x);
		miny = Math.min(miny, y);
		maxy = Math.max(maxy, y);
		xNumbers.add(x);
		yNumbers.add(y);
		sumy += y;
		xlabels.put(x++,getMonthLabel(month));
    	
        // create a new series from the x and y axis numbers
    	String title = "";
        return new SimpleXYSeries(xNumbers,yNumbers,title);
    }
    
    /**
     * DESCRIPTION:
     * Obtains (x,y) values for a line reflecting the average value
     * for the current data set.
     * @return a SimpleXYSeries instance containing (x,y) values to plot.
     */
    private SimpleXYSeries getAverageSeries() {
    	
    	// create lists of x-axis, and y-axis numbers to plot
    	List<Number> xNumbers = new LinkedList<Number>();
    	List<Number> yNumbers = new LinkedList<Number>();

    	// line at average, across x-axis
    	xNumbers.add(lowerboundx);
    	yNumbers.add(average);
    	xNumbers.add(upperboundx);
    	yNumbers.add(average);

    	// create a new series from the x and y axis numbers
    	String title = "";
        return new SimpleXYSeries(xNumbers,yNumbers,title);
    }
    
    /**
     * DESCRIPTION:
     * Called when units of measurement shared preference has changed.
     * Updates the plot to reflect the new units.
     */
    public void onUpdateUnits() {
    	
        // get new units of measurement
        units = new Units(Settings.KEY_UNITS);
        
        // update the plot to reflect new units
        plot.setRangeLabel(units.getDistanceLabel());

        // redraw the plot
		redrawPlot();
    }
    
	/**
	 * DESCRIPTION:
	 * Called when one or more plot preferences have changed.
	 * @see android.content.SharedPreferences.OnSharedPreferenceChangeListener#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)
	 */
	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
		
		if (key.equals(Settings.KEY_PLOT_DATE_RANGE)) {
			// plot date range changed
			redrawPlot();
		} 
			
		if (key.equals(Settings.KEY_PLOT_FONT_SIZE)) {
			// plot font size changed
			redrawPlot();
        }
		
		/*
		 * NOTE: changes to Settings.KEY_UNITS is handled via call to
		 * our onUpdateUnits() method by our PlotActivity parent after
		 * the plot data has been updated.
		 */

	}
	
	/**
	 * DESCRIPTION:
	 * Returns a label for a specified month.
	 * @param date - the month
	 * @return a label String.
	 */
	private String getMonthLabel(Date date) {
		final String labels[] = getResources().getStringArray(R.array.arrayPlotMonthLabels);
		return labels[date.getMonth()];
	}

}

