From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 1/2] net: ceph: messenger: change BUG_ON() to WARN_ON() from ceph_con_in_msg_alloc()
Date: Wed, 27 Jan 2016 14:52:27 +0200
Message-ID: <4248c443a77400d6aaeb3bf352eb19406a9ff6e5.1453898892.git.ciorneiioana@gmail.com>
References: <cover.1453898892.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36376 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbcA0Kwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 05:52:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so2563309wmf.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 02:52:39 -0800 (PST)
In-Reply-To: <cover.1453898892.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453898892.git.ciorneiioana@gmail.com>
References: <cover.1453898892.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch replaces the uses of BUG_ON() from the function
ceph_con_in_msg_alloc() with WARN_ON() and an exit strategy.
There is no reason to crash the kernel if we can warn the user
and return an appropriate error code to the above layer in the
calling hierarchy.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9cfedf5..9a5e54c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3348,8 +3348,14 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 	struct ceph_msg *msg;
 	int ret = 0;
 
-	BUG_ON(con->in_msg != NULL);
-	BUG_ON(!con->ops->alloc_msg);
+	if (WARN_ON(con->in_msg)) {
+		con->in_msg = NULL;
+		return -ENOENT;
+	}
+	if (WARN_ON(!con->ops->alloc_msg)) {
+		con->in_msg = NULL;
+		return -ENOENT;
+	}
 
 	mutex_unlock(&con->mutex);
 	msg = con->ops->alloc_msg(con, hdr, skip);
@@ -3360,7 +3366,10 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 		return -EAGAIN;
 	}
 	if (msg) {
-		BUG_ON(*skip);
+		if (WARN_ON(*skip)) {
+			con->in_msg = NULL;
+			return -ENOENT;
+		}
 		msg_con_set(msg, con);
 		con->in_msg = msg;
 	} else {
-- 
2.6.4

