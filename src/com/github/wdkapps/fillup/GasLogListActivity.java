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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.TextView;
import android.widget.AdapterView.AdapterContextMenuInfo;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

/**
 * DESCRIPTION:
 * Implements an Android Activity class to display a list of 
 * gasoline records contained within a gas log database. Provides
 * a user interface to manipulate records in the log.
 */
public class GasLogListActivity 
extends Activity 
implements ConfirmationDialog.Listener, 
	StorageSelectionDialog.Listener, 
	OnItemClickListener, 
	OnSharedPreferenceChangeListener 
{
	
	/// key name for the Vehicle to pass via Intent
	/// gas records for this vehicle are displayed in the list 
	public final static String VEHICLE = GasLogListActivity.class.getName() + ".VEHICLE";
	
	/// the gasoline log
	private GasLog gaslog;
	
	/// the vehicle to display gas records for (obtained via Intent)
	private Vehicle vehicle;

	/// a list of records in the log 
	private List<GasRecord> records;

	/// the currently selected row from the list of records 
	private int selectedRow;
	
	/// the Android ListView for display of log records
	private ListView listView;
	
	/// an adapter used to format and display each log record 
	private GasLogListAdapter adapter;
	
    /**
     * DESCRIPTION:
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gas_log_list);
       
        // get the vehicle from Intent
        Intent intent = getIntent();
        vehicle = (Vehicle)intent.getSerializableExtra(VEHICLE);

        // initialize other attributes
        gaslog = GasLog.getInstance();
		records = gaslog.readAllRecords(vehicle);
		listView = (ListView)findViewById(R.id.gas_log_list);
		adapter = new GasLogListAdapter(this,records);

		// configure ListView to use our adapter
		listView.setAdapter(adapter);
		
		// configure ListView to use our context menu when a record is clicked
		registerForContextMenu(listView);
		listView.setLongClickable(false);
		listView.setOnItemClickListener(this);
		
		// scroll ListView to last record (highest odometer value)
		if (listView.getCount() > 0) {
			listView.setSelection(listView.getCount()-1);
		}
		
		// set column header labels to reflect current unit preference
		updateColumnHeaderLabels();
		
        // setup to be notified when preferences change
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);;
		prefs.registerOnSharedPreferenceChangeListener(this);
    }

    /**
     * DESCRIPTION:
     * Initialize the Activity's standard options menu. This is only called 
     * once, the first time the options menu is displayed. 
     * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_gas_log_list, menu);
        return true;
    }
    
    /**
     * DESCRIPTION:
     * Prepare the Activity's standard options menu to be displayed. This 
     * is called right before the menu is shown, every time it is shown, 
     * and can therefore be used to efficiently enable/disable items or 
     * otherwise dynamically modify the contents. 
     * @see android.app.Activity#onPrepareOptionsMenu(android.view.Menu)
     */
    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
    	MenuItem itemExport = menu.findItem(R.id.itemExport);
    	itemExport.setEnabled(!records.isEmpty());
    	return true;
    }
    
    /**
     * DESCRIPTION:
     * Called when an item in the options menu is selected.
     * @see android.app.Activity#onOptionsItemSelected(android.view.MenuItem)
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
    	
    	switch (item.getItemId()) {

    	case R.id.itemGetGas:
    		getGas(null);
    		return true;
    	
    	case R.id.itemImport:
    		showDialog(DIALOG_SELECT_STORAGE_LOCATION_ID);
    		return true;

    	case R.id.itemExport:
    		if (records.isEmpty()) {
    			Utilities.toast(this,getString(R.string.toast_no_data_to_export));
    		} else {
    			File file = getExportFile();
    			if (file.exists()) {
    				showDialog(DIALOG_CONFIRM_EXPORT_OVERWRITE_ID);
    			} else {
    				exportData();
    			}
    		}
    		return true;
    		
    	case R.id.itemSettings:
    		Intent intent = new Intent(this,Settings.class);
    		startActivity(intent);
    		return true;
    		
    	default:
    		return super.onOptionsItemSelected(item);
    	}
    }
    
    /**
     * DESCRIPTION:
     * Called every time the context menu is about to be shown.
     * @see android.app.Activity#onCreateContextMenu(android.view.ContextMenu, android.view.View, android.view.ContextMenu.ContextMenuInfo)
     */
    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenuInfo menuInfo) {
    	super.onCreateContextMenu(menu,view,menuInfo);
    	
    	// create the menu
    	getMenuInflater().inflate(R.menu.context_gas_log_list, menu);

    	// get index of currently selected row
    	AdapterContextMenuInfo info = (AdapterContextMenuInfo)menuInfo;
    	selectedRow = (int)info.id;
    	
    	// get record that is currently selected
    	GasRecord record = records.get(selectedRow);

    	// adjust menu contents for "show estimate"
    	if (!MileageEstimateDialog.isDisplayable(vehicle,records,selectedRow)) {
    		menu.removeItem(R.id.itemShowEstimate);
    	}

    	// adjust menu contents for "show calculation"
    	if (!MileageCalculationDialog.isDisplayable(record)) {
    		menu.removeItem(R.id.itemShowCalc);
    	}
    	
    	// adjust menu contents for "hide calculation"
    	if (record.hasCalculation()) {
    		MenuItem itemHideCalc = menu.findItem(R.id.itemHideCalc);
    		itemHideCalc.setChecked(record.isCalculationHidden());
    	} else {
    		menu.removeItem(R.id.itemHideCalc);
    	}

    }
    
	/**
	 * DESCRIPTION:
	 * Called when a record in the list is clicked.
	 * @see android.widget.AdapterView.OnItemClickListener#onItemClick(android.widget.AdapterView, android.view.View, int, long)
	 */
	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
		// display the context menu
		parent.showContextMenuForChild(view);   
    }
    
    /**
     * DESCRIPTION:
     * Called when an item in a context menu is selected.
     * @see android.app.Activity#onContextItemSelected(android.view.MenuItem)
     */
    @Override
    public boolean onContextItemSelected(MenuItem item) {
    	
    	// get index of currently selected row
    	AdapterContextMenuInfo info = (AdapterContextMenuInfo) item.getMenuInfo();
        selectedRow = (int)info.id;

    	switch (item.getItemId()) {

    	case R.id.itemEdit:
    		editRow();
    		return true;
    	
    	case R.id.itemDelete:
    		showDialog(DIALOG_CONFIRM_DELETE_ID);
    		return true;

    	case R.id.itemShowEstimate:
        	MileageEstimateDialog.init(vehicle,records,selectedRow);
    		showDialog(DIALOG_SHOW_ESTIMATE_ID);
    		return true;
    		
    	case R.id.itemShowCalc:
        	GasRecord record = records.get(selectedRow);
        	MileageCalculationDialog.init(record);
    		showDialog(DIALOG_SHOW_CALCULATION_ID);
    		return true;
    		
    	case R.id.itemHideCalc:
    		toggleHiddenCalculation(records.get(selectedRow));
    		return true;
    		
    	default:
    		return super.onContextItemSelected(item);
    	}
    }
    
    /**
     * DESCRIPTION:
     * Toggle the "hidden calculation" attribute of the specified gas record.
     * @param record - the gas record.
     */
    protected void toggleHiddenCalculation(GasRecord record) {
    	boolean hidden = record.isCalculationHidden();
    	record.setHiddenCalculation(!hidden);
		if (gaslog.updateRecord(record)) {
			adapter.notifyDataSetChanged();
		} else {
			Utilities.toast(this,getString(R.string.toast_failed));
		}
    }
    
    /**
     * DESCRIPTION:
     * Imports data from an ASCII CSV file into the log.
     */
    protected void importData(Uri uri) {
    	
        InputStream file;
		try {
			file = getContentResolver().openInputStream(uri);
		} catch (FileNotFoundException e) {
    		Utilities.toast(this,getString(R.string.toast_import_failed));
    		return;
		}
    	
    	if (!gaslog.importData(vehicle, file)) {
    		Utilities.toast(this,getString(R.string.toast_import_failed));
    		return;
    	} 
    	
    	records.clear();
    	records.addAll(gaslog.readAllRecords(vehicle));
    	adapter.notifyDataSetChanged();
		Utilities.toast(this,getString(R.string.toast_import_complete));
    }
    
    /**
     * DESCRIPTION:
     * Return the name and path to a file for exporting log data.
     * @return the File.
     */
    protected File getExportFile() {
    	
    	// get path to external storage directory 
    	File dir = ExternalStorage.getPublicDownloadDirectory();
    	
    	// export file is named after vehicle and stored in external storage directory
    	String file = vehicle.getName()+ ".csv";
    	return new File(dir,file);
    }
    
    /**
     * DESCRIPTION:
     * Allow user to select a file to import using an installed cloud application.
     */
    private void showCloudStorageChooser() {
        try {
            Intent target = new Intent(Intent.ACTION_GET_CONTENT); 
            // text/csv better, but need */* for google drive, else cannot select file
            target.setType("*/*");  
            target.addCategory(Intent.CATEGORY_OPENABLE);
            startActivityForResult(target,CHOOSE_IMPORT_FILE);
        } catch (android.content.ActivityNotFoundException ex) {
    		Utilities.toast(this,getString(R.string.toast_activity_not_found));
        }
    }
    
    /**
     * DESCRIPTION:
     * Allow the user to select a file to import from internal storage.
     */
    private void showInternalStorageChooser() {

    	if (ExternalStorage.isReadable()) {
    		Intent intent = new Intent(this, FileSelectionActivity.class);
    		File root = Environment.getExternalStorageDirectory();
    		File path = Environment.getExternalStoragePublicDirectory(DOWNLOAD_SERVICE);
    		intent.putExtra(FileSelectionActivity.ROOT,root.getAbsolutePath());
    		intent.putExtra(FileSelectionActivity.PATH,path.getAbsolutePath());
    		intent.putExtra(FileSelectionActivity.EXT,".csv");
    		startActivityForResult(intent,CHOOSE_IMPORT_FILE);
    	} else {
    		Utilities.toast(this,getString(R.string.toast_external_storage_not_readable));
    	}

    }
    
    /**
     * DESCRIPTION:
     * Exports data from the log to an ASCII CSV file.
     */
    protected void exportData() {
    	
    	if (!ExternalStorage.isWritable()) {
    		Utilities.toast(this,getString(R.string.toast_external_storage_not_writable));
    		return;
    	}

    	File file = getExportFile();
	
    	if (gaslog.exportData(vehicle,file)) {
    		Utilities.toast(this,getString(R.string.toast_export_complete));
    		Utilities.toast(this, file.getAbsolutePath());
    		showDialog(DIALOG_CONFIRM_EXPORT_SHARE_ID);
    	} else {
    		Utilities.toast(this,getString(R.string.toast_export_failed));
    	}
    }
    
    /**
     * DESCRIPTION:
     * Called when the user requests that a gasoline record be added to 
     * the log. Starts a new Activity to allow the user to enter the data. 
     * 
     * @param view - the View that activated this method (button click, etc).
     */
    protected void getGas(View view) {
    	Intent intent = new Intent(this, GasRecordActivity.class);
    	GasRecord record = new GasRecord(vehicle);
        int current_odometer = gaslog.readCurrentOdometer(vehicle);
    	intent.putExtra(GasRecordActivity.RECORD, record);
        intent.putExtra(GasRecordActivity.CURRENT_ODOMETER, current_odometer);
        intent.putExtra(GasRecordActivity.TANK_SIZE, vehicle.getTankSize());
    	startActivityForResult(intent,GET_GAS_REQUEST);
    }
    
    /**
     * DESCRIPTION:
     * Called when the user finishes entering data for a gasoline record
     * to add to the log.
     * @param record - the GasRecord data entered by the user.
     */
    protected void onGetGasResult(GasRecord record) {
    	
		// attempt to add the new record to the log
		if (!gaslog.createRecord(vehicle,record)) {
			Utilities.toast(this,getString(R.string.toast_error_saving_data));
			return;
		}

		// success!
		Utilities.toast(this,getString(R.string.toast_data_saved));

		// determine if full tank has been recorded before
		boolean previousFullTank = GasRecordList.hasFullTank(records);

		// add the new record to the list
		records.add(record);

		// recalculate mileage for the list
		GasRecordList.calculateMileage(records);

		// notify adapter that the list has changed
		adapter.notifyDataSetChanged();

		// find the position of the record in the list
		int position = GasRecordList.find(records,record);

		// scroll that row into view
		listView.setSelection(position);

		// need a previous full tank in the log to do any calculations
		if (!previousFullTank) {
			showDialog(DIALOG_TANK_NEVER_FILLED_ID);
			return;
		}

		// display mileage calculation if possible
		if (MileageCalculationDialog.isDisplayable(record)) {
			MileageCalculationDialog.init(record);
			showDialog(DIALOG_SHOW_CALCULATION_ID);
			return;
		} 

		// display mileage estimate if possible
		if (MileageEstimateDialog.isDisplayable(vehicle,records,position)) {
			MileageEstimateDialog.init(vehicle,records,position);
			showDialog(DIALOG_SHOW_ESTIMATE_ID);
		} 
			
    }
    
    /**
     * DESCRIPTION:
     * Called when the user requests to edit a specific gasoline record.
     * Starts new Activity to allow the user to edit the data.
     */
    protected void editRow() {
    	Intent intent = new Intent(this, GasRecordActivity.class);
    	GasRecord record = records.get(selectedRow);
    	intent.putExtra(GasRecordActivity.RECORD, record);
        intent.putExtra(GasRecordActivity.TANK_SIZE, vehicle.getTankSize());
    	startActivityForResult(intent,EDIT_ROW_REQUEST);
    }
    
    /**
     * DESCRIPTION:
     * Called when the user finishes editing data for a gasoline record.
     * @param record - the GasRecord data edited by the user.
     */
    protected void onEditRowResult(GasRecord record) {
		if (gaslog.updateRecord(record)) {
			records.set(selectedRow,record);
			GasRecordList.calculateMileage(records);
			adapter.notifyDataSetChanged();
		} else {
			Utilities.toast(this,getString(R.string.toast_edit_failed));
		}
    }
    
    /**
     * DESCRIPTION:
     * Called when the user has selected a gasoline record to delete
     * from the log and has confirmed deletion.
     */
    protected void deleteRow() {
    	
    	// get the record to delete from our list of records
    	GasRecord record = records.get(selectedRow);
    	
    	// attempt to remove the record from the log
    	if (gaslog.deleteRecord(record)) {
    		// success!
    		
    		// remove the record from our list of records
    		records.remove(selectedRow);
    		
    		// re-calculate mileage based on the modified data
    		GasRecordList.calculateMileage(records);
    		
    		// update the list view
    		adapter.notifyDataSetChanged();
    	} else {
    		Utilities.toast(this,getString(R.string.toast_delete_failed));
    	}

    }
    
	/**
	 * DESCRIPTION:
	 * Request code constants for onActivityResult()
	 * @see #onActivityResult(int, int, Intent)
	 */
	private static final int EDIT_ROW_REQUEST = 1;
	private static final int GET_GAS_REQUEST = 2;
	private static final int CHOOSE_IMPORT_FILE = 3;
    
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
        case EDIT_ROW_REQUEST: 
        	if (resultCode == Activity.RESULT_OK) {
        		GasRecord data = (GasRecord)intent.getSerializableExtra(GasRecordActivity.RECORD);
        		onEditRowResult(data);
        	} else {
        		Utilities.toast(this,getString(R.string.toast_canceled));
        	}
        	break;
        	
        case GET_GAS_REQUEST: 
        	if (resultCode == Activity.RESULT_OK) {
        		GasRecord data = (GasRecord)intent.getSerializableExtra(GasRecordActivity.RECORD);
        		onGetGasResult(data);
        	} else {
        		Utilities.toast(this,getString(R.string.toast_canceled));
        	}
        	break;
        	
        case CHOOSE_IMPORT_FILE:
        	if (resultCode == Activity.RESULT_OK) {
                Uri uri = intent.getData();
    			importData(uri);
        	} else {
        		Utilities.toast(this,getString(R.string.toast_canceled));
        	}

        	break;
        	
        default:
        	Utilities.toast(this,"Invalid request code.");
        }
    }
    
    /**
     * DESCRIPTION:
     * Dialog box integer ID constants
     * @see #onCreateDialog(int)
     */
    protected static final int DIALOG_CONFIRM_DELETE_ID = 1;
    protected static final int DIALOG_SHOW_CALCULATION_ID = 2;
    protected static final int DIALOG_CONFIRM_EXPORT_OVERWRITE_ID = 3;
    protected static final int DIALOG_SELECT_STORAGE_LOCATION_ID = 4;
    protected static final int DIALOG_SHOW_ESTIMATE_ID = 5;
    protected static final int DIALOG_TANK_NEVER_FILLED_ID = 6;
    protected static final int DIALOG_CONFIRM_EXPORT_SHARE_ID = 7;
    
    /** 
     * DESCRIPTION: 
     * Called as needed by the framework to create dialog boxes used by the Activity.
     * Each dialog box is referenced by a locally defined id integer. 
     * 
     * @see android.app.Activity#onCreateDialog(int)
     */
    protected Dialog onCreateDialog(int id) {
        Dialog dialog = null;
        String title;
        String message;

        switch(id) {
        case DIALOG_CONFIRM_DELETE_ID:
        	title = getString(R.string.title_confirm_log_delete_dialog);
        	message = getString(R.string.message_confirm_log_delete_dialog);
        	dialog = ConfirmationDialog.create(this,this,id,title,message);
            break;
            
        case DIALOG_SHOW_ESTIMATE_ID:
        	dialog = MileageEstimateDialog.create(this,id);
            break;
            
        case DIALOG_SHOW_CALCULATION_ID:
        	dialog = MileageCalculationDialog.create(this,id);
            break;
            
        case DIALOG_CONFIRM_EXPORT_OVERWRITE_ID:
        	File file = getExportFile();
        	title = getString(R.string.title_confirm_export_overwrite_dialog);
        	message = getString(R.string.message_confirm_export_overwrite_dialog);
        	message = String.format(message,file.getAbsolutePath());
        	dialog = ConfirmationDialog.create(this,this,id,title,message);
            break;
            
        case DIALOG_CONFIRM_EXPORT_SHARE_ID:
        	title = getString(R.string.title_confirm_export_share_dialog);
        	message = getString(R.string.message_confirm_export_share_dialog);
        	dialog = ConfirmationDialog.create(this,this,id,title,message);
            break;
            
        case DIALOG_SELECT_STORAGE_LOCATION_ID:
        	dialog = StorageSelectionDialog.create(this,this,DIALOG_SELECT_STORAGE_LOCATION_ID);
        	break;
        	
        case DIALOG_TANK_NEVER_FILLED_ID:
   			dialog = TankNeverFilledDialog.create(this,id);
            break;
        			
        default:
            dialog = null;
        }
        
        return dialog;
    }
    
	/**
	 * DESCRIPTION:
	 * Called when a confirmation dialog gets a response from the user.
	 * @see com.github.wdkapps.fillup.ConfirmationDialog.Listener#onConfirmationDialogResponse(int, boolean)
	 */
	@Override
	public void onConfirmationDialogResponse(int id, boolean confirmed) {
		
		removeDialog(id);
		
		if (!confirmed) return;
		
		switch(id) {
		case DIALOG_CONFIRM_DELETE_ID:
			deleteRow();
			break;
		case DIALOG_CONFIRM_EXPORT_OVERWRITE_ID:
			exportData();
			break;
		case DIALOG_CONFIRM_EXPORT_SHARE_ID:
			File file = getExportFile();
			Intent intent = new Intent(Intent.ACTION_SEND);
			intent.setType("text/plain");
			intent.putExtra(Intent.EXTRA_STREAM,Uri.fromFile(file));
			intent.putExtra(Intent.EXTRA_SUBJECT,file.getName());
			intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
			startActivity(Intent.createChooser(intent, getString(R.string.title_chooser_share_csv)));
			break;
			
		default:
			Utilities.toast(this,"Invalid dialog id.");
		}
		
	}

	/**
 	 * DESCRIPTION:
	 * Called when the user selects a file.
	 * @see com.github.wdkapps.fillup.FileSelectionDialog.Listener#onFileSelectionDialogResponse(int, java.io.File)
	 */
	@Override
	public void onStorageSelectionDialogResponse(int id, StorageSelectionDialog.Result result, String value) {

		removeDialog(id);
		
		if (result == StorageSelectionDialog.Result.RESULT_CANCEL) {
			Utilities.toast(this,getString(R.string.toast_canceled));
			return;
		}
		
		switch(id) {
		case DIALOG_SELECT_STORAGE_LOCATION_ID:
			if (value.equals("cloud")) {
				showCloudStorageChooser();
			} else {
				showInternalStorageChooser();
			}
			break;
		default:
			Utilities.toast(this,"Invalid dialog id.");
		}
		
	}
	
	/**
	 * DESCRIPTION:
	 * Updates the column header labels to the reflect the preferred
	 * units for distance, liquid volume, etc.
	 */
	protected void updateColumnHeaderLabels() {
        Units units = new Units(Settings.KEY_UNITS);
        TextView label = (TextView)findViewById(R.id.headerGallons);
        label.setText(units.getLiquidVolumeLabel());
        label = (TextView)findViewById(R.id.headerMileage);
        label.setText(units.getMileageLabel());
	}
	
	/**
	 * DESCRIPTION:
	 * Called when a shared preference value changes.
	 * @see android.content.SharedPreferences.OnSharedPreferenceChangeListener#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)
	 */
	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPreferences,String key) {
		if (key.equals(Settings.KEY_UNITS)) {

			// update the column header labels to reflect new units
			updateColumnHeaderLabels();

			// re-calculate mileage based on the new units
			GasRecordList.calculateMileage(records);
		}
		
		// update the list view
		adapter.notifyDataSetChanged();
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
		outState.putInt("selectedRow", selectedRow);
	}

	/**
	 * DESCRIPTION:
	 * Restore previously saved state data.
	 * @see android.app.Activity#onRestoreInstanceState(android.os.Bundle)
	 */
	@Override
	protected void onRestoreInstanceState(Bundle savedInstanceState) {
		super.onRestoreInstanceState(savedInstanceState);
		selectedRow = savedInstanceState.getInt("selectedRow");
	}

}
