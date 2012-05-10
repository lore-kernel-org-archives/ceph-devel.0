From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 1/2] ceph: add tracepoints for message submission on
 read/write requests
Date: Thu, 10 May 2012 08:35:55 -0600
Message-ID: <1336660556-6943-2-git-send-email-jaschut@sandia.gov>
References: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35949 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2EJOga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 10:36:30 -0400
In-Reply-To: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@dreamhost.com
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

Trace callers of ceph_osdc_start_request, so that call locations
are identified implicitly.

Put the tracepoints after calls to ceph_osdc_start_request,
since it fills in the request transaction ID and request OSD.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 fs/ceph/addr.c              |    8 ++++
 fs/ceph/file.c              |    6 +++
 include/trace/events/ceph.h |   77 +++++++++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c       |    7 ++++
 4 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 include/trace/events/ceph.h

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 173b1d2..f552579 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -13,6 +13,12 @@
 #include "mds_client.h"
 #include <linux/ceph/osd_client.h>
 
+
+#include <linux/tracepoint.h>
+#define CREATE_TRACE_POINTS
+#define CEPH_TRACE_FS_ADDR
+#include <trace/events/ceph.h>
+
 /*
  * Ceph address space ops.
  *
@@ -338,6 +344,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
 
 	dout("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
 	ret = ceph_osdc_start_request(osdc, req, false);
+	trace_ceph_async_readpages_req(req);
 	if (ret < 0)
 		goto out_pages;
 	ceph_osdc_put_request(req);
@@ -902,6 +909,7 @@ get_more_pages:
 		req->r_request->hdr.data_len = cpu_to_le32(len);
 
 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
+		trace_ceph_async_writepages_req(req);
 		BUG_ON(rc);
 		req = NULL;
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ed72428..fc31def 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -10,6 +10,11 @@
 #include "super.h"
 #include "mds_client.h"
 
+#include <linux/tracepoint.h>
+#define CREATE_TRACE_POINTS
+#define CEPH_TRACE_FS_FILE
+#include <trace/events/ceph.h>
+
 /*
  * Ceph file operations
  *
@@ -568,6 +573,7 @@ more:
 	req->r_inode = inode;
 
 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
+	trace_ceph_sync_writepages_req(req);
 	if (!ret) {
 		if (req->r_safe_callback) {
 			/*
diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
new file mode 100644
index 0000000..182af2c
--- /dev/null
+++ b/include/trace/events/ceph.h
@@ -0,0 +1,77 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ceph
+
+#if !defined(_TRACE_CEPH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CEPH_H
+
+
+#if !defined(TRACE_HEADER_MULTI_READ)
+
+static __always_inline int
+__ceph_req_num_ops(struct ceph_osd_request *req)
+{
+	struct ceph_osd_request_head *reqhead = req->r_request->front.iov_base;
+	return le16_to_cpu(reqhead->num_ops);
+}
+
+static __always_inline int
+__ceph_req_op_opcode(struct ceph_osd_request *req, int op)
+{
+	struct ceph_osd_request_head *reqhead = req->r_request->front.iov_base;
+	if (op < le16_to_cpu(reqhead->num_ops))
+		return le16_to_cpu(reqhead->ops[op].op);
+	else
+		return 0;
+}
+
+#endif
+
+DECLARE_EVENT_CLASS(ceph_start_req_class,
+	TP_PROTO(struct ceph_osd_request *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__field(unsigned long long, tid)
+		__field(int, osd)
+		__field(int, num_ops)
+		__array(unsigned, ops, 3)
+		__field(unsigned, pages)
+	),
+	TP_fast_assign(
+		__entry->tid = req->r_tid;
+		__entry->osd = req->r_osd->o_osd;
+		__entry->num_ops = __ceph_req_num_ops(req);
+		__entry->ops[0] = __ceph_req_op_opcode(req, 0);
+		__entry->ops[1] = __ceph_req_op_opcode(req, 1);
+		__entry->ops[2] = __ceph_req_op_opcode(req, 2);
+		__entry->pages = req->r_num_pages;
+	),
+	TP_printk("tid %llu osd%d ops %d 0x%04x/0x%04x/0x%04x pages %u",
+		  __entry->tid, __entry->osd, __entry->num_ops,
+		  __entry->ops[0], __entry->ops[1], __entry->ops[2],
+		  __entry->pages
+	)
+);
+
+#define DEFINE_CEPH_START_REQ_EVENT(name) \
+DEFINE_EVENT(ceph_start_req_class, name, \
+	TP_PROTO(struct ceph_osd_request *req), TP_ARGS(req))
+
+#ifdef CEPH_TRACE_FS_FILE
+DEFINE_CEPH_START_REQ_EVENT(ceph_sync_writepages_req);
+#endif
+
+#ifdef CEPH_TRACE_FS_ADDR
+DEFINE_CEPH_START_REQ_EVENT(ceph_async_writepages_req);
+DEFINE_CEPH_START_REQ_EVENT(ceph_async_readpages_req);
+#endif
+
+#ifdef CEPH_TRACE_NET_OSDC
+DEFINE_CEPH_START_REQ_EVENT(ceph_osdc_writepages_req);
+DEFINE_CEPH_START_REQ_EVENT(ceph_osdc_readpages_req);
+#endif
+
+
+#endif /* _TRACE_CEPH_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5e25405..f44e400 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -18,6 +18,11 @@
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
 
+#include <linux/tracepoint.h>
+#define CREATE_TRACE_POINTS
+#define CEPH_TRACE_NET_OSDC
+#include <trace/events/ceph.h>
+
 #define OSD_OP_FRONT_LEN	4096
 #define OSD_OPREPLY_FRONT_LEN	512
 
@@ -1906,6 +1911,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 	     off, *plen, req->r_num_pages, page_align);
 
 	rc = ceph_osdc_start_request(osdc, req, false);
+	trace_ceph_osdc_readpages_req(req);
 	if (!rc)
 		rc = ceph_osdc_wait_request(osdc, req);
 
@@ -1948,6 +1954,7 @@ int ceph_osdc_writepages(struct ceph_osd_client *osdc, struct ceph_vino vino,
 	     req->r_num_pages);
 
 	rc = ceph_osdc_start_request(osdc, req, nofail);
+	trace_ceph_osdc_writepages_req(req);
 	if (!rc)
 		rc = ceph_osdc_wait_request(osdc, req);
 
-- 
1.7.8.2


