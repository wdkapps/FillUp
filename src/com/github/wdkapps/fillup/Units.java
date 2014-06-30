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

import java.io.Serializable;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;

/**
 * DESCRIPTION:
 * Represents a preference value that specifies the units of measurement to use 
 * for mileage calculation. Provides the ability to obtain the current preference 
 * value and obtain label strings that reflect the setting (ie. "mpg", "gallons", 
 * "miles", etc). Needs to be Serializable in order to pass between Activity 
 * instances via an Intent instance (as part of a MileageCalculation instance).
 */
public class Units implements Serializable {

	/// required to enable serialization
	private static final long serialVersionUID = 1L;
	
	/// preference values represented as integers
	public static final int MILES_PER_GALLON = 0; 
	public static final int KILOMETERS_PER_LITER = 1; 
	public static final int LITERS_PER_100_KILOMETERS = 2; 
	public static final int UK_MPG_MILES_LITERS = 3;
	public static final int UK_MPG_KILOMETERS_LITERS = 4;
	public static final int KILOMETERS_PER_GALLON = 5;

	/// the currently selected preference value 
	private final int value;
	
	/// a summary String describing the current preference value
	private final String summary;

	/**
	 * DESCRIPTION:
	 * Constructs an instance of PlotDateRange.
	 * @param key - the name of the preference to retrieve. 
	 */
	public Units(String key) {
		
		// get saved preference value
		Context context = App.getContext();
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	String value = prefs.getString(key, "0");
    	
    	// convert string to integer
		this.value = Integer.parseInt(value);
		
		// summary strings are defines as resource
		Resources resources = context.getResources();
		String[] entries = resources.getStringArray(R.array.arrayUnitsEntries);
		
		// select appropriate string
		this.summary = entries[this.value];
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
	 * @return a summary String for the current preference value.
	 */
	public String getSummary() {
		return this.summary;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the liquid volume label appropriate for the currently
	 * selected Units preference value. 
	 * @return label String.
	 */
	public String getLiquidVolumeLabel() {
		int id = R.string.error_label;
		switch(value) {
		case MILES_PER_GALLON: id = R.string.gallons_label; break;
		case KILOMETERS_PER_LITER: id = R.string.liters_label; break;
		case LITERS_PER_100_KILOMETERS: id = R.string.liters_label; break;
		case UK_MPG_MILES_LITERS: id = R.string.liters_label; break;
		case UK_MPG_KILOMETERS_LITERS: id = R.string.liters_label; break;
		case KILOMETERS_PER_GALLON: id = R.string.gallons_label;
		}
		return App.getContext().getResources().getString(id);
	}

	/**
	 * DESCRIPTION:
	 * Returns the liquid volume label appropriate for the currently
	 * selected Units preference value in lower case. 
	 * @return label String.
	 */
	public String getLiquidVolumeLabelLowerCase() {
		return getLiquidVolumeLabel().toLowerCase(App.getLocale());
	}

	/**
	 * DESCRIPTION:
	 * Returns the liquid volume ratio label appropriate for the currently
	 * selected Units preference value (example: "per gallon"). 
	 * @return label String.
	 */
	public String getLiquidVolumeRatioLabel() {
		int id = R.string.error_label;
		switch(value) {
		case MILES_PER_GALLON: id = R.string.per_gallon_label; break;
		case KILOMETERS_PER_LITER: id = R.string.per_liter_label; break;
		case LITERS_PER_100_KILOMETERS: id = R.string.per_liter_label; break;
		case UK_MPG_MILES_LITERS: id = R.string.per_liter_label; break;
		case UK_MPG_KILOMETERS_LITERS: id = R.string.per_liter_label; break;
		case KILOMETERS_PER_GALLON: id = R.string.per_gallon_label;
		}
		return App.getContext().getResources().getString(id);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the distance ratio label appropriate for the currently
	 * selected Units preference value (example: "per mile"). 
	 * @return label String.
	 */
	public String getDistanceRatioLabel() {
		int id = R.string.error_label;
		switch(value) {
		case MILES_PER_GALLON: id = R.string.per_mile_label; break;
		case KILOMETERS_PER_LITER: id = R.string.per_kilometer_label; break;
		case LITERS_PER_100_KILOMETERS: id = R.string.per_kilometer_label; break;
		case UK_MPG_MILES_LITERS: id = R.string.per_mile_label; break;
		case UK_MPG_KILOMETERS_LITERS: id = R.string.per_kilometer_label; break;
		case KILOMETERS_PER_GALLON: id = R.string.per_kilometer_label;
		}
		return App.getContext().getResources().getString(id);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the distance label appropriate for the currently
	 * selected Units preference value. 
	 * @return label String.
	 */
	public String getDistanceLabel() {
		int id = R.string.error_label;
		switch(value) {
		case MILES_PER_GALLON: id = R.string.miles_label; break;
		case KILOMETERS_PER_LITER: id = R.string.kilometers_label; break;
		case LITERS_PER_100_KILOMETERS: id = R.string.kilometers_label; break;
		case UK_MPG_MILES_LITERS: id = R.string.miles_label; break;
		case UK_MPG_KILOMETERS_LITERS: id = R.string.kilometers_label; break;
		case KILOMETERS_PER_GALLON: id = R.string.kilometers_label;
		} 
		return App.getContext().getResources().getString(id);
	}

	/**
	 * DESCRIPTION:
	 * Returns the distance label appropriate for the currently
	 * selected Units preference value in lower case. 
	 * @return label String.
	 */
	public String getDistanceLabelLowerCase() {
		return getDistanceLabel().toLowerCase(App.getLocale());
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the label appropriate for the currently selected 
	 * Units preference value. 
	 * @return label String.
	 */
	public String getMileageLabel() {
		int id = R.string.error_label;
		switch(value) {
		case MILES_PER_GALLON: id = R.string.mpg_label; break;
		case KILOMETERS_PER_LITER: id = R.string.km_per_liter_label; break;
		case LITERS_PER_100_KILOMETERS: id = R.string.liters_per_100km_label; break;
		case UK_MPG_MILES_LITERS: id = R.string.mpg_label; break;
		case UK_MPG_KILOMETERS_LITERS: id = R.string.mpg_label; break;
		case KILOMETERS_PER_GALLON: id = R.string.kpg_label;
		}
		return App.getContext().getResources().getString(id);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the average size of vehicle fuel tank in the
	 * currently selected units of measurement.
	 * @return float tank size (gallons or liters)
	 */
	public float getAverageTankSize() {
		float tanksize = 0f;
		switch(value) {
		case MILES_PER_GALLON: 
		case KILOMETERS_PER_GALLON:
			tanksize = 16.0f; // gallons 
			break; 
		case KILOMETERS_PER_LITER: 
		case LITERS_PER_100_KILOMETERS: 
		case UK_MPG_MILES_LITERS:	
		case UK_MPG_KILOMETERS_LITERS:	
			tanksize = 60.0f; // liters
			break;
		}
		return tanksize;
	}
}
