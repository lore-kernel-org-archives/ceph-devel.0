From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: mon_get_version request infrastructure
Date: Thu, 24 Apr 2014 20:23:25 +0400
Message-ID: <1398356607-10666-2-git-send-email-ilya.dryomov@inktank.com>
References: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbaDXQXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Apr 2014 12:23:32 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so2008072eei.5
        for <ceph-devel@vger.kernel.org>; Thu, 24 Apr 2014 09:23:31 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id u1sm17088812eex.31.2014.04.24.09.23.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 09:23:31 -0700 (PDT)
In-Reply-To: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add support for mon_get_version requests to libceph.  This reuses much
of the ceph_mon_generic_request infrastructure, with one exception.
The mon_get_version reply hdr->tid is always 0 and that makes it
impossible to lookup ceph_mon_generic_request contexts by tid in
get_generic_reply().  So, instead of preallocating reply messages like
its done for statfs and poolop requests, we allocate a reply message on
the reply path.  This can probably interfere with revoke, but I don't
see a better way.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/mon_client.h |   11 ++--
 net/ceph/ceph_common.c          |    2 +
 net/ceph/debugfs.c              |    2 +
 net/ceph/mon_client.c           |  119 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index a486f390dfbe..d8060dd87f16 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -40,9 +40,9 @@ struct ceph_mon_request {
 };
 
 /*
- * ceph_mon_generic_request is being used for the statfs and poolop requests
- * which are bening done a bit differently because we need to get data back
- * to the caller
+ * ceph_mon_generic_request is being used for the statfs, poolop and
+ * mon_get_version requests which are being done a bit differently
+ * because we need to get data back to the caller
  */
 struct ceph_mon_generic_request {
 	struct kref kref;
@@ -53,7 +53,7 @@ struct ceph_mon_generic_request {
 	int buf_len;
 	struct completion completion;
 	struct ceph_msg *request;  /* original request */
-	struct ceph_msg *reply;    /* and reply */
+	struct ceph_msg *reply;    /* and reply, NULL for mon_get_version */
 };
 
 struct ceph_mon_client {
@@ -108,6 +108,9 @@ extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
 extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
 			       struct ceph_statfs *buf);
 
+extern int ceph_monc_do_get_version(struct ceph_mon_client *monc,
+				    const char *what, u64 *newest);
+
 extern int ceph_monc_open_session(struct ceph_mon_client *monc);
 
 extern int ceph_monc_validate_auth(struct ceph_mon_client *monc);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67d7721d237e..1675021d8c12 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -72,6 +72,8 @@ const char *ceph_msg_type_name(int type)
 	case CEPH_MSG_MON_SUBSCRIBE_ACK: return "mon_subscribe_ack";
 	case CEPH_MSG_STATFS: return "statfs";
 	case CEPH_MSG_STATFS_REPLY: return "statfs_reply";
+	case CEPH_MSG_MON_GET_VERSION: return "mon_get_version";
+	case CEPH_MSG_MON_GET_VERSION_REPLY: return "mon_get_version_reply";
 	case CEPH_MSG_MDS_MAP: return "mds_map";
 	case CEPH_MSG_CLIENT_SESSION: return "client_session";
 	case CEPH_MSG_CLIENT_RECONNECT: return "client_reconnect";
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 10421a4b76f8..45405aadee11 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -127,6 +127,8 @@ static int monc_show(struct seq_file *s, void *p)
 		op = le16_to_cpu(req->request->hdr.type);
 		if (op == CEPH_MSG_STATFS)
 			seq_printf(s, "%lld statfs\n", req->tid);
+		else if (op == CEPH_MSG_MON_GET_VERSION)
+			seq_printf(s, "%llu get_version", req->tid);
 		else
 			seq_printf(s, "%lld unknown\n", req->tid);
 	}
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 2ac9ef35110b..d64023965d1c 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -477,15 +477,12 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	return m;
 }
 
-static int do_generic_request(struct ceph_mon_client *monc,
-			      struct ceph_mon_generic_request *req)
+static int __do_generic_request(struct ceph_mon_client *monc,
+				struct ceph_mon_generic_request *req)
 {
 	int err;
 
 	/* register request */
-	mutex_lock(&monc->mutex);
-	req->tid = ++monc->last_tid;
-	req->request->hdr.tid = cpu_to_le64(req->tid);
 	__insert_generic_request(monc, req);
 	monc->num_generic_requests++;
 	ceph_con_send(&monc->con, ceph_msg_get(req->request));
@@ -496,13 +493,27 @@ static int do_generic_request(struct ceph_mon_client *monc,
 	mutex_lock(&monc->mutex);
 	rb_erase(&req->node, &monc->generic_request_tree);
 	monc->num_generic_requests--;
-	mutex_unlock(&monc->mutex);
 
 	if (!err)
 		err = req->result;
 	return err;
 }
 
+static int do_generic_request(struct ceph_mon_client *monc,
+			      struct ceph_mon_generic_request *req)
+{
+	int err;
+
+	mutex_lock(&monc->mutex);
+	req->tid = ++monc->last_tid;
+	req->request->hdr.tid = cpu_to_le64(req->tid);
+
+	err = __do_generic_request(monc, req);
+
+	mutex_unlock(&monc->mutex);
+	return err;
+}
+
 /*
  * statfs
  */
@@ -579,6 +590,94 @@ out:
 }
 EXPORT_SYMBOL(ceph_monc_do_statfs);
 
