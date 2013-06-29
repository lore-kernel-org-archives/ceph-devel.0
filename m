From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH] ceph: Add FScache support
Date: Fri, 28 Jun 2013 23:52:01 -0400
Message-ID: <20130629035155.GA7975@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:50226 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3F2DwI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jun 2013 23:52:08 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so1776820wes.15
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jun 2013 20:52:06 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

Adding support for fscache to the Ceph filesystem. This would bring it to on
par with some of the other network filesystems in Linux (like NFS, AFS, etc...)

This code uses uses existing ceph capabilities (cache & lazy io) to determine
if an inode is cacheable.

In order to mount the filesystem with fscache the 'fsc' mount option must be
passed.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/Kconfig  |    9 ++
 fs/ceph/Makefile |    2 +
 fs/ceph/addr.c   |   84 ++++++++++----
 fs/ceph/cache.c  |  334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/cache.h  |  115 +++++++++++++++++++
 fs/ceph/caps.c   |   12 ++
 fs/ceph/file.c   |    8 ++
 fs/ceph/inode.c  |   23 +++-
 fs/ceph/super.c  |   39 ++++++-
 fs/ceph/super.h  |   13 +++
 10 files changed, 616 insertions(+), 23 deletions(-)
 create mode 100644 fs/ceph/cache.c
 create mode 100644 fs/ceph/cache.h

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 49bc782..ac9a2ef 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -16,3 +16,12 @@ config CEPH_FS
 
 	  If unsure, say N.
 
+if CEPH_FS
+config CEPH_FSCACHE
+	bool "Enable Ceph client caching support"
+	depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
+	help
+	  Choose Y here to enable persistent, read-only local
+	  caching support for Ceph clients using FS-Cache
+
+endif
diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index bd35212..0af0678 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -9,3 +9,5 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
 	debugfs.o
 
+ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
+
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3e68ac1..b22610f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -11,6 +11,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "cache.h"
 #include <linux/ceph/osd_client.h>
 
 /*
@@ -149,11 +150,26 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc = page_snap_context(page);
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(!PagePrivate(page));
 	BUG_ON(!page->mapping);
 
 	inode = page->mapping->host;
+	ci = ceph_inode(inode);
+
+	if (offset != 0) {
+		dout("%p invalidatepage %p idx %lu partial dirty page\n",
+		     inode, page, page->index);
+		return;
+	}
+
+#ifdef CONFIG_CEPH_FSCACHE
+	if (PageFsCache(page))
+		ceph_invalidate_fscache_page(inode, page);
+#endif
+
+	if (!PagePrivate(page))
+		return;
+
+	BUG_ON(!PageLocked(page));
 
 	/*
 	 * We can get non-dirty pages here due to races between
@@ -163,31 +179,32 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	if (!PageDirty(page))
 		pr_err("%p invalidatepage %p page not dirty\n", inode, page);
 
-	if (offset == 0)
-		ClearPageChecked(page);
+	ClearPageChecked(page);
 
-	ci = ceph_inode(inode);
-	if (offset == 0) {
-		dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
-		     inode, page, page->index, offset);
-		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
-		ceph_put_snap_context(snapc);
-		page->private = 0;
-		ClearPagePrivate(page);
-	} else {
-		dout("%p invalidatepage %p idx %lu partial dirty page\n",
-		     inode, page, page->index);
-	}
+	dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
+	     inode, page, page->index, offset);
+
+	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
+	ceph_put_snap_context(snapc);
+	page->private = 0;
+	ClearPagePrivate(page);
 }
 
-/* just a sanity check */
 static int ceph_releasepage(struct page *page, gfp_t g)
 {
 	struct inode *inode = page->mapping ? page->mapping->host : NULL;
 	dout("%p releasepage %p idx %lu\n", inode, page, page->index);
 	WARN_ON(PageDirty(page));
-	WARN_ON(PagePrivate(page));
-	return 0;
+
+#ifdef CONFIG_CEPH_FSCACHE
+	/* Can we release the page from the cache? */
+	if (PageFsCache(page) && ceph_release_fscache_page(page, g) == 0)
+		return 0;
+#endif
+	if (PagePrivate(page))
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -202,6 +219,13 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	int err = 0;
 	u64 len = PAGE_CACHE_SIZE;
 
+#ifdef CONFIG_CEPH_FSCACHE
+	err = ceph_readpage_from_fscache(inode, page);
+
+	if (err == 0)
+		goto out;
+#endif
+
 	dout("readpage inode %p file %p page %p index %lu\n",
 	     inode, filp, page, page->index);
 	err = ceph_osdc_readpages(osdc, ceph_vino(inode), &ci->i_layout,
@@ -219,6 +243,11 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	}
 	SetPageUptodate(page);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	if (err == 0)
+		ceph_readpage_to_fscache(inode, page);
+#endif
+
 out:
 	return err < 0 ? err : 0;
 }
