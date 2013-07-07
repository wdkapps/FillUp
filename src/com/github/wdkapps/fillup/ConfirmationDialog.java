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

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.Resources;

/**
 * DESCRIPTION:
 * A general purpose dialog to use for confirmation of program actions.
 */
public class ConfirmationDialog {
	
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
         * @param confirmed - boolean indicating result (true = confirmed).
         */
        public void onConfirmationDialogResponse(int id, boolean confirmed);
    }
    
    /**
     * DESCRIPTION:
     * Creates an instance of the dialog.
     * @param context - the Context of the activity/application creating the dialog.
     * @param listener - a Listener to notify of dialog events.
     * @param id - an integer identifying the dialog (meaningful only to the owner).
	 * @param title - the title String to display.
	 * @param message - the message String to display.
     * @return - the Dialog.
     */
    public static Dialog create(
    		Context context, 
    		final Listener listener, 
    		final int id,
    		String title,
    		String message) {
    	
    	Resources res = App.getContext().getResources();

        // Build the dialog and set up the button click handlers
    	String yes_label = res.getString(R.string.yes_label);
    	String no_label = res.getString(R.string.no_label);
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setMessage(message)
               .setTitle(title)
               .setIcon(res.getDrawable(R.drawable.ic_dialog_alert))
               .setPositiveButton(yes_label,new DialogInterface.OnClickListener() {
            	   public void onClick(DialogInterface dialog, int which) {
            		   listener.onConfirmationDialogResponse(id,true);
            	   }
               })
               .setNegativeButton(no_label, new DialogInterface.OnClickListener() {
                   public void onClick(DialogInterface dialog, int which) {
                       listener.onConfirmationDialogResponse(id,false);
                   }
               });
        
        Dialog dialog = builder.create();
        dialog.setCanceledOnTouchOutside(false);

        return dialog;
    }

}
