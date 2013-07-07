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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import android.util.Log;

/**
 * DESCRIPTION:
 * A collection of static methods that perform commonly used tasks on
 * a java list of gas records (List<GasRecord>).
 * 
 * TODO change this to encapsulate the list?? Would require modification
 * of all other classes that currently use a List<GasRecord>.    
 */
public class GasRecordList {
	
	protected final static String TAG = GasRecordList.class.getName();
	
    /**
     * DESCRIPTION:
     * Calculates gas mileage for a List of GasRecords.
     * NOTE: The resulting list is sorted by odometer value.
     * @param list - the GasRecord List.
     */
    public static void calculateMileage(List<GasRecord> list) {
    	
    	// do nothing if list is empty
    	if ((list == null) || list.isEmpty())
    		return;
    	
    	// sort the list by odometer value
    	Collections.sort(list,new OdometerComparator());

    	// get currently selected units of measurement for calculation
    	Units units = new Units(Settings.KEY_UNITS);
    	
    	// initialize for calculations
    	GasRecord record;
    	MileageCalculation calc = null;
    	Iterator<GasRecord> iterator = list.iterator();
    	
    	// find the first full tank 	
    	while(iterator.hasNext()) {
    		record = iterator.next();
    		record.setCalculation(null);
    		if (record.isFullTank()) {
    			calc = new MileageCalculation(record, units);
    			break;
    		}
    	}
    	
    	// start calculating mileage after first full tank
    	while(iterator.hasNext()) {
    		record = iterator.next();
    		calc.add(record);
    		if (record.isFullTank()) {
    			record.setCalculation(calc);
    			calc = new MileageCalculation(record, units);
    		} else {
    			record.setCalculation(null);
    		}
    	}
    }
	
    /**
     * DESCRIPTION:
     * Locates a record in the list. 
     * NOTE: Odometer value is used for comparison.
	 * @param list - the list of gas records.
     * @param record - the record to search for.
     * @return the index of the record in the list (negative if not found).
     */
    public static int find(List<GasRecord> list, GasRecord record) {
    	return Collections.binarySearch(list,record, new OdometerComparator());
    }
    
	/**
	 * DESCRIPTION:
	 * Searches a list to determine if it contains a record with a full tank.
	 * @param list - the list of gas records.
	 * @return true if list contains a record with full tank.
	 */
    public static boolean hasFullTank(List<GasRecord> list) {
    	for (GasRecord record : list) {
    		if (record.isFullTank()) 
    			return true;
    	}
    	return false;
    }
    
	/**
	 * DESCRIPTION:
	 * Searches for a previous record in the list with a full tank.
	 * @param list - the list of gas records.
	 * @param location - the location in the list to start searching.
	 * @return the index of the previous full tank in the list (negative if not found)/
	 */
    public static int findPreviousFullTank(List<GasRecord> list, int location) {
    	int previous = location;
    	try {
    		while (--previous >= 0) {
    			if (list.get(previous).isFullTank()) 
    				break;
    		}
    	} catch (IndexOutOfBoundsException e) {
    		String msg = "size="+list.size()+" location="+location;
    		Log.e(TAG+"findPreviousFullTank()",msg,e);
    		previous = -1;
    	}
    	return previous;
    }
    
    /**
     * DESCRIPTION:
     * Creates a new list containing a copy of the records at locations
     * [start] through [end-1]. 
     * @param list - the list containing records to copy.
     * @param start - the index at which to start the sublist.
     * @param end - the index one past the end of the sublist.
     * @return
     */
    public static List<GasRecord> subList(List<GasRecord> list, int start, int  end) {
    	List<GasRecord> sublist = new ArrayList<GasRecord>(end - start);
    	
    	try {
    		for (int n=start; n<end; n++) {
    			GasRecord record = new GasRecord(list.get(n));
    			sublist.add(record);
    		}
    	} catch (IndexOutOfBoundsException e) {
    		String msg = "size=" + list.size() + " start=" + start + " end=" + end;
    		Log.e(TAG+"subList()",msg,e);
    		sublist.clear();
    	}
    	
    	return sublist;
    }

}
