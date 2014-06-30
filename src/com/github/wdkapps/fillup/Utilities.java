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

import java.text.NumberFormat;

import android.content.Context;
import android.util.DisplayMetrics;
import android.widget.Toast;

/**
 * DESCRIPTION:
 * Implements various methods for general purpose use.
 */
public class Utilities {
	
	/**
     * DESCRIPTION:
     * Display an Android "toast" dialog box.
     * @param context - the context to use. Usually an Application or Activity object.
     * @param text - the text to display in the toast.
     */
    public static void toast(Context context, String text)
    {
        Toast toast = Toast.makeText(context, text, Toast.LENGTH_LONG);
        toast.show();
    }
    
    /**
     * DESCRIPTION:
     * Convert pixels to device independent pixels.
     * @param px - pixels
     * @return device independent pixels.
     */
    public static float convertPixelsToDp(int px){
        DisplayMetrics metrics = App.getContext().getResources().getDisplayMetrics();
        float dp = px / (metrics.densityDpi / 160f);
        return dp;
    }
    
    /**
     * DESCRIPTION:
     * Convert device independent pixels to pixels. 
     * @param dp - device independent pixels.
     * @return pixels.
     */
    public static int convertDpToPixel(float dp){
        DisplayMetrics metrics = App.getContext().getResources().getDisplayMetrics();
        int px = (int) (dp * (metrics.densityDpi / 160f));
        return px;
    }
    
    /**
     * DESCRIPTION:
     * Returns the symbol for the currency in the current locale. 
     * @return the currency symbol as a String.
     */
    public static String getCurrencySymbol() {
    	NumberFormat nf = NumberFormat.getCurrencyInstance();
  		return nf.getCurrency().getSymbol(); 
    }
    
    /**
     * DESCRIPTION:
     * Returns a String formatted as currency in the current locale.
     * <p>
     * NOTE: A new NumberFormat instance is created each time this
     * method is called. This avoids NumberFormat thread safety issues 
     * at the cost of performance. Call this method sparingly!
     * </p>
     * @param value - the currency value to be formatted (as a double)
     * @return the value as a currency String
     */
    public static String getCurrencyString(double value) {
        NumberFormat nf = NumberFormat.getCurrencyInstance();
        return nf.format(value);
    }

}
