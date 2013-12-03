From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 3/3] rbd: document rbd-specific options
Date: Tue,  3 Dec 2013 15:12:53 -0800
Message-ID: <1386112373-25610-4-git-send-email-josh.durgin@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53153 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab3LDAFa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 19:05:30 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 64FE82667A
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5862726680
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
In-Reply-To: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd_full_behavior only affects rbd, so document it along with
read-only and read-write.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 0a30647..15f3ba6 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -18,6 +18,25 @@ Removal of a device:
 
   $ echo <dev-id> > /sys/bus/rbd/remove
 
+Options
+-------
+
+read_only/ro
+
+	The mapped device will only handle reads. This is the default for
+	snapshots.
+
+read_write/rw
+
+	The mapped device will handle reads and writes. This is invalid
+	for snapshots.
+
+osd_full_behavior
+
+	Choose how to handle writes to a full ceph cluster. Options are
+	"block" to pause I/O until there is space (the default), or
+	"error", to return an I/O error.
+
 Entries under /sys/bus/rbd/devices/<dev-id>/
 --------------------------------------------
 
-- 
1.7.10.4

