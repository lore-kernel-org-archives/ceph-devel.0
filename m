Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A34A0130
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263877; cv=none; b=R28qDwD1ZGIfdVSi8+fAwK7S0mBNBj0ddonZK+BNKNm+PCG/MlOVQfIHAK7Yqb1ASjBnFpPJGieM3wZ4XaNZ/LidKmJ3f3rZFe5CHMz9fTxrGDLWo4W0MuTpiQyhk5kLSsUHN+SWNUsfBL3WHx130gG+WAgNSOBO/FFp0HKKBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263877; c=relaxed/simple;
	bh=Ehnxt0GySVfSU0ycakgez33qzt/fItpgiBuToPa5i/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAA149QRCwy1hzd/b33BA9oan/i5s4wdPDzplTgguEiFT6rAWoPY56/5IinTxa+VjHnLRD/nNRKKXQHaw9e/1+mNISC0PJ3l8rmJJiOzwlDq3ydZW3C4vcwnXiUqxP9vRpvMuXtm8GXNRRx4l5lGcWwL2kGHw/t02rtKCBvHSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXNVa0do; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lc8Vj3/S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXNVa0do";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lc8Vj3/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9NIb+PA+5f7OZn884FAK7TMBs9FAWKWFK4wcAGDXp4=;
	b=VXNVa0dols59TOF3lHZoh/HZU3vT03Aao2BnCsWaVXKMkvmBuO5hfY1MiVA1MxzM8APg5e
	piA34CNPKhUndwoZBSU+DOABvQbjPyNI2PpQsg6KFTwvlgFrN6pDKfRfjVBJeJ077fDl47
	fiQE0lvdrnGSB08st0ggMJ26vbFPX28=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-pv29XYhvNS6zWuozlaNoiw-1; Thu, 24 Sep 2026 11:31:12 -0400
X-MC-Unique: pv29XYhvNS6zWuozlaNoiw-1
X-Mimecast-MFC-AGG-ID: pv29XYhvNS6zWuozlaNoiw_1790263871
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6aa734a7228so2611822a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263871; x=1790868671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9NIb+PA+5f7OZn884FAK7TMBs9FAWKWFK4wcAGDXp4=;
        b=lc8Vj3/SQarDKE1nu6pVRisss8K/zotLgXKVufi9F+0mxa2fT2HQ2nk6bga1ONl5pn
         4y9P5EqKTDAcN0NzX4zIz5o61uj3WNLsTSbqu/OcczUcIZgym7RVheg0gJpaeejUySfp
         DyT6ky3DWMJynvgdJaMLts+XFOtsh+RVbp3mTEujPWB2ROwf84uWgZjtVB+AnjJrpX2Q
         8gLWFnr1JtAMQ8zjUA47KVTfa8Q4pjN/WoikI4dEqMbI5KHhI0W81Ez+PFEibcvEiqq5
         GmqJhTPetB8EPaeBbQbP+Xt3fSC0NwgB3WfdJcic98fOz+W3rSSyNGi//lAp7HPt8+/V
         hvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263871; x=1790868671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9NIb+PA+5f7OZn884FAK7TMBs9FAWKWFK4wcAGDXp4=;
        b=XXufsYW97RmP5K1alE5NuNIAQ55xDWITVRGWs9lLeSEVHSxEDpj9A5u9xlxqReF7om
         hiZADOSPQm+MxOlRxgqXoZYqOX5lQUAibWPDiu6xtZW6vDqyLZHHd/6TtqKF3JspiuR9
         D0aIdHBfQWRhAZ+dLfr2WDh4eYpwv3TpzDvnMVv6SeiLgKTOPgNOW71N62Aft+9v332b
         BotCmYhtdKBi9pLc3QkNyCHfmyqzJlZUipFX71UitATZPN9O8bwD6TyBGKymMIV6qctk
         7nFTL73xVs1LuG53HuOsxBfUSkrNake0is4DW6Ia3H0OBKEhMLNBKFKY77EAgihYUVee
         zz6Q==
