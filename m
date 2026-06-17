Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BD477E4D
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708440; cv=none; b=cEq8ZYq2Ik6Vcoa8ZrHIAvWIneoIRvA4xyOnMrFRqUU7z3UEQl3rP7cBc3fOm+8khgOScWztq15oLjRe5h4QApIAHgrs0R4f4ipeOHuizG6RMqmS01Fn8HuOttTDEMRkVXvFYWDci8X6ydpuz0ofqaLPF8Uvw+bryq0jnqr4XLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708440; c=relaxed/simple;
	bh=ZL5bMs/znoTFBtaK33EzJpcFfJYqOxWtwi5wgHXixVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ci40hULe1IVvDKIw1BoNZGgcTcfFTr5V1LYSaZ3eMZ6nNXOKK1S4Y8KXQTRXBlSgj7UZJ7gC7P6r6vDSQw2cW6Q61hhkRKsQPupJhYqU6udwJwiPmGArbEH6lKjD8cve6XECrHnmnGIizv8okvtjncjvQtG3v5qhrvqGBMV70bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g901bfaU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lSMI7rPn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g901bfaU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lSMI7rPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOiVEc61CwjH6Gjc2LTPJr/3eoBUCKx59uZvYHlLtCk=;
	b=g901bfaUajCDJYSA+L1+DBllVjqG8X2RGJta8FZnIgVU4nnu2mCGrxIe4EmHZ/Sf+5KEoR
	UnvVEtWi+1QCj2io4KHR5eumfOzJHI0wdY4wcPVm2TdIpZfFRuwP/K3vTJhmN6zbq+9ewL
	pbKHYtxiMDSIpWQFSBLZrDpRTahKAAs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-3-GR41mWOGilF36ajbsPiA-1; Wed, 17 Jun 2026 11:00:20 -0400
X-MC-Unique: 3-GR41mWOGilF36ajbsPiA-1
X-Mimecast-MFC-AGG-ID: 3-GR41mWOGilF36ajbsPiA_1781708419
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso11055610a34.2
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708419; x=1782313219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOiVEc61CwjH6Gjc2LTPJr/3eoBUCKx59uZvYHlLtCk=;
        b=lSMI7rPnAcCm+cpd8hp0lajWC/76cEcj2JHSxcGOhwgJsHutoUT5BUixmcENhuLHtZ
         mhjVigSESrRP46liHPn0UTEkw/cmp45thPht3L5FEv2KVsDOexUmwSLxBHu5LTP6S81Y
         gmUlEFnrJjjYOvmEOZFg/t2dc1JU5VmhhdD6FUqwblEIMIY9gxpj8rydHWIg4/TUiAD6
         VejCY8jFVAGvXaLVgGB+3KGfjbhRqUii3uZ6M5Jrd0Zq3WOqNzzffQhpTb65rNo5yHi2
         i56GoIXGWdi6Ims/3SwHgzuK8Kuv+nt83FTwGGRBHujOhVuNHmkesz+HXvqKIJMv8ma6
         6LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708419; x=1782313219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EOiVEc61CwjH6Gjc2LTPJr/3eoBUCKx59uZvYHlLtCk=;
        b=W3dvFpuJj2Yl21RqSRjQQEfxojTI292TfLqbJ4KD6DIUUMLzqfeiBfgTIrakYp1h/B
         9VCyRT9aLX249bt8FFjhjRCYk192DhnL8ROTTIemAZMeNjXqa4fqRsGkYq3VQY3VKIEo
         pKItOOiry3am5kITYbIAd3da93MJ+xb0iddPlZHZfUoF4QPyvrbAZe6TkUoAd07omsQZ
         v9OyiaidXPuH2ZuSjm6loLufIJW8JXFgjCXdsPpfFYnWzeG6aA1htTYsQYqCDJiJsrHR
         HzTLp9Ss2BoGU3Lo8Fcu8DO5+8xA1AEfnKjolMiBperRpGI/YL1pQEApahGvP23u+9pH
         X85w==
X-Gm-Message-State: AOJu0Yy7xzid655wstsGNgPeZUCm9fTMj+/ppsEgaiycZNQeZCNZQT13
	fCXJXeT2lBDGx2WEmpTeNfZno6MPPny+kYvJFrA6IzRF1Z1WNyAt1YwXuH9X7gFc8scf5CliIZ5
	9hgpe6UDn7K2MDl1S9bsiMn92IOlD189sT3kSoAe5wbJGV2niB/ED5op0teRkuB5hIEJVzd136G
	TA7w29LE3RO8DtpOkVP0YZC8Ed/QjyNmRoPOox+Lu1erQ2QqhgFg==
X-Gm-Gg: Acq92OHnNITiWW4xyI/SQh7ZqjO2iYWFUaoMrHFoQc3y5KGigMbEi/JncO2qQln1rMF
	J+jD3O5duEktbMax8pmgk724JPeseQ8N8ARWJuemJFNx1kKT9/zHX0CMJ4klTMri+8AY+1DUKrT
	a6wKWLQpD5c/6LfvwvSW8eOjG9CEE81w0dqJXuwEb0zwe/hnOEQzAJUZQxiZvu60JepoK+Wg6JK
	xmLMTXtTSPW15VUT54SM1/K+CEZPlAEeHkR2pvvOqUksdZ6S4fEQQ0Y11axgdKMX35j61ykEJl+
	fKhKqGBHRUMKzMlYXdTg+rqS3tZsLdCz1lPPFsL5I2qlxkR5+tXYwrIDzWI8NPk7buSlhTo+l2R
	vZGl4cdu5igNxyrK13CSjospW/ablBED6JBdpsKsctHYJ
