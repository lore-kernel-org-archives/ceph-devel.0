Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9A4779BB
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708437; cv=none; b=rUeNDSB/F9Syjqjx6tGgQfuhNijGa70TZFy7E15Y5qeN24RGQKN65oo9Lsll6DkJ4vUCAv9Ze2HEGNzX5Gy7bCiIU6SIlGZkzD7/hS96drZ1W0ImOERVIg+D+oJgWyp46+JQlQHnmI6fchumdZnWbdQZ/DH/QGmUkP6d9d5/mS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708437; c=relaxed/simple;
	bh=orQ+hiyq4wqjHAIu7YQeGR9/AEtfJfRLdtbPySNe7P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDR+uSF4uG3Qzurv1TOY2pRO8hKowcD33ehF91aY0FLyXrQwRIUIECgffNHhBksKnMbOcCsmWpxVzwPPNCTh8nvGNAv/aWkIgmhJ/5OfSu+F/jYHE9mATyt4FIhyyAveruljbNCx+Od4tbCQVJ6tFgHT3s5WYVUWKeVnCj0/1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBGWzr9B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tnqZBXyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBGWzr9B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tnqZBXyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3tvp8kvw1th0IkSM4GPBK3LCx7IPStyJBKJp+RmiK4=;
	b=DBGWzr9Bo0iBPEXjkMV23mlGW4czn1hl8vSxTp80WomraE6W1+CTgixFdDffQhWMsE0IhV
	RE5RvtNpWORVa5nTJeQTP68qlve/gCcKJmIIBhUZNL01eIWm3ghhsQZayt3B+oX/J7kYdU
	MLlmbqjzzFZnHbcKsU1JsE6Tjl2xA7Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-cywmiWsvMgiNjCeZi1O8qQ-1; Wed, 17 Jun 2026 11:00:24 -0400
X-MC-Unique: cywmiWsvMgiNjCeZi1O8qQ-1
X-Mimecast-MFC-AGG-ID: cywmiWsvMgiNjCeZi1O8qQ_1781708424
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6da8558a6so6395721a34.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708423; x=1782313223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3tvp8kvw1th0IkSM4GPBK3LCx7IPStyJBKJp+RmiK4=;
        b=tnqZBXyOXIf45Ps1BmUKJO/wpvBV5Tu0uQwvHeJiTgDZFNYJG7zr9vvFAOPKaab0EU
         289hO7yROhhp42r9XhS8r8POiXUNqErycIFsEHgVS+5RfdijUWU+PY/V5+XYjxnxVvea
         BvH8PmPL7vdAbRxX+g1+wR4CQXkNNSaM2WG/Q6JyMiSnMdSjfPWqde45plJb8E/EBTlm
         rilZk74QGvaecG1Jo8e2VXXetPS2s7HUCj68Mw2GmE5Aplsddl1lLAWm8ry2uxnVBFFp
         N5n6XQt1LEWgn7zYkQbSJxUQ6La3+9083yGxNvIgLJiDee0bIqJ2N0q1miqc9ZpLyZLD
         TFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708423; x=1782313223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3tvp8kvw1th0IkSM4GPBK3LCx7IPStyJBKJp+RmiK4=;
        b=ojr0j6Tqz3KsKjSfzRBneZHLOWSFrUA/i9TUgI9jmhw0t1t6JgX2ZtMd/exTyJRe8M
         KLBDLIY0qzGl0KV0eSLoSCGHLBPKpgUYaN3yIXnADWmpNknFrH1SCEgXdxtW5orqSjMh
         3/q2cJ6uUQcpI3voEfXCrvJSHSX0k3pijnWo2D2Sb+LRB3Ke0Cvk2YHQyAfuQugkBrMJ
         mDVvggPaDJzBjEPuCZQEnVrEcnD27mshnQ+3Ik8kD2uQWFKJfenAVFmASQdwndZnuCEH
         8k4SAK0TAoMXEg+ClZYP8z0tvKNcMB34ao15lI8b0TgR1wa7OJ019w42tZeroL2Wpyeq
         Nkow==
