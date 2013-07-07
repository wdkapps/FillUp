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

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;

/**
 * DESCRIPTION:
 * Represents a preference value that specifies the size of font to use for 
 * for plotting. 
 */
public class PlotFontSize {
	
	/// preference values represented as integers
	public static final int SMALL = 0; 
	public static final int MEDIUM = 1; 
	public static final int LARGE = 2; 
	public static final int XLARGE = 3; 

	/// context for obtaining resources, etc
	private final Context context;	
	
	/// the currently selected preference value 
	private final int value;

	public PlotFontSize(Context context, String key) {

		// save context for future use
		this.context = context;
    	
		// get saved preference value
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	String value = prefs.getString(key, "0");
    	
    	// convert string to integer
		this.value = Integer.parseInt(value);
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
	 * Returns the font size in dp corresponding to the current
	 * font size "enumeration" value.
	 * @return flat - the font size in dp.
	 */
	public float getSizeDp() {
		float size = 0;
		switch (value) {
		case SMALL: size = 10; break;
		case MEDIUM: size = 12; break;
		case LARGE: size = 14; break;
		case XLARGE: size = 16; break;
		default:
			throw new RuntimeException("Invalid PlotFontSize value.");
		}
		return size;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns a summary String describing the current preference value. 
	 * The strings are defined as resources.
	 * @return a summary String for the current preference value.
	 */
	public String getSummary() {
		Resources resources = context.getResources();
		String[] entries = resources.getStringArray(R.array.arrayPlotFontSizeEntries);
		return entries[value];
	}


}
