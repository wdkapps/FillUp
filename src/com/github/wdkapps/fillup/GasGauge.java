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

import java.lang.reflect.Method;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

/**
 * DESCRIPTION:
 * Implements a custom View representing a gas gauge with a movable hand. The
 * hand position is a float value with range from 0.0 (empty) to 1.0 (full).<p>
 * 
 * This class was adapted from the Mind the Robot Custom UI Vintage Thermometer 
 * sample at mindtherobot.com. 
 * 
 * @see <a href=http://mindtherobot.com/blog/272/android-custom-ui-making-a-vintage-thermometer/>mindtherobot.com</a>
 */
public class GasGauge extends View {
	
    /**
     * DESCRIPTION:
     * Interface definition for a callback to be invoked when the gauge
     * hand position changes.
     */
    public static interface OnHandPositionChangedListener {
        public abstract void onHandPositionChanged(GasGauge source, float handPosition);
    }

	/// instance of registered listener for hand position changes (null = no listener) 
	private OnHandPositionChangedListener handPositionChangedListener = null;

	/// a tag string for debug logging (the name of this class)
	private static final String TAG = GasGauge.class.getSimpleName();

	/// drawing tools
	private Paint handPaint;
	private Path handPath;
	private Paint backgroundPaint; 

	/// holds the cached static background image for the gauge
	private Bitmap background; 

	/// scale configuration
	private static final float emptyPosition = 0.0f;
	private static final float halfPosition = 0.50f;
	private static final float fullPosition = 1.0f;

	/// hand dynamics (hand slowly moves from current position to target position)
	private float handPosition = emptyPosition;
	private float handTarget = emptyPosition;
	private float handVelocity = 0.0f;
	private float handAcceleration = 0.0f;
	private long lastHandMoveTime = -1L;
	
	/// flag indicating if the gauge hand can be moved
	private boolean interactive = true;
	
	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasGauge.
	 * @param context
 	 * @see android.view.View#View(android.content.Context)
	 */
	public GasGauge(Context context) {
		super(context);
		init();
	}

	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasGauge.
	 * @param context
	 * @param attrs
	 * @see android.view.View#View(android.content.Context,android.util.AttributeSet)
	 */
	public GasGauge(Context context, AttributeSet attrs) {
		super(context, attrs);
		init(context,attrs);
	}

	/**
	 * DESCRIPTION:
	 * Constructs an instance of GasGauge.
	 * @param context
	 * @param attrs
	 * @param defStyle
	 * @see android.view.View#View(android.content.Context,android.util.AttributeSet,int)
	 */
	public GasGauge(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		init(context,attrs);
	}

	/**
	 * DESCRIPTION:
	 * Register a callback to be invoked when the hand position changes.
	 * @param listener - the current listener to attach to this view (null=none)
	 */
	public void setOnHandPositionChangedListener(OnHandPositionChangedListener listener) {
		handPositionChangedListener = listener;
	}

	/**
	 * DESCRIPTION:
	 * Saves the current state of the view. 
	 * @see android.view.View#onRestoreInstanceState(android.os.Parcelable)
	 */
	@Override
	protected void onRestoreInstanceState(Parcelable state) {
		Bundle bundle = (Bundle) state;
		Parcelable superState = bundle.getParcelable("superState");
		super.onRestoreInstanceState(superState);

		handPosition = bundle.getFloat("handPosition");
		handTarget = bundle.getFloat("handTarget");
		handVelocity = bundle.getFloat("handVelocity");
		handAcceleration = bundle.getFloat("handAcceleration");
		lastHandMoveTime = bundle.getLong("lastHandMoveTime");
		interactive = bundle.getBoolean("interactive");
	}

	/**
	 * DESCRIPTION:
	 * Restores the state of the view.
	 * @see android.view.View#onSaveInstanceState()
	 */
	@Override
	protected Parcelable onSaveInstanceState() {
		Parcelable superState = super.onSaveInstanceState();

		Bundle state = new Bundle();
		state.putParcelable("superState", superState);
		state.putFloat("handPosition", handPosition);
		state.putFloat("handTarget", handTarget);
		state.putFloat("handVelocity", handVelocity);
		state.putFloat("handAcceleration", handAcceleration);
		state.putLong("lastHandMoveTime", lastHandMoveTime);
		state.putBoolean("interactive", interactive);
		return state;
	}
	
