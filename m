Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E03FF8AE
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283142; cv=none; b=RIAw0FNRvDe2OC1AqCarL3jQj6UdtENadrSlpgC8pviNZe4DUuQnlvd0wD5pt1vYd7wtPGoDGj+iOic4//yxtn7Zo5FagGkJ/EuetiGm6o+DTCphUs2Yl+hZxwuVUNNuetM0LmNOLcIO0D1ZkgD60F4cYY/OhStwIgA4vLNUY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283142; c=relaxed/simple;
	bh=nJp1aMuxWCUjupgbc4mKqK8um+RU1INVI+kbVugwGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka/rGIKgxPlNsWyq0Yr1qCwaoER44eG0jJi4JsWqqjbYygobiOiIkfHy3IV8v6uwK8bRVo30iseh3JrZAOuLzQkbM7oTJq+PH9FY9YivT/rCYuWUJEAJYorJukY7XkgCmmmvzzgfzY+xSFW4VPmYP+z6LEQzKn41EOrwTAkMzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gq4ucGi6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gq4ucGi6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso8633685e9.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283138; x=1781887938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTxqEc8zWJL60yb7bcwj3bHWMC/wLLvml6JA4qzDLX8=;
        b=gq4ucGi6q3kldfgsa/GHvZRGvgf2pTSFp8AtLc/Mxj9T2jJsx2fKr7/3E9b7D3oiS1
         m75orwNRRzvq7lyA50I5zNFrmYJyQHvYoDBIePGwSUPmAUFnHFoYPZlqwaRqaAiTzgnu
         8Ss3OuAUjUKsnvhmyH85E8K+JWnuCa4ql6K3toy/FZt4UIb23U7kL4jGiVH97mei+mRD
         YCiqggTYdCkSCdTOkEtyD1d1P8R8AlH3DCOEGI3TekyIa9vEbPr8F1tGC7mE8oK9HRaA
         aNMHR/2XotXLXppvz5SFq/70sGARrR7CnLYYVdrdxxdU1R04acB1uKfd6/D2xg/YLkH6
         fPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283138; x=1781887938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTxqEc8zWJL60yb7bcwj3bHWMC/wLLvml6JA4qzDLX8=;
        b=BejtLLoHMxdqOXqleHGgWJnsJP/3NquL56ApXyWDDe91J88dHhlr2fUg8oXDBjRwDr
         AiESkkCJmqqFIEN5zdfJNJrJuX7tPP3VJ/kjQAGVd2lIZnlX3m8hLSAqu+O79wUXDhz+
         SJGHIAsBx9gF7NSzJ7QF2musvtJAKKViOydPBAciPycjc9+tZI7710acnBVpVngifSP9
         wRSBD2BK5CEYHAijW2QF6IpkTJO+nONRJsWVrRfbXsnMibpI3XZVPpSiz+StbgrLPnRc
         5LV6nHbLjvYHpCHPIroUKH4Ilir2y3dOkWS3DUj0Mq8ouibDbWEJ82wP1b79thcAf+M0
         Lelg==
X-Forwarded-Encrypted: i=1; AFNElJ8CclyJRuMCUuxcRz/r/ceppoGfhRtwS4zZSyJlPHz3ET76KHmP8BoRZyqDB4yV1qCCv823PgGwlou0@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIP4KZVUq3U4CnW1a0CXLS6Hs8s2JAtbZvuBKL6jk0TQtwch2
	VN1CuBSTL/21n5bVDOa9TecjTHTB/Wh4JKN0XcLJ6AeUDU2ohLZg71z2es3yfPfcAqY=
X-Gm-Gg: Acq92OEu1/Ha6+kcllmo+hnGlLQSHScraKKoRpSvAwXcAuU9o2bwnxWIqHHSU4S/r03
	6sKC+bGf8ueTZC45CQetkB4fnMXjwNpAVklJb3FtXlFOKVWdRlrDAiW3tR7EveZLKlArvZcdTx8
	R26NqhsgFYPgbg46e+RpqAxTUW5cxZQMvBMlIMaEevyv03PxLZqU0nhGrTDXsaqfGYDg3+o/YJm
	khWBUwtBj3YB9NK8vIkpcLRL97TBjnCSXxda6SSIwxOip/9DRCpyuz/QSQG5nktCxIHSvSJd0g5
	xPVZAe9ALjrLXkd0x+0mGbd//uS1Ip1zRyLN8GwHS9XTKnrkMIWcN4G1eCevEJyYb6XfMnxFbko
	4w0fjPjW2lVX5KhewxQrmpmDWN1leR49ZwRhndUztJAZI8KXB2cBSUYerqW/qOPG+18iRsNDW1s
	hekDScmU5YsdxjvjGD8iIyBtD0Rz2d4CQGjA3sEEx8zfQbXDQyPTefqnujNa1F5A3U6eYBq6XUW
	E0fe5RE+2n/xS9R17soYnwVbfg=
X-Received: by 2002:a05:6000:607:b0:45a:e3dd:586b with SMTP id ffacd0b85a97d-4606da6dfe3mr5550212f8f.18.1781283138302;
        Fri, 12 Jun 2026 09:52:18 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 02/12] fs/ceph/super: make field `i_truncate_pagecache_size` optional
Date: Fri, 12 Jun 2026 18:51:54 +0200
Message-ID: <20260612165204.86137-3-max.kellermann@ionos.com>
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
index 22c7da1ea61c..1504b889622c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -680,7 +680,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
+#ifdef CONFIG_FS_ENCRYPTION
 	ci->i_truncate_pagecache_size = 0;
+#endif
 
 	ci->i_max_size = 0;
 	ci->i_reported_size = 0;
@@ -865,6 +867,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 		ci->i_truncate_size = truncate_size;
 
+#ifdef CONFIG_FS_ENCRYPTION
 		if (IS_ENCRYPTED(inode)) {
 			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
 			      ci->i_truncate_pagecache_size, size);
@@ -872,6 +875,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 		} else {
 			ci->i_truncate_pagecache_size = truncate_size;
 		}
+#endif
 	}
 	return queue_trunc;
 }
@@ -2331,7 +2335,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	/* there should be no reader or writer */
 	WARN_ON_ONCE(ci->i_rd_ref || ci->i_wr_ref);
 
-	to = ci->i_truncate_pagecache_size;
+	to = ceph_get_truncate_pagecache_size(ci);
 	wrbuffer_refs = ci->i_wrbuffer_ref;
 	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
 	      ci->i_truncate_pending, to);
@@ -2341,7 +2345,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	truncate_pagecache(inode, to);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (to == ci->i_truncate_pagecache_size) {
+	if (to == ceph_get_truncate_pagecache_size(ci)) {
 		ci->i_truncate_pending = 0;
 		finish = 1;
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 6aec40955387..f0f03aeb5b19 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -461,11 +461,14 @@ struct ceph_inode_info {
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
@@ -660,6 +663,14 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 	return ilookup5(sb, (unsigned long)vino.ino, ceph_ino_compare, &vino);
 }
 
+static inline u64 ceph_get_truncate_pagecache_size(const struct ceph_inode_info *ci)
+{
+#ifdef CONFIG_CEPH_FS_SNAPSHOTS
+	return ci->i_truncate_pagecache_size;
+#else
+	return ci->i_truncate_size;
+#endif
+}
 
 /*
  * Ceph inode.
-- 
2.47.3

