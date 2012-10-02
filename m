From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: avoid 32-bit page index overflow
Date: Tue, 02 Oct 2012 10:28:24 -0500
Message-ID: <506B0818.1040407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50110 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab2JBP20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 11:28:26 -0400
Received: by ieak13 with SMTP id k13so14913314iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 08:28:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A pgoff_t is defined (by default) to have type (unsigned long).  On
architectures such as i686 that's a 32-bit type.  The ceph address
space code was attempting to produce 64 bit offsets by shifting a
page's index by PAGE_CACHE_SHIFT, but the result was not what was
desired because the shift occurred before the result got promoted
to 64 bits.

Fix this by casting all uses of page->index used in this way to
the desired 64-bit type.

This fixes http://tracker.newdream.net/issues/3112

Reported-by:  Mohamed Pakkeer <pakkeer.mohideen@realimage.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4469b63..15dee48 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -205,7 +205,7 @@ static int readpage_nounlock(struct file *filp,
struct page *page)
 	dout("readpage inode %p file %p page %p index %lu\n",
 	     inode, filp, page, page->index);
 	err = ceph_osdc_readpages(osdc, ceph_vino(inode), &ci->i_layout,
-				  page->index << PAGE_CACHE_SHIFT, &len,
+				  (u64) page->index << PAGE_CACHE_SHIFT, &len,
 				  ci->i_truncate_seq, ci->i_truncate_size,
 				  &page, 1, 0);
 	if (err == -ENOENT)
@@ -286,7 +286,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	int nr_pages = 0;
 	int ret;

-	off = page->index << PAGE_CACHE_SHIFT;
+	off = (u64) page->index << PAGE_CACHE_SHIFT;

 	/* count pages */
 	next_index = page->index;
@@ -426,7 +426,7 @@ static int writepage_nounlock(struct page *page,
struct writeback_control *wbc)
 	struct ceph_inode_info *ci;
 	struct ceph_fs_client *fsc;
 	struct ceph_osd_client *osdc;
-	loff_t page_off = page->index << PAGE_CACHE_SHIFT;
+	loff_t page_off = (loff_t) page->index << PAGE_CACHE_SHIFT;
 	int len = PAGE_CACHE_SIZE;
 	loff_t i_size;
 	int err = 0;
@@ -817,8 +817,7 @@ get_more_pages:
 			/* ok */
 			if (locked_pages == 0) {
 				/* prepare async write request */
-				offset = (unsigned long long)page->index
-					<< PAGE_CACHE_SHIFT;
+				offset = (u64) page->index << PAGE_CACHE_SHIFT;
 				len = wsize;
 				req = ceph_osdc_new_request(&fsc->client->osdc,
 					    &ci->i_layout,
@@ -1180,7 +1179,7 @@ static int ceph_page_mkwrite(struct vm_area_struct
*vma, struct vm_fault *vmf)
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page = vmf->page;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
-	loff_t off = page->index << PAGE_CACHE_SHIFT;
+	loff_t off = (loff_t) page->index << PAGE_CACHE_SHIFT;
 	loff_t size, len;
 	int ret;

-- 
1.7.9.5

