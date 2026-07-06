Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BE3EDAD2
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322719; cv=none; b=UPHEKgZgwBZm8ocfeY8vyyyAowlgE5aMa5fjfMWjN5hlliVGtNScrMM6gXVEaRE2yFewrNteadf6fCeKyuwI6buYuSYkLoXrbiurphcTDc9colYtczRslM3Q7wcx1Dqb3VTlEJ2iyrwkZOxytPcIRp04QcvTLAP5MJ9qtlo+piY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322719; c=relaxed/simple;
	bh=uwMVf0O38dwYPksuPIL39EvOaE6wl/Xh+HGE7GDWUgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTV2rTZL9KihCKm0tAdsAINhsvJnRiO6WxOKH+zuCmvdkMJsaCxB4OQ60aqcKENXmRJie+FVcfzwBj/dO97NEFux729YKxbc43Hg3HIygYdvKQO7imTSgY/2nqbpnCeXIZpAyvqIP1LYqFs2sTpt5KVNKdN5ldZym1CHv96uQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QNDhVcN3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QNDhVcN3"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso2821117f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322702; x=1783927502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=QNDhVcN3FjKwYmPVMS1KdV5Dk2Sb67GpO46qAwxrYpwJAaorQ4jfD3S/40cz+TQohX
         otQGP6r03pDuGrm8szPkBJRvxZCHyrZdo+g2E7CudLht0tv7KI8BU4bCxoFg1KOar6T9
         BxEvIekQ0+U9g09JWmtuGG3GxlCq8Rzbl7v9DAUpW3tMbMbCJ/ZwS4Jc8ZTBKqR/0vEc
         aME8JZmoaSOoizhJ5w2pH05R5fESsSslGUz7HgAm/ciPm0kZaVGK1XnWFV976e4qioVa
         pfELaGkk8TEDUImqLxN+nYdhWKdo9JP0IFCMcLkXEopgjbKK7O68Oq2MC7C/1t3QGiZo
         wNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322702; x=1783927502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=LVKdXdq91a26+R9Rf56YboqNTBQUHwkcIKxsNFu4FD38uG2oHiEIU9oIiogImZLbw6
         3rU1wgnyNDMT13SKBgBNwQ8ZCQR3WsNsIUgFqgPIb3YtwVrUUNsBpZQir/S9Le4Tk15c
         j/kvwU/uTCevG7N2V5ZjaH4L+R+0rXFo5SZvWEAeeMv1PciNisrb5wx22X7XKrHQKBTo
         6M9N3kriojkMQJPCL0kCJ3dTSBEQNjTpeBUjmSgvsGt9LLN+q7SPSUnG7ZC8e9Rt2txf
         Eb97XJg0NQ/T7UQC8cb8w67LTG4c15DFQWRrcsZb4d/XJCTL6aZ/OPwAJEEQ3DbD5+Xn
         BNeA==
X-Forwarded-Encrypted: i=1; AHgh+Rps+P3tHahmOFFyahzlYE7O0+MjU6IeohAdO9fj7O5cSn+lvyIDu43393QR9wwiv+ceEAg/Ypd0eE3p@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCAJTwDpraeVSjt9qACWsGNNNJp371/aNX3x4G9CsmHutKM5o
	dD7CfK0VAeXRdSShb+3Uno2qXdIyR1IwnWyWu7K04FpQQ1dVaOxZwpXhGnvgqeNWWuw=
X-Gm-Gg: AfdE7cmftXnLgHpE1Hb5o+hwRL0bWAiztOcB9ro67odaM64bw2K7twak9DcdQce0vUX
	UX1raU9zbZlokSpH5/ccn5l1wRZtiGgGE+DmLs0tVye0KnVGg+FEEE2FM1vQlYYsTsmtFASlvx4
	BeEjDHg6ogTZ/2XeMO/ZmbTbB/cmxwamUg8dj1DRF5EeSCEz4j4esdwLmtunmgDiClEaaNqsdwI
	Z9hKCNW2oYaGQ8ZCBj3qP8RgfZpZCrukkVxJWUMJE9I2RXuZ43G3CtRhjO0tJQ/DGA0bKha+nCR
	a7kK6t06bi0PH+3DRFcR+FdRipSSo3OKCpN8jByBq4Gf3qcRsv9f3ZKyEQ7hfz3OyRz2zZHnwVa
	2JcU+NesVbBsxjy2clrfEppmbs5z11aA6Ojtxy20162c/sqJrhuOPMMX+s8CWVyCcww+t7yXkzT
	CkE694J3eFZdt/yhUxTjC0BCNtooD1D4GAtsyMg/BgxNVUKLwQEuOok2a/nMz9STuVcFIVhbQ91
	qCt3IqFXdfekEMl
