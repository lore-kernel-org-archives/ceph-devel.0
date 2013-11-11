From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 5/7] Cifs: Introduce routine for uncaching single no-data page
Date: Mon, 11 Nov 2013 23:27:27 +0800
Message-ID: <b4c84ba0eeeda3bf915524c8173d44abb30506ff.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:52863 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab3KKPl2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 10:41:28 -0500
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, Milosz Tanski <milosz@adfin.com>, Li Wang <liwang@ubuntukylin.com>

Introduce a routine for uncaching single no-data page, typically
in readpage().

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/cifs/fscache.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 24794b6..c712f42 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -54,6 +54,7 @@ extern int __cifs_readpages_from_fscache(struct inode *,
 					 struct address_space *,
 					 struct list_head *,
 					 unsigned *);
+extern void __cifs_fscache_readpage_cancel(struct inode *, struct page *);
 extern void __cifs_fscache_readpages_cancel(struct inode *, struct list_head *);
 
 extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
@@ -92,6 +93,13 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
+static inline void cifs_fscache_readpage_cancel(struct inode *inode,
+						struct page *page)
+{
+	if (CIFS_I(inode)->fscache)
+		return __cifs_fscache_readpage_cancel(inode, page);
+}
+
 static inline void cifs_fscache_readpages_cancel(struct inode *inode,
 						 struct list_head *pages)
 {
@@ -139,6 +147,11 @@ static inline int cifs_readpages_from_fscache(struct inode *inode,
 static inline void cifs_readpage_to_fscache(struct inode *inode,
 			struct page *page) {}
 
+static inline void cifs_fscache_readpage_cancel(struct inode *inode,
+						struct page *page)
+{
+}
+
 static inline void cifs_fscache_readpages_cancel(struct inode *inode,
 						 struct list_head *pages)
 {
-- 
1.7.9.5

