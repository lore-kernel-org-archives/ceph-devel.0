From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [qemu-iotests][PATCH] Update rbd support
Date: Tue, 12 Apr 2011 17:47:45 -0700
Message-ID: <1302655665-30101-1-git-send-email-josh.durgin@dreamhost.com>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49755 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab1DMAsj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 20:48:39 -0400
In-Reply-To: <cover.1302653035.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>

rbd is not growable, so test 016 is skipped.

rbd implements bdrv_truncate, so test 025 will work.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 016 |    4 ++++
 025 |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/016 b/016
index 16f151f..8fa921f 100755
--- a/016
+++ b/016
@@ -43,6 +43,10 @@ _supported_fmt raw
 _supported_proto generic
 _supported_os Linux
 
+# rbd images are not growable
+if [ "$IMGPROTO" = "rbd" ]; then
+    _notrun "image protocol $IMGPROTO does not support growable images"
+fi
 
 size=128M
 _make_test_img $size
diff --git a/025 b/025
index fba44a4..691b6da 100755
--- a/025
+++ b/025
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt raw qcow2
-_supported_proto file sheepdog
+_supported_proto file sheepdog rbd
 _supported_os Linux
 
 echo "=== Creating image"
-- 
1.7.2.3

