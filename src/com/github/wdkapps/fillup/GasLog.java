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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteConstraintException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.util.Log;

/**
 * DESCRIPTION:
 * Implements an abstract log for the storage of gasoline records. Provides 
 * CRUD methods to create, read, update, and delete gasoline records from 
 * the log. The underlying storage mechanism is an SQLite database.
 */
public class GasLog {
	
    /// singleton instance
    private static GasLog instance;
    
	/// a tag string for debug logging (the name of this class)
	private static final String TAG = GasLog.class.getName();
	
    /// database table names
	private static final String VEHICLES_TABLE = "Vehicles";
    private static final String RECORDS_TABLE = "Records";

    /// column names for RECORDS_TABLE
    private static final String RECORD_ID = "_id";
    private static final String RECORD_VEHICLE_ID = "_vid";
    private static final String RECORD_TIME = "time";
    private static final String RECORD_ODOMETER = "odometer";
    private static final String RECORD_GALLONS = "gallons";
    private static final String RECORD_FULLTANK = "fulltank";
    private static final String RECORD_HIDDEN = "hidden";
    private static final String RECORD_COST = "cost";
    private static final String RECORD_NOTES = "notes";
    
    
    // column names for VEHICLE_TABLE
    private static final String VEHICLE_ID = "_id";
    private static final String VEHICLE_NAME = "name";
    private static final String VEHICLE_TANK_SIZE="tanksize";

    /// array of all column names for VEHICLES_TABLE 
    private static final String[] VEHICLES_TABLE_COLUMNS = 
    		new String[] {VEHICLE_ID, VEHICLE_NAME, VEHICLE_TANK_SIZE};
    
    /// array of all column names for RECORDS_TABLE 
    private static final String[] RECORDS_TABLE_COLUMNS = new String[] {
    	RECORD_ID,
    	RECORD_VEHICLE_ID,
    	RECORD_TIME,RECORD_ODOMETER,
    	RECORD_GALLONS,
    	RECORD_FULLTANK,
    	RECORD_HIDDEN,
    	RECORD_COST,
    	RECORD_NOTES
    };
    
    /// SQL commands to create the database
    public static final String[] DATABASE_CREATE = new String[] {

    	"create table " + VEHICLES_TABLE + " ( " + 
    			VEHICLE_ID          + " integer primary key autoincrement, " + 
    			VEHICLE_NAME        + " text not null unique, " + 
    			VEHICLE_TANK_SIZE   + " real not null); ",

		"create table " + RECORDS_TABLE + " ( " + 
    			RECORD_ID           + " integer primary key autoincrement, " + 
    			RECORD_VEHICLE_ID   + " integer not null, " +
    			RECORD_TIME         + " integer not null, " +
    			RECORD_ODOMETER     + " integer not null, " + 
    			RECORD_GALLONS      + " real not null, " + 
    			RECORD_FULLTANK     + " integer not null, " +
    			RECORD_HIDDEN       + " integer not null default 0, " +
    			RECORD_COST         + " real not null default 0, " +
    			RECORD_NOTES        + " text, " +
    			"unique ("+RECORD_VEHICLE_ID+","+RECORD_ODOMETER+"), " + 
    			"foreign key ("+RECORD_VEHICLE_ID+") references "+VEHICLES_TABLE+" ("+VEHICLE_ID+"));"
    };
    
    /// SQL commands to delete the database
    public static final String[] DATABASE_DELETE = new String[] {
    	"drop table if exists " + RECORDS_TABLE + ";",
    	"drop table if exists " + VEHICLES_TABLE + ";"
    };
    
	/// the name of the database
	public static final String DATABASE_NAME = "gaslog.db";
	
	/// the database version number 
    public static final int DATABASE_VERSION = 5;

    /// context of the instance creator
    private final Context context;
    
    /// a helper instance used to open and close the database 
    private final GasLogOpenHelper helper;
    
    /// the database
    private final SQLiteDatabase db;
    
    /**
     * DESCRIPTION:
     * Determines if the log database file currently exists.
     * @return true if file exists, false otherwise.
     */
    public static boolean exists() {
        File dbFile = App.getContext().getDatabasePath(DATABASE_NAME);
        return dbFile.exists();
    }
    
