From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: kill ceph_osd_req_op->flags
Date: Wed, 14 Nov 2012 10:35:42 -0600
Message-ID: <50A3C85E.4050904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:55364 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KNQfo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:35:44 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so396577iay.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:35:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The flags field of struct ceph_osd_req_op is never used, so just get
rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 2b04d05..69287cc 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -157,7 +157,6 @@ struct ceph_osd_client {

 struct ceph_osd_req_op {
 	u16 op;           /* CEPH_OSD_OP_* */
-	u32 flags;        /* CEPH_OSD_FLAG_* */
 	union {
 		struct {
 			u64 offset, length;
-- 
1.7.9.5

