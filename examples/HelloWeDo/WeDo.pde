/**
 * Example showing how to use Java library for LEGO WeDo
 * https://github.com/kjkoster/lego-wedo-java
 * Library requires HIDAPI (HID library for Java) and Guava (Google Core Libraries for Java).
 */

// HIDAPI
import com.codeminders.hidapi.*;

// Guava
import com.google.common.annotations.*;
import com.google.common.base.*;
import com.google.common.base.internal.*;
import com.google.common.cache.*;
import com.google.common.collect.*;
import com.google.common.escape.*;
import com.google.common.eventbus.*;
import com.google.common.hash.*;
import com.google.common.html.*;
import com.google.common.io.*;
import com.google.common.math.*;
import com.google.common.net.*;
import com.google.common.primitives.*;
import com.google.common.reflect.*;
import com.google.common.util.concurrent.*;
import com.google.common.xml.*;
import com.google.thirdparty.publicsuffix.*;

// WeDo
import org.kjkoster.wedo.usb.*;
import org.kjkoster.wedo.bricks.*;
import org.kjkoster.wedo.*;
import org.kjkoster.wedo.activities.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

class WeDo {
  
  PApplet parent;
  WeDoBricks weDoBricks = null;
  boolean verbose = false;

  // Constructor
  WeDo(PApplet p) {
    parent = p;
    try {
        final Usb usb = new Usb(verbose);
        weDoBricks = new WeDoBricks(usb, verbose);
    } catch (Exception e) { }
  }
  
  Map<Handle, Brick[]> listHubs() {
    final Map<Handle, Brick[]> hubs = weDoBricks.readAll();
    if(verbose) {
      if (hubs.size() == 0) {
          println("No LEGO WeDo hubs found.");
      } else {
          for (final Map.Entry<Handle, Brick[]> hub : hubs.entrySet()) {
              println(hub.getKey().getProductName());
          }
      }
    }
    return hubs;
  }
  
  float getDistance(final boolean isA) {
      final Map<Handle, Brick[]> hubs = listHubs();
      Brick brick;
      float sensorData = 0;
      for (final Map.Entry<Handle, Brick[]> hub : hubs.entrySet()) {
        if (isA) { brick = hub.getValue()[0]; }
        else { brick = hub.getValue()[1]; }
        switch (brick.getType()) {
          case DISTANCE:
            sensorData = brick.getDistance().getCm();
            break;
          case TILT:
          default:
            sensorData = 0;
        }
      }
      return sensorData;
  }
  
  void setMotor(final boolean isA,int speed) {
    if (isA) { weDoBricks.motorA(parseByte(speed)); }
    else { weDoBricks.motorB(parseByte(speed)); }
  }
  
  float getTilt(final boolean isA) {
    final Map<Handle, Brick[]> hubs = listHubs();
    Brick brick;
    float sensorData = 0;
    for (final Map.Entry<Handle, Brick[]> hub : hubs.entrySet()) {
      if (isA) { brick = hub.getValue()[0]; }
      else { brick = hub.getValue()[1]; }
      switch (brick.getType()) {
        case TILT:
          sensorData = brick.getTilt().getValue() & 0xff;
          break;
        case DISTANCE:
        default:
          sensorData = 0;
      }
    }
    return sensorData;
  }
  
  String getDirection(final boolean isA) {
    String sensorData = null;
    float tilt = getTilt(isA);
    if (tilt < 4) { sensorData = "NO_TILT"; }
    else if (tilt > 10 && tilt < 40) { sensorData = "BACKWARD"; }
    else if (tilt > 60 && tilt < 90) { sensorData =  "RIGHT"; }
    else if (tilt > 117 && tilt < 140) { sensorData = "NO_TILT"; }
    else if (tilt > 151 && tilt < 190) { sensorData = "FORWARD"; }
    else if (tilt > 203 && tilt < 240) { sensorData = "LEFT"; }
    if(verbose) { println(sensorData); }
    return sensorData;
  }

  void reset() { weDoBricks.reset(); }
}