X-Received: by 2002:a05:6000:46cc:b0:46d:d6e0:9cc6 with SMTP id ffacd0b85a97d-47aac4eb1cbmr6848654f8f.44.1783322702115;
        Mon, 06 Jul 2026 00:25:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 09/18] fs/ceph/super.h: add `const` to helpers
Date: Mon,  6 Jul 2026 09:24:40 +0200
Message-ID: <20260706072450.3920010-10-max.kellermann@ionos.com>
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

This documents that these functions do not modify the parameters.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 35399689f0c1..ab6fa8319c79 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -588,7 +588,7 @@ static inline u32 ceph_ino_to_ino32(u64 vino)
  * we do want to set it to something, so that generic vfs code has an
  * appropriate value for tracepoints and the like.
  */
-static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
+static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 {
 	if (sizeof(ino_t) == sizeof(u32))
 		return ceph_ino_to_ino32(vino.ino);
@@ -598,12 +598,12 @@ static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
 /* for printf-style formatting */
 #define ceph_vinop(i) ceph_inode(i)->i_vino.ino, ceph_inode(i)->i_vino.snap
 
-static inline u64 ceph_ino(struct inode *inode)
+static inline u64 ceph_ino(const struct inode *inode)
 {
 	return ceph_inode(inode)->i_vino.ino;
 }
 
-static inline u64 ceph_snap(struct inode *inode)
+static inline u64 ceph_snap(const struct inode *inode)
 {
 	return ceph_inode(inode)->i_vino.snap;
 }
@@ -818,7 +818,7 @@ static inline struct ceph_dentry_info *ceph_dentry(const struct dentry *dentry)
 /*
  * caps helpers
  */
-static inline bool __ceph_is_any_real_caps(struct ceph_inode_info *ci)
+static inline bool __ceph_is_any_real_caps(const struct ceph_inode_info *ci)
 {
 	return !RB_EMPTY_ROOT(&ci->i_caps);
 }
@@ -1076,7 +1076,7 @@ void ceph_umount_begin(struct super_block *sb);
  * a cap_snap is "pending" if it is still awaiting an in-progress
  * sync write (that may/may not still update size, mtime, etc.).
  */
-static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
+static inline bool __ceph_have_pending_cap_snap(const struct ceph_inode_info *ci)
 {
 	return !list_empty(&ci->i_cap_snaps) &&
 	       list_last_entry(&ci->i_cap_snaps, struct ceph_cap_snap,
@@ -1173,7 +1173,7 @@ extern int ceph_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
 
-static inline bool ceph_inode_is_shutdown(struct inode *inode)
+static inline bool ceph_inode_is_shutdown(const struct inode *inode)
 {
 	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1357,7 +1357,7 @@ extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);
 
-static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
+static inline bool ceph_has_inline_data(const struct ceph_inode_info *ci)
 {
 	if (ci->i_inline_version == CEPH_INLINE_NONE ||
 	    ci->i_inline_version == 1) /* initial version, no data */
@@ -1432,7 +1432,7 @@ enum quota_get_realm {
 	QUOTA_GET_ANY
 };
 
-static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
+static inline bool __ceph_has_quota(const struct ceph_inode_info *ci,
 				    enum quota_get_realm which)
 {
 	bool has_quota = false;
@@ -1465,7 +1465,7 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
 		ceph_adjust_quota_realms_count(&ci->netfs.inode, has_quota);
 }
 
-static inline int __ceph_sparse_read_ext_count(struct inode *inode, u64 len)
+static inline int __ceph_sparse_read_ext_count(const struct inode *inode, u64 len)
 {
 	int cnt = 0;
 
-- 
2.47.3

