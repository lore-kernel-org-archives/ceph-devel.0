From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] mkcephfs: Actually do a mkfs.btrfs
Date: Thu, 31 Mar 2011 19:59:40 +0200
Message-ID: <1301594380-27512-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:47971 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1CaSHl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 14:07:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/mkcephfs.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index b193528..834d776 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -273,7 +273,7 @@ if [ -n "$prepareosdfs" ]; then
     done
 
     modprobe btrfs || true
-    echo mkfs.btrfs $btrfs_devs
+    mkfs.btrfs $btrfs_devs
     btrfsctl -a
     mount -t btrfs $btrfs_opt $first_dev $btrfs_path
     chown $osd_user $btrfs_path
-- 
1.7.0.4

