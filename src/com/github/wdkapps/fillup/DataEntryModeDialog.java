/*
 * *****************************************************************************
 * Copyright 2014 William D. Kraemer
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
 * A dialog allowing a user to select preferred data entry mode.
 */
public class DataEntryModeDialog {
	
	protected final static String TAG = DataEntryModeDialog.class.getName();
	
	/// a result code to be returned to the listener
	enum Result {RESULT_SELECTED, RESULT_CANCEL};
	
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
         * @param result - the result of the action
         */
        public void onDataEntryModeDialogResponse(int id, Result result);
    }
    
    /**
     * DESCRIPTION:
     * Creates an instance of the dialog.
     * @param context - the Context of the activity/application creating the dialog.
     * @param listener - a Listener to notify of dialog events.
     * @param id - an integer identifying the dialog (meaningful only to the owner).
     * @param mode - the current DataEntryMode
     * @return - the Dialog.
     */
    public static Dialog create(
    		Context context, 
    		final Listener listener, 
    		final int id,
    		final DataEntryMode mode) {

    	final Resources res = context.getResources();
    	
        Dialog dialog;
    	
        // Build the dialog and set up the click handlers
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder
        .setTitle(R.string.title_data_entry_mode_dialog)
        .setIcon(res.getDrawable(R.drawable.ic_dialog_menu_generic))
        .setSingleChoiceItems(R.array.arrayDataEntryModeEntries, mode.getValue(), new DialogInterface.OnClickListener() {
        	public void onClick(DialogInterface dialog, int which) {
        		String[] values = res.getStringArray(R.array.arrayDataEntryModeValues);
        		if ((which < 0) || (which >= values.length)) which = 0;
        		Settings.setString(mode.getKey(),values[which]);
        		listener.onDataEntryModeDialogResponse(id,Result.RESULT_SELECTED);
                dialog.dismiss();
        	}
        });
        
        // require user selection
        dialog = builder.create();
        dialog.setCanceledOnTouchOutside(false);

        dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
			@Override
			public void onCancel(DialogInterface dialog) {
                listener.onDataEntryModeDialogResponse(id,Result.RESULT_CANCEL);
			}
		}); 

        // return the dialog
        return dialog;
    }

}
