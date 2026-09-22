Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22441BA72
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085693; cv=none; b=ZMM+aMp26ZWzSbqXCopnN6td/9UgsfYUycneiJpWuMzdusmJ01eL+i/M4aLeu+Ngw69Su942iHXTofY5G8NPkAPOfHJoA9OG29G+QJO/u8Q0EyJJ+K6qbJIQ1QTib8YZ+oOiGHCIle5Ei8J/rCuhOwaEmScTvr5MYtDfw/uFNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085693; c=relaxed/simple;
	bh=Aov4P69267UEU6UUrWxlLd0PIuA6n0tNrYqgl7yWKBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOOuh58fmthWqtDoMt/jKba+PQ/+VsRNeoPAqCZ5EIEo025B+HVhvKVM7myWCHxHk6gsRb7EEKcdD24dF9HqBXRcTPlhdaF3M5ZfwtENIiXW4US/LbyesWhtG/2OATKe6Z7EdB7KqEoZ0DuuQVzxqfThGc4iukAOXADc51J6G4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NayHAg6H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jk7BHe+O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NayHAg6H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jk7BHe+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpiMO+ggs6mMQGbuE6XJf4iqOs17osXnH6zQ/0ziyi8=;
	b=NayHAg6H6Wa/85gfTrJVe4nvrHSfFKkPp9iSqgVGGdpgdVDhANrfUPxQhFAfjthdp2tDE8
	nYvV3E1bG2UJlW8RWVFk2/YTCKKdDe9FAzMjKhZKMmTzwPAXiLw0qg5dVOFLkVe03G1DfO
	6y04gEuz1wvqS9T1/Q4IbR1d8c5OVhE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-qPwLKuJbOPK2Nz7fWYNSAw-1; Tue, 22 Sep 2026 10:01:28 -0400
X-MC-Unique: qPwLKuJbOPK2Nz7fWYNSAw-1
X-Mimecast-MFC-AGG-ID: qPwLKuJbOPK2Nz7fWYNSAw_1790085686
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so648971485a.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085686; x=1790690486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpiMO+ggs6mMQGbuE6XJf4iqOs17osXnH6zQ/0ziyi8=;
        b=Jk7BHe+OXFLe7SzIUuYTTIqCuuRwdpRKvHehAq6uero3Vmz4XN0QOycZcy55XaKywd
         0S1jPbjdDqi1OPVVsP6y5/rNe69hXhWIZ8JPKmUXsJknUw4rOsPcQ1OaN35V5MPtzfRp
         iiwef/hoGt7KC8A2MkJDjsTkqy5P0I47uFmux83A9J9XVsxa2/YqgeRbjEaqvnGAzduC
         9PGLQOxomjypNKEXOmRfMF1GtwQIaMzv73a4yyaBfjj/pFxKjyWd781AURp0LGsGyMAR
         BPEKvf4A1ZOLVLE1o05ZHCsPQgU7sT8M2wwCRrT1buCr5SBU14D9F5qWgsFNQOY9JSF3
         XlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085686; x=1790690486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TpiMO+ggs6mMQGbuE6XJf4iqOs17osXnH6zQ/0ziyi8=;
        b=l2DEPHGjDKwl/EpKn6kt7Ee411tubG9BnaDLRa5CjlOTLtYQi308aUaekAv3UlPu75
         8laDt2omp5rjkD50F7+twt0EAXQA62kvVT7YPBcnGIpyBDfKrK0tkfDUCj8rnWpy9ox7
         Uzj7UGE6Od4M/bF1X0+zCsNcOhHdHO7mZUa9w0RXjMTW0dCiagixb1Zv+9hLwikdqrxB
         XEcqRJX3+ppuZFDkTku4OyEgfl25Da74oPLEQ9iFzmX6dU1CzM/WFjFUfa/MBf2lvsFv
         718O0ssmu5Jo6APNTs2quBlZIT9mkCoYYdCYY+dd2M+DRlLrYHnadVxrkYOPW0n+u+Ib
         Xtow==
