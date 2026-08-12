Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EA399377
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566610; cv=none; b=cO4W4+k78v6yR2bWzOb7ynbP/2jtVkhdkFm6I5il7Gzfw061BBmduXCh0ISPmNA9hEfDRikNq/ZXsGm1d2oWYGL64v3cwhrpMRII26cKPBWw1GQ3J4uXcsoUxcTkfvW3u0IVBAxOwYXPDzwj1LGC0ifOd1O9q8/MuJSygi+zIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566610; c=relaxed/simple;
	bh=yU1VW+v7+vbT6B3wN45UIfC/BjVP2vAYyGNWNhw+BHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0gfc4Ezin4APNIk33l6NmXgRHRN185EkevVF+f06PtodZVXTQToMelinNSZStYLvTBXw0oZzN3MQEhZB5IKBDBw9oCiYmAspECrqDlp6r136GSCs6fFti+RAXQcIi3DlsX6l41OCmSrFPXPetBunhDwbAmZfJzJVVEFlxrFjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CLyjPbVz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CLyjPbVz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so12735655e9.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566603; x=1787171403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0GwsUU62a4nufC1hoAjEItpwFESwLtkTjaWIBNIOxQ=;
        b=CLyjPbVzAIvUNpUyyEy2ndZ+mF7puKJGrgTd1D93PjrWF+S+JgrGu7sV2mzozaueTf
         2+BKoj4A8J5RFDt3pflw+fa8vQMQjtnuFGUVk023FPVEF+YaYx05vDpbyt1qmzmOaP2h
         qySCxJUryBKGlm1GctMvf7hIl5su4hhHrVgW6sGSk8gTaIYyucHz6ZVV9WxpiwyVj5q1
         4A0emzpQdE1hkH7dm81RF9kGzYuasUr61c1gmINUROGmGu6UoCKICFd5SpsEGu1kv307
         yacMhEj4ScgMkdXqjDZL7xU8LDCu/erhX8DRLB2zs58k4dfY29WbtmEAWGhyeiGnn89y
         u29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566603; x=1787171403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0GwsUU62a4nufC1hoAjEItpwFESwLtkTjaWIBNIOxQ=;
        b=gWvnl66ZupmhQMKGSZgP8dA8HWeImlc323Hj5Id88Eekq991qGpEj5hYY+yhzOrKrC
         5zkT2cByZpMAoFuIbNeGb1GbHVy/QdIqdQemQmvb8MYfBG61u2X/D/XXQUXkXqovNdg3
         PA2Jxs3ttEg2VORqgFpNoHSC6qRFWOboc/0+Gqfh0UirXUexG48N8MeXUSe80xKj3T23
         vJLaRpWSbqELVaKYnHCKbgGI/1U7iMepE2f4PUwda4z5BlLxa1jTsio8dY4qerPm3lAO
         O0LsiNbmhxkt4s4pxGisY1eMdbot11+EfhKOiHv4Lny8We0hhnKFXqv6WDTQ3Qzy/54o
         RyNw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Kd03eGfE6SHcz28BpbVJNrtTakh07azZ39UtRqddUgdU4jnYzmrFX67dvmOEsV99y89PhFu6HslV@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMjN/BlBhx6IfFln1D9Pmpj6taEMoTxAFMaXiJdJn2bqixyrY
	NOV4XEbAaiYVoeZE3ioVPKQC2T7dvvrhSQQD9yzbHMJvlNH0qdexWSsk84JqPWAxmyc=
X-Gm-Gg: AR+sD10nzs9aqYFdflnbThG8AHTbc7Ttu8X2K8KhPHFPsevV2KSgsbayljGmmvvIW0H
	2JF+GhKiyzpBHd+42KgVmA02TtjLFGVZzRfLpnlEt/NabGE2Qg9lyanSdUH2FncHRxaYl5Eb6Uw
	4nfPA61T1vPlK+8ENOuCjfj8VmAeYYptgCtZNAmKTCDni29Oa/dvZE3/SDu3UV1y+Nh3dZ8j7Ul
	kVPeNFKdzcjMr9X4JXhOrIqQO/DiXc35FV5INNbp8P3J0lo+FpqrCx7Ji5OPujH/ISFIPGEPK3W
	/NO8TRpopGfk+Sh6QwFjVb9rkSJxKOt9xaAbtp8yqHenGtM0HJARU3fMNDywLMrzeN+MFZYYjLc
	IwA11N2HBI0opYWn1hHDGpSn0qqzu89KvrTJkXt8rIbn+LPAMyrMWFMQYZlMIAYE6FhHUr3nhTv
	kpvrk/urS6waq78b8MUC1fAiEu1nXRDAuvzmI+33TvfxsMVCeGJiaAyG9hsKikLXeybhgbdKkCc
	Q47m43DcNWiX75GmYv6d2LLA1np68K6RdS8dmW19oaoPLOuOUKoYzVFkCH2ZjL+
X-Received: by 2002:a05:600c:6309:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-499821cf32emr3273845e9.14.1786566603335;
        Wed, 12 Aug 2026 13:30:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 11/12] fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
Date: Wed, 12 Aug 2026 22:29:48 +0200
Message-ID: <20260812202950.1800340-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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

