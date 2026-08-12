Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7539D6FA
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566610; cv=none; b=faUM/Wvz1ZMZZllJ8ZjIqzkOQr2cdlkHX/5ETVylhAxReBpBkmw3M99WdvZCCiy17mLeCXKAlkX7SsPgi2Q0g3Vgp301rVCb+LuPHu4O2m0jNCDI+uXjvUQgdO4cjJFuLduILU7m++4FzZkvLXGMo+SXEK9h8GivIixib8V+hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566610; c=relaxed/simple;
	bh=ItMu+kPTmFZnDgkl0OWkN0vhR8c+L6Q5g3sYeFtqIxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGWe8XBBdUHAGJ0z5T3xa8VYym4e+ufFrUDRpVk1lnfsVRmyC00J8ip0NyM8WIa85QmwLcLU2BuBa4tu/JctUZQIwxF9o+gkn9kmY6ZiwSLTZ9mjyq98v+AuM42/bWqjk02s7yzKJF3ljKgqpDlCltzPNBO6AcrL8SO/5iC+96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HuJfhdlN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HuJfhdlN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fd66a094eso524595f8f.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566604; x=1787171404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrwzJCwKgkiHPJrVYexM5E0v3kPPNtTc3vEMJzL4u4Y=;
        b=HuJfhdlNWY7CjLaDwOXPfYnvjTtv2XA8b3Gbo/4zuxvre84d6aiwPbZYBL3HR33SI3
         euAbxXFwuzjmGmIZh7hfd6exzzWtkwqsoyOF7VBE5UJTiRkcHC6J581P4Dj1EhGoPh7R
         YVQY08nQ3zu1bHwM6tXVUZky7aeIuN29/Swi8DukFAwVn9r/xGu0XS6ecxCRezenRyrH
         nSWZ9YN1W9OzZ0yMGYuHu3WPtRsJBZtCj6SPbgf1W7aHKyz1emlBZpwz30nSIKdPpxwx
         UfgMbdzX0Ry81OSipzGtssYucSQmMhEk5JzgVv2mlyJgiQNL3n5OScIAuFijg+QFuw/P
         CYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566604; x=1787171404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrwzJCwKgkiHPJrVYexM5E0v3kPPNtTc3vEMJzL4u4Y=;
        b=sqJVt/+rsMhd02WKm66vCsqZCoYa5nUs2oo/yLm5gwq8Qc4wcOTrqbat1GhquzmDEO
         B98XI9LKyaJuvH/2KToRYrUsm/e84GfeQKBjfhbvh9YsUgTbyv5Vnd86FAxswiVIQqhg
         hynqSP+x6BoyPMjpyfq5HwXl0ap/6wbAs9LDs6Eb5XFLe6oXgVAys53vUOyuRDnGatuM
         mBFcgshQVl2Ch7jEsazu6HbWaaw6Sqaxx8Gq42sPYSWAvlnu9SZ3mDKjTS/PzXNuG0Rv
         DhhXocTKgnQvSlHpG4ax3y8whpbx2B4UFbLWj/fhY7eIlInzv2K3iFuyzQBJhzPUU54B
         a+YA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1G8KIYwofyB4UwiZuiQIg11yzRDhQowSpFJWLtcDyk7ah/ZOkc7XSz+Ib0ZK2drgy3ZlCgduOtoyL@vger.kernel.org
X-Gm-Message-State: AOJu0YzEK+iYGdt1WdTNbundJPSr3z8aJdnDuYLiKeRVqVY9swScFIR4
	m0FoKq9PD/oAcVIcPRX7xG2lE3xsB9De7kc2HCEb53kEwWb0MZbKM13tYCS8ucAipxY=
