From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] vfs: export symbol d_find_any_alias()
Date: Wed, 11 Jan 2012 12:43:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201111241270.13761@cobra.newdream.net>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
 <1326307602-16284-2-git-send-email-sage@newdream.net> <20120111185557.GA29582@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50132 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933502Ab2AKUoJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 15:44:09 -0500
In-Reply-To: <20120111185557.GA29582@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 11 Jan 2012, Christoph Hellwig wrote:
> On Wed, Jan 11, 2012 at 10:46:41AM -0800, Sage Weil wrote:
> > Ceph needs this.
> > 
> > Signed-off-by: Sage Weil <sage@newdream.net>
> 
> Can you add a kerneldoc comment now that it is exported?
> 
> > -static struct dentry * d_find_any_alias(struct inode *inode)
> > +struct dentry * d_find_any_alias(struct inode *inode)
> 
> also if you touch the line anyway please remove the superflous
> whitespace after the '*'.

I almost did that, until the prototype stuck out like a sore thumb in 
dcache.h.  Fixed up, see below:


From d0207b0a2646a20e25ca8729a1d18ee74fdabfb9 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Tue, 10 Jan 2012 09:04:37 -0800
Subject: [PATCH 1/2] vfs: export symbol d_find_any_alias()

Ceph needs this.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/dcache.c            |   11 +++++++++--
 include/linux/dcache.h |    1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 89509b5..ba96005 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1471,7 +1471,14 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	return alias;
 }
 
-static struct dentry * d_find_any_alias(struct inode *inode)
+/**
+ * d_find_any_alias - find any alias for a given inode
+ * @inode: inode to find an alias for
+ *
+ * If any aliases exist for the given inode, take and return a
+ * reference for one of them.  If no aliases exist, return %NULL.
+ */
+struct dentry *d_find_any_alias(struct inode *inode)
 {
 	struct dentry *de;
 
@@ -1480,7 +1487,7 @@ static struct dentry * d_find_any_alias(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
-
+EXPORT_SYMBOL(d_find_any_alias);
 
 /**
  * d_obtain_alias - find or allocate a dentry for a given inode
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ed9f74f..3871ba7 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -241,6 +241,7 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern struct dentry *d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-- 
1.7.0

