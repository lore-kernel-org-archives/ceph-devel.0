From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: fix __dcache_readdir()
Date: Thu, 13 Feb 2014 21:04:23 +0800
Message-ID: <1392296663-5654-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19057 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbaBMNE3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Feb 2014 08:04:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

If directory is fragmented, readdir() read its dirfrags one by one.
After reading all dirfrags, the corresponding dentries are sorted in
(frag_t, off) order in the dcache. If dentries of a directory are all
cached, __dcache_readdir() can use the cached dentries to satisfy
readdir syscall. But when checking if a given dentry is after the
the position of readdir, __dcache_readdir() compares numerical value
of frag_t directly. This is wrong, it should use ceph_frag_compare().

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3bbd0eb..42edab9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -100,6 +100,14 @@ static unsigned fpos_off(loff_t p)
 	return p & 0xffffffff;
 }
 
+static int fpos_cmp(loff_t l, loff_t r)
+{
+	int v = ceph_frag_compare(fpos_frag(l), fpos_frag(r));
+	if (v)
+		return v;
+	return fpos_off(l) > fpos_off(r);
+}
+
 /*
  * When possible, we try to satisfy a readdir by peeking at the
  * dcache.  We make this work by carefully ordering dentries on
@@ -156,7 +164,7 @@ more:
 		if (!d_unhashed(dentry) && dentry->d_inode &&
 		    ceph_snap(dentry->d_inode) != CEPH_SNAPDIR &&
 		    ceph_ino(dentry->d_inode) != CEPH_INO_CEPH &&
-		    ctx->pos <= di->offset)
+		    fpos_cmp(ctx->pos, di->offset) <= 0)
 			break;
 		dout(" skipping %p %.*s at %llu (%llu)%s%s\n", dentry,
 		     dentry->d_name.len, dentry->d_name.name, di->offset,
-- 
1.8.5.3

