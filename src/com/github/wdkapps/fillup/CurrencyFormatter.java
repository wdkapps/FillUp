/*
 * *****************************************************************************
 * Copyright 2014 William D. Kraemer
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

import java.text.DecimalFormat;
import java.text.FieldPosition;
import java.text.Format;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.util.Currency;
import java.util.Locale;

import android.util.Log;

/**
 * DESCRIPTION:
 * A formatter for currency values as text Strings for a specified currency/locale.
 */
public class CurrencyFormatter extends Format {
	
	protected static final long serialVersionUID = 4871547796586258218L;

	/// for logging
	protected static final String TAG = CurrencyFormatter.class.getName();
	
    /// locale for currently selected currency
	protected Locale locale;
	
	// flag indicating whether the formatter is numeric (without currency symbol)
	protected boolean numeric;
    
    /// the actual number formatter
	protected NumberFormat nf; 

	/**
	 * DESCRIPTION:
	 * Constructs an instance of CurrencyFormatter.
	 * @param numeric - true = numeric formatter, false = symbolic formatter
	 */
	public CurrencyFormatter(boolean numeric) {
		this.numeric = numeric;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns a boolean indicating whether the formatter is
	 * numeric
	 * @return boolean - true = numeric formatter, false = symbolic formatter
	 */
	public boolean isNumeric() {
		return this.numeric;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the currently selected currency/locale
	 * @return
	 */
	public Locale getLocale() {
		return locale;
	}
	
	/**
	 * DESCRIPTION:
	 * Specifes a currency/locale to be utilized for formatting.
	 * @param locale
	 */
	public void setLocale(Locale locale) {
		
		this.locale = locale;
		
		if (numeric) {
			nf = NumberFormat.getInstance(locale);
			
	    	// don't display commas (ie. 1000.00 instead of 1,000.00)
	    	nf.setGroupingUsed(false);

		} else {
			nf = DecimalFormat.getCurrencyInstance(locale);
		}
		
    	// configure fraction digits for the formatter
    	nf.setMinimumFractionDigits(getMinimumFractionDigits());
    	nf.setMaximumFractionDigits(getMaximumFractionDigits());
	}
	
	/**
	 * DESCRIPTION:
	 * Formats a double value as a currency String.
	 * @param value
	 * @return String
	 */
	public String format(double value) {
		return nf.format(value);
	}

	/**
	 * @see java.text.Format#format(java.lang.Object, java.lang.StringBuffer, java.text.FieldPosition)
	 */
	@Override
	public StringBuffer format(Object object, StringBuffer buffer, FieldPosition field) {
		return nf.format(object, buffer, field);
	}

	/**
	 * @see java.text.Format#parseObject(java.lang.String, java.text.ParsePosition)
	 */
	@Override
	public Object parseObject(String string, ParsePosition position) {
		return nf.parseObject(string,position);
	}
	
	/**
	 * DESCRIPTION:
	 * Determine the default number of fraction digits to display for locale.
	 * @return number of digits
	 */
	protected int getDefaultFractionDigits() {
		
		final String TAG_ = TAG + ".getDefaultFractionDigits()";
		
    	int fractionDigits = 2;
    	try {
    		Currency currency = Currency.getInstance(locale);
    		fractionDigits = currency.getDefaultFractionDigits();
    	} catch(IllegalArgumentException ex) {
    		Log.e(TAG_,"unable to determine default fraction digits for locale",ex);
    	}

    	Log.d(TAG_,"fractionDigits="+fractionDigits);
    	
    	if (fractionDigits < 0) fractionDigits = 0;
    	
    	return fractionDigits;
	}
	
	/**
	 * DESCRIPTION:
	 * Determine the minimum number of fraction digits to display for locale.
	 * @return number of digits
	 */
	protected int getMinimumFractionDigits() {
    	return getDefaultFractionDigits();
	}
	
	/**
	 * DESCRIPTION:
	 * Determine the maximum number of fraction digits to display for locale.
	 * @return number of digits
	 */
	protected int getMaximumFractionDigits() {
    	return getDefaultFractionDigits();
	}

}
