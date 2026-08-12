Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB987399356
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566606; cv=none; b=iaMXXqovT/4i2JcMnBFJJW5MnfutDjN3sHFiEv9gTTjcbg2vtOZq9bzHoiE9aywbOJFkOHk0hbd2vFQDCeHcqrwZ8zrs7bJyMB/7vj68fdwr4QI55LwQLYXK5zpKdwG2R2D7opz+t7f1czUhtC9UJjdSdt0glARXOsnJsZMiK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566606; c=relaxed/simple;
	bh=9XEOCpJ92dHTmRtWjKTA/Gb5ilHulLiXFfGINfxa9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAeN6cxePZ2oAPYSlajt8dacMG6AgAcBPzGT15HOfyLWrHQjYZArkex1ruQBl6WWQdFxjQJSKms/dv971swBEoLqd91WmXbCT7hg32a+XlLWfxH4/+n9qMUvafqq8paOKCB0Qimqy7a78QvwEkumRd5kPx7RWmhBvAvfDIwBZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VXLzODNN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VXLzODNN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe377a217so856373f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566597; x=1787171397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=VXLzODNNZwSOSHzPRe+TDed9G0cS7MrRExehI6//A1vP/Eqq1j/z1+aKLpiaBecpCx
         2eHKAWLZRMBYtXtdHZHBtqt/oG/PyeIE0P6GvPq101PXvvP6DcO90lJ3Q7yqNZppQD/o
         /sOoSMttMTvMGqfw/+zaS/y8rmVWiWhAofAvGUJmE3lnZz/gvra8ui3q3B0VCr6WccJy
         Q4uikeNh/gnqzi9b0LpgKdvUOuYXi+m+0SAdSwvXtNKwhzBU6D1VMGqPyvfnpHZ90Giz
         8q57IQ0O6vn/bIQ59WzPfGGjk5Mxa9dqss+hCFklOtoovPfuOWNC/tXDTR3w4o/WyULw
         sVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566597; x=1787171397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=WHhrOvcwC+czjjCeGS5Up2OITO5/V64hMm2e8IpOBkQ36dH7p4KyrupB23iaomLoIU
         Ad79Yr0uhpkYuB1NGG/UJxmY9jnThjYsH9WMO+5UH8mca7tLiVBsGbtS5tvMhGpGEdSB
         BQ/IL2RT/rCKlgaDbVyl6Z2h/9+MPM9tYpUSwSAJ0cCQTlK4Ch/vw6qeDkECVpLCBhW0
         c7eDWAcc8j5KEWbFEZZQD3t56YXZLDfJ6HyR2yKBr4RtSHHmYQ/DlCgMz4HLZlcr2YDD
         DoT/CNaRv6+ds2e0I/gvj8E0dWU/MTEEns/0LCgoxlxpQJ+bFOLrCk42U4NHcW/E9xT0
         67Og==
X-Forwarded-Encrypted: i=1; AHgh+RreTLVCwSioBorjh8Ux5sZpehTRn/HeAMqM+INWcKtsgjljvOAYDAucRPHTJgtyxEIJbszfs33xs9H3@vger.kernel.org
X-Gm-Message-State: AOJu0YxIei2Y2qRFSePEinkSh5zKAlNtxdnOb0hvrD3zlqTdgiDNVIT4
	dMtLj+zwG4aLvVFjxXrnhxipyTKspApxTnK1hRaNNgly7P8cBDACcoT4ZbogLQgEnq1KcPXAwQ6
	eIEMnHo4=
