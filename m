Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFA485514
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076732; cv=none; b=kZtGNwWGQqth6vNGuaivn6g5aTlmQx6IPdaO+P4tWbSqAXQkB6rFYPp7dfvGfGruIyrRobtAdzY4T1/x7xpsmW7k2ZT8ZXaoThZ0+B2KgLev1+PhADCXIl3R+rM31ng4RRKXYNeB0aI1rpFbrme23zh7Wb7OsvvqEpmbkeaLeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076732; c=relaxed/simple;
	bh=o9USGOri0DNHjuRWnRkfOmLtqC+q0bG+eUolSoeXHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlBe64JdH6Ig4hQ6M4IARRKUgHWPad50GsWgrdjncHqJHamYg8V70idSTbZxeQs/mLgeOa4wANR4EA/84RMFuSv01xc4Mdd2KBNo/XLpLcIc2TS6BMmzTJKpj8X6OsrGeqp15nC7/kXn5ykJXa8Hkdia4SzyRt5c4FRFcyOs7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XlVPYj4Q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XlVPYj4Q"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so64569f8f.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076717; x=1787681517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1npwvHVkojeQbHnFgD+GTDd35EJtvNtQAE3wiFoHlg=;
        b=XlVPYj4QSJzVdBWTYEZIFsAIXYJuxcrBEaF2aMDu7I6z9ICU1QI1BjwbXfT5Mzm8d2
         vx8cYbNDIuf1F77286G6o61TMBIw+kG497SiEzWyn/NsCPMi28fgFTCNgfcSiydjIY3V
         9ou/ZcBalsOq+0mpsqe9Cjwp6RN79PX3DnXX+I+7A0gs3H4ARCzoNfW6aUm2gvjUMALG
         wQZ0nRaimv9GK9pbredNh5NES/22mjzpj36XanzNPoRIaUOr8d3nmdXn27nzfDDyvciw
         oG96pjZ9COX7yRgc66PjpikPok6MHgGiWxWntgvWS/pxCCcbRCdERjM6MFwmXBOs8w3O
         oZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076717; x=1787681517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1npwvHVkojeQbHnFgD+GTDd35EJtvNtQAE3wiFoHlg=;
        b=gqQ1JCnepQx2PSzxE1irOiEYmx1k6tWWowc0TFUzR/jlTMTYNdjiy36rQqK2BfUI6o
         MGD3zZXbvyU57DB0zTlQS9AGRO9OUEq5MQY5arFYMDAmp/2Efkb04qAqRi6KhLQrM7cL
         pRdb1jKZWbKQAPWNr6HOCypajECB6HEmh//aSs0stDjzOHd6kutBQ8PMzoMZ/TozGHkD
         SR4LBnzkhzsdJV4aXrq0E9+AZ2aVLmb2aotAsOdVQpckC7zNHzLNARuw0B/aD8M9AMLX
         PCrE6NAtkPNtalwJktC6Vm2KIb/bhmUXjzQdsg3LPqOotQx1w6csebs8UguHx7lh6C7u
         1kmA==
X-Forwarded-Encrypted: i=1; AHgh+RobT++hbfWZSUv6wj7rAKoGd5lvhDahKkr25ln8gCuo8A8i3ibJf2zseOieJ4u3q/+xDewM3rZUGeg2@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTEsvsmnHC0AgWd2WbKcRwqaEdVB5Psxni02FEGJErKXFA5mM
	UcIrZ82M8UL6lBbmcNQJ/XqUokFdR/caCsA4KxwRYHvyUP6pZ35m9Ru9QiLcPH7lN0o=
X-Gm-Gg: AR+sD11KsNNvFOt0bv31GZU+To/DcXgwTbLKgEA+0JCjRQqeFAUmU3/t7j2/ZsCH60a
	VTrKdUvhHfkhi34baWgqerXeuy1rowncBUZM9+TbFijW2NhF0gL+iJYeBTXomfb+jG0CDTkkaO8
	EZocyZpq1zQsbo/IP8i1JW6YrY3MroUUQr5OSHplV/v6nEuzawKqWLsAWODwX0epk15lSn7zxmO
	rRk07zkXlHPXtEEWhpuEiYs9qbvFiyxBMGq0hIrIrHCKNNepGkbf+Dp5HePV6ON6/8KtO32atX9
	5j6mTjK7IkdUnHPXy8S1KMuQ8R4J7xIt4mlXegF8lmHCPsQ4H+7BJ8SYETyftZHOyihT1hKUjiM
	k7ifOuZVp1qfgWhpHr+HD5r555FDbzgXA3nIBrRmIJya23QSVbvsEl8EQCsZuw1guFCMrGJWR6L
	T474gzzdNmeK6vQ4k7UqqV1wb3rSRC4d8EB5Nehn+7Ylasuuum3RS7FnynI0ukOXHsF2y6derL/
	iPAzw9X8DhoZ07tl+ehfXVzqdaIG7Ron4OEVALORacLqkBURoLqb6DhJkHEF4t1
X-Received: by 2002:a5d:5f4a:0:b0:47f:e770:13e0 with SMTP id ffacd0b85a97d-48160715b9bmr59223175f8f.7.1787076717053;
        Tue, 18 Aug 2026 11:11:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 12/12] fs/ceph: remove redundant inode number from ceph_inode_info
Date: Tue, 18 Aug 2026 20:11:44 +0200
Message-ID: <20260818181144.3541770-13-max.kellermann@ionos.com>
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

On 64 bit systems, ceph_vino_to_ino_t() is a no-op, and inode.i_ino is
the same as ceph_vino.ino.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/cache.c |  4 +++-
 fs/ceph/inode.c |  9 +++++++++
 fs/ceph/super.h | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

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
index aba98975a8a3..4faac8db5f00 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -44,11 +44,20 @@ static void ceph_inode_work(struct work_struct *work);
  */
 static int ceph_set_ino_cb(struct inode *inode, void *data)
 {
+#if BITS_PER_LONG >= 64
+	const struct ceph_vino *vino = data;
+#endif
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