+static void handle_get_version_reply(struct ceph_mon_client *monc,
+				     struct ceph_msg *msg)
+{
+	struct ceph_mon_generic_request *req;
+	void *p, *end;
+	u64 handle;
+	u64 version;
+
+	p = msg->front.iov_base;
+	end = p + msg->front_alloc_len;
+
+	ceph_decode_64_safe(&p, end, handle, bad);
+	ceph_decode_64_safe(&p, end, version, bad);
+
+	mutex_lock(&monc->mutex);
+	req = __lookup_generic_req(monc, handle);
+	if (req) {
+		dout("%s handle %llu version %llu\n", __func__, handle,
+		     version);
+		*(u64 *)req->buf = version;
+		req->result = 0;
+		get_generic_request(req);
+	} else {
+		pr_info("%s unknown handle %llu\n", __func__, handle);
+	}
+	mutex_unlock(&monc->mutex);
+	if (req) {
+		complete_all(&req->completion);
+		put_generic_request(req);
+	}
+
+	BUG_ON(req && req->reply);
+
+	return;
+bad:
+	pr_err("corrupt mon_get_version reply\n");
+	ceph_msg_dump(msg);
+}
+
+int ceph_monc_do_get_version(struct ceph_mon_client *monc, const char *what,
+			     u64 *newest)
+{
+	struct ceph_mon_generic_request *req;
+	void *p, *end;
+	int err;
+
+	req = kzalloc(sizeof(*req), GFP_NOFS);
+	if (!req)
+		return -ENOMEM;
+
+	kref_init(&req->kref);
+	req->buf = newest;
+	req->buf_len = sizeof(*newest);
+	init_completion(&req->completion);
+
+	req->request = ceph_msg_new(CEPH_MSG_MON_GET_VERSION,
+				    sizeof(u64) + sizeof(u32) + strlen(what),
+				    GFP_NOFS, true);
+	if (!req->request) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Preallocating a reply ceph_msg for mon_get_version requests
+	 * is pointless - their reply hdr->tid is always 0, which means
+	 * that the ceph_mon_generic_request cannot be looked up in
+	 * get_generic_reply().
+	 */
+
+	p = req->request->front.iov_base;
+	end = p + req->request->front_alloc_len;
+
+	/* fill out request */
+	mutex_lock(&monc->mutex);
+	req->tid = ++monc->last_tid;
+	ceph_encode_64(&p, req->tid); /* handle */
+	ceph_encode_string(&p, end, what, strlen(what));
+
+	err = __do_generic_request(monc, req);
+
+	mutex_unlock(&monc->mutex);
+out:
+	kref_put(&req->kref, release_generic_request);
+	return err;
+}
+EXPORT_SYMBOL(ceph_monc_do_get_version);
+
 /*
  * pool ops
  */
@@ -712,7 +811,8 @@ static void __resend_generic_request(struct ceph_mon_client *monc)
 	for (p = rb_first(&monc->generic_request_tree); p; p = rb_next(p)) {
 		req = rb_entry(p, struct ceph_mon_generic_request, node);
 		ceph_msg_revoke(req->request);
-		ceph_msg_revoke_incoming(req->reply);
+		if (req->reply)
+			ceph_msg_revoke_incoming(req->reply);
 		ceph_con_send(&monc->con, ceph_msg_get(req->request));
 	}
 }
@@ -981,6 +1081,10 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		handle_statfs_reply(monc, msg);
 		break;
 
+	case CEPH_MSG_MON_GET_VERSION_REPLY:
+		handle_get_version_reply(monc, msg);
+		break;
+
 	case CEPH_MSG_POOLOP_REPLY:
 		handle_poolop_reply(monc, msg);
 		break;
@@ -1032,6 +1136,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	case CEPH_MSG_MON_MAP:
 	case CEPH_MSG_MDS_MAP:
 	case CEPH_MSG_OSD_MAP:
+	case CEPH_MSG_MON_GET_VERSION_REPLY:
 		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
 		if (!m)
 			return NULL;	/* ENOMEM--return skip == 0 */
-- 
1.7.10.4

