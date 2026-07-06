Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634613AEB5D
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322721; cv=none; b=dCSKIv4LKykhz7xn7ydofa5X9vG+HHIwnpB+XtkStFru7oDcuJ3C0g92weeQkk6c1HGK1csesGmeFssGupRWo39v4yQqG3GK90e3lfn0oQUAo8yCZUNj9cEfefRIVSmuK2iki/f3xUhDWzCw3CSgHJr+NjwKiZbFepDTux9QTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322721; c=relaxed/simple;
	bh=zT6PvtFyQrq+cOgALPsK0n9K/I5nxVylB3EY5uQpbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkvegm1a8OI0oan0tSuISwJt13wPIzPWsRQIDcfZ39AfVIf7j29vxUFYTba7xF+dLpkjZn1kONpEsrEAcdMPn3BBf1nhoszLNyLdaOGkKefCZm5ouTqO4qdSj0uGc7rMjScPClvQaf+QXgiEgF8orYuzrBotTqSPxRkfiJFOnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bqSWtAuC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bqSWtAuC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1260015f8f.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322703; x=1783927503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr8u76qrchvbiMGvWKzACLQEdTwl+qWAaJmck9xTApQ=;
        b=bqSWtAuC+6194tRISfwDFtVbDc3GYKDEmb5VNPpkLOBs4V2Xqr7WUHNFQdYnxIAV/I
         viqyvZ4f7OtKZNu4yca9RSIPHa57d8mPio6PjIDvndxpGz0ocWTLYEIJv90VXOo75Gbs
         6dFvftAIKu/zRBvYN/eROKVhMYGdc2nvaWiruTc1JW63O1Gdc8E7nfy8PDfgLUPCuVcZ
         TfhMMNoAagczheLkaHl2u644nYuRzrdHAWilf0d8/912mMN3r0/8hVljyi2SmhcdgQNC
         /lGn9vFg9TJSKUYv78o7tRNoL5ldVCNdgl1BT7l39QoeADwaN4WdPD/SL1TUF+VTrh27
         bnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322703; x=1783927503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tr8u76qrchvbiMGvWKzACLQEdTwl+qWAaJmck9xTApQ=;
        b=B7GuVkRRgMj8YUlw7MM7Cq3uQTh1nnVaPq4PkJrN3fkQknUQ2uIjd/ONHPuSZasuR5
         GKclpsHaW2wL4FsJ3UoXllib3Ooo8g2IjcLTraEoAN5mf3G5iXsf2PyI37pTTmL1Rlvt
         vzoOff4qyy7KAKUXNrAIv+nFsJ7SJZTdJ+NZ+VgqsQjrNyie4dJ6b6sHvbtR9UBbUzMI
         OyDs3LeIa70EkakHGn20PwOS1+XxpXx6c8vV+Z1+eeZCGrFGRRUDUvv8MK0RTHhUFYPy
         A1OAS/qAyAYWGKS7FEejmHD+Hl/7W/NcdWkoq/aysI7zNJOCP+YeMrMbo1zQTYRPy95o
         rUdA==
X-Forwarded-Encrypted: i=1; AHgh+RoZDJbwr23sIqNALbPwzn3DOW4nNilNFFSw1tLFuSbvbGFrG81IJNN2PEVSYUkBAfCZDB0Ig3oGMU93@vger.kernel.org
X-Gm-Message-State: AOJu0YyER5w8NrsJhH3iwNu2AOcCWPOGj7Io05DoEQewJwWGon1hOKnj
	EEykkJ9fu2ZTCzmf+RAkIwGJnrOZPXdbdfPUs+xNXGXaQ1NOlW6OkdzPLqA7584F8nM=
X-Gm-Gg: AfdE7cn2wFlq6b1fdKlfWjuBKP5qtPYLZ5OLIOoK2vL77eNp15viunfANYxbOQ+qWcG
	s8fzpB6TOy4lw+QQt4skvCSwI/4asROUpTiUep2NAVEig65RnaNXLTqc3yubo5yf1n4Et9TTYPy
	IfV1fIuNbjNHAkQd0xLn9f1eqa8giiiWhYLOqXgWYU0Le+L3g7wu8yl2OMQcLs6GzGtO1OqYLFH
	wC9hyhJBaMPz8rDLYnRH1TB4oQuXP2F3+tueVC/XMBo2S8uHLiAzfJqkIYUULu1BjmuLW37wa9i
	e0jlmcMVzI0bz6bUUleGuVqJPNuhvgl7XUsy2RjknyID+1ZWAH91wf0pr70g0yGI/h4UXKD+mFs
	TLX7Op8XIQmkwdIumGKSUeRJiQY+lrbTuypMisKH0n8ztd8AMKuXrYxjd+iRxlkguJsz7i8xJ5K
	iU2W7MOHtnndQHgcGoapxULQkBw95d+GT85E846sc4oDoSsHOKB7Rda85dvvAfMrIeulCGDpHYu
	9QPO2BJkD+z1jqM
X-Received: by 2002:a5d:64e3:0:b0:477:f5c:9bf2 with SMTP id ffacd0b85a97d-47aace8e983mr11200257f8f.51.1783322703385;
        Mon, 06 Jul 2026 00:25:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 11/18] fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
Date: Mon,  6 Jul 2026 09:24:42 +0200
Message-ID: <20260706072450.3920010-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
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
index d03639525eb8..f627f2e28b9b 100644
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
index 372b239f6a36..00ef37312a79 100644
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
index d8859e4bed8b..7a6bff86b750 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1118,7 +1118,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		      read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, read_off, &read_len, 0, 1,
+					ceph_vino(inode), read_off, &read_len, 0, 1,
 					sparse ? CEPH_OSD_OP_SPARSE_READ :
 						 CEPH_OSD_OP_READ,
 					CEPH_OSD_FLAG_READ,
@@ -1824,7 +1824,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		rmw = first || last;
 
 		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
-		      ci->i_vino.ino, pos, len, write_pos, write_len,
+		      ceph_ino(inode), pos, len, write_pos, write_len,
 		      rmw ? "" : "no ");
 
 		/*
@@ -1857,7 +1857,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			 * depending on how the request was aligned.
 			 */
 			req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, first ? first_pos : last_pos,
+					ceph_vino(inode), first ? first_pos : last_pos,
 					&read_len, 0, (first && last) ? 2 : 1,
 					CEPH_OSD_OP_SPARSE_READ, CEPH_OSD_FLAG_READ,
 					NULL, ci->i_truncate_seq,
@@ -2055,7 +2055,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					    ci->i_vino, write_pos, &write_len,
+					    ceph_vino(inode), write_pos, &write_len,
 					    rmw ? 1 : 0, rmw ? 2 : 1,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE,
@@ -2980,12 +2980,12 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
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
index 540e1ad9ea77..b4a1c126cbc9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1988,7 +1988,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
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

