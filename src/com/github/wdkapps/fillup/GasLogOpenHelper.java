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

import java.util.LinkedList;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

/**
 * DESCRIPTION:
 * An Android SQLiteOpenHelper for our gas log database.
 */
class GasLogOpenHelper extends SQLiteOpenHelper {
	
	/// tag for logging
	private static final String TAG = GasLogOpenHelper.class.getName();
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasLogOpenHelper.
	 * @param context - the application or activity Context that owns the database.
	 */
	public GasLogOpenHelper(Context context) {
        super(context, GasLog.DATABASE_NAME, null, GasLog.DATABASE_VERSION);
	}

	/**
	 * DESCRIPTION:
	 * Creates the database.
	 * @see android.database.sqlite.SQLiteOpenHelper#onCreate(android.database.sqlite.SQLiteDatabase)
	 */
	@Override
	public void onCreate(SQLiteDatabase db) {
		execSQL(db,GasLog.DATABASE_CREATE);
    }

	/**
	 * DESCRIPTION:
	 * Upgrades the database to a new version.
	 * @see android.database.sqlite.SQLiteOpenHelper#onUpgrade(android.database.sqlite.SQLiteDatabase, int, int)
	 */
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		
		final String tag = TAG + ".onUpgrade()";
		
		Log.d(tag,"oldVersion="+oldVersion+"  newVersion="+newVersion);
		
		LinkedList<String> sql = new LinkedList<String>();
		
		while (oldVersion < newVersion) {
			
			switch (oldVersion) {
			case 2:
				sql.add("ALTER TABLE Records ADD COLUMN hidden integer not null default 0;");
				break;
			
			case 3:
				sql.add("ALTER TABLE Vehicles ADD COLUMN tanksize real not null default 16.0;");
				break;
			
			case 4:
				sql.add("ALTER TABLE Records ADD COLUMN cost real not null default 0.0;");
				sql.add("ALTER TABLE Records ADD COLUMN notes text;");
				break;
			}
			
			oldVersion++;
		}

		try {
			execSQL(db,(String[])sql.toArray(new String[sql.size()]));
		} catch (Throwable t) {
			String message = App.getContext().getString(R.string.toast_database_update_failed);
			Utilities.toast(App.getContext(),message );
			Log.e(tag,message,t);
			execSQL(db,GasLog.DATABASE_DELETE);
			onCreate(db);
		}
	}
	
	/**
	 * DESCRIPTION:
	 * Convenience method to execute an array or SQL command Strings.
	 * @param db - the database.
	 * @param statements - array of SQL statement Strings to execute.
	 */
	private void execSQL(SQLiteDatabase db, String [] statements) {
		final String tag = TAG + ".execSQL()";
		for (String sql : statements) {
			Log.d(tag,sql);
			db.execSQL(sql);
		}
	}

}