    /**
     * DESCRIPTION:
     * Returns a single instance, creating it if necessary.
     * @return GasLog - singleton instance.
     */
    public static GasLog getInstance() {
    	if (instance == null) {
            instance = new GasLog();
    	}
    	return instance;
    }
    
    /**
     * DESCRIPTION:
     * Destroys any existing log instance, closing the database.
     */
    public void finalize() throws Throwable {
    	if (instance != null) {
    		instance.helper.close();
    		instance = null;
    	}
        super.finalize();
    }
    
    /**
     * DESCRIPTION:
     * Constructs an instance of GasLog (private to enforce singleton).
     */
    private GasLog() {
    	this.context = App.getContext();
        this.helper = new GasLogOpenHelper(this.context);
        this.db = helper.getWritableDatabase();
    }
    
    /**
     * DESCRIPTION:
     * Returns the database version number reported by SQLite. 
     * @return the database version.
     */
    public int getDatabaseVersion() {
    	return db.getVersion();
    }
    
    /**
     * DESCRIPTION:
     * Convenience method to test assertion.
     * @param assertion - an asserted boolean condition. 
     * @param tag - a tag String identifying the calling method.
     * @param mdg - an error message to display/log.
     * @throws RuntimeException if the assertion is false
     */
    private void ASSERT(boolean assertion, String tag, String msg) {
    	if (!assertion) {
    		String assert_msg = "ASSERT failed: " + msg;
    		Log.e(tag,assert_msg);
    		throw new RuntimeException(assert_msg);
    	}
    }

    /**
     * DESCRIPTION:
     * Convenience method to convert a GasRecord instance to a set of key/value
     * pairs in a ContentValues instance utilized by SQLite access methods.
     *
     * @param record - the GasRecord to convert.
     * @return a ContentValues instance representing the specified GasRecord.
     */
    private ContentValues getContentValues(GasRecord record) {
    	ContentValues values = new ContentValues();
    	values.put(RECORD_ID, record.getID());
    	values.put(RECORD_VEHICLE_ID, record.getVehicleID());
    	values.put(RECORD_TIME, record.getDate().getTime());
    	values.put(RECORD_ODOMETER,record.getOdometer());
    	values.put(RECORD_GALLONS, record.getGallons());
    	values.put(RECORD_FULLTANK, record.isFullTank());
    	values.put(RECORD_HIDDEN, record.isCalculationHidden());
    	values.put(RECORD_COST, record.getCost());
    	values.put(RECORD_NOTES, record.getNotes());
    	return values;
    }
    
    /**
     * DESCRIPTION:
     * Convenience method to convert a Vehicle instance to a set of key/value
     * pairs in a ContentValues instance utilized by SQLite access methods.
     *
     * @param vehicle - the Vehicle to convert.
     * @return a ContentValues instance representing the specified Vehicle.
     */
    private ContentValues getContentValues(Vehicle vehicle) {
    	ContentValues values = new ContentValues();
    	values.put(VEHICLE_ID, vehicle.getID());
    	values.put(VEHICLE_NAME, vehicle.getName());
    	values.put(VEHICLE_TANK_SIZE, vehicle.getTankSize());
    	return values;
    }
    
    /**
     * DESCRIPTION:
     * Convenience method to create a GasRecord instance from values read
     * from the database.
     * @param c - a Cursor containing results of a database query. 
     * @return a GasRecord instance (null if no data).
     */
    private GasRecord getRecordFromCursor(Cursor c) {
    	final String tag = TAG+".getRecordFromCursor()";
    	GasRecord record = null;
    	if (c != null) {
    		int id = c.getInt(c.getColumnIndex(RECORD_ID));
    		int vid = c.getInt(c.getColumnIndex(RECORD_VEHICLE_ID));
    		long time = c.getLong(c.getColumnIndex(RECORD_TIME));
    		int odometer = c.getInt(c.getColumnIndex(RECORD_ODOMETER));
    		float gallons = c.getFloat(c.getColumnIndex(RECORD_GALLONS));
    		int fulltank = c.getInt(c.getColumnIndex(RECORD_FULLTANK));
    		int hidden = c.getInt(c.getColumnIndex(RECORD_HIDDEN));
    		double cost = c.getDouble(c.getColumnIndex(RECORD_COST));
    		String notes = c.getString(c.getColumnIndex(RECORD_NOTES));
    		
    		record = new GasRecord();
    		record.setID(id);
    		record.setVehicleID(vid);
    		record.setDate(new Date(time));
    		record.setOdometer(odometer);
    		record.setGallons(gallons);
    		record.setFullTank(fulltank == 1);
    		record.setHiddenCalculation(hidden == 1);
    		record.setCost(cost);
    		record.setNotes(notes);
    		
    		try {
    			record.calculatePrice();
    		} catch (NumberFormatException e) {
    			Log.e(tag,e.getMessage());
    		}
    	}
    	return record;
    }

