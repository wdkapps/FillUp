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

import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;

/**
 * DESCRIPTION:
 * Wrapper for TextWatcher instances to monitor the status of the various
 * gas record form EditText fields. The EditText API does not provide a mechanism 
 * to remove all attached TextWatcher instances. We must remember what we added, and
 * remove them when done. Also, we only want to monitor certain fields based on
 * the current data entry mode preference value.
 */
public abstract class GasRecordWatcher {

	/// current data entry mode
	private DataEntryMode mode;

	/// the EditText instances to monitor
	private EditText editTextPrice;
	private EditText editTextCost;
	private EditText editTextGallons;
	
	/// the TextWatchers...one per EditText
	private TextWatcher priceWatcher;
	private TextWatcher costWatcher;
	private TextWatcher gallonsWatcher;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasRecordWatcher.
	 * @param mode - current data entry mode
	 * @param price - EditText to monitor
	 * @param cost - EditText to monitor
	 * @param gallons - EditText to monitor
	 */
	public GasRecordWatcher(DataEntryMode mode, EditText price, EditText cost, EditText gallons) {
		this.editTextPrice = price;
		this.editTextCost = cost;
		this.editTextGallons = gallons;
		this.mode = mode;
		
		if (!mode.isCalculatePrice()) {
			priceWatcher = getPriceTextWatcher();
			editTextPrice.addTextChangedListener(priceWatcher);
		}
		
		if (!mode.isCalculateCost()) {
			costWatcher = getCostTextWatcher();
			editTextCost.addTextChangedListener(costWatcher);
		}
		
		if (!mode.isCalculateGallons()) {
			gallonsWatcher = getGallonsTextWatcher();
			editTextGallons.addTextChangedListener(gallonsWatcher);
		}
	}
	
	/**
	 * DESCRIPTION:
	 * Removes all TextWatcher instances in use.
	 */
	public void destroy() {
		if (!mode.isCalculatePrice()) {
			editTextPrice.removeTextChangedListener(priceWatcher);
		}
		
		if (!mode.isCalculateCost()) {
			editTextCost.removeTextChangedListener(costWatcher);
		}
		
		if (!mode.isCalculateGallons()) {
			editTextGallons.removeTextChangedListener(gallonsWatcher);
		}
	}

	/**
	 * DESCRIPTION:
	 * Creates a TextWatcher to listen for and handle changes for the
	 * price EditText.
	 * @return TextWatcher
	 */
	private TextWatcher getPriceTextWatcher() {
		return new TextWatcher() {
			public void beforeTextChanged(CharSequence s, int start, int count,	int after) {}
			public void onTextChanged(CharSequence s, int start, int before, int count) {}
			public void afterTextChanged(Editable s) {
				priceChanged();
			}
		};
	}
	
	/**
	 * DESCRIPTION:
	 * Creates a TextWatcher to listen for and handle changes for the
	 * cost EditText.
	 * @return TextWatcher
	 */
	private TextWatcher getCostTextWatcher() {
		return new TextWatcher() {
			public void beforeTextChanged(CharSequence s, int start, int count,	int after) {}
			public void onTextChanged(CharSequence s, int start, int before, int count) {}
			public void afterTextChanged(Editable s) {
				costChanged();
			}
		};
	}

	/**
	 * DESCRIPTION:
	 * Creates a TextWatcher to listen for and handle changes for the
	 * gallons EditText.
	 * @return TextWatcher
	 */
	private TextWatcher getGallonsTextWatcher() {
		return new TextWatcher() {
			public void beforeTextChanged(CharSequence s, int start, int count,	int after) {}
			public void onTextChanged(CharSequence s, int start, int before, int count) {}
			public void afterTextChanged(Editable s) {
				gallonsChanged();
			}
		};
	}
	
	/**
	 * DESCRIPTION:
	 * Called after the price EditText content has changed.
	 */
	public abstract void priceChanged();
	
	/**
	 * DESCRIPTION:
	 * Called after the cost EditText content has changed.
	 */
	public abstract void costChanged();
	
	/**
	 * DESCRIPTION:
	 * Called after the cost EditText content has changed.
	 */
	public abstract void gallonsChanged();

}
