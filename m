Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E331CC433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 28 Feb 2022 04:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiB1EVZ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 27 Feb 2022 23:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiB1EVW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Feb 2022 23:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92360403E9
        for <ceph-devel@vger.kernel.org>; Sun, 27 Feb 2022 20:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646022041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3ovuKlb1HgNYVZuCQNbpXFO5BTfiBIMvmxPeMqH2jQ=;
        b=VfyUUr3RxwqGR01Zz2PO/wYxnQOPxHTvUxXqV10Imv3uTCkgLVKODe/PA1fqPT26b5fLcZ
        JhRNNw6fP1Gx+Zjt6+KRI1DDcEiBbvbzB/o3uIAmPGxgqd7wU2pFbcQC3AdoRUH+Mk4X31
        R0ANK32mbtqk4kg2dffRw85NMwqYzbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-jbqQlX3ZMfahAbJ3Dw98VA-1; Sun, 27 Feb 2022 23:20:40 -0500
X-MC-Unique: jbqQlX3ZMfahAbJ3Dw98VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9BA08145F7;
        Mon, 28 Feb 2022 04:20:39 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A87735E26D;
        Mon, 28 Feb 2022 04:20:37 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com, lhenriques@suse.de,
        ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 2/3] ceph: use the parent inode of '.snap' to dencrypt the names for readdir
Date:   Mon, 28 Feb 2022 12:20:24 +0800
Message-Id: <20220228042025.30806-3-xiubli@redhat.com>
In-Reply-To: <20220228042025.30806-1-xiubli@redhat.com>
References: <20220228042025.30806-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The inode for '.snap' directory will always with no key setup, so
we can use the parent inode to do this.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/dir.c   | 17 ++++++++++-------
 fs/ceph/inode.c | 15 +++++++++------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a449f4a07c07..f0b28f210636 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -308,7 +308,7 @@ static bool need_send_readdir(struct ceph_dir_file_info *dfi, loff_t pos)
 static int ceph_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ceph_dir_file_info *dfi = file->private_data;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(file), *pinode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -347,7 +347,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 	err = fscrypt_prepare_readdir(inode);
 	if (err)
-		goto out;
+		return err;
 
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
@@ -369,11 +369,13 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_unlock(&ci->i_ceph_lock);
 	}
 
-	err = ceph_fname_alloc_buffer(inode, &tname);
+	pinode = ceph_get_snap_parent_inode(inode);
+
+	err = ceph_fname_alloc_buffer(pinode, &tname);
 	if (err < 0)
 		goto out;
 
-	err = ceph_fname_alloc_buffer(inode, &oname);
+	err = ceph_fname_alloc_buffer(pinode, &oname);
 	if (err < 0)
 		goto out;
 
@@ -527,7 +529,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 	for (; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
-		struct ceph_fname fname = { .dir	= inode,
+		struct ceph_fname fname = { .dir	= pinode,
 					    .name	= rde->name,
 					    .name_len	= rde->name_len,
 					    .ctext	= rde->altname,
@@ -615,8 +617,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	err = 0;
 	dout("readdir %p file %p done.\n", inode, file);
 out:
-	ceph_fname_free_buffer(inode, &tname);
-	ceph_fname_free_buffer(inode, &oname);
+	ceph_fname_free_buffer(pinode, &tname);
+	ceph_fname_free_buffer(pinode, &oname);
+	iput(pinode);
 	return err;
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8b0832271fdf..9cef99f78958 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1817,7 +1817,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct qstr dname;
 	struct dentry *dn;
-	struct inode *in;
+	struct inode *in, *pinode;
 	int err = 0, skipped = 0, ret, i;
 	u32 frag = le32_to_cpu(req->r_args.readdir.frag);
 	u32 last_hash = 0;
@@ -1876,11 +1876,13 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	cache_ctl.index = req->r_readdir_cache_idx;
 	fpos_offset = req->r_readdir_offset;
 
-	err = ceph_fname_alloc_buffer(inode, &tname);
+	pinode = ceph_get_snap_parent_inode(inode);
+
+	err = ceph_fname_alloc_buffer(pinode, &tname);
 	if (err < 0)
 		goto out;
 
-	err = ceph_fname_alloc_buffer(inode, &oname);
+	err = ceph_fname_alloc_buffer(pinode, &oname);
 	if (err < 0)
 		goto out;
 
@@ -1890,7 +1892,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
 		u32 olen = oname.len;
-		struct ceph_fname fname = { .dir	= inode,
+		struct ceph_fname fname = { .dir	= pinode,
 					    .name	= rde->name,
 					    .name_len	= rde->name_len,
 					    .ctext	= rde->altname,
@@ -2029,8 +2031,9 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
-	ceph_fname_free_buffer(inode, &tname);
-	ceph_fname_free_buffer(inode, &oname);
+	ceph_fname_free_buffer(pinode, &tname);
+	ceph_fname_free_buffer(pinode, &oname);
+	iput(pinode);
 	dout("readdir_prepopulate done\n");
 	return err;
 }
-- 
2.27.0

