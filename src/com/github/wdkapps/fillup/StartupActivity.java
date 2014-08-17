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

import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

/**
 * DESCRIPTION:
 * An Activity that performs startup checks and initialization for
 * the application, then launches the main Activity.
 */
public class StartupActivity extends Activity implements UnitsDialog.Listener {
	
	protected final static String TAG = StartupActivity.class.getSimpleName();
	
    /**
     * DESCRIPTION
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_startup);
		
		// currency manager initialization can be time consuming...get it out of the way at startup
		CurrencyManager.getInstance();
		
		// special case: display update information
		if (isUpdateFirstStart()) {
			showUpdateInformation();
			return;
		}

		// special case: prompt user to select units of measurement
		if (isInstallFirstStart()) {
	       	showDialog(DIALOG_SELECT_UNITS_ID);
			return;
		}

		// normal startup - start the application's main activity
		startMainActivity();
    }   
	
	/**
	 * DESCRIPTION:
	 * Starts the main Activity and exits this startup activity.
	 */
	protected void startMainActivity() {
        Intent intent = new Intent(this,MainActivity.class);
        startActivity(intent);
        finish();
	}

	/**
	 * DESCRIPTION:
	 * Determines if this is the first time starting after a 
	 * clean application install (no data exists yet).
	 * @return true if this is first startup after a clean install.
	 */
	protected boolean isInstallFirstStart() {
		return !GasLog.exists();
	}

	/**
	 * DESCRIPTION:
	 * Determines if this is the first time starting after an application
	 * update.
	 * @return true if first startup after an application update.
	 */
	protected boolean isUpdateFirstStart() {
		
		final String KEY = StartupActivity.class.getName() + ".savedVersionCode";  
		SharedPreferences prefs = getPreferences(Context.MODE_PRIVATE);
		
		// get the saved version code
		int savedVersionCode = prefs.getInt(KEY,0);
		
		// get the current version code for this application
		int appVersionCode = App.getVersionCode(); 

    	// save the current version code so we only do this once per version
		SharedPreferences.Editor editor = prefs.edit();
		editor.putInt(KEY,appVersionCode);
		editor.commit();

		// if the database does not exist yet, then this is not an update
		if (!GasLog.exists()) {
			return false;
		}
		
		// decide whether to display update info based on the saved version
		if (savedVersionCode >= 7) {
			return false;
		} 

		// yes, this is first startup for this version of the app
		return true;
	}
	
	/**
	 * DESCRIPTION:
	 * Displays information to the user describing what has changed 
	 * for the current software update, if the update.html exists.
	 */
	protected void showUpdateInformation() {
		
		// if update.html does not exist, skip display and start main activity
		if (!App.existsUpdateHtml()) {
			String tag = TAG + ".showUpdateInformation()";
			String msg = "UPDATE HTML FILE DOES NOT EXIST";
			Log.d(tag,msg);
			startMainActivity();
			return;
		}
		
		// start an activity to display the update information 
		// and await a result from the activity
		Intent intent = new Intent(this, HtmlViewerActivity.class);
    	intent.putExtra(HtmlViewerActivity.URL,getString(R.string.url_update_html));
    	intent.putExtra(HtmlViewerActivity.RETURN_RESULT, true);
    	startActivityForResult(intent,SHOW_UPDATE_INFO);
	}
	
	/**
	 * DESCRIPTION:
	 * Request code constants for onActivityResult()
	 * @see #onActivityResult(int, int, Intent)
	 */
	protected static final int SHOW_UPDATE_INFO = 1;
	
    /**
     * DESCRIPTION:
     * Called when an activity launched by this activity exits, giving the 
     * requestCode it was started with, the resultCode it returned, and any 
     * additional data from it.
     * 
     * @see android.app.Activity#onActivityResult(int, int, android.content.Intent)
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);  

        switch(requestCode) {     
        case SHOW_UPDATE_INFO: 
        	startMainActivity();
        	break;

        default:
        	Utilities.toast(this,"Invalid request code.");
        	startMainActivity();
        }
    }

	/**
	 * DESCRIPTION:
	 * Exits this Activity with launching the main Activity.
	 */
	protected void exitApplication() {
		finish();
	}
	
    /**
     * DESCRIPTION:
     * Dialog box integer ID constants
     * @see #onCreateDialog(int)
     */
    protected static final int DIALOG_SELECT_UNITS_ID = 1;

    /**
     * DESCRIPTION:
     * Called as needed by the framework to create dialog boxes used by the Activity.
     * Each dialog box is referenced by a locally defined id integer. 
     * @see android.app.Activity#onCreateDialog(int)
     */
    @Override
    protected Dialog onCreateDialog(int id) {
    	
        Dialog dialog = null;
        switch (id) {
        case DIALOG_SELECT_UNITS_ID:
        	dialog = UnitsDialog.create(this,this,id);
        	break;
            
        default:
        	Utilities.toast(this,"Invalid dialog id.");
    	}
    	return dialog;
    }
    
	/**
 	 * DESCRIPTION:
	 * Save current state data.
	 * NOTE: This gets called when the screen is rotated. The
	 * Activity is then destroyed, re-created, and state restored.
	 * @see android.app.Activity#onSaveInstanceState(android.os.Bundle)
	 */
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);

		// TODO fix this?
		// NOTE: removing dialog here avoids "window leaked" exception
		// if dialog cancelled after screen rotation
		removeDialog(DIALOG_SELECT_UNITS_ID);
	}

	/**
	 * DECSRIPTION:
	 * Called when a user response has been obtained from the dialog.
	 * @see com.github.wdkapps.fillup.UnitsDialog.Listener#onUnitsDialogResponse(int, String)
	 */
	@Override
	public void onUnitsDialogResponse(int id, UnitsDialog.Result result, String value) {

		removeDialog(id);
		
		switch(result) {
		case RESULT_SELECTED:
			
			// save the selected units of measurement as a shared preference
			SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
			SharedPreferences.Editor editor = prefs.edit();
			editor.putString(Settings.KEY_UNITS,value);
			editor.commit();

			// done
			startMainActivity();
			break;

		case RESULT_CANCEL:
			exitApplication();
			break;
		}
	}
}
