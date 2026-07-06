Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEE3BB68B
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322715; cv=none; b=LUqnWujDUnRft6/4f1S2ilYcYQOjI4q+yD9k2b/RzocB48p/iDKZmyrFSXNrakkEas4aiQh15AEYrU38zIzMp2jlYeQuD/H7XiSjEwJVmbHQvtujT44suqMdS/S6rBfTM4cFxBr57fHnRfJb6+OH7uROCblxPy8VuvJEObafgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322715; c=relaxed/simple;
	bh=ItMu+kPTmFZnDgkl0OWkN0vhR8c+L6Q5g3sYeFtqIxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7AcdddeGVUu8C7NytVw7UzVS6E7P1yjFIktOYnTDFELjwscq6SVZus7tafnC3+0EN8Tcy4T9ipeMUjwRiAucDBe+Wpcw7TDJGvcA/5QZOc8ooaAkVMQOIwpMWv9JAvmOQj51/bBpI+D5yPuYLw1pulZawPjWqguc3X4pzP4BXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AOnM+uA5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AOnM+uA5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d70879764so628486f8f.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322704; x=1783927504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrwzJCwKgkiHPJrVYexM5E0v3kPPNtTc3vEMJzL4u4Y=;
        b=AOnM+uA5o2jI5/AbOx4fp2pRzJTfeSKdHk5YxduQ6gv+6K4oTKnQGdZgecHRol2jdl
         LzHuuOwesoUwcJl0X7B355yRCgPBozRmSOAiteKsqXwmLLKWoE77OiTL8NlL2DtmQSQ+
         m+zduBRtwqbEgER0iDnO9cDE4wNiL6kilhXc981+KmO++JAozj5IrbAOAKFwJk6HfMa6
         OjAAZRGbRQgar8LR9L8vr9d5He2pGpGrf1608GIVC8SMKMFVCJ3YndL27qN4kCdlcSvl
         JrOSXz0tY1Ktmsge2OeAzfC205SwWHOmqoCi7iJJHAfeKLIP6dkUqsyUtO4AqdTXGQyX
         v/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322704; x=1783927504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrwzJCwKgkiHPJrVYexM5E0v3kPPNtTc3vEMJzL4u4Y=;
        b=ZjFu9L4fzDOe8M5bPQu+7lBbYbRBKD4c66ZEO9ibaudZ6p51m62H9VgPSwc40v6a9b
         wZgWT/qOtH53Xct8A6txqrK/Ykbbe+Y2H+V8a+jXW9QAVGBs3HngCebw/coREaOLn4dM
         ipxGXOCxxn92sZIZLNTudcaGmHU1GOsWHIDL1Z0uZos18Dz5NHSIiJBLqWwPwTgeXZL5
         HpPP1wvmcWhkVHYL2w0fnuhNfuy+EkgEDkznFFssLYj3Ps7+pwzTZxfFwYanUjk3P5fY
         Y+6aNcbb7F8+NH4BTOfKptBoi6BOuqOvbjzEFTUO/unpsUuKQMZ4hfLw4Cf4oG6+1ZzU
         9wAA==
X-Forwarded-Encrypted: i=1; AHgh+RoriRiaJYj8gA0AwadeLBJzHMKpP8uzUtSLqctTrKF+WErZjlzMzyAiA0rTPD0JBuJkgJVzG6wvJ5wh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Dzz7a9oZWSHsTw+kHC1sKHMXxtYNx0D6f0PFsg2tcjKysqCB
	lhxYcLDe+G+UHRckeyJnFG8eV98bQzGb9uLHmXNWzTz+FJ+aWi7DW2RPlNw7ZvN0zyo=
X-Gm-Gg: AfdE7clJ60O2JzMy0MqG6e9eEjPE8LrMHl1eaIpwtODJjI1ldyOVMxMuZAHK78WoqDL
	LVrQWe+XleBA3DzRT2wYc4pv8uh1K3xzsPM1EzD0FBED3XngOAKs2pFfGSdgcVQ3X36mqr55red
	GFiY9T0ndaKJCkWTg6K+xuWTouO5bP5sLPqTfV//7MIoss5pKLqwDLKjkhoUZS/luBRKlD2q0xI
	Fhudq9kcGj6vJxOBw9pFqSHetf9BsjUM8BRA4iPXqkP2saDVY+OcxfipLDfl8ExMe35gtEQdmLU
	gxDLhAB3rjHiByXKpdOuLPHjKPoJt+SxjF+kdXPtDyIwb4b2EHnj373uzFUCk9xXmiQexPM/qzb
	BH1GOe93ZOPs5yprLzxNASkY6ltWvYpqlJdyEfUDavy9l6qn1ncKVs8ySoYQS7NQ95dqOundg5S
	zQRLxnTO7/7b0rdPDkwrnsPVfu3H21KNLYGH6nGtiGagIH8OE2RLX1YdwByujdnTspG6rXgDo2l
	daL3C9iJzFPLhQS
X-Received: by 2002:a05:6000:41d4:b0:46f:9d18:bd3c with SMTP id ffacd0b85a97d-47aa92c079cmr10668025f8f.12.1783322703952;
        Mon, 06 Jul 2026 00:25:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 12/18] fs/ceph: remove redundant inode number from ceph_inode_info
Date: Mon,  6 Jul 2026 09:24:43 +0200
Message-ID: <20260706072450.3920010-13-max.kellermann@ionos.com>
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