X-Gm-Gg: AR+sD10Ad5sFcT01jgrvn/GmO/FEKFdaAQrVdDnOjJ+F9r/oVfody+oo6J6vy3imQym
	kLGKG6etA96DxAD5UgmvbRZ5zu32NsICJyUXCP9ppQr2ieNBEtXwH0pqPfAYN6NWks21ceBSCFb
	7PG6RRvFykDqWa/xg5A4/lrSwXpXKSETyvVf7QcR6yfAkPIZeic9Ne+tYA3nHGQpau2Rhk/Skqt
	4G2vZj9bOEQItGnkBIgSQ3fXvjZpCEC6dln7Pa4Y3cKXz5auFzUYCbpzxnxmYrB0I5QVIdhkC4y
	ungl7wLBUcLxY0KPZOBnRf5RZoJ+CRQe5DGJxKS02bwTufqniJensw2hddANs+VzFpOifChFR8r
	k+YBj0QaYSwF2WFeix6OaQ0miTvodxc0Hw//Xn5o4s6h8rOONYHgNdj6FLsQdoHlK/IB/AzJPWW
	C/7yRczVVfmNpC4wZqpKNGg7Ru4XUDI288VdqGU6DxcWjUiapA4VxO9hl8BnrI6gnIABJpqfG4q
	K4QupjmDwIzzxVlCZsljOITHw32Z77rMllXCpty9MZwvVngfU65gr1hmlFCOD/8
X-Received: by 2002:a5d:5589:0:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-4815a00e64bmr720119f8f.28.1786566603971;
        Wed, 12 Aug 2026 13:30:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 12/12] fs/ceph: remove redundant inode number from ceph_inode_info
Date: Wed, 12 Aug 2026 22:29:49 +0200
Message-ID: <20260812202950.1800340-13-max.kellermann@ionos.com>
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

On 64 bit systems, ceph_vino_to_ino_t() is a no-op, and inode.i_ino is
the same as ceph_vino.ino.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/cache.c |  4 +++-
 fs/ceph/inode.c |  7 +++++++
 fs/ceph/super.h | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index f678bab189d8..289615e58196 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -16,6 +16,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_vino vino;
 
 	/* No caching for filesystem? */
 	if (!fsc->fscache)
@@ -31,9 +32,10 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 
 	WARN_ON_ONCE(ci->netfs.cache);
 
+	vino = ceph_vino(inode);
 	ci->netfs.cache =
 		fscache_acquire_cookie(fsc->fscache, 0,
-				       &ci->i_vino, sizeof(ci->i_vino),
+				       &vino, sizeof(vino),
 				       &ci->i_version, sizeof(ci->i_version),
 				       i_size_read(inode));
 	if (ci->netfs.cache)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index aba98975a8a3..e82877782601 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -44,11 +44,18 @@ static void ceph_inode_work(struct work_struct *work);
  */
 static int ceph_set_ino_cb(struct inode *inode, void *data)
 {
+	const struct ceph_vino *vino = data;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 
+#if BITS_PER_LONG >= 64
+	inode->i_ino = vino->ino;
+	ci->i_snap = vino->snap;
+#else
 	ci->i_vino = *(struct ceph_vino *)data;
 	inode->i_ino = ceph_vino_to_ino_t(ci->i_vino);
+#endif
+
 	inode_set_iversion_raw(inode, 0);
 	percpu_counter_inc(&mdsc->metric.total_inodes);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 660125d94f8e..e5ab1b83a84d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -378,7 +378,15 @@ struct ceph_inode_xattrs_info {
  */
 struct ceph_inode_info {
 	struct netfs_inode netfs; /* Netfslib context and vfs inode */
+
+#if BITS_PER_LONG >= 64
+	/* on 64 bit systems, the full Ceph inode number is stored in
+	 * netfs.inode.i_ino
+	 */
+	u64 i_snap;
+#else
 	struct ceph_vino i_vino;   /* ceph ino + snap */
+#endif
 
 	spinlock_t i_ceph_lock;
 
@@ -570,7 +578,14 @@ ceph_inode_to_client(const struct inode *inode)
 static inline struct ceph_vino
 ceph_vino(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return (struct ceph_vino){
+		.ino = inode->i_ino,
+		.snap = ceph_inode(inode)->i_snap,
+	};
+#else
 	return ceph_inode(inode)->i_vino;
+#endif
 }
 
 static inline u32 ceph_ino_to_ino32(u64 vino)
@@ -600,12 +615,20 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 
 static inline u64 ceph_ino(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return inode->i_ino;
+#else
 	return ceph_inode(inode)->i_vino.ino;
+#endif
 }
 
 static inline u64 ceph_snap(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return ceph_inode(inode)->i_snap;
+#else
 	return ceph_inode(inode)->i_vino.snap;
+#endif
 }
 
 /**
-- 
2.47.3

