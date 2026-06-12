Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06B408616
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283148; cv=none; b=Jni3BqYKgVm72Qh//ZQX077Myej+2lOM4IwKbmi//QtkZUQAx0Z+XMyztmhAs6TwB+rlg7GyzmbnzMKFg/PfBzGFx2Ufn+Zz8MDRmAUjoz0/cD2yQRK3R6fHMLZbKkAHjuA/bSgJ8EM3UFb7zPkGLHugo3zi+gpxFEoTdRrzH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283148; c=relaxed/simple;
	bh=hX1o0/1X0IlAr+h2mvk5euMA+93fIB0+cOMIvEKYm+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbbrRLxJlhS47w9gpqvfAX+anoQYs7Gyrtd0Jl5Qv0u+eUlbc0E00xQVXqAoju/3slxtJA4tsFD8RgcqSdkb/+FpV/2ASw7XdSD8oWuvgE1L16o/ZAaLAujY2nmXweE8/LdSmX+9/FpglfOhag3T6f8SrGZQjkU181O1WsvNIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ajCt5Fg7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ajCt5Fg7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a76757e5so9431275e9.2
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283144; x=1781887944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnI2WOuzQhZjJmaMqnOcKFel7ALXR0Y3oSmXyakEYRg=;
        b=ajCt5Fg7ohhD+gd7qDJRspWcDMbdDd52B//zcw6M8Sk8YlcNnT4VLx5gdBiWN7b2lF
         2T+iXJyzxtTnXtMq7eFKggjktuZ8Q/X1cQUV/95RcJIeop8wNVIecOMvgNMvSSbz+D3/
         TPAXBbUTGnx6Ay7tdgvr/1ofudtHkoS/9+vdNwWXGHpmL79Npi072OSzCYev1r9SRBZZ
         XmVJd26npFsABtafRIMZFX058VChNclm7xVtrozVR5g79tgI6ZSRTqUZwJ6h3Ny+lLY4
         wI0LTQ15MlV0VMZ72HuDIZWaXbsortwls4cG2zytV7yMcZXhzqJqe1eQuUdUzYeEj/iL
         I6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283144; x=1781887944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnI2WOuzQhZjJmaMqnOcKFel7ALXR0Y3oSmXyakEYRg=;
        b=LJw3T238O8VfZWSkiCAGa4NcSMLdlpVe0575uh5p+JM1pU3pOSv1r7qZ3fG3CsYbhc
         MoTQY4i4/AdEVfg/G8dFTtVkxVmLQgurzNjll4YOI5Lm6X/VMo7Jq2XOY48fyMtaO45j
         ddGP6DHRFWVCW/wvYceS+3zqExbA1rOQFGCmYOaeSgM9kq0HniTZGnprpFfsrmmk3tZa
         sg4W7a9EV8HTPv9zkZ9OHlBrSUQPVWVWD0mBkB0pzIHpJrUY1teQYL2VyfpaUfAB5hXU
         2mtqetE4zm5D8bhmp9HlAqfsaCxxvmW6MDsjHiq8diCIp0u+UmPGNClNIVIFOfxKUjRX
         zFJw==
X-Forwarded-Encrypted: i=1; AFNElJ/u1kFPouvwx8pxUAkO0WowaD6MgYv0HWMeacF+/44o6f4v/bhugGUZwKd3ckCTa3XvIwsLNQHE9HOO@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTJCHg22gdqEMtK/EWJCUhotcdtlQ9LqBZrMnp05VktyLB+/L
	6XGV5xak/Vs65ZZzvTEgskh+GYXZqbTZTMcrdYWeU6xd+6BpLX6sWxZHKywl9eZ/kCw=
X-Gm-Gg: Acq92OG8u442jpXctTrkgHTzROuyWsi5qlvAWXng/xrD19RUUIrGkiGpUmJkwWNGkBo
	pjqj4jlsHhh4/RNEZCK6BbU6LlrRT7jmnBt291uPPF403sFU0v/iuPKNxS3fflwU1u6Iiu5blMs
	WPFd/p33dP5dS7+YgEDavE5qfaYv8U96GmQp12AchdQ8tU1HMHbShFp8N2CtsXe6qzH1+e79hUA
	OSPC0hBSLCMiK9+4rER/GPd+fUsgrtWzLpKGCusIUTZXIaBlypPaK6I2dm6r5FVguyJRlei3wlv
	ko1TpSpvRe2LmMV+1jN9HAiy2ydaPpc/law+BjVN7qEXCyGWTvo1u+tFGUvmkJkg/b22AaupfYT
	BQQaIBCegXhzvO/EMPFEAJF4p3+J9nYIWrBDkHc5cloIM3HLRIpeN5y/MoyqLch6XbbXJMVGhxG
	VuRZjq+ifFML3VkKkjmJwAJ8pNmuxuJYTowgGp/KJJqSjkQj2NLgepMaYIjwkrrWs6VlOwwoRKD
	TUHLccFBnfb7So/w3NJl+t6OGU=
X-Received: by 2002:a05:600c:5252:b0:490:c6c2:bdc2 with SMTP id 5b1f17b1804b1-49220051650mr3908255e9.4.1781283144560;
        Fri, 12 Jun 2026 09:52:24 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:24 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 12/12] fs/ceph: remove redundant inode number from ceph_inode_info
Date: Fri, 12 Jun 2026 18:52:04 +0200
Message-ID: <20260612165204.86137-13-max.kellermann@ionos.com>
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
index dcdbc24d1e21..c8ee7d735861 100644
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
index 5e4addbfc0f2..5cb535b126eb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -376,7 +376,15 @@ struct ceph_inode_xattrs_info {
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
 
@@ -563,7 +571,14 @@ ceph_inode_to_client(const struct inode *inode)
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
@@ -593,12 +608,20 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 
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

