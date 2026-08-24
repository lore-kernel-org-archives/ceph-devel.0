Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843ED3876DE
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596941; cv=none; b=m+9FBVt27aO27qJ41jKTL22JSYnCtQMw5LhhlCX22MwBne6DGHno2XKaSO3//vsHZcLadipdEADIaaO24/IsFZ+j8DumlTUb7QDtMRVLvut66yYTn86NVHrbLBl+OqyKhQkZLymE0vvqMuNJttQrg5ym2iM/oOdSJPEFg7V5YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596941; c=relaxed/simple;
	bh=fy0YWdySbcwe+SrvcVcAqvPsPd89TYKxDwapLKGJrBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muSNBBCMAOO68oTQFcEBiOZoo5GAoheCf4FuJTwjccZGgpa/Cdu/Bc+g5PIS25dqEhQNhtyyQy2pD3Viqad0xx6xrdatr3OhO6Fs4z1IcYdzZQ0eW/WihmYwHJiFSicGaf5dDWECukX+syeICiY9ypztPl3RrMrfFfdzv6prO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EdXT7L85; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EdXT7L85"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c167aa9500dso586057366b.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596937; x=1788201737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wrgSoA/LAHCRylqcLx3VjgTNEF7/gfLlLajj75IaXo=;
        b=EdXT7L85qpTsABdIy+9QboMXdtbvTVJh5sxUdfp3DwfKfclQeSgMKFmlD7lWnaK2zn
         RhAaQ0Y1fMRIc7AryVnOG0t6Isa9raTxB0CIvMn1gE75fZ+xgGyXYLVDU9fbo4VM2xXp
         sbPC4q4OVya7YhHnMAAMuHRgVAQL+Xd+Pk8nIz+ZBLw1cBjV7I1C+CCkpDgrpyUiR3dD
         /r/H/6AHRu4d8mFGeDZu5QVf8kGln8v0f69jna3sFPXXHbTaKBJdDvJtOxOoIf6L4tYO
         BZpL1LO5nWbza3a4//JDw3vBYSAelPeW4QpynqZ+Oe7RLClIuUQCwrxig6vor5SOsQc4
         psLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596937; x=1788201737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wrgSoA/LAHCRylqcLx3VjgTNEF7/gfLlLajj75IaXo=;
        b=CbsJxbkBYgcBqKWRY2z5Bd9Y6Tuokx5o7Mri7MfnRVQONZEO9/w8xGXJ9kFHwPHPgZ
         Y8i9Qn4s2hnROGNsvlsIs8pB+PUri7E+Ld3SINo+LClS+K8twbyXlB46MiT35k/hzduY
         Y2F39XvZaxps/rrOVXXoxJKhTbal8/pJkKJvrtM+uNbcgdKgdG0GRWGFOl3TbsV9Fp93
         XkAfZ5JS60mODo22b0Snh7YBvZ6yA17Qdu0xa4ZvQ0t03GNbx/0ICmMkA+QfYRMwa+Xx
         Gi38GbnZDHMO4i+W1Mme+qzxaZPhSwAVv7TJ3SgXhgFDwOCz0KI/lDc0XLRNZkO8Su/B
         5TGA==
X-Forwarded-Encrypted: i=1; AHgh+RqP3WAotOjA6MlbjcQpwmcRZVFdSgBPxGqAQldQQb1CrG3RVZyCdq53D9sEihq4kOt5z7OdJ6xPDG89@vger.kernel.org
X-Gm-Message-State: AFuF++nPE/jO+U/w36vLNo8yMmDv8QweTNCGA8GacBpK+L2oKXQ2y28X
	qm/gAw9Ek5nHt/7Cl9jlKomOlqGKuG7pBkXJpgtkdPxMhYV4Ztq1O2pgB9UD5Nk/d9vtBqVofiZ
	fWrL8lDU=
X-Gm-Gg: AR+sD12H7/TpaBh8TIBur+E/8FQA3wuyi48T5cJjYqjYum9dTNqRdNA6NWQwIC8FRZM
	hSBp6vOvm9ucSwijTBZOUMWVpp2onp5AG/2Qhn2exl2/x92MX83vPQozkl6ylDkFw+jPD68kZ44
	OOJkX36oSpVZfnCn+Ms0wDnCjbC1F9b5GrRERWfYTXqoUypshMKYLFKlNz/3fH+1zy89T+IWrwa
	WcUx9r8oIWxrqw+RvSiMs/r1bntdAUURPSp82QSJY7SekKFXM81WAeaCoGbm6nEl4JLnftt89cD
	U91tT0ZsVxAoLmtiHdMi+zjdU4L3lkX570lXHHib0YaE3e88fi+qfXzfNuY1s1Nnhs6vAt157Xu
	rzkDuGWDP58sYTeZU26QaxKe39tC4D6jB4v9KXz1BMIlSyMsG70j4Iw9yAJa6IYEsEbTip/xg2p
	WFp4eTQfSqLTMvjeeFErRSOGAZuu/GNEhr1onnEFOcDPzCnJmih4BKVRaGgEy4YDNHNw7Ltx019
	8OFX6qjDay8TBtOG6ZgIgBwGv14Ci+dLT8nPzulOoTsvYngl0Fdj0Iehi8ncHgFKQ==