X-Gm-Message-State: AFuF++lClM+J1WJ5nUNFTmjLYgGPjSF2qUWcFaMLmXN6oIcLS+OZzpvP
	YyMYzDnSObKaLI9l6JPSxDgzqNcptNARp05lKP58+QI2F80w3ke4CrkPz2G1dxfOsol5FfGhK7K
	GRrRxyzU/AUHd8n5UEo8YDEF9qTejuz7YbP6TXJKXdwTYmeIpWFUI0G6fR2SZsaRQdHOgIk5jm3
	7FdAuPngduBRjgQykxVeAl9Yc3lsNdfYBJDIcCkokLBMQna2uOQA==
X-Gm-Gg: AYBFou0lsNAeVeXsXewigOvBE1yNey20yNwUmhPULDD59wly1ix+QxShOZqLPsMaO0B
	ljY8qyh1Rs7Hoq3641kblrziHIJknaeyXM1ZSmWZwuZnL7hD10CY48gZCjmaXqaTKySiC5N9tR7
	75SqkZpM5GgAoatYC8HhdzxVOgRjF7mcNRgmKNqZGU/WFXtDtIaSuZEXsY8DyrnT/XqfjFDag5S
	zJ0PJrmG7Yp58BWEy7dVUfdkHBkiP1enWVM+WF1sQk3kfsYUfK701cakL53cfeh+Cj2JEmIHBzj
	ICfMvMOAWcrcpjZGGnjZ9Xn2Z+6OgNXtJoAyiE+f2pT79XAffst5QGKtQwTWS9IYy5fMbiTgKu3
	sQMeCPDRjLUSECgD44x+KUk0L8o60riCYQDy6jrvUJIl4t3EnbA5RTH6/f4Yb1my7BvKgIz+/7I
	mhsxMCQUpINTBpDA==
X-Received: by 2002:a05:6402:401a:b0:6aa:c767:ab47 with SMTP id 4fb4d7f45d1cf-6aacc856793mr2527168a12.35.1790263870377;
        Thu, 24 Sep 2026 08:31:10 -0700 (PDT)
X-Received: by 2002:a05:6402:401a:b0:6aa:c767:ab47 with SMTP id 4fb4d7f45d1cf-6aacc856793mr2527121a12.35.1790263869777;
        Thu, 24 Sep 2026 08:31:09 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:31:08 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 14/14] ceph: convert remaining helper paths to BLOG logging
Date: Thu, 24 Sep 2026 15:30:44 +0000
Message-Id: <20260924153045.994784-15-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
References: <20260924153045.994784-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace text debug logging with the boutc() wrappers in locks.c,
xattr.c, and crypto.c.

Do not log borrowed xattr names while destroying an invalidated
index. Snapshot encoding can replace and free the backing blob
before the index is destroyed, making even a bounded name read
unsafe. Log only the live index-node pointers at that site.

When copying xattr names, log the terminated destination and the
xattr pointer. Names borrowed from the blob are length-delimited
and must not be passed to an unbounded %s. Both text logging bugs
predate BLOG; eager binary argument capture also exposes them.

Keep encrypted-name logging within the supplied name bounds too.
On a long snapshot-name lookup failure, log the existing terminated
copy with its leading underscore restored, rather than the counted
input. Base64 encoding does not append a terminator: use BLOG_STR
with the encoded length, since format precision only bounds the
text path and does not constrain binary argument capture.

