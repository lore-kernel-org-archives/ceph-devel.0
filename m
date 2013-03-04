From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: define mds_alloc_msg() method
Date: Mon, 04 Mar 2013 12:12:17 -0600
Message-ID: <5134E401.6070604@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51281 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191Ab3CDSMQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:12:16 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so6546798iea.33
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:12:16 -0800 (PST)
In-Reply-To: <5134E3AD.4080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only user of the ceph messenger that doesn't define an alloc_msg
method is the mds client.  Define one, such that it works just like
it did before, and simplify ceph_con_in_msg_alloc() by assuming the
alloc_msg method is always present.

This and the next patch resolve:
    http://tracker.ceph.com/issues/4322

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c |   23 ++++++++++++++++++++
 net/ceph/messenger.c |   59
++++++++++++++++----------------------------------
 2 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 76b7344..a4b986a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3469,6 +3469,28 @@ static int invalidate_authorizer(struct
ceph_connection *con)
 	return ceph_monc_validate_auth(&mdsc->fsc->client->monc);
 }

+static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
+				struct ceph_msg_header *hdr, int *skip)
+{
+	struct ceph_msg *msg;
+	int type = (int) le16_to_cpu(hdr->type);
+	int front_len = (int) le32_to_cpu(hdr->front_len);
+
+	if (con->in_msg)
+		return con->in_msg;
+
+	*skip = 0;
+	msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
+	if (!msg) {
+		pr_err("unable to allocate msg type %d len %d\n",
+		       type, front_len);
+		return NULL;
+	}
+	msg->page_alignment = (unsigned int) le16_to_cpu(hdr->data_off);
+
+	return msg;
+}
+
 static const struct ceph_connection_operations mds_con_ops = {
 	.get = con_get,
 	.put = con_put,
@@ -3477,6 +3499,7 @@ static const struct ceph_connection_operations
mds_con_ops = {
 	.verify_authorizer_reply = verify_authorizer_reply,
 	.invalidate_authorizer = invalidate_authorizer,
 	.peer_reset = peer_reset,
+	.alloc_msg = mds_alloc_msg,
 };

 /* eof */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6ec6051..c7d4278 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2804,55 +2804,34 @@ static int ceph_alloc_middle(struct
ceph_connection *con, struct ceph_msg *msg)
 static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 {
 	struct ceph_msg_header *hdr = &con->in_hdr;
-	int type = le16_to_cpu(hdr->type);
-	int front_len = le32_to_cpu(hdr->front_len);
 	int middle_len = le32_to_cpu(hdr->middle_len);
 	struct ceph_msg *msg;
 	int ret = 0;

 	BUG_ON(con->in_msg != NULL);
+	BUG_ON(!con->ops->alloc_msg);

-	if (con->ops->alloc_msg) {
-		mutex_unlock(&con->mutex);
-		msg = con->ops->alloc_msg(con, hdr, skip);
-		mutex_lock(&con->mutex);
-		if (con->state != CON_STATE_OPEN) {
-			if (msg)
-				ceph_msg_put(msg);
-			return -EAGAIN;
-		}
-		con->in_msg = msg;
-		if (con->in_msg) {
-			con->in_msg->con = con->ops->get(con);
-			BUG_ON(con->in_msg->con == NULL);
-		}
-		if (*skip) {
-			con->in_msg = NULL;
-			return 0;
-		}
-		if (!con->in_msg) {
-			con->error_msg =
-				"error allocating memory for incoming message";
-			return -ENOMEM;
-		}
-	}
-	if (!con->in_msg) {
-		mutex_unlock(&con->mutex);
-		msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
-		mutex_lock(&con->mutex);
-		if (!msg) {
-			pr_err("unable to allocate msg type %d len %d\n",
-			       type, front_len);
-			return -ENOMEM;
-		}
-		if (con->state != CON_STATE_OPEN) {
+	mutex_unlock(&con->mutex);
+	msg = con->ops->alloc_msg(con, hdr, skip);
+	mutex_lock(&con->mutex);
+	if (con->state != CON_STATE_OPEN) {
+		if (msg)
 			ceph_msg_put(msg);
-			return -EAGAIN;
-		}
-		con->in_msg = msg;
+		return -EAGAIN;
+	}
+	con->in_msg = msg;
+	if (con->in_msg) {
 		con->in_msg->con = con->ops->get(con);
 		BUG_ON(con->in_msg->con == NULL);
-		con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
+	}
+	if (*skip) {
+		con->in_msg = NULL;
+		return 0;
+	}
+	if (!con->in_msg) {
+		con->error_msg =
+			"error allocating memory for incoming message";
+		return -ENOMEM;
 	}
 	memcpy(&con->in_msg->hdr, &con->in_hdr, sizeof(con->in_hdr));

-- 
1.7.9.5

