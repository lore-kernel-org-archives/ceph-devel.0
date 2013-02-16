From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: improve packing in struct ceph_osd_req_op
Date: Sat, 16 Feb 2013 10:24:49 -0600
Message-ID: <511FB2D1.4090306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:59969 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3BPQYw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:24:52 -0500
Received: by mail-qc0-f179.google.com with SMTP id b40so1565369qcq.38
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:24:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The layout of struct ceph_osd_req_op leaves lots of holes.
Rearranging things a little for better field alignment
reduces the size by a third.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 69287cc..82bf633 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -157,6 +157,7 @@ struct ceph_osd_client {

 struct ceph_osd_req_op {
 	u16 op;           /* CEPH_OSD_OP_* */
+	u32 payload_len;
 	union {
 		struct {
 			u64 offset, length;
@@ -165,23 +166,24 @@ struct ceph_osd_req_op {
 		} extent;
 		struct {
 			const char *name;
-			u32 name_len;
 			const char  *val;
+			u32 name_len;
 			u32 value_len;
 			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
 			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
 		} xattr;
 		struct {
 			const char *class_name;
-			__u8 class_len;
 			const char *method_name;
-			__u8 method_len;
-			__u8 argc;
 			const char *indata;
 			u32 indata_len;
+			__u8 class_len;
+			__u8 method_len;
+			__u8 argc;
 		} cls;
 		struct {
-			u64 cookie, count;
+			u64 cookie;
+			u64 count;
 		} pgls;
 	        struct {
 		        u64 snapid;
@@ -189,12 +191,11 @@ struct ceph_osd_req_op {
 		struct {
 			u64 cookie;
 			u64 ver;
-			__u8 flag;
 			u32 prot_ver;
 			u32 timeout;
+			__u8 flag;
 		} watch;
 	};
-	u32 payload_len;
 };

 extern int ceph_osdc_init(struct ceph_osd_client *osdc,
-- 
1.7.9.5

