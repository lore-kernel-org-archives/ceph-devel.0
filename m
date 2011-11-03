From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] FileJournal: stop using sync_file_range
Date: Thu, 3 Nov 2011 17:45:08 -0400
Message-ID: <20111103214508.GA19234@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:59362
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439Ab1KCVpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 17:45:09 -0400
Received: from hch by bombadil.infradead.org with local (Exim 4.76 #1 (Red Hat Linux))
	id 1RM55x-0005ry-0F
	for ceph-devel@vger.kernel.org; Thu, 03 Nov 2011 21:45:09 +0000
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Using sync_file_range means that neither any required metadata gets commited,
nor the disk cache gets flushed.  Stop using it for the journal, and add
a comment on why a fsync_range system call would be helpful here.

Btw, why does the code use O_SYNC (and not even O_DSYNC!) if using direct
I/O, but fdatasync/fsync for buffered I/O?  Avoiding cache flushes and
metadata updates for every writes is just as important for direct I/O
as it is for buffered I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: ceph/src/os/FileJournal.cc
===================================================================
--- ceph.orig/src/os/FileJournal.cc	2011-11-03 22:27:35.304690331 +0100
+++ ceph/src/os/FileJournal.cc	2011-11-03 22:40:02.244191569 +0100
@@ -842,23 +842,26 @@ void FileJournal::do_write(bufferlist& b
 
   if (!directio) {
     dout(20) << "do_write fsync" << dendl;
+
+    /*
+     * We'd really love to have a fsync_range or fdatasync_range and do a:
+     *
+     *  if (split) {
+     *    ::fsync_range(fd, header.max_size - split, split)l
+     *    ::fsync_range(fd, get_top(), bl.length() - split);
+     *  else
+     *    ::fsync_range(fd, write_pos, bl.length())
+     *
+     * NetBSD and AIX apparently have it, and adding it to Linux wouldn't be
+     * too hard given all the underlying infrastructure already exist.
+     *
+     * NOTE: using sync_file_range here would not be safe as it does not
+     * flush disk caches or commits any sort of metadata.
+     */
 #if defined(DARWIN) || defined(__FreeBSD__)
     ::fsync(fd);
 #else
-# ifdef HAVE_SYNC_FILE_RANGE
-    if (is_bdev) {
-      if (split) {
-	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
-	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
-	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_AFTER);
-	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_AFTER);
-      } else {
-	::sync_file_range(fd, write_pos, bl.length(),
-			  SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER);
-      }
-    } else
-# endif
-      ::fdatasync(fd);
+    ::fdatasync(fd);
 #endif
   }
 
