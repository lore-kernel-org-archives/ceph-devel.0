From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] ceph: fix snapshot directory timestamps
Date: Wed, 11 Mar 2020 11:05:38 +0000
Message-ID: <20200311110538.GB58729@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Marc Roos <M.Roos@f1-outsourcing.eu>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The .snap directory timestamps are kept at 0 (1970-01-01 00:00), which
isn't consistent with what the fuse client does.  This patch makes the
behaviour consistent, by setting these timestamps (atime, btime, ctime,
mtime) to those of the parent directory.

Cc: Marc Roos <M.Roos@f1-outsourcing.eu>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d01710a16a4a..968d55ca898d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -82,10 +82,14 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_mode = parent->i_mode;
 	inode->i_uid = parent->i_uid;
 	inode->i_gid = parent->i_gid;
+	inode->i_mtime = parent->i_mtime;
+	inode->i_ctime = parent->i_ctime;
+	inode->i_atime = parent->i_atime;
 	inode->i_op = &ceph_snapdir_iops;
 	inode->i_fop = &ceph_snapdir_fops;
 	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
 	ci->i_rbytes = 0;
+	ci->i_btime = ceph_inode(parent)->i_btime;
 
 	if (inode->i_state & I_NEW)
 		unlock_new_inode(inode);