    /**
     * DESCRIPTION:
     * Convenience method to create a Vehicle instance from values read
     * from the database.
     * @param c - a Cursor containing results of a database query. 
     * @return a Vehicle instance (null if no data).
     */
    private Vehicle getVehicleFromCursor(Cursor c) {
    	Vehicle vehicle = null;
    	if (c != null) {
    		vehicle = new Vehicle();
    		int id = c.getInt(c.getColumnIndex(VEHICLE_ID));
    		String name = c.getString(c.getColumnIndex(VEHICLE_NAME));
    		float tanksize = c.getFloat(c.getColumnIndex(VEHICLE_TANK_SIZE));
    		vehicle.setID(id);
    		vehicle.setName(name);
    		vehicle.setTankSize(tanksize);
    	}
    	return vehicle;
    }
    
    /**
     * DESCRIPTION:
     * Creates a vehicle in the log.
     * @param vehicle - the Vehicle to create.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean createVehicle(Vehicle vehicle) {
    	final String tag = TAG+".createVehicle()";
    	ASSERT((vehicle.getID() == null),tag,"vehicle id must be null");
    	boolean success = false;
    	try {
    		long rowID = db.insertOrThrow(VEHICLES_TABLE, null, getContentValues(vehicle));
   			vehicle.setID((int)rowID);
   			success = (rowID != -1);
    	} catch (SQLiteConstraintException e) {
    		Log.e(tag,"SQLiteConstraintException: "+e.getMessage());
    		Utilities.toast(context,context.getString(R.string.toast_duplicate_vehicle_name));
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	}
    	return success;
    }
    
    /**
     * DESCRIPTION:
     * Updates a vehicle in the log.
     * @param vehicle - the Vehicle to update.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean updateVehicle(Vehicle vehicle) {
    	final String tag = TAG+".updateVehicle()";
		ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");
		boolean success = false;
		try {
			ContentValues values = getContentValues(vehicle);
			values.remove(VEHICLE_ID);
			String whereClause = VEHICLE_ID + "=" + vehicle.getID();
			int count = db.update(VEHICLES_TABLE,values,whereClause,null);
			success = (count != 0);
		} catch (SQLiteConstraintException e) {
			Log.e(tag,"SQLiteConstraintException: "+e.getMessage());
			Utilities.toast(context,context.getString(R.string.toast_duplicate_vehicle_name));
		} catch (SQLException e) {
			Log.e(tag,"SQLException: "+e.getMessage());
		}
		return success;
    }
    
    /**
     * DESCRIPTION:
     * Reads all vehicles contained in the log.
     * @return a List of all Vehicle's in the log (empty if none exist).
     */
    public List<Vehicle> readAllVehicles() {
    	final String tag = TAG+".readAllVehicles()";
    	List<Vehicle> list = new ArrayList<Vehicle>();
    	Cursor cursor = null;
    	try {
    		// SELECT * FROM Vehicles ORDER BY name;
    		String orderBy = VEHICLE_NAME;
    		cursor = db.query(
    				VEHICLES_TABLE, 
    				VEHICLES_TABLE_COLUMNS,
    				null,null,null,null,
    				orderBy,
    				null
    				);

    		// create a list of Vehicle instances from the data
    		if (cursor != null) {
    			if (cursor.moveToFirst()) {
    				do {
    					Vehicle vehicle = getVehicleFromCursor(cursor);
    					list.add(vehicle);
    				} while (cursor.moveToNext());
    			}
    		}
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    		list.clear();
    	} finally {
    		if (cursor != null) cursor.close();
    	}

    	// return the list of Vehicles
    	return list;
    }
    