X-Gm-Gg: AR+sD12lMWO2Kho6EcmY7khgTVxuuu5nuiTIxPyGGOsa+sdHuTitCgqJC1U7keN1JXA
	StT3vf7IRkwk+g2IeOv9GGUq6rwJScIwLQx6Wy+fmXMntojimr9b17ZbmwU18N8BMCgDAhso4d9
	znkScUbAMGESktRf+8WSvTBNQ4SRmWey0YP6VHP6oE/q1WB1TKZ7A0FbCpOJvu4KrryYoKfHbTp
	Z5EhCWJ2mPdNbiKFN1e/49M5hm5NGrwniZyI1AS0wL9YKAWMqC6NekpJNuIlPWS94ep8uv02nNF
	w3YZXAUFLlssWIyThjdQHPDFxHhCMT0TyXp5foDWAejB+9/9/beHinjEy4uH1GDXt4fqOFLRg2R
	EicBW7KmXz4NL+lZHxHNZdnB52ksfk940mlouz2efdVT5RqDZft7lstvYWL0lLXZrofmtqbdVEh
	g/bruxL7pwVWbSuMT5Wjh8/Cp2DBa8vV4QlgcGAnxbJRSnKHebP+NMJJ9opfp8h2DxAfKEZOSNk
	hDZ52MX8p+/D3OnaGTdl0vfEm6if0pz3I6xsJdMLO8ekXcWqmtQkbBSI35eNVsP
X-Received: by 2002:adf:e19e:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-48159c904c7mr1168021f8f.4.1786566597358;
        Wed, 12 Aug 2026 13:29:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 02/12] fs/ceph/super: make field `i_truncate_pagecache_size` optional
Date: Wed, 12 Aug 2026 22:29:39 +0200
Message-ID: <20260812202950.1800340-3-max.kellermann@ionos.com>
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

This field is only used with CONFIG_FS_ENCRYPTION; without it, it
always equals `i_truncate_size`.

This reduces the size of `struct ceph_inode_info` by 8 bytes on
kernels that have filesystem encryption disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/inode.c |  8 ++++++--
 fs/ceph/super.h | 11 +++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 61d7c0b8161f..bdb82f123033 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -681,7 +681,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
+#ifdef CONFIG_FS_ENCRYPTION
 	ci->i_truncate_pagecache_size = 0;
+#endif
 
 	ci->i_max_size = 0;
 	ci->i_reported_size = 0;
@@ -866,6 +868,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 		ci->i_truncate_size = truncate_size;
 
+#ifdef CONFIG_FS_ENCRYPTION
 		if (IS_ENCRYPTED(inode)) {
 			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
 			      ci->i_truncate_pagecache_size, size);
@@ -873,6 +876,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 		} else {
 			ci->i_truncate_pagecache_size = truncate_size;
 		}
+#endif
 	}
 	return queue_trunc;
 }
@@ -2332,7 +2336,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	/* there should be no reader or writer */
 	WARN_ON_ONCE(ci->i_rd_ref || ci->i_wr_ref);
 
-	to = ci->i_truncate_pagecache_size;
+	to = ceph_get_truncate_pagecache_size(ci);
 	wrbuffer_refs = ci->i_wrbuffer_ref;
 	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
 	      ci->i_truncate_pending, to);
@@ -2342,7 +2346,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	truncate_pagecache(inode, to);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (to == ci->i_truncate_pagecache_size) {
+	if (to == ceph_get_truncate_pagecache_size(ci)) {
 		ci->i_truncate_pending = 0;
 		finish = 1;
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3cbd320b49a8..7023af704e14 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -468,11 +468,14 @@ struct ceph_inode_info {
 	u32 i_truncate_seq;        /* last truncate to smaller size */
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
+
+#ifdef CONFIG_FS_ENCRYPTION
 	/*
 	 * For none fscrypt case it equals to i_truncate_size or it will
 	 * equals to fscrypt_file_size
 	 */
 	u64 i_truncate_pagecache_size;
+#endif
 
 	u64 i_max_size;            /* max file size authorized by mds */
 	u64 i_reported_size; /* (max_)size reported to or requested of mds */
@@ -667,6 +670,14 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 	return ilookup5(sb, (unsigned long)vino.ino, ceph_ino_compare, &vino);
 }
 
+static inline u64 ceph_get_truncate_pagecache_size(const struct ceph_inode_info *ci)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	return ci->i_truncate_pagecache_size;
+#else
+	return ci->i_truncate_size;
+#endif
+}
 
 /*
  * Ceph inode.
-- 
2.47.3

