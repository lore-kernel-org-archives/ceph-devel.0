From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] ceph: allow object copies across different filesystems in the same cluster
Date: Mon,  9 Sep 2019 11:28:34 +0100
Message-ID: <20190909102834.16246-1-lhenriques@suse.com>
References: <87k1ahojri.fsf@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1ahojri.fsf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

OSDs are able to perform object copies across different pools.  Thus,
there's no need to prevent copy_file_range from doing remote copies if the
source and destination superblocks are different.  Only return -EXDEV if
they have different fsid (the cluster ID).

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Hi,

Here's the patch changelog since initial submittion:

- Dropped have_fsid checks on client structs
- Use %pU to print the fsid instead of raw hex strings (%*ph)
- Fixed 'To:' field in email so that this time the patch hits vger

Cheers,
--
Luis

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 685a03cc4b77..4a624a1dd0bb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
+	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
 	struct ceph_object_locator src_oloc, dst_oloc;
 	struct ceph_object_id src_oid, dst_oid;
 	loff_t endoff = 0, size;
@@ -1915,8 +1916,17 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 	if (src_inode == dst_inode)
 		return -EINVAL;
-	if (src_inode->i_sb != dst_inode->i_sb)
-		return -EXDEV;
+	if (src_inode->i_sb != dst_inode->i_sb) {
+		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
+
+		if (ceph_fsid_compare(&src_fsc->client->fsid,
+				      &dst_fsc->client->fsid)) {
+			dout("Copying object across different clusters:");
+			dout("  src fsid: %pU dst fsid: %pU\n",
+			     &src_fsc->client->fsid, &dst_fsc->client->fsid);
+			return -EXDEV;
+		}
+	}
 	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -1928,7 +1938,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * efficient).
 	 */
 
-	if (ceph_test_mount_opt(ceph_inode_to_client(src_inode), NOCOPYFROM))
+	if (ceph_test_mount_opt(src_fsc, NOCOPYFROM))
 		return -EOPNOTSUPP;
 
 	if ((src_ci->i_layout.stripe_unit != dst_ci->i_layout.stripe_unit) ||
@@ -2044,7 +2054,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				dst_ci->i_vino.ino, dst_objnum);
 		/* Do an object remote copy */
 		err = ceph_osdc_copy_from(
-			&ceph_inode_to_client(src_inode)->client->osdc,
+			&src_fsc->client->osdc,
 			src_ci->i_vino.snap, 0,
 			&src_oid, &src_oloc,
 			CEPH_OSD_OP_FLAG_FADVISE_SEQUENTIAL |
