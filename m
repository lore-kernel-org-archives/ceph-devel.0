From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/2] rbd: don't ignore return value of system()
Date: Sun, 27 Jan 2013 21:57:32 +0100
Message-ID: <1359320252-2445-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:60526 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756194Ab3A0U5h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 15:57:37 -0500
In-Reply-To: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Check for the return value of system() and handle the error if needed

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rbd.cc | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 833188a..bdbc684 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -1428,8 +1428,16 @@ static int do_kernel_add(const char *poolname, const char *imgname,
 
   // modprobe the rbd module if /sys/bus/rbd doesn't exist
   struct stat sb;
-  if ((stat("/sys/bus/rbd", &sb) < 0) || (!S_ISDIR(sb.st_mode)))
-    system("/sbin/modprobe rbd");
+  if ((stat("/sys/bus/rbd", &sb) < 0) || (!S_ISDIR(sb.st_mode))) {
+    r = system("/sbin/modprobe rbd");
+    if (r) {
+      if (r < 0)  
+        cerr << "rbd: error executing modprobe as shell command!" << std::endl;
+      else
+        cerr << "rbd: modprobe rbd failed! (" << r << ")" <<std::endl;
+      return r;
+    }
+  }
 
   // write to /sys/bus/rbd/add
   int fd = open("/sys/bus/rbd/add", O_WRONLY);
@@ -1448,8 +1456,16 @@ static int do_kernel_add(const char *poolname, const char *imgname,
   close(fd);
 
   // let udevadm do its job before we return
-  if (udevadm_settle)
-    system("/sbin/udevadm settle");
+  if (udevadm_settle) {
+    r = system("/sbin/udevadm settle");
+    if (r) {
+      if (r < 0)  
+        cerr << "rbd: error executing udevadm as shell command!" << std::endl;
+      else
+        cerr << "rbd: '/sbin/udevadm settle' failed! (" << r << ")" <<std::endl;
+      return r;
+    }
+  }
 
   return r;
 }
@@ -1664,8 +1680,16 @@ static int do_kernel_rm(const char *dev)
   r = close(fd);
 
   // let udevadm finish, if present
-  if (udevadm_settle)
-    system("/sbin/udevadm settle");
+  if (udevadm_settle){
+    r = system("/sbin/udevadm settle");
+    if (r) {
+      if (r < 0)  
+        cerr << "rbd: error executing udevadm as shell command!" << std::endl;
+      else
+        cerr << "rbd: '/sbin/udevadm settle' failed! (" << r << ")" <<std::endl;
+      return r;
+    }
+  }
 
   if (r < 0)
     r = -errno;
-- 
1.8.1.1

