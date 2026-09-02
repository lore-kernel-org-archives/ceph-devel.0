Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D84AA006
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365075; cv=none; b=JQqbsyYXhyFlE5HprcfMJWhgvyicOyCF+Aany+i83a5oysatTb6qkcWIx94zjt9LP/UXz8wZwnTp2j+lj3ynuzfuHuf/VLWqGTgKH0oxiNjr2lZHrQKak8TYMY0cfaFx1HM8GW6ShznGITm5E1GK3ATKeTR6P6Ob99yMuExyKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365075; c=relaxed/simple;
	bh=xvR5Sz3vHcCqlDibrLqzLZyn/zffAyFWTLvKm3kKj7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iySuUU4aluc5jga4ZPvP82AJs+8SnBu3oTpOjxNIpqttYtS3tYe7YoidlmF8SHZwKAM9x3bMiAOGY6eOVcDMr01jXRHwhRHbG2CPRbgc7unw1v2GB15CmCZyprNmqSKCbFlZbpyYxnxY/hzmP6LohejaXMfNzdDLF2TCpjN5ZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pt1di6KX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qBIl1HXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt1di6KX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qBIl1HXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PSHJgWo1pQlfxwBYrRw0hgK/Ix6X63XTJSt1wplqmo=;
	b=Pt1di6KX3GR/lBqGwbvFDzq3S78+p8/IIMwLk2/Lq3a/SSq0/bvTmazpv7PTMTox7NSwJE
	05ZqHWjUqyYCkiRl2adO1HQFt6eQUgCstmW3D1iQhxBq15N2m4E2CQVKm7Wn+kZZ9gS38E
	tEg++9DUJcCj0c9Lku8lqiNGCfeo9KM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-0bPpuQ4PPDuC3A3XFb-k2w-1; Wed, 02 Sep 2026 12:04:25 -0400
X-MC-Unique: 0bPpuQ4PPDuC3A3XFb-k2w-1
X-Mimecast-MFC-AGG-ID: 0bPpuQ4PPDuC3A3XFb-k2w_1788365065
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25501f4aa2so2840966b.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365064; x=1788969864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PSHJgWo1pQlfxwBYrRw0hgK/Ix6X63XTJSt1wplqmo=;
        b=qBIl1HXiIYju68zfF5iLpfS96kq1hBLryJyZicQVHQLcq8Dlgd6yRFhsZAzcXiqTP7
         mAONTYtcGm4/NgNxeG1tsPec0C9NgSs74NZ1sGdlX+epaeKYQ+l/reyp/l5FKX3Wf690
         xr0FdGmFouESTotSq0aWZkXeDVLztkeQTa07Hv6eFMY4lCm5OoSW17KdyT5Ma+KNvAeT
         mH7Pr71B5ZUwJ7U5Wwl8DVS0gweeI9L865CPGwpjqJaDZM6Lf+2INO0l41/XYfBZaVka
         nAGimgVcsuga94z8FbszYID6vwMUIt443rBNZLi3dSJiWjmW+vadln9zm1NF5pPq7igv
         DyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365064; x=1788969864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PSHJgWo1pQlfxwBYrRw0hgK/Ix6X63XTJSt1wplqmo=;
        b=LgOgwpe2k4s2ycrZ6vdVBR/CSPjS1V4nttRHkMY8WIjm9LGemnhF+mLKCWj4m9E17e
         vrARaHM5EPDTQHd72TgkqRdF96Z7BELGZ4RUUd25x38cptielCVMOhuDVDsXx9a2fPHH
         3X0mPZaAbqD4xAzMUkZfvz0aVgaygst8qyVd04AnAiGfw/0370Jq0huHjMnX635mMzAo
         TdKPn0a6G+DrM2YyU9VmlJeOQUFEezHFYYcA7ZyjynEsPPpnF3ol8EI1FOMNKxMqf3qE
         oCPyLTHF5D6WegHxng/vaQvVjxB/X0JptcbfTTYubGMl5nxp3PFfG97e1KU1rivmqMXD
         hwRA==
X-Gm-Message-State: AFuF++nAICQC4xnY+Iy7lipc1EbiQK95NFkx/5p7QWbtgzbJHds3cs1z
	YwH4gOhmqANesUzSkHABiMn5cBeIxN4Ig6PZaIa8ORm1LY4XAnf4l9omS5wXr4nT1E0NZnWlyGu
	qaocEqD4EB9jP7SpiZlE7Ih9FHK6PxXnWJ7uDUdIZpI2a3kcj2rzo+c6dXvy/D1ew8RUXCl98DE
	OS+oraL4ZSWTRzCM8jT5IkeGQ6YTRbW9SEiUp7w//8awYdajM=
X-Gm-Gg: AYBFou2675CV4IQ4gN/o5BKi/BdwVCtH3CREmd0gvG5aczo7dL+Ng1ZN2mFAPU1PmxS
	YfuUvUgXz+AeIZlVhoJw3uPkAXdVllOGBDgiWkB1aNKbAum0JQll/NC5nnmxosSdVyze+wE3sy8
	dlcovUMdbznbA68ZwxsX+L1LUt1+kpuICAr66egVTPzIhU4gpHgPXQbs97IO496rL06tj6uig8z
	6IIHgMNO6JY8eyOIf06C2Mv49Rh/Vtt0wPX5LMQyMMs6YBPBdvsUtPkUveH+pXo8Uu1VvPEP+dF
	L7posvoARwE3Fgo/xI9S2/FFZjA9noLjIf65V3W2PIZRHEuSaFBEwPYFNdIIoKeK+u1+W9ah6yC
	UIBcT+5ftd+eck2tSEWJHbxVBUp7jWME0/1Qmum+R6+AE3UQAPcvcfw8UEfLHSP7LugFhTeBl+M
	kWCHEcYKdh/OUrkg==
X-Received: by 2002:a17:907:94d3:b0:c25:4ba1:594f with SMTP id a640c23a62f3a-c25ef8408a4mr17650866b.0.1788365063744;
        Wed, 02 Sep 2026 09:04:23 -0700 (PDT)
X-Received: by 2002:a17:907:94d3:b0:c25:4ba1:594f with SMTP id a640c23a62f3a-c25ef8408a4mr17639066b.0.1788365062260;
        Wed, 02 Sep 2026 09:04:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 11/14] ceph: convert VFS inode and directory paths to bout
Date: Wed,  2 Sep 2026 16:04:04 +0000
Message-Id: <20260902160407.3196013-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902160407.3196013-1-amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
 <20260902160407.3196013-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dout()/doutc() with bout()/boutc() in dir.c (readdir, lookup,
mkdir, unlink, rename), inode.c (getattr, setattr, fill_inode), and
export.c (NFS export ops).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/dir.c    | 322 +++++++++++++++++++++++++++++++++++------------
 fs/ceph/export.c |  83 +++++++++---
 fs/ceph/inode.c  | 242 +++++++++++++++++++++--------------
 3 files changed, 452 insertions(+), 195 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ac56efa32d41..4ab8685d4235 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -122,7 +122,7 @@ static int note_last_dentry(struct ceph_fs_client *fsc,
 	memcpy(dfi->last_name, name, len);
 	dfi->last_name[len] = 0;
 	dfi->next_offset = next_offset;
-	doutc(fsc->client, "'%s'\n", dfi->last_name);
+	boutc(fsc->client, "'%s'\n", dfi->last_name);
 	return 0;
 }
 
@@ -146,7 +146,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 		cache_ctl->folio = filemap_lock_folio(&dir->i_data, ptr_pgoff);
 		if (IS_ERR(cache_ctl->folio)) {
 			cache_ctl->folio = NULL;
-			doutc(cl, " folio %lu not found\n", ptr_pgoff);
+			boutc(cl, " folio %lu not found\n", ptr_pgoff);
 			return ERR_PTR(-EAGAIN);
 		}
 		/* reading/filling the cache are serialized by
@@ -194,10 +194,12 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 	struct dentry *dentry, *last = NULL;
 	struct ceph_dentry_info *di;
 	struct ceph_readdir_cache_control cache_ctl = {};
+	char dname[NAME_MAX + 1];
+	unsigned int dname_len = 0;
 	u64 idx = 0;
 	int err = 0;
 
-	doutc(cl, "%p %llx.%llx v%u at %llx\n", dir, ceph_vinop(dir),
+	boutc(cl, "%p %llx.%llx v%u at %llx\n", dir, ceph_vinop(dir),
 	      (unsigned)shared_gen, ctx->pos);
 
 	/* search start position */
@@ -228,7 +230,7 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			dput(dentry);
 		}
 
