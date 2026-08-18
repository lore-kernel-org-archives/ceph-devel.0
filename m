Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AD484254
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076713; cv=none; b=oXTrgadEV5i2TAypYtkn71N3AdDBDyoUgAZIJdbXBt8c6X5pTF648NC3hv5QPQH+CwjFnWJaNfcCetlD9WtOHOuo+Hr5JTFMx/yP/3hoBfu5yR73lMXpo3KL6B1yOclb5IT2OvO/f2QFdFJLkFQLsH1OVx99kIWnVkTxetpfdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076713; c=relaxed/simple;
	bh=9XEOCpJ92dHTmRtWjKTA/Gb5ilHulLiXFfGINfxa9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keC1AQWSsRMgOuyWXYD8dSWW4jOWBvbZLB1TDomnbkRqzV9jbml+jlBeEp3loxM1r1OWBwzxZKbQ095kfxf+UXN2Vsx6NcRt1BAf10WnVDdPp8uqg6eHcsRXMsATsNGqbsE77G6mvGGtRuFD/UmU7WIb24p24a91YKbSKUBK0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ICO1IEAE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ICO1IEAE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so90843f8f.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076709; x=1787681509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=ICO1IEAEY/jlf28oNsU1sIK/4Ko5p/QmI9qi9kedDCySsbrKB1AKc/eNiug0wkye4t
         Pzs7l3kabl3rIL2Gz6j/6S5tWL14s85qFPJtWNHvkTNlsjZ3wZCUbYWtd+uh0Rf48X6g
         9AHraOZsjAi0smQz6k0InEhSEknyQWUYJ4KFJFFDeMbGICTRFK15pFPOP5XRaEpfXcEu
         ZhoROoJlbQkMKpK6YLmoUsGGQ/4UYqjM8vFvVKvvwcJoobSOQHL3gfZwdbuDGN0GCEqY
         CSnXBXkEkjoST+F6uJmcfWbx03Au94eF9QVPVVu5dY7tfvvSdxJTkY0qILVeabY7gbVD
         6YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076709; x=1787681509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=arCkhFg4EWRySu3juAlb/sn+MjNNV0x7DNnL/XvAEuHLESJhCKPkNHG9e3eHjYTguC
         pgGdAvaH7/QGhEIUzOFT3xCoMW6ZbqdFTGGiO02dM410OG/jE/4kBW9NlC4ImKE3gcOo
         DZhSo5UyrRvhSpvRv0o3luLTkXjxGwZjdVh2rXI1xSKl4hMDDN/UifQsjqQ11sE/DUxM
         L8ErJVFL8vgvqFffDRpUXWdWK2CsFI6gP0Yq//ijXu3Zz6bZoUlj3alLAs13I8dBqEPp
         c2V/3difF/UCswNzJjHittFtiQ4H6s3SOnj25l5j9U4/JW7G0Kkaz1PrsW9KpK+Gc6UN
         mFJQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/CFoPnILvTV4w3lE2PbK8rTlwmGf4aIakTpoFHFn3p6eAASX7jQJv84aJpgh0i4PbToNP2HPZxMho@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ixo5/JcPJWtgie1ylwkKdJqtCB24Mm+Bs0ZcZdRFHXf93q2u
	AJYZMAUDwT9kNr629jy27OBwg4jzp3XdBSJ/1gaFXaVAfIHea+03Y/WcNIjp17y/1vI=
X-Gm-Gg: AR+sD12C0drqi8AMgeH3/uB95LjnDek4dS6OOJsP6+yNRRUFXXgD1d8WqelzUXUjEn3
	a74pItJrUjBSe1emrjctE0LLi2J8NrKyUW9dSZsxi4ElFfjLDSiKCvgwWxeQ7+0QK+zS/anpt5Q
	akHZMThYfWB9pfjQUjMG7Wv8garLQQ2acMCCJJ9KFV75QqVWjW3Q6AlOPiJbT94OpdZ8LZnk5cp
	gWZM0viG3LLN+g3Q+Bzr5jkKjlLOSNQQrB7qWnaP72TAxVOE7MW9nSoBcr819kCRp7dADqoMXr3
	nVApxiLy77uOpORqiBV+RPZTZc62l/5Oxd+PgAJvMfg31gwtGVyPwKbUJE7e9aq7osHf47JMz6A
	o+zNr5gB8CpS9txgwS3EX3f6Oy9MIkFsNnS0PCZUYFx1ylt9o6F/UefOO646tjgG92olJq8hXF6
	+NLZu5ajqe1GeySHF/Iw1tCGojg7zrOLO8zNH3FZ/cRX/uwzjhEikufZoEHysMLK9bWdURFRauZ
	wB3+fP2crU/LfI6+Om+5sMIKPtbxWBF/mIlUYLzH07iyjgF9Jo4JRKgdStaooI8btXOK5TjCOs=
X-Received: by 2002:a05:6000:601:b0:47f:7c50:2222 with SMTP id ffacd0b85a97d-4816077740emr56609702f8f.24.1787076709584;
        Tue, 18 Aug 2026 11:11:49 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:49 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 02/12] fs/ceph/super: make field `i_truncate_pagecache_size` optional
Date: Tue, 18 Aug 2026 20:11:34 +0200
Message-ID: <20260818181144.3541770-3-max.kellermann@ionos.com>
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