X-Received: by 2002:a05:6830:c0b:b0:7e6:de36:3f35 with SMTP id 46e09a7af769-7e90b339c80mr3633543a34.10.1781708417807;
        Wed, 17 Jun 2026 08:00:17 -0700 (PDT)
X-Received: by 2002:a05:6830:c0b:b0:7e6:de36:3f35 with SMTP id 46e09a7af769-7e90b339c80mr3633434a34.10.1781708415813;
        Wed, 17 Jun 2026 08:00:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 11/15] ceph: convert VFS inode and directory paths to bout
Date: Wed, 17 Jun 2026 14:59:41 +0000
Message-Id: <20260617145945.1912736-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
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
 fs/ceph/dir.c    | 290 ++++++++++++++++++++++++++++++++---------------
 fs/ceph/export.c |  83 ++++++++++----
 fs/ceph/inode.c  | 233 +++++++++++++++++++++----------------
 3 files changed, 401 insertions(+), 205 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..9f756d863b76 100644
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
@@ -197,7 +197,7 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 	u64 idx = 0;
 	int err = 0;
 
-	doutc(cl, "%p %llx.%llx v%u at %llx\n", dir, ceph_vinop(dir),
+	boutc(cl, "%p %llx.%llx v%u at %llx\n", dir, ceph_vinop(dir),
 	      (unsigned)shared_gen, ctx->pos);
 
 	/* search start position */
@@ -228,7 +228,7 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			dput(dentry);
 		}
 
-		doutc(cl, "%p %llx.%llx cache idx %llu\n", dir,
+		boutc(cl, "%p %llx.%llx cache idx %llu\n", dir,
 		      ceph_vinop(dir), idx);
 	}
 
@@ -265,8 +265,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		spin_unlock(&dentry->d_lock);
 
 		if (emit_dentry) {
-			doutc(cl, " %llx dentry %p %pd %p\n", di->offset,
-			      dentry, dentry, d_inode(dentry));
+			boutc(cl, " %llx dentry %p %s %p\n", di->offset,
+			      dentry, dentry->d_name.name, d_inode(dentry));
 			ctx->pos = di->offset;
 			if (!dir_emit(ctx, dentry->d_name.name,
 				      dentry->d_name.len, ceph_present_inode(d_inode(dentry)),
@@ -326,19 +326,26 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -349,16 +356,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -374,8 +385,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
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
@@ -404,15 +417,18 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -428,6 +444,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
+				ceph_blog_exit(&__ji);
 				return -ENOMEM;
 			}
 			memcpy(req->r_path2, dfi->last_name, len);
@@ -435,6 +452,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			err = ceph_encode_encrypted_dname(inode, req->r_path2, len);
 			if (err < 0) {
 				ceph_mdsc_put_request(req);
+				ceph_blog_exit(&__ji);
 				return err;
 			}
 		} else if (is_hash_order(ctx->pos)) {
@@ -456,9 +474,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -493,7 +512,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				dfi->dir_ordered_count = req->r_dir_ordered_cnt;
 			}
 		} else {
-			doutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
+			boutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
 			      ceph_vinop(inode));
 			/* disable readdir cache */
 			dfi->readdir_cache_idx = -1;
@@ -512,6 +531,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			if (err) {
 				ceph_mdsc_put_request(dfi->last_readdir);
 				dfi->last_readdir = NULL;
+				ceph_blog_exit(&__ji);
 				return err;
 			}
 		} else if (req->r_reply_info.dir_end) {
@@ -521,7 +541,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	rinfo = &dfi->last_readdir->r_reply_info;
-	doutc(cl, "%p %llx.%llx frag %x num %d pos %llx chunk first %llx\n",
+	boutc(cl, "%p %llx.%llx frag %x num %d pos %llx chunk first %llx\n",
 	      inode, ceph_vinop(inode), dfi->frag, rinfo->dir_nr, ctx->pos,
 	      rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
 
@@ -546,16 +566,19 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			pr_warn_client(cl,
 				"%p %llx.%llx rde->offset 0x%llx ctx->pos 0x%llx\n",
 				inode, ceph_vinop(inode), rde->offset, ctx->pos);
+			ceph_blog_exit(&__ji);
 			return -EIO;
 		}
 
-		if (WARN_ON_ONCE(!rde->inode.in))
+		if (WARN_ON_ONCE(!rde->inode.in)) {
+			ceph_blog_exit(&__ji);
 			return -EIO;
+		}
 
 		ctx->pos = rde->offset;
-		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,
+		boutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,
 		      ceph_vinop(inode), i, rinfo->dir_nr, ctx->pos,
-		      rde->name_len, rde->name, &rde->inode.in);
+		      rde->name_len, (const char *)rde->name, &rde->inode.in);
 
 		if (!dir_emit(ctx, rde->name, rde->name_len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
@@ -566,7 +589,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			 * doesn't have enough memory, etc. So for next readdir
 			 * it will continue.
 			 */
-			doutc(cl, "filldir stopping us...\n");
+			boutc(cl, "filldir stopping us...\n");
+			ceph_blog_exit(&__ji);
 			return 0;
 		}
 
@@ -597,7 +621,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			kfree(dfi->last_name);
 			dfi->last_name = NULL;
 		}