X-Received: by 2002:a17:907:d048:b0:c21:74ed:4608 with SMTP id a640c23a62f3a-c246a4cf8b5mr3173824666b.10.1787596936684;
        Mon, 24 Aug 2026 11:42:16 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:16 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 10/11] fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
Date: Mon, 24 Aug 2026 20:41:58 +0200
Message-ID: <20260824184159.240821-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to remove (optimize) `i_vino`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c       |  5 ++---
 fs/ceph/caps.c       |  4 ++--
 fs/ceph/dir.c        |  2 +-
 fs/ceph/file.c       | 14 +++++++-------
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/quota.c      |  2 +-
 fs/ceph/snap.c       |  4 ++--
 fs/ceph/super.h      |  7 +++----
 fs/ceph/xattr.c      |  4 ++--
 9 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 41af001070bb..3a3f49f2cdbc 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -282,7 +282,6 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_reply_info_in *iinfo;
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
-	struct ceph_inode_info *ci = ceph_inode(inode);
 	ssize_t err = 0;
 	size_t len;
 	int mode;
@@ -302,7 +301,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		err = PTR_ERR(req);
 		goto out;
 	}
-	req->r_ino1 = ci->i_vino;
+	req->r_ino1 = ceph_vino(inode);
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
@@ -2475,7 +2474,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	rd_req->r_base_oloc.pool = pool;
 	if (pool_ns)
 		rd_req->r_base_oloc.pool_ns = ceph_get_string(pool_ns);
-	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci->i_vino.ino);
+	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ceph_ino(&ci->netfs.inode));
 
 	err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
 	if (err)
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 554343d612f7..f81782712d8a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -730,7 +730,7 @@ void ceph_add_cap(struct inode *inode,
 			ceph_change_snap_realm(inode, realm);
 		else
 			WARN(1, "%s: couldn't find snap realm 0x%llx (ino 0x%llx oldrealm 0x%llx)\n",
-			     __func__, realmino, ci->i_vino.ino,
+			     __func__, realmino, ceph_ino(inode),
 			     ci->i_snap_realm ? ci->i_snap_realm->ino : 0);
 	}
 
@@ -1176,7 +1176,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	} else {
 		cap->queue_release = 0;
 	}
-	cap->cap_ino = ci->i_vino.ino;
+	cap->cap_ino = ceph_ino(inode);
 
 	spin_unlock(&session->s_cap_lock);
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index aff72458d3f4..c0a3c10f576e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2124,7 +2124,7 @@ static void ceph_d_prune(struct dentry *dentry)
 
 	/* we hold d_lock, so d_parent is stable */
 	dir_ci = ceph_inode(d_inode(dentry->d_parent));
-	if (dir_ci->i_vino.snap == CEPH_SNAPDIR)
+	if (ceph_snap(&dir_ci->netfs.inode) == CEPH_SNAPDIR)
 		return;
 
 	/* who calls d_delete() should also disable dcache readdir */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e79c18aee78d..bf4e888905a5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1119,7 +1119,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		      read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, read_off, &read_len, 0, 1,
+					ceph_vino(inode), read_off, &read_len, 0, 1,
 					sparse ? CEPH_OSD_OP_SPARSE_READ :
 						 CEPH_OSD_OP_READ,
 					CEPH_OSD_FLAG_READ,
@@ -1825,7 +1825,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		rmw = first || last;
 
 		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
-		      ci->i_vino.ino, pos, len, write_pos, write_len,
+		      ceph_ino(inode), pos, len, write_pos, write_len,
 		      rmw ? "" : "no ");
 
 		/*
@@ -1858,7 +1858,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			 * depending on how the request was aligned.
 			 */
 			req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, first ? first_pos : last_pos,
+					ceph_vino(inode), first ? first_pos : last_pos,
 					&read_len, 0, (first && last) ? 2 : 1,
 					CEPH_OSD_OP_SPARSE_READ, CEPH_OSD_FLAG_READ,
 					NULL, ci->i_truncate_seq,
@@ -2056,7 +2056,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					    ci->i_vino, write_pos, &write_len,
+					    ceph_vino(inode), write_pos, &write_len,
 					    rmw ? 1 : 0, rmw ? 2 : 1,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE,
