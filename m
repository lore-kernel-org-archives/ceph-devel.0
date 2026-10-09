Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF138F95B
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564177; cv=none; b=nDbg4vcA/DDALY555gHVNhPoplDvHh/f8gySXzfyTL2b+hm25nrdRsMDy+rTQrCKemac+hx6h0uZ6qm9FKspblYrvUA/IxG1aec34C79HQyFa0alsazRhE+QRwtB4p/H7z3bUZqIkPeha++/7UTECpXYfRMpue11kB6mCGqMckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564177; c=relaxed/simple;
	bh=+3dYvQgmvc0Jqqm8BvbKPEIAU/XVj1XQx+rjfBjLZuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ud9/4Ovk+RVZEg1oDkQRnO7c4hfMCH4cwhDRAt6oEh6yTXu26dtFuZQrbsUvHzQy851VAJo7TPfgIc8MKbw7U42WeORAmXBIRFSmq+5ZWADyoH+UO8YtykYMhH7+LjBVvp0i0yAAX1Qvpbu/W2Jc8MZc8cQPY3+4WBrZK9jiWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayr3TWjl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5csQ2Bf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayr3TWjl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5csQ2Bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791564174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPD5LelXQESO+ChJn9ewzfOyykc4hAUKOBQlPcK4MhM=;
	b=Ayr3TWjlRzTzyjEYcyfSJeajF0ltTUhciyPJSdj1lgLC3TyPYqnsdzi5C0eueV5JpAe8D7
	XsvYGE2fGd0X6HYgMEVPVHuytpRjhPEUSFaOIS0yV6xOqztlkxt1VT+TdIoamY2IutEkq9
	pHhFG9i0q2FT/AFYcZkTZHE1OSrpTEI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-5WXmYigWM9OGDHrY4cw-TQ-1; Fri, 9 Oct 2026 16:42:53 +0000
X-MC-Unique: 5WXmYigWM9OGDHrY4cw-TQ-1
X-Mimecast-MFC-AGG-ID: 5WXmYigWM9OGDHrY4cw-TQ_1791564172
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2e49c5ff09so3134466b.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791564172; x=1792168972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPD5LelXQESO+ChJn9ewzfOyykc4hAUKOBQlPcK4MhM=;
        b=f5csQ2Bf3D9D4zwr56tbFWNLDojo9Jp/ULivBSFpsWexSqQHLpSX9ue0sJtIPM5fjc
         0oCf412aZczdF+nUGZxnaK4WQCIWnem6NJc0rxT6QIQO0rSDNSHKI+55YTZPv7JzGvvO
         2jK2Z/xCXpzcmhQm1hSsN2AQJkeb4HMYNuCADut+3Xt98fvIZHMc1ZkrSRs7iufqkcw9
         HEJ6xo41xgngWwEP9HRTNnVg8IbQ7NXkUw8l//Oer5gZ9RMee5/WXlYx7aAwzihvYAYt
         lO6ygy7Jsnh5RbGzNJUtS16jZ8MmglGUDMGMX2o/FlnLjCyr2rCRuDCfEvrG4bX5E23b
         Rh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564172; x=1792168972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPD5LelXQESO+ChJn9ewzfOyykc4hAUKOBQlPcK4MhM=;
        b=JH2oL0BaE4b61QScB3Gq3Sdts7ZMItNDMRL85uksoJubMMoHOhC4wjlxjZOmDYd8Pb
         pnpKkW4UZsg3Tg80RMEauCHzqnxNA3Te9nhW+3syhruAecEJ8ejKrzzkjwcaOXOMesf+
         f7RCyM4wghaNOHexGgqiZK3qtsDmho1IDCLfEqRFrPQYm6wibc4kdJz1AsjTulXLLUBS
         XFeqC6A1+ZZb66KdhRMZn2tCW3iM0ybtd/f2b2Q2z4bw1etbmXjUwlqJy/MObY9BB5zM
         GCDiEMsDNXoFnKkx9Y+c0/DCLZhfoD3uWFcr4hqwzxy+0xknmB82p+Uh+stOLSEjUtnH
         knHw==
X-Gm-Message-State: AFq9FYIXzkCmtSRvYAbQM45SvGZHBoHZFh5kHH5yQCjg1kXKtC83GTKV
	ViGhU9nJdGQXcNygXbkbNk4ypwd/4uVRjv5f75jQC4CfdpF239IGsdHOrU8P4lTdnNMk2FW386E
	M8kpxRlSIPG6732oRxpunJ7D3cWM5PoFbGZwdb3RZvh8PRjRsTAFQmUleZ20F21MYVBg1IXjZpy
	Z0fzVRTt6PQs3Mwg8NuA22nJjNwSXo/3CaEBWDUWW2CbnNNMbo+w==
