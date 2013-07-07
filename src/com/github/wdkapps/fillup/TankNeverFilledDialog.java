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
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * A dialog box to inform the user that mileage calculations cannot be performed
 * until a full tank is logged.
 */
public class TankNeverFilledDialog {
	
	/**
	 * DESCRIPTION:
	 * Determines if the dialog can be displayed for a specific set of data.
	 * @param records - the gas records to evaluate.
	 * @return true if the dialog can be displayed, false otherwise. 
	 */
	public static boolean isDisplayable(List<GasRecord> records) {
		return !GasRecordList.hasFullTank(records);
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
        
        // display the text explaining why we cannot calculate mileage
		TextView textCalculation = (TextView)dialog.findViewById(R.id.textCalculation);
		textCalculation.setText(res.getString(R.string.message_tank_never_filled));
		
        // get the gas gauge view from the layout
        GasGauge viewGauge = (GasGauge)dialog.findViewById(R.id.viewGauge);
		
		// create an image of a gas gauge with same layout parameters
		ImageView imageGauge = new ImageView(dialog.getContext());
		imageGauge.setImageDrawable(res.getDrawable(R.drawable.gauge_background_question));
		imageGauge.setLayoutParams(viewGauge.getLayoutParams());
		
        // replace gas gauge view with the image
        ViewGroup parent = (ViewGroup)viewGauge.getParent();
        int index = parent.indexOfChild(viewGauge);
        parent.removeView(viewGauge);
        parent.addView(imageGauge, index);
		
        // remove the note text (not needed)
        TextView textNote = (TextView)dialog.findViewById(R.id.textNote);
        textNote.setText(null);
       
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
	
}
