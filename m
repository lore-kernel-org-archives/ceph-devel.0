From: Alex Elder <elder@inktank.com>
Subject: [PATCH 16/20] libceph: move ceph_osdc_build_request()
Date: Fri, 05 Apr 2013 09:05:18 -0500
Message-ID: <515EDA1E.7080300@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:47688 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161548Ab3DEOFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:05:20 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so3235133iag.36
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:05:19 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This simply moves ceph_osdc_build_request() later in its source
file without any change.  Done as a separate patch to facilitate
review of the change in the next patch.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |  196
++++++++++++++++++++++++-------------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6c6d7b8..f80984e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -526,104 +526,6 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
 }

 /*
- * build new request AND message
- *
- */
-void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
-				struct ceph_snap_context *snapc, u64 snap_id,
-				struct timespec *mtime)
-{
-	struct ceph_msg *msg = req->r_request;
-	void *p;
-	size_t msg_size;
-	int flags = req->r_flags;
-	u64 data_len;
-	unsigned int i;
-
-	req->r_snapid = snap_id;
-	req->r_snapc = ceph_get_snap_context(snapc);
-
-	/* encode request */
-	msg->hdr.version = cpu_to_le16(4);
-
-	p = msg->front.iov_base;
-	ceph_encode_32(&p, 1);   /* client_inc  is always 1 */
-	req->r_request_osdmap_epoch = p;
-	p += 4;
-	req->r_request_flags = p;
-	p += 4;
-	if (req->r_flags & CEPH_OSD_FLAG_WRITE)
-		ceph_encode_timespec(p, mtime);
-	p += sizeof(struct ceph_timespec);
-	req->r_request_reassert_version = p;
-	p += sizeof(struct ceph_eversion); /* will get filled in */
-
-	/* oloc */
-	ceph_encode_8(&p, 4);
-	ceph_encode_8(&p, 4);
-	ceph_encode_32(&p, 8 + 4 + 4);
-	req->r_request_pool = p;
-	p += 8;
-	ceph_encode_32(&p, -1);  /* preferred */
-	ceph_encode_32(&p, 0);   /* key len */
-
-	ceph_encode_8(&p, 1);
-	req->r_request_pgid = p;
-	p += 8 + 4;
-	ceph_encode_32(&p, -1);  /* preferred */
-
-	/* oid */
-	ceph_encode_32(&p, req->r_oid_len);
-	memcpy(p, req->r_oid, req->r_oid_len);
-	dout("oid '%.*s' len %d\n", req->r_oid_len, req->r_oid, req->r_oid_len);
-	p += req->r_oid_len;
-
-	/* ops--can imply data */
-	ceph_encode_16(&p, (u16)req->r_num_ops);
-	data_len = 0;
-	for (i = 0; i < req->r_num_ops; i++) {
-		data_len += osd_req_encode_op(req, p, i);
-		p += sizeof(struct ceph_osd_op);
-	}
-
-	/* snaps */
-	ceph_encode_64(&p, req->r_snapid);
-	ceph_encode_64(&p, req->r_snapc ? req->r_snapc->seq : 0);
-	ceph_encode_32(&p, req->r_snapc ? req->r_snapc->num_snaps : 0);
-	if (req->r_snapc) {
-		for (i = 0; i < snapc->num_snaps; i++) {
-			ceph_encode_64(&p, req->r_snapc->snaps[i]);
-		}
-	}
-
-	req->r_request_attempts = p;
-	p += 4;
-
-	/* data */
-	if (flags & CEPH_OSD_FLAG_WRITE) {
-		u16 data_off;
-
-		/*
-		 * The header "data_off" is a hint to the receiver
-		 * allowing it to align received data into its
-		 * buffers such that there's no need to re-copy
-		 * it before writing it to disk (direct I/O).
-		 */
-		data_off = (u16) (off & 0xffff);
-		req->r_request->hdr.data_off = cpu_to_le16(data_off);
-	}
-	req->r_request->hdr.data_len = cpu_to_le32(data_len);
-
-	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
-	msg_size = p - msg->front.iov_base;
-	msg->front.iov_len = msg_size;
-	msg->hdr.front_len = cpu_to_le32(msg_size);
-
-	dout("build_request msg_size was %d\n", (int)msg_size);
-}
-EXPORT_SYMBOL(ceph_osdc_build_request);
-
-/*
  * build new request AND message, calculate layout, and adjust file
  * extent as needed.
  *
@@ -1968,6 +1870,104 @@ static void ceph_osdc_msg_data_set(struct
ceph_msg *msg,
 }

 /*
+ * build new request AND message
+ *
+ */
+void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
+				struct ceph_snap_context *snapc, u64 snap_id,
+				struct timespec *mtime)
+{
+	struct ceph_msg *msg = req->r_request;
+	void *p;
+	size_t msg_size;
+	int flags = req->r_flags;
+	u64 data_len;
+	unsigned int i;
+
+	req->r_snapid = snap_id;
+	req->r_snapc = ceph_get_snap_context(snapc);
+
+	/* encode request */
+	msg->hdr.version = cpu_to_le16(4);
+
+	p = msg->front.iov_base;
+	ceph_encode_32(&p, 1);   /* client_inc  is always 1 */
+	req->r_request_osdmap_epoch = p;
+	p += 4;
+	req->r_request_flags = p;
+	p += 4;
+	if (req->r_flags & CEPH_OSD_FLAG_WRITE)
+		ceph_encode_timespec(p, mtime);
+	p += sizeof(struct ceph_timespec);
+	req->r_request_reassert_version = p;
+	p += sizeof(struct ceph_eversion); /* will get filled in */
+
+	/* oloc */
+	ceph_encode_8(&p, 4);
+	ceph_encode_8(&p, 4);
+	ceph_encode_32(&p, 8 + 4 + 4);
+	req->r_request_pool = p;
+	p += 8;
+	ceph_encode_32(&p, -1);  /* preferred */
+	ceph_encode_32(&p, 0);   /* key len */
+
+	ceph_encode_8(&p, 1);
+	req->r_request_pgid = p;
+	p += 8 + 4;
+	ceph_encode_32(&p, -1);  /* preferred */
+
+	/* oid */
+	ceph_encode_32(&p, req->r_oid_len);
+	memcpy(p, req->r_oid, req->r_oid_len);
+	dout("oid '%.*s' len %d\n", req->r_oid_len, req->r_oid, req->r_oid_len);
+	p += req->r_oid_len;
+
+	/* ops--can imply data */
+	ceph_encode_16(&p, (u16)req->r_num_ops);
+	data_len = 0;
+	for (i = 0; i < req->r_num_ops; i++) {
+		data_len += osd_req_encode_op(req, p, i);
+		p += sizeof(struct ceph_osd_op);
+	}
+
+	/* snaps */
+	ceph_encode_64(&p, req->r_snapid);
+	ceph_encode_64(&p, req->r_snapc ? req->r_snapc->seq : 0);
+	ceph_encode_32(&p, req->r_snapc ? req->r_snapc->num_snaps : 0);
+	if (req->r_snapc) {
+		for (i = 0; i < snapc->num_snaps; i++) {
+			ceph_encode_64(&p, req->r_snapc->snaps[i]);
+		}
+	}
+
+	req->r_request_attempts = p;
+	p += 4;
+
+	/* data */
+	if (flags & CEPH_OSD_FLAG_WRITE) {
+		u16 data_off;
+
+		/*
+		 * The header "data_off" is a hint to the receiver
+		 * allowing it to align received data into its
+		 * buffers such that there's no need to re-copy
+		 * it before writing it to disk (direct I/O).
+		 */
+		data_off = (u16) (off & 0xffff);
+		req->r_request->hdr.data_off = cpu_to_le16(data_off);
+	}
+	req->r_request->hdr.data_len = cpu_to_le32(data_len);
+
+	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
+	msg_size = p - msg->front.iov_base;
+	msg->front.iov_len = msg_size;
+	msg->hdr.front_len = cpu_to_le32(msg_size);
+
+	dout("build_request msg_size was %d\n", (int)msg_size);
+}
+EXPORT_SYMBOL(ceph_osdc_build_request);
+
+/*
  * Register request, send initial attempt.
  */
 int ceph_osdc_start_request(struct ceph_osd_client *osdc,
-- 
1.7.9.5

