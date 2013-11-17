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

import java.util.Collections;
import java.util.List;

import com.androidplot.xy.XYPlot;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.ViewTreeObserver;
import android.view.ViewTreeObserver.OnGlobalLayoutListener;
import android.widget.ScrollView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * Implements a group of tabs containing plots for economy, 
 * gasoline purchased, and distance driven statistics.
 */
public class PlotActivity extends Activity implements OnSharedPreferenceChangeListener {
	
	/// a tag string for debug logging (the name of this class)
	@SuppressWarnings("unused")
	private static final String TAG = PlotActivity.class.getName();
	
	/// key name for the Vehicle to pass via Intent
	/// gas records for this vehicle are the data that is plotted 
	public final static String VEHICLE = PlotActivity.class.getName() + ".VEHICLE";
	
	/// the data to plot
	public static List<GasRecord> records = null;
	
	/// the data aggregated per month
	public static MonthlyTrips monthly = null;
	
	/// the vehicle to display gas records for (obtained via Intent)
	private Vehicle vehicle;
	
    /// the plots
    private MileagePlot plotMileage = new MileagePlot();
    private OdometerPlot plotOdometer = new OdometerPlot();
    private GallonsPlot plotGallons = new GallonsPlot();
    private CostPlot plotCost = new CostPlot();
    private PricePlot plotPrice = new PricePlot();
    
	/// buttons for selection of range of data to evaluate
	@SuppressWarnings("unused")
	private PlotDateRangeButtons rangeButtons;
	
	private ScrollView scrollview;

    /**
     * DESCRIPTION:
     * Called when the Activity is created.
     * @see android.app.ActivityGroup#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plot);
        
        // get the vehicle from Intent
        Intent intent = getIntent();
        vehicle = (Vehicle)intent.getSerializableExtra(VEHICLE);
        
        // read the data from the gas log 
        GasLog gaslog = GasLog.getInstance();
        records = gaslog.readAllRecords(vehicle);
        
        // calculate monthly totals
        monthly = new MonthlyTrips(records);
        
        // sort gas records by date
    	Collections.sort(records,new DateComparator());

    	// initialize the plot range buttons
    	rangeButtons = new PlotDateRangeButtons(this,Settings.KEY_PLOT_DATE_RANGE);
    	
        // create plots
    	plotMileage.onCreate(savedInstanceState,this,(XYPlot)findViewById(R.id.xyMileagePlot));
    	plotOdometer.onCreate(savedInstanceState,this,(XYPlot)findViewById(R.id.xyOdometerPlot));
    	plotGallons.onCreate(savedInstanceState,this,(XYPlot)findViewById(R.id.xyGallonsPlot));
    	plotCost.onCreate(savedInstanceState,this,(XYPlot)findViewById(R.id.xyCostPlot));
    	plotPrice.onCreate(savedInstanceState,this,(XYPlot)findViewById(R.id.xyPricePlot));

		// set font size for plot titles to reflect preferences
		setTitlesFontSize();
    	
		// setup to adjust plot height to fit on screen once layout size is known
		scrollview = (ScrollView)findViewById(R.id.scrollviewPlots);
		ViewTreeObserver vto = scrollview.getViewTreeObserver();
		vto.addOnGlobalLayoutListener(new OnGlobalLayoutListener() {
	        @Override
	        public void onGlobalLayout() {
	        	int height = (scrollview.getHeight() * 85) / 100;
	        	plotMileage.setHeight(height);
	        	plotOdometer.setHeight(height);
	        	plotGallons.setHeight(height);
	        	plotCost.setHeight(height);
	        	plotPrice.setHeight(height);
	        	// remove this listener or it will repeatedly run
	        	ViewTreeObserver vto = scrollview.getViewTreeObserver();
	        	if (vto.isAlive()) {
	        		vto.removeGlobalOnLayoutListener (this);
	        	}
	        }
	    });
		
        // setup to be notified when shared preferences change
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);;
		prefs.registerOnSharedPreferenceChangeListener(this);

    }

	/**
     * DESCRIPTION:
     * Initialize the contents of the Activity's standard options menu. 
     * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_plot, menu);
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Called when an item in the options menu is selected.
     * @see android.app.Activity#onOptionsItemSelected(android.view.MenuItem)
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

    	switch (item.getItemId()) {
    	
    	case R.id.itemSettings:
    		Intent intent = new Intent(this,Settings.class);
    		startActivity(intent);
    		return true;

    	default:
    		return super.onContextItemSelected(item);
    	}

    }
    
	/**
	 * DESCRIPTION:
	 * Called when one or more shared preferences have changed.
	 * @see android.content.SharedPreferences.OnSharedPreferenceChangeListener#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)
	 */
	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
		
		// update the data to reflect new units
		if (key.equals(Settings.KEY_UNITS)) {
        	GasRecordList.calculateMileage(records);
            monthly = new MonthlyTrips(records);
		}
		
		// update title font size
		if (key.equals(Settings.KEY_PLOT_FONT_SIZE)) {
        	setTitlesFontSize();
		}
		
		// notify plots that preferences have changed
		plotMileage.onSharedPreferenceChanged(sharedPreferences,key);
		plotOdometer.onSharedPreferenceChanged(sharedPreferences,key);
		plotGallons.onSharedPreferenceChanged(sharedPreferences,key);
		plotCost.onSharedPreferenceChanged(sharedPreferences,key);
		plotPrice.onSharedPreferenceChanged(sharedPreferences,key);
		
	}
	
    /**
     * DESCRIPTION:
     * Adjust font size used for plot title labels to reflect shared
     * preferences.
     */
    private void setTitlesFontSize() {
    	PlotFontSize size = new PlotFontSize(this,Settings.KEY_PLOT_FONT_SIZE);
    	float sizeTitle = size.getSizeDp() + 2.0f;
    	TextView title;
    	title = (TextView)findViewById(R.id.titleMileagePlot);
    	title.setTextSize(sizeTitle);
    	title = (TextView)findViewById(R.id.titleOdometerPlot);
    	title.setTextSize(sizeTitle);
    	title = (TextView)findViewById(R.id.titleGallonsPlot);
    	title.setTextSize(sizeTitle);
    	title = (TextView)findViewById(R.id.titleCostPlot);
    	title.setTextSize(sizeTitle);
    	title = (TextView)findViewById(R.id.titlePricePlot);
    	title.setTextSize(sizeTitle);
    }

}
