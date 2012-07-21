From: Sage Weil <sage@inktank.com>
Subject: [PATCH 3/9] libceph: report socket read/write error message
Date: Fri, 20 Jul 2012 17:41:42 -0700
Message-ID: <1342831308-18815-4-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46562 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2GUAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:10 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We need to set error_msg to something useful before calling ceph_fault();
do so here for try_{read,write}().  This is more informative than

libceph: osd0 192.168.106.220:6801 (null)

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 12419a0..7105908 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2291,14 +2291,18 @@ restart:
 	ret = try_read(con);
 	if (ret == -EAGAIN)
 		goto restart;
-	if (ret < 0)
+	if (ret < 0) {
+		con->error_msg = "socket error on read";
 		goto fault;
+	}
 
 	ret = try_write(con);
 	if (ret == -EAGAIN)
 		goto restart;
-	if (ret < 0)
+	if (ret < 0) {
+		con->error_msg = "socket error on write";
 		goto fault;
+	}
 
 done:
 	mutex_unlock(&con->mutex);
-- 
1.7.9

