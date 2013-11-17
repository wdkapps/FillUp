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

import java.util.Date;
import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * DESCRIPTION:
 * Sequentially iterates over a Date range at 23:59:59 on the last day of each month.
 */
public class MonthIterator implements Iterator<Month> {
	
	/// the next month value in the iteration range
	private Month next;
	
	/// the last month of the iteration range 
	private Month end;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of MonthIterator.
	 * @param dateStart - the starting date
	 * @param dateEnd - the ending date
	 */
	public MonthIterator(Date dateStart, Date dateEnd) {
		next = new Month(dateStart);
		end = new Month(dateEnd);
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
	public Month next() {
		if (!hasNext()) throw new NoSuchElementException();
		Month month = new Month(next);
		next.increment();
		return month;
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
	
}
