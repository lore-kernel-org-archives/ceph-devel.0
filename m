Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE7408029
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283148; cv=none; b=TDDQM/GnGXacOjgrT0gvo25+rxAd+0jZdAjgbA1Dy2G7mvzRL9he1tYGRM+R98XVs7gG1LwrYCnB2IE03R4NTvyJlwkYM8UW7Nw4klH6RSBYz2a5hlfojRe9tB8iwDfblw7BM1MmgahUw70SBC4lx10L9zXOI2JrO+ReTVoUEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283148; c=relaxed/simple;
	bh=FMxrZS3XgLX2y95gMdcexiP+l6LYzjnD28zQ148j1LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu1fiGzrq5hRp/xcX7ZB+xMo/IPNG6pX1vtXFPawbXnWbAzH4N6+oP2983tKZzcAvEyrDzS9BmZtv7O+8c88Bz2ZMs1RlIqoIgyg3lkEWI5O9RSrQ3QN1Q8/qajWRyihY+oZa5vWfwgWrcNu5usjS3zjFw8TjPi7GWeyUnY5JxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LVtmKV3e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LVtmKV3e"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eedc94d37so723772f8f.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283144; x=1781887944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auo6qH2KlvJG7Pb37PJ7zvLHhf77r40SAEFp2fNSyfw=;
        b=LVtmKV3eUjxFfJLOxJwk78pGjxs+7A4DaB12xO0X/ihLPjPFX6yz3lbO/V/Wdy8U1F
         +VA7DDjCv3hoUue5W7ePR3mkDzCv315E4fRWUV2vI/J1KDWCRUtPx/pU0bwvyASDP/j4
         fguW6vHtiZtYqB7M/d6hWgYMUwmVAXDOXBqTWGxy9k2AloOrFW27RVBF4F4wTjuokeOG
         sr0Owc3+gHhfrbPUxUTAMBmtHcRh/MxRW39wZA0XLBrnAEoCwDGiYDjNApJQnzYZ4Ppf
         5NvcmuFuToeXVSLpenc7l5TXeCQiABw4XkPiz4hEVufy5Ez4dJ4/pU8PEdjx0E7LyG/z
         4Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283144; x=1781887944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Auo6qH2KlvJG7Pb37PJ7zvLHhf77r40SAEFp2fNSyfw=;
        b=kz4RuUMmZ7i2EeGtM8790kEbt19efGVnHV4ApgiM8oACUhXL6nhiCgiad8TPe63Vwv
         NZ9f1sQyQhnVlElEExqECjilaIUd+O9goTiOeImfp1Y9fHioitJSzLlIiu1HNMXjiEoI
         Y+kvopTNha7KJL8mEI0rb/xYIQ+TLOyXLhklq/kMaI6K51Ww9YGNpGyZnhLXlyiN8m+h
         ZorP4ZpclZR51dIqDIEePPqSrg54MesERBKYOK6enB829RVFKU3i2siqVm+MX3OpdmNJ
         WbzhE3tjPQG/Q/jqFvDxGeVjBwqQLj5J2fORSh0XKEBLbC63wtK4DMaWFD7oQLwQ9UJV
         MItQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dycK2fi5CJBw0Vt65SJDDWpDlDTkbGM6oHpgWuPpyiz2cpyalz5EinA0Kxdrx366fwSKNp24u0eLk@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsQAgPfBVW6e8/fXYOiLRxY+xcKaV7UM689GBH9YP1ycE8PtS
	+niP7Uu3KTGbjPUOfQvxQTRG3+2qaf/pWsjUhJ7W+GfIEKskkJEcf9fQ0AL4tdLfzHj4LeddbaO
	G83kzoR8=
