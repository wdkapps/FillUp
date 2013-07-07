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

import android.app.Dialog;
import android.content.Context;
import android.content.res.Resources;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * A dialog box for entering/editing Vehicle data.
 */
public class VehicleDialog {

	/**
	 * DESCRIPTION:
	 * The activity that creates an instance of this dialog must
	 * implement this interface in order to receive event callbacks.
	 */
	public interface Listener {
		
		/**
		 * DESCRIPTION:
		 * Called when the dialog closes to report the response to the listener.
		 * @param id - the id value specified when the dialog was created.
		 * @param vehicle - the edited vehicle (null = action was canceled).
		 */
		public void onVehicleDialogClosure(int id, Vehicle vehicle);
	}
	
	/**
	 * DESCRIPTION:
	 * Creates an instance of the dialog.
	 * @param context - the Context of the activity/application creating the dialog.
	 * @param listener - a Listener to notify of dialog events.
	 * @param id - an integer identifying the dialog (meaningful only to the owner)
	 * @param vehicle - the Vehicle to edit.
	 * @return the Dialog.
	 */
	public static Dialog create(
			final Context context, 
			final Listener listener, 
			final int id,
			String title,
			final Vehicle vehicle) {
		
		// create a custom dialog instance
		final Dialog dialog = new Dialog(context);
        dialog.setContentView(R.layout.dialog_vehicle);
        dialog.setTitle(title);
        dialog.setCancelable(true);
        
        // update tank size label to reflect current units of measurement
        TextView labelVehicleTankSize = 
        		(TextView)dialog.findViewById(R.id.labelVehicleTankSize);
        Units units = new Units(Settings.KEY_UNITS);
        String format = labelVehicleTankSize.getText().toString();
        String label = String.format(format,units.getLiquidVolumeLabelLowerCase());
        labelVehicleTankSize.setText(label);
        
        // initialize to current vehicle attributes 
    	final EditText textVehicleName = 
    			(EditText)dialog.findViewById(R.id.textVehicleName);
    	final EditText textVehicleTankSize = 
    			(EditText)dialog.findViewById(R.id.textVehicleTankSize);
    	textVehicleName.setText(vehicle.getName());
    	textVehicleTankSize.setText(vehicle.getTankSizeString());

        // define a click listener for the dialog's OK button
        Button buttonOK = (Button)dialog.findViewById(R.id.buttonOK);
        buttonOK.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
            	
            	Resources res = App.getContext().getResources();
            	String message;
            	
            	// validate vehicle name
            	String name = textVehicleName.getText().toString().trim();
            	if (!isValidName(name)) {
            		message = res.getString(R.string.toast_invalid_vehicle_name);
            		Utilities.toast(context,message);
            		return;
            	} 
            	
            	// validate vehicle tank size
            	String tanksize = textVehicleTankSize.getText().toString().trim();
            	if (!isValidTankSize(tanksize)) {
            		message = res.getString(R.string.toast_invalid_vehicle_tank_size);
            		Utilities.toast(context,message);
            		return;
            	} 
            	
            	// valid data - notify listener
            	vehicle.setName(name);
            	vehicle.setTankSize(tanksize);
            	listener.onVehicleDialogClosure(id,vehicle);
            }
        });

        // define a click listener for the dialog's CANCEL button
    	Button buttonCancel = (Button)dialog.findViewById(R.id.buttonCancel);
        buttonCancel.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
            	listener.onVehicleDialogClosure(id,null);
            }
        });
        
        dialog.setCanceledOnTouchOutside(false);

        // return the dialog instance
		return dialog;
	}
	
	/**
	 * DESCRIPTION:
	 * Validates the vehicle name string.
	 * @param name - the vehicle name String to validate.
	 * @return boolean - true = valid.
	 */
	private static boolean isValidName(String name) {

		try {
			Vehicle v = new Vehicle();
			v.setName(name);
		} catch (IllegalArgumentException e) {
			return false;
		}

		return true;
	}
	
	/**
	 * DESCRIPTION:
	 * Validates the vehicle tank size string.
	 * @param tanksize - the vehicle tank size String to validate.
	 * @return boolean - true = valid.
	 */
	private static boolean isValidTankSize(String tanksize) {

		try {
			Vehicle v = new Vehicle();
			v.setTankSize(tanksize);
		} catch (NumberFormatException e) {
			return false;
		}
		
		return true;
	}

}
