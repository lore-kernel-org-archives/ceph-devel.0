Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211D38B7CD
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596939; cv=none; b=axJhSomerd4d3iMUThMJhsGd4OzltWJy+CfNp0hOcDPME8afkiKCNHZvULAi/qCRdoTRzuj64D3jtyakBOf1712rybjPwe5Y28wTQm4cZHYosKXNhWoPxKZhGsL1h8NEAcXNde4an8Zd+If9m16ocyR9zx1H/EPHkzdERW2+H/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596939; c=relaxed/simple;
	bh=8f4/Y9OGi6UWa4fmkrLPrmDMstvmz81JVDu3GHRUtMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8RpQiyh2vWb4eKrlKcIYDPxhCpDSDZ+i4v2P3ReRDwIaxb0TNQTtM/EatrkAG7n+5NaUqmrh6Rd5zrfrqcslKztBrJ+YtX9EdKy4v/bqo1ZYiWnE+IxjP8EFoiMjQudHbOd4MmguB1VDyphGJ6821Qv5w37q7uitV/28zxcfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GVnWcjp/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GVnWcjp/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso6522716a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596935; x=1788201735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tCkqN5jp8QCX/lQSQpuYbF6YkmDquhi+IixAaPDZQM=;
        b=GVnWcjp/wJFz05hYpRU61nsvL1YPYosgxKisBKPqhpPkbh9eWi2Ia529GMpXhZ2liH
         q3xaQMorgxsmQmuJkC8pubFYzz1io4Z7O2VeoPRJSDFqaoLEC+T0E7uNIeZWw7f9vIJd
         pU3ucNJcWrBPtR+lsGH98It4fDh57+UIRG/jA/1we/IqOMEYJS/FshulffXSjhMdC45P
         ueB4P0aVmcWj4hPRdN5PnQmEzXB0kG7JMLQ9XOOUWsXxUYYl8ngMEp+GGllQm6YQQvBz
         +ms/utIoMVvRnvXU1YvdpIN1CAyv1T1PFhy/W9Z7rlVaBKvNRX9SaHux9zEvwOChg7lp
         R6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596935; x=1788201735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5tCkqN5jp8QCX/lQSQpuYbF6YkmDquhi+IixAaPDZQM=;
        b=CqLXishmQIk5XmmbRLzJLrYf9bf1Vfc4SURcQ+DtdaWYBRhFHTRyXjbCFC658/7t8r
         Jjt8IDygLX5DEoITHR8tDU5CJBxdva0ib5RP4eXtwLbosqiYkE32ZdfJZeoTlxPKjX7n
         HDlYa6KIvsjdokUsOcMaIyw9UBxBP5JcUlh7r3EO9uLvR2DTVDPNeJfYNYMxUrULLMSf
         f0pWtx/ItRppYSpvIuk7LuZByTBMU/1PHyeAkB9vOxSzkPfdYrdxpzukV8ZnP59hbnvf
         9MF1SbI/xUq27CVqjSY+SUcZarJ1T3yJ6bOWKqrieTh2n00gPwUa137YPFxWAsusfcfP
         NXHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoljdV+8PMaac/GjLDeklKXbvBAF9xgVQ+TZNuroHCMPd4/fsO0qldQYEk2e6Um3mNjbRBplljy5JuF@vger.kernel.org
X-Gm-Message-State: AFuF++mnUvETGi0M9tqIbAI9xoRQ/QJKCibwFUTU/hOixXpACddI7VRX
	AgujehhLm35PxPVuW/JEJwR3m7ivUS70InBn0dngWm0w0aHks1HhjaP+qYC4i6keXl0=