-		doutc(cl, "%p %llx.%llx next frag is %x\n", inode,
+		boutc(cl, "%p %llx.%llx next frag is %x\n", inode,
 		      ceph_vinop(inode), frag);
 		goto more;
 	}
@@ -613,7 +637,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_lock(&ci->i_ceph_lock);
 		if (dfi->dir_ordered_count ==
 				atomic64_read(&ci->i_ordered_count)) {
-			doutc(cl, " marking %p %llx.%llx complete and ordered\n",
+			boutc(cl, " marking %p %llx.%llx complete and ordered\n",
 			      inode, ceph_vinop(inode));
 			/* use i_size to track number of entries in
 			 * readdir cache */
@@ -621,15 +645,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
 
@@ -675,8 +700,12 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
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
@@ -695,7 +724,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	if (offset >= 0) {
 		if (need_reset_readdir(dfi, offset)) {
-			doutc(cl, "%p %llx.%llx dropping %p content\n",
+			boutc(cl, "%p %llx.%llx dropping %p content\n",
 			      inode, ceph_vinop(inode), file);
 			reset_readdir(dfi);
 		} else if (is_hash_order(offset) && offset > file->f_pos) {
@@ -713,6 +742,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 out:
 	inode_unlock(inode);
+	ceph_blog_exit(&__ji);
 	return retval;
 }
 
@@ -733,9 +763,9 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 		struct inode *inode = ceph_get_snapdir(parent);
 
 		res = d_splice_alias(inode, dentry);
-		doutc(cl, "ENOENT on snapdir %p '%pd', linking to "
+		boutc(cl, "ENOENT on snapdir %p '%s', linking to "
 		      "snapdir %p %llx.%llx. Spliced dentry %p\n",
-		      dentry, dentry, inode, ceph_vinop(inode), res);
+		      dentry, dentry->d_name.name, inode, ceph_vinop(inode), res);
 		if (res)
 			dentry = res;
 	}
@@ -762,7 +792,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 		/* no trace? */
 		err = 0;
 		if (!req->r_reply_info.head->is_dentry) {
-			doutc(cl,
+			boutc(cl,
 			      "ENOENT and no trace, dentry %p inode %llx.%llx\n",
 			      dentry, ceph_vinop(d_inode(dentry)));
 			if (d_really_is_positive(dentry)) {
@@ -803,19 +833,26 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	int op;
 	int mask;
 	int err;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%p %llx.%llx/'%pd' dentry %p\n", dir, ceph_vinop(dir),
-	      dentry, dentry);
+	ceph_blog_enter(fsc, &__ji);
 
-	if (dentry->d_name.len > NAME_MAX)
+	boutc(cl, "%p %llx.%llx/'%s' dentry %p\n", dir, ceph_vinop(dir),
+	      dentry->d_name.name, dentry);
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
@@ -828,7 +865,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 		spin_lock(&ci->i_ceph_lock);
-		doutc(cl, " dir %llx.%llx flags are 0x%lx\n",
+		boutc(cl, " dir %llx.%llx flags are 0x%lx\n",
 		      ceph_vinop(dir), ci->i_ceph_flags);
 		if (strncmp(dentry->d_name.name,
 			    fsc->mount_options->snapdir_name,
@@ -839,11 +876,12 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
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
@@ -852,8 +890,10 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
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
 
@@ -879,7 +919,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	}
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
-	doutc(cl, "result=%p\n", dentry);
+	boutc(cl, "result=%p\n", dentry);
+	ceph_blog_exit(&__ji);
 	return dentry;
 }
 
@@ -914,25 +955,33 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
+	struct ceph_journal_info __ji;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_snap(dir) != CEPH_NOSNAP) {
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
+	boutc(cl, "%p %llx.%llx/'%s' dentry %p mode 0%ho rdev %d\n",
+	      dir, ceph_vinop(dir), dentry->d_name.name, dentry, mode, rdev);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -974,13 +1023,21 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	else
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
 static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ceph_mknod(idmap, dir, dentry, mode, 0);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
+	int ret = ceph_mknod(idmap, dir, dentry, mode, 0);
+
+	ceph_blog_exit(&__ji);
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
@@ -1025,26 +1082,34 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
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
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_snap(dir) != CEPH_NOSNAP) {
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
+	boutc(cl, "%p %llx.%llx/'%s' to '%s'\n", dir, ceph_vinop(dir),
+	      dentry->d_name.name, dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -1092,6 +1157,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1099,25 +1165,31 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
+		boutc(cl, "mksnap %llx.%llx/'%s' dentry %p\n",
+		      ceph_vinop(dir), dentry->d_name.name, dentry);
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
-		      ceph_vinop(dir), dentry, dentry, mode);
+		boutc(cl, "mkdir %llx.%llx/'%s' dentry %p mode 0%ho\n",
+		      ceph_vinop(dir), dentry->d_name.name, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
 		ret = ERR_PTR(-EROFS);
@@ -1184,6 +1256,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		d_drop(dentry);
 	}
 	ceph_release_acl_sec_ctx(&as_ctx);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -1191,29 +1264,42 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
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
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_snap(dir) != CEPH_NOSNAP) {
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
+	boutc(cl, "%p %llx.%llx/'%s' to '%s'\n", dir, ceph_vinop(dir),
+	      old_dentry->d_name.name, dentry->d_name.name);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		d_drop(dentry);
+		ceph_blog_exit(&__ji);
 		return PTR_ERR(req);
 	}
 	req->r_dentry = dget(dentry);
@@ -1240,6 +1326,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 		d_instantiate(dentry, d_inode(old_dentry));
 	}
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1348,15 +1435,19 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
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
+		boutc(cl, "rmsnap %llx.%llx/'%s' dn\n", ceph_vinop(dir),
+		      dentry->d_name.name);
 		op = CEPH_MDS_OP_RMSNAP;
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
-		      ceph_vinop(dir), dentry, ceph_vinop(inode));
+		boutc(cl, "unlink/rmdir %llx.%llx/'%s' inode %llx.%llx\n",
+		      ceph_vinop(dir), dentry->d_name.name,
+		      ceph_vinop(inode));
 		op = d_is_dir(dentry) ?
 			CEPH_MDS_OP_RMDIR : CEPH_MDS_OP_UNLINK;
 	} else
@@ -1379,6 +1470,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
 		if (err == -EACCES) {
+			ceph_blog_exit(&__ji);
 			return err;
 		} else if (err < 0) {
 			try_async = false;
@@ -1404,8 +1496,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
-		doutc(cl, "async unlink on %llx.%llx/'%pd' caps=%s",
-		      ceph_vinop(dir), dentry,
+		boutc(cl, "async unlink on %llx.%llx/'%s' caps=%s",
+		      ceph_vinop(dir), dentry->d_name.name,
 		      ceph_cap_string(req->r_dir_caps));
 		set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 		req->r_callback = ceph_async_unlink_cb;
@@ -1465,6 +1557,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	ceph_mdsc_put_request(req);
 out:
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1473,42 +1566,60 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old_dir->i_sb);
+	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int op = CEPH_MDS_OP_RENAME;
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (flags)
+	if (flags) {
+		ceph_blog_exit(&__ji);
 		return -EINVAL;
+	}
 
-	if (ceph_snap(old_dir) != ceph_snap(new_dir))
+	if (ceph_snap(old_dir) != ceph_snap(new_dir)) {
+		ceph_blog_exit(&__ji);
 		return -EXDEV;
+	}
 	if (ceph_snap(old_dir) != CEPH_NOSNAP) {
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
+	boutc(cl, "%llx.%llx/'%s' to %llx.%llx/'%s'\n",
+	      ceph_vinop(old_dir), old_dentry->d_name.name,
+	      ceph_vinop(new_dir), new_dentry->d_name.name);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-	if (IS_ERR(req))
+	if (IS_ERR(req)) {
+		ceph_blog_exit(&__ji);
 		return PTR_ERR(req);
+	}
 	ihold(old_dir);
 	req->r_dentry = dget(new_dentry);
 	req->r_num_caps = 2;
@@ -1537,6 +1648,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		d_move(old_dentry, new_dentry);
 	}
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1553,7 +1665,7 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "%p %p '%pd'\n", di, dn, dn);
+	boutc(cl, "%p %p '%s'\n", di, dn, dn->d_name.name);
 
 	di->flags |= CEPH_DENTRY_LEASE_LIST;
 	if (di->flags & CEPH_DENTRY_SHRINK_LIST) {
@@ -1587,7 +1699,7 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "%p %p '%pd' (offset 0x%llx)\n", di, dn, dn, di->offset);
+	boutc(cl, "%p %p '%s' (offset 0x%llx)\n", di, dn, dn->d_name.name, di->offset);
 
 	if (!list_empty(&di->lease_list)) {
 		if (di->flags & CEPH_DENTRY_LEASE_LIST) {
@@ -1886,7 +1998,7 @@ static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 					 CEPH_MDS_LEASE_RENEW, seq);
 		ceph_put_mds_session(session);
 	}
-	doutc(cl, "dentry %p = %d\n", dentry, valid);
+	boutc(cl, "dentry %p = %d\n", dentry, valid);
 	return valid;
 }
 
@@ -1951,9 +2063,9 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 			valid = 0;
 		spin_unlock(&dentry->d_lock);
 	}
