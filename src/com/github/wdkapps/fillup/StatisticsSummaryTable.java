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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * DESCRIPTION:
 * A table for display of statistics derived from multiple months of trip data.
 */
public class StatisticsSummaryTable implements HtmlData {

	/// the trip data
	private List<TripRecord> data;
	
	/// accumulation of all trip data
	private TripRecord total;
	
	/// a title for the table
	private final String title;

	/// css class value
	private final String cssClass = "summary";
	
	/// the html data for the table
	private StringBuilder html;
	
	/// current units of measurement for display of labels
	private Units units;
	
	/// gas records data was derived from
	private ArrayList<GasRecord> records = new ArrayList<GasRecord>();
	
	/// a row index used during creation
	private int row;
	
	/// end of line string
	private static final String newline = System.getProperty("line.separator");
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of StatisticsReportTable.
	 * @param data - the trip data used to generate the table (current month at index 0)
	 * @param title - the table title.
	 */
	public StatisticsSummaryTable(List<TripRecord> data,  String title) {
		this.data = data;
		this.title = getString(R.string.stats_summary_prefix) + title;
		this.total = new TripRecord(new Date());
		for (TripRecord trip : data) { 
			this.total.append(trip);
		}
		this.records.addAll(total.getGasRecords());
		Collections.sort(records,new OdometerComparator());
		createTable();
	}

	/**
	 * DESCRIPTION:
	 * Returns the table as an HTML String.
	 * @see com.github.wdkapps.fillup.HtmlData#getHtml()
	 */
	@Override
	public String getHtml() {
		return html.toString();
	}
	
	/**
	 * DESCRIPTION:
	 * Generates an HTML table from the data.
	 */
	private void createTable() {
		units = new Units(Settings.KEY_UNITS);
		html = new StringBuilder();
		html.append("<table"+property("class",cssClass)+">").append(newline);
		appendTableHeaderRow(title,"2");
		row = 0;
		appendMileageData();
		appendDistanceData();
		appendGallonsData();
		appendCostData();
		appendPriceData();
		html.append("</table>").append(newline);
	}	

	/**
	 * DESCRIPTION:
	 * Generates a generic HTML table header row consisting of a single
	 * cell that spans a specified number of table columns.
	 * @param cell - the header cell content as a String.
	 * @param colspan - the number of table columns that the header cell spans
	 */
	private void appendTableHeaderRow(String cell, String colspan) {
		html.append("<tr"+property("class",cssClass)+">").append(newline);
		html.append("  <th"+property("class",cssClass)+property("colspan",colspan)+">").append(cell).append("</th>").append(newline);
		html.append("</tr>").append(newline);
	}
	
	/**
	 * DESCRIPTION:
	 * Generates a generic HTML table row.<p>
	 * NOTE: marks odd numbered rows to support alternating colors for older browsers.
	 * @param cells - the cell content for the row (each cell is one table column).
	 */
	private void appendTableRow(String[] cells) {
		if ((row & 1) == 1) {
			html.append("<tr"+property("class",cssClass+" odd")+">").append(newline);
		} else {			
			html.append("<tr"+property("class",cssClass)+">").append(newline);
		}
		for (String cell : cells) {
			html.append("  <td"+property("class",cssClass)+">").append(cell).append("</td>").append(newline);
		}		
		html.append("</tr>").append(newline);
		row++;
	}
	
	/**
	 * DESCRIPTION:
	 * Appends distance statistical data to the table.
	 */
	private void appendDistanceData() {

		// calculate monthly average
		int months = data.size();
		float average = 0;
		if (months > 0) {
			average = total.getDistance()/months;
		}
		
		// create table row
		String label = getString(R.string.stats_label_distance);
		String value = String.format(App.getLocale(),getString(R.string.stats_calc_distance),
    				total.getDistance().intValue(),
    				units.getDistanceLabelLowerCase(),
    				average);
		value = value.replace("(","<br/>(");
		appendTableRow(new String[]{label,value});
	}
	
