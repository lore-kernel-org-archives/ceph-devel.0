From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 58/61] fscache: Rewrite the main document
Date: Mon, 04 May 2020 18:16:22 +0100
Message-ID: <158861258200.340223.6420616682330887473.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Rewrite the main document to reflect the new API.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/fscache.txt |   51 ++++++++-----------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/Documentation/filesystems/caching/fscache.txt b/Documentation/filesystems/caching/fscache.txt
index 50f0a5757f48..dbfa0ece0ce8 100644
--- a/Documentation/filesystems/caching/fscache.txt
+++ b/Documentation/filesystems/caching/fscache.txt
@@ -83,9 +83,6 @@ then serving the pages out of that cache rather than the netfs inode because:
      one-off access of a small portion of it (such as might be done with the
      "file" program).
 
-It instead serves the cache out in PAGE_SIZE chunks as and when requested by
-the netfs('s) using it.
-
 
 FS-Cache provides the following facilities:
 
@@ -109,22 +106,22 @@ FS-Cache provides the following facilities:
      recursive, stack space is limited, and indices can only be children of
      indices.
 
- (7) Data I/O is done direct to and from the netfs's pages.  The netfs
-     indicates that page A is at index B of the data-file represented by cookie
-     C, and that it should be read or written.  The cache backend may or may
-     not start I/O on that page, but if it does, a netfs callback will be
-     invoked to indicate completion.  The I/O may be either synchronous or
-     asynchronous.
+ (7) The cache provides two basic I/O operations: write to the cache and read
+     from the cache.  These may be done synchronously or asynchronously and may
+     involve direct I/O.  The position and length of the request have to be
+     rounded to the I/O block size of the cache.
+
+ (8) The cache doesn't keep track of any of the netfs state and retains no
+     pointers back into the netfs.  The netfs is entirely responsible for
+     telling the cache what to do.  A number of helpers are provided to manage
+     the interaction.
 
  (8) Cookies can be "retired" upon release.  At this point FS-Cache will mark
      them as obsolete and the index hierarchy rooted at that point will get
      recycled.
 
- (9) The netfs provides a "match" function for index searches.  In addition to
-     saying whether a match was made or not, this can also specify that an
-     entry should be updated or deleted.
-
-(10) As much as possible is done asynchronously.
+ (9) Coherency data and index keys are stored in the cookie.  This is used by
+     the cache to determine whether the stored data is still valid.
 
 
 FS-Cache maintains a virtual indexing tree in which all indices, files, objects
@@ -144,33 +141,19 @@ caches.
      +------------+           +---------------+              +----------+
      |            |           |               |              |          |
    00001        00002       00007           00125        vol00001   vol00002
-     |            |           |               |                         |
- +---+---+     +-----+      +---+      +------+------+            +-----+----+
- |   |   |     |     |      |   |      |      |      |            |     |    |
-PG0 PG1 PG2   PG0  XATTR   PG0 PG1   DIRENT DIRENT DIRENT        R/W   R/O  Bak
-                     |                                            |
-                    PG0                                       +-------+
-                                                              |       |
-                                                            00001   00003
-                                                              |
-                                                          +---+---+
-                                                          |   |   |
-                                                         PG0 PG1 PG2
+                                                             |
+                                                         +-------+
+                                                         |       |
+                                                       00001   00003
 
 In the example above, you can see two netfs's being backed: NFS and AFS.  These
 have different index hierarchies:
 
  (*) The NFS primary index contains per-server indices.  Each server index is
-     indexed by NFS file handles to get data file objects.  Each data file
-     objects can have an array of pages, but may also have further child
-     objects, such as extended attributes and directory entries.  Extended
-     attribute objects themselves have page-array contents.
+     indexed by NFS file handles to get data objects.
 
  (*) The AFS primary index contains per-cell indices.  Each cell index contains
-     per-logical-volume indices.  Each of volume index contains up to three
-     indices for the read-write, read-only and backup mirrors of those volumes.
-     Each of these contains vnode data file objects, each of which contains an
-     array of pages.
+     logical volume indices and each of those contains vnode data file objects.
 
 The very top index is the FS-Cache master index in which individual netfs's
 have entries.