X-Gm-Gg: Acq92OHfhyQ4R4W7MmJetRy2xbuL3ldOZrwdtokGqHlCVMsKAM6R35QmYco3VRofzlp
	yjNMgmg5F9/Vkxbnyz6dXH20VRnv2eTGkwjK2kDuv5DpxSidbcT1upL/o7GKIyf4qNzdz3a8T/N
	kGzg5jM8hdPaWyL/uoXa6iXsibmsgrQo4sg01IBqbT0y8uHeRwn+67t+FOst2fKDycR6qqJt7Dl
	JRkNuhFzKvutTaEvlimmuSWPYmtV20DQ5gBKrPLOUZfbO7bhcOrBNvRBwyTFRqxOBW9xm0TW4+J
	Q7gWJOWez/UIbyPLgNQ5TPQ9jZT1Nb+eSt9h8mMHNq3AbBDLIdoCHbzp23rrOaNLVJZIG7HbN+Q
	URlUlN3So3cwkU22PurGzJRauM+dLTGARWVwB3ht+Gj+rbvDJA+oHGI2t5uHTxGceQXEsvc74d9
	M9A4VZeKbywxdRh5dCcg7s5d15gzfnWw1/xEMPB8YKjo2SlI+28Ptebh21bS9pLI+hxLeJ/90u/
	hrJ07GkayYywUM3W3m55c7BdKWmmxyt4sqSQg==
X-Received: by 2002:a05:6000:1888:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-4606db96bc3mr5394161f8f.26.1781283143943;
        Fri, 12 Jun 2026 09:52:23 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 11/12] fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
Date: Fri, 12 Jun 2026 18:52:03 +0200
Message-ID: <20260612165204.86137-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
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
 fs/ceph/file.c       | 14 +++++++-------
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/quota.c      |  2 +-
 fs/ceph/snap.c       |  4 ++--
 fs/ceph/super.h      |  7 +++----
 fs/ceph/xattr.c      |  4 ++--
 8 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b114ef483937..d9a32897f4f0 100644
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
 
@@ -2466,7 +2465,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	rd_req->r_base_oloc.pool = pool;
 	if (pool_ns)
 		rd_req->r_base_oloc.pool_ns = ceph_get_string(pool_ns);
-	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci->i_vino.ino);
+	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ceph_ino(&ci->netfs.inode));
 
 	err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
 	if (err)
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e50bcb393c8f..151baed53721 100644
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
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 00e62991a416..2cc5d8db40ac 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1113,7 +1113,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		      read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, read_off, &read_len, 0, 1,
+					ceph_vino(inode), read_off, &read_len, 0, 1,
 					sparse ? CEPH_OSD_OP_SPARSE_READ :
 						 CEPH_OSD_OP_READ,
 					CEPH_OSD_FLAG_READ,
@@ -1819,7 +1819,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		rmw = first || last;
 
 		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
-		      ci->i_vino.ino, pos, len, write_pos, write_len,
+		      ceph_ino(inode), pos, len, write_pos, write_len,
 		      rmw ? "" : "no ");
 
 		/*
@@ -1852,7 +1852,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			 * depending on how the request was aligned.
 			 */
 			req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, first ? first_pos : last_pos,
+					ceph_vino(inode), first ? first_pos : last_pos,
 					&read_len, 0, (first && last) ? 2 : 1,
 					CEPH_OSD_OP_SPARSE_READ, CEPH_OSD_FLAG_READ,
 					NULL, ci->i_truncate_seq,
@@ -2050,7 +2050,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					    ci->i_vino, write_pos, &write_len,
+					    ceph_vino(inode), write_pos, &write_len,
 					    rmw ? 1 : 0, rmw ? 2 : 1,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE,
@@ -2975,12 +2975,12 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
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
index 1534a91342a7..ebe2b79eafca 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1986,7 +1986,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
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
index 6dbc7859ff49..44200eca9af4 100644
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
index abdbffbdf0e6..5e4addbfc0f2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -589,7 +589,7 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 }
 
 /* for printf-style formatting */
-#define ceph_vinop(i) ceph_inode(i)->i_vino.ino, ceph_inode(i)->i_vino.snap
+#define ceph_vinop(i) ceph_ino(i), ceph_snap(i)
 
 static inline u64 ceph_ino(const struct inode *inode)
 {
@@ -634,9 +634,8 @@ static inline u64 ceph_present_inode(struct inode *inode)
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
index c5e9ef656b5f..cffb9236d4e0 100644
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