-		doutc(cl, "%p %llx.%llx cache idx %llu\n", dir,
+		boutc(cl, "%p %llx.%llx cache idx %llu\n", dir,
 		      ceph_vinop(dir), idx);
 	}
 
@@ -261,12 +263,22 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		if (fpos_cmp(ctx->pos, di->offset) <= 0) {
 			__ceph_dentry_dir_lease_touch(di);
 			emit_dentry = true;
+			dname_len = dentry->d_name.len;
+			if (dname_len > NAME_MAX)
+				dname_len = NAME_MAX;
+			memcpy(dname, dentry->d_name.name, dname_len);
+			dname[dname_len] = '\0';
 		}
 		spin_unlock(&dentry->d_lock);
 
 		if (emit_dentry) {
-			doutc(cl, " %llx dentry %p %pd %p\n", di->offset,
-			      dentry, dentry, d_inode(dentry));
+			boutc_formats(cl, " %llx dentry %p %s %p\n",
+				      " %llx dentry %p %pd %p\n",
+				      (di->offset, dentry,
+				       BLOG_STR(dname, dname_len),
+				       d_inode(dentry)),
+				      (di->offset, dentry, dentry,
+				       d_inode(dentry)));
 			ctx->pos = di->offset;
 			if (!dir_emit(ctx, dentry->d_name.name,
 				      dentry->d_name.len, ceph_present_inode(d_inode(dentry)),
@@ -326,19 +338,26 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	int err;
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%p %llx.%llx file %p pos %llx\n", inode,
+	ceph_blog_enter(fsc, &__ji);
+
+	boutc(cl, "%p %llx.%llx file %p pos %llx\n", inode,
 	      ceph_vinop(inode), file, ctx->pos);
-	if (dfi->file_info.flags & CEPH_F_ATEND)
+	if (dfi->file_info.flags & CEPH_F_ATEND) {
+		ceph_blog_exit(&__ji);
 		return 0;
+	}
 
 	/* always start with . and .. */
 	if (ctx->pos == 0) {
-		doutc(cl, "%p %llx.%llx off 0 -> '.'\n", inode,
+		boutc(cl, "%p %llx.%llx off 0 -> '.'\n", inode,
 		      ceph_vinop(inode));
 		if (!dir_emit(ctx, ".", 1, ceph_present_inode(inode),
-			    inode->i_mode >> 12))
+			    inode->i_mode >> 12)) {
+			ceph_blog_exit(&__ji);
 			return 0;
+		}
 		ctx->pos = 1;
 	}
 	if (ctx->pos == 1) {
@@ -349,16 +368,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ino = ceph_present_inode(dentry->d_parent->d_inode);
 		spin_unlock(&dentry->d_lock);
 
-		doutc(cl, "%p %llx.%llx off 1 -> '..'\n", inode,
+		boutc(cl, "%p %llx.%llx off 1 -> '..'\n", inode,
 		      ceph_vinop(inode));
-		if (!dir_emit(ctx, "..", 2, ino, inode->i_mode >> 12))
+		if (!dir_emit(ctx, "..", 2, ino, inode->i_mode >> 12)) {
+			ceph_blog_exit(&__ji);
 			return 0;
+		}
 		ctx->pos = 2;
 	}
 
 	err = ceph_fscrypt_prepare_readdir(inode);
-	if (err < 0)
+	if (err < 0) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
@@ -374,8 +397,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 		spin_unlock(&ci->i_ceph_lock);
 		err = __dcache_readdir(file, ctx, shared_gen);
-		if (err != -EAGAIN)
+		if (err != -EAGAIN) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	} else {
 		spin_unlock(&ci->i_ceph_lock);
 	}
@@ -404,15 +429,18 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			frag = fpos_frag(ctx->pos);
 		}
 
-		doutc(cl, "fetching %p %llx.%llx frag %x offset '%s'\n",
+		boutc(cl, "fetching %p %llx.%llx frag %x offset '%s'\n",
 		      inode, ceph_vinop(inode), frag, dfi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-		if (IS_ERR(req))
+		if (IS_ERR(req)) {
+			ceph_blog_exit(&__ji);
 			return PTR_ERR(req);
+		}
 
 		err = ceph_alloc_readdir_reply_buffer(req, inode);
 		if (err) {
 			ceph_mdsc_put_request(req);
+			ceph_blog_exit(&__ji);
 			return err;
 		}
 		/* hints to request -> mds selection code */
@@ -428,6 +456,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
+				ceph_blog_exit(&__ji);
 				return -ENOMEM;
 			}
 			memcpy(req->r_path2, dfi->last_name, len);
@@ -435,6 +464,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			err = ceph_encode_encrypted_dname(inode, req->r_path2, len);
 			if (err < 0) {
 				ceph_mdsc_put_request(req);
+				ceph_blog_exit(&__ji);
 				return err;
 			}
 		} else if (is_hash_order(ctx->pos)) {
@@ -456,9 +486,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
+			ceph_blog_exit(&__ji);
 			return err;
 		}
-		doutc(cl, "%p %llx.%llx got and parsed readdir result=%d"
+		boutc(cl, "%p %llx.%llx got and parsed readdir result=%d"
 		      "on frag %x, end=%d, complete=%d, hash_order=%d\n",
 		      inode, ceph_vinop(inode), err, frag,
 		      (int)req->r_reply_info.dir_end,
@@ -493,7 +524,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				dfi->dir_ordered_count = req->r_dir_ordered_cnt;
 			}
 		} else {
-			doutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
+			boutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
 			      ceph_vinop(inode));
 			/* disable readdir cache */
 			dfi->readdir_cache_idx = -1;
@@ -512,6 +543,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			if (err) {
 				ceph_mdsc_put_request(dfi->last_readdir);
 				dfi->last_readdir = NULL;
+				ceph_blog_exit(&__ji);
 				return err;
 			}
 		} else if (req->r_reply_info.dir_end) {
@@ -521,7 +553,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	rinfo = &dfi->last_readdir->r_reply_info;
-	doutc(cl, "%p %llx.%llx frag %x num %d pos %llx chunk first %llx\n",
+	boutc(cl, "%p %llx.%llx frag %x num %d pos %llx chunk first %llx\n",
 	      inode, ceph_vinop(inode), dfi->frag, rinfo->dir_nr, ctx->pos,
 	      rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
 
@@ -548,19 +580,26 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				inode, ceph_vinop(inode), rde->offset, ctx->pos);
 			ceph_mdsc_put_request(dfi->last_readdir);
 			dfi->last_readdir = NULL;
+			ceph_blog_exit(&__ji);
 			return -EIO;
 		}
 
 		if (WARN_ON_ONCE(!rde->inode.in)) {
 			ceph_mdsc_put_request(dfi->last_readdir);
 			dfi->last_readdir = NULL;
+			ceph_blog_exit(&__ji);
 			return -EIO;
 		}
 
 		ctx->pos = rde->offset;
-		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,
-		      ceph_vinop(inode), i, rinfo->dir_nr, ctx->pos,
-		      rde->name_len, rde->name, &rde->inode.in);
+		boutc_bounded(cl,
+			      "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n",
+			      (inode, ceph_vinop(inode), i, rinfo->dir_nr,
+			       ctx->pos, rde->name_len,
+			       BLOG_STR(rde->name, rde->name_len), &rde->inode.in),
+			      (inode, ceph_vinop(inode), i, rinfo->dir_nr,
+			       ctx->pos, rde->name_len, (const char *)rde->name,
+			       &rde->inode.in));
 
 		if (!dir_emit(ctx, rde->name, rde->name_len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
@@ -571,7 +610,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			 * doesn't have enough memory, etc. So for next readdir
 			 * it will continue.
 			 */
-			doutc(cl, "filldir stopping us...\n");
+			boutc(cl, "filldir stopping us...\n");
+			ceph_blog_exit(&__ji);
 			return 0;
 		}
 
@@ -602,7 +642,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			kfree(dfi->last_name);
 			dfi->last_name = NULL;
 		}
-		doutc(cl, "%p %llx.%llx next frag is %x\n", inode,
+		boutc(cl, "%p %llx.%llx next frag is %x\n", inode,
 		      ceph_vinop(inode), frag);
 		goto more;
 	}
