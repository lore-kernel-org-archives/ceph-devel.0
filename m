From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: drop connection refcounting for mon_client
Date: Tue, 05 Jun 2012 22:31:01 -0500
Message-ID: <4FCECEF5.1040802@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55386 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2FFDa5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:30:57 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so4512272yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:30:57 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From Sage Weil <sage@inktank.com>

All references to the embedded ceph_connection come from the msgr
workqueue, which is drained prior to mon_client destruction.  That
means we can ignore con refcounting entirely.

Signed-off-by: Sage Weil <sage@newdream.net>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 net/ceph/mon_client.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ac4d6b1..062b724 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1029,9 +1029,23 @@ out:
 	mutex_unlock(&monc->mutex);
 }

+/*
+ * We can ignore refcounting on the connection struct, as all references
+ * will come from the messenger workqueue, which is drained prior to
+ * mon_client destruction.
+ */
+static struct ceph_connection *con_get(struct ceph_connection *con)
+{
+	return con;
+}
+
+static void con_put(struct ceph_connection *con)
+{
+}
+
 static const struct ceph_connection_operations mon_con_ops = {
-	.get = ceph_con_get,
-	.put = ceph_con_put,
+	.get = con_get,
+	.put = con_put,
 	.dispatch = dispatch,
 	.fault = mon_fault,
 	.alloc_msg = mon_alloc_msg,
-- 
1.7.5.4