X-Gm-Gg: AYBFou10M8gHygiEM1ZhoZyjQUPr0I+7w5zDuXTDUlbdYouJNgL0ea03LF2qBPr3R2W
	U9bOGsQ6PAsL87Q4nQ6aUvNuuqzewkMLeKhgXT0LifXnfgYFviOgxIjSMQ+VymWnvu0eqSIqcjD
	uBH4h4qtdremHy1BiKPB/59+sJ6MsSXU2T20GLEPUeDGV8DeF/5UJOb/SvoOtzLO1Zhq1q8/sdh
	B2TkBK9CULQGERVjpOVNom/m4SrAZTBfnq42K2ckXQAASLUD2p6odZsi6WqZ67S4wKdUWIZz+ph
	nrXwTLlgfWw5yk7TIjHR2NJwaY4k9YQZ70g8AYf0tsl8I8klO7bKrVCo10a717XdmOQGplzQkRL
	zQ/79Fb6hwqZbFWqfkv7s1F2KTW+da6sa81/gA7drN3IHF1zc5RygX2LPRBi/Qj3c4RssUL3H7K
	gWVxt01D1+BIFMRQ==
X-Received: by 2002:a17:906:e104:10b0:c32:3da2:69bf with SMTP id a640c23a62f3a-c323da26f88mr51695566b.30.1791564172255;
        Fri, 09 Oct 2026 09:42:52 -0700 (PDT)
X-Received: by 2002:a17:906:e104:10b0:c32:3da2:69bf with SMTP id a640c23a62f3a-c323da26f88mr51694166b.30.1791564171820;
        Fri, 09 Oct 2026 09:42:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa8511sm120683666b.59.2026.10.09.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:42:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/3] ceph: fail quarantined subvolume access with EACCES
Date: Fri,  9 Oct 2026 16:42:45 +0000
Message-Id: <20261009164245.2483933-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009164245.2483933-1-amarkuze@redhat.com>
References: <20261009164245.2483933-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise CEPHFS_FEATURE_QUARANTINE (bit 24). The MDS then rejects
metadata from this client with EACCES instead of parking the request
until quarantine is lifted. Clients that do not advertise the bit
still block.

Cached caps can satisfy getattr, open, lookup, and readdir without
asking the MDS, and file I/O waits in ceph_get_caps() for caps that
quarantine will not reissue. Fail those paths locally when the inode
or an ancestor is marked. Async create and unlink take the same check
in ceph_mdsc_submit_request(), so they cannot complete in the cache.

Recovery clients with q/Q caps are not marked. The MDS sends errno 0
and full caps, and those operations proceed.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       | 10 ++++++++++
 fs/ceph/debugfs.c    |  1 +
 fs/ceph/dir.c        | 10 ++++++++++
 fs/ceph/file.c       | 11 +++++++++++
 fs/ceph/inode.c      |  7 +++++++
 fs/ceph/mds_client.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h | 10 +++++++++-
 7 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 84238da4d75c..3a99107b7567 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3263,6 +3263,9 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
 			return ret;
 	}
 
+	if (ceph_inode_is_under_quarantine(inode))
+		return -EACCES;
+
 	flags = get_used_fmode(need | want);
 	if (nonblock)
 		flags |= NON_BLOCKING;
@@ -3297,6 +3300,9 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 	flags = get_used_fmode(need | want);
 
 	while (true) {
+		if (ceph_inode_is_under_quarantine(inode))
+			return -EACCES;
+
 		flags &= CEPH_FILE_MODE_MASK;
 		if (vfs_inode_has_locks(inode))
 			flags |= CHECK_FILELOCK;
@@ -3333,6 +3339,10 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 					ret = -ERESTARTSYS;
 					break;
 				}
