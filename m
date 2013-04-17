From: Wido den Hollander <wido@42on.com>
Subject: [PATCH] docs: Update CloudStack RBD documentation
Date: Wed, 17 Apr 2013 22:11:32 +0200
Message-ID: <1366229492-17550-1-git-send-email-wido@42on.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([79.99.132.139]:42408 "EHLO
	wido-desktop.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S965338Ab3DQUTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 16:19:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@42on.com>


Signed-off-by: Wido den Hollander <wido@42on.com>
---
 doc/rbd/rbd-cloudstack.rst |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/rbd/rbd-cloudstack.rst b/doc/rbd/rbd-cloudstack.rst
index fb66978..b81660e 100644
--- a/doc/rbd/rbd-cloudstack.rst
+++ b/doc/rbd/rbd-cloudstack.rst
@@ -39,9 +39,9 @@ CloudStack integrates with Ceph's block devices to provide CloudStack with a
 back end for CloudStack's Primary Storage. The instructions below detail the
 setup for CloudStack Primary Storage.
 
-.. note:: We recommend installing with Ubuntu 12.04 or later so that 
+.. note:: We recommend installing with Ubuntu 13.04 or later so that 
    you can use package installation instead of having to compile 
-   QEMU from source.
+   libvirt from source.
    
 Installing and configuring QEMU for use with CloudStack doesn't require any
 special handling. Ensure that you have a running Ceph  cluster. Install QEMU and
@@ -53,8 +53,8 @@ higher (you may need to compile from source) and ensure it is running with Ceph.
 #. Also see `KVM Hypervisor Host Installation`_.
 
 
-.. note:: Raring Ringtail (13.04) will have ``libvirt`` verison 0.9.13 or higher
-   by default.
+.. note:: Raring Ringtail (13.04) will have ``libvirt`` version 0.9.13 or higher
+   with RBD storage pool support enabled by default.
 
 Create a Pool
 =============
@@ -104,8 +104,9 @@ created (e.g., ``cloudstack``).
 Limitations
 ===========
 
-- CloudStack will only bind to one monitor.
+- CloudStack will only bind to one monitor (You can however create a Round Robin DNS record over multiple monitors)
 - CloudStack does not support cloning snapshots.
+- You still need a (small) NFS based Primary Storage for the SystemVMs
 - You may need to compile ``libvirt`` to use version 0.9.13 with Ubuntu.
 
 
-- 
1.7.9.5

