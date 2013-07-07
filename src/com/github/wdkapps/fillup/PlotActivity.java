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

import android.app.TabActivity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TabHost;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * Implements a group of tabs containing plots for economy, 
 * gasoline purchased, and distance driven statistics.
 */
public class PlotActivity extends TabActivity implements OnSharedPreferenceChangeListener {
	
	/// a tag string for debug logging (the name of this class)
	private static final String TAG = PlotActivity.class.getName();
	
	/// key name for the Vehicle to pass via Intent
	/// gas records for this vehicle are the data that is plotted 
	public final static String VEHICLE = PlotActivity.class.getName() + ".VEHICLE";
	
	/// the data to plot
	public static List<GasRecord> data = null;
	
	/// the data aggregated per month
	public static MonthlyTrips monthly = null;
	
	/// the vehicle to display gas records for (obtained via Intent)
	private Vehicle vehicle;

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
        data = gaslog.readAllRecords(vehicle);
        
        // calculate monthly totals
        monthly = new MonthlyTrips(data);
        
        // sort gas records by date
    	Collections.sort(data,new DateComparator());

        // configure the tabs
        TabHost tabHost = getTabHost();
 
        Units units = new Units(Settings.KEY_UNITS);
        String title = units.getMileageLabel();
        intent = new Intent(this, MileagePlotActivity.class);
        tabHost.addTab(tabHost.newTabSpec("tab0").setIndicator(title).setContent(intent));

    	intent = new Intent(this, OdometerPlotActivity.class);
        title = getString(R.string.title_tab_odometer_plot);
        tabHost.addTab(tabHost.newTabSpec("tab1").setIndicator(title).setContent(intent));
        
    	intent = new Intent(this, GallonsPlotActivity.class);
        title = getString(R.string.title_tab_gallons_plot);
        tabHost.addTab(tabHost.newTabSpec("tab2").setIndicator(title).setContent(intent));

    	intent = new Intent(this, CostPlotActivity.class);
        title = getString(R.string.title_tab_cost_plot);
        tabHost.addTab(tabHost.newTabSpec("tab3").setIndicator(title).setContent(intent));
        
        // enable multi-line tab titles
        for (int n=0; n<getTabWidget().getTabCount(); n++) {
        	TextView textview;
        	textview = (TextView)getTabWidget().getChildAt(n).findViewById(android.R.id.title); 
        	textview.setSingleLine(false);
        }
        
        // select the first tab
        tabHost.setCurrentTab(0); 
        
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
		
		if (key.equals(Settings.KEY_UNITS)) {
			
			// get new units of measurement
	        Units units = new Units(Settings.KEY_UNITS);

	        // change title of the mileage plot tab to reflect new units
        	TextView title;
        	title = (TextView)getTabWidget().getChildAt(0).findViewById(android.R.id.title); 
        	title.setText(units.getMileageLabel());
			
			// update the data to reflect new units
        	GasRecordList.calculateMileage(data);
			
			// get tab activities
			MileagePlotActivity tab0 = null;
			OdometerPlotActivity tab1 = null;
			GallonsPlotActivity tab2 = null;
			CostPlotActivity tab3 = null;
			try {
				tab0 = (MileagePlotActivity)getLocalActivityManager().getActivity("tab0");
				tab1 = (OdometerPlotActivity)getLocalActivityManager().getActivity("tab1");
				tab2 = (GallonsPlotActivity)getLocalActivityManager().getActivity("tab2");
				tab3 = (CostPlotActivity)getLocalActivityManager().getActivity("tab3");
			} catch (Throwable t) {
				// made an attempt, but had a problem for some reason
				// not a big deal - plots will reflect new units after activity exits
				// and is restarted (next time plots are displayed).
				Log.e(TAG+"onSharedPreferenceChanged()","unable to update units for child plots",t);
			}
			
			// notify children that units have changed
			if (tab0 != null) tab0.onUpdateUnits();
			if (tab1 != null) tab1.onUpdateUnits();
			if (tab2 != null) tab2.onUpdateUnits();
			if (tab3 != null) tab3.onUpdateUnits();
		}
		
	}
	
}