X-Gm-Message-State: AOJu0YyzdJvo4JNRyYuBKB1BkuoycgknWrI4huhhfXivj6NyXLiFIUDh
	3jueUh1nb1p/MGLTUhNdo6oWK/qp9XTSdoClxDOcRIVKUg7wo1faVKo7dt1CZ25VFZdxkgpDYpt
	s8KPhF6cNimlHKtOwjqYjMVoWcaaUQ5dyYvezsXbl4RKeUBAdFdzMeW1wwSZWgxbIIP9kLrJVmO
	Vl1T64CBOdgQKn/iutTB9FsqL+2FrOfvvaebJawbDbqWtED8KGOQ==
X-Gm-Gg: Acq92OGpCQFyFIpQncjEUIttOY9k6PfiBhdgHmHe0pHnjNmxwFAl7SiqWdCah4ezqLV
	UZvwvj3le/jQ3O5T9fHBkgJ8wSXDzozrkxkAzDnwFnCFs1kGJH8l7AGXX2VQLJNjW3ZyDH/8z+6
	RSP+9vb6zLM3Vw4CWo6dLvf1yyCzCJtHZ3t1N11S6+PN+OB1li9jF85PrNSjvFrGxdDy3tBlbmU
	0mipjJrpoBfFVKfYsTcgamzyAOj0I5Qs83jFYvFr+ko2+THl4uQ/kSp/Kqr8/cZag0hEDu6Ezfq
	gE9NGN9NLzv169d5lImsqtI+wJYTo/uU1k1AJMmqeroSgHrPEK463WvHXJsDFRZ+tXY/y/4934l
	nXUVDWsULYo8cDRAjRjoCctsJxqtUvrU7x8n3KvGwCUih
X-Received: by 2002:a05:6830:270f:b0:7e4:de59:41fd with SMTP id 46e09a7af769-7e90b3adbcfmr3582561a34.7.1781708423048;
        Wed, 17 Jun 2026 08:00:23 -0700 (PDT)
X-Received: by 2002:a05:6830:270f:b0:7e4:de59:41fd with SMTP id 46e09a7af769-7e90b3adbcfmr3582514a34.7.1781708422252;
        Wed, 17 Jun 2026 08:00:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 14/15] ceph: convert remaining helper paths to bout
Date: Wed, 17 Jun 2026 14:59:44 +0000
Message-Id: <20260617145945.1912736-15-amarkuze@redhat.com>
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

Replace dout()/doutc() with bout()/boutc() in locks.c, xattr.c,
crypto.c, ioctl.c, mdsmap.c, and quota.c.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/crypto.c | 14 ++++----
 fs/ceph/ioctl.c  |  6 ++--
 fs/ceph/locks.c  | 66 +++++++++++++++++++++++++-----------
 fs/ceph/mdsmap.c |  8 ++---
 fs/ceph/quota.c  |  2 +-
 fs/ceph/xattr.c  | 88 +++++++++++++++++++++++++++++++-----------------
 6 files changed, 119 insertions(+), 65 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 64d240759277..71e7d7594d6f 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -188,7 +188,7 @@ static struct inode *parse_longname(const struct inode *parent,
 	inode_number = name_end + 1;
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", str);
+		boutc(cl, "failed to parse inode number: %s\n", str);
 		return ERR_PTR(ret);
 	}
 
@@ -198,7 +198,7 @@ static struct inode *parse_longname(const struct inode *parent,
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
 		if (IS_ERR(dir))
-			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
+			boutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
 	return dir;
 }
@@ -432,7 +432,7 @@ int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -443,7 +443,7 @@ int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -520,7 +520,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
-		doutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
+		boutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
 		      ceph_vinop(inode));
 		return 0;
 	}
@@ -544,7 +544,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
 						 off + pgsoff, ext->len);
-		doutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
+		boutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
 		      ceph_vinop(inode), i, ext->off, ext->len, fret);
 		if (fret < 0) {
 			if (ret == 0)
@@ -553,7 +553,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		ret = pgsoff + fret;
 	}
