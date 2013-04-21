From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix byte order mismatch
Date: Sun, 21 Apr 2013 16:55:55 -0500
Message-ID: <5174606B.4090906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63006 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3DUVz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:55:57 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so6426672iec.22
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:55:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A WATCH op includes an object version.  The version that's supplied
is incorrectly byte-swapped osd_req_op_watch_init() where it's first
assigned (it's been this way since that code was first added).

The result is that the version sent to the osd is wrong, because
that value gets byte-swapped again in osd_req_encode_op().  This
is the source of a sparse warning related to improper byte order in
the assignment.

The approach of using the version to avoid a race is deprecated
(see http://tracker.ceph.com/issues/3871), and the watch parameter
is no longer even examined by the osd.  So fix the assignment in
osd_req_op_watch_init() so it no longer does the byte swap.

This resolves:
    http://tracker.ceph.com/issues/3847

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 467020c..57d8db5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -577,8 +577,7 @@ void osd_req_op_watch_init(struct ceph_osd_request
*osd_req,
 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);

 	op->watch.cookie = cookie;
-	/* op->watch.ver = version; */	/* XXX 3847 */
-	op->watch.ver = cpu_to_le64(version);
+	op->watch.ver = version;
 	if (opcode == CEPH_OSD_OP_WATCH && flag)
 		op->watch.flag = (u8)1;
 }
-- 
1.7.9.5

