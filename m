Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADF403B13
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283146; cv=none; b=qFoU/De704r4j7pX5/BHE8LkRh/IHd/j7ZgolL+B0T2LXqmSFu2vv7rxOQtvaswpKwJhTh9Ls+Pcxw2/Gjg0y6Pyz7GEKV/iRFf911eMrtJ3wuDJz5cgqBEpwN+Oyu9Lsbe9/hj0kAmLoL7rQbuBHsCn37Ilfoo9PN6euCn5WG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283146; c=relaxed/simple;
	bh=Rf4UB8v0iThmvij98UlaQfZ5ZsB3+D2Q0z/hidO1xUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIrK2+hgIl0mDnBit/JW55rzzdq08gRVYt8Qy62kZeHxBckTJHQm0WTUYU5sKrZJOwBM1kGe5hnOCQjz4LoLR4fPhJ3NivAwgP00ADE0WwLkxl7MzLtkisj3z39Q/x+83e5KoZuLl9XH+LyvWPiHu+OT1O8aAM73rLXBV0PfrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AolOmcKx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AolOmcKx"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-460662fcb4eso819820f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283143; x=1781887943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFYPGnV9JZG8KG8wwu/dAxGKjUjQJd7Q3DIzzqa6rG0=;
        b=AolOmcKx5uS1nX7J0Mq7LRAahMdg4VErFHQHkLRZzIUxubRugYm3qiRzp5Un7ZWEGP
         8+3cMCR1G3bjwb3reEgUX8jR9/K3QKnYIXD0u3ApLrUR8T5+59pWk7fANxz6jthgeOOq
         PcjapYEL9FQfmS7xr9Mg2FKOkzmZJv2cieVejMvIfjvlAJllmLayrvdFd+SMPVLW66lu
         17BRB8Da1k+W+hvIyOGWomY+sjbd0q7iyBqtVcuonPoVKBxqvI4mxMv0O6my8/wPU+hD
         HAIzJfttevd3gAxY7Rta1xoV6RnuQ474BlJLwYRqTw/p8dc9FqX8zhj7pVWRdLX8FnDB
         tWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283143; x=1781887943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFYPGnV9JZG8KG8wwu/dAxGKjUjQJd7Q3DIzzqa6rG0=;
        b=qsIRY72ZEe692jzu2FpOpwEyUFKvmTIgqeNOMgowd4XSNj30EDSz65vOuNWg6hc5KV
         VXIkg9NXE7mE+uNiV3kyrvgsFsSMis6WksdhqRzfJMKNMsfNEqCLXNuMihc57ACToA0r
         Yg7+SyneBvqapZGLX+IwSbxBaNFl+eWR++XHdZSPh/xQIIJ4EAPLPtsq1nj4A4booAjk
         DbsBtU35Khz1OkirFBWTiFNK9yWJsJzPv8M4wTjqTauT6NGxt9zjmx0xcWhADiLQZTuB
         fu9kF9nnrjjL54jrt/+W4YIKmk+fx03JCSbB90f3SzVmJZiXPcX54ZT+nOi/Hk5FkHx6
         fsPg==
X-Forwarded-Encrypted: i=1; AFNElJ/IJypdcHEkJa8/6Vy4cf9zTXRmxFP/QfcFcQ7Da9nIGDsG03aKHguLbQUv4lb5g8Vfcb3BbVOqb96n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzy75g53L7ynwfNqqXsaRG6TYsefNjFbZ63fsLIlMblI/Aa11Y
	6VLGV68mpDSwCNINTlhxN0TrHUaq/1SIaaYj1764PQFaP14aQjY0D40qjK0HkHt8LvCq+9fhDXm
	vuq9oixQ=