Reported-by: Xiubo Li <xiubo.li@clyso.com>
Link: https://lore.kernel.org/ceph-devel/CAOJNxRJTiUkSAW6diKfZA51mGMCeGdKsbcb5mdkYxqf+-+e8fQ@mail.gmail.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 fs/ceph/crypto.c |  19 ++++-----
 fs/ceph/locks.c  |  66 ++++++++++++++++++++++---------
 fs/ceph/xattr.c  | 101 +++++++++++++++++++++++++++++++----------------
 3 files changed, 124 insertions(+), 62 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index a7883336e6a1..de349397fc47 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -181,7 +181,7 @@ static struct inode *parse_longname(const struct inode *parent,
 		return ERR_PTR(-ENOMEM);
 	name_end = strrchr(str, '_');
 	if (!name_end) {
-		doutc(cl, "failed to parse long snapshot name: %s\n", str);
+		boutc(cl, "failed to parse long snapshot name: %s\n", str);
 		return ERR_PTR(-EIO);
 	}
 	*name_len = (name_end - str);
@@ -194,7 +194,7 @@ static struct inode *parse_longname(const struct inode *parent,
 	inode_number = name_end + 1;
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", str);
+		boutc(cl, "failed to parse inode number: %s\n", str);
 		return ERR_PTR(ret);
 	}
 
@@ -204,7 +204,7 @@ static struct inode *parse_longname(const struct inode *parent,
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
 		if (IS_ERR(dir))
-			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
+			boutc(cl, "can't find inode %s (_%s)\n", inode_number, str);
 	}
 	return dir;
 }
@@ -275,7 +275,8 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* base64 encode the encrypted name */
 	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
-	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
+	boutc_bounded(cl, "base64-encoded ciphertext name = %.*s\n",
+		      (elen, BLOG_STR(p, elen)), (elen, (const char *)p));
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
@@ -491,7 +492,7 @@ int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -502,7 +503,7 @@ int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -579,7 +580,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
-		doutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
+		boutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
 		      ceph_vinop(inode));
 		return 0;
 	}
@@ -603,7 +604,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
 						 off + pgsoff, ext->len);
-		doutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
+		boutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
 		      ceph_vinop(inode), i, ext->off, ext->len, fret);
 		if (fret < 0) {
 			if (ret == 0)
@@ -612,7 +613,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		ret = pgsoff + fret;
 	}
-	doutc(cl, "ret %d\n", ret);
+	boutc(cl, "ret %d\n", ret);
 	return ret;
 }
 
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e0..a0c946e5890e 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -110,7 +110,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	owner = secure_addr(fl->c.flc_owner);
 
-	doutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
+	boutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
 		    "start: %llu, length: %llu, wait: %d, type: %d\n",
 		    (int)lock_type, (int)operation, owner,
 		    (u64) fl->c.flc_pid,
@@ -147,7 +147,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	}
 	ceph_mdsc_put_request(req);
-	doutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
+	boutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
 	      "length: %llu, wait: %d, type: %d, err code %d\n",
 	      (int)lock_type, (int)operation, (u64) fl->c.flc_pid,
 	      fl->fl_start, length, wait, fl->c.flc_type, err);
@@ -175,7 +175,7 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (!err)
 		return 0;
 
-	doutc(cl, "request %llu was interrupted\n", req->r_tid);
+	boutc(cl, "request %llu was interrupted\n", req->r_tid);
 
 	mutex_lock(&mdsc->mutex);
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
@@ -248,6 +248,7 @@ static int try_unlock_file(struct file *file, struct file_lock *fl)
 int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
@@ -255,14 +256,21 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
 	u8 wait = 0;
 	u8 lock_cmd;
+	struct ceph_journal_info __ji;
 
