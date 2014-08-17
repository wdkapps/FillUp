/*
 * *****************************************************************************
 * Copyright 2014 William D. Kraemer
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

import android.content.res.Resources;

/**
 * DESCRIPTION:
 * Represents a preference value that specifies the default mode for data
 * entry. Obtains the current preference value from Settings.
 */

public class DataEntryMode implements Serializable {

	private static final long serialVersionUID = 15754214431035874L;
	
	/// preference values represented as integers
	public static final int CALCULATE_PRICE = 0; 
	public static final int CALCULATE_GALLONS = 1; 
	public static final int CALCULATE_COST = 2; 

	/// the Settings key 
	private String key;
	
	/// the currently selected preference value 
	private int value;
	
	/// a summary String describing the current preference value
	private String summary;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of DataEntryMode.
	 * @param key - the name of the preference to retrieve. 
	 */
	public DataEntryMode(String key) {
		
		this.key = key;
		
		// get saved preference value
		String value = Settings.getString(Settings.KEY_DATA_ENTRY_MODE,"0");
		
    	// convert string to integer
		this.value = Integer.parseInt(value);
		
		// summary strings are defined as resource
		Resources resources = App.getContext().getResources();
		String[] entries = resources.getStringArray(R.array.arrayUnitsEntries);
		
		// select appropriate string
		this.summary = entries[this.value];
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the Settings key string.
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the current data entry mode value.
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
	 * Returns true if mode is CALCULATE_PRICE
	 * @return boolean
	 */
	public boolean isCalculatePrice() {
		return (value == CALCULATE_PRICE);
	}

	/**
	 * DESCRIPTION:
	 * Returns true if mode is CALCULATE_COST
	 * @return boolean
	 */
	public boolean isCalculateCost() {
		return (value == CALCULATE_COST);
	}

	/**
	 * DESCRIPTION:
	 * Returns true if mode is CALCULATE_GALLONS
	 * @return boolean
	 */
	public boolean isCalculateGallons() {
		return (value == CALCULATE_GALLONS);
	}

	/**
	 * DESCRIPTION:
	 * Returns a string representing the object.
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "DataEntryMode [value=" + value + ", summary=" + summary + "]";
	}

}
