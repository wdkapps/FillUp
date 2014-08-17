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

/**
 * DESCRIPTION:
 * A formatter for currency values as text Strings for a specified currency/locale
 * with an extract fraction digit (i.e. tenths of a cent).
 */
public class FractionalCurrencyFormatter extends CurrencyFormatter {
	
	private static final long serialVersionUID = 2099731379764621534L;

	/**
	 * DESCRIPTION:
	 * Constructs an instance of FractionalCurrencyFormatter.
	 * @param numeric - true = numeric formatter, false = symbolic formatter
	 */
	public FractionalCurrencyFormatter(boolean numeric) {
		super(numeric);
	}

	/**
	 * DESCRIPTION:
	 * Determine the maximum number of fraction digits to display for locale.
	 * @return number of digits
	 */
	@Override
	protected int getMaximumFractionDigits() {
		// add an extra fractional digit (i.e. "tenth of a cent")
		return super.getMaximumFractionDigits() + 1;
	}

}