    /**
     * DESCRIPTION:
     * Deletes a specified vehicle from the log.
     * @param vehicle - the Vehicle to delete.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean deleteVehicle(Vehicle vehicle) {
    	final String tag = TAG+".deleteVehicle()";
		ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");
    	
		boolean success = false;
		
    	// delete all records for the vehicle
    	if (!deleteAllRecords(vehicle)) {
    		return false;
    	}
    	
    	// delete the vehicle
    	try {
    		String whereClause = VEHICLE_ID + "=" + vehicle.getID();
    		String [] whereArgs = null;
    		int count = db.delete(VEHICLES_TABLE, whereClause, whereArgs);
    		success = (count == 1);
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	} 
    	
    	return success;
    }
    
    /**
     * DESCRIPTION:
     * Determines the current odometer value in the log for a specific vehicle.
     * @param vehicle - the Vehicle being evaluated.
     * @return the current odometer value (int) in the log for the vehicle. (-1 if no data)
     */
    public int readCurrentOdometer(Vehicle vehicle) {
    	final String tag = TAG+".readCurrentOdometer()";
    	ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");

    	int value = -1;
    	
    	Cursor cursor = null;

    	try {
    		// query the database for maximum value of the odometer column
    		final String MAX_ODOMETER = "MAX(" + RECORD_ODOMETER + ")";
    		final String[] columns = new String[] {MAX_ODOMETER};
    		String selection = RECORD_VEHICLE_ID + "=" + vehicle.getID();
    		cursor = db.query(
    				RECORDS_TABLE, 
    				columns,
    				selection, 
    				null, null, null, null);

    		// get the value from the query results 
    		if (cursor != null) {
    			if (cursor.moveToFirst()) {
    				do {
    					value = cursor.getInt(cursor.getColumnIndex(MAX_ODOMETER));
    				} while (cursor.moveToNext());
    			}
    		}
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	} finally {
    		if (cursor != null) cursor.close();
    	}

		// return the value
		return value;
    }
    
    /**
     * DESCRIPTION:
     * Creates a gasoline record in the log.
     * @param record - the GasRecord to create.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean createRecord(Vehicle vehicle, GasRecord record) {
    	final String tag = TAG+".createRecord()";
    	ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");
    	ASSERT((record.getID() == null),tag,"record id must be null");
    	boolean success = false;
    	record.setVehicleID(vehicle.getID());
    	try {
    		long rowID = db.insertOrThrow(RECORDS_TABLE, null, getContentValues(record));
    		record.setID((int)rowID);
    		success = true;
    	} catch (SQLiteConstraintException e) {
    		Log.e(tag,"SQLiteConstraintException: "+e.getMessage());
    		Utilities.toast(context,context.getString(R.string.toast_duplicate_odometer_value));
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	}
    	
    	return success;
    }    	
    
    /**
     * DESCRIPTION:
     * Updates a gasoline record in the log.
     * @param record - the GasRecord to update.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean updateRecord(GasRecord record) {
    	final String tag = TAG+".updateRecord()";
		ASSERT((record.getID() != null),tag,"record id cannot be null");
    	boolean success = false;
    	try {
        	ContentValues values = getContentValues(record);
        	values.remove(RECORD_ID);
        	String whereClause = RECORD_ID + "=" + record.getID();
    		int count = db.update(RECORDS_TABLE,values,whereClause,null);
    		success = (count > 0);
    	} catch (SQLiteConstraintException e) {
    		Log.e(tag,"SQLiteConstraintException: "+e.getMessage());
    		Utilities.toast(context,context.getString(R.string.toast_duplicate_odometer_value));
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	}
    	return success;
    }
    
    /**
     * DESCRIPTION:
     * Reads all gasoline records contained in the log for a specific vehicle.
     * @param vehicle - the Vehicle to read the records for. 
     * @return a List of all GasRecord's in the log for the vehicle (empty if none exist).
     */
    public List<GasRecord> readAllRecords(Vehicle vehicle) {
       	final String tag = TAG+".readAllRecords()";
		ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");

		List<GasRecord> list = new ArrayList<GasRecord>();
		
		Cursor cursor = null;

		try {
			// SELECT * FROM Records WHERE vid=vehicle.getID() ORDER BY odometer;
			String orderBy = RECORD_ODOMETER;
			String selection = RECORD_VEHICLE_ID + "=" + vehicle.getID();
			cursor = db.query(
					RECORDS_TABLE, 
					RECORDS_TABLE_COLUMNS,
					selection,
					null,null,null,
					orderBy,
					null
					);

			// create a list of GasRecords from the data
			if (cursor != null) {
				if (cursor.moveToFirst()) {
					do {
						GasRecord record = getRecordFromCursor(cursor);
						list.add(record);
					} while (cursor.moveToNext());
				}
			}

			// calculate mileage based on the data
			GasRecordList.calculateMileage(list);
			
		} catch (SQLException e) {
			Log.e(tag,"SQLException: "+e.getMessage());
			list.clear();
		} finally {
			if (cursor != null) cursor.close();
		}

		// return the list of GasRecords
    	return list;
    }
    
