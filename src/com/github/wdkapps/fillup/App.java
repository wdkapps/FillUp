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

import java.util.Locale;

import android.app.Application;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.util.Log;

/**
 * DESCRIPTION:
 * Convenience class to simplify access to application attributes.
 * NOTE: requires setting the android:name attribute of the <application> 
 * tag in the AndroidManifest.xml to point to this class, 
 * e.g. android:name=".App".
 */
public class App extends Application {
	
	/// tag string for logging
	private static final String TAG = App.class.getSimpleName();
	
    /// the application context instance
    private static Context mContext;

    /**
     * DESCRIPTION:
     * Called when the application starts.
     * @see android.app.Application#onCreate()
     */
    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;
    }

    /**
     * DESCRIPTION:
     * Returns the Context for this application instance.
     * @return the application Context.
     */
    public static Context getContext(){
        return mContext;
    }
    
    /**
     * DESCRIPTION:
     * Returns the Locale that the user has configured the device for.
     * @return the current Locale.
     */
    public static Locale getLocale() {
    	return mContext.getResources().getConfiguration().locale;
    }
    
    /**
     * DESCRIPTION:
     * Returns the Android versionCode for the application.
     * @return the version code integer value (-1 if an error occurred)
     */
    public static int getVersionCode() {
    	String pkgname = mContext.getPackageName();
    	PackageManager pkgmgr = mContext.getPackageManager();
    	int versionCode = -1;
		try {
			PackageInfo info = pkgmgr.getPackageInfo(pkgname, 0);
			versionCode = info.versionCode;
		} catch (NameNotFoundException e) {
			Log.e(TAG,"getVersionCode()",e);
		}
    	return versionCode;
    }
    
    /**
     * DESCRIPTION:
     * Determine if the update.html file exists in the jar (apk).
     * @return true if update.html exists.
     */
    public static boolean existsUpdateHtml() {
    	String res_update_html = mContext.getString(R.string.res_update_html); 
		if (mContext.getClass().getClassLoader().getResource(res_update_html) == null) {
			return false;
		} else {
			return true;
		}
    }
    
}