-	doutc(cl, "dir %p %llx.%llx v%u dentry %p '%pd' = %d\n", dir,
+	boutc(cl, "dir %p %llx.%llx v%u dentry %p '%s' = %d\n", dir,
 	      ceph_vinop(dir), (unsigned)atomic_read(&ci->i_shared_gen),
-	      dentry, dentry, valid);
+	      dentry, dentry->d_name.name, valid);
 	return valid;
 }
 
@@ -1974,16 +2086,16 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 
 	inode = d_inode_rcu(dentry);
 
-	doutc(cl, "%p '%pd' inode %p offset 0x%llx nokey %d\n",
-	      dentry, dentry, inode, ceph_dentry(dentry)->offset,
+	boutc(cl, "%p '%s' inode %p offset 0x%llx nokey %d\n",
+	      dentry, dentry->d_name.name, inode, ceph_dentry(dentry)->offset,
 	      !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
-		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
-		      dentry, inode);
+		boutc(cl, "%p '%s' inode %p is SNAPPED\n", dentry,
+		      dentry->d_name.name, inode);
 		valid = 1;
 	} else if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 		valid = 1;
@@ -2040,14 +2152,14 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 				break;
 			}
 			ceph_mdsc_put_request(req);
-			doutc(cl, "%p '%pd', lookup result=%d\n", dentry,
-			      dentry, err);
+			boutc(cl, "%p '%s', lookup result=%d\n", dentry,
+			      dentry->d_name.name, err);
 		}
 	} else {
 		percpu_counter_inc(&mdsc->metric.d_lease_hit);
 	}
 
