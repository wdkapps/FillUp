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

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.List;

import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * DESCRIPTION:
 * Implements an Activity that calculates and displays statistics for 
 * gas record data for a specified vehicle.
 */
public class StatisticsActivity extends Activity implements OnSharedPreferenceChangeListener
{
	/// key name for the Vehicle to pass via Intent
	/// gas records for this vehicle are the data to gather statistics for 
	public final static String VEHICLE = StatisticsActivity.class.getName() + ".VEHICLE";

	/// the vehicle (obtained via Intent)
	private Vehicle vehicle;
	
	/// the data to plot
	public static List<GasRecord> records = null;

	/// the data to display statistics for
	private MonthlyTrips monthly;
	
	/// the Android WebView for display of statistics data
	private WebView webview;
	
	/// buttons for selection of range of data to evaluate
	private PlotDateRangeButtons rangeButtons;
	
	/// the report
	private HtmlData report;
	
    /**
     * DESCRIPTION:
     * Called when the Activity is created.
     * @see android.app.ActivityGroup#onCreate(android.os.Bundle)
     */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_statistics);
		
        // get the vehicle from Intent
        Intent intent = getIntent();
        vehicle = (Vehicle)intent.getSerializableExtra(VEHICLE);
        
        // read the data from the gas log 
        GasLog gaslog = GasLog.getInstance();
        records = gaslog.readAllRecords(vehicle);

        // calculate monthly totals
        monthly = new MonthlyTrips(records);
        
    	// initialize the layout
    	rangeButtons = new PlotDateRangeButtons(this,Settings.KEY_PLOT_DATE_RANGE);
		webview = (WebView)findViewById(R.id.webviewStats);
    	webview.getSettings().setDefaultTextEncodingName("utf-8");
    	webview.setScrollBarStyle(View.SCROLLBARS_INSIDE_OVERLAY);
    	
    	// automatically scroll to top of page when data changes
    	webview.setWebViewClient(new WebViewClient() {
    		public void onPageFinished(WebView view, String url) {
    			view.scrollTo(0,0);
    		}
    	});
    	
        // setup to be notified when settings change (plot range)
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);;
		prefs.registerOnSharedPreferenceChangeListener(this);

		// generate the report
		generateReport();
		
		// display the report
		displayReport();
	}
	
	
	/**
	 * DESCRIPTION:
	 * Generates the statistics report from the monthly data.
	 */
	private void generateReport() {
    	String title = rangeButtons.getPlotDateRange().getSummary();
    	report = new StatisticsReport(title,monthly);
	}
	
	/**
	 * DESCRIPTION:
	 * Display a StatisticsReport for the current monthly data set in the WebView.
	 */
	private void displayReport() {
       	webview.loadDataWithBaseURL(null, report.getHtml(), "text/html", "utf-8", null);
	}

	/**
     * DESCRIPTION:
     * Initialize the contents of the Activity's standard options menu. 
     * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
     */
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_statistics, menu);
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

    	case R.id.itemShare:
    	   	if (ExternalStorage.isWritable()) {
    	   		shareReport();
        	} else {
        		Utilities.toast(this,getString(R.string.toast_external_storage_not_writable));
        	}
    		return true;
    		
    	case R.id.itemSettings:
    		Intent intent = new Intent(this,Settings.class);
    		startActivity(intent);
    		return true;
    		
    	default:
    		return super.onOptionsItemSelected(item);
    	}
    }
    
    /**
     * DESCRIPTION:
     * Return the name and path to a file for storage statistics report data.
     * @return the File.
     */
    protected File getReportFile() {
    	
    	// get path to external storage directory 
    	File dir = ExternalStorage.getPublicDownloadDirectory();
    	
    	// export file is named after vehicle and stored in external storage directory
    	String format = getString(R.string.stats_report_filename);
    	String file = String.format(App.getLocale(),format,vehicle.getName());
    	return new File(dir,file);
    }
    
    /**
     * DESCRIPTION:
     * Creates a statistics report file containing the report html data.
     * @param file - the report File to create.
     * @return boolean - true if file creation successful.
     */
    private boolean createReportFile(File file) {
    	boolean status = false;
    	PrintStream out = null;
    	try {
    		out = new PrintStream(new FileOutputStream(file));
    		out.println(report.getHtml());
    		status = true;
    	} catch(Throwable t) {
    		Log.e(getClass().getName(),"createReportFile() failed",t);
    	} finally {
    		if (out != null) out.close();
    	}
    	return status;
    }
    
    /**
     * DESCRIPTION:
     * Create a file containing statistics report data (HTML) and prompt
     * the user for a method to share the file. 
     */
    private void shareReport() {
    	
    	File file = getReportFile();
	
    	if (!createReportFile(file)) {
    		Utilities.toast(this,getString(R.string.toast_create_report_failed));
    	}

		Utilities.toast(this, file.getAbsolutePath());

		Intent intent = new Intent(Intent.ACTION_SEND);
		intent.setType("text/html");
		intent.putExtra(Intent.EXTRA_STREAM,Uri.fromFile(file));
		intent.putExtra(Intent.EXTRA_SUBJECT,file.getName());
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
		startActivity(Intent.createChooser(intent, getString(R.string.title_chooser_share_html)));
    }

	/**
	 * DESCRIPTION:
	 * Called when a shared preference is changed, added, or removed.
	 * @see android.content.SharedPreferences.OnSharedPreferenceChangeListener#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)
	 */
	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
		
		// update the display when the plot date range changes
		if (key.equals(Settings.KEY_PLOT_DATE_RANGE)) {
			generateReport();
			displayReport();
		} 

		// update the display when units of measurement change
		if (key.equals(Settings.KEY_UNITS)) {
        	GasRecordList.calculateMileage(records);
            monthly = new MonthlyTrips(records);
			generateReport();
			displayReport();
		} 
		
	}
	
}
