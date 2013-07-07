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

import java.util.Date;

import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.Menu;
import android.view.View;
import android.widget.DatePicker;
import android.widget.TimePicker;
import android.app.Activity;
import android.content.Intent;

/**
 * DESCRIPTION:
 * Implements an Android Activity class to display a date/time value and 
 * allow the user to modify it. The date/time value is passed in/out
 * of the Activity via the Android Intent mechanism.
 */
public class DateTimeActivity extends Activity {
	
	/// key name for the date/time as a milliseconds value to pass via Intent
	public final static String MILLISECONDS = DateTimeActivity.class.getName() + ".MILLISECONDS";
	
	/// get device settings for 24 hour clock mode
	/// NOTE: static because it seemed to cause performance hit when called in onCreate() 
	private final static boolean is24HourView = DateFormat.is24HourFormat(App.getContext());
	
	/// the Activity's widgets (Views)
	private DatePicker datePicker;
	private TimePicker timePicker;
	
	/// the date/time as a millisecond value 
	/// (the number of milliseconds since 1/1/1970, midnight GMT)
	private long milliseconds;
	
    /**
     * DECRIPTION:
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_date_time);   
        
        // get view instances
        datePicker = (DatePicker)findViewById(R.id.datePicker);
        timePicker = (TimePicker)findViewById(R.id.timePicker);
        
        // get parameters from intent
        Intent intent = getIntent();
        milliseconds = (long)intent.getLongExtra(MILLISECONDS,0);
        
        // display initial values
        setData();
    }

    /**
     * DESCRIPTION:
     * Initialize the Activity's standard options menu.
     * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        //getMenuInflater().inflate(R.menu.activity_gas_record, menu);
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Set the widget values based on the initial data values 
     * obtained via Activity Intent.
     */
    protected void setData() {
    	Date date = new Date(milliseconds);
    	int month = date.getMonth();
    	int day = date.getDate();
    	int year = date.getYear() + 1900;
    	int hour = date.getHours();
    	int minute = date.getMinutes();
    	datePicker.init(year,month,day,null);
    	timePicker.setIs24HourView(is24HourView);
    	timePicker.setCurrentHour(hour);
    	timePicker.setCurrentMinute(minute);
     }

    /**
     * DESCRIPTION:
     * Get the current data values from the widgets after user edit,
     * validate them, and return results.
     * 
     * @return boolean - indicates if edited data is valid (valid=true)
     */
    protected boolean getData() {
    	int month = datePicker.getMonth();
    	int day = datePicker.getDayOfMonth();
    	int year = datePicker.getYear() - 1900;
    	int hour = timePicker.getCurrentHour();
    	int minute = timePicker.getCurrentMinute();
    	Date date = new Date(year,month,day,hour,minute);
    	milliseconds = date.getTime();
    	return true;
    }

    /**
     * DESCRIPTION:
     * Called when the CANCEL button has been clicked.
     * @param view
     */
    public void clickedCancel(View view) {
    	returnResult(Activity.RESULT_CANCELED);
    }
    
    /**
     * DESCRIPTION:
     * Called when the OK button has been clicked (user is done editing data).
     * @param view
     */
    public void clickedOk(View view) {
    	
    	// validate the data set
    	if (!getData()) return;
    	
    	// success
  		returnResult(Activity.RESULT_OK);
    }
    
    /**
     * DESCRIPTION:
     * Returns results the caller and closes this Activity.
     * @param resultCode - the integer result code to return to caller.
     */
    protected void returnResult(int resultCode) {

    	Intent intent = new Intent();
    	
    	// if successful edit, return edited gas record data to caller 
    	if (resultCode == Activity.RESULT_OK) {
    		intent.putExtra(MILLISECONDS, milliseconds);
    	}
    	
    	setResult(resultCode, intent); 
    	finish(); 
    }
    
}
