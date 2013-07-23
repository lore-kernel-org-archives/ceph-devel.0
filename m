From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [parch] ceph: cleanup types in striped_read()
Date: Tue, 23 Jul 2013 16:48:01 +0300
Message-ID: <20130723134801.GA15116@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

We pass in a u64 value for "len" and then immediately truncate away the
upper 32 bits.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2ddf061..93e53c8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -313,9 +313,9 @@ static int striped_read(struct inode *inode,
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	u64 pos, this_len;
+	u64 pos, this_len, left;
 	int io_align, page_align;
-	int left, pages_left;
+	int pages_left;
 	int read;
 	struct page **page_pos;
 	int ret;
@@ -346,7 +346,7 @@ more:
 		ret = 0;
 	hit_stripe = this_len < left;
 	was_short = ret >= 0 && ret < this_len;
-	dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
+	dout("striped_read %llu~%llu (read %u) got %d%s%s\n", pos, left, read,
 	     ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
 
 	if (ret > 0) {
@@ -378,7 +378,7 @@ more:
 			if (pos + left > inode->i_size)
 				left = inode->i_size - pos;
 
-			dout("zero tail %d\n", left);
+			dout("zero tail %llu\n", left);
 			ceph_zero_page_vector_range(page_align + read, left,
 						    pages);
 			read += left;
