From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 2/2] ceph: add tracepoints for message send queueing and
 completion, reply handling
Date: Thu, 10 May 2012 08:35:56 -0600
Message-ID: <1336660556-6943-3-git-send-email-jaschut@sandia.gov>
References: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35935 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab2EJOg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 10:36:29 -0400
In-Reply-To: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@dreamhost.com
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 include/trace/events/ceph.h |   67 +++++++++++++++++++++++++++++++++++++++++++
 net/ceph/messenger.c        |    9 +++++-
 net/ceph/osd_client.c       |    1 +
 3 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
index 182af2c..b390f78 100644
--- a/include/trace/events/ceph.h
+++ b/include/trace/events/ceph.h
@@ -4,6 +4,9 @@
 #if !defined(_TRACE_CEPH_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_CEPH_H
 
+#if defined(CEPH_TRACE_FS_FILE) \
+ || defined(CEPH_TRACE_FS_ADDR) \
+ || defined(CEPH_TRACE_NET_OSDC)
 
 #if !defined(TRACE_HEADER_MULTI_READ)
 
@@ -68,8 +71,72 @@ DEFINE_CEPH_START_REQ_EVENT(ceph_async_readpages_req);
 #ifdef CEPH_TRACE_NET_OSDC
 DEFINE_CEPH_START_REQ_EVENT(ceph_osdc_writepages_req);
 DEFINE_CEPH_START_REQ_EVENT(ceph_osdc_readpages_req);
+
+TRACE_EVENT(ceph_handle_reply_msg,
+	TP_PROTO(struct ceph_connection *con,
+		 struct ceph_msg *msg,
+		 struct ceph_osd_reply_head *reply,
+		 void *req),
+	TP_ARGS(con, msg, reply, req),
+	TP_STRUCT__entry(
+		__field(unsigned long long, tid)
+		__field(long long, peer_num)
+		__field(void*, req)
+		__field(unsigned, peer_type)
+		__field(int, result)
+		__field(int, flags)
+	),
+	TP_fast_assign(
+		__entry->tid = le64_to_cpu(msg->hdr.tid);
+		__entry->peer_num = le64_to_cpu(con->peer_name.num);
+		__entry->peer_type = con->peer_name.type;
+		__entry->req = req;
+		__entry->result = le32_to_cpu(reply->result);
+		__entry->flags = le32_to_cpu(reply->flags);
+	),
+	TP_printk("peer %s%lld tid %llu result %d flags 0x%08x (req %p)",
+		  ceph_entity_type_name(__entry->peer_type), __entry->peer_num,
+		  __entry->tid, __entry->result, __entry->flags,  __entry->req
+	)
+);
 #endif
 
+#endif /* CEPH_TRACE_FS_FILE || CEPH_TRACE_FS_ADDR || CEPH_TRACE_NET_OSDC */
+
+#if defined(CEPH_TRACE_NET_MESSENGER)
+
+DECLARE_EVENT_CLASS(ceph_write_msg_class,
+	TP_PROTO(struct ceph_connection *con, struct ceph_msg *msg),
+	TP_ARGS(con, msg),
+	TP_STRUCT__entry(
+		__field(unsigned long long, tid)
+		__field(unsigned long long, seq)
+		__field(long long, peer_num)
+		__field(unsigned, peer_type)
+		__field(int, sent)
+	),
+	TP_fast_assign(
+		__entry->tid = le64_to_cpu(msg->hdr.tid);
+		__entry->seq = le64_to_cpu(msg->hdr.seq);
+		__entry->peer_num = le64_to_cpu(con->peer_name.num);
+		__entry->peer_type = con->peer_name.type;
+		__entry->sent = con->out_msg_pos.data_pos;
+	),
+	TP_printk("peer %s%lld tid %llu seq %llu sent %d",
+		  ceph_entity_type_name(__entry->peer_type), __entry->peer_num,
+		  __entry->tid, __entry->seq, __entry->sent)
+);
+
+#define CEPH_WRITE_MSG_EVENT(name) \
+DEFINE_EVENT(ceph_write_msg_class, name, \
+	TP_PROTO(struct ceph_connection *con, struct ceph_msg *msg), \
+	TP_ARGS(con, msg))
+
+CEPH_WRITE_MSG_EVENT(ceph_prepare_write_msg);
+CEPH_WRITE_MSG_EVENT(ceph_try_write_msg);
+CEPH_WRITE_MSG_EVENT(ceph_try_write_msg_done);
+
+#endif /* CEPH_TRACE_NET_MESSENGER */
 
 #endif /* _TRACE_CEPH_H */
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ad5b708..033c4ab 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -20,6 +20,11 @@
 #include <linux/ceph/pagelist.h>
 #include <linux/export.h>
 
+#include <linux/tracepoint.h>
+#define CREATE_TRACE_POINTS
+#define CEPH_TRACE_NET_MESSENGER
+#include <trace/events/ceph.h>
+
 /*
  * Ceph uses the messenger to exchange ceph_msg messages with other
  * hosts in the system.  The messenger provides ordered and reliable
@@ -555,7 +560,7 @@ static void prepare_write_message(struct ceph_connection *con)
 		/* no, queue up footer too and be done */
 		prepare_write_message_footer(con, v);
 	}
-
+	trace_ceph_prepare_write_msg(con, m);
 	set_bit(WRITE_PENDING, &con->state);
 }
 
@@ -1853,8 +1858,10 @@ more_kvec:
 
 	/* msg pages? */
 	if (con->out_msg) {
+		trace_ceph_try_write_msg(con, con->out_msg);
 		if (con->out_msg_done) {
 			ceph_msg_put(con->out_msg);
+			trace_ceph_try_write_msg_done(con, con->out_msg);
 			con->out_msg = NULL;   /* we're done with this one */
 			goto do_next;
 		}
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f44e400..767e253 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1200,6 +1200,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	/* lookup */
 	mutex_lock(&osdc->request_mutex);
 	req = __lookup_request(osdc, tid);
+	trace_ceph_handle_reply_msg(con, msg, rhead, req);
 	if (req == NULL) {
 		dout("handle_reply tid %llu dne\n", tid);
 		mutex_unlock(&osdc->request_mutex);
-- 
1.7.8.2