@@ -261,6 +290,9 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 		     page->index);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
+#ifdef CONFIG_CEPH_FSCACHE
+		ceph_readpage_to_fscache(inode, page);
+#endif
 		unlock_page(page);
 		page_cache_release(page);
 		bytes -= PAGE_CACHE_SIZE;
@@ -330,7 +362,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
 		page = list_entry(page_list->prev, struct page, lru);
 		BUG_ON(PageLocked(page));
 		list_del(&page->lru);
-		
+
  		dout("start_read %p adding %p idx %lu\n", inode, page,
 		     page->index);
 		if (add_to_page_cache_lru(page, &inode->i_data, page->index,
@@ -377,6 +409,14 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 	int rc = 0;
 	int max = 0;
 
+#ifdef CONFIG_CEPH_FSCACHE
+	rc = ceph_readpages_from_fscache(mapping->host, mapping, page_list,
+					 &nr_pages);
+
+	if (rc == 0)
+		goto out;
+#endif
+
 	if (fsc->mount_options->rsize >= PAGE_CACHE_SIZE)
 		max = (fsc->mount_options->rsize + PAGE_CACHE_SIZE - 1)
 			>> PAGE_SHIFT;
@@ -490,6 +530,10 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		set_bdi_congested(&fsc->backing_dev_info, BLK_RW_ASYNC);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	ceph_readpage_to_fscache(inode, page);
+#endif
+
 	set_page_writeback(page);
 	err = ceph_osdc_writepages(osdc, ceph_vino(inode),
 				   &ci->i_layout, snapc,
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
new file mode 100644
index 0000000..1ee3461
--- /dev/null
+++ b/fs/ceph/cache.c
@@ -0,0 +1,334 @@
+/*
+ * Ceph cache definitions.
+ *
+ *  Copyright (C) 2013 by Adfin Solutions, Inc. All Rights Reserved.
+ *  Written by Milosz Tanski (milosz@adfin.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor
+ *  Boston, MA  02111-1301  USA
+ *
+ */
+
+#include "super.h"
+#include "cache.h"
+
+struct ceph_aux_inode {
+	struct timespec	mtime;
+	loff_t          size;
+};
+
+struct fscache_netfs ceph_cache_netfs = {
+	.name		= "ceph",
+	.version	= 0,
+};
+
+static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
+					     void *buffer, uint16_t maxbuf)
+{
+	const struct ceph_fs_client* fsc = cookie_netfs_data;
+	uint16_t klen;
+
+	klen = sizeof(fsc->client->fsid);
+	if (klen > maxbuf)
+		return 0;
+
+	memcpy(buffer, &fsc->client->fsid, klen);
+	return klen;
+}
+
+static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
+	.name		= "CEPH.fsid",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= ceph_fscache_session_get_key,
+};
+
+void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc)
+{
+	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
+					      &ceph_fscache_fsid_object_def,
+					      fsc);
+}
+
+void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc)
+{
+	fscache_relinquish_cookie(fsc->fscache, 0);
+	fsc->fscache = NULL;
+}
+
+static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
+				  	   void *buffer, uint16_t maxbuf)
+{
+	const struct ceph_inode_info* ci = cookie_netfs_data;
+	uint16_t klen;
+
+	/* use ceph virtual inode (id + snaphot) */
+	klen = sizeof(ci->i_vino);
+	if (klen > maxbuf)
+		return 0;
+
+	memcpy(buffer, &ci->i_vino, klen);
+	return klen;
+}
+
+static uint16_t ceph_fscache_inode_get_aux(const void *cookie_netfs_data,
+					   void *buffer, uint16_t bufmax)
+{
+	struct ceph_aux_inode aux;
+	const struct ceph_inode_info* ci = cookie_netfs_data;
+	const struct inode* inode = &ci->vfs_inode;
+
+	memset(&aux, 0, sizeof(aux));
+	aux.mtime = inode->i_mtime;
+	aux.size = inode->i_size;
+
+	memcpy(buffer, &aux, sizeof(aux));
+
+	return sizeof(aux);
+}
+
+static void ceph_fscache_inode_get_attr(const void *cookie_netfs_data,
+					uint64_t *size)
+{
+	const struct ceph_inode_info* ci = cookie_netfs_data;
+	const struct inode* inode = &ci->vfs_inode;
+
+	*size = inode->i_size;
+}
+
+static enum fscache_checkaux ceph_fscache_inode_check_aux(
+	void *cookie_netfs_data, const void *data, uint16_t dlen)
+{
+	struct ceph_aux_inode aux;
+	struct ceph_inode_info* ci = cookie_netfs_data;
+	struct inode* inode = &ci->vfs_inode;
+
+	if (dlen != sizeof(aux))
+		return FSCACHE_CHECKAUX_OBSOLETE;
+
+	memset(&aux, 0, sizeof(aux));
+	aux.mtime = inode->i_mtime;
+	aux.size = inode->i_size;
+
+	if (memcmp(data, &aux, sizeof(aux)) != 0)
+		return FSCACHE_CHECKAUX_OBSOLETE;
+
+	dout("ceph inode 0x%p cached okay", ci);
+	return FSCACHE_CHECKAUX_OKAY;
+}
+
+static void ceph_fscache_inode_now_uncached(void* cookie_netfs_data)
+{
+	struct ceph_inode_info* ci = cookie_netfs_data;
+	struct pagevec pvec;
+	pgoff_t first;
+	int loop, nr_pages;
+
+	pagevec_init(&pvec, 0);
+	first = 0;
+
+	dout("ceph inode 0x%p now uncached", ci);
+
+	while (1) {
+		nr_pages = pagevec_lookup(&pvec, ci->vfs_inode.i_mapping, first,
+					  PAGEVEC_SIZE - pagevec_count(&pvec));
+
+		if (!nr_pages)
+			break;
+
+		for (loop = 0; loop < nr_pages; loop++)
+			ClearPageFsCache(pvec.pages[loop]);
+
+		first = pvec.pages[nr_pages - 1]->index + 1;
+
+		pvec.nr = nr_pages;
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+}
+
+static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
+	.name		= "CEPH.inode",
+	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
+	.get_key	= ceph_fscache_inode_get_key,
+	.get_attr	= ceph_fscache_inode_get_attr,
+	.get_aux	= ceph_fscache_inode_get_aux,
+	.check_aux	= ceph_fscache_inode_check_aux,
+	.now_uncached	= ceph_fscache_inode_now_uncached,
+};
+
+
+static int get_caps_issued(struct ceph_inode_info* ci)
+{
+	int issued;
+	int implemented = 0;
+
+	issued = __ceph_caps_issued(ci, &implemented);
+	issued |= implemented | __ceph_caps_dirty(ci);
+	return issued;
+}
+
+
+void ceph_fscache_register_inode_cookie(struct ceph_fs_client* fsc,
+					struct ceph_inode_info* ci)
+{
+	const int want = (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO);
+
+	/* No caching for filesystem */
+	if (fsc->fscache == NULL)
+		return;
+	/* Only do it for data files */
+	if ((ci->vfs_inode.i_mode & S_IFREG) == 0)
+		return;
+
+	if (ci->fscache)
+		return;
+	if ((get_caps_issued(ci) & want) == 0) {
+		dout("No caps for caching inode: %p", &ci->vfs_inode);
+		return;
+	}
+
+	ci->fscache = fscache_acquire_cookie(fsc->fscache,
+					     &ceph_fscache_inode_object_def,
+					     ci);
+}
+
+void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
+{
+	if (ci->fscache == NULL)
+		return;
+
+	fscache_relinquish_cookie(ci->fscache, 0);
+	ci->fscache = NULL;
+}
+
+void ceph_fscache_revoke_inode_cookie(struct ceph_inode_info* ci)
+{
+	if (ci->fscache == NULL)
+		return;
+
+	fscache_invalidate(ci->fscache);
+	/* Make sure the cache is cleared after we close the handle */
+	fscache_relinquish_cookie(ci->fscache, 1);
+	ci->fscache = NULL;
+}
+
+void __ceph_fscache_async_uncache_inode(struct ceph_inode_info* ci)
+{
+	fscache_uncache_all_inode_pages(ci->fscache, &ci->vfs_inode);
+}
+
+static void ceph_vfs_readpage_complete(struct page *page, void *data, int error)
+{
+	if (!error)
+		SetPageUptodate(page);
+}
+
+static void ceph_vfs_readpage_complete_unlock(struct page *page, void *data, int error)
+{
+	if (!error) {
+		SetPageUptodate(page);
+		unlock_page(page);
+	}
+}
+
+/* Atempt to read from the fscache,
+ *
+ * This function is called from the readpage_nounlock context. DO NOT attempt to
+ * unlock the page here (or in the callback).
+ */
+int __ceph_readpage_from_fscache(struct inode *inode, struct page *page)
+{
+	const struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret;
+
+	ret = fscache_read_or_alloc_page(ci->fscache, page,
+					 ceph_vfs_readpage_complete, NULL,
+					 GFP_KERNEL);
+
+	switch (ret) {
+		case 0: /* Page found */
+			dout("page read submitted\n");
+			return 0;
+		case -ENOBUFS: /* Pages were not found, and can't be */
+		case -ENODATA: /* Pages were not found */
+			dout("page/inode not in cache\n");
+			return 1;
+		default:
+			dout("%s: unknown error ret = %i\n", __func__, ret);
+			return ret;
+	}
+}
+
+int __ceph_readpages_from_fscache(struct inode *inode,
+				  struct address_space *mapping,
+				  struct list_head *pages,
+				  unsigned *nr_pages)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int issued = get_caps_issued(ci);
+	const int want = (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO);
+	int ret;
+
+	/* Check if we have cached read caps */
+	if ((issued & want) == 0) {
+		return -ENOBUFS;
+	}
+
+	ret = fscache_read_or_alloc_pages(ci->fscache, mapping, pages, nr_pages,
+					  ceph_vfs_readpage_complete_unlock,
+					  NULL, mapping_gfp_mask(mapping));
+
+	switch (ret) {
+		case 0: /* All pages found */
+			dout("all-page read submitted\n");
+			return 0;
+		case -ENOBUFS: /* Some pages were not found, and can't be */
+		case -ENODATA: /* some pages were not found */
+			dout("page/inode not in cache\n");
+			return 1;
+		default:
+			dout("%s: unknown error ret = %i\n", __func__, ret);
+			return ret;
+	}
+}
+
+void __ceph_readpage_to_fscache(struct inode *inode, struct page *page)
+{
+	const struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret;
+
+	ret = fscache_write_page(ci->fscache, page, GFP_KERNEL);
+	if (ret)
+		 fscache_uncache_page(ci->fscache, page);
+}
+
+void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
+{
+	const struct ceph_inode_info *ci = ceph_inode(inode);
+	struct fscache_cookie *cookie = ci->fscache;
+
+	fscache_wait_on_page_write(cookie, page);
+	fscache_uncache_page(cookie, page);
+}
+
+int __ceph_release_fscache_page(struct page *page, gfp_t gfp)
+{
+	struct inode* inode = page->mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct fscache_cookie *cookie = ci->fscache;
+
+	return fscache_maybe_release_page(cookie, page, gfp);
+}
+
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
new file mode 100644
index 0000000..7d24151
--- /dev/null
+++ b/fs/ceph/cache.h
@@ -0,0 +1,115 @@
+/*
+ * Ceph cache definitions.
+ *
+ *  Copyright (C) 2013 by Adfin Solutions, Inc. All Rights Reserved.
+ *  Written by Milosz Tanski (milosz@adfin.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor
+ *  Boston, MA  02111-1301  USA
+ *
+ */
+
+#ifndef _CEPH_CACHE_H
+#define _CEPH_CACHE_H
+#ifdef CONFIG_CEPH_FSCACHE
+
+#include <linux/fscache.h>
+
+
+extern struct fscache_netfs ceph_cache_netfs;
+
+
+void ceph_fscache_inode_get_cookie(struct inode *inode);
+
+void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc);
+void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc);
+void ceph_fscache_register_inode_cookie(struct ceph_fs_client* parent_fsc,
+					struct ceph_inode_info* ci);
+void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
+void ceph_fscache_revoke_inode_cookie(struct ceph_inode_info* ci);
+void __ceph_fscache_async_uncache_inode(struct ceph_inode_info* ci);
+
+int __ceph_readpage_from_fscache(struct inode *inode, struct page *page);
+int __ceph_readpages_from_fscache(struct inode *inode,
+				  struct address_space *mapping,
+				  struct list_head *pages,
+				  unsigned *nr_pages);
+void __ceph_readpage_to_fscache(struct inode *inode, struct page *page);
+void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
+int __ceph_release_fscache_page(struct page *page, gfp_t gfp);
+
+static inline void ceph_fsxache_async_uncache_inode(struct inode* inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (ci->fscache == NULL)
+		return;
+
+	__ceph_fscache_async_uncache_inode(ci);
+}
+
+static inline int ceph_readpage_from_fscache(struct inode *inode,
+					     struct page *page)
+{
+	if (ceph_inode(inode)->fscache == NULL)
+		return -ENOBUFS;
+
+	return __ceph_readpage_from_fscache(inode, page);
+}
+
+static inline int ceph_readpages_from_fscache(struct inode *inode,
+					      struct address_space *mapping,
+					      struct list_head *pages,
+					      unsigned *nr_pages)
+{
+	if (ceph_inode(inode)->fscache == NULL)
+		return -ENOBUFS;
+
+	return __ceph_readpages_from_fscache(inode, mapping, pages, nr_pages);
+}
+
+static inline void ceph_readpage_to_fscache(struct inode *inode,
+					    struct page *page)
+{
+	if (ceph_inode(inode)->fscache == NULL)
+		return;
+
+	if (PageFsCache(page))
+		return __ceph_readpage_to_fscache(inode, page);
+}
+
+static inline void ceph_invalidate_fscache_page(struct inode *inode,
+						struct page *page)
+{
+	if (ceph_inode(inode)->fscache == NULL)
+		return;
+
+	if (PageFsCache(page))
+		return __ceph_invalidate_fscache_page(inode, page);
+}
+
+static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
+{
+	struct inode* inode = page->mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (ci->fscache == NULL)
+		return 1;
+	
+	return __ceph_release_fscache_page(page, gfp);
+}
+
+#endif
+#endif
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index da0f9b8..5379f41 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -10,6 +10,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "cache.h"
 #include <linux/ceph/decode.h>
 #include <linux/ceph/messenger.h>
 