	/**
	 * DESCRIPTION:
	 * Initialize the view from specified attribute values.
	 * @param context
	 * @param attrs - the set of attribute values.
	 */
	private void init(Context context, AttributeSet attrs) {
		
		init();
		
		TypedArray a = context.getTheme().obtainStyledAttributes(
				attrs,
				R.styleable.GasGauge,
				0, 0);

		try {
			float position;
			position = a.getFloat(R.styleable.GasGauge_handPosition, emptyPosition);
			setHandTarget(position);
		} finally {
			a.recycle();
		}
		
	}

	/**
	 * DESCRIPTION:
	 * Initialize the view to default attribute values.
	 */
	private void init() {

		// TODO - remove this ASAP - see method description for details.
		disableHardwareAcceleration();
		
		initDrawingTools();
		setHandTarget(emptyPosition);
		setHandPosition(emptyPosition);
	}
	
	/**
	 * DESCRIPTION:
	 * Disables hardware acceleration when drawing this view. 
	 * This is a workaround for a problem with hardware acceleration in Android 4.2.
	 * The hand path is not being drawn with hardware acceleration enabled on a Nexus 7.
	 * Hardware acceleration is not supported until Android 3.0 (API 11) so we're
	 * running the command to disable it via Java reflection (will fail on older APIs).
	 * The command in Android 3.0 or greater is: setLayerType(View.LAYER_TYPE_SOFTWARE,null);
	 * @see <a href="http://code.google.com/p/android/issues/detail?id=23737">Google bug report</a>
	 */
	private void disableHardwareAcceleration() {
		final String tag = TAG + ".disableHardwareAcceleration()";
		try {
			//final int LAYER_TYPE_NONE = 0;
			final int LAYER_TYPE_SOFTWARE = 1;
			//final int LAYER_TYPE_HARDWARE = 2;
			Method method = View.class.getMethod("setLayerType", int.class, Paint.class);
			method.invoke(this, LAYER_TYPE_SOFTWARE, null);
			Log.w(tag, "Hardware Acceleration has been disabled for view.");
		} catch (Throwable t) {
			Log.w(tag, "Hardware Acceleration not supported on API " + android.os.Build.VERSION.SDK_INT);
		}
	}

	/**
	 * DESCRIPTION:
	 * Initialize the tools required for drawing the view.
	 */
	private void initDrawingTools() {
	
		handPaint = new Paint();
		handPaint.setAntiAlias(true);
		handPaint.setColor(0xff922012);		
		//handPaint.setShadowLayer(0.01f, -0.005f, -0.005f, 0x7f000000);  
		handPaint.setStyle(Paint.Style.FILL);	

		handPath = new Path();
		handPath.moveTo(0.5f, 0.65f);
		handPath.lineTo(0.5f - 0.03f, 0.65f - 0.02f);
		handPath.lineTo(0.5f - 0.02f, 0.65f - 0.32f);
		handPath.lineTo(0.5f + 0.02f, 0.65f - 0.32f);
		handPath.lineTo(0.5f + 0.03f, 0.65f - 0.02f);
		handPath.lineTo(0.5f, 0.65f);
		
		backgroundPaint = new Paint();
		backgroundPaint.setFilterBitmap(true);
	}

	/**
	 * DESCRIPTION:
	 * Measures the view and its content to determine the measured width and 
	 * the measured height. 
	 * @see android.view.View#onMeasure(int, int)
	 */
	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		final String tag = TAG + ".onMeasure()";
		Log.d(tag, "Width spec: " + MeasureSpec.toString(widthMeasureSpec));
		Log.d(tag, "Height spec: " + MeasureSpec.toString(heightMeasureSpec));

		int widthMode = MeasureSpec.getMode(widthMeasureSpec);
		int widthSize = MeasureSpec.getSize(widthMeasureSpec);

		int heightMode = MeasureSpec.getMode(heightMeasureSpec);
		int heightSize = MeasureSpec.getSize(heightMeasureSpec);

		int chosenWidth = chooseDimension(widthMode, widthSize);
		int chosenHeight = chooseDimension(heightMode, heightSize);

		int chosenDimension = Math.min(chosenWidth, chosenHeight);

