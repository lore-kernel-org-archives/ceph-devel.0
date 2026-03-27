Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91562D8DB1
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621860; cv=none; b=cr1ZhCbpbspp27ur97obg9gyldF/uX1j5FjwQhEF8Hb8aHeIfoCq/u8gm9fy41beNc/yOVmlrWNA3PaHh6703bpKTUejVcga9DevxUWphIq2+nigpPG2xM+KtG7YLE7scIki+VGEkV5T7Z4r5KfoeRvPUl1u14ej65ISB0xVrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621860; c=relaxed/simple;
	bh=e5pGTithxIDEvoJyKDTd6o2t4PMWhn+Q41XaZgW/fyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UliQHi7KVF7/sLJel4ViRUdKKzJP6BcdieIe0wFp6zXpE4c+ZF00IokcYrk9WUXkx3qNqfcv6IEIlcLEoId5yydns7/3tpQYipvibQd05m20YDP7zOWGmOOQqctsPkLkEH3FqVJYkw+yiV70pHa+wE58tey/BTouBg8wZVOVW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJGUxTN9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0LMGC1p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJGUxTN9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0LMGC1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfQmGvhJGJfqudSLMRQkPitARPCGSlgKp15jWKKDzZ8=;
	b=aJGUxTN9v9J9fysFulLt7JkmOFDBreLaEB7pI18rsdZcyezRuPHKUxeKV8mnN4EU0skKIe
	Ldxtz5piUKFD5h64exbPPEcRdnLE9VFDlmmRa3Tt0DmkTiZ6kv4PbTW5KSvZTPcRRzeo/8
	3em0uETkpARw1a1GH53Mx7QIME/DyxI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-2hR0G0SQNe2aFwySEe_yQw-1; Fri, 27 Mar 2026 10:30:55 -0400
X-MC-Unique: 2hR0G0SQNe2aFwySEe_yQw-1
X-Mimecast-MFC-AGG-ID: 2hR0G0SQNe2aFwySEe_yQw_1774621855
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d9e1866bf1so3626606a34.1
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621855; x=1775226655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfQmGvhJGJfqudSLMRQkPitARPCGSlgKp15jWKKDzZ8=;
        b=c0LMGC1p1q3dDw1a9QnGnEQe0jBesCGp+uBDUvnbiFFZbN/VZk+nGoPrQlN6PL0NlE
         WH68H6AyuEc2Vs4uI2xTSSl9zxbXKoLYRAeCidco4Z0j9ZuIUHhMpucsSd2FZ2IXP8mf
         QQlWjk6inmJ/wUYoWdk7dnbdQYzj/z1p4U4JkKJ+8/8YDNSrwztotkHi93evCifnp7pH
         Cn09GqvacOOErCgL4C6nitLb6cKpZXdaKXbalwnTNmeFkGSYB3PtmlNECW6HbuYHlF3b
         pyE115DVo3+tlT7b5BwWl+iylRbrmfn6N7/OxIq7pWS+SqMDFnxi4qZG4Hw60Lr3q+gZ
         uKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621855; x=1775226655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfQmGvhJGJfqudSLMRQkPitARPCGSlgKp15jWKKDzZ8=;
        b=qbQ59mjBijfxHdbzVJJ42JOHce8l7qaxFx/yLtP9Hqv+L86bCQmAxjlQUIq33DLP2/
         K/vrCLlaMRVnT5k0BDqAzcPuot0rSO9CZjeaUd5jA7UREidXywzLKLs3byhPDsYdCxIs
         ++BYR/cwPYfSiMTW0SjkAf88ZdZl0SHu5phRUVnYPEjz6SvKAMAfYYYJz7kvL6/50dnX
         fAOOnqlaeikHEqFUGmYTwK8Sh94rkDVTij6cXLWQP69rP4cvW1O6WuurI/HSz4NtYoCe
         fnehR84rMB/dp3+h/uNwIPrXC0S6aFIAjRxu/0eSPe0nXShiWrvbhqyHbB0f7Q6cu/2m
         Ujzw==
X-Gm-Message-State: AOJu0Yyml83CYDRU0CXwOm5WkXykfnW1JGFUML2epsHtyIJs863Zmhd8
	ZEkOnZ7FiS/PtDMpNiLIHsKjR7faHOQyuZbHSAUys3lU6iVLUuv/BS4xagGJAOFI76i7lfhdJ7H
	McnNFelkkhSn5RXKCdNx/eAu3SaxpiGNc6fHwkvqsCBthBqDqrYlvQe1cufl/OTiKSnNB59eB2a
	NyCFjO3yjOmKkFdwh3GnMPywmv4/CKVVLcz2OySM6GwG2nZ9Qjhw==
