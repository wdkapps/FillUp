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
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * Implements an Android Activity class to display one GasRecord and 
 * allow the user to enter/edit values. The record is passed in/out
 * of the Activity via the Android Intent mechanism.
 */
public class GasRecordActivity extends Activity implements ConfirmationDialog.Listener, View.OnFocusChangeListener {
	
	/// key name for the GasRecord to pass via Intent
	public final static String RECORD = GasRecordActivity.class.getName() + ".RECORD";
	
	/// key name for the current odometer value to pass via Intent
	public final static String CURRENT_ODOMETER = GasRecordActivity.class.getName() + ".CURRENT_ODOMETER";
	
	/// key name for the vehicle tank size value to pass via Intent
	public final static String TANK_SIZE = GasRecordActivity.class.getName() + ".TANK_SIZE";
	
	/// the GasRecord being edited 
	private GasRecord record;
	
	/// the current odometer value for vehicle pertaining to the gas record
	private int current_odometer;
	
	/// the tank size for vehicle pertaining to the gas record
	private float tank_size;
	
	/// the Activity's widgets (Views)
	private EditText editTextDate;
	private EditText editTextOdometer;
	private EditText editTextCost;
	private EditText editTextGallons;
	private CheckBox checkBoxFullTank;
	private EditText editTextNotes;
	
    /**
     * DECRIPTION:
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gas_record);   

        // get view instances
        editTextDate = (EditText)findViewById(R.id.editTextDate);
        editTextOdometer = (EditText)findViewById(R.id.editTextOdometer);
        editTextCost = (EditText)findViewById(R.id.editTextCost);
        editTextGallons = (EditText)findViewById(R.id.editTextGallons);
        checkBoxFullTank = (CheckBox)findViewById(R.id.checkBoxFullTank);
        editTextNotes = (EditText)findViewById(R.id.editTextNotes);
        
        // update labels to reflect current units
        Units units = new Units(Settings.KEY_UNITS);
        TextView label = (TextView)findViewById(R.id.textViewOdometer);
        String format = getString(R.string.odometer_units_label);
        label.setText(String.format(App.getLocale(),format,units.getDistanceLabelLowerCase()));
        label = (TextView)findViewById(R.id.textViewGallons);
        format = getString(R.string.gasoline_label);
        label.setText(String.format(App.getLocale(),format,units.getLiquidVolumeLabelLowerCase()));
        label = (TextView)findViewById(R.id.textViewCost);
        format = getString(R.string.total_cost_label);
        label.setText(String.format(App.getLocale(),format,Utilities.getCurrencySymbol()));

        // update hints to reflect current units
        editTextGallons.setHint(units.getLiquidVolumeLabelLowerCase());
        
        // disallow newline in notes field
        editTextNotes.addTextChangedListener(new TextWatcher() {
            public void onTextChanged(CharSequence s, int start, int before, int count) {}
            public void beforeTextChanged(CharSequence s, int start, int count,int after) {}
            public void afterTextChanged(Editable s) {
                for(int i = s.length(); i > 0; i--){
                    if(s.subSequence(i-1, i).toString().equals("\n"))
                         s.replace(i-1, i, "");
                }
            }
        });
        
        // listen for changes to text values (so we can re-display as formatted values)
        editTextOdometer.setOnFocusChangeListener(this);
        editTextCost.setOnFocusChangeListener(this);
        editTextGallons.setOnFocusChangeListener(this);
        
        // get parameters from intent
        Intent intent = getIntent();
        record = (GasRecord)intent.getSerializableExtra(RECORD);
        current_odometer = intent.getIntExtra(CURRENT_ODOMETER, -1);
        tank_size = intent.getFloatExtra(TANK_SIZE, 99999999f);
        
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
     * Sets the text displayed in the odometer EditText to 
     * reflect the gas record value.
     */
    private void setOdometerText() {
        if (record.getOdometer() == 0) {
        	editTextOdometer.setText("");
        } else {
        	String value = record.getOdometerString();
        	editTextOdometer.setText(value);
            editTextOdometer.setSelection(value.length());
        }
    }

    /**
     * DESCRIPTION:
     * Sets the text displayed in the cost EditText to 
     * reflect the gas record value.
     */
    private void setCostText() {
        if (record.getCost() == 0) {
        	editTextCost.setText("");
        } else {
        	String value = record.getCostString();
        	editTextCost.setText(value);
            editTextCost.setSelection(value.length());
        }
    }
    
    /**
     * DESCRIPTION:
     * Sets the text displayed in the gallons EditText to 
     * reflect the gas record value.
     */
    private void setGallonsText() {
        if (record.getGallons() == 0) {
        	editTextGallons.setText("");
        } else {
        	String value = record.getGallonsString();
        	editTextGallons.setText(value);
            editTextGallons.setSelection(value.length());
        }
    }
        
