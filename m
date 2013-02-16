From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: simplify data length calculation
Date: Sat, 16 Feb 2013 11:08:05 -0600
Message-ID: <511FBCF5.7090506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:63241 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab3BPRIH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:08:07 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so1578400qco.35
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:08:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Simplify the way the data length recorded in a message header is
calculated in ceph_osdc_build_request().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index bbd1575..b58748e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -335,7 +335,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	void *p;
 	size_t msg_size = sizeof(*head) + num_op*sizeof(*op);
 	int flags = req->r_flags;
-	u64 data_len = 0;
+	u64 data_len;
 	int i;

 	WARN_ON((flags & (CEPH_OSD_FLAG_READ|CEPH_OSD_FLAG_WRITE)) == 0);
@@ -363,8 +363,6 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	while (num_op--)
 		osd_req_encode_op(req, op++, src_op++);

-	data_len += req->r_trail.length;
-
 	if (snapc) {
 		head->snap_seq = cpu_to_le64(snapc->seq);
 		head->num_snaps = cpu_to_le32(snapc->num_snaps);
@@ -374,14 +372,12 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 		}
 	}

+	data_len = req->r_trail.length;
 	if (flags & CEPH_OSD_FLAG_WRITE) {
 		req->r_request->hdr.data_off = cpu_to_le16(off);
-		req->r_request->hdr.data_len = cpu_to_le32(len + data_len);
-	} else if (data_len) {
-		req->r_request->hdr.data_off = 0;
-		req->r_request->hdr.data_len = cpu_to_le32(data_len);
+		data_len += len;
 	}
-
+	req->r_request->hdr.data_len = cpu_to_le32(data_len);
 	req->r_request->page_alignment = req->r_page_alignment;

 	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
-- 
1.7.9.5