-	if (!(fl->c.flc_flags & FL_POSIX))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (!(fl->c.flc_flags & FL_POSIX)) {
+		ceph_blog_exit(&__ji);
 		return -ENOLCK;
+	}
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
-	doutc(cl, "fl_owner: %p\n", fl->c.flc_owner);
+	boutc(cl, "fl_owner: %p\n", fl->c.flc_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -273,14 +281,17 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
 			posix_lock_file(file, fl, NULL);
+		ceph_blog_exit(&__ji);
 		return -EIO;
 	}
 
 	/* Wait for reset to complete before acquiring new locks */
 	if (op == CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
 		err = ceph_mdsc_wait_for_reset(mdsc);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
 	if (lock_is_read(fl))
@@ -292,14 +303,16 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl)) {
 		err = try_unlock_file(file, fl);
-		if (err <= 0)
+		if (err <= 0) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->c.flc_type) {
-			doutc(cl, "locking locally\n");
+			boutc(cl, "locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
 				/* undo! This should only happen if
@@ -307,43 +320,55 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 				 * deadlock. */
 				ceph_lock_message(CEPH_LOCK_FCNTL, op, inode,
 						  CEPH_LOCK_UNLOCK, 0, fl);
-				doutc(cl, "got %d on posix_lock_file, undid lock\n",
+				boutc(cl, "got %d on posix_lock_file, undid lock\n",
 				      err);
 			}
 		}
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
 int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u8 wait = 0;
 	u8 lock_cmd;
+	struct ceph_journal_info __ji;
 
-	if (!(fl->c.flc_flags & FL_FLOCK))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (!(fl->c.flc_flags & FL_FLOCK)) {
+		ceph_blog_exit(&__ji);
 		return -ENOLCK;
+	}
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
-	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
+	boutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		if (lock_is_unlock(fl))
 			locks_lock_file_wait(file, fl);
+		ceph_blog_exit(&__ji);
 		return -EIO;
 	}
 
 	/* Wait for reset to complete before acquiring new locks */
 	if (!lock_is_unlock(fl)) {
 		err = ceph_mdsc_wait_for_reset(mdsc);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
 	if (IS_SETLKW(cmd))
@@ -358,8 +383,10 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (lock_is_unlock(fl)) {
 		err = try_unlock_file(file, fl);
-		if (err <= 0)
+		if (err <= 0) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
 	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
@@ -370,10 +397,11 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 			ceph_lock_message(CEPH_LOCK_FLOCK,
 					  CEPH_MDS_OP_SETFILELOCK,
 					  inode, CEPH_LOCK_UNLOCK, 0, fl);
-			doutc(cl, "got %d on locks_lock_file_wait, undid lock\n",
+			boutc(cl, "got %d on locks_lock_file_wait, undid lock\n",
 			      err);
 		}
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -399,7 +427,7 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
-	doutc(cl, "counted %d flock locks and %d fcntl locks\n",
+	boutc(cl, "counted %d flock locks and %d fcntl locks\n",
 	      *flock_count, *fcntl_count);
 }
 
@@ -430,7 +458,7 @@ static int lock_to_ceph_filelock(struct inode *inode,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		doutc(cl, "Have unknown lock type %d\n",
+		boutc(cl, "Have unknown lock type %d\n",
 		      lock->c.flc_type);
 		err = -EINVAL;
 	}
@@ -455,7 +483,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 	int seen_flock = 0;
 	int l = 0;
 
-	doutc(cl, "encoding %d flock and %d fcntl locks\n", num_flock_locks,
+	boutc(cl, "encoding %d flock and %d fcntl locks\n", num_flock_locks,
 	      num_fcntl_locks);
 
 	if (!ctx)
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 1da6deea2c24..39dbbcc287c0 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -70,7 +70,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
-	doutc(cl, "%p\n", &ci->netfs.inode);
+	boutc(cl, "%p\n", &ci->netfs.inode);
 	down_read(&osdc->lock);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
 	if (pool_name) {
@@ -627,7 +627,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		xattr->should_free_name = update_xattr;
 
 		ci->i_xattrs.count++;
-		doutc(cl, "count=%d\n", ci->i_xattrs.count);
+		boutc(cl, "count=%d\n", ci->i_xattrs.count);
 	} else {
 		kfree(*newxattr);
 		*newxattr = NULL;
@@ -655,13 +655,19 @@ static int __set_xattr(struct ceph_inode_info *ci,
 	if (new) {
 		rb_link_node(&xattr->node, parent, p);
 		rb_insert_color(&xattr->node, &ci->i_xattrs.index);
-		doutc(cl, "p=%p\n", p);
+		boutc(cl, "p=%p\n", p);
 	}
 
-	doutc(cl, "added %p %llx.%llx xattr %p %.*s=%.*s%s\n", inode,
-	      ceph_vinop(inode), xattr, name_len, name, min(val_len,
-	      MAX_XATTR_VAL_PRINT_LEN), val,
-	      val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : "");
+	boutc_bounded(cl, "added %p %llx.%llx xattr %p %.*s=%.*s%s\n",
+		      (inode, ceph_vinop(inode), xattr, name_len,
+		       BLOG_STR(name, name_len),
+		       min(val_len, MAX_XATTR_VAL_PRINT_LEN),
+		       BLOG_STR(val, min(val_len, MAX_XATTR_VAL_PRINT_LEN)),
+		       val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : ""),
+		      (inode, ceph_vinop(inode), xattr, name_len,
+		       (const char *)name,
+		       min(val_len, MAX_XATTR_VAL_PRINT_LEN), (const char *)val,
+		       val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : ""));
 
 	return 0;
 }
@@ -690,13 +696,16 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 		else {
 			int len = min(xattr->val_len, MAX_XATTR_VAL_PRINT_LEN);
 
-			doutc(cl, "%s found %.*s%s\n", name, len, xattr->val,
-			      xattr->val_len > len ? "..." : "");
+			boutc_bounded(cl, "%s found %.*s%s\n",
+				      (name, len, BLOG_STR(xattr->val, len),
+				       xattr->val_len > len ? "..." : ""),
+				      (name, len, (const char *)xattr->val,
+				       xattr->val_len > len ? "..." : ""));
 			return xattr;
 		}
 	}
 
-	doutc(cl, "%s not found\n", name);
+	boutc(cl, "%s not found\n", name);
 
 	return NULL;
 }
@@ -742,14 +751,14 @@ static char *__copy_xattr_names(struct ceph_inode_info *ci,
 	struct ceph_inode_xattr *xattr = NULL;
 
 	p = rb_first(&ci->i_xattrs.index);
-	doutc(cl, "count=%d\n", ci->i_xattrs.count);
+	boutc(cl, "count=%d\n", ci->i_xattrs.count);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		memcpy(dest, xattr->name, xattr->name_len);
 		dest[xattr->name_len] = '\0';
 
-		doutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
+		boutc(cl, "dest=%s xattr=%p (%d/%d)\n", dest, xattr,
 		      xattr->name_len, ci->i_xattrs.names_size);
 
 		dest += xattr->name_len + 1;
@@ -767,13 +776,14 @@ void __ceph_destroy_xattrs(struct ceph_inode_info *ci)
 
 	p = rb_first(&ci->i_xattrs.index);
 
-	doutc(cl, "p=%p\n", p);
+	boutc(cl, "p=%p\n", p);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		tmp = p;
 		p = rb_next(tmp);
-		doutc(cl, "next p=%p (%.*s)\n", p, xattr->name_len, xattr->name);
+		/* Names borrowed from an older blob may already be stale. */
+		boutc(cl, "next p=%p xattr=%p\n", p, xattr);
 		rb_erase(tmp, &ci->i_xattrs.index);
 
 		__free_xattr(xattr);
@@ -802,7 +812,7 @@ static int __build_xattrs(struct inode *inode)
 	int err = 0;
 	int i;
 
-	doutc(cl, "len=%d\n",
+	boutc(cl, "len=%d\n",
 	      ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
 
 	if (ci->i_xattrs.index_version >= ci->i_xattrs.version)
@@ -888,7 +898,7 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 	int size = 4 + ci->i_xattrs.count*(4 + 4) +
 			     ci->i_xattrs.names_size +
 			     ci->i_xattrs.vals_size;
-	doutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
+	boutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
 	      ci->i_xattrs.names_size, ci->i_xattrs.vals_size);
 
 	if (name_size)
@@ -912,7 +922,7 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (ci->i_xattrs.dirty) {
 		int need = __get_required_blob_size(ci, 0, 0);
 
@@ -951,7 +961,8 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 }
 
 static inline int __get_request_mask(struct inode *in) {
-	struct ceph_mds_request *req = current->journal_info;
+	struct ceph_mds_request *req =
+		ceph_current_mds_request(ceph_sb_to_fs_client(in->i_sb));
 	int mask = 0;
 	if (req && req->r_target_inode == in) {
 		if (req->r_op == CEPH_MDS_OP_LOOKUP ||
@@ -1009,7 +1020,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
 	      ceph_vinop(inode), name, ci->i_xattrs.version,
 	      ci->i_xattrs.index_version);
 
@@ -1019,7 +1030,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		spin_unlock(&ci->i_ceph_lock);
 
 		/* security module gets xattr while filling trace */
-		if (current->journal_info) {
+		if (ceph_current_fill_trace_request()) {
 			pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1052,7 +1063,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 
 	memcpy(value, xattr->val, xattr->val_len);
 
-	if (current->journal_info &&
+	if (ceph_current_fill_trace_request() &&
 	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
 	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
 		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
@@ -1064,14 +1075,18 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool len_only = (size == 0);
 	u32 namelen;
 	int err;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx ver=%lld index_ver=%lld\n", inode,
+	boutc(cl, "%p %llx.%llx ver=%lld index_ver=%lld\n", inode,
 	      ceph_vinop(inode), ci->i_xattrs.version,
 	      ci->i_xattrs.index_version);
 
@@ -1079,8 +1094,10 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	    !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)) {
 		spin_unlock(&ci->i_ceph_lock);
 		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 		spin_lock(&ci->i_ceph_lock);
 	}
 
@@ -1101,6 +1118,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = namelen;
 out:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1133,7 +1151,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	doutc(cl, "name %s value size %zu\n", name, size);
+	boutc(cl, "name %s value size %zu\n", name, size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1162,10 +1180,10 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	req->r_num_caps = 1;
 	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
 
-	doutc(cl, "xattr.ver (before): %lld\n", ci->i_xattrs.version);
+	boutc(cl, "xattr.ver (before): %lld\n", ci->i_xattrs.version);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
-	doutc(cl, "xattr.ver (after): %lld\n", ci->i_xattrs.version);
+	boutc(cl, "xattr.ver (after): %lld\n", ci->i_xattrs.version);
 
 out:
 	if (pagelist)
@@ -1176,10 +1194,11 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 int __ceph_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct ceph_buffer *old_blob = NULL;
 	int issued;
@@ -1235,7 +1254,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
 	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
-		doutc(cl, "sync version: %llu size: %d max: %llu\n",
+		boutc(cl, "sync version: %llu size: %d max: %llu\n",
 		      ci->i_xattrs.version, required_blob_size,
 		      mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
@@ -1251,7 +1270,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
 	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
@@ -1266,7 +1285,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	 */
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
-		doutc(cl, "sync (size too large): %d > %llu\n",
+		boutc(cl, "sync (size too large): %d > %llu\n",
 		      required_blob_size, mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
 	}
@@ -1277,7 +1296,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 		spin_unlock(&ci->i_ceph_lock);
 		ceph_buffer_put(old_blob); /* Shouldn't be required */
-		doutc(cl, " pre-allocating new blob size=%d\n",
+		boutc(cl, " pre-allocating new blob size=%d\n",
 		      required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
@@ -1317,7 +1336,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		up_read(&mdsc->snap_rwsem);
 
 	/* security module set xattr while filling trace */
-	if (current->journal_info) {
+	if (ceph_current_fill_trace_request()) {
 		pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1346,9 +1365,16 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 				  struct dentry *dentry, struct inode *inode,
 				  const char *name, void *value, size_t size)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_journal_info __ji;
+	int ret;
+
 	if (!ceph_is_valid_xattr(name))
 		return -EOPNOTSUPP;
-	return __ceph_getxattr(inode, name, value, size);
+	ceph_blog_enter(fsc, &__ji);
+	ret = __ceph_getxattr(inode, name, value, size);
+	ceph_blog_exit(&__ji);
+	return ret;
 }
 
 static int ceph_set_xattr_handler(const struct xattr_handler *handler,
@@ -1357,9 +1383,16 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
 				  const char *name, const void *value,
 				  size_t size, int flags)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_journal_info __ji;
+	int ret;
+
 	if (!ceph_is_valid_xattr(name))
 		return -EOPNOTSUPP;
-	return __ceph_setxattr(inode, name, value, size, flags);
+	ceph_blog_enter(fsc, &__ji);
+	ret = __ceph_setxattr(inode, name, value, size, flags);
+	ceph_blog_exit(&__ji);
+	return ret;
 }
 
 static const struct xattr_handler ceph_other_xattr_handler = {
-- 
2.34.1