X-Gm-Message-State: AFuF++n45J2CFIIgA3WRIkP1GLS2UlslENVefeZyVGPZGq1P1x/rJ7AD
	/ZwLLGv7uyU35JY1poxOpxx0/EWiKqCAcVdKhgKWLWUT7jaN3D6NvenhuziK7/QLmkY88eZ4Uqn
	PuzcPsMzRlivDth7msaR7KcI+9GjNCH/HSqVu+LB+xjP2nlBS3jrSd+FUZ1MXOO+81m0LaXXW5w
	+Lqn4D3RiWMQqxmUFW78rIK/wpHFRNT7gUuVSE9FRqTYNifa52ew==
X-Gm-Gg: AYBFou3h08YZXdTg1rS7USRQHPc+WCGnGJE1wFCpo0hYAUm43BODJM2LfksMiQMq8L4
	y8yDvLt2eu2ORDpWC8OpBOfmi78Ae7qv+j++e9s+BsCN4EBCW2LMyqtm4nPpiJwhDVinltz0f4s
	GeGgrb834a5uaWpu4l5iIJfBuAr8JntifTg+u9I2LwgRO9j94gSB29NATeLrf2sLNcO7M/HOWWc
	263IoT7bjy45q5svMsbPSd17m6mVNLn+55k7vCX90XIEsGm0HpJpDRYeZyjqDQG1TPTiL+dJdtV
	wRHWocDnu8RfwIbLjK3LPxYIZGFbwIG6wL7Xa4yIxrI2xUSLam7CfEI8VKg7EPAKXpzLZFiZ7yE
	sk6oIBc+TkPnWpQzs9sbxYaZiDznjeaqrSsDN1949NVbsvWIyxyd4O/U5Y4Tv2NYAUDfkWvc7RO
	b7rQ1qUbhOpJWAtQ==
X-Received: by 2002:a05:620a:171f:b0:93b:eed8:3a52 with SMTP id af79cd13be357-93c15d764b6mr625360185a.3.1790085685849;
        Tue, 22 Sep 2026 07:01:25 -0700 (PDT)
X-Received: by 2002:a05:620a:171f:b0:93b:eed8:3a52 with SMTP id af79cd13be357-93c15d764b6mr625344685a.3.1790085683568;
        Tue, 22 Sep 2026 07:01:23 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 14/14] ceph: convert remaining helper paths to BLOG logging
Date: Tue, 22 Sep 2026 14:00:47 +0000
Message-Id: <20260922140047.794405-15-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922140047.794405-1-amarkuze@redhat.com>
References: <20260922140047.794405-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace text debug logging with the boutc() wrappers in locks.c,
xattr.c, and crypto.c.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/crypto.c |  18 ++++----
 fs/ceph/locks.c  |  66 +++++++++++++++++++++---------
 fs/ceph/xattr.c  | 104 +++++++++++++++++++++++++++++++----------------
 3 files changed, 126 insertions(+), 62 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index a7883336e6a1..569ef52c38b0 100644
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
+			boutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
 	return dir;
 }
@@ -275,7 +275,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* base64 encode the encrypted name */
 	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
-	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
+	boutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
@@ -491,7 +491,7 @@ int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -502,7 +502,7 @@ int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -579,7 +579,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
-		doutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
+		boutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
 		      ceph_vinop(inode));
 		return 0;
 	}
@@ -603,7 +603,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
 						 off + pgsoff, ext->len);
-		doutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
+		boutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
 		      ceph_vinop(inode), i, ext->off, ext->len, fret);
 		if (fret < 0) {
 			if (ret == 0)
@@ -612,7 +612,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
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
index 1da6deea2c24..c085b055209d 100644
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
+		boutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
 		      xattr->name_len, ci->i_xattrs.names_size);
 
 		dest += xattr->name_len + 1;
@@ -767,13 +776,17 @@ void __ceph_destroy_xattrs(struct ceph_inode_info *ci)
 
 	p = rb_first(&ci->i_xattrs.index);
 
-	doutc(cl, "p=%p\n", p);
+	boutc(cl, "p=%p\n", p);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		tmp = p;
 		p = rb_next(tmp);
