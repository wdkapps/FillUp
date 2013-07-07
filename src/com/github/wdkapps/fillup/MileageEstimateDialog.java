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

import com.github.wdkapps.fillup.CheatSheet.Trigger;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.text.Html;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * A dialog box to calculate and display mileage estimates based
 * on gas gauge hand position.
 */
public class MileageEstimateDialog {
	
	/// the vehicle that the estimate is for
	private static Vehicle vehicle;
	
	/// current list of gas records from the log for estimation purposes
	private static List<GasRecord> records;
	
	// the estimate
	private static MileageCalculation calculation;
	
	/**
	 * DESCRIPTION:
	 * Determines if the dialog can be displayed for a specific set of data.<p>
	 * Data requirements: 
	 * <ul>
	 * <li>The list must be sorted by odometer value.
	 * <li>The list must contain at least two gas records:<ol>
	 * <li>the record being evaluated (cannot be full tank). 
	 * <li>a previous record with full tank.
	 * </ol>
	 * </ul>
	 * @param _vehicle - the Vehicle to calculate estimates for.
	 * @param _records - a List of gas records for the vehicle.
	 * @param location - the index of the gas record in the list to estimate mileage for.
	 * @return true if the dialog can be displayed, false otherwise. 
	 */
	public static boolean isDisplayable(Vehicle _vehicle, List<GasRecord> _records, int location) {
		
		// need valid vehicle tank size for estimates
		if ((_vehicle == null) || (_vehicle.getTankSize() <= 0.0f)) {  
			return false;
		}

		// need at least 2 gas records...the record being evaluated and a previous fill up
		if ((_records == null) || (_records.size() < 2)) {
			return false;
		}
		
		// range check the specified gas record location
		if ((location < 1) || (location > (_records.size()-1))) {
			return false;
		}
		
		// the record being evaluated should not be a full tank
		if (_records.get(location).isFullTank()) { 
			return false;
		}

		// a previous fill up must exist
		if (GasRecordList.findPreviousFullTank(_records, location) < 0) {
			return false;
		}

		// can display the dialog for the specified data!
		return true;
	}
	
	/**
	 * DESCRIPTION:
	 * Initializes the data required to perform mileage estimate calculations. 
	 * NOTE: Assumes that the dialog isDisplayable() for the specified data!
	 * @param _vehicle - the Vehicle to perform calculations for.
	 * @param _records - a List of gas records for the vehicle.
	 * @param location - the index of the gas record in the list to estimate mileage for.
	 * @return true if initialization was successful, false otherwise. 
	 */
	public static void init(Vehicle _vehicle, List<GasRecord> _records, int location) {
		
		// copy the vehicle data
		vehicle = new Vehicle(_vehicle);
		
 		// copy the records we need from the list 
		// - the first record in the list is the previous full tank
		// - the last record in the list is the record being evaluated
		int fulltank = GasRecordList.findPreviousFullTank(_records, location);
		records = GasRecordList.subList(_records, fulltank, location+1);
		
		// no calculations made yet
		calculation = null;
	}
	
