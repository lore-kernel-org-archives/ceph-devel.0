From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 1/5] libceph: encode CEPH_OSD_OP_FLAG_* op flags
Date: Tue, 25 Feb 2014 17:36:43 +0200
Message-ID: <1393342607-23653-2-git-send-email-ilya.dryomov@inktank.com>
References: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:41634 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbaBYPgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:36:53 -0500
Received: by mail-lb0-f170.google.com with SMTP id s7so519055lbd.29
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:36:52 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id x4sm10579359lbn.2.2014.02.25.07.36.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 07:36:51 -0800 (PST)
In-Reply-To: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encode ceph_osd_op::flags field so that it gets sent over the wire.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 include/linux/ceph/osd_client.h |    1 +
 include/linux/ceph/rados.h      |    2 +-
 net/ceph/osd_client.c           |    2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index fd47e872ebcc..e94f5da251d6 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -76,6 +76,7 @@ struct ceph_osd_data {
 
 struct ceph_osd_req_op {
 	u16 op;           /* CEPH_OSD_OP_* */
+	u32 flags;        /* CEPH_OSD_OP_FLAG_* */
 	u32 payload_len;
 	union {
 		struct ceph_osd_data raw_data_in;
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 96292df4041b..8f9bf4570215 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -382,7 +382,7 @@ enum {
  */
 struct ceph_osd_op {
 	__le16 op;           /* CEPH_OSD_OP_* */
-	__le32 flags;        /* CEPH_OSD_FLAG_* */
+	__le32 flags;        /* CEPH_OSD_OP_FLAG_* */
 	union {
 		struct {
 			__le64 offset, length;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0676f2b199d6..5d7fd0b8c1c8 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -688,7 +688,9 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 
 		return 0;
 	}
+
 	dst->op = cpu_to_le16(src->op);
+	dst->flags = cpu_to_le32(src->flags);
 	dst->payload_len = cpu_to_le32(src->payload_len);
 
 	return request_data_len;
-- 
1.7.10.4