+				if (ceph_inode_is_under_quarantine(inode)) {
+					ret = -EACCES;
+					break;
+				}
 
 				/*
 				 * If a cap update is lost after
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6a9a5551d9d7..ef10e948a2d3 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -53,6 +53,7 @@ static const struct ceph_session_feature_desc ceph_session_feature_table[] = {
 	{ CEPHFS_FEATURE_HAS_OWNER_UIDGID, "HAS_OWNER_UIDGID" },
 	{ CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK, "MDS_AUTH_CAPS_CHECK" },
 	{ CEPHFS_FEATURE_SUBVOLUME_METRICS, "SUBVOLUME_METRICS" },
+	{ CEPHFS_FEATURE_QUARANTINE, "QUARANTINE" },
 };
 
 static int mdsmap_show(struct seq_file *s, void *p)
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 384e9edabe2a..1e214ef65c5d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -349,6 +349,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 	ceph_blog_enter(fsc, &__ji);
 
+	if (ceph_inode_is_under_quarantine(inode)) {
+		ceph_blog_exit(&__ji);
+		return -EACCES;
+	}
+
 	boutc(cl, "%p %llx.%llx file %p pos %llx\n", inode,
 	      ceph_vinop(inode), file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND) {
@@ -888,6 +893,11 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
+	if (ceph_inode_is_under_quarantine(dir)) {
+		ceph_blog_exit(&__ji);
+		return ERR_PTR(-EACCES);
+	}
+
 	if (IS_ENCRYPTED(dir)) {
 		bool had_key = fscrypt_has_encryption_key(dir);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 856710c63765..f90c313ef4b2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -382,6 +382,12 @@ int ceph_open(struct inode *inode, struct file *file)
 		return 0;
 	}
 
+	/* Existing caps can satisfy open without an MDS round-trip. */
+	if (ceph_inode_is_under_quarantine(inode)) {
+		ceph_blog_exit(&__ji);
+		return -EACCES;
+	}
+
 	/* filter out O_CREAT|O_EXCL; vfs did that already.  yuck. */
 	flags = file->f_flags & ~(O_CREAT|O_EXCL);
 	if (S_ISDIR(inode->i_mode)) {
@@ -831,6 +837,11 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		return -ENAMETOOLONG;
 	}
 
+	if (ceph_inode_is_under_quarantine(dir)) {
+		ceph_blog_exit(&__ji);
+		return -EACCES;
+	}
+
 	err = ceph_wait_on_conflict_unlink(dentry);
 	if (err) {
 		ceph_blog_exit(&__ji);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 994a0c4f2f4c..40638d7e1522 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3167,6 +3167,13 @@ int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
 		return 0;
 	}
 
+	/*
+	 * Cached caps would otherwise satisfy getattr after the MDS has
+	 * revoked access. Fail before that short-circuit.
+	 */
+	if (ceph_inode_is_under_quarantine(inode))
+		return -EACCES;
+
 	boutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
 	if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 97a0ce4709ca..89d20a42b606 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3983,12 +3983,53 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	}
 }
 
+static bool ceph_request_targets_quarantine(struct ceph_mds_request *req,
+					    struct inode *dir)
+{
+	struct inode *inode;
+
+	if (dir && ceph_inode_is_under_quarantine(dir))
+		return true;
+	if (req->r_inode && ceph_inode_is_under_quarantine(req->r_inode))
+		return true;
+	if (req->r_parent && ceph_inode_is_under_quarantine(req->r_parent))
+		return true;
+	if (req->r_old_inode && ceph_inode_is_under_quarantine(req->r_old_inode))
+		return true;
+	if (req->r_old_dentry_dir &&
+	    ceph_inode_is_under_quarantine(req->r_old_dentry_dir))
+		return true;
+	if (req->r_dentry) {
+		inode = d_inode(req->r_dentry);
+		if (inode && ceph_inode_is_under_quarantine(inode))
+			return true;
+	}
+	if (req->r_old_dentry) {
+		inode = d_inode(req->r_old_dentry);
+		if (inode && ceph_inode_is_under_quarantine(inode))
+			return true;
+	}
+	return false;
+}
+
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 			      struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
+	/*
+	 * Quarantine-aware clients fail metadata immediately. The MDS is
+	 * still the authority for clients that have not seen the cap
+	 * update yet; this covers inodes already marked locally, including
+	 * async create/unlink which would otherwise complete in cache.
+	 */
+	if (ceph_request_targets_quarantine(req, dir)) {
+		doutc(cl, "request %p op %s denied by subvolume quarantine\n",
+		      req, ceph_mds_op_name(req->r_op));
+		return -EACCES;
+	}
+
 	/*
 	 * If a reset is in progress, wait for it to complete.
 	 *
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 863cdb8d588a..157f8933a547 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -39,7 +39,14 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
 	CEPHFS_FEATURE_SUBVOLUME_METRICS,
 
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_SUBVOLUME_METRICS,
+	/*
+	 * Bit 23 is CEPHFS_FEATURE_BLOCKDIFF on the MDS and is not
+	 * advertised here. Bit 24 is subvolume quarantine; it must stay
+	 * aligned with the userspace client.
+	 */
+	CEPHFS_FEATURE_QUARANTINE = 24,
+
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_QUARANTINE,
 };
 
 #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
@@ -57,6 +64,7 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
 	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,	\
 	CEPHFS_FEATURE_SUBVOLUME_METRICS,	\
+	CEPHFS_FEATURE_QUARANTINE,		\
 }
 
 /*
-- 
2.34.1

