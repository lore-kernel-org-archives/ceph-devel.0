From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: check data_len in ->alloc_msg()
Date: Wed,  2 Sep 2015 20:33:48 +0300
Message-ID: <1441215228-12315-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37406 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbIBReH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 13:34:07 -0400
Received: by wicfx3 with SMTP id fx3so26695601wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2015 10:34:06 -0700 (PDT)
Received: from orange.local.localdomain ([109.110.66.71])
        by smtp.gmail.com with ESMTPSA id gk9sm4658259wib.9.2015.09.02.10.34.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 10:34:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Only ->alloc_msg() should check data_len of the incoming message
against the preallocated ceph_msg, doing it in the messenger is not
right.  The contract is that either ->alloc_msg() returns a ceph_msg
which will fit all of the portions of the incoming message, or it
returns NULL and possibly sets skip, signaling whether NULL is due to
an -ENOMEM.  ->alloc_msg() should be the only place where we make the
skip/no-skip decision.

I stumbled upon this while looking at con/osd ref counting.  Right now,
if we get a non-extent message with a larger data portion than we are
prepared for, ->alloc_msg() returns a ceph_msg, and then, when we skip
it in the messenger, we don't put the con/osd ref acquired in
ceph_con_in_msg_alloc() (which is normally put in process_message()),
so this also fixes a memory leak.

An existing BUG_ON in ceph_msg_data_cursor_init() ensures we don't
corrupt random memory should a buggy ->alloc_msg() return an unfit
ceph_msg.

While at it, I changed the "unknown tid" dout() to a pr_warn() to make
sure all skips are seen and unified format strings.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c  |  7 -------
 net/ceph/osd_client.c | 51 ++++++++++++++++++---------------------------------
 2 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 36757d46ac40..525f454f7531 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2337,13 +2337,6 @@ static int read_partial_message(struct ceph_connection *con)
 			return ret;
 
 		BUG_ON(!con->in_msg ^ skip);
-		if (con->in_msg && data_len > con->in_msg->data_length) {
-			pr_warn("%s skipping long message (%u > %zd)\n",
-				__func__, data_len, con->in_msg->data_length);
-			ceph_msg_put(con->in_msg);
-			con->in_msg = NULL;
-			skip = 1;
-		}
 		if (skip) {
 			/* skip this message */
 			dout("alloc_msg said skip message\n");
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 50033677c0fa..80b94e37c94a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2817,8 +2817,9 @@ out:
 }
 
 /*
- * lookup and return message for incoming reply.  set up reply message
- * pages.
+ * Lookup and return message for incoming reply.  Don't try to do
+ * anything about a larger than preallocated data portion of the
+ * message at the moment - for now, just skip the message.
  */
 static struct ceph_msg *get_reply(struct ceph_connection *con,
 				  struct ceph_msg_header *hdr,
@@ -2836,10 +2837,10 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	mutex_lock(&osdc->request_mutex);
 	req = __lookup_request(osdc, tid);
 	if (!req) {
-		*skip = 1;
+		pr_warn("%s osd%d tid %llu unknown, skipping\n",
+			__func__, osd->o_osd, tid);
 		m = NULL;
-		dout("get_reply unknown tid %llu from osd%d\n", tid,
-		     osd->o_osd);
+		*skip = 1;
 		goto out;
 	}
 
@@ -2849,10 +2850,9 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	ceph_msg_revoke_incoming(req->r_reply);
 
 	if (front_len > req->r_reply->front_alloc_len) {
-		pr_warn("get_reply front %d > preallocated %d (%u#%llu)\n",
-			front_len, req->r_reply->front_alloc_len,
-			(unsigned int)con->peer_name.type,
-			le64_to_cpu(con->peer_name.num));
+		pr_warn("%s osd%d tid %llu front %d > preallocated %d\n",
+			__func__, osd->o_osd, req->r_tid, front_len,
+			req->r_reply->front_alloc_len);
 		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front_len, GFP_NOFS,
 				 false);
 		if (!m)
@@ -2860,37 +2860,22 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		ceph_msg_put(req->r_reply);
 		req->r_reply = m;
 	}
-	m = ceph_msg_get(req->r_reply);
-
-	if (data_len > 0) {
-		struct ceph_osd_data *osd_data;
 
-		/*
-		 * XXX This is assuming there is only one op containing
-		 * XXX page data.  Probably OK for reads, but this
-		 * XXX ought to be done more generally.
-		 */
-		osd_data = osd_req_op_extent_osd_data(req, 0);
-		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-			if (osd_data->pages &&
-				unlikely(osd_data->length < data_len)) {
-
-				pr_warn("tid %lld reply has %d bytes we had only %llu bytes ready\n",
-					tid, data_len, osd_data->length);
-				*skip = 1;
-				ceph_msg_put(m);
-				m = NULL;
-				goto out;
-			}
-		}
+	if (data_len > req->r_reply->data_length) {
+		pr_warn("%s osd%d tid %llu data %d > preallocated %zu, skipping\n",
+			__func__, osd->o_osd, req->r_tid, data_len,
+			req->r_reply->data_length);
+		m = NULL;
+		*skip = 1;
+		goto out;
 	}
-	*skip = 0;
+
+	m = ceph_msg_get(req->r_reply);
 	dout("get_reply tid %lld %p\n", tid, m);
 
 out:
 	mutex_unlock(&osdc->request_mutex);
 	return m;
-
 }
 
 static struct ceph_msg *alloc_msg(struct ceph_connection *con,
-- 
1.9.3

