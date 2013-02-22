From: Sage Weil <sage@inktank.com>
Subject: [PATCH] ceph: fix statvfs fr_size
Date: Fri, 22 Feb 2013 15:23:42 -0800
Message-ID: <1361575422-20180-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44644 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab3BVXXp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 18:23:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Different versions of glibc are broken in different ways, but the short of
it is that for the time being, frsize should == bsize, and be used as the
multiple for the blocks, free, and available fields.  This mirrors what is
done for NFS.  The previous reporting of the page size for frsize meant
that newer glibc and df would report a very small value for the fs size.

Fixes http://tracker.ceph.com/issues/3793.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/super.c |    7 ++++++-
 fs/ceph/super.h |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index e86aa99..006f94b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -71,8 +71,14 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	/*
 	 * express utilization in terms of large blocks to avoid
 	 * overflow on 32-bit machines.
+	 *
+	 * NOTE: for the time being, we make bsize == frsize so humor
+	 * not-yet-ancient versions of glibc that are broken.
+	 * Someday, we will probably want to report a real block
+	 * size...  whatever that may mean for a network file system!
 	 */
 	buf->f_bsize = 1 << CEPH_BLOCK_SHIFT;
+	buf->f_frsize = 1 << CEPH_BLOCK_SHIFT;
 	buf->f_blocks = le64_to_cpu(st.kb) >> (CEPH_BLOCK_SHIFT-10);
 	buf->f_bfree = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
 	buf->f_bavail = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
@@ -80,7 +86,6 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = le64_to_cpu(st.num_objects);
 	buf->f_ffree = -1;
 	buf->f_namelen = NAME_MAX;
-	buf->f_frsize = PAGE_CACHE_SIZE;
 
 	/* leave fsid little-endian, regardless of host endianness */
 	fsid = *(u64 *)(&monmap->fsid) ^ *((u64 *)&monmap->fsid + 1);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9861cce..604526a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -21,7 +21,7 @@
 
 /* large granularity for statfs utilization stats to facilitate
  * large volume sizes on 32-bit machines. */
-#define CEPH_BLOCK_SHIFT   20  /* 1 MB */
+#define CEPH_BLOCK_SHIFT   22  /* 4 MB */
 #define CEPH_BLOCK         (1 << CEPH_BLOCK_SHIFT)
 
 #define CEPH_MOUNT_OPT_DIRSTAT         (1<<4) /* `cat dirname` for stats */
-- 
1.7.9.5