@@ -618,7 +658,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_lock(&ci->i_ceph_lock);
 		if (dfi->dir_ordered_count ==
 				atomic64_read(&ci->i_ordered_count)) {
-			doutc(cl, " marking %p %llx.%llx complete and ordered\n",
+			boutc(cl, " marking %p %llx.%llx complete and ordered\n",
 			      inode, ceph_vinop(inode));
 			/* use i_size to track number of entries in
 			 * readdir cache */
@@ -626,15 +666,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			i_size_write(inode, dfi->readdir_cache_idx *
 				     sizeof(struct dentry*));
 		} else {
-			doutc(cl, " marking %llx.%llx complete\n",
+			boutc(cl, " marking %llx.%llx complete\n",
 			      ceph_vinop(inode));
 		}
 		__ceph_dir_set_complete(ci, dfi->dir_release_count,
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
-	doutc(cl, "%p %llx.%llx file %p done.\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx file %p done.\n", inode, ceph_vinop(inode),
 	      file);
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -680,8 +721,12 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file->f_mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	loff_t retval;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	inode_lock(inode);
 	retval = -EINVAL;
@@ -700,7 +745,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	if (offset >= 0) {
 		if (need_reset_readdir(dfi, offset)) {
-			doutc(cl, "%p %llx.%llx dropping %p content\n",
+			boutc(cl, "%p %llx.%llx dropping %p content\n",
 			      inode, ceph_vinop(inode), file);
 			reset_readdir(dfi);
 		} else if (is_hash_order(offset) && offset > file->f_pos) {
@@ -718,6 +763,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 out:
 	inode_unlock(inode);
+	ceph_blog_exit(&__ji);
 	return retval;
 }
 
@@ -738,9 +784,12 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 		struct inode *inode = ceph_get_snapdir(parent);
 
 		res = d_splice_alias(inode, dentry);
-		doutc(cl, "ENOENT on snapdir %p '%pd', linking to "
-		      "snapdir %p %llx.%llx. Spliced dentry %p\n",
-		      dentry, dentry, inode, ceph_vinop(inode), res);
+		boutc_formats(cl,
+			      "ENOENT on snapdir %p '%s', linking to snapdir %p %llx.%llx. Spliced dentry %p\n",
+			      "ENOENT on snapdir %p '%pd', linking to snapdir %p %llx.%llx. Spliced dentry %p\n",
+			      (dentry, dentry->d_name.name, inode,
+			       ceph_vinop(inode), res),
+			      (dentry, dentry, inode, ceph_vinop(inode), res));
 		if (res)
 			dentry = res;
 	}
@@ -767,7 +816,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 		/* no trace? */
 		err = 0;
 		if (!req->r_reply_info.head->is_dentry) {
-			doutc(cl,
+			boutc(cl,
 			      "ENOENT and no trace, dentry %p inode %llx.%llx\n",
 			      dentry, ceph_vinop(d_inode(dentry)));
 			if (d_really_is_positive(dentry)) {
@@ -813,19 +862,28 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	int op;
 	int mask;
 	int err;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%p %llx.%llx/'%pd' dentry %p\n", dir, ceph_vinop(dir),
-	      dentry, dentry);
+	ceph_blog_enter(fsc, &__ji);
 
-	if (dentry->d_name.len > NAME_MAX)
+	boutc_formats(cl, "%p %llx.%llx/'%s' dentry %p\n",
+		      "%p %llx.%llx/'%pd' dentry %p\n",
+		      (dir, ceph_vinop(dir), dentry->d_name.name, dentry),
+		      (dir, ceph_vinop(dir), dentry, dentry));
+
+	if (dentry->d_name.len > NAME_MAX) {
+		ceph_blog_exit(&__ji);
 		return ERR_PTR(-ENAMETOOLONG);
+	}
 
 	if (IS_ENCRYPTED(dir)) {
 		bool had_key = fscrypt_has_encryption_key(dir);
 
 		err = fscrypt_prepare_lookup_partial(dir, dentry);
-		if (err < 0)
+		if (err < 0) {
+			ceph_blog_exit(&__ji);
 			return ERR_PTR(err);
+		}
 
 		/* mark directory as incomplete if it has been unlocked */
 		if (!had_key && fscrypt_has_encryption_key(dir))
@@ -838,7 +896,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 		spin_lock(&ci->i_ceph_lock);
-		doutc(cl, " dir %llx.%llx flags are 0x%lx\n",
+		boutc(cl, " dir %llx.%llx flags are 0x%lx\n",
 		      ceph_vinop(dir), ci->i_ceph_flags);
 		if (strncmp(dentry->d_name.name,
 			    fsc->mount_options->snapdir_name,
@@ -850,11 +908,12 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED, 1)) {
 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
 			spin_unlock(&ci->i_ceph_lock);
-			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
+			boutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
 			if (d_unhashed(dentry))
 				d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
+			ceph_blog_exit(&__ji);
 			return NULL;
 		}
 		spin_unlock(&ci->i_ceph_lock);
@@ -863,8 +922,10 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	op = ceph_snap(dir) == CEPH_SNAPDIR ?
 		CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
 	req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
-	if (IS_ERR(req))
+	if (IS_ERR(req)) {
+		ceph_blog_exit(&__ji);
 		return ERR_CAST(req);
+	}
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 
@@ -890,7 +951,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	}
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
-	doutc(cl, "result=%p\n", dentry);
+	boutc(cl, "result=%p\n", dentry);
+	ceph_blog_exit(&__ji);
 	return dentry;
 }
 
@@ -925,25 +987,37 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (ceph_in_snap(dir))
+	if (ceph_in_snap(dir)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
 	err = ceph_wait_on_conflict_unlink(dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	if (ceph_quota_is_max_files_exceeded(dir)) {
 		err = -EDQUOT;
 		goto out;
 	}
 
-	doutc(cl, "%p %llx.%llx/'%pd' dentry %p mode 0%ho rdev %d\n",
-	      dir, ceph_vinop(dir), dentry, dentry, mode, rdev);
+	boutc_formats(cl,
+		      "%p %llx.%llx/'%s' dentry %p mode 0%ho rdev %d\n",
+		      "%p %llx.%llx/'%pd' dentry %p mode 0%ho rdev %d\n",
+		      (dir, ceph_vinop(dir), dentry->d_name.name, dentry,
+		       mode, rdev),
+		      (dir, ceph_vinop(dir), dentry, dentry, mode, rdev));
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -985,6 +1059,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	else
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1036,26 +1111,36 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *dest)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	umode_t mode = S_IFLNK | 0777;
 	int err;
+	struct ceph_journal_info __ji;
 
-	if (ceph_in_snap(dir))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_in_snap(dir)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
 	err = ceph_wait_on_conflict_unlink(dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	if (ceph_quota_is_max_files_exceeded(dir)) {
 		err = -EDQUOT;
 		goto out;
 	}
 
-	doutc(cl, "%p %llx.%llx/'%pd' to '%s'\n", dir, ceph_vinop(dir), dentry,
-	      dest);
+	boutc_formats(cl, "%p %llx.%llx/'%s' to '%s'\n",
+		      "%p %llx.%llx/'%pd' to '%s'\n",
+		      (dir, ceph_vinop(dir), dentry->d_name.name, dest),
+		      (dir, ceph_vinop(dir), dentry, dest));
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -1103,6 +1188,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1110,25 +1196,36 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	struct dentry *ret;
 	int err;
 	int op;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	err = ceph_wait_on_conflict_unlink(dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return ERR_PTR(err);
+	}
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* mkdir .snap/foo is a MKSNAP */
 		op = CEPH_MDS_OP_MKSNAP;
-		doutc(cl, "mksnap %llx.%llx/'%pd' dentry %p\n",
-		      ceph_vinop(dir), dentry, dentry);
+		boutc_formats(cl, "mksnap %llx.%llx/'%s' dentry %p\n",
+			      "mksnap %llx.%llx/'%pd' dentry %p\n",
+			      (ceph_vinop(dir), dentry->d_name.name, dentry),
+			      (ceph_vinop(dir), dentry, dentry));
 	} else if (!ceph_in_snap(dir)) {
-		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
-		      ceph_vinop(dir), dentry, dentry, mode);
+		boutc_formats(cl, "mkdir %llx.%llx/'%s' dentry %p mode 0%ho\n",
+			      "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
+			      (ceph_vinop(dir), dentry->d_name.name, dentry,
+			       mode),
+			      (ceph_vinop(dir), dentry, dentry, mode));
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
 		ret = ERR_PTR(-EROFS);
@@ -1195,6 +1292,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		d_drop(dentry);
 	}
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -1202,29 +1300,45 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 		     struct dentry *dentry)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (dentry->d_flags & DCACHE_DISCONNECTED)
+	if (dentry->d_flags & DCACHE_DISCONNECTED) {
+		ceph_blog_exit(&__ji);
 		return -EINVAL;
+	}
 
 	err = ceph_wait_on_conflict_unlink(dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
-	if (ceph_in_snap(dir))
+	if (ceph_in_snap(dir)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
-	doutc(cl, "%p %llx.%llx/'%pd' to '%pd'\n", dir, ceph_vinop(dir),
-	      old_dentry, dentry);
+	boutc_formats(cl, "%p %llx.%llx/'%s' to '%s'\n",
+		      "%p %llx.%llx/'%pd' to '%pd'\n",
+		      (dir, ceph_vinop(dir), old_dentry->d_name.name,
+		       dentry->d_name.name),
+		      (dir, ceph_vinop(dir), old_dentry, dentry));
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		d_drop(dentry);
+		ceph_blog_exit(&__ji);
 		return PTR_ERR(req);
 	}
 	req->r_dentry = dget(dentry);
@@ -1251,6 +1365,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 		d_instantiate(dentry, d_inode(old_dentry));
 	}
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1359,15 +1474,24 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	int err = -EROFS;
 	int op;
 	char *path;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* rmdir .snap/foo is RMSNAP */
-		doutc(cl, "rmsnap %llx.%llx/'%pd' dn\n", ceph_vinop(dir),
-		      dentry);
+		boutc_formats(cl, "rmsnap %llx.%llx/'%s' dn\n",
+			      "rmsnap %llx.%llx/'%pd' dn\n",
+			      (ceph_vinop(dir), dentry->d_name.name),
+			      (ceph_vinop(dir), dentry));
 		op = CEPH_MDS_OP_RMSNAP;
 	} else if (!ceph_in_snap(dir)) {
-		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
-		      ceph_vinop(dir), dentry, ceph_vinop(inode));
+		boutc_formats(cl,
+			      "unlink/rmdir %llx.%llx/'%s' inode %llx.%llx\n",
+			      "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
+			      (ceph_vinop(dir), dentry->d_name.name,
+			       ceph_vinop(inode)),
+			      (ceph_vinop(dir), dentry, ceph_vinop(inode)));
 		op = d_is_dir(dentry) ?
 			CEPH_MDS_OP_RMDIR : CEPH_MDS_OP_UNLINK;
 	} else
@@ -1390,6 +1514,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
 		if (err == -EACCES) {
+			ceph_blog_exit(&__ji);
 			return err;
 		} else if (err < 0) {
 			try_async = false;
@@ -1415,9 +1540,12 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
-		doutc(cl, "async unlink on %llx.%llx/'%pd' caps=%s",
-		      ceph_vinop(dir), dentry,
-		      ceph_cap_string(req->r_dir_caps));
+		boutc_formats(cl, "async unlink on %llx.%llx/'%s' caps=%s",
+			      "async unlink on %llx.%llx/'%pd' caps=%s",
+			      (ceph_vinop(dir), dentry->d_name.name,
+			       ceph_cap_string(req->r_dir_caps)),
+			      (ceph_vinop(dir), dentry,
+			       ceph_cap_string(req->r_dir_caps)));
 		set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 		req->r_callback = ceph_async_unlink_cb;
 		req->r_old_inode = d_inode(dentry);
@@ -1476,6 +1604,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	ceph_mdsc_put_request(req);
 out:
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1484,42 +1613,63 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old_dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int op = CEPH_MDS_OP_RENAME;
 	int err;
+	struct ceph_journal_info __ji;
 
-	if (flags)
+	ceph_blog_enter(fsc, &__ji);
+
+	if (flags) {
+		ceph_blog_exit(&__ji);
 		return -EINVAL;
+	}
 
-	if (ceph_snap(old_dir) != ceph_snap(new_dir))
+	if (ceph_snap(old_dir) != ceph_snap(new_dir)) {
+		ceph_blog_exit(&__ji);
 		return -EXDEV;
+	}
 	if (ceph_in_snap(old_dir)) {
 		if (old_dir == new_dir && ceph_snap(old_dir) == CEPH_SNAPDIR)
 			op = CEPH_MDS_OP_RENAMESNAP;
-		else
+		else {
+			ceph_blog_exit(&__ji);
 			return -EROFS;
+		}
 	}
 	/* don't allow cross-quota renames */
 	if ((old_dir != new_dir) &&
-	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
+	    (!ceph_quota_is_same_realm(old_dir, new_dir))) {
+		ceph_blog_exit(&__ji);
 		return -EXDEV;
+	}
 
 	err = ceph_wait_on_conflict_unlink(new_dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
 				     flags);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
-	doutc(cl, "%llx.%llx/'%pd' to %llx.%llx/'%pd'\n",
-	      ceph_vinop(old_dir), old_dentry, ceph_vinop(new_dir),
-	      new_dentry);
+	boutc_formats(cl, "%llx.%llx/'%s' to %llx.%llx/'%s'\n",
+		      "%llx.%llx/'%pd' to %llx.%llx/'%pd'\n",
+		      (ceph_vinop(old_dir), old_dentry->d_name.name,
+		       ceph_vinop(new_dir), new_dentry->d_name.name),
+		      (ceph_vinop(old_dir), old_dentry,
+		       ceph_vinop(new_dir), new_dentry));
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-	if (IS_ERR(req))
+	if (IS_ERR(req)) {
+		ceph_blog_exit(&__ji);
 		return PTR_ERR(req);
+	}
 	ihold(old_dir);
 	req->r_dentry = dget(new_dentry);
 	req->r_num_caps = 2;
@@ -1548,6 +1698,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		d_move(old_dentry, new_dentry);
 	}
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1564,7 +1715,8 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "%p %p '%pd'\n", di, dn, dn);
+	boutc_formats(cl, "%p %p '%s'\n", "%p %p '%pd'\n",
+		      (di, dn, dn->d_name.name), (di, dn, dn));
 
 	di->flags |= CEPH_DENTRY_LEASE_LIST;
 	if (di->flags & CEPH_DENTRY_SHRINK_LIST) {
@@ -1598,7 +1750,10 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "%p %p '%pd' (offset 0x%llx)\n", di, dn, dn, di->offset);
+	boutc_formats(cl, "%p %p '%s' (offset 0x%llx)\n",
+		      "%p %p '%pd' (offset 0x%llx)\n",
+		      (di, dn, dn->d_name.name, di->offset),
+		      (di, dn, dn, di->offset));
 
 	if (!list_empty(&di->lease_list)) {
 		if (di->flags & CEPH_DENTRY_LEASE_LIST) {
@@ -1905,7 +2060,7 @@ static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 					 CEPH_MDS_LEASE_RENEW, seq);
 		ceph_put_mds_session(session);
 	}
-	doutc(cl, "dentry %p = %d\n", dentry, valid);
+	boutc(cl, "dentry %p = %d\n", dentry, valid);
 	return valid;
 }
 
@@ -1970,8 +2125,9 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 			valid = 0;
 		spin_unlock(&dentry->d_lock);
 	}