    /**
     * DESCRIPTION:
     * Deletes a specified gasoline record from the log.
     * @param record - the GasRecord to delete.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean deleteRecord(GasRecord record) {

    	final String tag = TAG+".deleteRecord()";
    	
		ASSERT((record.getID() != null),tag,"record id cannot be null");
		
    	boolean success = false;
    	
    	try {
        	String whereClause = RECORD_ID + "=" + record.getID();
        	String [] whereArgs = null;
        	int count = db.delete(RECORDS_TABLE, whereClause, whereArgs);
    		success = (count == 1);
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	}
    	
    	return success;
    }

    /**
     * DESCRIPTION:
     * Deletes all gasoline records from the log for a specific vehicle.
     * @param vehicle - the Vehicle to delete records for.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean deleteAllRecords(Vehicle vehicle) {
    	final String tag = TAG+".deleteAllRecords()";
    	ASSERT((vehicle.getID() != null),tag,"vehicle id cannot be null");
    	boolean success = false;
    	try {
    		String whereClause = RECORD_VEHICLE_ID + "=" + vehicle.getID();
    		String [] whereArgs = null;
    		db.delete(RECORDS_TABLE, whereClause, whereArgs);
    		success = true;
    	} catch (SQLException e) {
    		Log.e(tag,"SQLException: "+e.getMessage());
    	}
    	
    	return success;
    }
    
    /**
     * DESCRIPTION:
     * Reads gasoline record data from a specified ASCII CSV formatted file
     * into the log for a specific vehicle. 
     * @param vehicle - the Vehicle to import records for.
     * @param file - the ASCII CSV data file to import.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean importData(Vehicle vehicle, InputStream file) {
    	
    	final String tag = TAG+".importData()";
    	
    	boolean success = false;
    	
    	db.beginTransaction();
    	
		int num = 0;
    	BufferedReader reader = null;
    	try {
    		reader = new BufferedReader(new InputStreamReader(file));
    		
    		String line;
    		do {
    			line = reader.readLine();
    			num++;
    			if (line != null) {
    				GasRecord record = new GasRecord(line);
    				if (!createRecord(vehicle,record)) {
    					throw new SQLiteException("create failed");
    				}
    			}
    		} while (line != null);
    		
    		success = true;
    		db.setTransactionSuccessful();
    		
    	} catch(Throwable t) {
    		Log.e(tag,"import failed",t);
    		String format = context.getString(R.string.toast_stopped_at_csv_line);
    		Utilities.toast(context, String.format(format,num));
    	} finally {
    		db.endTransaction();
    		if (reader != null) { 
    			try {
    				reader.close();
    			} catch (IOException e) {
    				Log.e(tag,"close() failed",e);
    			}
    		}
    	}
    	
    	return success;
    }
    
    /**
     * DESCRIPTION:
     * Copies all existing log data for a specific vehicle to an ASCII CSV file.
     * @param vehicle - the Vehicle to export data for.
     * @param file - the ASCII CSV file to create.
     * @return boolean flag indicating success/failure (true=success)
     */
    public boolean exportData(Vehicle vehicle, File file) {
    	
    	final String tag = TAG+".exportData()";
    	
    	boolean status = false;
    	
    	List<GasRecord> list = readAllRecords(vehicle);
    	
    	PrintStream out = null;
    	try {
    		out = new PrintStream(new FileOutputStream(file));
    		for (GasRecord record : list) {
    			out.println(record.toStringCSV());
    		}
    		status = true;
    	} catch(Throwable t) {
    		Log.e(tag,"export failed",t);
    	} finally {
    		if (out != null) out.close();
    	}
    	
    	return status;
    }
}
