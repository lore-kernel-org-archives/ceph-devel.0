From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/9] ceph: define ceph_writepages_osd_request()
Date: Thu, 04 Apr 2013 11:19:37 -0500
Message-ID: <515DA819.4080204@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45863 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762972Ab3DDQTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:19:39 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so3235192ieb.14
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:19:38 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mostly for readability, define ceph_writepages_osd_request() and
use it to allocate the osd request for ceph_writepages_start().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index de7aac0..5b4ac17 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -654,6 +654,26 @@ static void alloc_page_vec(struct ceph_fs_client *fsc,
 	}
 }

+static struct ceph_osd_request *
+ceph_writepages_osd_request(struct inode *inode, u64 offset, u64 *len,
+				struct ceph_snap_context *snapc,
+				int num_ops, struct ceph_osd_req_op *ops)
+{
+	struct ceph_fs_client *fsc;
+	struct ceph_inode_info *ci;
+	struct ceph_vino vino;
+
+	fsc = ceph_inode_to_client(inode);
+	ci = ceph_inode(inode);
+	vino = ceph_vino(inode);
+	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
+
+	return ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
+			vino, offset, len, num_ops, ops, CEPH_OSD_OP_WRITE,
+			CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK,
+			snapc, ci->i_truncate_seq, ci->i_truncate_size, true);
+}
+
 /*
  * initiate async writeback
  */
@@ -835,16 +855,9 @@ get_more_pages:
 				/* prepare async write request */
 				offset = (u64) page_offset(page);
 				len = wsize;
-				vino = ceph_vino(inode);
-				/* BUG_ON(vino.snap != CEPH_NOSNAP); */
-				req = ceph_osdc_new_request(&fsc->client->osdc,
-					    &ci->i_layout, vino, offset, &len,
-					    num_ops, ops,
-					    CEPH_OSD_OP_WRITE,
-					    CEPH_OSD_FLAG_WRITE |
-						    CEPH_OSD_FLAG_ONDISK,
-					    snapc, ci->i_truncate_seq,
-					    ci->i_truncate_size, true);
+				req = ceph_writepages_osd_request(inode,
+							offset, &len, snapc,
+							num_ops, ops);

 				if (IS_ERR(req)) {
 					rc = PTR_ERR(req);
@@ -852,6 +865,7 @@ get_more_pages:
 					break;
 				}

+				vino = ceph_vino(inode);
 				ceph_osdc_build_request(req, offset,
 					num_ops, ops, snapc, vino.snap,
 					&inode->i_mtime);
-- 
1.7.9.5

