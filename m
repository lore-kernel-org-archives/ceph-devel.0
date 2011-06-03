From: Sage Weil <sage@newdream.net>
Subject: O_DIRECT change
Date: Fri, 3 Jun 2011 09:48:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106030939020.27322@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52546 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab1FCQqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2011 12:46:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: henry.cy.chang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Henry,

I made a small change to the O_DIRECT path to zero holes properly in 
commit 85defe7 (below).  Do you mind reviewing the change, and/or testing, 
since you are the main O_DIRECT user?  The test case that was failing is 
here:

	http://tracker.newdream.net/issues/1096#note-19

The problem was that the read coming down from the VFS isn't trimmed to 
i_size, so the old zero tail check wasn't true, and we would set 
*checkeof.  Then ceph_aio_read would getattr and loop, since we 
didn't actually read eof (due to a hole).

Actually, I suspect the *checkeof part is still incorrect... does the 
zeroing part at least look right to you?

Thanks!
sage


From 85defe76f7e2a0b3d285a3be72fcffce96629b5c Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Wed, 1 Jun 2011 16:08:44 -0700
Subject: [PATCH] ceph: fix short sync reads from the OSD

If we get a short read from the OSD because the object is small, we need to
zero the remainder of the buffer.  For O_DIRECT reads, the attempted range
is not trimmed to i_size by the VFS, so we were actually looping
indefinitely.

Fix by trimming by i_size, and the unconditionally zeroing the trailing
range.

Reported-by: Jeff Wu <cpwu@tnsoft.com.cn>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/file.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8c5ac4e..b654f40 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -283,7 +283,7 @@ int ceph_release(struct inode *inode, struct file *file)
 static int striped_read(struct inode *inode,
 			u64 off, u64 len,
 			struct page **pages, int num_pages,
-			int *checkeof, bool align_to_pages,
+			int *checkeof, bool o_direct,
 			unsigned long buf_align)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -308,7 +308,7 @@ static int striped_read(struct inode *inode,
 	io_align = off & ~PAGE_MASK;
 
 more:
-	if (align_to_pages)
+	if (o_direct)
 		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
 	else
 		page_align = pos & ~PAGE_MASK;
@@ -346,20 +346,22 @@ more:
 	}
 
 	if (was_short) {
-		/* was original extent fully inside i_size? */
-		if (pos + left <= inode->i_size) {
-			dout("zero tail\n");
-			ceph_zero_page_vector_range(page_off + read, len - read,
+		/* did we bounce off eof? */
+		if (pos + left > inode->i_size)
+			*checkeof = 1;
+
+		/* zero trailing bytes (inside i_size) */
+		if (left > 0 && pos < inode->i_size) {
+			if (pos + left > inode->i_size)
+				left = inode->i_size - pos;
+
+			dout("zero tail %d\n", left);
+			ceph_zero_page_vector_range(page_off + read, left,
 						    pages);
-			read = len;
-			goto out;
+			read += left;
 		}
-
-		/* check i_size */
-		*checkeof = 1;
 	}
 
-out:
 	if (ret >= 0)
 		ret = read;
 	dout("striped_read returns %d\n", ret);
@@ -659,7 +661,7 @@ out:
 
 		/* hit EOF or hole? */
 		if (statret == 0 && *ppos < inode->i_size) {
-			dout("aio_read sync_read hit hole, reading more\n");
+			dout("aio_read sync_read hit hole, ppos %lld < size %lld, reading more\n", *ppos, inode->i_size);
 			read += ret;
 			base += ret;
 			len -= ret;
-- 
1.7.0

