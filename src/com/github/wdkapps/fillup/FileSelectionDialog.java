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
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.view.KeyEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * A dialog to allow selection of one existing file from a specified path.
 * By default the user is only allowed to view files within the specified 
 * path directory or one of it's sub-directories. However, a root path
 * higher in the tree can be specified to allow access elsewhere in
 * the file system. 
 */
public class FileSelectionDialog 
implements AdapterView.OnItemClickListener {

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
		 * @param file - the selected File (null = canceled).
		 */
		public void onFileSelectionDialogResponse(int id, File file);
	}
	
	private Dialog dialog;
	private final Context context;
	private final Listener listener;
	private final int id;
	private File path;
	private File root;
	private final String ext;
	private List<String> filenames = new ArrayList<String>();
	private TextView labelPath;	
	private ListView listview;
	private ArrayAdapter<String> adapter;
	
	/**
	 * DESCRIPTION:
	 * Initializes an instance of FileSelectionDialog.
	 * @param context - the Context of the activity/application creating the dialog.
	 * @param listener - a Listener to notify of dialog events.
	 * @param id - an integer identifying the dialog (meaningful only to the owner).
	 * @param path - a file system path to list contents of. 
	 * @param ext - only display file names having this extension (null = display all file names)
	 */
	public FileSelectionDialog(
			Context context, 
			Listener listener, 
			int id,
			File path,
			String ext)	 {
		this.context = context;
		this.listener = listener;
		this.id = id;
		this.path = new File(path.getAbsolutePath());
		this.root = new File(path.getAbsolutePath());
		this.ext = ext;
	}
	
	/**
	 * DESCRIPTION:
	 * Changes the root to allow traversal above the initial path in the file system
	 * @param root - the new root file system path (assumed to be higher in the tree 
	 * than the initial path location).
	 */
	public void setRoot(File root) {
		this.root = root;
	}
	
	/**
	 * DESCRIPTION:
	 * Creates of the dialog.
	 * @return - the Dialog.
	 */
	public Dialog create() {
		
		Resources res = App.getContext().getResources();

		// create a custom dialog instance
		dialog = new Dialog(context);
        dialog.setContentView(R.layout.dialog_file_selection);
        dialog.setTitle(res.getString(R.string.title_file_selection_dialog));
        dialog.setCanceledOnTouchOutside(false);
        dialog.setCancelable(false);
        
        // save resource instances for future use
        labelPath = (TextView)dialog.findViewById(R.id.labelPath);
    	listview = (ListView)dialog.findViewById(R.id.listviewFiles);

    	// create a string array adapter for the ListView 
    	adapter = new ArrayAdapter<String>(
				dialog.getContext(),android.R.layout.simple_list_item_1,filenames);	
		listview.setAdapter(adapter);

		// listen for ListView selections
        listview.setOnItemClickListener(this);
        
        // listen for cancel button clicks
    	Button buttonCancel = (Button)dialog.findViewById(R.id.buttonCancel);
        buttonCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				// notify listener that dialog has been canceled
				listener.onFileSelectionDialogResponse(id,null);
			}
		});
        
        // treat android back button press like cancel
        dialog.setOnKeyListener(new DialogInterface.OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface arg0, int keyCode, KeyEvent event) {
            	if (keyCode == KeyEvent.KEYCODE_BACK) {
            		// notify listener that dialog has been canceled
            		listener.onFileSelectionDialogResponse(id,null);
                }
                return true;
            }
        });

        // list the contents of the current path
        chooseDirectory(path);

        // return the Dialog instance
		return dialog;
	}
	
	/**
	 * DESCRIPTION:
	 * Callback invoked when an item in the ListView has been clicked.
	 * @see android.widget.AdapterView.OnItemClickListener#onItemClick(android.widget.AdapterView, android.view.View, int, long)
	 */
	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
		String filename = (String)listview.getItemAtPosition(position);
		File file = new File(path,filename);
		if (filename.equals("../")) {
			chooseDirectory(path.getParentFile());
		} else if (filename.endsWith("/")) {
			chooseDirectory(file);
		} else if (file.isFile()) {
			listener.onFileSelectionDialogResponse(this.id,file);
		}
	}
	
	/**
	 * DESCRIPTION:
	 * Selects a new path location and updates the displayed list of files
	 * to reflect the content of that directory.
	 * @param destination - the new path location.
	 */
	protected void chooseDirectory(File destination) {

		// update the path location
		path = destination;
        labelPath.setText(path.getAbsolutePath());
		
        // filter to list directories
		FilenameFilter filterDirsOnly = new FilenameFilter() {
            public boolean accept(File dir, String filename) {
                File file = new File(dir, filename);
                return file.isDirectory();
            }
        };
        
        // filter to list files
		FilenameFilter filterFilesOnly = new FilenameFilter() {
            public boolean accept(File dir, String filename) {
                File file = new File(dir, filename);
            	if ((ext != null) && !filename.endsWith(ext))
            		return false;
                return file.isFile();
            }
        };
        		
        // clear contents of the list
		filenames.clear();
		
		// if not at root, allow to traverse to parent directory
		if (!path.equals(root) && (path.getParentFile() != null)) {
			filenames.add("../");
		}
		
		// get arrays of directories and files at path location
		String[] dirs = path.list(filterDirsOnly);
		String[] files = path.list(filterFilesOnly);
		
		// add directories to the list, sorted by name
		if (dirs != null) {
			Arrays.sort(dirs);
			for (String dir : dirs) {
				filenames.add(dir + "/");
			}
		}

		// add files to the list, sorted by name
		if (files != null) {
			Arrays.sort(files);
			for (String file : files) {
				filenames.add(file);
			}
		}
		
		// tell ListView that the list has changed
		adapter.notifyDataSetChanged();
	}

}