-	doutc(cl, "ret %d\n", ret);
+	boutc(cl, "ret %d\n", ret);
 	return ret;
 }
 
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 15cde055f3da..456600f6f34f 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -259,10 +259,10 @@ static long ceph_ioctl_lazyio(struct file *file)
 	spin_unlock(&ci->i_ceph_lock);
 
 	if (is_file_already_lazy) {
-		doutc(cl, "file %p %p %llx.%llx already lazy\n", file, inode,
+		boutc(cl, "file %p %p %llx.%llx already lazy\n", file, inode,
 		      ceph_vinop(inode));
 	} else {
-		doutc(cl, "file %p %p %llx.%llx marked lazy\n", file, inode,
+		boutc(cl, "file %p %p %llx.%llx marked lazy\n", file, inode,
 		      ceph_vinop(inode));
 
 		ceph_check_caps(ci, 0);
@@ -369,7 +369,7 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int ret;
 
-	doutc(fsc->client, "file %p %p %llx.%llx cmd %s arg %lu\n", file,
+	boutc(fsc->client, "file %p %p %llx.%llx cmd %s arg %lu\n", file,
 	      inode, ceph_vinop(inode), ceph_ioctl_cmd_name(cmd), arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
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
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d8e46eb7e5eb..0a76b952102c 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -236,7 +236,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 			*p = info_end;
 		}
 
-		doutc(cl, "%d/%d %lld mds%d.%d %s %s%s\n", i+1, n, global_id,
+		boutc(cl, "%d/%d %lld mds%d.%d %s %s%s\n", i+1, n, global_id,
 		      mds, inc, ceph_pr_addr(&addr),
 		      ceph_mds_state_name(state), laggy ? "(laggy)" : "");
 
@@ -246,7 +246,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		}
 
 		if (state <= 0) {
-			doutc(cl, "got incorrect state(%s)\n",
+			boutc(cl, "got incorrect state(%s)\n",
 			      ceph_mds_state_name(state));
 			continue;
 		}
@@ -410,10 +410,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
 	}
 bad_ext:
-	doutc(cl, "m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
+	boutc(cl, "m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
 	      !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
 	*p = end;
-	doutc(cl, "success epoch %u\n", m->m_epoch);
+	boutc(cl, "success epoch %u\n", m->m_epoch);
 	return m;
 nomem:
 	err = -ENOMEM;
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 053d5bf0c9f0..545b16235188 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -164,7 +164,7 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	}
 
 	if (IS_ERR(in)) {
-		doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->ino,
+		boutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->ino,
 		      PTR_ERR(in));
 		qri->timeout = jiffies + secs_to_jiffies(60); /* XXX */
 	} else {
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 860fc8e1867d..bf0442446dab 100644
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
@@ -655,12 +655,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
 	if (new) {
 		rb_link_node(&xattr->node, parent, p);
 		rb_insert_color(&xattr->node, &ci->i_xattrs.index);
-		doutc(cl, "p=%p\n", p);
+		boutc(cl, "p=%p\n", p);
 	}
 
-	doutc(cl, "added %p %llx.%llx xattr %p %.*s=%.*s%s\n", inode,
-	      ceph_vinop(inode), xattr, name_len, name, min(val_len,
-	      MAX_XATTR_VAL_PRINT_LEN), val,
+	boutc(cl, "added %p %llx.%llx xattr %p %.*s=%.*s%s\n", inode,
+	      ceph_vinop(inode), xattr, name_len, (const char *)name,
+	      min(val_len, MAX_XATTR_VAL_PRINT_LEN), (const char *)val,
 	      val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : "");
 
 	return 0;
@@ -690,13 +690,14 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 		else {
 			int len = min(xattr->val_len, MAX_XATTR_VAL_PRINT_LEN);
 
-			doutc(cl, "%s found %.*s%s\n", name, len, xattr->val,
+			boutc(cl, "%s found %.*s%s\n", name, len,
+			      (const char *)xattr->val,
 			      xattr->val_len > len ? "..." : "");
 			return xattr;
 		}
 	}
 
-	doutc(cl, "%s not found\n", name);
+	boutc(cl, "%s not found\n", name);
 
 	return NULL;
 }
@@ -742,14 +743,14 @@ static char *__copy_xattr_names(struct ceph_inode_info *ci,
 	struct ceph_inode_xattr *xattr = NULL;
 
 	p = rb_first(&ci->i_xattrs.index);
-	doutc(cl, "count=%d\n", ci->i_xattrs.count);
+	boutc(cl, "count=%d\n", ci->i_xattrs.count);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		memcpy(dest, xattr->name, xattr->name_len);
 		dest[xattr->name_len] = '\0';
 
-		doutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
+		boutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
 		      xattr->name_len, ci->i_xattrs.names_size);
 
 		dest += xattr->name_len + 1;
@@ -767,13 +768,14 @@ void __ceph_destroy_xattrs(struct ceph_inode_info *ci)
 
 	p = rb_first(&ci->i_xattrs.index);
 
-	doutc(cl, "p=%p\n", p);
+	boutc(cl, "p=%p\n", p);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		tmp = p;
 		p = rb_next(tmp);
-		doutc(cl, "next p=%p (%.*s)\n", p, xattr->name_len, xattr->name);
+		boutc(cl, "next p=%p (%.*s)\n", p, xattr->name_len,
+		      (const char *)xattr->name);
 		rb_erase(tmp, &ci->i_xattrs.index);
 
 		__free_xattr(xattr);
@@ -802,7 +804,7 @@ static int __build_xattrs(struct inode *inode)
 	int err = 0;
 	int i;
 
-	doutc(cl, "len=%d\n",
+	boutc(cl, "len=%d\n",
 	      ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
 
 	if (ci->i_xattrs.index_version >= ci->i_xattrs.version)
@@ -887,7 +889,7 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 	int size = 4 + ci->i_xattrs.count*(4 + 4) +
 			     ci->i_xattrs.names_size +
 			     ci->i_xattrs.vals_size;
-	doutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
+	boutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
 	      ci->i_xattrs.names_size, ci->i_xattrs.vals_size);
 
 	if (name_size)
@@ -911,7 +913,7 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (ci->i_xattrs.dirty) {
 		int need = __get_required_blob_size(ci, 0, 0);
 
@@ -950,7 +952,8 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 }
 
 static inline int __get_request_mask(struct inode *in) {
-	struct ceph_mds_request *req = current->journal_info;
+	struct ceph_mds_request *req =
+		ceph_current_mds_request(ceph_sb_to_fs_client(in->i_sb));
 	int mask = 0;
 	if (req && req->r_target_inode == in) {
 		if (req->r_op == CEPH_MDS_OP_LOOKUP ||
@@ -969,6 +972,7 @@ static inline int __get_request_mask(struct inode *in) {
 ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		      size_t size)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_inode_xattr *xattr;
@@ -1008,7 +1012,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
 	      ceph_vinop(inode), name, ci->i_xattrs.version,
 	      ci->i_xattrs.index_version);
 
@@ -1018,7 +1022,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		spin_unlock(&ci->i_ceph_lock);
 
 		/* security module gets xattr while filling trace */
-		if (current->journal_info) {
+		if (ceph_current_mds_request(fsc)) {
 			pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1051,7 +1055,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 
 	memcpy(value, xattr->val, xattr->val_len);
 
-	if (current->journal_info &&
+	if (ceph_current_mds_request(fsc) &&
 	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
 	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
 		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
@@ -1063,14 +1067,18 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
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
 
@@ -1078,8 +1086,10 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
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
 
@@ -1100,6 +1110,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = namelen;
 out:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1132,7 +1143,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	doutc(cl, "name %s value size %zu\n", name, size);
+	boutc(cl, "name %s value size %zu\n", name, size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1161,10 +1172,10 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
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
@@ -1175,10 +1186,11 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
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
@@ -1234,7 +1246,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
 	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
-		doutc(cl, "sync version: %llu size: %d max: %llu\n",
+		boutc(cl, "sync version: %llu size: %d max: %llu\n",
 		      ci->i_xattrs.version, required_blob_size,
 		      mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
@@ -1250,7 +1262,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
 	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
@@ -1276,7 +1288,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 		spin_unlock(&ci->i_ceph_lock);
 		ceph_buffer_put(old_blob); /* Shouldn't be required */
-		doutc(cl, " pre-allocating new blob size=%d\n",
+		boutc(cl, " pre-allocating new blob size=%d\n",
 		      required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
@@ -1316,7 +1328,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		up_read(&mdsc->snap_rwsem);
 
 	/* security module set xattr while filling trace */
-	if (current->journal_info) {
+	if (ceph_current_mds_request(fsc)) {
 		pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1345,9 +1357,16 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
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
@@ -1356,9 +1375,16 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
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

