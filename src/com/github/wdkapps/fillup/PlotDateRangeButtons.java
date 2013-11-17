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

import android.app.Activity;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.ToggleButton;

/**
 * DESCRIPTION:
 * Implements an object to manage a set of compound buttons and select a 
 * date range for plots and statistics based on which button is clicked.
 * The buttons are defined in range_button_bar.xml layout. Plot date range 
 * was initially selected only via Settings/Preferences Activity. The buttons 
 * provide an alternate means of selecting a range without navigating to the
 * Settings menu. The selected range is saved as a SharedPreference. The parent
 * Activity must register for preference changes in order to be notified
 * that a range was selected. 
 */
public class PlotDateRangeButtons implements OnCheckedChangeListener {

	/// the Activity that owns the buttons
	private Activity activity;
	
	/// the Settings key for the PlotDateRange shared preference to manage 
	private String key;
	
	/// the buttons 
	private ToggleButton button1;
	private ToggleButton button6;
	private ToggleButton button12;
	private ToggleButton buttonYTD;
	private ToggleButton buttonAll;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of PlotDateRangeButtons.
	 * @param activity - the Activity that owns the buttons
	 * @param key - the Settings key for the PlotDateRange shared preference to manage 
	 */
	public PlotDateRangeButtons(Activity activity, String key) {
		this.activity = activity;
		this.key = key;
		button1 = (ToggleButton)activity.findViewById(R.id.button1);
		button6 = (ToggleButton)activity.findViewById(R.id.button6);
		button12 = (ToggleButton)activity.findViewById(R.id.button12);
		buttonYTD = (ToggleButton)activity.findViewById(R.id.buttonYTD);
		buttonAll = (ToggleButton)activity.findViewById(R.id.buttonAll);
		button1.setOnCheckedChangeListener(this);
		button6.setOnCheckedChangeListener(this);
		button12.setOnCheckedChangeListener(this);
		buttonYTD.setOnCheckedChangeListener(this);
		buttonAll.setOnCheckedChangeListener(this);
		PlotDateRange range = new PlotDateRange(activity,key);
		setChecked(range);
		
		// change YTD label to current year (better for localization)
		Date now = new Date();
		String label = Integer.toString(now.getYear() + 1900);
		buttonYTD.setText(label);
		buttonYTD.setTextOn(label);
		buttonYTD.setTextOff(label);
	}
	
	/**
	 * DESCRIPTION:
	 * Update the state of the buttons to reflect a specified 
	 * PlotDateRange value.
	 * @param range - the PlotDateRange value.
	 */
	private void setChecked(PlotDateRange range) {
		int value = range.getValue();
		button1.setChecked(value == PlotDateRange.PAST_MONTH);
		button6.setChecked(value == PlotDateRange.PAST_6_MONTHS);
		button12.setChecked(value == PlotDateRange.PAST_12_MONTHS);
		buttonYTD.setChecked(value == PlotDateRange.YEAR_TO_DATE);
		buttonAll.setChecked(value == PlotDateRange.ALL);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the button that is currently checked (should only be one).
	 * @return the ToggleButton that is currently checked
	 */
	private CompoundButton getChecked() {
		if (button1.isChecked()) return button1;
		if (button6.isChecked()) return button6;
		if (button12.isChecked()) return button12;
		if (buttonYTD.isChecked()) return buttonYTD;
		if (buttonAll.isChecked()) return buttonAll;
		return null;
	}
	
	/**
	 * DESCRIPTION:
	 * Removes check for all buttons except the specified button.
	 * @param button - the currently selected button.
	 */
	private void uncheckOtherButtons(CompoundButton button) {
		int id = button.getId();
		if (id != R.id.button1) button1.setChecked(false);
		if (id != R.id.button6) button6.setChecked(false);
		if (id != R.id.button12) button12.setChecked(false);
		if (id != R.id.buttonYTD) buttonYTD.setChecked(false);
		if (id != R.id.buttonAll) buttonAll.setChecked(false);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the PlotDateRange integer value for a specified button
	 * @param button - the button
	 * @return PlotDateRange integer value.
	 */
	private Integer getRangeValueForButton(CompoundButton button) {
		switch(button.getId()) {
		case R.id.button1: return PlotDateRange.PAST_MONTH;
		case R.id.button6: return PlotDateRange.PAST_6_MONTHS;
		case R.id.button12: return PlotDateRange.PAST_12_MONTHS; 
		case R.id.buttonYTD: return PlotDateRange.YEAR_TO_DATE; 
		case R.id.buttonAll: return PlotDateRange.ALL; 
		}
		return null;
	}
	
	/**
	 * DESCRIPTION:
	 * Called when the checked state of one of the buttons has changed.
	 * @see android.widget.CompoundButton.OnCheckedChangeListener#onCheckedChanged(android.widget.CompoundButton, boolean)
	 */
	@Override
	public void onCheckedChanged(CompoundButton button, boolean isChecked) {
		
        if(isChecked) {
        	
        	// un-check the other buttons
            uncheckOtherButtons(button);

            // get range value for the checked button
            Integer value = getRangeValueForButton(button);
            
    		// save the value in shared preferences
            if (value != null) {
            	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(activity);
            	SharedPreferences.Editor editor = prefs.edit();
            	editor.putString(key,value.toString());
            	editor.commit();
            }

        } else if (getChecked() == null){
        	// cannot uncheck a button that is currently checked
            button.setChecked(true);
        }
		
	}
	
	/**
	 * DESCRIPTION:
	 * Convenience method to get current plot date range.
	 * @return the current PlotDateRange.
	 */
	public PlotDateRange getPlotDateRange() {
		return new PlotDateRange(activity,key);
	}

}
