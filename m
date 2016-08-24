From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 06/16] libceph: support for blacklisting clients
Date: Wed, 24 Aug 2016 15:18:30 +0200
Message-ID: <1472044720-29116-7-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34161 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id j12so785436ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:18:58 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.57
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:57 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Douglas Fuller <dfuller@redhat.com>

Reuse ceph_mon_generic_request infrastructure for sending monitor
commands.  In particular, add support for 'blacklist add' to prevent
other, non-responsive clients from making further updates.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
[idryomov@gmail.com: refactor, misc fixes throughout]
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/ceph_fs.h    | 11 ++++++
 include/linux/ceph/mon_client.h |  3 ++
 net/ceph/mon_client.c           | 82 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 7868d602c0a0..c086e63dcee1 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -138,6 +138,9 @@ struct ceph_dir_layout {
 #define CEPH_MSG_POOLOP_REPLY           48
 #define CEPH_MSG_POOLOP                 49
 
+/* mon commands */
+#define CEPH_MSG_MON_COMMAND            50
+#define CEPH_MSG_MON_COMMAND_ACK        51
 
 /* osd */
 #define CEPH_MSG_OSD_MAP                41
@@ -176,6 +179,14 @@ struct ceph_mon_statfs_reply {
 	struct ceph_statfs st;
 } __attribute__ ((packed));
 
+struct ceph_mon_command {
+	struct ceph_mon_request_header monhdr;
+	struct ceph_fsid fsid;
+	__le32 num_strs;         /* always 1 */
+	__le32 str_len;
+	char str[];
+} __attribute__ ((packed));
+
 struct ceph_osd_getmap {
 	struct ceph_mon_request_header monhdr;
 	struct ceph_fsid fsid;
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 24d704d1ea5c..d5a3ecea578d 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -141,6 +141,9 @@ int ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
 int ceph_monc_get_version_async(struct ceph_mon_client *monc, const char *what,
 				ceph_monc_callback_t cb, u64 private_data);
 
+int ceph_monc_blacklist_add(struct ceph_mon_client *monc,
+			    struct ceph_entity_addr *client_addr);
+
 extern int ceph_monc_open_session(struct ceph_mon_client *monc);
 
 extern int ceph_monc_validate_auth(struct ceph_mon_client *monc);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ef34a02719d7..a8effc8b7280 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -835,6 +835,83 @@ int ceph_monc_get_version_async(struct ceph_mon_client *monc, const char *what,
 }
 EXPORT_SYMBOL(ceph_monc_get_version_async);
 
+static void handle_command_ack(struct ceph_mon_client *monc,
+			       struct ceph_msg *msg)
+{
+	struct ceph_mon_generic_request *req;
+	void *p = msg->front.iov_base;
+	void *const end = p + msg->front_alloc_len;
+	u64 tid = le64_to_cpu(msg->hdr.tid);
+
+	dout("%s msg %p tid %llu\n", __func__, msg, tid);
+
+	ceph_decode_need(&p, end, sizeof(struct ceph_mon_request_header) +
+							    sizeof(u32), bad);
+	p += sizeof(struct ceph_mon_request_header);
+
+	mutex_lock(&monc->mutex);
+	req = lookup_generic_request(&monc->generic_request_tree, tid);
+	if (!req) {
+		mutex_unlock(&monc->mutex);
+		return;
+	}
+
+	req->result = ceph_decode_32(&p);
+	__finish_generic_request(req);
+	mutex_unlock(&monc->mutex);
+
+	complete_generic_request(req);
+	return;
+
+bad:
+	pr_err("corrupt mon_command ack, tid %llu\n", tid);
+	ceph_msg_dump(msg);
+}
+
+int ceph_monc_blacklist_add(struct ceph_mon_client *monc,
+			    struct ceph_entity_addr *client_addr)
+{
+	struct ceph_mon_generic_request *req;
+	struct ceph_mon_command *h;
+	int ret = -ENOMEM;
+	int len;
+
+	req = alloc_generic_request(monc, GFP_NOIO);
+	if (!req)
+		goto out;
+
+	req->request = ceph_msg_new(CEPH_MSG_MON_COMMAND, 256, GFP_NOIO, true);
+	if (!req->request)
+		goto out;
+
+	req->reply = ceph_msg_new(CEPH_MSG_MON_COMMAND_ACK, 512, GFP_NOIO,
+				  true);
+	if (!req->reply)
+		goto out;
+
+	mutex_lock(&monc->mutex);
+	register_generic_request(req);
+	h = req->request->front.iov_base;
+	h->monhdr.have_version = 0;
+	h->monhdr.session_mon = cpu_to_le16(-1);
+	h->monhdr.session_mon_tid = 0;
+	h->fsid = monc->monmap->fsid;
+	h->num_strs = cpu_to_le32(1);
+	len = sprintf(h->str, "{ \"prefix\": \"osd blacklist\", \
+		                 \"blacklistop\": \"add\", \
+				 \"addr\": \"%pISpc/%u\" }",
+		      &client_addr->in_addr, le32_to_cpu(client_addr->nonce));
+	h->str_len = cpu_to_le32(len);
+	send_generic_request(monc, req);
+	mutex_unlock(&monc->mutex);
+
+	ret = wait_generic_request(req);
+out:
+	put_generic_request(req);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_monc_blacklist_add);
+
 /*
  * Resend pending generic requests.
  */
@@ -1139,6 +1216,10 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		handle_get_version_reply(monc, msg);
 		break;
 
+	case CEPH_MSG_MON_COMMAND_ACK:
+		handle_command_ack(monc, msg);
+		break;
+
 	case CEPH_MSG_MON_MAP:
 		ceph_monc_handle_map(monc, msg);
 		break;
@@ -1178,6 +1259,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 		m = ceph_msg_get(monc->m_subscribe_ack);
 		break;
 	case CEPH_MSG_STATFS_REPLY:
+	case CEPH_MSG_MON_COMMAND_ACK:
 		return get_generic_reply(con, hdr, skip);
 	case CEPH_MSG_AUTH_REPLY:
 		m = ceph_msg_get(monc->m_auth_reply);
-- 
2.4.3

