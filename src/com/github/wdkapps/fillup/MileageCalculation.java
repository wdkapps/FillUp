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

import java.io.Serializable;

/**
 * DESCRIPTION:
 * Implements an object to calculate gas mileage for a set of 
 * gasoline records. It calculates total distance driven, total
 * gasoline used and overall fuel efficiency (mileage) in the specified
 * units. Needs to be Serializable in order to pass between Activity 
 * instances via an Intent instance.
 */
public class MileageCalculation implements Serializable {
	
	/// required to enable serialization
	private static final long serialVersionUID = 3403673049159091140L;
	
	// for conversion from liters to imperial gallons
	private static final float IMPERIAL_GALLONS_PER_LITER = 0.219969f;
	
	// for conversion from kilometers to miles
	private static final float MILES_PER_KILOMETER = 0.621371f;
	
	/// odometer value for the previous full tank of gas 
	protected int startOdometer;
	
	/// odometer value for the current full tank of gas 
	protected int endOdometer;
	
	/// amount of gasoline used between fill ups  
	protected float gasolineUsed;
	
	/// the preferred calculation units 
	protected Units units;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of MileageCalculation.
	 *
	 * @param startRecord - GasRecord reflecting the previous full tank of gas.
	 * @param units - the Units of measurement to use for calculations.
	 */
	public MileageCalculation(GasRecord startRecord, Units units) {
		this.startOdometer = startRecord.getOdometer();
		this.endOdometer = this.startOdometer;
		this.gasolineUsed = 0;
		this.units = units;
	}
	
	/**
	 * DESCRIPTION:
	 * Adds a gas record to the set of records used for calculation.
	 * NOTE: Assumed records are added in odometer order (lowest odometer first).
	 * @param record - the GasRecord to add to the calculation set.
	 */
	public void add(GasRecord record) {
		this.endOdometer = record.getOdometer();
		this.gasolineUsed += record.getGallons();
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the distance driven.
	 * @return integer - distance driven.
	 */
	public int getDistanceDriven() {
		return endOdometer - startOdometer;
	}

	/**
	 * DESCRIPTION:
	 * Returns the amount of gasoline used.
	 * @return float - gasoline used.
	 */
	public float getGasolineUsed() {
		return gasolineUsed;
	}
	
	/**
	 * DESCRIPTION:
	 * Calculates the quantity of gasoline consumed per distance driven.
	 * @return float - calculated fuel efficiency (mileage) 
	 */
	public float getMileage() {
		float mileage = 0;
		int distance = getDistanceDriven();
		
		// avoid division by zero!
		if ((gasolineUsed > 0) && (distance > 0)) {
			
			// calculate mileage in specified units
			switch (units.getValue()) {
			
			case Units.MILES_PER_GALLON:
			case Units.KILOMETERS_PER_GALLON:	
			case Units.KILOMETERS_PER_LITER:
				mileage = distance/gasolineUsed;
				break;
				
			case Units.LITERS_PER_100_KILOMETERS:
				mileage = (gasolineUsed * 100)/distance;
				break;
				
			case Units.UK_MPG_MILES_LITERS:
				// calculate MPG when: odometer = miles, gasolineUsed = liters
				float miles = (float) distance;
				float imperialGallons = gasolineUsed * IMPERIAL_GALLONS_PER_LITER;
				mileage = miles/imperialGallons; 
				break;
				
			case Units.UK_MPG_KILOMETERS_LITERS:
				// calculate MPG when: odometer = kilometers, gasolineUsed = liters
				miles = (float) distance * MILES_PER_KILOMETER;
				imperialGallons = gasolineUsed * IMPERIAL_GALLONS_PER_LITER;
				mileage = miles/imperialGallons; 
				break;
			}
			
		}
		return mileage;
	}
	
	/**
	 * DESCRIPTION:
	 * Returns quantity of gasoline used as a formatted String.
	 * @return String - quantity of gas used.
	 */
	public String getGasolineUsedString() {
		return String.format(App.getLocale(),"%.3f", getGasolineUsed());
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the calculated mileage as a formatted String.
	 * @return String - calculated gas mileage
	 */
	public String getMileageString() {
		return String.format(App.getLocale(),"%.2f", getMileage());
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the units of measurement used for calculations.
	 * @return - the Units of measurement.
	 */
	public Units getUnits() {
		return units;
	}
	
	/**
	 * DESCRIPTION:
	 * Displays object instance values for logging purposes.
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "MileageCalculation [" + 
				"startOdometer=" + startOdometer + 
				", endOdometer=" + endOdometer + 
				", gasUsed=" + gasolineUsed + 
				", units=" + units.getMileageLabel() + 
				"]";
	}

}
