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
import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * DESCRIPTION:
 * An Android ArrayAdapter for the purpose of displaying a list
 * of Java File instances.
 */
public class FileSelectionListAdapter extends ArrayAdapter<File>{
	
	/// instance of LayoutInflator for creating rows
	private final LayoutInflater inflater;
	
	/// a list of Java File instances for display 
	private final List<File> files;

	/**
	 * DESCRIPTION:
	 * Constructs an instance of FileSelectionListAdapter.
	 * @param context - Context for owner of this adapter.
	 * @param files - List of Java File instances being displayed.
	 */
	public FileSelectionListAdapter(Context context, List<File> files) {
		super(context, R.layout.row_file_selection, files);
	    this.inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	    this.files = files;
	}
	
	/**
	 * DESCRIPTION:
	 * Constructs and populates a View for display of the File at the index
	 * of the List specified by the position parameter.
	 * @see android.widget.ArrayAdapter#getView(int, android.view.View, android.view.ViewGroup)
	 */
	@Override
	public View getView(int position, View view, ViewGroup parent) {
		
		// create a view for the row if it doesn't already exist
		if (view == null) {
			view = inflater.inflate(R.layout.row_file_selection,null);
		} 
		
		// get widgets from the view
		ImageView icon = (ImageView)view.findViewById(R.id.imageviewIcon);
		TextView label = (TextView)view.findViewById(R.id.textviewLabel);
		
		// display icon and label for this Java File
		File file = files.get(position);
		icon.setImageResource(file.isDirectory() ? R.drawable.ic_folder : R.drawable.ic_file);
		label.setText(file.getName());
		
		// return the created/populated view
		return view;
	}

}