	/**
	 * DESCRIPTION:
	 * Appends cost statistical data to the table.
	 */
	private void appendCostData() {

		// calculate cost per month
		int months = data.size();
		double per_month = 0;
		if (months > 0) {
			per_month = total.getCost()/months;
		}
		
		// calculate cost per mile/kilometer
		double per_mile = 0;
		if (total.getDistance() > 0) {
			per_mile = total.getCost()/total.getDistance();
		}
		
		// create table row
		String label = getString(R.string.stats_label_cost);
		String value = String.format(App.getLocale(),getString(R.string.stats_calc_cost),
    				CurrencyManager.getInstance().getSymbolicFormatter().format(total.getCost()),
    				CurrencyManager.getInstance().getSymbolicFormatter().format(per_month),
    				CurrencyManager.getInstance().getSymbolicFractionalFormatter().format(per_mile),
    				units.getDistanceRatioLabel()); 
		value = value.replace("(","<br/>(");
		appendTableRow(new String[]{label,value});
	}

	/**
	 * DESCRIPTION:
	 * Appends gallons statistical data to the table.
	 */
	private void appendGallonsData() {

		// calculate monthly average
		int months = data.size();
		float average = 0;
		if (months > 0) {
			average = total.getGallons()/months;
		}

		// create table row
		String label = getString(R.string.stats_label_gallons);
		String value = String.format(App.getLocale(),getString(R.string.stats_calc_gallons),
    				total.getGallons(),
    				units.getLiquidVolumeLabelLowerCase(),
    				average);
		value = value.replace("(","<br/>(");
		appendTableRow(new String[]{label,value});
	}

	/**
	 * DESCRIPTION:
	 * Appends price statistical data to the table.
	 */
	private void appendPriceData() {
		String label = getString(R.string.stats_label_price);;
		String value = "-";
		if (total.getGallons() > 0) {
			double price = total.getCost()/total.getGallons();
			value = String.format("%s %s",
					CurrencyManager.getInstance().getSymbolicFormatter().format(price),
					units.getLiquidVolumeRatioLabel());
		}
		appendTableRow(new String[]{label,value});
	}

	/**
	 * DESCRIPTION:
	 * Appends mileage statistical data to the table.
	 */
	private void appendMileageData() {
		
		float min = Float.MAX_VALUE;
		float max = 0f;
		float sum = 0f;
		int count = 0;
		for (GasRecord record : records) {
			if (!record.hasCalculation()) continue;
			if (record.isCalculationHidden()) continue;
			float mileage = record.getCalculation().getMileage();
			min = Math.min(min,mileage);
			max = Math.max(max,mileage);
			sum += mileage;
			count++;
		}
		
		String label;
		String value;

		// average
		label = getString(R.string.stats_label_mileage_avg);
		value = "-";
		if (count > 0) 	value = String.format(App.getLocale(),"%.2f %s",sum/count,units.getMileageLabel());
		appendTableRow(new String[]{label,value});
		
		// minimum
		label = getString(R.string.stats_label_mileage_min);
		value = "-";
		if (count > 0) 	value = String.format(App.getLocale(),"%.2f %s",min,units.getMileageLabel());
		appendTableRow(new String[]{label,value});

		// maximum
		label = getString(R.string.stats_label_mileage_max);
		value = "-";
		if (count > 0) 	value = String.format(App.getLocale(),"%.2f %s",max,units.getMileageLabel());
		appendTableRow(new String[]{label,value});
	}
	
	/**
	 * DESCRIPTION:
	 * Returns an HTML property definition in the form of: attribute="value".
	 * @param attribute - the attribute name of the property.
	 * @param value - the value to be assigned to the property.
	 * @return the property definition String.
	 */
	private String property(String attribute, String value) {
		return String.format(" %s=\"%s\"", attribute, value);
	}
	
	/**
	 * DESCRIPTION:
	 * Convenience method to retrieve a String resource.
	 * @param id - the desired resource identifier. 
	 * @return the String data associated with the resource.
	 * @see android.content.res.Resources#getString(int id)
	 */
	private String getString(int id) {
		return App.getContext().getResources().getString(id);
	}
	
}
