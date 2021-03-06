Gobi2000 network driver for Dell 1.0.130
10/15/2010

This readme covers important information concerning 
the QCUSBNet2kDell driver, provided in correlation with
the Gobi2000-Linux-Package.

Table of Contents

1. Prerequisites
2. Installation instructions
3. What's new in this release
4. Notes
5. Known issues
6. Known platform issues

-------------------------------------------------------------------------------

1. PREREQUISITES

a. Kernel headers or full kernel source installed for the currently 
   running kernel.  There must be a link "/lib/modules/<uname -r>/build"
   that points to these kernel headers or sources.
b. The kernel must support the usbcore and usbnet drivers, either as
   modules or built into the kernel.
c. Tools required for building the kernel.  These tools usually come in a 
   package called "kernel-devel".
d. "gcc" compiler
e. "make" tool

-------------------------------------------------------------------------------

2. INSTALLATION INSTRUCTIONS

a. Navigate to the folder "QCUSBNet2k" that contains:
      Makefile
      QCUSBNetDell.c
      QMIDevice.c
      QMIDevice.h
      Structs.h
      QMI.c
      QMI.h
b. (only required for kernels prior to 2.6.25) Create a symbolic link 
   to the usbnet.h file in your kernel sources:
      ln -s <linux sources>/drivers/net/usb/usbnet.h ./
c. Run the command:
      make
d. Copy the newly created QCUSBNet2kDell.ko into the directory
   /lib/modules/`uname -r`/kernel/drivers/net/usb/
e. Run the command:
      depmod
f. (Optional) Load the driver manually with the command:
      modprobe QCUSBNet2kDell
   - This is only required the first time after you install the
     drivers.  If you restart or plug the Gobi device in the drivers 
     will be automatically loaded.

-------------------------------------------------------------------------------

3. WHAT'S NEW

This Release (Gobi2000 network driver for Dell 1.0.130) 10/15/2010
a. Fix possible kernel WARNING if device removed before QCWWANDisconnect().
b. Fix multiple memory leaks in error cases.
c. Fix possible deadlock during error case in driver initialization.

Prior Release (Gobi2000 network driver for Dell 1.0.120) 08/16/2010
a. Change semaphore to completion type for thread notification.
b. Add safeEnumDelay parameter to allow users to disable enumeration delay.
c. Correct error handling during enumeration.
d. Prevent possible initialization hang when using uhci-hcd driver.

Prior Release (Gobi2000 network driver for Dell 1.0.110) 06/18/2010
a. Correctly initialize semaphore during probe function.

Prior Release (Gobi2000 network driver for Dell 1.0.100) 06/02/2010
a. Merge QCQMI driver into QCUSBNet2k driver, removing dependency.

Prior Release (Gobi2000 network driver for Dell 1.0.90) 05/13/2010
a. Fix UserspaceClose() from a thread
b. Add 2.6.33 kernel support

Prior Release (Gobi2000 network driver for Dell 1.0.80) 04/19/2010
a. Add support to check for duplicate or out of sequence QMI messages.

Prior Release (Gobi2000 network driver for Dell 1.0.70) 03/15/2010
a. Added support for CDC CONNECTION_SPEED_CHANGE indication.
b. Modified device cleanup function to better handle the device
   losing power during suspend or hibernate.
c. Replaced autosuspend feature with more aggressive "Selective suspend"
   style power management.  Even if QCWWAN2k or Network connections are
   active the device will still enter autosuspend after the delay time,
   and wake on remote wakeup or new data being sent.

Prior Release (Gobi2000 Serial driver for Dell 1.0.60) 02/16/2010
a. Fix to allow proper fork() functionality
b. Add supports_autosuspend flag
c. Ignore EOVERFLOW errors on interrupt endpoint and resubmit URB
d. Change driver versions to match installer package
e. Minor update for 2.6.23 kernel compatibility

Prior Release (in correlation with Gobi2000-Linux-Package 1.0.30) 12/04/2009
a. Modify ioctl numbering to avoid conflict in 2.6.31 kernel
   This release is only compatible with GOBI2000_LINUX_SDK 1.0.30 and newer.
b. Made minor compatibility changes for 2.6.31 kernel

Prior Release (in correlation with Gobi2000-Linux-Package 1.0.20) 11/20/2009
a. Initial release

-------------------------------------------------------------------------------

4. NOTES

a. In Composite mode, the Gobi device will enumerate a network interface
   usb<#> where <#> signifies the next available USB network interface.
b. In Composite mode, the Gobi device will enumerate a device node
   /dev/qcqmi<#>.  This device node is for use by the QCWWANCMAPI2k.
c. Ownership, group, and permissions are managed by your system 
   configuration.

-------------------------------------------------------------------------------

4. KNOWN ISSUES

No known issues.
         
-------------------------------------------------------------------------------

4. KNOWN PLATFORM ISSUES

a. Enabling autosuspend:
   Autosuspend is supported by the Gobi2000 module and its drivers, 
   but by default it is not enabled by the open source kernel. As such,
   the Gobi2000 module will not enter autosuspend unless the
   user specifically turns on autosuspend with the command:
      echo auto > /sys/bus/usb/devices/.../power/level
b. Ksoftirq using 100% CPU:
   There is a known issue with the open source usbnet driver that can 
   result in infinite software interrupts. The fix for this is to test 
   (in the usbnet_bh() function) if the usb_device can submit URBs before 
   attempting to submit the response URB buffers.
   
-------------------------------------------------------------------------------



