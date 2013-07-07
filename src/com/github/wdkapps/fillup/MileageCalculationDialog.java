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

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * A dialog box to display mileage calculation information.
 */
public class MileageCalculationDialog {
	
	/// the mileage calculation to display
	private static MileageCalculation calculation;

	/**
	 * DESCRIPTION:
	 * Determines if the dialog can be displayed for a specific set of data.<p>
	 * Data requirements: 
	 * <ul>
	 * <li>The record must have a MileageCalculation instance.
	 * </ul>
	 * @param record - the gas record to display mileage calculation for.
	 * @return true if the dialog can be displayed, false otherwise. 
	 */
	public static boolean isDisplayable(GasRecord record) {
		return record.hasCalculation();
	}
	
	/**
	 * DESCRIPTION:
	 * Initializes the mileage calculation data to display. 
	 * NOTE: Assumes that the dialog isDisplayable() for the specified data!
	 * @param record - the gas record to display mileage calculation for.
	 * @return true if initialization was successful, false otherwise. 
	 */
	public static void init(GasRecord record) {
		calculation = record.getCalculation();
	}
	
	/**
	 * DESCRIPTION:
	 * Creates an instance of the dialog.
	 * @param activity - the activity creating the dialog.
	 * @param id - an integer identifying the dialog (meaningful only to the owner).
	 * @return - the Dialog
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
        		res.getString(R.string.title_mileage_calculation),
        		units.getMileageLabel());

        // display the title
		TextView textTitle = (TextView)dialog.findViewById(R.id.textTitle);
		textTitle.setText(title);
        
        // display the calculation text
		TextView textCalculation = (TextView)dialog.findViewById(R.id.textCalculation);
		textCalculation.setText(getCalculationText(calculation));
		
        // remove the note text (used only for estimates)
        TextView textNote = (TextView)dialog.findViewById(R.id.textNote);
        textNote.setText(null);

        // initialize gauge to reflect full tank
        GasGauge viewGauge = (GasGauge)dialog.findViewById(R.id.viewGauge);
        viewGauge.setHandTarget(1.0f);
        viewGauge.setInteractive(false);
        
        // remove the dialog when the close image is clicked
        ImageView imageCloseDialog = (ImageView)dialog.findViewById(R.id.imageCloseDialog);
        imageCloseDialog.setOnClickListener(new OnClickListener() {
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
	private static String getCalculationText(MileageCalculation calc) {
		
		Resources res = App.getContext().getResources();
		
		if (calc == null) {
			return res.getString(R.string.mileage_calculation_none);
		}
		
		Units units = calc.getUnits();
		
		String message = 
				String.format(res.getString(R.string.mileage_calculation_drove),
						calc.getDistanceDriven(),
						units.getDistanceLabelLowerCase()) + 
				String.format(res.getString(R.string.mileage_calculation_used),
						calc.getGasolineUsedString(),
						units.getLiquidVolumeLabelLowerCase()) + 
				String.format("%s %s",
						calc.getMileageString(),
						units.getMileageLabel());

		return message;
	}
	

}
