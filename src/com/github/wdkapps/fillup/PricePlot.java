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

import java.text.Format;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.Display;
import android.view.ViewGroup;

import com.androidplot.util.PaintUtils;
import com.androidplot.util.PixelUtils;
import com.androidplot.xy.BarFormatter;
import com.androidplot.xy.BarRenderer;
import com.androidplot.xy.BoundaryMode;
import com.androidplot.xy.LineAndPointFormatter;
import com.androidplot.xy.PointLabelFormatter;
import com.androidplot.xy.PointLabeler;
import com.androidplot.xy.SimpleXYSeries;
import com.androidplot.xy.XYPlot;
import com.androidplot.xy.XYSeries;
import com.androidplot.xy.XYStepMode;

/**
 * DESCRIPTION:
 * A plot of gas price data.
 * 
 * NOTE: 
 * This class was originally implemented as a separate Activity "tab" inside
 * a parent TabActivity, but has been refactored to manage an XYPlot view
 * for a parent Activity. 
 */
public class PricePlot implements OnSharedPreferenceChangeListener {

	/// for logging
	private static final String TAG = PricePlot.class.getName();

	/// the parent activity
	private Activity activity;

    /// the plot
    private XYPlot plot;
    
    /// defines how the plot bars are drawn
    private BarFormatter plotFormatter;
    
    /// defines how the average line is drawn
    private LineAndPointFormatter avgFormatter;
    
    /// defines how the average point label is drawn
    private PointLabelFormatter avgLabelFormatter;
    
    /// average gas used per month for plot period
    private double average = 0;
    
    /// total gas used for plot period
    private TripRecord sumy;
    
    /// range of y-axis data for the plot period (gas used)
    private double miny = 0;
    private double maxy = 0;
    
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
    
    /// formatter for y-axis labels
    private Format ylabels = CurrencyManager.getInstance().getSymbolicFormatter();  
    
    /**
     * DESCRIPTION:
     * Creates the graph.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    public void onCreate(Bundle savedInstanceState, Activity parent, XYPlot xyplot)
    {
    	this.activity = parent;
    	this.plot = xyplot;
    	
        // get current units of measurement
        units = new Units(Settings.KEY_UNITS);
        
        // create a formatter to use for drawing the plot series 
        plotFormatter = new BarFormatter(
				activity.getResources().getColor(R.color.plot_fill_color),
				activity.getResources().getColor(R.color.plot_line_color));

        // create a formatter for average label
        float hOffset = 50f;
        float vOffset = -10f;
        avgLabelFormatter = new PointLabelFormatter(
        		activity.getResources().getColor(R.color.plot_avgline_color),
        		hOffset,
        		vOffset);

        // create a formatter to use for drawing the average line
        avgFormatter = new LineAndPointFormatter(
        		activity.getResources().getColor(R.color.plot_avgline_color),
        		null,
        		null,
        		avgLabelFormatter);
        
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
        String format = activity.getString(R.string.title_plot_price_range);
        String label = String.format(App.getLocale(),format,units.getLiquidVolumeRatioLabel());
        plot.setRangeLabel(label);
        plot.setDomainLabel(activity.getString(R.string.months_label));
        
        // specify format of axis value labels
        plot.setRangeValueFormat(ylabels);
        plot.setDomainValueFormat(xlabels);

        // plot the data
        drawPlot();
        
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

        	// specify format of the average point label 
        	avgFormatter.setPointLabeler(new PointLabeler() {
        		@Override
        		public String getLabel(XYSeries series, int index) {
        			return (index == 0) ? ylabels.format(series.getY(index)) : "";
        		}
        	});
        }
    
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
    	PlotFontSize size = new PlotFontSize(activity,Settings.KEY_PLOT_FONT_SIZE);

    	// plot title label
        PaintUtils.setFontSizeDp(plot.getTitleWidget().getLabelPaint(),size.getSizeDp());
        plot.getTitleWidget().pack();

    	// axis step value labels
        PaintUtils.setFontSizeDp(plot.getGraphWidget().getRangeLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(plot.getGraphWidget().getDomainLabelPaint(),size.getSizeDp());
        
        // axis origin value labels
        PaintUtils.setFontSizeDp(plot.getGraphWidget().getRangeOriginLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(plot.getGraphWidget().getDomainOriginLabelPaint(),size.getSizeDp());

        // axis title labels
        PaintUtils.setFontSizeDp(plot.getRangeLabelWidget().getLabelPaint(),size.getSizeDp());
        PaintUtils.setFontSizeDp(plot.getDomainLabelWidget().getLabelPaint(),size.getSizeDp());
        plot.getRangeLabelWidget().pack();
        plot.getDomainLabelWidget().pack();
        
        // average point label
        avgLabelFormatter.getTextPaint().setTextSize(PixelUtils.dpToPix(size.getSizeDp()));
    }
    
    /**
     * DESCRIPTION:
     * Sets the boundaries for the X and Y-axis based on the data values.
     */
    private void setPlotAxisBoundaries() {

        //set y-axis boundaries
    	long boundy = 1;
    	while (maxy >= boundy) boundy *= 2;
    	plot.setRangeBoundaries(0, (float)boundy, BoundaryMode.FIXED);
    	
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
        	Display display = activity.getWindowManager().getDefaultDisplay();
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

    	// get numbers to plot from gas record monthly data, where (x,y) is:
    	// x = sequential index [0..n] with labels mapped to specific months
    	// y = calculated cost for that month
    	sumy = new TripRecord(new Date());
    	miny = Float.MAX_VALUE; 
    	maxy = Float.MIN_VALUE;
    	minx = Long.MAX_VALUE; 
    	maxx = Long.MIN_VALUE;
    	xlabels.clear();
    	long x = 0L;
    	double y = 0f;
    	for (Month month : PlotActivity.monthly) {
    		TripRecord data = PlotActivity.monthly.getTrips(month);
    		y = data.getPrice();
    		Log.d(tag,"month="+month.toString()+" x="+x+" y="+y);
    		minx = Math.min(minx, x);
    		maxx = Math.max(maxx, x);
    		miny = Math.min(miny, y);
    		maxy = Math.max(maxy, y);
    		xNumbers.add(x);
    		yNumbers.add(y);
    		sumy.append(data);
    		xlabels.put(x++,month.getLabel());
    	}

    	// adjust min/max values if no data
    	if (xNumbers.isEmpty()) minx = maxx = 0;
    	if (yNumbers.isEmpty()) miny = maxy = 0;
    	
    	// calculate average for the series
    	average = sumy.getPrice();

    	Log.d(tag,"minx="+minx+" maxx="+maxx);
    	Log.d(tag,"miny="+miny+" maxy="+maxy);
    	Log.d(tag,"average="+average);

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
		
		if (key.equals(Settings.KEY_UNITS)) {
			
	        // get new units of measurement
	        units = new Units(Settings.KEY_UNITS);
	        
	        // update the plot to reflect new units
	        plot.setRangeLabel(units.getLiquidVolumeLabel());

	        // redraw the plot
			redrawPlot();
		}

	}
	
    /**
     * DESCRIPTION:
     * Sets the height of the plot view.
     * @param height - the height in pixels.
     */
    public void setHeight(int height) {
    	ViewGroup.LayoutParams params = plot.getLayoutParams();
    	params.height = height;
    	plot.setLayoutParams(params);
    	plot.redraw();
    }

}

