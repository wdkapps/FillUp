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

import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;

/**
 * DESCRIPTION:
 * The main Activity for the application. Displays a drop down list of 
 * vehicles from the log and allows a user to add/edit/or delete vehicles, 
 * view vehicle logs, and add a gas record to the log for a selected a 
 * vehicle.  
 */
public class MainActivity 
extends Activity 
implements VehicleDialog.Listener, ConfirmationDialog.Listener, View.OnClickListener {
	
	/// the gas log
	private GasLog gaslog;
	
	/// a list of vehicles from the log
	private List<Vehicle> vehicles;
	
	/// the selected vehicle
	private Vehicle selectedVehicle;
	
	/// a "drop down list" of vehicles
	private Spinner spinnerVehicles;
	
	/// list of views that require an existing vehicle
	private List<View> listViewsThatNeedVehicle;
	
	/// an adapter to populate the spinner with vehicle names
	private ArrayAdapter<Vehicle> adapter;
	
    /**
     * DESCRIPTION
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        // restore preferences
        PreferenceManager.setDefaultValues(this, R.xml.preferences, false);
        
        // register as click listener for our views
        ImageButton buttonVehicleAdd = (ImageButton)findViewById(R.id.buttonVehicleAdd);
        ImageButton buttonVehicleEdit = (ImageButton)findViewById(R.id.buttonVehicleEdit);
        ImageButton buttonVehicleDelete = (ImageButton)findViewById(R.id.buttonVehicleDelete);
        Button buttonGetGas = (Button)findViewById(R.id.buttonGetGas);
        Button buttonViewLog = (Button)findViewById(R.id.buttonViewLog);
        Button buttonPlotData = (Button)findViewById(R.id.buttonPlotData);
        Button buttonViewStatistics = (Button)findViewById(R.id.buttonViewStatistics);
        buttonVehicleAdd.setOnClickListener(this);
        buttonVehicleEdit.setOnClickListener(this);
        buttonVehicleDelete.setOnClickListener(this);
        buttonGetGas.setOnClickListener(this);
        buttonViewLog.setOnClickListener(this);
        buttonPlotData.setOnClickListener(this);
        buttonViewStatistics.setOnClickListener(this);
        
        // create a list of views that require an existing vehicle
        listViewsThatNeedVehicle = new LinkedList<View>();
        listViewsThatNeedVehicle.add(buttonVehicleEdit);
        listViewsThatNeedVehicle.add(buttonVehicleDelete);
        listViewsThatNeedVehicle.add(buttonGetGas);
        listViewsThatNeedVehicle.add(buttonViewLog);
        listViewsThatNeedVehicle.add(buttonPlotData);
        listViewsThatNeedVehicle.add(buttonViewStatistics);

        // create a log instance for use by this application
        gaslog = GasLog.getInstance();
        
        // get a list of all vehicles currently documented in the log
        vehicles = GasLog.getInstance().readAllVehicles();
        
        // create a drop down list for vehicle selection
        adapter = new ArrayAdapter<Vehicle>(this,android.R.layout.simple_spinner_item,vehicles);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerVehicles = (Spinner)findViewById(R.id.spinnerVehicles);
        spinnerVehicles.setAdapter(adapter);
        updateVehiclesSpinnerState();
        
        // if the activity is not being re-initialized (for example after screen rotate)
        // start by adding a vehicle if there are none currently defined
        if ((savedInstanceState == null) && vehicles.isEmpty()) {
        	showDialog(DIALOG_ADD_VEHICLE_ID);
        }
        
    }
    
    /**
     * DESCRIPTION:
     * Enable/disable the "drop down list" of vehicles and all
     * vehicle related View instances depending on whether any vehicles
     * are currently defined. 
     */
    private void updateVehiclesSpinnerState() {
    	boolean enabled = !vehicles.isEmpty();
    	spinnerVehicles.setEnabled(enabled);
    	for (View view : listViewsThatNeedVehicle) {
    		view.setEnabled(enabled);
    	}
    }

    /**
     * DESCRIPTION:
     * Initialize the contents of the Activity's standard options menu. 
     * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Called when an item in the options menu is selected.
     * @see android.app.Activity#onOptionsItemSelected(android.view.MenuItem)
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
    	
    	Intent intent;

    	switch (item.getItemId()) {

    	case R.id.itemVehicleAdd:
    		showDialog(DIALOG_ADD_VEHICLE_ID);
    		return true;

    	case R.id.itemVehicleEdit:
    		if (getSelectedVehicle() != null) {
    			showDialog(DIALOG_EDIT_VEHICLE_ID);
    		}
    		return true;

    	case R.id.itemVehicleDelete:
    		if (getSelectedVehicle() != null) {
    			showDialog(DIALOG_DELETE_VEHICLE_ID);
    		}
    		return true;

    	case R.id.itemHelp:
			intent = new Intent(this, HtmlViewerActivity.class);
			intent.putExtra(HtmlViewerActivity.URL,getString(R.string.url_help_html));
			startActivity(intent);
			return true;

    	case R.id.itemSettings:
    		intent = new Intent(this,Settings.class);
    		startActivity(intent);
    		return true;

    	default:
    		return super.onOptionsItemSelected(item);
    	}
    }
    
	/**
	 * DESCRIPTION:
	 * Called when a View (i.e Button) that this Activity is a registered 
	 * listener for is clicked. 
	 * @see android.view.View.OnClickListener#onClick(android.view.View)
	 */
	@Override
	public void onClick(View v) {
		
		switch (v.getId()) {
		
		case R.id.buttonVehicleAdd:
	       	showDialog(DIALOG_ADD_VEHICLE_ID);
			break;

		case R.id.buttonVehicleEdit:
            if (getSelectedVehicle() != null) {
            	showDialog(DIALOG_EDIT_VEHICLE_ID);
            }
			break;

		case R.id.buttonVehicleDelete:
            if (getSelectedVehicle() != null) {
            	showDialog(DIALOG_DELETE_VEHICLE_ID);
            }
			break;
			
		case R.id.buttonGetGas:
			getGas(v);
			break;
			
		case R.id.buttonViewLog:
			viewLog(v);
			break;
			
		case R.id.buttonPlotData:
			plotData(v);
			break;

		case R.id.buttonViewStatistics:
			viewStatistics(v);
			break;
			
		default:
			Utilities.toast(this,"Invalid view id.");
		}
		
	}

    /**
     * DESCRIPTION:
     * Determines which vehicle is currently selected in the spinner.
     * @return the selected Vehicle. Also sets the selectedVehicle class attribute.
     */
    protected Vehicle getSelectedVehicle() {
        selectedVehicle = (Vehicle)spinnerVehicles.getSelectedItem();
        if (selectedVehicle == null) {
        	Utilities.toast(this,getString(R.string.toast_select_a_vehicle));
        }
        return selectedVehicle;
    }
    
    /**
     * DESCRIPTION:
     * Selects a vehicle based on its position in the vehicles list.
     * @param position - the list index of the vehicle to select
     */
    protected void setSelectedVehicle(int position) {
    	updateVehiclesSpinnerState();
    	if ((position >= 0) && (position < vehicles.size())) {
    		spinnerVehicles.setSelection(position);
    	}
    }
    
    /**
     * DESCRIPTION:
     * Locates a specified vehicle in the spinner and selects it. If unable
     * to find vehicle, the first vehicle in spinner is selected. 
     * @param name - the name of the vehicle to select.
     */
    protected void setSelectedVehicle(String name) {
    	
    	// find the vehicle by name
    	int position = 0;
    	for (int i = 0; i < vehicles.size(); i++) {
    		if (vehicles.get(i).getName().equals(name)) {
    			position = i;
    		}
    	}
    	
    	// select it
    	setSelectedVehicle(position);
    }
    
    /**
     * DESCRIPTION:
     * Starts an Activity to view the log records for the 
     * selected vehicle.
     * @param view - currently unused - necessary only if called as click listener.
     */
    public void viewLog(View view) {

    	// get the selected vehicle
        if (getSelectedVehicle() == null) return;
        
        // start an Activity to display gas records for the vehicle
    	Intent intent = new Intent(this, GasLogListActivity.class);
    	intent.putExtra(GasLogListActivity.VEHICLE, selectedVehicle);
    	startActivity(intent);
    }
    
    /**
     * DESCRIPTION:
     * Starts an Activity to get a new gasoline record to be added to 
     * the gas log for the selected vehicle.
     * @param view - currently unused - necessary only if called as click listener.
     */
    public void getGas(View view) {

    	// get the selected vehicle
        if (getSelectedVehicle() == null) return;

        // prepare input for GasRecordActivity
    	GasRecord record = new GasRecord(selectedVehicle);
        int current_odometer = gaslog.readCurrentOdometer(selectedVehicle);
        
        // start a GasRecordActivity to get a new gas record for the vehicle
    	Intent intent = new Intent(this, GasRecordActivity.class);
    	intent.putExtra(GasRecordActivity.RECORD, record);
        intent.putExtra(GasRecordActivity.CURRENT_ODOMETER, current_odometer);
        intent.putExtra(GasRecordActivity.TANK_SIZE, selectedVehicle.getTankSize());
    	startActivityForResult(intent,GET_GAS_REQUEST);
    }
    
    /**
     * DESCRIPTION:
     * Starts an Activity to plot data for the selected vehicle.
     * @param view - currently unused - necessary only if called as click listener.
     */
    public void plotData(View view) {

    	// get the selected vehicle
        if (getSelectedVehicle() == null) return;
        
        // start an Activity to display gas records for the vehicle
    	Intent intent = new Intent(this, PlotActivity.class);
    	intent.putExtra(PlotActivity.VEHICLE, selectedVehicle);
    	startActivity(intent);
    }

    /**
     * DESCRIPTION:
     * Starts an Activity to display statistical data for the selected vehicle.
     * @param view - currently unused - necessary only if called as click listener.
     */
    public void viewStatistics(View view) {

    	// get the selected vehicle
        if (getSelectedVehicle() == null) return;
        
        // start an Activity to display statistics for the vehicle
    	Intent intent = new Intent(this, StatisticsActivity.class);
    	intent.putExtra(StatisticsActivity.VEHICLE, selectedVehicle);
    	startActivity(intent);
    }
    
    /**
     * DESCRIPTION:
     * Adds a new vehicle to the log.
     * @param vehicle - the new Vehicle.
     * @return boolean - true if successful.
     */
    protected boolean addVehicle(Vehicle vehicle) {

    	// attempt to add the vehicle to the log
    	if (!gaslog.createVehicle(vehicle)) {
    		Utilities.toast(this,getString(R.string.toast_add_failed));
    		return false;
    	}
    	
    	// read updated list of vehicles from the log
    	vehicles.clear();
    	vehicles.addAll(gaslog.readAllVehicles());
        adapter.notifyDataSetChanged();
    	
        // select the new vehicle by its name
        setSelectedVehicle(vehicle.getName());

        // success
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Updates data for a specified vehicle in the log.
     *
     * @param vehicle - the edited vehicle.
     * @return boolean - true if successful.
     */
    protected boolean editVehicle(Vehicle vehicle) {
    	
    	// attempt to update the vehicle data in the log
    	if (!gaslog.updateVehicle(vehicle)) {
    		Utilities.toast(this,getString(R.string.toast_edit_failed));
    		return false;
    	}

    	// read updated list of vehicles from the log
    	vehicles.clear();
    	vehicles.addAll(gaslog.readAllVehicles());
        adapter.notifyDataSetChanged();
        
        // select the edited vehicle by its new name
        setSelectedVehicle(vehicle.getName());
        
        // success
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Removes the selected vehicle and all its gas records from
     * the log.
     * @return boolean - true if successful.
     */
    protected boolean deleteVehicle() {

    	// attempt to update the vehicle data in the log
    	if (!gaslog.deleteVehicle(selectedVehicle)) {
    		Utilities.toast(this,getString(R.string.toast_delete_failed));
    		return false;
    	}
    	
    	// read updated list of vehicles from the log
    	vehicles.clear();
    	vehicles.addAll(gaslog.readAllVehicles());
        adapter.notifyDataSetChanged();
        
    	// select the first vehicle in the list
       	setSelectedVehicle(0);

        // success
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Dialog box integer ID constants
     * @see #onCreateDialog(int)
     */
    protected static final int DIALOG_ADD_VEHICLE_ID = 1;
    protected static final int DIALOG_EDIT_VEHICLE_ID = 2;
    protected static final int DIALOG_DELETE_VEHICLE_ID = 3;
    protected static final int DIALOG_SHOW_CALCULATION_ID = 4;
    protected static final int DIALOG_SHOW_ESTIMATE_ID = 5;
    protected static final int DIALOG_TANK_NEVER_FILLED_ID = 6;

    /**
     * DESCRIPTION:
     * Called as needed by the framework to create dialog boxes used by the Activity.
     * Each dialog box is referenced by a locally defined id integer. 
     * @see android.app.Activity#onCreateDialog(int)
     */
    protected Dialog onCreateDialog(int id) {
        Dialog dialog = null;
        String title;
        String message;
    	
    	switch (id) {
    	case DIALOG_ADD_VEHICLE_ID:
    		title = getString(R.string.vehicle_add_label);
        	dialog = VehicleDialog.create(this,this,id,title,new Vehicle());
        	break;

    	case DIALOG_EDIT_VEHICLE_ID:
    		title = getString(R.string.vehicle_edit_label);
    		dialog = VehicleDialog.create(this,this,id,title,new Vehicle(selectedVehicle));
            break;
            
    	case DIALOG_DELETE_VEHICLE_ID:
    		title = getString(R.string.title_confirm_delete_vehicle);
    		message = getString(R.string.message_confirm_delete_vehicle);
   			dialog = ConfirmationDialog.create(this,this,id,title,message);
        	break;
        	
        case DIALOG_SHOW_CALCULATION_ID:
        	dialog = MileageCalculationDialog.create(this,id);
            break;

        case DIALOG_SHOW_ESTIMATE_ID:
        	dialog = MileageEstimateDialog.create(this,id);
            break;
            
        case DIALOG_TANK_NEVER_FILLED_ID:
   			dialog = TankNeverFilledDialog.create(this,id);
            break;
            
        default:
        	Utilities.toast(this,"Invalid dialog id.");
    	}
    	return dialog;
    }
    
	/**
	 * DESCRIPTION:
	 * Called when the user is done entering/editing vehicle data.
	 * @see com.github.wdkapps.fillup.VehicleDialog.Listener#onVehicleDialogClosure(int, com.github.wdkapps.fillup.Vehicle)
	 */
	@Override
	public void onVehicleDialogClosure(int id, Vehicle vehicle) {
		
		removeDialog(id);
		
		if (vehicle == null) {
			Utilities.toast(this,getString(R.string.toast_canceled));
			return;
		}
		
		switch (id) {

		case DIALOG_ADD_VEHICLE_ID:
			addVehicle(vehicle);
			break;

		case DIALOG_EDIT_VEHICLE_ID:
			editVehicle(vehicle);
			break;

		default:
			Utilities.toast(this,"Invalid dialog id.");
		}
	}
	
	/**
	 * DECSRIPTION:
	 * Called when a user response has been obtained from the dialog.
	 * @see com.github.wdkapps.fillup.ConfirmationDialog.Listener#onConfirmationDialogResponse(int, boolean)
	 */
	@Override
	public void onConfirmationDialogResponse(int id, boolean confirmed) {

		removeDialog(id);
		
		if (!confirmed) return;
		
		switch (id) {

		case DIALOG_DELETE_VEHICLE_ID:
			deleteVehicle();
			break;
			
		default:
			Utilities.toast(this,"Invalid dialog id.");
		}
	}

    /**
     * DESCRIPTION:
     * Adds a gas record to the log for the selected vehicle.
     * @param record - the GasRecord data entered by the user.
     */
    protected void addGasRecord(GasRecord record) {

    	// get a list of records from the log before adding new record
		List<GasRecord> list = gaslog.readAllRecords(selectedVehicle);
    	
		// attempt to add the new record to the log
    	if (!gaslog.createRecord(selectedVehicle,record)) { 
			Utilities.toast(this,getString(R.string.toast_error_saving_data));
    		return;
		}
    	
    	// success!
    	Utilities.toast(this,getString(R.string.toast_data_saved));
    	
    	// need a previous full tank in the log to do any calculations
    	if (TankNeverFilledDialog.isDisplayable(list)) {
    		showDialog(DIALOG_TANK_NEVER_FILLED_ID);
    		return;
    	}
    	
    	// add the new record to the list
    	list.add(record);
    	
    	// recalculate mileage
    	GasRecordList.calculateMileage(list);
    	
    	// find the new location of the record in the list (after sort)
    	int location = GasRecordList.find(list,record);
			
    	// display mileage calculation if possible
    	if (MileageCalculationDialog.isDisplayable(record)) {
    		MileageCalculationDialog.init(record);
    		showDialog(DIALOG_SHOW_CALCULATION_ID);
    		return;
    	} 

    	// display mileage estimate if possible
    	if (MileageEstimateDialog.isDisplayable(selectedVehicle,list,location)) {
    		MileageEstimateDialog.init(selectedVehicle,list,location);
    		showDialog(DIALOG_SHOW_ESTIMATE_ID);
    	} 
    
    }
    
	/**
	 * DESCRIPTION:
	 * Request code constants for onActivityResult()
	 * @see #onActivityResult(int, int, Intent)
	 */
	private static final int GET_GAS_REQUEST = 1;
    
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
        case GET_GAS_REQUEST: 
        	if (resultCode == Activity.RESULT_OK) {
        		GasRecord record = (GasRecord)intent.getSerializableExtra(GasRecordActivity.RECORD);
        		addGasRecord(record);
        	} else {
        		Utilities.toast(this,getString(R.string.toast_canceled));
        	}
        	break;
        	
        default:
        	Utilities.toast(this,"Invalid Request Code.");
        }
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
		outState.putSerializable("selectedVehicle", selectedVehicle);
	}

	/**
	 * DESCRIPTION:
	 * Restore previously saved state data.
	 * @see android.app.Activity#onRestoreInstanceState(android.os.Bundle)
	 */
	@Override
	protected void onRestoreInstanceState(Bundle savedInstanceState) {
		super.onRestoreInstanceState(savedInstanceState);
		selectedVehicle = (Vehicle)savedInstanceState.getSerializable("selectedVehicle");
	}

}