@@ -2366,6 +2367,11 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 				ci->i_rdcache_revoking = ci->i_rdcache_gen;
 			}
 		}
+
+#ifdef CONFIG_CEPH_FSCACHE
+		/* Close the fscache on inode */
+		ceph_fscache_unregister_inode_cookie(ci);
+#endif
 	}
 
 	/* side effects now are allowed */
@@ -2425,6 +2431,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		wake = 1;
 	}
 
+#ifdef CONFIG_CEPH_FSCACHE
+	/* Register cache (if needed); perform this after any size change. */
+	if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
+		ceph_fscache_register_inode_cookie(session->s_mdsc->fsc, ci);
+#endif
+
 	/* check cap bits */
 	wanted = __ceph_caps_wanted(ci);
 	used = __ceph_caps_used(ci);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 656e169..2162b35 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -11,6 +11,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "cache.h"
 
 /*
  * Ceph file operations
@@ -67,10 +68,17 @@ out:
 static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 {
 	struct ceph_file_info *cf;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
 	int ret = 0;
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
+#ifdef CONFIG_CEPH_FSCACHE
+		spin_lock(&ci->i_ceph_lock);
+		ceph_fscache_register_inode_cookie(fsc, ci);
+		spin_unlock(&ci->i_ceph_lock);
+#endif
 	case S_IFDIR:
 		dout("init_file %p %p 0%o (regular)\n", inode, file,
 		     inode->i_mode);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index be0f7e2..5144b36 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -12,6 +12,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "cache.h"
 #include <linux/ceph/decode.h>
 
 /*
@@ -377,6 +378,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	INIT_WORK(&ci->i_vmtruncate_work, ceph_vmtruncate_work);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	ci->fscache = NULL;
+#endif
+
 	return &ci->vfs_inode;
 }
 
@@ -396,6 +401,10 @@ void ceph_destroy_inode(struct inode *inode)
 
 	dout("destroy_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
+#ifdef CONFIG_CEPH_FSCACHE
+	ceph_fscache_unregister_inode_cookie(ci);
+#endif
+
 	ceph_queue_caps_release(inode);
 
 	/*
@@ -430,7 +439,6 @@ void ceph_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, ceph_i_callback);
 }
 
-
 /*
  * Helpers to fill in size, ctime, mtime, and atime.  We have to be
  * careful because either the client or MDS may have more up to date
@@ -633,6 +641,14 @@ static int fill_inode(struct inode *inode,
 			    le32_to_cpu(info->time_warp_seq),
 			    &ctime, &mtime, &atime);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	/* Notify the cache that size has changed */
