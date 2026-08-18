Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFD486B99
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076725; cv=none; b=XQaGL1xofa3EpdAv9W95PedLK4H0iQsYzxz/YW/Qv8QT+ozJugAzlYyl4uNCbgYnCarzthkrwCK/MklSTIO972tiJjJDZhItDIF8epbUZmJni73W3uqsI5JEj6vgrVuRVEiTrLdr6IBBPW9SdZYY6eFNo27fcIT3Q1vsuEt8uQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076725; c=relaxed/simple;
	bh=oiVmzcAKmlPDtZjfAObrIsUUramBNrsjJ2BxpPOQa30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI+5N+gpCLl0w+JMGx/kJwOL3QP6PxU+ziPBq/k6XE5D+zCBWP7xjwCU5wHYGWaADHmjJS+k9XoXAVV1k+dLKlR1HqBn1bRELLOCiDJ4amGWHTnQm8hG1DfYVGN6kwWGWpBMsbzKPAfnBGAeg0ZXys0RfwiaZkgId3OIoE+b6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PeWloCDt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PeWloCDt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de008b020so17143f8f.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076716; x=1787681516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pL1KiS9CEGUN/NiOxD9xGDBwx+N/unHU1dSQX3rcHc8=;
        b=PeWloCDtofr31WlSvmuqxhqlT9hDsnvqiVo0yE+iCg8t5eRnw1WcD5nng6IxKgKs3K
         hjiJpoesMJc7fCxuZLZ89RiLSeR+P6/lKk52gSybY/i5lViikkikdwBLimHkkmfX/oKg
         E4aA34f1OeicXofecGi26hHhT54abYvhSe8wcC4gLZfFlhuGtUH+8oecv6daZte3jRxc
         92P83WbjheMTmGsGXpekFmRCD8qpqvu49MQYRVUmvmNSSrstHYxBInSSswp/jHHINbHN
         QEAqJUIk5GPdKIucmVvcqN4uIRhchLqs7k8oaFksc9An60brzEhGknc4pkk4xx9loXgx
         j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076716; x=1787681516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pL1KiS9CEGUN/NiOxD9xGDBwx+N/unHU1dSQX3rcHc8=;
        b=kgo840AGs3dg0I0sWibFi03rV4XwG3XngGW4KQwxvQgn/E79K+6CxuiB1bs3nKVR1p
         7Ei87EFxgjgx21Zk2KxUYXg2LmZJ3n4lHUnXSMyk2I+JTwLa1XZtb4LNKvcqeUJPzvrK
         l/yuFS6dRGfYSli+usAJZQd/bP6bu4iePWS14a5JbcHjkAEuKyTFF72F81vCyvHYDtdS
         7MkGtsWgwKcu2d8au/mWBu4ZOn7K/wqTZryN1Wc8GTM+2SQm4BvsQCCZ5lQnTqYFujfz
         sO7fJi18/1nnL+MdLMIAP4G9SKsFZ5RCYbqRNny5cWBYKQUTKRVBz3mD4AnXr+rCe0QT
         d60g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2euWmssSaTR/pCdolVESc4YN6pEGqYnddP0H8a4QhU9KtLKhqTmOaQ0Uex32atIquRuzMD48lT+MH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7nVNB4tM6+ctOo0cFfvi8IFz9/6RyJw4JGyXlgZzItLCpo0H
	N/lI3pg8XTlLhwWFOTkOo7cj6r13l6EAkcNvLLv3RwETS+2b4hZnwGY1+MhjHSR881Y=
X-Gm-Gg: AR+sD13itnGyrjXopQLE7miueM5MSWjJ9ah5m6+CXG+zcDgiA8Sz5EheHO4uSFavNWO
	MpcW3P1gSQcg7eKKyTABeg5rKcLxYSh6Gtdshht6OUllv1rEAklHnNbdcn/th5G5CWttPx1XYMC
	doIwpSSiCI0PeCy3OGvTBIx6so+G3jNe+HbthPm34DwnQgm1s2EFpI0DaJr8fz2xf71FiJuYBe8
	fuJPxKt18OajQ7FF7ffp2kqvkIQ/xef92UilcYS2h8tTgDE0bCjcRgUB0FPTUT9xN/oo16eZuLE
	YZDlw03iV47/AaSQH+3vE3Fm/p+iwzQu/WxJmvi6+1B63IrecbENZqi7l9w0plnGBQhNOrzYber
	Yrb0/rV3Ss9AfbiFe99UBRe+nLZm+jCVXQLm49AVFXMSgkgxsVAwLKfptBTdv1clr+00EabcfAi
	VHiYFLJoZXOBnLawdCVQVCxMdrs+dJmw32MB7UpZEzLt6v0kdXaS27otLg7XDWsHN9tuHeMMygp
	Y/0w+dWHvyA0YvlFyfKG6bvjRKjMgrGDX8uzaYh6ocm8uHZCROL4hjGPlh4ySKC
X-Received: by 2002:a05:6000:22c1:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-482a9d5b7d0mr14295154f8f.0.1787076716389;
        Tue, 18 Aug 2026 11:11:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 11/12] fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
Date: Tue, 18 Aug 2026 20:11:43 +0200
Message-ID: <20260818181144.3541770-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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
index ecfd0fed3471..7beb1b4d1cd9 100644
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
index 51ed5aee193f..49213c320d7f 100644
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
index b0b8d04b594f..660125d94f8e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -596,7 +596,7 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 }
 
 /* for printf-style formatting */
-#define ceph_vinop(i) ceph_inode(i)->i_vino.ino, ceph_inode(i)->i_vino.snap
+#define ceph_vinop(i) ceph_ino(i), ceph_snap(i)
 
 static inline u64 ceph_ino(const struct inode *inode)
 {
@@ -641,9 +641,8 @@ static inline u64 ceph_present_inode(struct inode *inode)
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
index af54480d9254..b8416afd4901 100644
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

