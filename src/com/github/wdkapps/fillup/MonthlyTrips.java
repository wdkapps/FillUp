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

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * DESCRIPTION:
 * A container for calculated trip data derived from a list of gas records. 
 * Provides a monthly summation of trip attributes (distance, gallons of
 * gas purchased, etc) for plotting purposes.
 */
public class MonthlyTrips implements Iterable<Date>{
	
	/// maps a month (MMYYYY string) to a TripRecord representing trips that were recorded during that month
	private Map<String,TripRecord> map = new HashMap<String,TripRecord>();
	
	/// the earliest date recorded in the map
	Date earliest = new Date();
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of MonthlyAggregate.
	 * @param data - a list of gas records for trip calculations.
	 */
	public MonthlyTrips(List<GasRecord> data) {
		
        // derive trip information from the gas record data - each trip spans two gas records
        // note1: assumes gas record data is sorted by odometer value
        if (!data.isEmpty()) {
            Iterator<GasRecord> iterator = data.iterator();
        	GasRecord startGas = iterator.next();
        	add(new TripRecord(startGas,startGas));
        	while(iterator.hasNext()) {
        		GasRecord endGas = iterator.next();
        		add(new TripRecord(startGas,endGas));
        		startGas = endGas;
        	}
        }
        
	}
	
	/**
	 * DESCRIPTION:
	 * Adds a trip record to the map.
	 * @param trip - the trip record to add.
	 */
	private void add(TripRecord trip) {
		
		// get key reflecting the trip date (month)
		String key = getKey(trip.getEndDate());
		
		// attempt to get existing trips for that month
		TripRecord trips = map.get(key);
		if (trips == null) {
			// no existing trips - save this trip in map
			map.put(key,trip);
		} else {
			// append this trip to existing trip totals for the month
			trips.append(trip);
		}
		
		// remember what the earliest trip date is (for iteration)
		if (trip.getEndDate().before(earliest)) {
			earliest = trip.getEndDate();
		}
	}
	
	/**
	 * DESCRIPTION:
	 * Calculates a unique MMYYYY key for the specified trip date.
	 * @param date
	 * @return
	 */
	private String getKey(Date date) {
		int month = date.getMonth();
		int year = date.getYear() + 1900;
		return String.format(Locale.US,"%02d%04d",month,year);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the trip data for a specified month.
	 * @param month - the data index.
	 * @return a TripRecord reflecting trip totals for the specified month.
	 */
	public TripRecord getTrips(Date month) {
		TripRecord trips = map.get(getKey(month));
		if (trips == null) trips = new TripRecord(month);
		return trips;
	}

	/**
	 * DESCRIPTION:
	 * Returns a MonthIterator spanning the data contained in the map
	 * within the currently configured plot date range.
	 * @see java.lang.Iterable#iterator()
	 */
	@Override
	public Iterator<Date> iterator() {

		// iterate over the configured plot range
		PlotDateRange range = new PlotDateRange(App.getContext(),Settings.KEY_PLOT_DATE_RANGE);
		
		// initialize start date to the current date
		Calendar startCalendar = Calendar.getInstance();
		
		// determine start date for specified range
		// note: one month less than desired range - current month is handled separately
		switch (range.getValue()){
		case PlotDateRange.ALL:
			startCalendar.setTime(earliest);
			break;
		case PlotDateRange.PAST_MONTH:
			break;
		case PlotDateRange.PAST_6_MONTHS:
			startCalendar.add(Calendar.MONTH, -5);
			break;
		case PlotDateRange.PAST_12_MONTHS:
			startCalendar.add(Calendar.MONTH, -11);
			break;
		case PlotDateRange.YEAR_TO_DATE:
			startCalendar.set(Calendar.MONTH, Calendar.JANUARY);
			startCalendar.set(Calendar.DAY_OF_MONTH, 1);
			startCalendar.set(Calendar.HOUR_OF_DAY,0);
			startCalendar.set(Calendar.MINUTE,0);
			break;
		default:
			throw new RuntimeException("Invalid PlotDateRange integer value");
		}

		// force maximum range to 2 years or plot gets ugly
		Calendar twoyearsago = Calendar.getInstance();
		twoyearsago.add(Calendar.MONTH, -23);
		if (startCalendar.before(twoyearsago)) {
			startCalendar = twoyearsago;
		}
		
		// return the iterator
		Date startDate = startCalendar.getTime();
		Date endDate = new Date();
		return new MonthIterator(startDate,endDate);
	}
	
}
