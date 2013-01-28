From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/3] rbd-fuse: fix usage of conn->want
Date: Mon, 28 Jan 2013 16:33:43 +0100
Message-ID: <1359387224-6769-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38889 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766Ab3A1Pds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 10:33:48 -0500
In-Reply-To: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>

Fix usage of conn->want and FUSE_CAP_BIG_WRITES. Both need libfuse
version >= 2.8. Encapsulate the related code line into a check for
the needed FUSE_VERSION as already done in ceph-fuse in some cases.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rbd_fuse/rbd-fuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/rbd_fuse/rbd-fuse.c b/src/rbd_fuse/rbd-fuse.c
index b3e318f..c204463 100644
--- a/src/rbd_fuse/rbd-fuse.c
+++ b/src/rbd_fuse/rbd-fuse.c
@@ -461,8 +461,9 @@ rbdfs_init(struct fuse_conn_info *conn)
 	ret = rados_ioctx_create(cluster, pool_name, &ioctx);
 	if (ret < 0)
 		exit(91);
-
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 	conn->want |= FUSE_CAP_BIG_WRITES;
+#endif
 	gotrados = 1;
 
 	// init's return value shows up in fuse_context.private_data,
-- 
1.8.1.1