+	if (queue_trunc && ci->fscache) {
+		pr_info("size changed inode: %p cap flags\n", &ci->vfs_inode);
+		fscache_attr_changed(ci->fscache);
+	}
+#endif
+
 	/* only update max_size on auth cap */
 	if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 	    ci->i_max_size != le64_to_cpu(info->max_size)) {
@@ -1430,6 +1446,11 @@ static void ceph_invalidate_work(struct work_struct *work)
 	orig_gen = ci->i_rdcache_gen;
 	spin_unlock(&ci->i_ceph_lock);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	dout("cache invalidating inode: %p cap flags\n", &ci->vfs_inode);
+	fscache_invalidate(ci->fscache);
+#endif
+
 	truncate_inode_pages(&inode->i_data, 0);
 
 	spin_lock(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7d377c9..850c161 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -17,6 +17,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "cache.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -142,6 +143,8 @@ enum {
 	Opt_nodcache,
 	Opt_ino32,
 	Opt_noino32,
+	Opt_fscache,
+	Opt_nofscache
 };
 
 static match_table_t fsopt_tokens = {
@@ -167,6 +170,8 @@ static match_table_t fsopt_tokens = {
 	{Opt_nodcache, "nodcache"},
 	{Opt_ino32, "ino32"},
 	{Opt_noino32, "noino32"},
+	{Opt_fscache, "fsc"},
+	{Opt_nofscache, "nofsc"},
 	{-1, NULL}
 };
 
@@ -260,6 +265,12 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_noino32:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_INO32;
 		break;
+	case Opt_fscache:
+		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
+		break;
+	case Opt_nofscache:
+		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
+		break;
 	default:
 		BUG_ON(token);
 	}
@@ -422,6 +433,10 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",dcache");
 	else
 		seq_puts(m, ",nodcache");