-		doutc(cl, "next p=%p (%.*s)\n", p, xattr->name_len, xattr->name);
+		boutc_bounded(cl, "next p=%p (%.*s)\n",
+			      (p, xattr->name_len,
+			       BLOG_STR(xattr->name, xattr->name_len)),
+			      (p, xattr->name_len,
+			       (const char *)xattr->name));
 		rb_erase(tmp, &ci->i_xattrs.index);
 
 		__free_xattr(xattr);
@@ -802,7 +815,7 @@ static int __build_xattrs(struct inode *inode)
 	int err = 0;
 	int i;
 
-	doutc(cl, "len=%d\n",
+	boutc(cl, "len=%d\n",
 	      ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
 
 	if (ci->i_xattrs.index_version >= ci->i_xattrs.version)
@@ -888,7 +901,7 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 	int size = 4 + ci->i_xattrs.count*(4 + 4) +
 			     ci->i_xattrs.names_size +
 			     ci->i_xattrs.vals_size;
-	doutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
+	boutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
 	      ci->i_xattrs.names_size, ci->i_xattrs.vals_size);
 
 	if (name_size)
@@ -912,7 +925,7 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (ci->i_xattrs.dirty) {
 		int need = __get_required_blob_size(ci, 0, 0);
 
@@ -951,7 +964,8 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 }
 
 static inline int __get_request_mask(struct inode *in) {
-	struct ceph_mds_request *req = current->journal_info;
+	struct ceph_mds_request *req =
+		ceph_current_mds_request(ceph_sb_to_fs_client(in->i_sb));
 	int mask = 0;
 	if (req && req->r_target_inode == in) {
 		if (req->r_op == CEPH_MDS_OP_LOOKUP ||
@@ -1009,7 +1023,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
 	      ceph_vinop(inode), name, ci->i_xattrs.version,
 	      ci->i_xattrs.index_version);
 
@@ -1019,7 +1033,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		spin_unlock(&ci->i_ceph_lock);
 
 		/* security module gets xattr while filling trace */
-		if (current->journal_info) {
+		if (ceph_current_fill_trace_request()) {
 			pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1052,7 +1066,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 
 	memcpy(value, xattr->val, xattr->val_len);
 
-	if (current->journal_info &&
+	if (ceph_current_fill_trace_request() &&
 	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
 	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
 		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
@@ -1064,14 +1078,18 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
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
 
@@ -1079,8 +1097,10 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
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
 
@@ -1101,6 +1121,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = namelen;
 out:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -1133,7 +1154,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	doutc(cl, "name %s value size %zu\n", name, size);
+	boutc(cl, "name %s value size %zu\n", name, size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1162,10 +1183,10 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
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
@@ -1176,10 +1197,11 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
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
@@ -1235,7 +1257,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
 	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
-		doutc(cl, "sync version: %llu size: %d max: %llu\n",
+		boutc(cl, "sync version: %llu size: %d max: %llu\n",
 		      ci->i_xattrs.version, required_blob_size,
 		      mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
@@ -1251,7 +1273,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
+	boutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
 	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
@@ -1266,7 +1288,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	 */
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
-		doutc(cl, "sync (size too large): %d > %llu\n",
+		boutc(cl, "sync (size too large): %d > %llu\n",
 		      required_blob_size, mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
 	}
@@ -1277,7 +1299,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 		spin_unlock(&ci->i_ceph_lock);
 		ceph_buffer_put(old_blob); /* Shouldn't be required */
-		doutc(cl, " pre-allocating new blob size=%d\n",
+		boutc(cl, " pre-allocating new blob size=%d\n",
 		      required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
@@ -1317,7 +1339,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		up_read(&mdsc->snap_rwsem);
 
 	/* security module set xattr while filling trace */
-	if (current->journal_info) {
+	if (ceph_current_fill_trace_request()) {
 		pr_warn_ratelimited_client(cl,
 				"sync %p %llx.%llx during filling trace\n",
 				inode, ceph_vinop(inode));
@@ -1346,9 +1368,16 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
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
@@ -1357,9 +1386,16 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
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

