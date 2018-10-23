From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: add destination file data sync before doing any remote copy
Date: Tue, 23 Oct 2018 09:53:14 +0100
Message-ID: <20181023085314.3561-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

If we try to copy into a file that was just written, any data that is remote
copied will be overwritten by our buffered writes once they are flushed.  When
this happens, the call to invalidate_inode_pages2_range will also return a
-EBUSY error.

This patch fixes this by also sync'ing the destination file before starting any
copy.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f788496fafcc..b4607baa8969 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1932,10 +1932,17 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	if (!prealloc_cf)
 		return -ENOMEM;
 
-	/* Start by sync'ing the source file */
+	/* Start by sync'ing the source and destination files */
 	ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
-	if (ret < 0)
+	if (ret < 0) {
+		dout("failed to write src file (%zd)\n", ret);
+		goto out;
+	}
+	ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
+	if (ret < 0) {
+		dout("failed to write dst file (%zd)\n", ret);
 		goto out;
+	}
 
 	/*
 	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
