From: Nikolay Borisov <n.borisov.lkml@gmail.com>
Subject: [PATCH v2] ceph: Mark the file cache as unreclaimable
Date: Mon, 25 Jul 2016 20:12:13 +0300
Message-ID: <1469466733-9092-1-git-send-email-n.borisov.lkml@gmail.com>
References: <1469466572-8939-1-git-send-email-n.borisov.lkml@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35529 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcGYRMU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 13:12:20 -0400
In-Reply-To: <1469466572-8939-1-git-send-email-n.borisov.lkml@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Nikolay Borisov <n.borisov.lkml@gmail.com>

Ceph creates multiple caches with the SLAB_RECLAIMABLE flag set, so
that it can satisfy its internal needs. Inspecting the code shows that
most of the caches are indeed reclaimable since they are directly
related to the generic inode/dentry shrinkers. However, one of the
cache used to satisfy struct file is not reclaimable since its
entries are freed only when the last reference to the file is
dropped. If a heavily loaded node opens a lot of files it can
introduce non-trivial discrepancies between memory shown as reclaimable
and what is actually reclaimed when drop_caches is used.

Fix this by removing the reclaimable flag for the file's cache.

Signed-off-by: Nikolay Borisov <n.borisov.lkml@gmail.com>
---

Fixed checkpatch warning + missing SOB line

 fs/ceph/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 91e02481ce06..8697cac6add0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -672,8 +672,8 @@ static int __init init_caches(void)
 	if (ceph_dentry_cachep == NULL)
 		goto bad_dentry;
 
-	ceph_file_cachep = KMEM_CACHE(ceph_file_info,
-				      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
+	ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
+
 	if (ceph_file_cachep == NULL)
 		goto bad_file;
 
-- 
2.7.4

