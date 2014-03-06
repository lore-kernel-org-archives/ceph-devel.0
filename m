From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the materialised dentry name correctly
Date: Thu,  6 Mar 2014 22:16:16 +0800
Message-ID: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: linux-nfs@vger.kernel.org, trond.myklebust@primarydata.com, ceph-devel@vger.kernel.org, sage@inktank.com
List-Id: ceph-devel.vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make __d_materialise_dentry() set the materialised dentry name correctly by
flipping the arguments to switch_names().

switch_names() is lazy: if both names are internal to their dentries, it'll
overwrite that of the first dentry with that of the second, and won't update
that of the second.

In the case of __d_materialise_dentry(), the second is an already extant
anonymous dentry that we want to insert into the tree in place of the dentry we
just looked up[*].  However, the dentry we just looked up carries the name we
actually want to use.

[*] This is used by NFS to join a mount of a subtree into a mount of a tree
nearer the root when the two meet, where both mounts share a superblock and
thus a set of dentries.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 265e0ce..ff779d4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct dentry *dentry, struct dentry *anon)
 
 	dparent = dentry->d_parent;
 
-	switch_names(dentry, anon);
+	switch_names(anon, dentry);
 	swap(dentry->d_name.hash, anon->d_name.hash);
 
 	dentry->d_parent = dentry;
-- 
1.8.5.3

