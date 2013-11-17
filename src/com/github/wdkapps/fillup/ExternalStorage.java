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

import android.content.Context;
import android.os.Environment;

/**
 * DESCRIPTION:
 * Represents Android device external storage (sdcard).
 */
public class ExternalStorage {

	/**
     * DESCRIPTION:
     * Determine whether external storage (sdcard) is in a 
     * readable state.
     * @return boolean - true = readable
     */
    public static boolean isReadable() {
    	String state = Environment.getExternalStorageState();
    	return (Environment.MEDIA_MOUNTED.equals(state) || 
    			Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)); 
    }

    /**
     * DESCRIPTION:
     * Determine whether external storage (sdcard) is in a 
     * writable state.
     * @return boolean - true = writable
     */
    public static boolean isWritable() {
    	String state = Environment.getExternalStorageState();
    	return Environment.MEDIA_MOUNTED.equals(state);
    }
    
    /**
     * DESCRIPTION:
     * Returns path to the DOWNLOAD_SERVICE directory.
     * @return the path as a Java File instance.
     */
    public static File getPublicDownloadDirectory() {
    	
    	// get path to external storage directory 
    	File dir = Environment.getExternalStoragePublicDirectory(Context.DOWNLOAD_SERVICE);
    	
    	// make sure it exists
    	dir.mkdir();
    	
    	return dir;
    }
    
}
