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

import java.text.FieldPosition;
import java.text.Format;
import java.text.ParsePosition;
import java.util.HashMap;
import java.util.Map;

/**
 * DESCRIPTION:
 * Implements a formatter for plot axis labels by mapping label strings to 
 * specific plot data values.
 */
public class MappedLabelFormat extends Format {

	/// needed for serialization 
	private static final long serialVersionUID = 1L;

	/// the map of values to labels
	private Map<Long,String> labels = new HashMap<Long,String>();
	
	/// flag indicating whether the labels should be abbreviated during formatting
	private boolean abbreviate = false;
	
	/**
	 * DESCRIPTION:
	 * Removes all elements from this map, leaving it empty.
	 */
	public void clear() {
		labels.clear();
	}
	
	/**
	 * DESCRIPTION:
	 * Maps the specified value to the specified label.
	 * @param value
	 * @param label
	 */
	public void put(Long value, String label) {
		labels.put(value,label);
	}

	/**
	 * DESCRIPTION:
	 * Appends the mapped label to the buffer. If a mapping is not found, 
	 * the buffer is left unchanged.<p> 
	 * NOTE: Androidplot casts each axis value as a Double even though the
	 * plot series data is defined as Long/Number. Not sure why. Examples
	 * show Float conversion to Integer. Doing Double conversion to Long here.
	 * @see java.text.Format#format(java.lang.Object, java.lang.StringBuffer, java.text.FieldPosition)
	 */
	@Override
	public StringBuffer format(Object object, StringBuffer buffer, FieldPosition field) {
		String label = null;
		if (object instanceof Double) {
			Long value = Math.round((Double)object);
			label = labels.get(value);
		}
		if (label != null) {
			
			if (abbreviate && !label.isEmpty()) {
				label = label.substring(0,1);
			}

			buffer.append(label);
		}
		return buffer;
	}

	/**
	 * DESCRIPTION:
	 * Unsupported method - not needed.
	 * @see java.text.Format#parseObject(java.lang.String, java.text.ParsePosition)
	 */
	@Override
	public Object parseObject(String string, ParsePosition position) {
		throw new UnsupportedOperationException("parseObject() is not implemented");
	}
	
	/**
	 * DESCRIPTION:
	 * Specifies whether labels should be abbreviated to their first character
	 * during format.
	 * @param enabled - true = abbreviate the labels.
	 */
	public void setAbbreviate(boolean enabled) {
		this.abbreviate = enabled;
	}

}
