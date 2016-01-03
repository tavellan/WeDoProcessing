# WeDoProcessing

Java library and examples of using LEGO WeDo with Processing 3.

# Installation

Just clone and then copy the folder into the libraries folder of your Processing sketchbook. The sketchbook is where your sketches are saved.

WeDo Java Library requires HIDAPI (HID library for Java) and Guava (Google Core Libraries for Java). This repository contains those compiled JAR-libraries to use on a 64 bit Linux platform.

Writing udev rules (Linux)
-----------------------------
By default, LEGO WeDo hub get permissions that allow only root to write to the device.

To grant non-root users access to the device, create a file named /etc/udev/rules.d/wedo.rules with the following content:

```
ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0003", SUBSYSTEMS=="usb", ACTION=="add", MODE="0666"
```

Then unplug the device and plug it back in. It should be now accessible.

# References

 - https://github.com/kjkoster/lego-wedo-java
 - https://github.com/itdaniher/WeDoMore
 - https://github.com/Salaboy/lego-wedo4j
 - https://github.com/PetrGlad/lego-wedo4j
