From: Josh Durgin <joshd@hq.newdream.net>
Subject: [PATCH 2/2] tests: Add tests for network disks
Date: Tue, 07 Dec 2010 11:57:33 -0800
Message-ID: <4CFE91AD.9050206@hq.newdream.net>
References: <20101202131928.GV2502@redhat.com> <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55039 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0LGT5d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 14:57:33 -0500
In-Reply-To: <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org


Signed-off-by: Josh Durgin <joshd@hq.newdream.net>
---
 tests/qemuargv2xmltest.c                           |    3 ++
 .../qemuxml2argv-disk-drive-network-nbd.args       |    1 +
 .../qemuxml2argv-disk-drive-network-nbd.xml        |   32 ++++++++++++++++++
 .../qemuxml2argv-disk-drive-network-rbd.args       |    1 +
 .../qemuxml2argv-disk-drive-network-rbd.xml        |   34 ++++++++++++++++++++
 .../qemuxml2argv-disk-drive-network-sheepdog.args  |    1 +
 .../qemuxml2argv-disk-drive-network-sheepdog.xml   |   32 ++++++++++++++++++
 tests/qemuxml2argvtest.c                           |    6 +++
 8 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml

diff --git a/tests/qemuargv2xmltest.c b/tests/qemuargv2xmltest.c
index d941b0b..adff05a 100644
--- a/tests/qemuargv2xmltest.c
+++ b/tests/qemuargv2xmltest.c
@@ -173,6 +173,9 @@ mymain(int argc, char **argv)
     DO_TEST("disk-drive-cache-v2-wt");
     DO_TEST("disk-drive-cache-v2-wb");
     DO_TEST("disk-drive-cache-v2-none");
+    DO_TEST("disk-drive-network-nbd");
+    DO_TEST("disk-drive-network-rbd");
+    DO_TEST("disk-drive-network-sheepdog");
     DO_TEST("disk-usb");
     DO_TEST("graphics-vnc");

diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args
new file mode 100644
index 0000000..75d74ab
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args
@@ -0,0 +1 @@
+LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test /usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive file=nbd:example.org:6000,if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml
new file mode 100644
index 0000000..863165d
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml
@@ -0,0 +1,32 @@
+<domain type='qemu'>
+  <name>QEMUGuest1</name>
+  <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
+  <memory>219200</memory>
+  <currentMemory>219200</currentMemory>
+  <vcpu>1</vcpu>
+  <os>
+    <type arch='i686' machine='pc'>hvm</type>
+    <boot dev='hd'/>
+  </os>
+  <clock offset='utc'/>
+  <on_poweroff>destroy</on_poweroff>
+  <on_reboot>restart</on_reboot>
+  <on_crash>destroy</on_crash>
+  <devices>
+    <emulator>/usr/bin/qemu</emulator>
+    <disk type='block' device='disk'>
+      <source dev='/dev/HostVG/QEMUGuest1'/>
+      <target dev='hda' bus='ide'/>
+      <address type='drive' controller='0' bus='0' unit='0'/>
+    </disk>
+    <disk type='network' device='disk'>
+      <driver name='qemu' type='raw'/>
+      <source protocol='nbd'>
+        <host name='example.org' port='6000'/>
+      </source>
+      <target dev='vda' bus='virtio'/>
+    </disk>
+    <controller type='ide' index='0'/>
+    <memballoon model='virtio'/>
+  </devices>
+</domain>
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
new file mode 100644
index 0000000..7e19beb
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
@@ -0,0 +1 @@
+LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test CEPH_ARGS=-m mon1.example.org:6321,mon2.example.org:6322,mon3.example.org:6322 /usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive file=rbd:pool/image,if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
new file mode 100644
index 0000000..118d890
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
@@ -0,0 +1,34 @@
+<domain type='qemu'>
+  <name>QEMUGuest1</name>
+  <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
+  <memory>219200</memory>
+  <currentMemory>219200</currentMemory>
+  <vcpu>1</vcpu>
+  <os>
+    <type arch='i686' machine='pc'>hvm</type>
+    <boot dev='hd'/>
+  </os>
+  <clock offset='utc'/>
+  <on_poweroff>destroy</on_poweroff>
+  <on_reboot>restart</on_reboot>
+  <on_crash>destroy</on_crash>
+  <devices>
+    <emulator>/usr/bin/qemu</emulator>
+    <disk type='block' device='disk'>
+      <source dev='/dev/HostVG/QEMUGuest1'/>
+      <target dev='hda' bus='ide'/>
+      <address type='drive' controller='0' bus='0' unit='0'/>
+    </disk>
+    <disk type='network' device='disk'>
+      <driver name='qemu' type='raw'/>
+      <source protocol='rbd' name='pool/image'>
+        <host name='mon1.example.org' port='6321'/>
+        <host name='mon2.example.org' port='6322'/>
+        <host name='mon3.example.org' port='6322'/>
+      </source>
+      <target dev='vda' bus='virtio'/>
+    </disk>
+    <controller type='ide' index='0'/>
+    <memballoon model='virtio'/>
+  </devices>
+</domain>
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args
new file mode 100644
index 0000000..147378f
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args
@@ -0,0 +1 @@
+LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test /usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive file=sheepdog:example.org:6000:image,if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml
new file mode 100644
index 0000000..5313d75
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml
@@ -0,0 +1,32 @@
+<domain type='qemu'>
+  <name>QEMUGuest1</name>
+  <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
+  <memory>219200</memory>
+  <currentMemory>219200</currentMemory>
+  <vcpu>1</vcpu>
+  <os>
+    <type arch='i686' machine='pc'>hvm</type>
+    <boot dev='hd'/>
+  </os>
+  <clock offset='utc'/>
+  <on_poweroff>destroy</on_poweroff>
+  <on_reboot>restart</on_reboot>
+  <on_crash>destroy</on_crash>
+  <devices>
+    <emulator>/usr/bin/qemu</emulator>
+    <disk type='block' device='disk'>
+      <source dev='/dev/HostVG/QEMUGuest1'/>
+      <target dev='hda' bus='ide'/>
+      <address type='drive' controller='0' bus='0' unit='0'/>
+    </disk>
+    <disk type='network' device='disk'>
+      <driver name='qemu' type='raw'/>
+      <source protocol='sheepdog' name='image'>
+        <host name='example.org' port='6000'/>
+      </source>
+      <target dev='vda' bus='virtio'/>
+    </disk>
+    <controller type='ide' index='0'/>
+    <memballoon model='virtio'/>
+  </devices>
+</domain>
diff --git a/tests/qemuxml2argvtest.c b/tests/qemuxml2argvtest.c
index 5fe91f1..bb184fc 100644
--- a/tests/qemuxml2argvtest.c
+++ b/tests/qemuxml2argvtest.c
@@ -302,6 +302,12 @@ mymain(int argc, char **argv)
             QEMUD_CMD_FLAG_DRIVE_CACHE_V2 | QEMUD_CMD_FLAG_DRIVE_FORMAT, false);
     DO_TEST("disk-drive-cache-v2-none", QEMUD_CMD_FLAG_DRIVE |
             QEMUD_CMD_FLAG_DRIVE_CACHE_V2 | QEMUD_CMD_FLAG_DRIVE_FORMAT, false);
+    DO_TEST("disk-drive-network-nbd", QEMUD_CMD_FLAG_DRIVE |
+            QEMUD_CMD_FLAG_DRIVE_FORMAT, false);
+    DO_TEST("disk-drive-network-rbd", QEMUD_CMD_FLAG_DRIVE |
+            QEMUD_CMD_FLAG_DRIVE_FORMAT, false);
+    DO_TEST("disk-drive-network-sheepdog", QEMUD_CMD_FLAG_DRIVE |
+            QEMUD_CMD_FLAG_DRIVE_FORMAT, false);
     DO_TEST("disk-usb", 0, false);
     DO_TEST("disk-usb-device", QEMUD_CMD_FLAG_DRIVE |
             QEMUD_CMD_FLAG_DEVICE | QEMUD_CMD_FLAG_NODEFCONFIG, false);
-- 
1.5.6.5


