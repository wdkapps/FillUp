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

/**
 * DESCRIPTION:
 * Implements an object representing one month of a calendar year to be used as an index
 * when iterating over a range of dates.
 */
public class Month {
	
	/// the month (0-11)
	private int month;
	
	/// the year
	private int year;
	
	/// array of month labels as "MMM"
	private final String labels[] = App.getContext().getResources().getStringArray(R.array.arrayPlotMonthLabels);
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of Month.
	 * @param date - the Date to initialize from.
	 */
	public Month(Date date) {
		this.month = date.getMonth();
		this.year = date.getYear() + 1900;
	}
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of Month as a copy of another Month instance.
	 * @param that - the Month instance to copy.
	 */
	public Month(Month that) {
		this.month = that.month;
		this.year = that.year;
	}

	/**
	 * DESCRIPTION:
	 * Increment by one calendar month.
	 */
	public void increment() {
		if (month == Calendar.DECEMBER) {
			month = Calendar.JANUARY;
			year++;
		} else {
			month++;
		}
	}

	/**
	 * DESCRIPTION:
	 * Decrement by one calendar month.
	 */
	public void decrement() {
		if (month == Calendar.JANUARY) {
			month = Calendar.DECEMBER;
			year--;
		} else {
			month--;
		}
	}

	/**
	 * DESCRIPTION:
	 * Checks if this Month is before another specified Month.
	 * @param that - the other Month.
	 * @return true if this Month precedes the specified Month. 
	 */
	public boolean before(Month that) {
		if (this.year < that.year) return true;
		if (this.year > that.year) return false;
		if (this.month < that.month) return true;
		return false;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns a Date representation of the Month.
	 * @return the Month as a Date.
	 */
	public Date getDate() {
		// year,month,day,hour,min.sec
		return new Date(year-1900,month,1,0,0,0);
	}
	
	/**
	 * DESCRIPTION:
	 * Calculates an integer hash code for this Month. 
	 * @see java.lang.Object#hashCode()
	 * @return the integer hash code.
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + month;
		result = prime * result + year;
		return result;
	}

	/**
	 * DESCRIPTION:
	 * Compares this instance with the specified object and indicates 
	 * if they are equal. 
	 * @see java.lang.Object#equals(java.lang.Object)
	 * @return if the specified object is equal to this record; false otherwise.
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Month that = (Month) obj;
		if (this.month != that.month)
			return false;
		if (this.year != that.year)
			return false;
		return true;
	}

	/**
	 * DESCRIPTION:
	 * Returns a label for a specified month as "MMM".
	 * @return a label String.
	 */
	public String getLabel() {
		return labels[month];
	}
	
	/**
	 * DESCRIPTION:
	 * Returns a label for a specified month as "MMM YYYY".
	 * @return a label String.
	 */
	public String getLongLabel() {
		String mmm = labels[month];
		String yyyy = Integer.toString(year);
		return String.format("%s %s",mmm,yyyy); 
	}

	/**
	 * DESCRIPTION
	 * Returns a label for a specified month as "MMM".
	 * @see java.lang.Object#toString()
	 * @return a label String.
	 */
	@Override
	public String toString() {
		return getLabel();
	}
	
}