-	doutc(cl, "%p '%pd' %s\n", dentry, dentry, valid ? "valid" : "invalid");
+	boutc(cl, "%p '%s' %s\n", dentry, dentry->d_name.name, valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
 	return valid;
@@ -2086,7 +2198,7 @@ static void ceph_d_release(struct dentry *dentry)
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 
-	doutc(fsc->client, "dentry %p '%pd'\n", dentry, dentry);
+	doutc(fsc->client, "dentry %p '%s'\n", dentry, dentry->d_name.name);
 
 	atomic64_dec(&fsc->mdsc->metric.total_dentries);
 
@@ -2112,7 +2224,7 @@ static void ceph_d_prune(struct dentry *dentry)
 	struct ceph_inode_info *dir_ci;
 	struct ceph_dentry_info *di;
 
-	doutc(cl, "dentry %p '%pd'\n", dentry, dentry);
+	doutc(cl, "dentry %p '%s'\n", dentry, dentry->d_name.name);
 
 	/* do we have a valid parent? */
 	if (IS_ROOT(dentry))
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af104679..e34a4682df4e 100644
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
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return ceph_encode_snapfh(inode, rawfh, max_len, parent_inode);
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_snap(inode) != CEPH_NOSNAP) {
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
 
 	if (ceph_snap(inode) != CEPH_NOSNAP) {
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
 
@@ -540,7 +576,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 	if (req)
 		ceph_mdsc_put_request(req);
 	kfree(last_name);
-	doutc(fsc->client, "child dentry %p %p %llx.%llx err=%d\n", child,
+	boutc(fsc->client, "child dentry %p %p %llx.%llx err=%d\n", child,
 	      inode, ceph_vinop(inode), err);
 	return err;
 }
@@ -552,17 +588,25 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	struct ceph_mds_request *req;
 	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
+	struct ceph_journal_info __ji;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_snap(inode) != CEPH_NOSNAP) {
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
@@ -602,10 +646,11 @@ static int ceph_get_name(struct dentry *parent, char *name,
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
index 61d7c0b8161f..85e5267f310c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -255,7 +255,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 			inode->i_flags |= S_ENCRYPTED;
 			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
 		} else {
-			doutc(cl, "Failed to alloc snapdir fscrypt_auth\n");
+			boutc(cl, "Failed to alloc snapdir fscrypt_auth\n");
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -333,7 +333,7 @@ static struct ceph_inode_frag *__get_or_create_frag(struct ceph_inode_info *ci,
 	rb_link_node(&frag->node, parent, p);
 	rb_insert_color(&frag->node, &ci->i_fragtree);
 
-	doutc(cl, "added %p %llx.%llx frag %x\n", inode, ceph_vinop(inode), f);
+	boutc(cl, "added %p %llx.%llx frag %x\n", inode, ceph_vinop(inode), f);
 	return frag;
 }
 
@@ -390,7 +390,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 
 		/* choose child */
 		nway = 1 << frag->split_by;
-		doutc(cl, "frag(%x) %x splits by %d (%d ways)\n", v, t,
+		boutc(cl, "frag(%x) %x splits by %d (%d ways)\n", v, t,
 		      frag->split_by, nway);
 		for (i = 0; i < nway; i++) {
 			n = ceph_frag_make_child(t, frag->split_by, i);
@@ -401,7 +401,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 		}
 		BUG_ON(i == nway);
 	}
-	doutc(cl, "frag(%x) = %x\n", v, t);
+	boutc(cl, "frag(%x) = %x\n", v, t);
 
 	return t;
 }
@@ -450,13 +450,13 @@ static int ceph_fill_dirfrag(struct inode *inode,
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
@@ -481,7 +481,7 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	frag->ndist = min_t(u32, ndist, CEPH_MAX_DIRFRAG_REP);
 	for (i = 0; i < frag->ndist; i++)
 		frag->dist[i] = le32_to_cpu(dirinfo->dist[i]);
-	doutc(cl, "%p %llx.%llx frag %x ndist=%d\n", inode,
+	boutc(cl, "%p %llx.%llx frag %x ndist=%d\n", inode,
 	      ceph_vinop(inode), frag->frag, frag->ndist);
 
 out:
@@ -546,7 +546,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		     frag_tree_split_cmp, NULL);
 	}
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	rb_node = rb_first(&ci->i_fragtree);
 	for (i = 0; i < nsplits; i++) {
 		id = le32_to_cpu(fragtree->splits[i].frag);
@@ -586,7 +586,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		if (frag->split_by == 0)
 			ci->i_fragtree_nsplits++;
 		frag->split_by = split_by;
-		doutc(cl, " frag %x split by %d\n", frag->frag, frag->split_by);
+		boutc(cl, " frag %x split by %d\n", frag->frag, frag->split_by);
 		prev_frag = frag;
 	}
 	while (rb_node) {
@@ -734,13 +734,17 @@ void ceph_free_inode(struct inode *inode)
 
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
 
@@ -766,7 +770,7 @@ void ceph_evict_inode(struct inode *inode)
 	 */
 	if (ci->i_snap_realm) {
 		if (ceph_snap(inode) == CEPH_NOSNAP) {
-			doutc(cl, " dropping residual ref to snap realm %p\n",
+			boutc(cl, " dropping residual ref to snap realm %p\n",
 			      ci->i_snap_realm);
 			ceph_change_snap_realm(inode, NULL);
 		} else {
@@ -790,6 +794,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
 	ceph_put_string(rcu_dereference_raw(ci->i_cached_layout.pool_ns));
+	ceph_blog_exit(&__ji);
 }
 
 static inline blkcnt_t calc_inode_blocks(u64 size)
@@ -815,7 +820,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
 	    (truncate_seq == ci->i_truncate_seq && size > isize)) {
-		doutc(cl, "size %lld -> %llu\n", isize, size);
+		boutc(cl, "size %lld -> %llu\n", isize, size);
 		if (size > 0 && S_ISDIR(inode->i_mode)) {
 			pr_err_client(cl, "non-zero size for directory\n");
 			size = 0;
@@ -830,7 +835,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ceph_fscache_update(inode);
 		ci->i_reported_size = size;
 		if (truncate_seq != ci->i_truncate_seq) {
-			doutc(cl, "truncate_seq %u -> %u\n",
+			boutc(cl, "truncate_seq %u -> %u\n",
 			      ci->i_truncate_seq, truncate_seq);
 			ci->i_truncate_seq = truncate_seq;
 
@@ -860,14 +865,14 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	 * anyway.
 	 */
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) >= 0) {
-		doutc(cl, "truncate_size %lld -> %llu, encrypted %d\n",
+		boutc(cl, "truncate_size %lld -> %llu, encrypted %d\n",
 		      ci->i_truncate_size, truncate_size,
 		      !!IS_ENCRYPTED(inode));
 
 		ci->i_truncate_size = truncate_size;
 
 		if (IS_ENCRYPTED(inode)) {
-			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
+			boutc(cl, "truncate_pagecache_size %lld -> %llu\n",
 			      ci->i_truncate_pagecache_size, size);
 			ci->i_truncate_pagecache_size = size;
 		} else {
@@ -968,7 +973,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
+		boutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
 		      time_warp_seq, ci->i_time_warp_seq);
 }
 
@@ -1036,7 +1041,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	lockdep_assert_held(&mdsc->snap_rwsem);
 
-	doutc(cl, "%p ino %llx.%llx v %llu had %llu\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p ino %llx.%llx v %llu had %llu\n", inode, ceph_vinop(inode),
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
@@ -1133,7 +1138,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -1205,7 +1210,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
-			doutc(cl, "max_size %lld -> %llu\n",
+			boutc(cl, "max_size %lld -> %llu\n",
 			    ci->i_max_size, le64_to_cpu(info->max_size));
 			ci->i_max_size = le64_to_cpu(info->max_size);
 		}
@@ -1346,7 +1351,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			    (info_caps & CEPH_CAP_FILE_SHARED) &&
 			    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
 			    !__ceph_dir_is_complete(ci)) {
-				doutc(cl, " marking %p complete (empty)\n",
+				boutc(cl, " marking %p complete (empty)\n",
 				      inode);
 				i_size_write(inode, 0);
 				__ceph_dir_set_complete(ci,
@@ -1356,7 +1361,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 			wake = true;
 		} else {
-			doutc(cl, " %p got snap_caps %s\n", inode,
+			boutc(cl, " %p got snap_caps %s\n", inode,
 			      ceph_cap_string(info_caps));
 			ci->i_snap_caps |= info_caps;
 		}
@@ -1427,7 +1432,7 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
 
-	doutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
+	boutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
 	if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -1566,14 +1571,14 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
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
@@ -1601,11 +1606,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1671,13 +1676,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
 			dn = d_lookup(parent, &dname);
-			doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
-			      parent, dname.len, dname.name, dn);
+			boutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+			      parent, dname.len, (const char *)dname.name, dn);
 
 			if (!dn) {
 				dn = d_alloc(parent, &dname);
-				doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-				      dname.len, dname.name, dn);
+				boutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+				      dname.len, (const char *)dname.name, dn);
 				if (!dn) {
 					dput(parent);
 					ceph_fname_free_buffer(parent_dir, &oname);
@@ -1693,7 +1698,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
-				doutc(cl, " dn %p points to wrong inode %p\n",
+				boutc(cl, " dn %p points to wrong inode %p\n",
 				      dn, d_inode(dn));
 				ceph_dir_clear_ordered(parent_dir);
 				d_delete(dn);
@@ -1771,30 +1776,30 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
 
@@ -1808,9 +1813,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
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
@@ -1839,7 +1844,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				goto done;
 			dn = req->r_dentry;  /* may have spliced */
 		} else if (d_really_is_positive(dn) && d_inode(dn) != in) {
-			doutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
+			boutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
 			      dn, d_inode(dn), ceph_vinop(d_inode(dn)),
 			      ceph_vinop(in));
 			d_invalidate(dn);
@@ -1851,7 +1856,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    rinfo->dlease, session,
 					    req->r_request_started);
 		}
-		doutc(cl, " final dn %p\n", dn);
+		boutc(cl, " final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
 	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
@@ -1862,7 +1867,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!dir);
 		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
 		BUG_ON(!req->r_dentry);
-		doutc(cl, " linking snapped dir %p to dn %p\n", in,
+		boutc(cl, " linking snapped dir %p to dn %p\n", in,
 		      req->r_dentry);
 		ceph_dir_clear_ordered(dir);
 
@@ -1894,7 +1899,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
 	if (unlikely(!IS_ERR_OR_NULL(parent_dir) && parent_dir != req->r_parent))
 		iput(parent_dir);
-	doutc(cl, "done err=%d\n", err);
+	boutc(cl, "done err=%d\n", err);
 	return err;
 }
 
@@ -1920,7 +1925,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
-			doutc(cl, "badness got %d\n", err);
+			boutc(cl, "badness got %d\n", err);
 			continue;
 		}
 		rc = ceph_fill_inode(in, NULL, &rde->inode, NULL, session,
@@ -1987,11 +1992,11 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 
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
@@ -2032,7 +2037,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 	if (rinfo->dir_dir &&
 	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
-		doutc(cl, "got new frag %x -> %x\n", frag,
+		boutc(cl, "got new frag %x -> %x\n", frag,
 			    le32_to_cpu(rinfo->dir_dir->frag));
 		frag = le32_to_cpu(rinfo->dir_dir->frag);
 		if (!rinfo->hash_order)
@@ -2040,10 +2045,10 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
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
 
@@ -2087,15 +2092,15 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 retry_lookup:
 		dn = d_lookup(parent, &dname);
-		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
-		      parent, dname.len, dname.name, dn);
+		boutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+		      parent, dname.len, (const char *)dname.name, dn);
 
 		if (!dn) {
 			dn = d_alloc(parent, &dname);
-			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-			      dname.len, dname.name, dn);
+			boutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+			      dname.len, (const char *)dname.name, dn);
 			if (!dn) {
-				doutc(cl, "d_alloc badness\n");
+				boutc(cl, "d_alloc badness\n");
 				err = -ENOMEM;
 				goto out;
 			}
@@ -2108,7 +2113,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
 			struct ceph_dentry_info *di = ceph_dentry(dn);
-			doutc(cl, " dn %p points to wrong inode %p\n",
+			boutc(cl, " dn %p points to wrong inode %p\n",
 			      dn, d_inode(dn));
 
 			spin_lock(&dn->d_lock);
@@ -2131,7 +2136,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
 			if (IS_ERR(in)) {
-				doutc(cl, "new_inode badness\n");
+				boutc(cl, "new_inode badness\n");
 				d_drop(dn);
 				dput(dn);
 				err = PTR_ERR(in);
@@ -2160,7 +2165,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		if (d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
-				doutc(cl, " skip splicing dn %p to inode %p"
+				boutc(cl, " skip splicing dn %p to inode %p"
 				      " (security xattr deadlock)\n", dn, in);
 				iput(in);
 				skipped++;
@@ -2193,7 +2198,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 	return err;
 }
 
@@ -2204,7 +2209,7 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 	bool ret;
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
+	boutc(cl, "set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
 	i_size_write(inode, size);
 	ceph_fscache_update(inode);
 	inode->i_blocks = calc_inode_blocks(size);
@@ -2225,10 +2230,10 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
 
 	ihold(inode);
 	if (queue_work(fsc->inode_wq, &ci->i_work)) {
-		doutc(cl, "%p %llx.%llx mask=%lx\n", inode,
+		boutc(cl, "%p %llx.%llx mask=%lx\n", inode,
 		      ceph_vinop(inode), ci->i_work_mask);
 	} else {
-		doutc(cl, "%p %llx.%llx already queued, mask=%lx\n",
+		boutc(cl, "%p %llx.%llx already queued, mask=%lx\n",
 		      inode, ceph_vinop(inode), ci->i_work_mask);
 		iput(inode);
 	}
@@ -2256,7 +2261,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	}
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx gen %d revoking %d\n", inode,
+	boutc(cl, "%p %llx.%llx gen %d revoking %d\n", inode,
 	      ceph_vinop(inode), ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
@@ -2276,12 +2281,12 @@ static void ceph_do_invalidate_pages(struct inode *inode)
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
@@ -2309,7 +2314,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_truncate_pending == 0) {
-		doutc(cl, "%p %llx.%llx none pending\n", inode,
+		boutc(cl, "%p %llx.%llx none pending\n", inode,
 		      ceph_vinop(inode));
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
@@ -2322,7 +2327,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
 		spin_unlock(&ci->i_ceph_lock);
-		doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
+		boutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
 		      ceph_vinop(inode));
 		filemap_write_and_wait_range(&inode->i_data, 0,
 					     inode->i_sb->s_maxbytes);
@@ -2334,7 +2339,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 
 	to = ci->i_truncate_pagecache_size;
 	wrbuffer_refs = ci->i_wrbuffer_ref;
-	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
 	      ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -2366,7 +2371,7 @@ static void ceph_inode_work(struct work_struct *work)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
 	if (test_and_clear_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask)) {
-		doutc(cl, "writeback %p %llx.%llx\n", inode, ceph_vinop(inode));
+		boutc(cl, "writeback %p %llx.%llx\n", inode, ceph_vinop(inode));
 		filemap_fdatawrite(&inode->i_data);
 	}
 	if (test_and_clear_bit(CEPH_I_WORK_INVALIDATE_PAGES, &ci->i_work_mask))
@@ -2461,7 +2466,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 
 	issued = __ceph_caps_issued(ci, NULL);
 
-	doutc(cl, "size %lld -> %lld got cap refs on %s, issued %s\n",
+	boutc(cl, "size %lld -> %lld got cap refs on %s, issued %s\n",
 	      i_size, attr->ia_size, ceph_cap_string(got),
 	      ceph_cap_string(issued));
 
@@ -2518,7 +2523,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	 * If the Rados object doesn't exist, it will be set to 0.
 	 */
 	if (!objver) {
-		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
+		boutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
 
 		header.data_len = cpu_to_le32(8 + 8 + 4);
 		header.file_offset = 0;
@@ -2527,7 +2532,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 		header.data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
 		header.file_offset = cpu_to_le64(orig_pos);
 
-		doutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
+		boutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
 		      CEPH_FSCRYPT_BLOCK_SIZE);
 
 		/* truncate and zero out the extra contents for the last block */
@@ -2555,7 +2560,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	}
 	req->r_pagelist = pagelist;
 out:
-	doutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
+	boutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 	if (iov.iov_base)
@@ -2640,7 +2645,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx issued %s\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx issued %s\n", inode, ceph_vinop(inode),
 	      ceph_cap_string(issued));
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 	if (cia && cia->fscrypt_auth) {
@@ -2652,7 +2657,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 			goto out;
 		}
 
-		doutc(cl, "%p %llx.%llx fscrypt_auth len %u to %u)\n", inode,
+		boutc(cl, "%p %llx.%llx fscrypt_auth len %u to %u)\n", inode,
 		      ceph_vinop(inode), ci->fscrypt_auth_len, len);
 
 		/* It should never be re-set once set */
@@ -2683,7 +2688,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_UID) {
 		kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
 
-		doutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
+		boutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
 		      ceph_vinop(inode),
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kuid(&init_user_ns, attr->ia_uid));
@@ -2701,7 +2706,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_GID) {
 		kgid_t fsgid = from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid);
 
-		doutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
+		boutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
 		      ceph_vinop(inode),
 		      from_kgid(&init_user_ns, inode->i_gid),
 		      from_kgid(&init_user_ns, attr->ia_gid));
@@ -2717,7 +2722,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_MODE) {
-		doutc(cl, "%p %llx.%llx mode 0%o -> 0%o\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o -> 0%o\n", inode,
 		      ceph_vinop(inode), inode->i_mode, attr->ia_mode);
 		if (!do_sync && (issued & CEPH_CAP_AUTH_EXCL)) {
 			inode->i_mode = attr->ia_mode;
@@ -2755,7 +2760,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_SIZE) {
-		doutc(cl, "%p %llx.%llx size %lld -> %lld\n", inode,
+		boutc(cl, "%p %llx.%llx size %lld -> %lld\n", inode,
 		      ceph_vinop(inode), isize, attr->ia_size);
 		/*
 		 * Only when the new size is smaller and not aligned to
@@ -2854,7 +2859,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 	if (ia_valid & ATTR_FILE)
-		doutc(cl, "%p %llx.%llx ATTR_FILE ... hrm!\n", inode,
+		boutc(cl, "%p %llx.%llx ATTR_FILE ... hrm!\n", inode,
 		      ceph_vinop(inode));
 
 	if (dirtied) {
@@ -2896,7 +2901,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		 */
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err == -EAGAIN && truncate_retry--) {
-			doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote), retry it!\n",
+			boutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote), retry it!\n",
 			      inode, ceph_vinop(inode), err,
 			      ceph_cap_string(dirtied), mask);
 			ceph_mdsc_put_request(req);
@@ -2905,7 +2910,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		}
 	}
 out:
-	doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote)\n", inode,
+	boutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote)\n", inode,
 	      ceph_vinop(inode), err, ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
@@ -2926,34 +2931,50 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_snap(inode) != CEPH_NOSNAP) {
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
 
@@ -3002,12 +3023,12 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
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
@@ -3035,7 +3056,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		}
 	}
 	ceph_mdsc_put_request(req);
