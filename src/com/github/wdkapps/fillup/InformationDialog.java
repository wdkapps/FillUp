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
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.res.Resources;

/**
 * DESCRIPTION:
 * A general purpose dialog to use for displaying an informative message.
 * The only operator response is "OK".
 */
public class InformationDialog {
	
	/**
	 * DESCRIPTION:
	 * Creates an instance of the dialog.
	 * @param activity - the activity creating the dialog.
	 * @param id - an integer identifying the dialog (meaningful only to the owner).
	 * @param title - the title String to display.
	 * @param message - the message String to display.
	 * @return - the Dialog instance.
	 */
	public static Dialog create(
			final Activity activity, 
			final int id,
			String title,
			String message) {
		
    	Resources res = App.getContext().getResources();

        // Build the dialog and set up the button click handlers
		String ok_label = res.getString(R.string.ok_label);
        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        builder.setTitle(title)
               .setIcon(res.getDrawable(R.drawable.ic_dialog_info))
               .setMessage(message)
               .setPositiveButton(ok_label, new DialogInterface.OnClickListener() {
                   public void onClick(DialogInterface dialog, int which) {
                	   activity.removeDialog(id);
                   }
               });

        Dialog dialog = builder.create();
        dialog.setCanceledOnTouchOutside(false);
        
        return dialog;
    }

}
