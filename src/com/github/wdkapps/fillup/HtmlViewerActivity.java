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

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;

/**
 * DESCRIPTION:
 * Implements an Android Activity class to display information
 * from an HTML asset file. 
 */
public class HtmlViewerActivity extends Activity {

	/// key name for the URL to pass via Intent
	public final static String URL = HtmlViewerActivity.class.getName() + ".URL";

	/// key name for a boolean flag to pass via Intent requesting that the activity returns a result on close
	public final static String RETURN_RESULT = HtmlViewerActivity.class.getName() + ".RETURN_RESULT";
	
    /**
     * DESCRIPTION:
     * Called when the activity is starting.
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_html_viewer);
        
        // get parameters from intent
        Intent intent = getIntent();
        String url = intent.getStringExtra(URL);
        final boolean return_result = intent.getBooleanExtra(RETURN_RESULT,false);
        
        // display the HTML
        WebView webview = (WebView)findViewById(R.id.webView);  
        webview.getSettings().setSupportZoom(true);
        webview.getSettings().setBuiltInZoomControls(true);
        webview.loadUrl(url);
        
        // terminate this activity when user clicks OK
        Button buttonOK = (Button)findViewById(R.id.buttonOK);
        final HtmlViewerActivity activity = this;
        buttonOK.setOnClickListener(new View.OnClickListener() {
        	@Override
        	public void onClick(View v) {
        		if (return_result) {
        			setResult(Activity.RESULT_OK);
        		}
        		activity.finish();
        	}
        });
    }
    
    /**
     * DESCRIPTION
     * Make the Back Key navigate to the previously viewed HTML file
     * (if possible) instead of exiting the Activity. 
     * @see android.app.Activity#onKeyDown(int, android.view.KeyEvent)
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        WebView webview = (WebView)findViewById(R.id.webView);  
    	if(event.getAction() == KeyEvent.ACTION_DOWN){
            switch(keyCode)
            {
            case KeyEvent.KEYCODE_BACK:
                if(webview.canGoBack()){
                    webview.goBack();
                }else{
                    finish();
                }
                return true;
            }
        }
        return super.onKeyDown(keyCode, event);
    }

}