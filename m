From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 05/12] ceph-fs: replace direct access of d_count with the d_count() helper
Date: Fri,  5 Jul 2013 10:48:05 -0400
Message-ID: <1373035685-40678-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <andi@firstfloor.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>
List-Id: ceph-devel.vger.kernel.org

Because of the d_count change made in dcache.h, all readonly references
to d_count have to be changed to use the new d_count() helper as they
shouldn't access its value directly.  There is no change in logic
and everything should just work.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 fs/ceph/inode.c      |    4 ++--
 fs/ceph/mds_client.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index be0f7e2..bd2289a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -903,8 +903,8 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in,
 	} else if (realdn) {
 		dout("dn %p (%d) spliced with %p (%d) "
 		     "inode %p ino %llx.%llx\n",
-		     dn, dn->d_count,
-		     realdn, realdn->d_count,
+		     dn, d_count(dn),
+		     realdn, d_count(realdn),
 		     realdn->d_inode, ceph_vinop(realdn->d_inode));
 		dput(dn);
 		dn = realdn;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4d29203..8fd678f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1553,7 +1553,7 @@ retry:
 	*base = ceph_ino(temp->d_inode);
 	*plen = len;
 	dout("build_path on %p %d built %llx '%.*s'\n",
-	     dentry, dentry->d_count, *base, len, path);
+	     dentry, d_count(dentry), *base, len, path);
 	return path;
 }
 
-- 
1.7.1
