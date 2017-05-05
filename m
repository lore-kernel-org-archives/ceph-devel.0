From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: Check that the new inode size is within limits in ceph_fallocate()
Date: Fri,  5 May 2017 18:28:44 +0100
Message-ID: <20170505172844.18374-1-lhenriques@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Currently the ceph client doesn't respect the rlimit in fallocate.  This
means that a user can allocate a file with size > RLIMIT_FSIZE.  This
patch adds the call to inode_newsize_ok() to verify filesystem limits and
ulimits.  This should make ceph successfully run xfstest generic/228.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 26cc95421cca..bc5809d4d2d4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1636,8 +1636,12 @@ static long ceph_fallocate(struct file *file, int mode,
 	}
 
 	size = i_size_read(inode);
-	if (!(mode & FALLOC_FL_KEEP_SIZE))
+	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
 		endoff = offset + length;
+		ret = inode_newsize_ok(inode, endoff);
+		if (ret)
+			goto unlock;
+	}
 
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
