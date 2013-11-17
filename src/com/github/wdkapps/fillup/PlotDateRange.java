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

import java.util.Calendar;
import java.util.Date;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;

/**
 * DESCRIPTION:
 * Represents a preference value that specifies a range of dates to plot.
 * Provides the ability to obtain the current preference value and test whether a 
 * specified Java Date instance falls within the range of dates.
 */
public class PlotDateRange {
	
	/// preference values represented as integers
	public static final int PAST_MONTH = 0; 
	public static final int PAST_6_MONTHS = 1; 
	public static final int PAST_12_MONTHS = 2; 
	public static final int YEAR_TO_DATE = 3; 
	public static final int ALL = 4;
	
	/// context for obtaining resources, etc
	private final Context context;	
	
	/// the currently selected preference value 
	private final int value;
	
	/// start and end dates for the range 
	private Date startDate;
	private Date endDate;

	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of PlotDateRange.
	 * @param context - the context of the preferences whose values are wanted.
	 * @param key - the name of the preference to retrieve. 
	 */
	public PlotDateRange(Context context, String key) {
		
		// save context for future use
		this.context = context;
    	
		// get saved preference value
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	String value = prefs.getString(key, "0");
    	
    	// convert string to integer
		this.value = Integer.parseInt(value);
		
		// determine start dates for specified range 
		Calendar startCalendar = Calendar.getInstance();
		startCalendar.set(Calendar.DAY_OF_MONTH,1);
		startCalendar.set(Calendar.HOUR_OF_DAY,0);
		startCalendar.set(Calendar.MINUTE,0);
		startCalendar.set(Calendar.SECOND,0);
		switch (this.value){
		case ALL:
			// force maximum range to 2 years or plot gets ugly (too much data)
			startCalendar.add(Calendar.MONTH, -23);
			break;
		case PAST_MONTH:
			break;
		case PAST_6_MONTHS:
			startCalendar.add(Calendar.MONTH, -5);
			break;
		case PAST_12_MONTHS:
			startCalendar.add(Calendar.MONTH, -11);
			break;
		case YEAR_TO_DATE:
			startCalendar.set(Calendar.MONTH, Calendar.JANUARY);
			startCalendar.set(Calendar.DAY_OF_MONTH, 1);
			startCalendar.set(Calendar.HOUR_OF_DAY,0);
			startCalendar.set(Calendar.MINUTE,0);
			break;
		default:
			throw new RuntimeException("Invalid PlotDateRange integer value");
		}
		
		// end date is midnight the first day of the next month
		Calendar endCalendar = Calendar.getInstance();
		endCalendar.set(Calendar.DAY_OF_MONTH,1);
		endCalendar.set(Calendar.HOUR_OF_DAY,0);
		endCalendar.set(Calendar.MINUTE,0);
		endCalendar.set(Calendar.SECOND,0);
		endCalendar.add(Calendar.MONTH,1);		
		
		// get Dates from Calendars
		startDate = startCalendar.getTime();
		endDate = endCalendar.getTime();
	}

	/**
	 * DESCRIPTION:
	 * Returns the preference value as an integer.
	 * @return the int value.
	 * 
	 * NOTE: The value is retrieved from shared preferences ONLY when 
	 *       the instance is constructed.
	 */
	public int getValue() {
		return this.value;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns a summary String describing the current preference value. 
	 * The strings are defined as resources.
	 * @return a summary String for the current preference value.
	 */
	public String getSummary() {
		Resources resources = context.getResources();
		String[] entries = resources.getStringArray(R.array.arrayPlotDateRangeEntries);
		return entries[value];
	}
	
	/**
	 * DESCRIPTION:
	 * Getter method for start of date range.
	 * @return the starting Date for the current range.
	 */
	public Date getStartDate() {
		return new Date(this.startDate.getTime());
	}

	/**
	 * DESCRIPTION:
	 * Getter method for end of date range.
	 * @return the ending Date for the current range.
	 */
	public Date getEndDate() {
		return new Date(this.endDate.getTime());
	}
	
	/**
	 * DESCRIPTION:
	 * Determines if a specified date falls within the current plot date range.
	 * @param date - the Date to test.
	 * @return true if specified date is within range, false otherwise. 
	 */
	public boolean contains(Date date) {
		
		//if (this.value == ALL) {
		//	return true;
		//}
		
		return !(date.before(startDate) || date.after(endDate));
	}
	
}