@@ -2981,12 +2981,12 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 					      &dst_objoff, &dst_objlen);
 		ceph_oid_init(&src_oid);
 		ceph_oid_printf(&src_oid, "%llx.%08llx",
-				src_ci->i_vino.ino, src_objnum);
+				ceph_ino(&src_ci->netfs.inode), src_objnum);
 		ceph_oid_init(&dst_oid);
 		ceph_oid_printf(&dst_oid, "%llx.%08llx",
-				dst_ci->i_vino.ino, dst_objnum);
+				ceph_ino(&dst_ci->netfs.inode), dst_objnum);
 		/* Do an object remote copy */
-		req = ceph_alloc_copyfrom_request(osdc, src_ci->i_vino.snap,
+		req = ceph_alloc_copyfrom_request(osdc, ceph_snap(&src_ci->netfs.inode),
 						  &src_oid, &src_oloc,
 						  &dst_oid, &dst_oloc,
 						  dst_ci->i_truncate_seq,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 30f8430b2825..e5fb39913a4b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1989,7 +1989,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 			if (cap == prev)
 				break;
 			prev = cap;
-			vino = cap->ci->i_vino;
+			vino = ceph_vino(&cap->ci->netfs.inode);
 			spin_unlock(&session->s_cap_lock);
 
 			inode = ceph_find_inode(sb, vino);
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 08641d578a0b..02d7a3062f2d 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -31,7 +31,7 @@ static inline bool ceph_has_realms_with_quotas(struct inode *inode)
 	if (root && ceph_ino(root) == CEPH_INO_ROOT)
 		return false;
 	/* MDS stray dirs have no quota realms */
-	if (ceph_vino_is_reserved(ceph_inode(inode)->i_vino))
+	if (ceph_vino_is_reserved(ceph_vino(inode)))
 		return false;
 	/* otherwise, we can't know for sure */
 	return true;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 94964e0952bd..f064b5ad3bf4 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -985,7 +985,7 @@ void ceph_change_snap_realm(struct inode *inode, struct ceph_snap_realm *realm)
 	if (oldrealm) {
 		spin_lock(&oldrealm->inodes_with_caps_lock);
 		list_del_init(&ci->i_snap_realm_item);
-		if (oldrealm->ino == ci->i_vino.ino)
+		if (oldrealm->ino == ceph_ino(inode))
 			oldrealm->inode = NULL;
 		spin_unlock(&oldrealm->inodes_with_caps_lock);
 		ceph_put_snap_realm(mdsc, oldrealm);
@@ -996,7 +996,7 @@ void ceph_change_snap_realm(struct inode *inode, struct ceph_snap_realm *realm)
 	if (realm) {
 		spin_lock(&realm->inodes_with_caps_lock);
 		list_add(&ci->i_snap_realm_item, &realm->inodes_with_caps);
-		if (realm->ino == ci->i_vino.ino)
+		if (realm->ino == ceph_ino(inode))
 			realm->inode = inode;
 		spin_unlock(&realm->inodes_with_caps_lock);
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4d6cdbf02491..15fa433c9485 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -597,7 +597,7 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 }
 
 /* for printf-style formatting */
-#define ceph_vinop(i) ceph_inode(i)->i_vino.ino, ceph_inode(i)->i_vino.snap
+#define ceph_vinop(i) ceph_ino(i), ceph_snap(i)
 
 static inline u64 ceph_ino(const struct inode *inode)
 {
@@ -642,9 +642,8 @@ static inline u64 ceph_present_inode(struct inode *inode)
 static inline int ceph_ino_compare(struct inode *inode, void *data)
 {
 	struct ceph_vino *pvino = (struct ceph_vino *)data;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	return ci->i_vino.ino == pvino->ino &&
-		ci->i_vino.snap == pvino->snap;
+	return ceph_ino(inode) == pvino->ino &&
+		ceph_snap(inode) == pvino->snap;
 }
 
 /*
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index d93dc7ae0add..c8fb35f4eaea 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -272,7 +272,7 @@ static bool ceph_vxattrcb_quota_exists(struct ceph_inode_info *ci)
 	if ((ci->i_max_files || ci->i_max_bytes) &&
 	    !ceph_in_snap(&ci->netfs.inode) &&
 	    ci->i_snap_realm &&
-	    ci->i_snap_realm->ino == ci->i_vino.ino)
+	    ci->i_snap_realm->ino == ceph_ino(&ci->netfs.inode))
 		ret = true;
 	spin_unlock(&ci->i_ceph_lock);
 	return ret;
@@ -1328,7 +1328,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 			spin_lock(&ci->i_ceph_lock);
 			if ((ci->i_max_files || ci->i_max_bytes) &&
 			    !(ci->i_snap_realm &&
-			      ci->i_snap_realm->ino == ci->i_vino.ino))
+			      ci->i_snap_realm->ino == ceph_ino(&ci->netfs.inode)))
 				err = -EOPNOTSUPP;
 			spin_unlock(&ci->i_ceph_lock);
 		}
-- 
2.47.3