    /**
     * DESCRIPTION:
     * Retrieves the text displayed in the odometer EditText and 
     * stores the value in the gas record.
     */
    private boolean getOdometerText() {
    	boolean valid = true;
    	String value = editTextOdometer.getText().toString();
    	try {
    		record.setOdometer(value);
    	} catch (NumberFormatException e) {
    		valid = false;
    	}
    	return valid;
    }
        
    /**
     * DESCRIPTION:
     * Retrieves the text displayed in the cost EditText and 
     * stores the value in the gas record.
     */
    private boolean getCostText() {
    	boolean valid = true;
    	String value = editTextCost.getText().toString().trim();
    	try {
    		if (!value.isEmpty()) {
    			record.setCost(value);
    		} else if (Settings.isCostRequired()) {
    			valid = false;
        } else {
    			record.setCost(0d);
    		}
    	} catch (NumberFormatException e) {
    		valid = false;
    	}

    	return valid;
    }

    /**
     * DESCRIPTION:
     * Retrieves the text displayed in the gallons EditText and 
     * stores the value in the gas record.
     */
    private boolean getGallonsText() {
    	boolean valid = true;
    	String value = editTextGallons.getText().toString();
		try {
			record.setGallons(value);
		} catch (NumberFormatException e) {
			valid = false;
        }
    	return valid;
    }

    /**
     * DESCRIPTION:
     * Set the widget values based on the initial GasRecord data values. 
     */
    protected void setData() {
    	
    	editTextDate.setText(record.getDateTimeString());
    	
    	setOdometerText();
    	
    	setCostText();
    	
    	setGallonsText();
    	
        checkBoxFullTank.setChecked(record.isFullTank());
        
        editTextNotes.setText(record.getNotes());
    }

    /**
     * DESCRIPTION:
     * Get the current data values from the widgets after user edit,
     * validate them, and update the GasRecord being edited.
     * 
     * @return boolean - indicates if edited data is valid (valid=true)
     */
    protected boolean getData() {
    	
		Units units = new Units(Settings.KEY_UNITS);
		String message;
    	
		// reset any previous errors
		editTextOdometer.setError(null);
		editTextCost.setError(null);
		editTextGallons.setError(null);
		
		// odometer
    	if (!getOdometerText()) {
    		editTextOdometer.setError(getString(R.string.toast_invalid_odometer_value));
    		editTextOdometer.requestFocus();
    		return false;
    	}
    	
    	// cost
    	if (!getCostText()) {
    		editTextCost.setError(getString(R.string.toast_invalid_cost_value));
    		editTextCost.requestFocus();
    		return false;
    	}
    	
    	// gallons
    	if (!getGallonsText()) {
    		message = getString(R.string.toast_invalid_gallons_value);
    		message = String.format(message, units.getLiquidVolumeLabelLowerCase());
    		editTextGallons.setError(message);
    		editTextGallons.requestFocus();
    		return false;
    	}
   	
    	// tank full
    	record.setFullTank(checkBoxFullTank.isChecked());
    	
    	// if the tank is not full any more, reset the hidden calculation flag
    	if (!record.isFullTank()) {
    		record.setHiddenCalculation(false);
    	}
    	
    	// notes
    	String value = editTextNotes.getText().toString();
    	record.setNotes(value);
    	
    	// display calculated cost per gallon as a toast
    	value = Utilities.getCurrencyString(record.getCostPerGallon());
    	message = String.format("%s %s",value,units.getLiquidVolumeRatioLabel());
    	Utilities.toast(this,message);

    	// success - valid data set!
    	return true;
    }
    
    /**
     * DESCRIPTION:
     * Evaluate the data and, if necessary, confirm that the user intended 
     * to enter values that are in range but seem odd for the current 
     * situation.
     * @param id - the id of the last confirmation dialog displayed (0 = starting point) 
     * @return true if all data values are acceptable/confirmed.
     */
    protected boolean confirmData(int id) {
    	switch(id) {
    	
    	case 0: // starting point
        	if (record.getOdometer() < current_odometer) {
        		showDialog(DIALOG_CONFIRM_ODOMETER_LOW_ID);
        		return false;
        	} 

    	case DIALOG_CONFIRM_ODOMETER_LOW_ID:
        	if (record.getGallons() > tank_size) {
        		showDialog(DIALOG_CONFIRM_GALLONS_HIGH_ID);
        		return false;
        	}

    	default:
    		return true;
    	}
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
    	
    	// dismiss the soft keyboard
    	InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    	if (imm != null) {
    		imm.hideSoftInputFromWindow(editTextOdometer.getWindowToken(), 0);
    	}
    	
    	// validate the data set
    	if (!getData()) return;
    	
    	// confirm values that are in range, but possibly wrong
    	if (!confirmData(0)) return;
    	
    	// success
  		returnResult(Activity.RESULT_OK);
    }

