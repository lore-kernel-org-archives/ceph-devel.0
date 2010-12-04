From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: ioctl compatibility
Date: Sat, 4 Dec 2010 15:17:51 -0800
Message-ID: <FB06A065-2077-41B8-9C55-74C5234DDFAC@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44109 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab0LDXRw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 18:17:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Gregory Farnum <gregf@hq.newdream.net>

Hi Greg,

I noticed this patch changed the CEPH_IOCTL_MAGIC to 0x98, and is also synchronized with the user space Ceph tree, but the Ceph client that ships with Ubuntu 10.10 uses 0x97. There wasn't a change made by this patch to Documentation/ioctl/ioctl-numbers.txt, so I was curious if this was an oversight, and if not, how the userspace code could be made to adapt for the kernel shipping with 10.10.

Thanks,
Noah


--- a/fs/ceph/ioctl.h
+++ b/fs/ceph/ioctl.h
@@ -4,7 +4,7 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
-#define CEPH_IOCTL_MAGIC 0x97
+#define CEPH_IOCTL_MAGIC 0x98
 
 /* just use u64 to align sanely on all archs */
 struct ceph_ioctl_layout {
@@ -17,6 +17,8 @@ struct ceph_ioctl_layout {
                                   struct ceph_ioctl_layout)
 #define CEPH_IOC_SET_LAYOUT _IOW(CEPH_IOCTL_MAGIC, 2,          \
                                   struct ceph_ioctl_layout)
+#define CEPH_IOC_SET_LAYOUT_POLICY _IOW(CEPH_IOCTL_MAGIC, 5,   \
+                                  struct ceph_ioctl_layout)
 
 /*
  * Extract identity, address of the OSD and object storing a given