-	doutc(cl, "dir %p %llx.%llx v%u dentry %p '%pd' = %d\n", dir,
-	      ceph_vinop(dir), (unsigned)atomic_read(&ci->i_shared_gen),
+	doutc(cl, "dir %p %llx.%llx v%u dentry %p '%pd' = %d\n",
+	      dir, ceph_vinop(dir),
+	      (unsigned)atomic_read(&ci->i_shared_gen),
 	      dentry, dentry, valid);
 	return valid;
 }
@@ -1993,6 +2149,7 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 
 	inode = d_inode_rcu(dentry);
 
+	/* No BLOG enter under LOOKUP_RCU; keep %pd text logging. */
 	doutc(cl, "%p '%pd' inode %p offset 0x%llx nokey %d\n",
 	      dentry, dentry, inode, ceph_dentry(dentry)->offset,
 	      !!(dentry->d_flags & DCACHE_NOKEY_NAME));
@@ -2066,7 +2223,8 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 		percpu_counter_inc(&mdsc->metric.d_lease_hit);
 	}
 
-	doutc(cl, "%p '%pd' %s\n", dentry, dentry, valid ? "valid" : "invalid");
+	doutc(cl, "%p '%pd' %s\n", dentry, dentry,
+	      valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
 	return valid;
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 1466c46f0691..a698f5bb11a0 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -87,32 +87,42 @@ static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 	*max_len = snap_handle_length;
 	ret = FILEID_BTRFS_WITH_PARENT;
 out:
-	doutc(cl, "%p %llx.%llx ret=%d\n", inode, ceph_vinop(inode), ret);
+	boutc(cl, "%p %llx.%llx ret=%d\n", inode, ceph_vinop(inode), ret);
 	return ret;
 }
 
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	static const int handle_length = CEPH_FH_BASIC_SIZE;
 	static const int connected_handle_length = CEPH_FH_WITH_PARENT_SIZE;
 	int type;