	/**
	 * DESCRIPTION:
	 * Called when the EDIT DATE button is clicked.
     * @param view
	 */
	public void clickedEditDate(View view) {
		// start an Activity to edit the date/time
		Intent intent = new Intent(this, DateTimeActivity.class);
		intent.putExtra(DateTimeActivity.MILLISECONDS, record.getDate().getTime());
		startActivityForResult(intent,EDIT_DATE_TIME_REQUEST);
	}

	/**
	 * DESCRIPTION:
	 * Called when a user response has been obtained from a confirmation dialog.
	 * @see com.github.wdkapps.fillup.ConfirmationDialog.Listener#onConfirmationDialogResponse(int, boolean)
	 */
	@Override
	public void onConfirmationDialogResponse(int id, boolean confirmed) {

		// close the dialog
		removeDialog(id);

		// continue confirming data
		if (confirmed && confirmData(id)) { 
			returnResult(Activity.RESULT_OK);
		}
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
    		intent.putExtra(GasRecordActivity.RECORD, record);
    	}
    	
    	setResult(resultCode, intent); 
    	finish(); 
    }
    
    /**
     * DESCRIPTION:
     * Dialog box integer ID constants
     * @see #onCreateDialog(int)
     */
    protected static final int DIALOG_CONFIRM_ODOMETER_LOW_ID = 1;
    protected static final int DIALOG_CONFIRM_GALLONS_HIGH_ID = 2;

    /**
     * DESCRIPTION:
     * Called as needed by the framework to create dialog boxes used by the Activity.
     * Each dialog box is referenced by a locally defined id integer. 
     * @see android.app.Activity#onCreateDialog(int)
     */
    @Override
    protected Dialog onCreateDialog(int id) {
        Dialog dialog = null;
        String title;
        String message;
        String value;
        
        Units units = new Units(Settings.KEY_UNITS);
    	
    	switch (id) {
    	case DIALOG_CONFIRM_ODOMETER_LOW_ID:
    		title = getString(R.string.title_confirm_odometer);
    		message = getString(R.string.message_confirm_odometer);
    		value = Integer.toString(current_odometer);
    		message = String.format(message,value);
        	dialog = ConfirmationDialog.create(this,this,id,title,message);
        	break;
        	
    	case DIALOG_CONFIRM_GALLONS_HIGH_ID:
    		title = getString(R.string.title_confirm_gallons);
    		title = String.format(title,units.getLiquidVolumeLabel());
    		message = getString(R.string.message_confirm_gallons);
    		value = String.format(App.getLocale(),"%.1f %s", 
    				tank_size, units.getLiquidVolumeLabelLowerCase());
    		message = String.format(message,value);
        	dialog = ConfirmationDialog.create(this,this,id,title,message);
        	break;
        	
    	}
    	return dialog;
    }

	/**
	 * DESCRIPTION:
	 * Request code constants for onActivityResult()
	 * @see #onActivityResult(int, int, Intent)
	 */
	private static final int EDIT_DATE_TIME_REQUEST = 1;

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
        case EDIT_DATE_TIME_REQUEST: 
        	if (resultCode == Activity.RESULT_OK) {
        		long milliseconds = intent.getLongExtra(DateTimeActivity.MILLISECONDS,-1);
        		if (milliseconds > 0) {
        			Date date = new Date(milliseconds);
        			record.setDate(date);
        			editTextDate.setText(record.getDateTimeString());
        		}
        	} 
        	break;
        	
        default:
        	Utilities.toast(this,"Invalid Request Code.");
        }
    }

	/**
	 * DESCRIPTION:
	 * Called when the focus state of a view has changed.
	 * @see android.view.View.OnFocusChangeListener#onFocusChange(android.view.View, boolean)
	 */
	@Override
	public void onFocusChange(View view, boolean hasFocus) {

		// do nothing if view is getting focus
		if (hasFocus) return;

		// losing focus...get the new value and if valid, re-display it correctly formatted
		switch (view.getId()) {
		case R.id.editTextOdometer:
			if (getOdometerText()) setOdometerText();
			break;
		case R.id.editTextCost:
			if (getCostText()) setCostText();
			break;
		case R.id.editTextGallons:
			if (getGallonsText()) setGallonsText();
			break;
		}
	}

}
