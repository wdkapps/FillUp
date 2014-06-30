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

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * An Activity to allow selection of one existing file from a specified path.
 * @param ROOT - the root path as a String.
 * @param PATH - the path to display contents of as a String (at or below ROOT)
 * @param EXT - only display file names with this extension (null = display all files)
 */
public class FileSelectionActivity extends Activity implements AdapterView.OnItemClickListener {
	
	/// Intent parameter keys
	public final static String ROOT = FileSelectionActivity.class.getName() + ".ROOT";
	public final static String PATH = FileSelectionActivity.class.getName() + ".PATH";
	public final static String EXT = FileSelectionActivity.class.getName() + ".EXT";
	
	/// the ListView adapter
	private FileSelectionListAdapter adapter;
	
	/// the ListView of files and folders
	private ListView listview;
	
	/// a List of Java File instances representing the contents at the current path
	private final List<File> filelist = new ArrayList<File>();
	
	/// a TextView to display the current path
	private TextView textviewPath;
	
	/// the root path
	private File root;
	
	/// the currently displayed path
	private File path;
	
	/// file name extension to display (null = display all)
	private String ext;

	/**
	 * DESCRIPTION
	 * Called when the activity is starting. 
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_file_selection);
		
        // get parameters 
		Intent intent = getIntent();
        root = new File(intent.getStringExtra(ROOT));
        ext = intent.getStringExtra(EXT);
        if (ext != null) ext = ext.toLowerCase(App.getLocale());
        if (savedInstanceState == null) {
        	path = new File(intent.getStringExtra(PATH));
        } else {
        	path = new File(savedInstanceState.getString(PATH));
        }
		
        // get our views
		textviewPath = (TextView)findViewById(R.id.textviewPath);
		listview = (ListView)findViewById(R.id.listviewFiles);
		
		// configure the ListView
		adapter = new FileSelectionListAdapter(this,filelist);
		listview.setAdapter(adapter);
        listview.setOnItemClickListener(this);
		
        // display contents at the specified path
		chooseDirectory(path);
	}

	/**
	 * DESCRIPTION
	 * Called the first time the options menu is displayed in order to initialize 
	 * the contents of the Activity's standard options menu. 
	 * @return true for the menu to be displayed; false it will not be shown.
	 * @see android.app.Activity#onCreateOptionsMenu(android.view.Menu)
	 */
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		return false;
	}
	
	/**
	 * DESCRIPTION
	 * Called to retrieve per-instance state from an activity before being killed so that the 
	 * state can be restored.
	 * @see android.app.Activity#onSaveInstanceState(android.os.Bundle)
	 */
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
        outState.putString(PATH, path.getAbsolutePath());
	}

	/**
	 * DESCRIPTION:
	 * Selects a new path location and updates the displayed list of files
	 * to reflect the content of that directory.
	 * @param destination - the new path location.
	 */
	private void chooseDirectory(File destination) {

		// update the path location
		path = destination;
        textviewPath.setText(path.getAbsolutePath());
		
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
            	if ((ext != null) && !filename.toLowerCase(App.getLocale()).endsWith(ext))
            		return false;
                return file.isFile();
            }
        };
        
        // clear contents of the list
		filelist.clear();
		
		// if not at root, allow to traverse to parent directory
		if (!path.equals(root) && (path.getParentFile() != null)) {
			filelist.add(new File(path,".."));
		}
		
		// get arrays of directories and files at path location
		String[] dirs = path.list(filterDirsOnly);
		String[] files = path.list(filterFilesOnly);
		
		// add directories to the file list, sorted by name
		if (dirs != null) {
			Arrays.sort(dirs,new ComparatorIgnoreCase());
			for (String dir : dirs) {
				filelist.add(new File(path,dir));
			}
		}

		// add files to the file list, sorted by name
		if (files != null) {
			Arrays.sort(files,new ComparatorIgnoreCase());
			for (String file : files) {
				filelist.add(new File(path,file));
			}
		}
		
		// tell ListView that the file list has changed
		adapter.notifyDataSetChanged();
	}

	/**
	 * DESCRIPTION:
	 * Callback invoked when an item in the ListView has been clicked.
	 * @see android.widget.AdapterView.OnItemClickListener#onItemClick(android.widget.AdapterView, android.view.View, int, long)
	 */
	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
		File file = (File)listview.getItemAtPosition(position);
		if (file.getName().equals("..")) {
			chooseDirectory(path.getParentFile());
		} else if (file.isDirectory()) {
			chooseDirectory(file);
		} else if (file.isFile()) {
			finishWithResult(file);
		}
	}
	
    /**
     * DESCRIPTION
     * Finish this Activity with a result code and URI of the selected file.
     * @param file The file selected (null = canceled)
     */
    private void finishWithResult(File file) {
        if (file != null) {
            Uri uri = Uri.fromFile(file);
            setResult(RESULT_OK, new Intent().setData(uri));
            finish();
        } else {
            setResult(RESULT_CANCELED);
            finish();
        }
    }
    
    /**
     * DESCRIPTION:
     * Comparator class to compare two Strings ignoring case.
     */
    private class ComparatorIgnoreCase implements Comparator<String> {
    	@Override
        public int compare(String s1, String s2) {
            return s1.compareToIgnoreCase(s2);
        }
    }

}
