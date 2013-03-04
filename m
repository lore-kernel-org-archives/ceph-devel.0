From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: use (void *) for untyped data in osd ops
Date: Mon, 04 Mar 2013 12:09:15 -0600
Message-ID: <5134E34B.6070903@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E30E.2090400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:33683 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab3CDSJP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:09:15 -0500
Received: by mail-ia0-f175.google.com with SMTP id k38so2938120iah.34
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:09:15 -0800 (PST)
In-Reply-To: <5134E30E.2090400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Two of the fields defining osd operations are defined using (char *)
while the data they represent are really untyped, not character
strings.  Change them to have type (void *).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index a79f833..ec33588 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -184,7 +184,7 @@ struct ceph_osd_req_op {
 		} extent;
 		struct {
 			const char *name;
-			const char  *val;
+			const void *val;
 			u32 name_len;
 			u32 value_len;
 			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
@@ -193,7 +193,7 @@ struct ceph_osd_req_op {
 		struct {
 			const char *class_name;
 			const char *method_name;
-			const char *indata;
+			const void *indata;
 			u32 indata_len;
 			__u8 class_len;
 			__u8 method_len;
-- 
1.7.9.5

