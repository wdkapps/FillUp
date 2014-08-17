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

import java.text.SimpleDateFormat;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.content.pm.ApplicationInfo;
import android.os.Bundle;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;
import android.preference.Preference.OnPreferenceClickListener;
import android.util.Log;

/**
 * DESCRIPTION:
 * An Activity to display and modify application settings/preferences. 
 */
public class Settings extends PreferenceActivity implements OnSharedPreferenceChangeListener {
	
	// shared preference keys
	public static final String KEY_UNITS = "units";
	public static final String KEY_PLOT_DATE_RANGE = "plot_date_range";
	public static final String KEY_PLOT_FONT_SIZE = "plot_font_size";
	public static final String KEY_DATA_ENTRY_MODE = "data_entry_mode";
	public static final String KEY_CURRENCY = "currency";
	
	/// tag string for logging
	private static final String TAG = Settings.class.getName(); 

	/**
	 * DESCRIPTION:
	 * Creates the Activity.
	 * @see android.preference.PreferenceActivity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		addPreferencesFromResource(R.xml.preferences);

		String key;
		Preference preference;
		final Activity activity = this;
		
		// populate list of available currencies
		CharSequence[] entries = CurrencyManager.getInstance().getPrefEntries();
		CharSequence[] entryValues = CurrencyManager.getInstance().getPrefEntryValues();
		key = getResources().getString(R.string.pref_key_currency);
		ListPreference lp = (ListPreference)findPreference(key);
		lp.setEntries(entries);
		lp.setEntryValues(entryValues);
		
		// display the package name
		key = getResources().getString(R.string.pref_key_pkg_name);
		preference = (Preference)findPreference(key);
		preference.setSummary(getPackageName());

		// display the package version
		key = getResources().getString(R.string.pref_key_pkg_version);
		preference = (Preference)findPreference(key);
		preference.setSummary(getPackageVersion());
		
		// display the database version
		key = getResources().getString(R.string.pref_key_database_version);
		preference = (Preference)findPreference(key);
		preference.setSummary(getDatabaseVersion());
		
		// display the package build date
		key = getResources().getString(R.string.pref_key_build_date);
		preference = (Preference)findPreference(key);
		preference.setSummary(getBuildDate());
		
		// display the license information when clicked (html)
		key = getResources().getString(R.string.pref_key_license);
		preference = (Preference)findPreference(key);
		preference.setOnPreferenceClickListener(new OnPreferenceClickListener() {
	        public boolean onPreferenceClick(Preference preference) {
	        	Intent intent = new Intent(activity, HtmlViewerActivity.class);
	        	intent.putExtra(HtmlViewerActivity.URL,getString(R.string.url_license_html));
	        	activity.startActivity(intent);
	            return true;
	        }
	    });
		
		// display the help information when clicked (html)
		key = getResources().getString(R.string.pref_key_help);
		preference = (Preference)findPreference(key);
		preference.setOnPreferenceClickListener(new OnPreferenceClickListener() {
			public boolean onPreferenceClick(Preference preference) {
				Intent intent = new Intent(activity, HtmlViewerActivity.class);
				intent.putExtra(HtmlViewerActivity.URL,getString(R.string.url_help_html));
				activity.startActivity(intent);
				return true;
			}
		});
		
		// register for notification of changes
		SharedPreferences sharedPreferences = getPreferenceScreen().getSharedPreferences();
		sharedPreferences.registerOnSharedPreferenceChangeListener(this);
		
		// initialize summary for each shared preference to reflect the selected value
		onSharedPreferenceChanged(sharedPreferences,KEY_UNITS);
		onSharedPreferenceChanged(sharedPreferences,KEY_PLOT_FONT_SIZE);
		onSharedPreferenceChanged(sharedPreferences,KEY_CURRENCY);
	}
	
	/**
	 * DESCRIPTION:
	 * Called when a preference value changes.
	 * @see android.content.SharedPreferences.OnSharedPreferenceChangeListener#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)
	 */
	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPreferences,String key) {
		
		final String tag = TAG + ".onSharedPreferenceChanged()";
		
		// get preference instance for the specified key
		Preference pref = getPreferenceScreen().findPreference(key);
		if (pref == null) {
			Log.e(tag,"findPreference() returned null for key="+key);
			return;
		}

		// update the preference's summary to reflect the current value
		if (key.equals(KEY_UNITS)) {
			Units units = new Units(key);
            pref.setSummary(units.getSummary());
		} else if (key.equals(KEY_PLOT_FONT_SIZE)) {
  			PlotFontSize size = new PlotFontSize(this,key);
            pref.setSummary(size.getSummary());
        } else if (key.equals(KEY_CURRENCY)) {
        	pref.setSummary(CurrencyManager.getInstance().getPrefSummary());
        }
		
	}

	/**
	 * DESCRIPTION:
	 * Returns the version for this application package.
	 * @return the package version String
	 */
	private String getPackageVersion() {
		String value = null;
		try {
			value = getPackageManager().getPackageInfo(getPackageName(), 0).versionName;
		} catch (Throwable t) {
    		Log.e(TAG,"Error obtaining package version",t);
    		value = "error";
		}
		
		return value;
	}
	
    /**
     * DESCRIPTION:
     * Returns the build date for this application package.
     * @return the package build date formatted as a String.
     */
    private String getBuildDate() {

    	String value = null;

    	try{
    		ApplicationInfo ai = getPackageManager().getApplicationInfo(getPackageName(), 0);
    		ZipFile zf = new ZipFile(ai.sourceDir);
    		ZipEntry ze = zf.getEntry("classes.dex");
    		long time = ze.getTime();
    		value = SimpleDateFormat.getDateTimeInstance().format(new java.util.Date(time));
    	}catch(Throwable t){
    		Log.e(TAG,"Error obtaining build date/time",t);
    		value = "error";
    	}

    	return value;
    }
    
    /**
     * DESCRIPTION:
     * Returns the database version for this application (actual and desired).
     * @return the database version formatted as a String.
     */
    private String getDatabaseVersion() {
    	String value = null;
    	try {
    		GasLog gaslog = GasLog.getInstance();
    		int actual = gaslog.getDatabaseVersion();  // reported by sqlite
    		int desired = GasLog.DATABASE_VERSION;
    		value = String.format(App.getLocale(),"%d (%d)",actual,desired);
    	} catch (Throwable t) {
    		Log.e(TAG,"Error obtaining database version",t);
    		value = "error";
    	}
    	return value;
    }
    
    /**
     * DESCRIPTION:
     * Returns flag to indicate whether entering a value for cost
     * is required when editing/creating a gas record.
     * @return boolean - true if cost entry is required.
     */
    public static boolean isCostRequired() {
		Context context = App.getContext();
		String key = context.getString(R.string.pref_key_require_cost);
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	return prefs.getBoolean(key, true);
    }

    /**
     * DESCRIPTION:
     * Returns flag to indicate whether cost value should be
     * displayed in the gas log.
     * @return boolean - true if cost value should be displayed.
     */
    public static boolean isCostDisplayable() {
		Context context = App.getContext();
		String key = context.getString(R.string.pref_key_display_cost);
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	return prefs.getBoolean(key, true);
    }

    /**
     * DESCRIPTION:
     * Returns flag to indicate whether notes value should be
     * displayed in the gas log.
     * @return boolean - true if notes value should be displayed.
     */
    public static boolean isNotesDisplayable() {
		Context context = App.getContext();
		String key = context.getString(R.string.pref_key_display_notes);
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	return prefs.getBoolean(key, true);
    }
    
    /**
     * DESCRIPTION:
     * Retrieve a String value from the preferences.
     * @param key - the name of the preference to retrieve
     * @param defaultValue - vale to return if preference does not exist
     * @return String
     */
    public static String getString(String key, String defaultValue) {
		Context context = App.getContext();
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
    	return prefs.getString(key,defaultValue);
    }
    
    /**
     * DESCRIPTION:
     * Set a String value in the preferences.
     * @param key - the name of the preference to set
     * @param value - the new value for the preference
     */
    public static void setString(String key, String value) {
		Context context = App.getContext();
    	SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
		SharedPreferences.Editor editor = prefs.edit();
		editor.putString(key,value);
		editor.commit();
    }

}