X-Gm-Gg: ATEYQzx4g8IVSnZXvCtG2I5chQFlFMXTzcYh0Ip5NnKvJb4KRxDc7zaxCIE1vn9i+ZZ
	2PEpiCML8tUokCg+Pn8yvd3x3UqktUaZ8S875n1GKEJI0sMuWdJiTqVT+vtwlftcINC0Vl2CS8B
	26bu2w6nUyYaLZybBIiADkBgeU5wX19xFjn/mtcP+f/CELA2D+MjPniO+ZMhAbXTaB103dwAC20
	epIXO8wkcBSA2O52FzuglBPS/OuKQkJS68wXattZVYRc1oqwp5pakUMYTth3dZECzb/KAfDXV+3
	LM/Dvi4U09Oq6Hmerax9COJ3qFSpzL/pjzNrlScqmFJtXutX3cIdzY05S10LpGJ8/n9nOEPEOAE
	cTaDMqqLaJuP+pu6E87I7Yykkv0+2axzlCsVyxPQYfAN37BHjz9VDNqs=
X-Received: by 2002:a05:6820:99c:b0:67b:bd89:90ed with SMTP id 006d021491bc7-67e187062e4mr1467844eaf.41.1774621854758;
        Fri, 27 Mar 2026 07:30:54 -0700 (PDT)
X-Received: by 2002:a05:6820:99c:b0:67b:bd89:90ed with SMTP id 006d021491bc7-67e187062e4mr1467806eaf.41.1774621854116;
        Fri, 27 Mar 2026 07:30:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:30:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 01/10] ceph: convert inode flags to named bit positions
Date: Fri, 27 Mar 2026 14:30:37 +0000
Message-Id: <20260327143045.1393612-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define all CEPH_I_* flags as named bit positions with derived bitmask
values so the Ceph client can use test_bit(), set_bit(), and clear_bit()
consistently on inode error and state flags. This prepares the later
reset path to use atomic bit operations on the file-lock error state.

Co-authored-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/file.c       |  2 +-
 fs/ceph/locks.c      |  8 +++----
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
 5 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 66bbf6d517a9..aa9ee283dfda 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -579,7 +579,7 @@ static void wake_async_create_waiters(struct inode *inode,
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
+		clear_and_wake_up_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
 
 		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
 			ci->i_ceph_flags &= ~CEPH_I_ASYNC_CHECK_CAPS;
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index dd764f9c64b9..2f21574dfb99 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
 	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
 		/* clear error when all locks are released */
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
+		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 	fl->fl_u.ceph.inode = NULL;
@@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		wait = 1;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
@@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (lock_is_unlock(fl))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23b6d00643c9..12f1b57d4b1c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..e91a199d56fd 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -658,7 +658,7 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
-	return wait_on_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT,
+	return wait_on_bit(&ci->i_ceph_flags, CEPH_I_ASYNC_CREATE_BIT,
 			   TASK_KILLABLE);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 29a980e22dc2..272c287836c1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 /*
  * Ceph inode.
  */
-#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
-#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata */
-#define CEPH_I_POOL_PERM	(1 << 3)  /* pool rd/wr bits are valid */
-#define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
-#define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
-#define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
-#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
-#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
-#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
-#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
-#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
-#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
-#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this */
-#define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
-#define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
-#define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately after async
-					     creating finishes */
+#define CEPH_I_DIR_ORDERED_BIT		(0)  /* dentries in dir are ordered */
+#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata */
+#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
+#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
+#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
+#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
+#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
+#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snapss */
+#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
+#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
+#define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
+#define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
+#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+
+#define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
+#define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
+#define CEPH_I_POOL_PERM		(1 << CEPH_I_POOL_PERM_BIT)
+#define CEPH_I_POOL_RD			(1 << CEPH_I_POOL_RD_BIT)
+#define CEPH_I_POOL_WR			(1 << CEPH_I_POOL_WR_BIT)
+#define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
+#define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
+#define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
+#define CEPH_I_ERROR_WRITE		(1 << CEPH_I_ERROR_WRITE_BIT)
+#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
+#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
+#define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
+#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_ASYNC_CHECK_CAPS		(1 << CEPH_I_ASYNC_CHECK_CAPS_BIT)
 
 /*
  * Masks of ceph inode work.
@@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
  */
 static inline void ceph_set_error_write(struct ceph_inode_info *ci)
 {
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
+	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
+		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
 
 static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
 {
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
+	if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
+		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
-- 
2.34.1

