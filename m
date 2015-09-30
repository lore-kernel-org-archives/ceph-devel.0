From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] ceph: fix a comment typo
Date: Tue, 29 Sep 2015 20:36:57 -0700
Message-ID: <4fb037c2ae2e494be58dc752483fb2f852a4cd70.1443612355.git.geliangtang@163.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-12.163.com ([220.181.12.12]:50301 "EHLO m12-12.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbbI3DhP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Sep 2015 23:37:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Geliang Tang <geliangtang@163.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Just fix a typo in the code comment.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 fs/ceph/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 834f9f3..a4766de 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -88,7 +88,7 @@ static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
 	const struct ceph_inode_info* ci = cookie_netfs_data;
 	uint16_t klen;
 
-	/* use ceph virtual inode (id + snaphot) */
+	/* use ceph virtual inode (id + snapshot) */
 	klen = sizeof(ci->i_vino);
 	if (klen > maxbuf)
 		return 0;
-- 
1.9.1


