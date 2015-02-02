
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package onyx.util.tween.easing {

/**
 *  The Linear class defines easing functions to implement 
 *  linear motion with Flex effect classes. 
 *
 *  For more information, see http://www.robertpenner.com/profmx.
 */  
final public class Linear
{
	

	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------
	
    /**
     *  The <code>easeNone()</code> method defines a constant motion, 
     *  with no acceleration. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
     */  
	public function easeNone(t:Number, b:Number,
									c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeIn()</code> method starts motion from zero velocity, 
     *  and then accelerates motion as it executes. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
     */  
	public function easeIn(t:Number, b:Number,
								  c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeOut()</code> method starts motion fast, 
     *  and then decelerates motion to a zero velocity as it executes. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
     */  
	public function easeOut(t:Number, b:Number,
								   c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeInOut()</code> method combines the motion 
     *  of the <code>easeIn()</code> and <code>easeOut()</code> methods
	 *  to start the motion from zero velocity, accelerate motion, 
	 *  then decelerate back to zero velocity. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
     */  
	public function easeInOut(t:Number, b:Number,
									 c:Number, d:Number):Number
	{
		return c * t / d + b;
	}
}

}