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
import java.util.LinkedList;
import java.util.List;

import com.androidplot.util.PaintUtils;
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
import android.text.format.DateFormat;
import android.util.Log;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * An Activity that displays a graph of gas mileage data.
 */
public class MileagePlotActivity extends Activity implements OnSharedPreferenceChangeListener {
	
	/// for logging
	private static final String TAG = MileagePlotActivity.class.getName();

    /// the plot
    private XYPlot plot;
    
    /// the plot title
    private TextView title;
    
    /// defines how the plot lines are drawn
    LineAndPointFormatter plotFormatter;
    
    /// defines how the average line is drawn
    LineAndPointFormatter avgFormatter;
    
    /// the range of dates to plot (shared preference) 
    private PlotDateRange range;
    
    /// average mileage for the current graph
    private float average = 0;
    
    /// range of y-axis data for the plot period (calculated mileage values)
    private float miny = 0;
    private float maxy = 0;
    
    /// range of x-axis data for the plot period (time in milliseconds since 1970) 
    private long minx = 0;
    private long maxx = 0;

    /// x-axis boundaries of the plot (based on minx/maxx and plot range preference)
    private long lowerboundx = 0;
    private long upperboundx = 0;
    
    /// units of measurement
    private Units units;
    
    /**
     * DESCRIPTION:
     * Creates the graph.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mileage_plot);
        
        // get current units of measurement
        units = new Units(Settings.KEY_UNITS);
        
        // get current instance of our widgets
        plot = (XYPlot)findViewById(R.id.xyMileagePlot);
        title = (TextView)findViewById(R.id.titleMileagePlot);
        
        // create a formatter to use for drawing the series using LineAndPointRenderer:
        plotFormatter = new LineAndPointFormatter(
        		getResources().getColor(R.color.plot_line_color),
        		getResources().getColor(R.color.plot_point_color),
        		getResources().getColor(R.color.plot_fill_color),
        		(PointLabelFormatter)null);

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

        // reduce the number of axis labels
        plot.setTicksPerRangeLabel(2);
        plot.setTicksPerDomainLabel(4);
        
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
        plot.setRangeLabel(units.getMileageLabel());
        plot.setDomainLabel("");
        
        // specify format of axis value labels
        plot.setRangeValueFormat(new DecimalFormat("###0.0"));
        plot.setDomainValueFormat(DateFormat.getDateFormat(App.getContext()));
        
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
     * Clears the plot widget, then draws the data again.
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
     * Sets the title of the plot to reflect the current average mileage.
     */
    private void setPlotTitle() {
    	String title = getString(R.string.message_insufficient_data);
    	if (average > 0) {
    		title = String.format(App.getLocale(),getString(R.string.title_plot_mileage),
    				average,
    				units.getMileageLabel()); 
    	}
    	this.title.setText(title);
    }
    
    /**
     * DESCRIPTION:
     * Sets the boundaries for the X and Y-axis based on the data values.
     */
    private void setPlotAxisBoundaries() {
    	
    	final long MSEC_PER_DAY = 86400000L;
    	
        //set y-axis boundaries
    	long boundy = 5;
    	while (maxy >= boundy) boundy *= 2;
    	plot.setRangeBoundaries(0, (float)boundy, BoundaryMode.FIXED);
    	
    	// set y-axis steps
    	double stepy = ((double)boundy)/10;
        plot.setRangeStep(XYStepMode.INCREMENT_BY_VAL, stepy);
        
        // calculate x-axis boundaries
        if (range.getValue() == PlotDateRange.ALL) {
        	// use actual min/max values from data
        	lowerboundx = minx;
        	upperboundx = maxx;
        } else {
        	// use start/end values for the plot date range
        	lowerboundx = range.getStartDate().getTime(); 
        	upperboundx = range.getEndDate().getTime();
        }
        
        // special case: one data point - expand range to center it in the plot
        if ((average != 0) && (lowerboundx == upperboundx)) {
        	lowerboundx -= MSEC_PER_DAY;
        	upperboundx += MSEC_PER_DAY;
        }

        // set x-axis boundaries
    	plot.setDomainBoundaries(lowerboundx,upperboundx,BoundaryMode.FIXED);
    }

    /**
     * DESCRIPTION:
     * Obtains (x,y) values from the current data set for plotting. Also
     * calculates the average y-value for the series.
     * @return a SimpleXYSeries instance containing (x,y) values to plot.
     */
    private SimpleXYSeries getPlotSeries() {
    	
    	final String tag = TAG + ".getPlotSeries()";
    	
    	// get plot date range from preferences
    	range = new PlotDateRange(this,Settings.KEY_PLOT_DATE_RANGE); 

    	// create lists of x-axis, and y-axis numbers to plot
    	List<Number> xNumbers = new LinkedList<Number>();
    	List<Number> yNumbers = new LinkedList<Number>();

    	// get numbers to plot from gas record data, where (x,y) is:
    	// x = time in milliseconds (from date) plus an index to avoid duplicate values
    	// y = calculated mileage at that date
    	float sumy = 0;
    	miny = Float.MAX_VALUE; 
    	maxy = Float.MIN_VALUE;
    	minx = Long.MAX_VALUE; 
    	maxx = Long.MIN_VALUE;
    	for (GasRecord record : PlotActivity.data) {
    		if (record.hasCalculation() && 
    			!record.isCalculationHidden() && 
    			range.contains(record.getDate())) {
    			
    			long x = record.getDate().getTime() + (long)xNumbers.size();
    			float y = record.getCalculation().getMileage();
   				Log.d(tag,"date="+record.getDateString()+" x="+x+" y="+y);
    			minx = Math.min(minx, x);
    			maxx = Math.max(maxx, x);
    			miny = Math.min(miny, y);
    			maxy = Math.max(maxy, y);
   				xNumbers.add(x);
   				yNumbers.add(y);
   				sumy += y;
    		}
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

    	// line at average, across the x-axis
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
        plot.setRangeLabel(units.getMileageLabel());

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
}