	/**
	 * DESCRIPTION:
	 * Creates an instance of the dialog. Uses the data previously specified
	 * via the init() method.
	 * @param activity - the activity creating the dialog.
	 * @param id - an integer identifying the dialog (meaningful only to the owner).
	 * @return - the Dialog instance.
	 */
	public static Dialog create(final Activity activity, final int id) {
		
		Resources res = App.getContext().getResources();

		// create a custom dialog instance
		final Dialog dialog = new Dialog(activity);
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(R.layout.dialog_mileage_calculation);
        dialog.setCanceledOnTouchOutside(false);
        dialog.setCancelable(true);  // via back key
		
		// get current units of measurement
        Units units = new Units(Settings.KEY_UNITS);
        
        // format the dialog title string
        String title = String.format(
        		res.getString(R.string.title_mileage_estimate),
        		units.getMileageLabel());

        // display the title
		TextView textTitle = (TextView)dialog.findViewById(R.id.textTitle);
		textTitle.setText(Html.fromHtml(title+"<sup><small>*</small></sup>"));

        // display the estimated calculation (or help info if not calculated yet)
		TextView textCalculation = (TextView)dialog.findViewById(R.id.textCalculation);
		String estimate = res.getString(R.string.mileage_estimate_initial);
		if (calculation != null) {
			estimate = getEstimateString(calculation);
		} 
		textCalculation.setText(estimate);
		
        // initialize gauge to reflect 1/2 tank
        GasGauge viewGauge = (GasGauge)dialog.findViewById(R.id.viewGauge);
        viewGauge.setHandTarget(0.5f);
        viewGauge.setInteractive(true);

        // update the estimate when the gauge hand position changes
        viewGauge.setOnHandPositionChangedListener(new GasGauge.OnHandPositionChangedListener() {
			@Override
			public void onHandPositionChanged(GasGauge source, float handPosition) {
				calculation = getEstimateCalculation(handPosition);
				TextView textCalculation = (TextView)dialog.findViewById(R.id.textCalculation);
				textCalculation.setText(getEstimateString(calculation));
			}
		});
        
        // add note indicating that the estimate is based on vehicle tank size
        TextView textNote = (TextView)dialog.findViewById(R.id.textNote);
        if (vehicle == null) {
        	textNote.setText(null);
        } else {
        	// construct the note message string
        	String note = String.format(
        			res.getString(R.string.mileage_estimate_note),
        			vehicle.getTankSizeString(), 
        			units.getLiquidVolumeLabelLowerCase());
        	textNote.setText(Html.fromHtml("<sup><small>*</small></sup><u>" + note + "</u>"));
        
        	// add "tool tip" to the note explaining how to specify tank size
        	CheatSheet.setup(textNote,R.string.mileage_estimate_tanksize_info,Trigger.Click);
        }

        // remove the dialog when the close image is clicked
        ImageView image = (ImageView)dialog.findViewById(R.id.imageCloseDialog);
        image.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
				activity.removeDialog(id);            
			}
        });
        
        // remove the dialog when canceled (via back key)
        dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
			@Override
			public void onCancel(DialogInterface dialog) {
				activity.removeDialog(id);            
			}
        });

        // return the dialog
		return dialog;
	}
	
	/**
	 * DESCRIPTION:
	 * Creates a message String describing a specific mileage calculation.
	 * @param calc - the MileageCalculation. 
	 * @return a String describing the calculation.
	 */
	private static String getEstimateString(MileageCalculation calc) {
		
		Resources res = App.getContext().getResources();
		
		if (calc == null) {
			return res.getString(R.string.mileage_estimate_none);
		}
		
		Units units = calc.getUnits();
		
		String message = 
				String.format(res.getString(R.string.mileage_estimate_drove),
						calc.getDistanceDriven(),
						units.getDistanceLabelLowerCase()) + 
				String.format(res.getString(R.string.mileage_estimate_used),
						calc.getGasolineUsedString(),
						units.getLiquidVolumeLabelLowerCase()) + 
				String.format("%s %s",
						calc.getMileageString(),
						units.getMileageLabel());

		return message;
	}
	
	/**
	 * DESCRIPTION:
	 * Calculates estimated mileage based on a specified gas gauge hand position.
	 * @param position - the gas gauge hand position (0.0 [empty] - 1.0 [full])
	 * @return the estimated MileageCalculation (null = no calculation).
	 */
	private static MileageCalculation getEstimateCalculation(float position) {
		
		// safety net - necessary data should have been initialized before getting here!
		// returning null will result in display of "no calculation" message
		if ((vehicle == null) || (records == null) || (records.size() < 2)) {
			return null;
		}
		
		// calculate how much gas is needed to fill the tank based on current gauge position
		float filltank = vehicle.getTankSize() * (1.0f - position);
		
		// get the record at the end of the list
		int end = records.size() - 1;
		GasRecord record = records.get(end);
		
		// create an estimate reflecting the record with a full tank
		GasRecord estimate = new GasRecord(record);
		estimate.setGallons(record.getGallons() + filltank);
		estimate.setFullTank(true);
		
		// replace saved record with the estimate at the end of the list
		records.set(end,estimate);
		
		// calculate estimated mileage
		GasRecordList.calculateMileage(records);
		
		// restore the real record to the list
		records.set(end,record);
		
		// return the estimated mileage
		return estimate.getCalculation();
	}
	
}
