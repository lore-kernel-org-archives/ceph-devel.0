Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F35381AF1
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596933; cv=none; b=kSpao3XnYFLAY4AZKVlcyAGQysdAyo1l+NBlAN1foTflHp5JKWWWPSkd1SQp4gmO9hJw7ELNUMUSR3KZ1ZIrhmbYXZYrVThQ/LpcTx97FrtHDyuQ8IqEgxJbT/z5Z/0L4sSkw6XInyOlFQzbkM2kIabTWPm+qVJQht0YWV8l6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596933; c=relaxed/simple;
	bh=9XEOCpJ92dHTmRtWjKTA/Gb5ilHulLiXFfGINfxa9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbgLyyoi9aQLOP3cygNWboVbEYSsM2Rk6Zb5BKYGiwC6wW8xh+QKbXT55Zon3Gr6LxjDhMlVPCZJ9pZSe8COIA/TwslG7y9MhaZT9Lin7x4Po+hO+yGyJl0ArkEFRYCIM6Yz4XC5aQYNVldNIyC+Hpsp4WJyGf/D228P//l4w1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YOi91apN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YOi91apN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c214e625259so569308166b.2
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596930; x=1788201730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=YOi91apNsBaU3HxfZG79TayeeQLL156ja2oL0lzsQETJqcsqLyT5zuuYtxTvRaEkYR
         x63XKV/hlZjWjRkkd7Kc1q9A795pXwyPwnSJYa7yIWWy5KJ97ygoQexdrlYctLFA+WSJ
         67UuhkXY24OhMWyZ2Wp0ZTtKTkmemU+aohnyUfArAsYASrCB5VhEttVuw9ZvaWXbTGrJ
         HvxilKHhYe3dHM8UyxucV3GDX7Gr6Cv5xjZeLTHez+KqyHG0mGu5Zl/fR1pnBIOsj3dP
         OyiLkYQY/MeMsXNee7X0vn4jiMZEfO5KzL2OqjCQb4ikvvnQRb2qQeZw6XzVSAY1ScJ1
         LkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596930; x=1788201730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=IBNrQ8M/OyKCqjdR/HoAwU8ufZshbeMF4QUJgskBW+ANUw/qaFbrsRZvm5AWtpbAyt
         D0Mg+yVq2p4DgH4YSAvXmEAwnnQBx7l+YLw4cQ0LvabXWtVOhpwhtrJoLH4B2BN7puDg
         KEYqLm4CEQUE2Ai4mdnMZEFk88KulAL4NfspHdnXkByrN7HqnSfAUZ2ISvCPPKixw69D
         /Bkt+udSidrAFOcNi97BSmWcwBsO2Myu3YzsCnTwwbBcB/uAp8VyJq+H6MsKPtiY+P2H
         tI+RFtEjlM+zH3ek/A4/AoZBYWlbpr8WI6aPIF+MyQK17BWl495B1B6XdnfUXPUh6jFJ
         wU2g==
X-Forwarded-Encrypted: i=1; AHgh+RrqvvjO244VdkeyqdAJ6Vp7cpr7RfRloYGZsxtQfbM5D+wvvf9miYmw35r8e2meodDYMaSlZjvu3ELg@vger.kernel.org
X-Gm-Message-State: AFuF++nG03DDEh7Nz3MU8IfwJBmADBAa+FERfVgKNEFou0cFCrNRAjUk
	N/Xm726DYopOLqWoWB2ImDXEEqqicir9uEcNTEqpoAbDA3tINxDDyBAboGS4VpmyXEI=
X-Gm-Gg: AR+sD12xFHgjrZILe9Ixafv4HGB5Ir4QrwPRn9nsTzPXfZstxcieQt70+/np6vSvWTz
	Omulp2sulHBf4mQFs1GXAtGQ8vfqJxrbYjKEf7fpF1ZscrJVEZImu+05lsVTjQJX/NP+15NdYtJ
	TgTzAi3WpQ2z8UATV35Rr1+BnKKdqyHY62UZCvf8mEIrWXAfyPaSXWjgNx2GukxeM96YNCaDSpP
	MGugIcwax6sfsJoWSnDOQzyk1ZR3RJSiW6N0GGAknblHhq2vndlmahFauHgHf38qriI0LnNFSHl
	9N7pmOgOtCavQ3eBpkndbec4TQsSUjjkMEynOQea440/9zm/TyR7+xV6InbM0V9n1V1ec8YZ+LS
	4NoYTLCYRSMUUO603q51t4vMdjtd+xSxArR7xyvbweznKx7AgCrl8LcMhsTtsVJZHVTFmVYKczU
	SQ7WU1ksUWr5lCSP4jj4l7r9Dc195f/PP8Y5z3jczP0sFMf2mgpanPsmfCDZ05ZpRI3yhr+FRab
	7uddxL6fBxQf3Qc6685/HFHNilpEqd49qrXzoKZqVeuUVLYf0hOyljtCYD0HRSY
X-Received: by 2002:a17:907:9814:b0:c21:792:8257 with SMTP id a640c23a62f3a-c24e5ad9556mr40773866b.15.1787596930287;
        Mon, 24 Aug 2026 11:42:10 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:09 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 02/11] fs/ceph/super: make field `i_truncate_pagecache_size` optional
Date: Mon, 24 Aug 2026 20:41:50 +0200
Message-ID: <20260824184159.240821-3-max.kellermann@ionos.com>
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

