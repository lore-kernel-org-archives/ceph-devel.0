From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: fix copy_file_range error path in short copies
Date: Wed,  5 Feb 2020 10:28:52 +0000
Message-ID: <20200205102852.12236-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

When there's an error in the copying loop but some bytes have already been
copied into the destination file, it is necessary to dirty the caps and
eventually update the MDS with the file metadata (timestamps, size).  This
patch fixes this error path.

Cc: stable@vger.kernel.org
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 11929d2bb594..7be47d24edb1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2104,9 +2104,16 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			CEPH_OSD_OP_FLAG_FADVISE_DONTNEED, 0);
 		if (err) {
 			dout("ceph_osdc_copy_from returned %d\n", err);
-			if (!ret)
+			/*
+			 * If we haven't done any copy yet, just exit with the
+			 * error code; otherwise, return the number of bytes
+			 * already copied, update metadata and dirty caps.
+			 */
+			if (!ret) {
 				ret = err;
-			goto out_caps;
+				goto out_caps;
+			}
+			goto out_early;
 		}
 		len -= object_size;
 		src_off += object_size;
@@ -2118,6 +2125,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		/* We still need one final local copy */
 		do_final_copy = true;
 
+out_early:
 	file_update_time(dst_file);
 	inode_inc_iversion_raw(dst_inode);
 
