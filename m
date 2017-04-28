From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: choose readdir frag based on previous readdir reply
Date: Fri, 28 Apr 2017 16:03:41 +0800
Message-ID: <20170428080341.13742-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932429AbdD1IDu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Apr 2017 04:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECFE0C059727
        for <ceph-devel@vger.kernel.org>; Fri, 28 Apr 2017 08:03:49 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

The dirfragtree is lazily updated, it's not always accurate. Infinite
loops happens in following circumstance.

- client send request to read frag A
- frag A has been fragmented into frag B and C. So mds fills the reply
  with contents of frag B
- client wants to read next frag C. ceph_choose_frag(frag value of C)
  return frag A.

The fix is using previous readdir reply to calculate next readdir frag
when possible.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ae61cdf..e071d23 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -294,7 +294,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i;
 	int err;
-	u32 ftype;
+	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
 
 	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
@@ -341,7 +341,6 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	/* do we have the correct frag content buffered? */
 	if (need_send_readdir(fi, ctx->pos)) {
 		struct ceph_mds_request *req;
-		unsigned frag;
 		int op = ceph_snap(inode) == CEPH_SNAPDIR ?
 			CEPH_MDS_OP_LSSNAP : CEPH_MDS_OP_READDIR;
 
@@ -352,8 +351,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (is_hash_order(ctx->pos)) {
-			frag = ceph_choose_frag(ci, fpos_hash(ctx->pos),
-						NULL, NULL);
+			/* fragtree isn't always accurate. choose frag
+			 * based on previous reply when possible. */
+			if (frag == (unsigned)-1)
+				frag = ceph_choose_frag(ci, fpos_hash(ctx->pos),
+							NULL, NULL);
 		} else {
 			frag = fpos_frag(ctx->pos);
 		}
@@ -480,6 +482,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino vino;
 		ino_t ino;
+		u32 ftype;
 
 		BUG_ON(rde->offset < ctx->pos);
 
@@ -502,15 +505,17 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
+	ceph_mdsc_put_request(fi->last_readdir);
+	fi->last_readdir = NULL;
+
 	if (fi->next_offset > 2) {
-		ceph_mdsc_put_request(fi->last_readdir);
-		fi->last_readdir = NULL;
+		frag = fi->frag;
 		goto more;
 	}
 
 	/* more frags? */
 	if (!ceph_frag_is_rightmost(fi->frag)) {
-		unsigned frag = ceph_frag_next(fi->frag);
+		frag = ceph_frag_next(fi->frag);
 		if (is_hash_order(ctx->pos)) {
 			loff_t new_pos = ceph_make_fpos(ceph_frag_value(frag),
 							fi->next_offset, true);
-- 
2.9.3

