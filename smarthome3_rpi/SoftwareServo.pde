/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Copyright (c) The Processing Foundation 2015
  Hardware I/O library developed by Gottfried Haider
  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.
  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.
  You should have received a copy of the GNU Lesser General
  Public License along with this library; if not, write to the
  Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA  02111-1307  USA
*/
import processing.core.*;
/**
 *  @webref
 */
public class SoftwareServo {

  public static final int DEFAULT_MAX_PULSE = 17000;
  public static final int DEFAULT_MIN_PULSE = (DEFAULT_MAX_PULSE/100);

  protected int pin = -1;                     // gpio number (-1 .. not attached)
  protected int buffer_pin = -1;
  protected boolean turn_on = false;
  protected long handle = -1;                 // native thread id (<0 .. not started)
  protected int period = DEFAULT_MAX_PULSE;   // 10 ms (100 Hz)
  protected int minPulse = 0;                 // minimum pulse width in microseconds
  protected int maxPulse = 0;                 // maximum pulse width in microseconds
  protected int pulse = 0;                    // current pulse in microseconds


  /**
   *  Opens a servo motor
   *  @param parent typically use "this"
   *  @webref
   */
  public SoftwareServo(PApplet parent, int pin) {
    NativeInterface.loadLibrary();
    
    this.buffer_pin = pin;
    //attach(pin);
  }


  /**
   *  Closes a servo motor
   *  @webref
   */
  public void close() {
    detach();
  }


  protected void finalize() throws Throwable {
    try {
      close();
    } finally {
      super.finalize();
    }
  }


  /**
   *  Attaches a servo motor to a GPIO pin
   *  @param pin GPIO pin
   *  @webref
   */
  public void attach(int pin) {
    detach();
    this.pin = pin;
    this.minPulse = DEFAULT_MIN_PULSE;
    this.maxPulse = DEFAULT_MAX_PULSE;
  }


  /**
   *  Attaches a servo motor to a GPIO pin using custom pulse widths
   *  @param minPulse minimum pulse width in microseconds (default: 544, same as on Arduino)
   *  @param maxPulse maximum pulse width in microseconds (default: 2400, same as on Arduino)
   *  @webref
   */
  public void attach(int pin, int minPulse, int maxPulse) {
    detach();
    this.pin = pin;
    this.minPulse = minPulse;
    this.maxPulse = maxPulse;
  }


  /**
   *  Moves a servo motor to a given orientation
   *  @param angle angle in degrees (controls speed and direction on continuous-rotation servos)
   *  @webref
   */
public void write(float angle) 
{
    if ( (angle>0) & (turn_on == false) )
    {
      pin = buffer_pin;
      attach(pin);
      turn_on = true;
    }
    
    if (angle == 0)
    {
      detach();
      turn_on = false;
    }
    
  if (turn_on == true)
  {
    if (attached() == false) {
      System.err.println("You need to call attach(pin) before write(angle).");
      throw new RuntimeException("Servo is not attached");
    }

    if (angle < 0 || 180 < angle) {
      System.err.println("Only degree values between 0 and 180 can be used.");
      throw new IllegalArgumentException("Illegal value");
    }
    pulse = (int)(minPulse + (angle/180.0) * (maxPulse-minPulse));

    if (handle < 0) {
      // start a new thread
      GPIO.pinMode(pin, GPIO.OUTPUT);
      if (NativeInterface.isSimulated()) {
        return;
      }
      handle = NativeInterface.servoStartThread(pin, pulse, period);
      if (handle < 0) {
        throw new RuntimeException(NativeInterface.getError((int)handle));
      }
    } else {
      // thread already running
      int ret = NativeInterface.servoUpdateThread(handle, pulse, period);
      if (ret < 0) {
        throw new RuntimeException(NativeInterface.getError(ret));
      }
    }
    
  }
}


  /**
   *  Returns whether a servo motor is attached to a pin
   *  @return true if attached, false is not
   *  @webref
   */
  public boolean attached() {
    return (pin != -1);
  }


  /**
   *  Detatches a servo motor from a GPIO pin
   *  @webref
   */
  public void detach() {
    if (0 <= handle) {
      // stop thread
      int ret = NativeInterface.servoStopThread(handle);
      GPIO.pinMode(pin, GPIO.INPUT);
      handle = -1;
      pin = -1;
      if (ret < 0) {
        throw new RuntimeException(NativeInterface.getError(ret));
      }
    }
  }
}
