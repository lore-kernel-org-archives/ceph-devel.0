From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 5/8] ceph: clean PgPrivate2 on returning from readpages
Date: Thu, 5 Sep 2013 18:22:36 -0400
Message-ID: <3a29a98a66a06a8219608432a42376a3a994786b.1378418255.git.milosz@adfin.com>
References: <cover.1378418255.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1378418255.git.milosz@adfin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com, dhowells@redhat.com, jiayisuse@gmail.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

In some cases the ceph readapages code code bails without filling all the pages
already marked by fscache. When we return back to readahead code this causes
a BUG.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/addr.c  |    2 ++
 fs/ceph/cache.h |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3a21a7c..1fda9cf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -398,6 +398,8 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 		BUG_ON(rc == 0);
 	}
 out:
+	ceph_fscache_readpages_cancel(inode, page_list);
+
 	dout("readpages %p file %p ret %d\n", inode, file, rc);
 	return rc;
 }
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 0ea95cb..fb326fd 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -58,6 +58,13 @@ static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
 	return fscache_maybe_release_page(ci->fscache, page, gfp);
 }
 
+static inline void ceph_fscache_readpages_cancel(struct inode *inode,
+						 struct list_head *pages)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	return fscache_readpages_cancel(ci->fscache, pages);
+}
+
 #else
 
 static inline int ceph_fscache_register(void)
-- 
1.7.9.5
