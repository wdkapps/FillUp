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
 * A class to represent a specific vehicle in the gasoline log.
 * Each gasoline record refers to a specific vehicle in the log.
 * Needs to be Serializable in order to pass between Activity instances via 
 * an Intent instance.
 */
public class Vehicle implements Serializable {
	
	/// minimum/maximum lengths of name string in characters
	public static final int MIN_NAME_LENGTH = 1;
	public static final int MAX_NAME_LENGTH = 20;
	
	/// required for serialization
	private static final long serialVersionUID = 815593508057718224L;

	/// the id of the vehicle in the gas log database 
	private Integer id;
	
	/// the name of the vehicle 
	private String name;
		
	/// the size of the vehicle's gas tank (gallons or liters depending on units)  
	private Float tanksize;
	
	/**
	 * DESCRIPTION:
	 * Constructs a blank instance of Vehicle.
	 */
	public Vehicle() {
		id = null;
		name = "";
		Units units = new Units(Settings.KEY_UNITS);
		tanksize = units.getAverageTankSize();
	}
	
	/**
	 * DESCRIPTION:
	 * Constructs a copy of an existing Vehicle.
	 * @param that - the existing Vehicle instance to copy.
	 */
	public Vehicle(Vehicle that) {
		this.id = Integer.valueOf(that.id);
		this.name = new String(that.name);
		this.tanksize = Float.valueOf(that.tanksize);
	}
	
	/**
	 * DESCRIPTION:
	 * Getter method for the vehicle id attribute.
	 * @return the Integer vehicle id value.
	 */
	public Integer getID() {
		return this.id;
	}

	/**
	 * DESCRIPTION:
	 * Setter method for the vehicle id attribute.
	 * @param id - the Integer vehicle id value. 
	 */
	public void setID(Integer id) {
		this.id = id;
	}

	/**
	 * DESCRIPTION:
	 * Getter method for the vehicle name attribute.
	 * @return the vehicle name String value.
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * DESCRIPTION:
	 * Setter method for the vehicle name attribute.
	 * @param name - the vehicle name String value.
	 * @throws IllegalArgumentException if the string is not a valid vehicle name.
	 */
	public void setName(String name) {
		
		// can't be null
		if (name == null) 
			throw new IllegalArgumentException("null string");
		
		// range check the string length
		if ((name.length() < MIN_NAME_LENGTH) ||
			(name.length() > MAX_NAME_LENGTH))
			throw new IllegalArgumentException("invalid name length");
		
		// must be a valid filename (for import/export)
		final String VALID_NAME_REGEX = "[a-zA-z0-9][a-zA-z0-9- ]*"; 
		if (!name.matches(VALID_NAME_REGEX)) 
			throw new IllegalArgumentException("invaid format");

		this.name = name;
	}
	
	/**
	 * DESCRIPTION:
	 * Getter method for the vehicle tank size attribute. 
	 * @return the vehicle tank size float value.
	 */
	public Float getTankSize() {
		return tanksize;
	}

	/**
	 * DESCRIPTION:
	 * Setter method for the vehicle tank size attribute.
	 * @param tankSize - the Float vehicle tank size value.
	 */
	public void setTankSize(Float tankSize) {
		this.tanksize = tankSize;
	}
	
	/**
	 * DESCRIPTION:
	 * Getter method for the vehicle tank size attribute.
	 * @return the vehicle tank size attribute value as a String.
	 */
	public String getTankSizeString() {
		return String.format(App.getLocale(),"%.1f",tanksize);
	}

	/**
	 * DESCRIPTION:
	 * Setter method for the vehicle tank size attribute.
	 * @param tankSize - the vehicle tank size value as a String.
	 * @throws NumberFormatException if String parse fails.
	 */
	public void setTankSize(String tankSize) {
		
		if (tankSize == null) 
			throw new NumberFormatException("null string");

		float value = Float.parseFloat(tankSize.replace(',','.'));
		
		if ((value < 1.0f) || (value > 1000f))
			throw new NumberFormatException("out of range");
		
		this.tanksize = value;
	}

	/**
	 * DESCRIPTION:
	 * Returns a string representation of the vehicle for display purposes.
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return getName();
	}
	
}