+	struct ceph_journal_info __ji;
 
-	if (ceph_in_snap(inode))
-		return ceph_encode_snapfh(inode, rawfh, max_len, parent_inode);
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_in_snap(inode)) {
+		int ret = ceph_encode_snapfh(inode, rawfh, max_len,
+					     parent_inode);
+		ceph_blog_exit(&__ji);
+		return ret;
+	}
 
 	if (parent_inode && (*max_len < connected_handle_length)) {
 		*max_len = connected_handle_length;
+		ceph_blog_exit(&__ji);
 		return FILEID_INVALID;
 	} else if (*max_len < handle_length) {
 		*max_len = handle_length;
+		ceph_blog_exit(&__ji);
 		return FILEID_INVALID;
 	}
 
 	if (parent_inode) {
 		struct ceph_nfs_confh *cfh = (void *)rawfh;
-		doutc(cl, "%p %llx.%llx with parent %p %llx.%llx\n", inode,
+		boutc(cl, "%p %llx.%llx with parent %p %llx.%llx\n", inode,
 		      ceph_vinop(inode), parent_inode, ceph_vinop(parent_inode));
 		cfh->ino = ceph_ino(inode);
 		cfh->parent_ino = ceph_ino(parent_inode);
@@ -120,11 +130,12 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 		type = FILEID_INO32_GEN_PARENT;
 	} else {
 		struct ceph_nfs_fh *fh = (void *)rawfh;
-		doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+		boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 		fh->ino = ceph_ino(inode);
 		*max_len = handle_length;
 		type = FILEID_INO32_GEN;
 	}
+	ceph_blog_exit(&__ji);
 	return type;
 }
 
@@ -286,9 +297,9 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 	ceph_mdsc_put_request(req);
 
 	if (want_parent) {
-		doutc(cl, "%llx.%llx\n err=%d\n", vino.ino, vino.snap, err);
+		boutc(cl, "%llx.%llx\n err=%d\n", vino.ino, vino.snap, err);
 	} else {
-		doutc(cl, "%llx.%llx parent %llx hash %x err=%d", vino.ino,
+		boutc(cl, "%llx.%llx parent %llx hash %x err=%d", vino.ino,
 		      vino.snap, sfh->parent_ino, sfh->hash, err);
 	}
 	/* see comments in ceph_get_parent() */
@@ -304,20 +315,31 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_nfs_fh *fh = (void *)fid->raw;
+	struct dentry *dentry;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (fh_type == FILEID_BTRFS_WITH_PARENT) {
 		struct ceph_nfs_snapfh *sfh = (void *)fid->raw;
+		ceph_blog_exit(&__ji);
 		return __snapfh_to_dentry(sb, sfh, false);
 	}
 
 	if (fh_type != FILEID_INO32_GEN  &&
-	    fh_type != FILEID_INO32_GEN_PARENT)
+	    fh_type != FILEID_INO32_GEN_PARENT) {
+		ceph_blog_exit(&__ji);
 		return NULL;
-	if (fh_len < sizeof(*fh) / BYTES_PER_U32)
+	}
+	if (fh_len < sizeof(*fh) / BYTES_PER_U32) {
+		ceph_blog_exit(&__ji);
 		return NULL;
+	}
 