X-Gm-Gg: AR+sD13mwPPMgZPbsaDuVu9RQzzaSO08XiKLLPXDEOPSHo3H1rXtgCbH3Th+nzdB/Vh
	D+dzL+GXq1wzei/qIUfKuajE5DYrF3wM9s+pTQL5aHXrCrJVJ6QpPq11wp2ahLaUpO+Q97ensJz
	/4Nt8x5R+7EyJj2w4JYpI/GxNCJ2ELHshMSnityvoZwSsRzppo1QabhH3QW1CZCzJTF3DXUs2IE
	aKSM1Yr3vaPG/IRASmHDvCe1YNKUpF+WRwNHMcz5hREwjkmYP0c04BlGjT0QUG7KmZI3uzXriKu
	Uu2dpHEKcQBhXMD9aRuYk5vHzvrT389KJ2WVrp4I/Qyd3FjGXxGdvCwn0asq2SQKtL80CuCB1Qu
	ZNSKXjQ0IHCYWtyUX64/Hl4+p9oiQrkgS58JrADty7JADcIF8+hxp3NgEeJpkcJLPtYmQuJVqHl
	qHdQ3U6xKCv/LQuUn7rJ88u/qOQrOfxInjzivfvJArvRlTMVd5Jlmkyi+OgL6HjSPRBA4jof8gt
	yay8AlsBCh88cCXZI9I2EGduE56WdckOgo34OwL3q/wY2QDFhGJhP5lGCXn8gRG
X-Received: by 2002:a17:907:728b:b0:c24:c250:a6b5 with SMTP id a640c23a62f3a-c24e5ae23b9mr36253966b.12.1787596934652;
        Mon, 24 Aug 2026 11:42:14 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:14 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 08/11] fs/ceph/super.h: add `const` to helpers
Date: Mon, 24 Aug 2026 20:41:56 +0200
Message-ID: <20260824184159.240821-9-max.kellermann@ionos.com>
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

This documents that these functions do not modify the parameters.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index beb7009f793c..4b2a1568000f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -589,7 +589,7 @@ static inline u32 ceph_ino_to_ino32(u64 vino)
  * we do want to set it to something, so that generic vfs code has an
  * appropriate value for tracepoints and the like.
  */
-static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
+static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 {
 	if (sizeof(ino_t) == sizeof(u32))
 		return ceph_ino_to_ino32(vino.ino);
@@ -599,12 +599,12 @@ static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
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
@@ -819,7 +819,7 @@ static inline struct ceph_dentry_info *ceph_dentry(const struct dentry *dentry)
 /*
  * caps helpers
  */
-static inline bool __ceph_is_any_real_caps(struct ceph_inode_info *ci)
+static inline bool __ceph_is_any_real_caps(const struct ceph_inode_info *ci)
 {
 	return !RB_EMPTY_ROOT(&ci->i_caps);
 }
@@ -1077,7 +1077,7 @@ void ceph_umount_begin(struct super_block *sb);
  * a cap_snap is "pending" if it is still awaiting an in-progress
  * sync write (that may/may not still update size, mtime, etc.).
  */
-static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
+static inline bool __ceph_have_pending_cap_snap(const struct ceph_inode_info *ci)
 {
 	return !list_empty(&ci->i_cap_snaps) &&
 	       list_last_entry(&ci->i_cap_snaps, struct ceph_cap_snap,
@@ -1174,7 +1174,7 @@ extern int ceph_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
 
-static inline bool ceph_inode_is_shutdown(struct inode *inode)
+static inline bool ceph_inode_is_shutdown(const struct inode *inode)
 {
 	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1358,7 +1358,7 @@ extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);
 
-static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
+static inline bool ceph_has_inline_data(const struct ceph_inode_info *ci)
 {
 	if (ci->i_inline_version == CEPH_INLINE_NONE ||
 	    ci->i_inline_version == 1) /* initial version, no data */
@@ -1433,7 +1433,7 @@ enum quota_get_realm {
 	QUOTA_GET_ANY
 };
 
-static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
+static inline bool __ceph_has_quota(const struct ceph_inode_info *ci,
 				    enum quota_get_realm which)
 {
 	bool has_quota = false;
@@ -1466,7 +1466,7 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
 		ceph_adjust_quota_realms_count(&ci->netfs.inode, has_quota);
 }
 
-static inline int __ceph_sparse_read_ext_count(struct inode *inode, u64 len)
+static inline int __ceph_sparse_read_ext_count(const struct inode *inode, u64 len)
 {
 	int cnt = 0;
 
-- 
2.47.3

