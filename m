From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/8] ceph: update MAINTAINERS file
Date: Mon, 30 Jul 2012 08:59:25 -0700
Message-ID: <1343663971-3221-3-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45764 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2G3P7l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:41 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

 * shiny new inktank.com email addresses
 * add include/linux/crush directory (previous oversight)

Signed-off-by: Sage Weil <sage@inktank.com>
---
 MAINTAINERS |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe643e7..b8af81a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1761,15 +1761,16 @@ F:	arch/powerpc/oprofile/*cell*
 F:	arch/powerpc/platforms/cell/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT
-M:	Sage Weil <sage@newdream.net>
+M:	Sage Weil <sage@inktank.com>
 L:	ceph-devel@vger.kernel.org
-W:	http://ceph.newdream.net/
+W:	http://ceph.ceph/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
 S:	Supported
 F:	Documentation/filesystems/ceph.txt
 F:	fs/ceph
 F:	net/ceph
 F:	include/linux/ceph
+F:	include/linux/crush
 
 CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
 L:	linux-usb@vger.kernel.org
@@ -5596,8 +5597,8 @@ F:	arch/hexagon/
 
 RADOS BLOCK DEVICE (RBD)
 F:	include/linux/qnxtypes.h
-M:	Yehuda Sadeh <yehuda@hq.newdream.net>
-M:	Sage Weil <sage@newdream.net>
+M:	Yehuda Sadeh <yehuda@inktank.com>
+M:	Sage Weil <sage@inktank.com>
 M:	ceph-devel@vger.kernel.org
 S:	Supported
 F:	drivers/block/rbd.c
-- 
1.7.9.5