-	doutc(cl, "result=%d\n", err);
+	boutc(cl, "result=%d\n", err);
 	return err;
 }
 
@@ -3073,7 +3094,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 	xattr_value = req->r_reply_info.xattr_info.xattr_value;
 	xattr_value_len = req->r_reply_info.xattr_info.xattr_value_len;
 
-	doutc(cl, "xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
+	boutc(cl, "xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
 
 	err = (int)xattr_value_len;
 	if (size == 0)
@@ -3088,7 +3109,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 put:
 	ceph_mdsc_put_request(req);
 out:
-	doutc(cl, "result=%d\n", err);
+	boutc(cl, "result=%d\n", err);
 	return err;
 }
 
@@ -3100,15 +3121,22 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (mask & MAY_NOT_BLOCK)
+	if (mask & MAY_NOT_BLOCK) {
+		ceph_blog_exit(&__ji);
 		return -ECHILD;
+	}
 
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
 		err = generic_permission(idmap, inode, mask);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3148,21 +3176,29 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct super_block *sb = inode->i_sb;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 valid_mask = STATX_BASIC_STATS;
 	int err = 0;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (ceph_inode_is_shutdown(inode))
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
@@ -3196,8 +3232,10 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			struct inode *parent;
 
 			parent = ceph_lookup_inode(sb, ceph_ino(inode));
-			if (IS_ERR(parent))
+			if (IS_ERR(parent)) {
+				ceph_blog_exit(&__ji);
 				return PTR_ERR(parent);
+			}
 
 			pci = ceph_inode(parent);
 			spin_lock(&pci->i_ceph_lock);
@@ -3230,6 +3268,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_ENCRYPTED);
 
 	stat->result_mask = request_mask & valid_mask;
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
-- 
2.34.1