+	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
+		seq_puts(m, ",fsc");
+	else
+		seq_puts(m, ",nofsc");
 
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
@@ -530,6 +545,11 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	if (!fsc->wb_pagevec_pool)
 		goto fail_trunc_wq;
 
+#ifdef CONFIG_CEPH_FSCACHE
+	if ((fsopt->flags & CEPH_MOUNT_OPT_FSCACHE))
+		ceph_fscache_register_fsid_cookie(fsc);
+#endif
+
 	/* caps */
 	fsc->min_caps = fsopt->max_readdir;
 
@@ -554,6 +574,10 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 {
 	dout("destroy_fs_client %p\n", fsc);
 
+#ifdef CONFIG_CEPH_FSCACHE
+	ceph_fscache_unregister_fsid_cookie(fsc);
+#endif
+
 	destroy_workqueue(fsc->wb_wq);
 	destroy_workqueue(fsc->pg_inv_wq);
 	destroy_workqueue(fsc->trunc_wq);
@@ -588,6 +612,8 @@ static void ceph_inode_init_once(void *foo)
 
 static int __init init_caches(void)
 {
+	int error = -ENOMEM;
+
 	ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
 				      sizeof(struct ceph_inode_info),
 				      __alignof__(struct ceph_inode_info),
@@ -611,15 +637,19 @@ static int __init init_caches(void)
 	if (ceph_file_cachep == NULL)
 		goto bad_file;
 
-	return 0;
+#ifdef CONFIG_CEPH_FSCACHE
+	if ((error = fscache_register_netfs(&ceph_cache_netfs)))
+		goto bad_file;
+#endif
 
+	return 0;
 bad_file:
 	kmem_cache_destroy(ceph_dentry_cachep);
 bad_dentry:
 	kmem_cache_destroy(ceph_cap_cachep);
 bad_cap:
 	kmem_cache_destroy(ceph_inode_cachep);
-	return -ENOMEM;
+	return error;
 }
 
 static void destroy_caches(void)
@@ -629,10 +659,15 @@ static void destroy_caches(void)
 	 * destroy cache.
 	 */
 	rcu_barrier();
+
 	kmem_cache_destroy(ceph_inode_cachep);
 	kmem_cache_destroy(ceph_cap_cachep);
 	kmem_cache_destroy(ceph_dentry_cachep);
 	kmem_cache_destroy(ceph_file_cachep);
+
+#ifdef CONFIG_CEPH_FSCACHE
+	fscache_unregister_netfs(&ceph_cache_netfs);
+#endif
 }
 
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7ccfdb4..5ddaad5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -16,6 +16,10 @@
 
 #include <linux/ceph/libceph.h>
 
