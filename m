From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: drop mutex while allocating a message
Date: Mon, 04 Mar 2013 12:12:01 -0600
Message-ID: <5134E3F1.70008@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:36173 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDSMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:12:02 -0500
Received: by mail-ia0-f177.google.com with SMTP id o25so4924841iad.8
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:12:01 -0800 (PST)
In-Reply-To: <5134E3AD.4080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In ceph_con_in_msg_alloc(), if no alloc_msg method is defined for a
connection a new message is allocated with ceph_msg_new().

Drop the mutex before making this call, and make sure we're still
connected when we get it back again.

This is preparing for the next patch, which ensures all connections
define an alloc_msg method, and then handles them all the same way.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0f9933a..6ec6051 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2807,13 +2807,12 @@ static int ceph_con_in_msg_alloc(struct
ceph_connection *con, int *skip)
 	int type = le16_to_cpu(hdr->type);
 	int front_len = le32_to_cpu(hdr->front_len);
 	int middle_len = le32_to_cpu(hdr->middle_len);
+	struct ceph_msg *msg;
 	int ret = 0;

 	BUG_ON(con->in_msg != NULL);

 	if (con->ops->alloc_msg) {
-		struct ceph_msg *msg;
-
 		mutex_unlock(&con->mutex);
 		msg = con->ops->alloc_msg(con, hdr, skip);
 		mutex_lock(&con->mutex);
@@ -2838,12 +2837,19 @@ static int ceph_con_in_msg_alloc(struct
ceph_connection *con, int *skip)
 		}
 	}
 	if (!con->in_msg) {
-		con->in_msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
-		if (!con->in_msg) {
+		mutex_unlock(&con->mutex);
+		msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
+		mutex_lock(&con->mutex);
+		if (!msg) {
 			pr_err("unable to allocate msg type %d len %d\n",
 			       type, front_len);
 			return -ENOMEM;
 		}
+		if (con->state != CON_STATE_OPEN) {
+			ceph_msg_put(msg);
+			return -EAGAIN;
+		}
+		con->in_msg = msg;
 		con->in_msg->con = con->ops->get(con);
 		BUG_ON(con->in_msg->con == NULL);
 		con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
-- 
1.7.9.5

