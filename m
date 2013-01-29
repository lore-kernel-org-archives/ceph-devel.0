From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph] locking fun with d_materialise_unique()
Date: Tue, 29 Jan 2013 13:03:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301291301260.6657@cobra.newdream.net>
References: <20130129045213.GH4503@ZenIV.linux.org.uk> <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net> <20130129080036.GI4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20130129080036.GI4503@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Al,

On Tue, 29 Jan 2013, Al Viro wrote:

> On Mon, Jan 28, 2013 at 09:20:34PM -0800, Sage Weil wrote:
> 
> > Yep, that is indeed a problem.  I think we just need to do the r_aborted 
> > and/or r_locked_dir check in the else if condition...
> > 
> > > I'm not sure if we are guaranteed that ceph_readdir_prepopulate() won't
> > > get to its splice_dentry() and d_delete() calls in similar situations -
> > > I hadn't checked that one yet.  If it isn't guaranteed, we have a problem
> > > there as well.
> > 
> > ...and the condition guarding readdir_prepopulate().  :)
> 
> > I think you're reading it correctly.  The main thing to keep in mind here 
> > is that we *do* need to call fill_inode() for the inode metadata on these 
> > requests to keep the mds and client state in sync.  The dentry state is 
> > safe to ignore.
> 
> You mean the parts under
>         if (rinfo->head->is_dentry) {
> and
>         if (rinfo->head->is_target) {
> in there?  Because there's fill_inode() called from readdir_prepopulate()
> and it's a lot more problematic than those two...

Yep, patch below.
 
> > It would be great to have the dir i_mutex rules summarized somewhere, even 
> > if it is just a copy of the below.  It took a fair bit of trial and error 
> > to infer what was going on when writing this code.  :)
> 
> Directory ->i_mutex rules are in part documented - "what VFS guarantees
> to hold" side is in Documentation/filesystems/directory-locking.  It's
> the other side ("what locks are expected to be held by callers of dcache.c
> functions") that is badly missing...
> 
> > Ping me when you've pushed that branch and I'll take a look...
> 
> To gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git
>    01a88fa..4056362  master -> master
> 
> with tentative ceph patch in the very end.  Should be on git.kernel.org
> shortly...

We should drop teh mds_client.c hunk from your patch, and then do 
something like the below.  I'll put it in the ceph tree so we can do some 
basic testing.  Unfortunately, the abort case is a bit annoying to 
trigger.. we'll need to write a new test for it.

Thanks-
sage



From 80d70ef02d5277af8e1355db74fffe71f7217e76 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@inktank.com>
Date: Tue, 29 Jan 2013 13:01:15 -0800
Subject: [PATCH] ceph: prepopulate inodes only when request is aborted

If r_aborted is true, we do not hold the dir i_mutex, and cannot touch
the dcache.  However, we still need to update the inodes with the state
returned by the MDS.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/inode.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 77b1b18..b51653e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1195,6 +1195,39 @@ done:
 /*
  * Prepopulate our cache with readdir results, leases, etc.
  */
+static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
+					   struct ceph_mds_session *session)
+{
+	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	int i, err = 0;
+
+	for (i = 0; i < rinfo->dir_nr; i++) {
+		struct ceph_vino vino;
+		struct inode *in;
+		int rc;
+
+		vino.ino = le64_to_cpu(rinfo->dir_in[i].in->ino);
+		vino.snap = le64_to_cpu(rinfo->dir_in[i].in->snapid);
+
+		in = ceph_get_inode(req->r_dentry->d_sb, vino);
+		if (IS_ERR(in)) {
+			err = PTR_ERR(in);
+			dout("new_inode badness got %d\n", err);
+			continue;
+		}
+		rc = fill_inode(in, &rinfo->dir_in[i], NULL, session,
+				req->r_request_started, -1,
+				&req->r_caps_reservation);
+		if (rc < 0) {
+			pr_err("fill_inode badness on %p got %d\n", in, rc);
+			err = rc;
+			continue;
+		}
+	}
+
+	return err;
+}
+
 int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			     struct ceph_mds_session *session)
 {
@@ -1209,6 +1242,9 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u64 frag = le32_to_cpu(rhead->args.readdir.frag);
 	struct ceph_dentry_info *di;
 
+	if (req->r_aborted)
+		return readdir_prepopulate_inodes_only(req, session);
+
 	if (le32_to_cpu(rinfo->head->op) == CEPH_MDS_OP_LSSNAP) {
 		snapdir = ceph_get_snapdir(parent->d_inode);
 		parent = d_find_alias(snapdir);
-- 
1.7.9.5