		setMeasuredDimension(chosenDimension, chosenDimension);
	}

	/**
	 * DESCRIPTION:
	 * Selects view size based on specified MesaureSpec mode.
	 * @param mode - the MesasureSpec mode integer.
	 * @param size - the desired view size integer.
	 * @return - the selected view size integer.
	 */
	private int chooseDimension(int mode, int size) {
		if (mode == MeasureSpec.AT_MOST || mode == MeasureSpec.EXACTLY) {
			return size;
		} else { // (mode == MeasureSpec.UNSPECIFIED)
			return getPreferredSize();
		} 
	}

	/**
	 * DESCRIPTION:
	 * Returns a preferred size for the view in case size
	 * is not specified.
	 * @return - preferred view size integer.
	 */
	private int getPreferredSize() {
		return 200;
	}

	/**
	 * DESCRIPTION:
	 * Calculates the angle to draw the hand on the canvas given the hand position.
	 * @param position - the hand position (range = 0.0 to 1.0).
	 * @return - the angle to draw the hand (range = -50 to +50 degrees)
	 */
	private float positionToAngle(float position) {
		// range for hand angle is 100 degrees
		//   empty position (0.0) = -50 degrees (left)
		//   half position  (0.5) =   0 degrees (straight up)
		//   full position  (1.0) = +50 degrees (right)
		final int RANGE = 100;
		return (position - halfPosition) * RANGE;
	}
	
	/**
	 * DESCRIPTION:
	 * Draws the image of the gauge's hand on a canvas to reflect its 
	 * current position. 
	 * @param canvas - the canvas to draw the hand image on.
	 */
	private void drawHand(Canvas canvas) {
		float handAngle = positionToAngle(handPosition);
		canvas.save(Canvas.MATRIX_SAVE_FLAG);
		canvas.rotate(handAngle, 0.5f, 0.65f);
		canvas.drawPath(handPath, handPaint);
		canvas.restore();
	}

	/**
	 * DESCRIPTION:
	 * Draws the background image for the gauge on a canvas (gauge rim, meter, etc).
	 * @param canvas - the canvas to draw the background image on.
	 */
	private void drawBackground(Canvas canvas) {
		final String tag = TAG + ".drawBackground()";
		if (background == null) {
			Log.w(tag, "Background not created");
		} else {
			canvas.drawBitmap(background, 0, 0, backgroundPaint);
		}
	}

	/**
	 * DESCRIPTION:
	 * Draws the view.
	 * @see android.view.View#onDraw(android.graphics.Canvas)
	 */
	@Override
	protected void onDraw(Canvas canvas) {
		drawBackground(canvas);

		float scale = (float) getWidth();		
		canvas.save(Canvas.MATRIX_SAVE_FLAG);
		canvas.scale(scale, scale);
		drawHand(canvas);
		canvas.restore();

		if (handNeedsToMove()) {
			moveHand();
		}
	}

	/**
	 * DESCRIPTION:
	 * Called during layout when the size of this view has changed.
	 * @see android.view.View#onSizeChanged(int, int, int, int)
	 */
	@Override
	protected void onSizeChanged(int w, int h, int oldw, int oldh) {
		final String tag = TAG + ".onSizeChanged()";
		Log.d(tag, "Size changed to " + w + "x" + h);
		regenerateBackground();
	}

	/**
	 * DESCRIPTION:
	 * Creates the background image bitmap from an image file and scales it 
	 * to fit the current size of the view.
	 */
	private void regenerateBackground() {
		
		// free the old bitmap
		if (background != null) {
			background.recycle();
		}

		float scale = (float) getWidth();
		Bitmap image = BitmapFactory.decodeResource(getResources(), R.drawable.gauge_background);
		background = Bitmap.createScaledBitmap(image, (int)scale, (int)scale, false);
		Canvas backgroundCanvas = new Canvas(background);
		backgroundCanvas.scale(scale, scale);
	}

	/**
	 * DESCRIPTION:
	 * Determines if the gauge hand needs to move in order to be at the target position.
	 * @return - boolean (true = needs to move)
	 */
	private boolean handNeedsToMove() {
		return Math.abs(handPosition - handTarget) > 0.01f;
	}

	/**
	 * DESCRIPTION:
	 * Simulates real analog gauge hand movement by periodically moving the gauge 
	 * hand from its current position toward its target position given the two 
	 * positions and the dynamic physics model attributes defined for hand 
	 * movement (acceleration, velocity, etc).
	 */
	private void moveHand() {
		if (! handNeedsToMove()) {
			return;
		}

		if (lastHandMoveTime != -1L) {
			long currentTime = System.currentTimeMillis();
			float delta = (currentTime - lastHandMoveTime) / 1000.0f;

			float direction = Math.signum(handVelocity);
			if (Math.abs(handVelocity) < 90.0f) {
				handAcceleration = 5.0f * (handTarget - handPosition);
			} else {
				handAcceleration = 0.0f;
			}
			handPosition += handVelocity * delta;
			handVelocity += handAcceleration * delta;
			if ((handTarget - handPosition) * direction < 0.01f * direction) {
				handPosition = handTarget;
				handVelocity = 0.0f;
				handAcceleration = 0.0f;
				lastHandMoveTime = -1L;
			} else {
				lastHandMoveTime = System.currentTimeMillis();				
			}
			invalidate();
		} else {
			lastHandMoveTime = System.currentTimeMillis();
			moveHand();
		}
	}

	/**
	 * DESCRIPTION:
	 * Sets the target position for the gauge hand to a specified value. 
	 * Invalidates the view to cause the hand to start moving from its 
	 * current position toward the target position.
	 * @param position - the desired target hand position.
	 */
	public void setHandTarget(float position) {
		if (position < emptyPosition) {
			position = emptyPosition;
		} else if (position > fullPosition) {
			position = fullPosition;
		}
		handTarget = position;
		invalidate();
	}
	
	/**
	 * DESCRIPTION:
	 * Sets the current position for the gauge hand to a specified value. 
	 * Invalidates the view to cause the hand to immediately be drawn at
	 * the new position.
	 * @param position - the desired hand position.
	 */
	public void setHandPosition(float position) {
		if (position < emptyPosition) {
			position = emptyPosition;
		} else if (position > fullPosition) {
			position = fullPosition;
		}
		handTarget = handPosition = position;
		invalidate();
	}
	
	/**
	 * DESCRIPTION:
	 * Returns the current position of the gauge hand.
	 * @return - the hand position (float, range 0.0 [empty] to 1.0 [full])
	 */
	public float getHandPosition() {
		return this.handPosition;
	}
	
	/**
	 * DESCRIPTION:
	 * Setter for a flag specifying whether the gauge is interactive,
	 * (i.e. allows user to change hand position)
	 * @param interactive - true = allows gauge hand changes.
	 */
	public void setInteractive(boolean interactive) {
		this.interactive = interactive;
	}
	
	/**
	 * DESCRIPTION:
	 * Called when the screen is touched. Moves the gauge hand accordingly.
	 * @see android.view.View#onTouchEvent(android.view.MotionEvent)
	 */
	@Override
	public boolean onTouchEvent(MotionEvent event) {
		
		if (!interactive) return false;
		
		final String tag = TAG + ".onTouchEvent()";
		final float EMPTYX = 0.2f;  // the scaled x-coordinate of the E on the gauge background
		final float FULLX = 0.8f;   // the scaled x-coordinate of the F on the gauge background
		
		switch (event.getAction()) {
	    case MotionEvent.ACTION_DOWN:
	    case MotionEvent.ACTION_MOVE:
	    case MotionEvent.ACTION_UP:
	    	
			// get the scaled x-coordinate where the screen was touched 
	    	// (0.0 or less = far left, 1.0 or greater = far right)
	    	float x = event.getX() / getWidth();
	    	
	    	// adjust x to keep it within the E-F meter displayed as the background gauge image 
	    	// (if you touch outside the meter, it should snap to the appropriate min/max position)
			if (x > FULLX) x = FULLX;
			if (x < EMPTYX) x = EMPTYX;
			
			// calculate the desired gauge hand position from the x value
			float position = (x - EMPTYX) / (FULLX - EMPTYX);
			//Log.d(tag, String.format("getX()=%f getWidth()=%d x=%f position=%f", event.getX(),getWidth(),x,position));
			
			// move the hand to the new position
			setHandPosition(position);
			
			// if gesture has finished, notify listener of new hand position 
			if ((event.getAction() == MotionEvent.ACTION_UP) && 
				(handPositionChangedListener != null)) {
				Log.d(tag,String.format("handPosition=%f",handPosition));
				handPositionChangedListener.onHandPositionChanged(this,handPosition);
			}
	    	return true;
	    }
	    return false;
	}

}
