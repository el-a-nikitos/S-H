import processing.core.*;

public class nikitos_PWM {

  public static final int DEFAULT_MIN_PULSE = 500;
  public static final int DEFAULT_MAX_PULSE = 9000;
  
  protected int period = 10000;     // 10 ms (100 Hz)
  protected int pin = -1;           // gpio number (-1 .. not attached)
  protected long handle = -1;       // native thread id (<0 .. not started)
  protected int minPulse = 0;       // minimum pulse width in microseconds
  protected int maxPulse = 0;       // maximum pulse width in microseconds
  protected int pulse = 0;          // current pulse in microseconds


  /**
   *  Opens a servo motor
   *  @param parent typically use "this"
   *  @webref
   */
  public nikitos_PWM(PApplet parent, int pin) {
    NativeInterface.loadLibrary();
    
    attach(pin);
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
  public void write(float angle) {
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
