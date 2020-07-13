From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/32] vfs: Export rw_verify_area() for use by cachefiles
Date: Mon, 13 Jul 2020 17:31:12 +0100
Message-ID: <159465787270.1376674.9709773455326854521.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27010 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730256AbgGMQbX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:31:23 -0400
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Export rw_verify_area() for so that cachefiles can use it before issuing
call_read_iter() and call_write_iter() to effect async DIO operations
against the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/internal.h      |    5 -----
 fs/read_write.c    |    1 +
 include/linux/fs.h |    1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd708..8213a29a972f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -156,11 +156,6 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 
-/*
- * read_write.c
- */
-extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
-
 /*
  * pipe.c
  */
diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15e..eb18270a1e14 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -400,6 +400,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..aa3e3af92220 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2905,6 +2905,7 @@ extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
 extern int __check_sticky(struct inode *dir, struct inode *inode);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 
 static inline bool execute_ok(struct inode *inode)
 {
