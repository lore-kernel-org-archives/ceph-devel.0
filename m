Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E639A040
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566608; cv=none; b=Q8puWBGR48TbXrBhTLswyMfcT0j9CIjUKVk+Ycy9hixurc7CM9hTG/umE9GRLIXQvdGSFckI6S4Kto79tDmj2UwX6FSjjpia/w2hIsAByBXRRFDhk/6L3PH21crWNK21FwlNSisLC/SsPQS2/fu+UkhFxUWWfLnd6jNRWsBzQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566608; c=relaxed/simple;
	bh=uwMVf0O38dwYPksuPIL39EvOaE6wl/Xh+HGE7GDWUgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf3j9FydEvZLZjnvML4bX2X0T9Wlzi3y+4CLSvkSYVL13ojCekjq2ZuB0YwWkpS5NBKh1aPfciuZZHZiMFYpEZJ46bqSNafIg53yA2uGhdUiiGdDpAOAOPp0JnLUrjBqqnjTdQTAVbff/sGP1NxxwMEyatfLCbbJEEmLbxPiPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C/c2dcKR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C/c2dcKR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980dc26022so2035e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566602; x=1787171402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=C/c2dcKRhjD6YRvjLhcN9/0daxGYiUyyBnQEJJXATnXX55xhIg6B18pyor9DmU8Ks4
         JZD0lbbY9zr/5yByC5WoGsdSIvKFjvlcvnw0ZrRKdQN6DIMHCd3NSMvbR6BUsBiddCjj
         qRmlUOVzwpkGsQMpEcIPlpiu14wcbFj2MEvqosWvVMhj8rsXxUOVVpyu6SuBV9gEat5G
         ymADTTjAUA8Yaqw35idX1an1LYjaGigd8J7vp6aZioST0QkFYrd1Me3Ry7y7CLYpGlN2
         gxqPSXNHEKFR0+JMPm0yhvyUk1b606uIX9+gO55rTeWylOedHH3E5dNQCyjrq74w8iJt
         8LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566602; x=1787171402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=NKNPg/o29wnB7V7xtGxh4dQ4lyIHeGwdYaCC5MRyflBULtGyDSRQ09nRZcUzGzuSkI
         IOIrTGDHDn3/1kL6kbC09gkf0hysNjnYUvyNapE4ZNjqMLzi1X+LNP0mvSikxswluOSy
         yaH9DZIw4OwFMJ4vewhP22dIow9FbraNyKSYMSj+XUorLqfOgK12A9hN323o9JBPNzNx
         4hARo8BKiOUnHd+BIyXWXbC9rU58QzOUNsslyAdc8UWC6llJvEQxRvEQ6Zfgo5d87G5i
         i1NDVCqerKxXrBYknzHbzKsAdGw6P2avQjhw+cv15HSb4ibWHIfv5Zgu/xBC2MOhtvwr
         FH6g==
X-Forwarded-Encrypted: i=1; AHgh+RobN8SS+DLT4g2YCp3F7wicemH3t4HH4YDr8Br7nXz9IlWtPbehb0fAnif6noK1H+usK5u/XKDPn/VE@vger.kernel.org
X-Gm-Message-State: AOJu0Yztc3IflFO/2QIp81GD1vb5LIyGFj6luM3pMImNgvLp3UlRKFcb
	ZczzGxJE5HrNSG0Mf8+BPvy+lEXVZiv1pqREbES6vD98M0TEwZLX3GKl7TLYpQLLgoQ=
X-Gm-Gg: AR+sD100ufAc1ERuSPE5YwqwvZQ6IBwAl6a1vKo1v8JI/aPcrNwOfoc0XMXgIBFihvj
	UbA1JyxqkrSdbjs+p/5pXl93+0amGHbWdXE9H5Rk0wE7WKxXZrjT0WW0AOWI0P+BCIWfmiOixzQ
	otzD9EZ4YS4Ok3DeTa5XaYxkiYk/gsf8NqrGEQmYBwnea5pNdhaCinFu3++fJjGTJw8qHYBPurh
	w5HQMwhYeUX+AWROiCDnE98+f/2XAAFpCzXQfr/j1ReXlAAwA8pop+TRHu/cdx6rm4rFJMbhj2E
	aWkn9cRxYIri1mI6iLFXMvHRZ6mrPgfG3uUPFFnftAe0jebOhvN8SE5ItSdbD7LWyF7F6pZL1Gj
	D55dxGQsRsoQXgV3lPuW15vP+rudPki6K4tgT1C9BEnQnEVk2Tgl+JrWkJ7TL8prPjQB4y/AP4G
	6Db6cgJ554rXpniDPIDKsk6rOeueGRWWsrrju4ubLh4YiC4fBO9ICqedkAn8Gmo8qpwxfL7kkwN
	6SgeKmBH/gSv8lzjKDZxl6uuKZ5h0IStjFSpzy+YEYoPGg+ZZFuMz/oyaJPPlsM
X-Received: by 2002:a05:600c:810a:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-499821fb5f9mr2578085e9.15.1786566602024;
        Wed, 12 Aug 2026 13:30:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 09/12] fs/ceph/super.h: add `const` to helpers
Date: Wed, 12 Aug 2026 22:29:46 +0200
Message-ID: <20260812202950.1800340-10-max.kellermann@ionos.com>
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

