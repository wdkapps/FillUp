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

import java.util.List;

import android.app.Activity;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * An Android ArrayAdapter for the purpose of displaying gasoline records
 * in an Android ListView.
 */
public class GasLogListAdapter extends ArrayAdapter<GasRecord> {
	
	/// the Android Activity owning the ListView
	private final Activity activity;
		
	/// a list of gasoline records for display 
	private final List<GasRecord> records;
	
    /// currently configured units of measurement
    private Units units;
    
    /// currently settings for displaying cost and notes
    private boolean isCostDisplayable;
    private boolean isNotesDisplayable;

	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasLogListAdapter.
	 *
	 * @param activity - the Android Activity instance that owns the ListView.
	 * @param records - the List of GasRecord instances for display in the ListView.
	 */
	public GasLogListAdapter(Activity activity, List<GasRecord> records) {
		super(activity,R.layout.row_gas_log_list,records);
		this.activity = activity;
		this.records = records;
		getSettings();
	}
	
	/**
	 * DESCRIPTION:
	 * Gets current configuration values from Settings. Better performance 
	 * keeping a local copy of these values, but we need to update
	 * when they change.
	 * @see GasLogListAdapter#notifyDataSetChanged()
	 */
	private void getSettings() {
		this.units = new Units(Settings.KEY_UNITS);
		this.isCostDisplayable = Settings.isCostDisplayable();
		this.isNotesDisplayable = Settings.isNotesDisplayable();
	}
	
	/**
	 * DESCRIPTION:
	 * Constructs and populates a View for display of the GasRecord date at the index
	 * of the List specified by the position parameter.
	 * @see android.widget.ArrayAdapter#getView(int, android.view.View, android.view.ViewGroup)
	 */
	@Override
	public View getView(int position, View view, ViewGroup parent) {
		
		// create a view for the row if it doesn't already exist
		if (view == null) {
			LayoutInflater inflater = activity.getLayoutInflater();
			view = inflater.inflate(R.layout.row_gas_log_list,null);
		} 
		
		// get widgets from the view
		TextView columnDate = (TextView)view.findViewById(R.id.columnDate);
		TextView columnOdometer = (TextView)view.findViewById(R.id.columnOdometer);
		TextView columnGallons = (TextView)view.findViewById(R.id.columnGallons);
		TextView columnMileage = (TextView)view.findViewById(R.id.columnMileage);
		TextView rowCost = (TextView)view.findViewById(R.id.rowCost);
		TextView rowNotes = (TextView)view.findViewById(R.id.rowNotes);
		
		// populate row widgets from record data
		GasRecord record = records.get(position);
		
		// date
		columnDate.setText(record.getDateString());

		// odometer (bold if tank is full) 
		if (record.isFullTank()) {
			columnOdometer.setText(Html.fromHtml("<b>"+record.getOdometerString()+"</b>"));
		} else {
			columnOdometer.setText(record.getOdometerString());
		}
		
		// gallons
		columnGallons.setText(record.getGallonsString());
		
		// mpg
		String mileage = "";
		if (record.hasCalculation()) {
			mileage = record.getCalculation().getMileageString();
			if (mileage.length() > "9999.99".length()) {
				mileage = "#VAL!";
			}
			if (record.isCalculationHidden()) {
				mileage = "---";
			}
		}
		columnMileage.setText(mileage);
		
		// cost (don't display if zero)
		if (!isCostDisplayable || (record.getCost() == 0d)) {
			rowCost.setVisibility(View.GONE);
		} else {
			String cost = String.format("<b>%s</b>: %s (%s %s)",
					App.getContext().getString(R.string.cost_label),
					CurrencyManager.getInstance().getSymbolicFormatter().format(record.getCost()),
					CurrencyManager.getInstance().getSymbolicFractionalFormatter().format(record.getPrice()),
					units.getLiquidVolumeRatioLabel());
			rowCost.setText(Html.fromHtml(cost));
			rowCost.setVisibility(View.VISIBLE);
		}

		// notes (don't display if blank)
		String notes = record.getNotes();
		if (!isNotesDisplayable || (notes == null) || notes.trim().isEmpty()) {
			rowNotes.setVisibility(View.GONE);
		} else {
			notes = String.format("<b>%s</b>: %s",
					App.getContext().getString(R.string.notes_label),
					notes);
			rowNotes.setText(Html.fromHtml(notes));
			rowNotes.setVisibility(View.VISIBLE);
		}
		
		// return the view
		return view;
	}

	/**
	 * DESCRIPTION:
	 * Called by parent when the underlying data set changes.
	 * @see android.widget.ArrayAdapter#notifyDataSetChanged()
	 */
	@Override
	public void notifyDataSetChanged() {
		
		// configuration may have changed - get current settings
		getSettings();
		
		super.notifyDataSetChanged();
	}
}
