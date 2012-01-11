From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] ceph: enable/disable dentry complete flags via mount
 option
Date: Wed, 11 Jan 2012 12:44:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201111244040.13761@cobra.newdream.net>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
 <1326307602-16284-3-git-send-email-sage@newdream.net> <20120111190001.GB29582@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50137 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2AKUov (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 15:44:51 -0500
In-Reply-To: <20120111190001.GB29582@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 11 Jan 2012, Christoph Hellwig wrote:
> > +  dcache
> > +        Use the dcache contents to perform negative lookups and
> > +        readdir when the client has the entire directory contents in
> > +        its cache.  (This does not change correctness; the client uses
> > +        cached metadata only when a lease or capability ensures it is
> > +        valid.)
> > +
> > +  nodcache
> > +        Do not use the dcache as above.
> >  
> > +  noasyncreaddir
> > +	Do not use the dcache as above for readdir.
> 
> None of thie explains why you'd ever want to turn the flag off.

See below:

From 755052c0867755c0acb12de4878e29da9301e4f3 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Tue, 10 Jan 2012 09:12:55 -0800
Subject: [PATCH 2/2] ceph: enable/disable dentry complete flags via mount option

Enable/disable use of the dentry dir 'complete' flag via a mount option.
This lets the admin control whether ceph uses the dcache to satisfy
negative lookups or readdir when it has the entire directory contents in
its cache.

This is purely a performance optimization; correctness is guaranteed
whether it is enabled or not.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 Documentation/filesystems/ceph.txt |   18 +++++++++++++-----
 fs/ceph/dir.c                      |   25 ++++++++++++++++++++++---
 fs/ceph/super.c                    |   14 ++++++++++++++
 fs/ceph/super.h                    |    1 +
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
index 763d8eb..d6030aa 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -119,12 +119,20 @@ Mount Options
 	must rely on TCP's error correction to detect data corruption
 	in the data payload.
 
-  noasyncreaddir
-	Disable client's use its local cache to satisfy	readdir
-	requests.  (This does not change correctness; the client uses
-	cached metadata only when a lease or capability ensures it is
-	valid.)
+  dcache
+        Use the dcache contents to perform negative lookups and
+        readdir when the client has the entire directory contents in
+        its cache.  (This does not change correctness; the client uses
+        cached metadata only when a lease or capability ensures it is
+        valid.)
+
+  nodcache
+        Do not use the dcache as above.  This avoids a significant amount of
+        complex code, sacrificing performance without affecting correctness,
+        and is useful for tracking down bugs.
 
+  noasyncreaddir
+	Do not use the dcache as above for readdir.
 
 More Information
 ================
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b230b8f..ab2b035 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1104,17 +1104,36 @@ static int ceph_snapdir_d_revalidate(struct dentry *dentry,
  */
 void ceph_dir_set_complete(struct inode *inode)
 {
-	/* not yet implemented */
+	struct dentry *dentry = d_find_any_alias(inode);
+	
+	if (dentry && ceph_dentry(dentry) &&
+	    ceph_test_mount_opt(ceph_sb_to_client(dentry->d_sb), DCACHE)) {
+		dout(" marking %p (%p) complete\n", inode, dentry);
+		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	}
+	dput(dentry);
 }
 
 void ceph_dir_clear_complete(struct inode *inode)
 {
-	/* not yet implemented */
+	struct dentry *dentry = d_find_any_alias(inode);
+
+	if (dentry && ceph_dentry(dentry)) {
+		dout(" marking %p (%p) complete\n", inode, dentry);
+		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	}
+	dput(dentry);
 }
 
 bool ceph_dir_test_complete(struct inode *inode)
 {
-	/* not yet implemented */
+	struct dentry *dentry = d_find_any_alias(inode);
+
+	if (dentry && ceph_dentry(dentry)) {
+		dout(" marking %p (%p) NOT complete\n", inode, dentry);
+		clear_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	}
+	dput(dentry);
 	return false;
 }
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index ec74313..9c62fe0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -131,6 +131,8 @@ enum {
 	Opt_rbytes,
 	Opt_norbytes,
 	Opt_noasyncreaddir,
+	Opt_dcache,
+	Opt_nodcache,
 	Opt_ino32,
 };
 
@@ -152,6 +154,8 @@ static match_table_t fsopt_tokens = {
 	{Opt_rbytes, "rbytes"},
 	{Opt_norbytes, "norbytes"},
 	{Opt_noasyncreaddir, "noasyncreaddir"},
+	{Opt_dcache, "dcache"},
+	{Opt_nodcache, "nodcache"},
 	{Opt_ino32, "ino32"},
 	{-1, NULL}
 };
@@ -231,6 +235,12 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_noasyncreaddir:
 		fsopt->flags |= CEPH_MOUNT_OPT_NOASYNCREADDIR;
 		break;
+	case Opt_dcache:
+		fsopt->flags |= CEPH_MOUNT_OPT_DCACHE;
+		break;
+	case Opt_nodcache:
+		fsopt->flags &= ~CEPH_MOUNT_OPT_DCACHE;
+		break;
 	case Opt_ino32:
 		fsopt->flags |= CEPH_MOUNT_OPT_INO32;
 		break;
@@ -377,6 +387,10 @@ static int ceph_show_options(struct seq_file *m, struct vfsmount *mnt)
 		seq_puts(m, ",norbytes");
 	if (fsopt->flags & CEPH_MOUNT_OPT_NOASYNCREADDIR)
 		seq_puts(m, ",noasyncreaddir");
+	if (fsopt->flags & CEPH_MOUNT_OPT_DCACHE)
+		seq_puts(m, ",dcache");
+	else
+		seq_puts(m, ",nodcache");
 
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index edcbf37..140f99f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -28,6 +28,7 @@
 #define CEPH_MOUNT_OPT_RBYTES          (1<<5) /* dir st_bytes = rbytes */
 #define CEPH_MOUNT_OPT_NOASYNCREADDIR  (1<<7) /* no dcache readdir */
 #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
+#define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
 
 #define CEPH_MOUNT_OPT_DEFAULT    (CEPH_MOUNT_OPT_RBYTES)
 
-- 
1.7.0