+#ifdef CONFIG_CEPH_FSCACHE
+#include <linux/fscache.h>
+#endif
+
 /* f_type in struct statfs */
 #define CEPH_SUPER_MAGIC 0x00c36400
 
@@ -29,6 +33,7 @@
 #define CEPH_MOUNT_OPT_NOASYNCREADDIR  (1<<7) /* no dcache readdir */
 #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
 #define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
+#define CEPH_MOUNT_OPT_FSCACHE         (1<<10) /* use fscache */
 
 #define CEPH_MOUNT_OPT_DEFAULT    (CEPH_MOUNT_OPT_RBYTES)
 
@@ -90,6 +95,10 @@ struct ceph_fs_client {
 	struct dentry *debugfs_bdi;
 	struct dentry *debugfs_mdsc, *debugfs_mdsmap;
 #endif
+
+#ifdef CONFIG_CEPH_FSCACHE
+	struct fscache_cookie *fscache;
+#endif
 };
 
 
@@ -319,6 +328,10 @@ struct ceph_inode_info {
 
 	struct work_struct i_vmtruncate_work;
 
+#ifdef CONFIG_CEPH_FSCACHE
+	struct fscache_cookie *fscache;
+#endif
+
 	struct inode vfs_inode; /* at end */
 };
 
-- 
1.7.10.4