-	doutc(fsc->client, "%llx\n", fh->ino);
-	return __fh_to_dentry(sb, fh->ino);
+	boutc(fsc->client, "%llx\n", fh->ino);
+	dentry = __fh_to_dentry(sb, fh->ino);
+	ceph_blog_exit(&__ji);
+	return dentry;
 }
 
 static struct dentry *__get_parent(struct super_block *sb,
@@ -369,8 +391,12 @@ static struct dentry *__get_parent(struct super_block *sb,
 static struct dentry *ceph_get_parent(struct dentry *child)
 {
 	struct inode *inode = d_inode(child);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (ceph_in_snap(inode)) {
 		struct inode* dir;
@@ -409,8 +435,9 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 		dn = __get_parent(child->d_sb, child, 0);
 	}
 out:
-	doutc(cl, "child %p %p %llx.%llx err=%ld\n", child, inode,
+	boutc(cl, "child %p %p %llx.%llx err=%ld\n", child, inode,
 	      ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
+	ceph_blog_exit(&__ji);
 	return dn;
 }
 
@@ -424,21 +451,30 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_nfs_confh *cfh = (void *)fid->raw;
 	struct dentry *dentry;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (fh_type == FILEID_BTRFS_WITH_PARENT) {
 		struct ceph_nfs_snapfh *sfh = (void *)fid->raw;
+		ceph_blog_exit(&__ji);
 		return __snapfh_to_dentry(sb, sfh, true);
 	}
 
-	if (fh_type != FILEID_INO32_GEN_PARENT)
+	if (fh_type != FILEID_INO32_GEN_PARENT) {
+		ceph_blog_exit(&__ji);
 		return NULL;
-	if (fh_len < sizeof(*cfh) / BYTES_PER_U32)
+	}
+	if (fh_len < sizeof(*cfh) / BYTES_PER_U32) {
+		ceph_blog_exit(&__ji);
 		return NULL;
+	}
 
-	doutc(fsc->client, "%llx\n", cfh->parent_ino);
+	boutc(fsc->client, "%llx\n", cfh->parent_ino);
 	dentry = __get_parent(sb, NULL, cfh->ino);
 	if (unlikely(dentry == ERR_PTR(-ENOENT)))
 		dentry = __fh_to_dentry(sb, cfh->parent_ino);
+	ceph_blog_exit(&__ji);
 	return dentry;
 }
 
@@ -549,7 +585,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 	if (req)
 		ceph_mdsc_put_request(req);
 	kfree(last_name);
-	doutc(fsc->client, "child dentry %p %p %llx.%llx err=%d\n", child,
+	boutc(fsc->client, "child dentry %p %p %llx.%llx err=%d\n", child,
 	      inode, ceph_vinop(inode), err);
 	return err;
 }
@@ -561,17 +597,25 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	struct ceph_mds_request *req;
 	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
+	struct ceph_journal_info __ji;
 
-	if (ceph_in_snap(inode))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_in_snap(inode)) {
+		ceph_blog_exit(&__ji);
 		return __get_snap_name(parent, name, child);
+	}
 
 	mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
 				       USE_ANY_MDS);
-	if (IS_ERR(req))
+	if (IS_ERR(req)) {
+		ceph_blog_exit(&__ji);
 		return PTR_ERR(req);
+	}
 
 	inode_lock(dir);
 	req->r_inode = inode;
@@ -610,10 +654,11 @@ static int ceph_get_name(struct dentry *parent, char *name,
 		ceph_fname_free_buffer(dir, &oname);
 	}
 out:
-	doutc(mdsc->fsc->client, "child dentry %p %p %llx.%llx err %d %s%s\n",
+	boutc(mdsc->fsc->client, "child dentry %p %p %llx.%llx err %d %s%s\n",
 	      child, inode, ceph_vinop(inode), err, err ? "" : "name ",
 	      err ? "" : name);
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 209e8972287d..804a7a71e831 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -264,7 +264,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 			inode->i_flags |= S_ENCRYPTED;
 			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
 		} else {
-			doutc(cl, "Failed to alloc snapdir fscrypt_auth\n");
+			boutc(cl, "Failed to alloc snapdir fscrypt_auth\n");
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -342,7 +342,7 @@ static struct ceph_inode_frag *__get_or_create_frag(struct ceph_inode_info *ci,
 	rb_link_node(&frag->node, parent, p);
 	rb_insert_color(&frag->node, &ci->i_fragtree);
 
-	doutc(cl, "added %p %llx.%llx frag %x\n", inode, ceph_vinop(inode), f);
+	boutc(cl, "added %p %llx.%llx frag %x\n", inode, ceph_vinop(inode), f);
 	return frag;
 }
 
@@ -399,7 +399,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 
 		/* choose child */
 		nway = 1 << frag->split_by;
-		doutc(cl, "frag(%x) %x splits by %d (%d ways)\n", v, t,
+		boutc(cl, "frag(%x) %x splits by %d (%d ways)\n", v, t,
 		      frag->split_by, nway);
 		for (i = 0; i < nway; i++) {
 			n = ceph_frag_make_child(t, frag->split_by, i);
@@ -410,7 +410,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 		}
 		BUG_ON(i == nway);
 	}
-	doutc(cl, "frag(%x) = %x\n", v, t);
+	boutc(cl, "frag(%x) = %x\n", v, t);
 
 	return t;
 }
@@ -459,13 +459,13 @@ static int ceph_fill_dirfrag(struct inode *inode,
 			goto out;
 		if (frag->split_by == 0) {
 			/* tree leaf, remove */
-			doutc(cl, "removed %p %llx.%llx frag %x (no ref)\n",
+			boutc(cl, "removed %p %llx.%llx frag %x (no ref)\n",
 			      inode, ceph_vinop(inode), id);
 			rb_erase(&frag->node, &ci->i_fragtree);
 			kfree(frag);
 		} else {
 			/* tree branch, keep and clear */
-			doutc(cl, "cleared %p %llx.%llx frag %x referral\n",
+			boutc(cl, "cleared %p %llx.%llx frag %x referral\n",
 			      inode, ceph_vinop(inode), id);
 			frag->mds = -1;
 			frag->ndist = 0;
@@ -490,7 +490,7 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	frag->ndist = min_t(u32, ndist, CEPH_MAX_DIRFRAG_REP);
 	for (i = 0; i < frag->ndist; i++)
 		frag->dist[i] = le32_to_cpu(dirinfo->dist[i]);
-	doutc(cl, "%p %llx.%llx frag %x ndist=%d\n", inode,
+	boutc(cl, "%p %llx.%llx frag %x ndist=%d\n", inode,
 	      ceph_vinop(inode), frag->frag, frag->ndist);
 
 out:
@@ -555,7 +555,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		     frag_tree_split_cmp, NULL);
 	}
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	rb_node = rb_first(&ci->i_fragtree);
 	for (i = 0; i < nsplits; i++) {
 		id = le32_to_cpu(fragtree->splits[i].frag);
@@ -595,7 +595,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		if (frag->split_by == 0)
 			ci->i_fragtree_nsplits++;
 		frag->split_by = split_by;
-		doutc(cl, " frag %x split by %d\n", frag->frag, frag->split_by);
+		boutc(cl, " frag %x split by %d\n", frag->frag, frag->split_by);
 		prev_frag = frag;
 	}
 	while (rb_node) {
@@ -744,13 +744,17 @@ void ceph_free_inode(struct inode *inode)
 
 void ceph_evict_inode(struct inode *inode)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_frag *frag;
 	struct rb_node *n;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(cl, "%p ino %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
@@ -776,7 +780,7 @@ void ceph_evict_inode(struct inode *inode)
 	 */
 	if (ci->i_snap_realm) {
 		if (!ceph_in_snap(inode)) {
-			doutc(cl, " dropping residual ref to snap realm %p\n",
+			boutc(cl, " dropping residual ref to snap realm %p\n",
 			      ci->i_snap_realm);
 			ceph_change_snap_realm(inode, NULL);
 		} else {
@@ -800,6 +804,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
 	ceph_put_string(rcu_dereference_raw(ci->i_cached_layout.pool_ns));
+	ceph_blog_exit(&__ji);
 }
 
 /*
@@ -884,7 +889,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
 	    (truncate_seq == ci->i_truncate_seq && size > isize)) {
-		doutc(cl, "size %lld -> %llu\n", isize, size);
+		boutc(cl, "size %lld -> %llu\n", isize, size);
 		if (size > 0 && S_ISDIR(inode->i_mode)) {
 			pr_err_client(cl, "non-zero size for directory\n");
 			size = 0;
@@ -899,7 +904,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ceph_fscache_update(inode);
 		ci->i_reported_size = size;
 		if (truncate_seq != ci->i_truncate_seq) {
-			doutc(cl, "truncate_seq %u -> %u\n",
+			boutc(cl, "truncate_seq %u -> %u\n",
 			      ci->i_truncate_seq, truncate_seq);
 			ci->i_truncate_seq = truncate_seq;
 
@@ -929,7 +934,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	 * anyway.
 	 */
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) >= 0) {
-		doutc(cl, "truncate_size %lld -> %llu, encrypted %d\n",
+		boutc(cl, "truncate_size %lld -> %llu, encrypted %d\n",
 		      ci->i_truncate_size, truncate_size,
 		      !!IS_ENCRYPTED(inode));
 
@@ -937,7 +942,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 #ifdef CONFIG_FS_ENCRYPTION
 		if (IS_ENCRYPTED(inode)) {
-			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
+			boutc(cl, "truncate_pagecache_size %lld -> %llu\n",
 			      ci->i_truncate_pagecache_size, size);
 			ci->i_truncate_pagecache_size = size;
 		} else {
@@ -1039,7 +1044,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
+		boutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
 		      time_warp_seq, ci->i_time_warp_seq);
 }
 
@@ -1107,7 +1112,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	lockdep_assert_held(&mdsc->snap_rwsem);
 
-	doutc(cl, "%p ino %llx.%llx v %llu had %llu\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p ino %llx.%llx v %llu had %llu\n", inode, ceph_vinop(inode),
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
@@ -1204,7 +1209,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -1276,7 +1281,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
-			doutc(cl, "max_size %lld -> %llu\n",
+			boutc(cl, "max_size %lld -> %llu\n",
 			    ci->i_max_size, le64_to_cpu(info->max_size));
 			ci->i_max_size = le64_to_cpu(info->max_size);
 		}
@@ -1417,7 +1422,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			    (info_caps & CEPH_CAP_FILE_SHARED) &&
 			    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
 			    !__ceph_dir_is_complete(ci)) {
-				doutc(cl, " marking %p complete (empty)\n",
+				boutc(cl, " marking %p complete (empty)\n",
 				      inode);
 				i_size_write(inode, 0);
 				__ceph_dir_set_complete(ci,
@@ -1427,7 +1432,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 			wake = true;
 		} else {
-			doutc(cl, " %p got snap_caps %s\n", inode,
+			boutc(cl, " %p got snap_caps %s\n", inode,
 			      ceph_cap_string(info_caps));
 			ci->i_snap_caps |= info_caps;
 		}
@@ -1498,7 +1503,7 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
 
-	doutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
+	boutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
 	if (ceph_in_snap(dir))
@@ -1637,14 +1642,14 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 	}
 
 	if (realdn) {
-		doutc(cl, "dn %p (%d) spliced with %p (%d) inode %p ino %llx.%llx\n",
+		boutc(cl, "dn %p (%d) spliced with %p (%d) inode %p ino %llx.%llx\n",
 		      dn, d_count(dn), realdn, d_count(realdn),
 		      d_inode(realdn), ceph_vinop(d_inode(realdn)));
 		dput(dn);
 		*pdn = realdn;
 	} else {
 		BUG_ON(!ceph_dentry(dn));
-		doutc(cl, "dn %p attached to %p ino %llx.%llx\n", dn,
+		boutc(cl, "dn %p attached to %p ino %llx.%llx\n", dn,
 		      d_inode(dn), ceph_vinop(d_inode(dn)));
 	}
 	return 0;
@@ -1672,11 +1677,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct inode *parent_dir = NULL;
 	int err = 0;
 
-	doutc(cl, "%p is_dentry %d is_target %d\n", req,
+	boutc(cl, "%p is_dentry %d is_target %d\n", req,
 	      rinfo->head->is_dentry, rinfo->head->is_target);
 
 	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
-		doutc(cl, "reply is empty!\n");
+		boutc(cl, "reply is empty!\n");
 		if (rinfo->head->result == 0 && req->r_parent)
 			ceph_invalidate_dir_request(req);
 		return 0;
@@ -1742,13 +1747,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
 			dn = d_lookup(parent, &dname);
-			doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
-			      parent, dname.len, dname.name, dn);
+			boutc_bounded(cl,
+				      "d_lookup on parent=%p name=%.*s got %p\n",
+				      (parent, dname.len,
+				       BLOG_STR(dname.name, dname.len), dn),
+				      (parent, dname.len,
+				       (const char *)dname.name, dn));
 
 			if (!dn) {
 				dn = d_alloc(parent, &dname);
-				doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-				      dname.len, dname.name, dn);
+				boutc_bounded(cl, "d_alloc %p '%.*s' = %p\n",
+					      (parent, dname.len,
+					       BLOG_STR(dname.name, dname.len), dn),
+					      (parent, dname.len,
+					       (const char *)dname.name, dn));
 				if (!dn) {
 					dput(parent);
 					ceph_fname_free_buffer(parent_dir, &oname);
@@ -1764,7 +1776,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
-				doutc(cl, " dn %p points to wrong inode %p\n",
+				boutc(cl, " dn %p points to wrong inode %p\n",
 				      dn, d_inode(dn));
 				ceph_dir_clear_ordered(parent_dir);
 				d_delete(dn);
@@ -1842,30 +1854,30 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		have_lease = have_dir_cap ||
 			le32_to_cpu(rinfo->dlease->duration_ms);
 		if (!have_lease)
-			doutc(cl, "no dentry lease or dir cap\n");
+			boutc(cl, "no dentry lease or dir cap\n");
 
 		/* rename? */
 		if (req->r_old_dentry && req->r_op == CEPH_MDS_OP_RENAME) {
 			struct inode *olddir = req->r_old_dentry_dir;
 			BUG_ON(!olddir);
 
-			doutc(cl, " src %p '%pd' dst %p '%pd'\n",
-			      req->r_old_dentry, req->r_old_dentry, dn, dn);
-			doutc(cl, "doing d_move %p -> %p\n", req->r_old_dentry, dn);
+			boutc(cl, " src %p '%s' dst %p '%s'\n",
+			      req->r_old_dentry, req->r_old_dentry->d_name.name, dn, dn->d_name.name);
+			boutc(cl, "doing d_move %p -> %p\n", req->r_old_dentry, dn);
 
 			/* d_move screws up sibling dentries' offsets */
 			ceph_dir_clear_ordered(dir);
 			ceph_dir_clear_ordered(olddir);
 
 			d_move(req->r_old_dentry, dn);
-			doutc(cl, " src %p '%pd' dst %p '%pd'\n",
-			      req->r_old_dentry, req->r_old_dentry, dn, dn);
+			boutc(cl, " src %p '%s' dst %p '%s'\n",
+			      req->r_old_dentry, req->r_old_dentry->d_name.name, dn, dn->d_name.name);
 
 			/* ensure target dentry is invalidated, despite
 			   rehashing bug in vfs_rename_dir */
 			ceph_invalidate_dentry_lease(dn);
 
-			doutc(cl, "dn %p gets new offset %lld\n",
+			boutc(cl, "dn %p gets new offset %lld\n",
 			      req->r_old_dentry,
 			      ceph_dentry(req->r_old_dentry)->offset);
 
@@ -1879,9 +1891,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		/* null dentry? */
 		if (!rinfo->head->is_target) {
-			doutc(cl, "null dentry\n");
+			boutc(cl, "null dentry\n");
 			if (d_really_is_positive(dn)) {
-				doutc(cl, "d_delete %p\n", dn);
+				boutc(cl, "d_delete %p\n", dn);
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 			} else if (have_lease) {
@@ -1911,7 +1923,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				goto done;
 			dn = req->r_dentry;  /* may have spliced */
 		} else if (d_really_is_positive(dn) && d_inode(dn) != in) {
-			doutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
+			boutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
 			      dn, d_inode(dn), ceph_vinop(d_inode(dn)),
 			      ceph_vinop(in));
 			d_invalidate(dn);
@@ -1923,7 +1935,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    rinfo->dlease, session,
 					    req->r_request_started);
 		}
-		doutc(cl, " final dn %p\n", dn);
+		boutc(cl, " final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
 	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
@@ -1934,7 +1946,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!dir);
 		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
 		BUG_ON(!req->r_dentry);
-		doutc(cl, " linking snapped dir %p to dn %p\n", in,
+		boutc(cl, " linking snapped dir %p to dn %p\n", in,
 		      req->r_dentry);
 		ceph_dir_clear_ordered(dir);
 
@@ -1966,7 +1978,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
 	if (unlikely(!IS_ERR_OR_NULL(parent_dir) && parent_dir != req->r_parent))
 		iput(parent_dir);
-	doutc(cl, "done err=%d\n", err);
+	boutc(cl, "done err=%d\n", err);
 	return err;
 }
 
@@ -1992,7 +2004,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
-			doutc(cl, "badness got %d\n", err);
+			boutc(cl, "badness got %d\n", err);
 			continue;
 		}
 		rc = ceph_fill_inode(in, NULL, &rde->inode, NULL, session,
@@ -2059,11 +2071,11 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 
 	if (req->r_dir_release_cnt == atomic64_read(&ci->i_release_count) &&
 	    req->r_dir_ordered_cnt == atomic64_read(&ci->i_ordered_count)) {
-		doutc(cl, "dn %p idx %d\n", dn, ctl->index);
+		boutc(cl, "dn %p idx %d\n", dn, ctl->index);
 		ctl->dentries[idx] = dn;
 		ctl->index++;
 	} else {
-		doutc(cl, "disable readdir cache\n");
+		boutc(cl, "disable readdir cache\n");
 		ctl->index = -1;
 	}
 	return 0;
@@ -2104,7 +2116,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 	if (rinfo->dir_dir &&
 	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
-		doutc(cl, "got new frag %x -> %x\n", frag,
+		boutc(cl, "got new frag %x -> %x\n", frag,
 			    le32_to_cpu(rinfo->dir_dir->frag));
 		frag = le32_to_cpu(rinfo->dir_dir->frag);
 		if (!rinfo->hash_order)
@@ -2112,10 +2124,10 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	}
 
 	if (le32_to_cpu(rinfo->head->op) == CEPH_MDS_OP_LSSNAP) {
-		doutc(cl, "%d items under SNAPDIR dn %p\n",
+		boutc(cl, "%d items under SNAPDIR dn %p\n",
 		      rinfo->dir_nr, parent);
 	} else {
-		doutc(cl, "%d items under dn %p\n", rinfo->dir_nr, parent);
+		boutc(cl, "%d items under dn %p\n", rinfo->dir_nr, parent);
 		if (rinfo->dir_dir)
 			ceph_fill_dirfrag(d_inode(parent), rinfo->dir_dir);
 
@@ -2159,15 +2171,20 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 retry_lookup:
 		dn = d_lookup(parent, &dname);
-		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
-		      parent, dname.len, dname.name, dn);
+		boutc_bounded(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+			      (parent, dname.len,
+			       BLOG_STR(dname.name, dname.len), dn),
+			      (parent, dname.len, (const char *)dname.name, dn));
 
 		if (!dn) {
 			dn = d_alloc(parent, &dname);
-			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-			      dname.len, dname.name, dn);
+			boutc_bounded(cl, "d_alloc %p '%.*s' = %p\n",
+				      (parent, dname.len,
+				       BLOG_STR(dname.name, dname.len), dn),
+				      (parent, dname.len,
+				       (const char *)dname.name, dn));
 			if (!dn) {
-				doutc(cl, "d_alloc badness\n");
+				boutc(cl, "d_alloc badness\n");
 				err = -ENOMEM;
 				goto out;
 			}
@@ -2180,7 +2197,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
 			struct ceph_dentry_info *di = ceph_dentry(dn);
-			doutc(cl, " dn %p points to wrong inode %p\n",
+			boutc(cl, " dn %p points to wrong inode %p\n",
 			      dn, d_inode(dn));
 
 			spin_lock(&dn->d_lock);
@@ -2203,7 +2220,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
 			if (IS_ERR(in)) {
-				doutc(cl, "new_inode badness\n");
+				boutc(cl, "new_inode badness\n");
 				d_drop(dn);
 				dput(dn);
 				err = PTR_ERR(in);
@@ -2232,7 +2249,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		if (d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
-				doutc(cl, " skip splicing dn %p to inode %p"
+				boutc(cl, " skip splicing dn %p to inode %p"
 				      " (security xattr deadlock)\n", dn, in);
 				iput(in);
 				skipped++;
@@ -2265,7 +2282,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 	return err;
 }
 
@@ -2276,7 +2293,7 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 	bool ret;
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
+	boutc(cl, "set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
 	i_size_write(inode, size);
 	ceph_fscache_update(inode);
 	inode->i_blocks = calc_inode_blocks(size);
@@ -2328,7 +2345,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	}
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx gen %d revoking %d\n", inode,
+	boutc(cl, "%p %llx.%llx gen %d revoking %d\n", inode,
 	      ceph_vinop(inode), ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
@@ -2348,12 +2365,12 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	spin_lock(&ci->i_ceph_lock);
 	if (orig_gen == ci->i_rdcache_gen &&
 	    orig_gen == ci->i_rdcache_revoking) {
-		doutc(cl, "%p %llx.%llx gen %d successful\n", inode,
+		boutc(cl, "%p %llx.%llx gen %d successful\n", inode,
 		      ceph_vinop(inode), ci->i_rdcache_gen);
 		ci->i_rdcache_revoking--;
 		check = 1;
 	} else {
-		doutc(cl, "%p %llx.%llx gen %d raced, now %d revoking %d\n",
+		boutc(cl, "%p %llx.%llx gen %d raced, now %d revoking %d\n",
 		      inode, ceph_vinop(inode), orig_gen, ci->i_rdcache_gen,
 		      ci->i_rdcache_revoking);
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
@@ -2381,7 +2398,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_truncate_pending == 0) {
-		doutc(cl, "%p %llx.%llx none pending\n", inode,
+		boutc(cl, "%p %llx.%llx none pending\n", inode,
 		      ceph_vinop(inode));
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
@@ -2394,7 +2411,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
 		spin_unlock(&ci->i_ceph_lock);
-		doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
+		boutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
 		      ceph_vinop(inode));
 		filemap_write_and_wait_range(&inode->i_data, 0,
 					     inode->i_sb->s_maxbytes);
@@ -2406,7 +2423,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 
 	to = ceph_get_truncate_pagecache_size(ci);
 	wrbuffer_refs = ci->i_wrbuffer_ref;
-	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
 	      ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -2435,10 +2452,14 @@ static void ceph_inode_work(struct work_struct *work)
 	struct ceph_inode_info *ci = container_of(work, struct ceph_inode_info,
 						 i_work);
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (test_and_clear_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask)) {
-		doutc(cl, "writeback %p %llx.%llx\n", inode, ceph_vinop(inode));
+		boutc(cl, "writeback %p %llx.%llx\n", inode, ceph_vinop(inode));
 		filemap_fdatawrite(&inode->i_data);
 	}
 	if (test_and_clear_bit(CEPH_I_WORK_INVALIDATE_PAGES, &ci->i_work_mask))
@@ -2453,6 +2474,7 @@ static void ceph_inode_work(struct work_struct *work)
 	if (test_and_clear_bit(CEPH_I_WORK_FLUSH_SNAPS, &ci->i_work_mask))
 		ceph_flush_snaps(ci, NULL);
 
+	ceph_blog_exit(&__ji);
 	iput(inode);
 }
 
@@ -2533,7 +2555,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 
 	issued = __ceph_caps_issued(ci, NULL);
 
-	doutc(cl, "size %lld -> %lld got cap refs on %s, issued %s\n",
+	boutc(cl, "size %lld -> %lld got cap refs on %s, issued %s\n",
 	      i_size, attr->ia_size, ceph_cap_string(got),
 	      ceph_cap_string(issued));
 
@@ -2590,7 +2612,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	 * If the Rados object doesn't exist, it will be set to 0.
 	 */
 	if (!objver) {
-		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
+		boutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
 
 		header.data_len = cpu_to_le32(8 + 8 + 4);
 		header.file_offset = 0;
@@ -2599,7 +2621,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 		header.data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
 		header.file_offset = cpu_to_le64(orig_pos);
 
-		doutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
+		boutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
 		      CEPH_FSCRYPT_BLOCK_SIZE);
 
 		/* truncate and zero out the extra contents for the last block */
@@ -2627,7 +2649,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	}
 	req->r_pagelist = pagelist;
 out:
-	doutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
+	boutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 	if (iov.iov_base)
@@ -2712,7 +2734,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx issued %s\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx issued %s\n", inode, ceph_vinop(inode),
 	      ceph_cap_string(issued));
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 	if (cia && cia->fscrypt_auth) {
@@ -2724,7 +2746,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 			goto out;
 		}
 
-		doutc(cl, "%p %llx.%llx fscrypt_auth len %u to %u)\n", inode,
+		boutc(cl, "%p %llx.%llx fscrypt_auth len %u to %u)\n", inode,
 		      ceph_vinop(inode), ci->fscrypt_auth_len, len);
 
 		/* It should never be re-set once set */
@@ -2755,7 +2777,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_UID) {
 		kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
 
-		doutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
+		boutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
 		      ceph_vinop(inode),
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kuid(&init_user_ns, attr->ia_uid));
@@ -2773,7 +2795,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_GID) {
 		kgid_t fsgid = from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid);
 
-		doutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
+		boutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
 		      ceph_vinop(inode),
 		      from_kgid(&init_user_ns, inode->i_gid),
 		      from_kgid(&init_user_ns, attr->ia_gid));
@@ -2789,7 +2811,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_MODE) {
-		doutc(cl, "%p %llx.%llx mode 0%o -> 0%o\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o -> 0%o\n", inode,
 		      ceph_vinop(inode), inode->i_mode, attr->ia_mode);
 		if (!do_sync && (issued & CEPH_CAP_AUTH_EXCL)) {
 			inode->i_mode = attr->ia_mode;
@@ -2827,7 +2849,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_SIZE) {
-		doutc(cl, "%p %llx.%llx size %lld -> %lld\n", inode,
+		boutc(cl, "%p %llx.%llx size %lld -> %lld\n", inode,
 		      ceph_vinop(inode), isize, attr->ia_size);
 		/*
 		 * Only when the new size is smaller and not aligned to
@@ -2926,7 +2948,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_FILE)
-		doutc(cl, "%p %llx.%llx ATTR_FILE ... hrm!\n", inode,
+		boutc(cl, "%p %llx.%llx ATTR_FILE ... hrm!\n", inode,
 		      ceph_vinop(inode));
 
 	if (dirtied) {
@@ -2968,7 +2990,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		 */
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err == -EAGAIN && truncate_retry--) {
-			doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote), retry it!\n",
+			boutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote), retry it!\n",
 			      inode, ceph_vinop(inode), err,
 			      ceph_cap_string(dirtied), mask);
 			ceph_mdsc_put_request(req);
@@ -2977,7 +2999,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 out:
-	doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote)\n", inode,
+	boutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote)\n", inode,
 	      ceph_vinop(inode), err, ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
@@ -2998,34 +3020,50 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (ceph_in_snap(inode))
+	if (ceph_in_snap(inode)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
 	err = fscrypt_prepare_setattr(dentry, attr);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	err = setattr_prepare(idmap, dentry, attr);
-	if (err != 0)
+	if (err != 0) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
-	    attr->ia_size > max(i_size_read(inode), fsc->max_file_size))
+	    attr->ia_size > max(i_size_read(inode), fsc->max_file_size)) {
+		ceph_blog_exit(&__ji);
 		return -EFBIG;
+	}
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
-	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
+	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size)) {
+		ceph_blog_exit(&__ji);
 		return -EDQUOT;
+	}
 
 	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3074,12 +3112,12 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 	int err;
 
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
-		doutc(cl, "inode %p %llx.%llx SNAPDIR\n", inode,
+		boutc(cl, "inode %p %llx.%llx SNAPDIR\n", inode,
 		      ceph_vinop(inode));
 		return 0;
 	}
 
-	doutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
+	boutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
 	if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
 			return 0;
@@ -3107,7 +3145,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		}
 	}
 	ceph_mdsc_put_request(req);
-	doutc(cl, "result=%d\n", err);
+	boutc(cl, "result=%d\n", err);
 	return err;
 }
 
@@ -3145,7 +3183,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 	xattr_value = req->r_reply_info.xattr_info.xattr_value;
 	xattr_value_len = req->r_reply_info.xattr_info.xattr_value_len;
 
-	doutc(cl, "xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
+	boutc(cl, "xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
 
 	err = (int)xattr_value_len;
 	if (size == 0)
@@ -3160,7 +3198,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 put:
 	ceph_mdsc_put_request(req);
 out:
-	doutc(cl, "result=%d\n", err);
+	boutc(cl, "result=%d\n", err);
 	return err;
 }
 
@@ -3172,15 +3210,20 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
+	struct ceph_journal_info __ji;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
+	ceph_blog_enter(fsc, &__ji);
+
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
 		err = generic_permission(idmap, inode, mask);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3220,21 +3263,29 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct super_block *sb = inode->i_sb;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 valid_mask = STATX_BASIC_STATS;
 	int err = 0;
+	struct ceph_journal_info __ji;
 
-	if (ceph_inode_is_shutdown(inode))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
 	/* Skip the getattr altogether if we're asked not to sync */
 	if ((flags & AT_STATX_SYNC_TYPE) != AT_STATX_DONT_SYNC) {
 		err = ceph_do_getattr(inode,
 				statx_to_caps(request_mask, inode->i_mode),
 				flags & AT_STATX_FORCE_SYNC);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
 	generic_fillattr(idmap, request_mask, inode, stat);
@@ -3268,8 +3319,10 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			struct inode *parent;
 
 			parent = ceph_lookup_inode(sb, ceph_ino(inode));
-			if (IS_ERR(parent))
+			if (IS_ERR(parent)) {
+				ceph_blog_exit(&__ji);
 				return PTR_ERR(parent);
+			}
 
 			pci = ceph_inode(parent);
 			spin_lock(&pci->i_ceph_lock);
@@ -3302,6 +3355,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_ENCRYPTED);
 
 	stat->result_mask = request_mask & valid_mask;
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
-- 
2.34.1

