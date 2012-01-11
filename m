From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/2] vfs: export symbol d_find_any_alias()
Date: Wed, 11 Jan 2012 10:46:41 -0800
Message-ID: <1326307602-16284-2-git-send-email-sage@newdream.net>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45189 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab2AKSym (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 13:54:42 -0500
In-Reply-To: <1326307602-16284-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: viro@ZenIV.linux.org.uk, hch@infradead.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Sage Weil <sage@newdream.net>

Ceph needs this.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/dcache.c            |    4 ++--
 include/linux/dcache.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 89509b5..80208e6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1471,7 +1471,7 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	return alias;
 }
 
-static struct dentry * d_find_any_alias(struct inode *inode)
+struct dentry * d_find_any_alias(struct inode *inode)
 {
 	struct dentry *de;
 
@@ -1480,7 +1480,7 @@ static struct dentry * d_find_any_alias(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
-
+EXPORT_SYMBOL(d_find_any_alias);
 
 /**
  * d_obtain_alias - find or allocate a dentry for a given inode
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ed9f74f..86079df 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -241,6 +241,7 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern struct dentry * d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-- 
1.7.0

