Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6B4AA58F
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366502; cv=none; b=cjL1vuNQaYddOeiGEDW+jUO1ne5HwxynmxOVexaLixFV9nrmuk89VXBaQ9SPaflUIJmyQf4W7JFJz6M//nAaWhJodHiz75PVxh0NNfeN0Jx/2+Zum6Bz1mEE28jVTq3z9aTNlnqUzlRra8DAj/P0OfCM3/nXAXRy6cqwc9gtd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366502; c=relaxed/simple;
	bh=UwQSJrFic5uwP9PXknvwJYaQSb7BDZRNIbFd/3mnZlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvGARs2zEIqG4qGMmx0O3EpNAJwbvPRO12JFuh0UVQFouQfbGJF7BSenc0IbYKM9+9+TUsfqAYSy8Q/exKKMtMrDlBAADaRnKFz0zH4n+A3DdEeilFITuxI5esE8zywM+8RQq6S6E8r4CkvzWNzjDedOb3kRHA8I4GUO2cjsN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/pkwitn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJ8IEPAu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/pkwitn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJ8IEPAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcHKA+ZhQXXWaslpJLUt1oH1QU7uRshXpEOJDp8B+qg=;
	b=h/pkwitnbrNP2G2toEK02jNnGaQTDZ49NWVlt+DNYgB3bm/m6pteb8h83GiTxjqY0OnbEc
	acYMErCRRQfwh/YVKiID/CDkzqkQTpAeO8pTL1tyjIveWbdt3h638flM8fOBappnt5l489
	aFG0z66rgWZn/ZxKrT8wA2bUy119Gug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-zId2wAQJMWWMqErHmszb1A-1; Wed, 02 Sep 2026 12:28:17 -0400
X-MC-Unique: zId2wAQJMWWMqErHmszb1A-1
X-Mimecast-MFC-AGG-ID: zId2wAQJMWWMqErHmszb1A_1788366496
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15f4732dfaso106110266b.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366496; x=1788971296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcHKA+ZhQXXWaslpJLUt1oH1QU7uRshXpEOJDp8B+qg=;
        b=gJ8IEPAums2PcSssiYmRi7PifzwMRm12Xp5d/H/sUQU33SfuBRTV+ROp61MsO4+Z37
         75A0XywREjkeGGT/nbyNz4oBBh+dUQmYDrCq0PzpgPBEEtU357GdC542CVqkT6upIxNQ
         1Jsc146k5O+ESljXynk5+x9+Mb7+0yniKY+c/mH0N2FLzx1v2uKf/evcUw3e7moJHrA4
         Ol2Yw+jUAd2O66XqfFifJDDfvzwGmzaa3Mo6Z5ok5cL9AzyfT3L7Ftu8ETtwNjiBS1CG
         6c5ka8PcR1yts+eKNQxx3ZenQJvTfXzk3feASNxMPr0OqymCVoTTg6OEcuWFVeKJkJXf
         WEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366496; x=1788971296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcHKA+ZhQXXWaslpJLUt1oH1QU7uRshXpEOJDp8B+qg=;
        b=bl83hhH9FXSDtHJw0UQ4lSpnZy64CKg2IxFTYfioMzGWv8cZsHIJ6LzFLW84uzC7sD
         xerQNiHFfZ176Xs8Nqhs6mZlA2os6CTGGJYZknXoc/ax5hEXu8kzwsSUN5ceEjt58grY
         RP6kafw7uz18U0tGtLU0nxqWrOEPcaePqvd1YVM7e2KVZLpIvyBQr97uGN7pkjFDMUwa
         ZzQ0mPRxWb7i/RAbsWNa5cH+qgdAMkQNUz8LrezipvqtNdz5FYjfSKJeii/+hx7j/Db2
         pihZxgR+6RdScFCplf9mdl3vq+AcCTo+1uSFOoYPDwAq0Jhe7fwABzlFOx7ptcAOlpOf
         mI/Q==
X-Gm-Message-State: AFuF++lti+cF3AODQKGftWS7SqgvXXNxe43lHk6kIjEq31mWzVcLtax+
	oq8hncp0G1j7lfjVaG4ejzdP7BRBW1FWM9Psmnb/l4fJeh2F2vrgvM2vqDaS/P4c9zaK10aVMAI
	4I+DQxVmH+ou4tKMtHubuklzkbL0rCZQTQByYn9yuJOTDH0FLgxEDd5UcsxNipNmG5lg2XZqtiA
	5+CiyqJkXfymlMsE83o92r82qe3W04nRnwJUtt8CEsbFoPEBsqZA==
X-Gm-Gg: AYBFou08HvP1PJHYW9V62+JT/lxA3oWFuxrI4Nsi5YWnX2O9tuBwbNOzPlJr9u2Fgve
	/kexGnJEFUxo7EcV5RRiI0qd+DWivvdwc+aAufsUlUyiJOgfGLTvkLLiZLbqP6rWkbJUGshCQp0
	YIkzGFyAv0/S9l0ezJAx1+2E4/H+4WtJkhWKwFZv0Ru5H26KkbHRBZeNEv+dWExjCtLzGqMGLYn
	qxXY+yaAn7yJXW4RvVOgx6Wq2bRhciLX+S/GU6OXWl1t2qYkRyODlyTOOCz2Jmk68foKjlMAdhF
	nCgDabx+FNberG1vRGyyxGIfDUSeodJi240Gcq7VY7RG8jtO2VKvDW2qu0ZhPtHNQH76kuDQsAk
	oSBH0Y87/vMZY5vdQBOrBaifYMsFq4oCsIghQoxPa1fYcFNHKdf9ydgIfVZCP7hZgm9rWdLgU0P
	6FNJ4URRdGSZ1nvA==
X-Received: by 2002:a17:907:d28:b0:c25:6230:dfcd with SMTP id a640c23a62f3a-c25d5492faamr403284766b.15.1788366496010;
        Wed, 02 Sep 2026 09:28:16 -0700 (PDT)
X-Received: by 2002:a17:907:d28:b0:c25:6230:dfcd with SMTP id a640c23a62f3a-c25d5492faamr403281366b.15.1788366495435;
        Wed, 02 Sep 2026 09:28:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 14/14] ceph: convert remaining helper paths to bout
Date: Wed,  2 Sep 2026 16:28:00 +0000
Message-Id: <20260902162800.3197342-15-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902162800.3197342-1-amarkuze@redhat.com>
References: <20260902162800.3197342-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dout()/doutc() with bout()/boutc() in locks.c, xattr.c,
and crypto.c.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/crypto.c |  14 +++----
 fs/ceph/locks.c  |  66 +++++++++++++++++++++---------
 fs/ceph/xattr.c  | 102 ++++++++++++++++++++++++++++++++---------------
 3 files changed, 123 insertions(+), 59 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 53b13cfce333..6da957e5b24b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
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
@@ -483,7 +483,7 @@ int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -494,7 +494,7 @@ int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	boutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
 	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
@@ -571,7 +571,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
-		doutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
+		boutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
 		      ceph_vinop(inode));
 		return 0;
 	}
@@ -595,7 +595,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
 						 off + pgsoff, ext->len);
-		doutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
+		boutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
 		      ceph_vinop(inode), i, ext->off, ext->len, fret);
 		if (fret < 0) {
 			if (ret == 0)
@@ -604,7 +604,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
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
index 1da6deea2c24..7d736c9d2c89 100644
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

