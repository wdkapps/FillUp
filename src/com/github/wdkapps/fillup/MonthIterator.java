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
import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * DESCRIPTION:
 * Sequentially iterates over a Date range at 23:59:59 on the last day of each month.
 */
public class MonthIterator implements Iterator<Date> {
	
	/// the next month value in the iteration range
	private Calendar next = Calendar.getInstance();
	
	/// the end date of the iteration range 
	private Calendar end = Calendar.getInstance();
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of MonthIterator.
	 * @param dateStart - the starting date
	 * @param dateEnd - the ending date
	 */
	public MonthIterator(Date dateStart, Date dateEnd) {
		next.set(Calendar.MONTH,dateStart.getMonth());
		next.set(Calendar.YEAR,dateStart.getYear()+1900);
		next.set(Calendar.DAY_OF_MONTH,getLastDayOfMonth(next));
		next.set(Calendar.HOUR_OF_DAY,23);
		next.set(Calendar.MINUTE,59);
		next.set(Calendar.SECOND,59);
		end.setTime(dateEnd);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns true if there is at least one more month, false otherwise.
	 * @see java.util.Iterator#hasNext()
	 */
	@Override
	public boolean hasNext() {
		return next.before(end);
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the next month and advances the iterator.
	 * @throws NoSuchElementException if there are no more months. 
	 * @see java.util.Iterator#next()
	 */
	@Override
	public Date next() {
		if (!hasNext()) throw new NoSuchElementException();
		Date date = next.getTime();
		next.add(Calendar.MONTH,1);
		next.set(Calendar.DAY_OF_MONTH,getLastDayOfMonth(next));
		return date;
	}

	/**
	 * DESCRIPTION:
	 * Element removal is not supported by this iterator.
	 * @throws UnsupportedOperationException 
	 * @see java.util.Iterator#remove()
	 */
	@Override
	public void remove() {
		throw new UnsupportedOperationException();
	}
	
	/**
	 * DESCRIPTION:
	 * Convenience method to retrieve the last day of the month
	 * for a specific month (indicated via Calendar instance). 
	 * @param calendar - indicates the month to retrieve the last day for. 
	 * @return int - the last day of the specified month.
	 */
	private int getLastDayOfMonth(Calendar calendar) {
		return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);	
	}

}
