From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: rename ceph_msg::front_max to front_alloc_len
Date: Mon, 13 Jan 2014 12:58:39 +0200
Message-ID: <1389610721-5280-2-git-send-email-ilya.dryomov@inktank.com>
References: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:47447 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAMK7j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 05:59:39 -0500
Received: by mail-ee0-f49.google.com with SMTP id d17so613012eek.22
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jan 2014 02:59:38 -0800 (PST)
In-Reply-To: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Rename front_max field of struct ceph_msg to front_alloc_len to make
its purpose more clear.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/messenger.h |    2 +-
 net/ceph/messenger.c           |    6 +++---
 net/ceph/mon_client.c          |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index c1d3f5a65273..861138f7c161 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -157,7 +157,7 @@ struct ceph_msg {
 	bool front_is_vmalloc;
 	bool more_to_follow;
 	bool needs_out_seq;
-	int front_max;
+	int front_alloc_len;
 	unsigned long ack_stamp;        /* tx: when we were acked */
 
 	struct ceph_msgpool *pool;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 21054206953b..331f8e4c8a75 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3131,7 +3131,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	INIT_LIST_HEAD(&m->data);
 
 	/* front */
-	m->front_max = front_len;
+	m->front_alloc_len = front_len;
 	if (front_len) {
 		if (front_len > PAGE_CACHE_SIZE) {
 			m->front.iov_base = __vmalloc(front_len, flags,
@@ -3306,8 +3306,8 @@ EXPORT_SYMBOL(ceph_msg_last_put);
 
 void ceph_msg_dump(struct ceph_msg *msg)
 {
-	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
-		 msg->front_max, msg->data_length);
+	pr_debug("msg_dump %p (front_alloc_len %d length %zd)\n", msg,
+		 msg->front_alloc_len, msg->data_length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 1fe25cd29d0e..2ac9ef35110b 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -152,7 +152,7 @@ static int __open_session(struct ceph_mon_client *monc)
 		/* initiatiate authentication handshake */
 		ret = ceph_auth_build_hello(monc->auth,
 					    monc->m_auth->front.iov_base,
-					    monc->m_auth->front_max);
+					    monc->m_auth->front_alloc_len);
 		__send_prepared_auth_request(monc, ret);
 	} else {
 		dout("open_session mon%d already open\n", monc->cur_mon);
@@ -196,7 +196,7 @@ static void __send_subscribe(struct ceph_mon_client *monc)
 		int num;
 
 		p = msg->front.iov_base;
-		end = p + msg->front_max;
+		end = p + msg->front_alloc_len;
 
 		num = 1 + !!monc->want_next_osdmap + !!monc->want_mdsmap;
 		ceph_encode_32(&p, num);
@@ -897,7 +897,7 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
 	ret = ceph_handle_auth_reply(monc->auth, msg->front.iov_base,
 				     msg->front.iov_len,
 				     monc->m_auth->front.iov_base,
-				     monc->m_auth->front_max);
+				     monc->m_auth->front_alloc_len);
 	if (ret < 0) {
 		monc->client->auth_err = ret;
 		wake_up_all(&monc->client->auth_wq);
@@ -939,7 +939,7 @@ static int __validate_auth(struct ceph_mon_client *monc)
 		return 0;
 
 	ret = ceph_build_auth(monc->auth, monc->m_auth->front.iov_base,
-			      monc->m_auth->front_max);
+			      monc->m_auth->front_alloc_len);
 	if (ret <= 0)
 		return ret; /* either an error, or no need to authenticate */
 	__send_prepared_auth_request(monc, ret);
-- 
1.7.10.4