X-Gm-Gg: Acq92OFpR7Y9sY2n5Vh2+sLJDWz8CEofrF5N7o4X17T6539aN0XEojRHicQCrDNy5vg
	otGG10j00BD4R1RiohlDTL1AM712yg/+nWi02mYIDkbfjdPbzaFPJO3sAZcEZyE6f1sIg3hBnNW
	ZrpPsIaRJVDHYJvX29/07tjZKaH1CVp/oBx0F+s22tM37I3le7ur5DpV0gwsMDGX/0QsYumJA4K
	X62fHMxxabDb1ke/aRp+fnHPFv7U9dwCtPap/sh6vWiiYWRbSIJiIZ/m4NqmVutGJvTcnJN9pGN
	gEODUrFpic8fLOQvVsol1hmFkCjeTI+79W/nhyOILksYAVSTk0eombx+pnllQpRnhzpJCmi1CC4
	mp68b3Pjt79edYVnyc3QEYpn0v2Gw4eVW1vkRyI9FHMrEF5NbSZBoB6Qw7BzcYGkLFVfotS5I1T
	aYUbtCR29cfwBMMWRiwVJGEcO05PExCIERLWtGamZc9A9hBZnRfQaipaPzdxWFrBta95Xi7KFOf
	wM1isHRQXPNfzwuzEFnTmpNxQE=
X-Received: by 2002:a05:6000:220d:b0:45e:d6b2:e6a5 with SMTP id ffacd0b85a97d-4606dbd7834mr5528708f8f.34.1781283142655;
        Fri, 12 Jun 2026 09:52:22 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:22 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 09/12] fs/ceph/super.h: add `const` to helpers
Date: Fri, 12 Jun 2026 18:52:01 +0200
Message-ID: <20260612165204.86137-10-max.kellermann@ionos.com>
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

This documents that these functions do not modify the parameters.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 19f26724b285..b1d38fa6647f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -581,7 +581,7 @@ static inline u32 ceph_ino_to_ino32(u64 vino)
  * we do want to set it to something, so that generic vfs code has an
  * appropriate value for tracepoints and the like.
  */
-static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
+static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 {
 	if (sizeof(ino_t) == sizeof(u32))
 		return ceph_ino_to_ino32(vino.ino);
@@ -591,12 +591,12 @@ static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
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
@@ -810,7 +810,7 @@ static inline struct ceph_dentry_info *ceph_dentry(const struct dentry *dentry)
 /*
  * caps helpers
  */
-static inline bool __ceph_is_any_real_caps(struct ceph_inode_info *ci)
+static inline bool __ceph_is_any_real_caps(const struct ceph_inode_info *ci)
 {
 	return !RB_EMPTY_ROOT(&ci->i_caps);
 }
@@ -1068,7 +1068,7 @@ void ceph_umount_begin(struct super_block *sb);
  * a cap_snap is "pending" if it is still awaiting an in-progress
  * sync write (that may/may not still update size, mtime, etc.).
  */
-static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
+static inline bool __ceph_have_pending_cap_snap(const struct ceph_inode_info *ci)
 {
 	return !list_empty(&ci->i_cap_snaps) &&
 	       list_last_entry(&ci->i_cap_snaps, struct ceph_cap_snap,
@@ -1165,7 +1165,7 @@ extern int ceph_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
 
-static inline bool ceph_inode_is_shutdown(struct inode *inode)
+static inline bool ceph_inode_is_shutdown(const struct inode *inode)
 {
 	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1349,7 +1349,7 @@ extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);
 
-static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
+static inline bool ceph_has_inline_data(const struct ceph_inode_info *ci)
 {
 	if (ci->i_inline_version == CEPH_INLINE_NONE ||
 	    ci->i_inline_version == 1) /* initial version, no data */
@@ -1424,7 +1424,7 @@ enum quota_get_realm {
 	QUOTA_GET_ANY
 };
 
-static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
+static inline bool __ceph_has_quota(const struct ceph_inode_info *ci,
 				    enum quota_get_realm which)
 {
 	bool has_quota = false;
@@ -1457,7 +1457,7 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
 		ceph_adjust_quota_realms_count(&ci->netfs.inode, has_quota);
 }
 
-static inline int __ceph_sparse_read_ext_count(struct inode *inode, u64 len)
+static inline int __ceph_sparse_read_ext_count(const struct inode *inode, u64 len)
 {
 	int cnt = 0;
 
-- 
2.47.3

