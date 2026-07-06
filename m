Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4D3DDDC3
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322718; cv=none; b=MJjmR144nzS5EUdC1NWfK5OP3Owrb/fs4m7z1GhiCQqPia1e1E2rACmTs5KwuGONfA4YNJJbER7ewrPFwEyGSkEjk4Ew17cbcVPEx6tybRaPx3CNplhrxa/umoWCuq3DCZdN2nzNFh6xcUk/T5Va7EHD+7PoRBWXiB6/M72ibXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322718; c=relaxed/simple;
	bh=9XEOCpJ92dHTmRtWjKTA/Gb5ilHulLiXFfGINfxa9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk6hhf2zjC/oVtdHZofJtuuIQ8Nedoi/nixYQAxivxyN+m5MkaUAwCa41ngH0N/netdsgjDrcoJ3Igvr/MdrF44YrrBRet+rKZoDF22kWQObTrTWbYtNjSM49qw9jTvWJSp+S9xbrgGFdm/DrK5c8izHqytNMz871lc06o0Gbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I4pXRH3S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I4pXRH3S"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2282843f8f.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322698; x=1783927498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=I4pXRH3StSrNgYaufuTOv8flH6uH0AKoRpC/rGrSBVuKIhjaSowEgjHLTPJLPC9gN1
         +gwQacxtiiQMNrmOAo/vFRPyJGEBf7Fj2QzNlI3k7PkYsag/V4MWwUokz5321oEzfK2g
         VCXz+IrR/LzhyZFYtxPCuSoAwH2hZbbOwa7YTuqCUEy4fpOZg5GdGzAvjKfOlAOdA6Cb
         JozFzvE4Ke+ghIcFdtVvYE7RalBXH3gTr3S+5TAvx85NqkrtfSd1T8Qa6sGogkpOS/EX
         SXoBKSjeVhztarl5wpUxi8eWbyduSIDhRYB/zIBUrKRj0xAVxrnCFIB2V8m+1A2ADwXC
         1g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322698; x=1783927498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00c8rcUzxLCd7wLsw23nlyAOLrwAoUbKznwY4vUbxqs=;
        b=rNLx9RC9Ek2hgTrPFLoYzrlMufdvqTvwTFyPCqK+h+g7hmTNDSywxvEL10h7XVJXDz
         /JECTFNYD9UQ0olv6g4LFIgvacvQ4OMSJdJUqs5bWmhTwT2Mtu/EWPzBFY5Eu77Dn3Eu
         YwBcCjDkvrkUt8O8ZcLTzvMurz/U31NmNaTAUkULLbjtyIBoJ8GBw6u9nwmus++aXUX3
         FUkhBFH6Y4F+tez4zFUKBOrH5esmMz0QGTGxOJu57t2YCO1nPpj0BqlCDq4F0Iz+IdLp
         yqj7Hoos3TZNfDm+/ee0y6dg9dNDHvaEqY93RffSCf9JFMSF5f1SpB68CMBkJj/UBIk+
         scPQ==
X-Forwarded-Encrypted: i=1; AHgh+RoM8VsezoTO9xhJql4p2m90oi4l57UH9upk6kwuZNTBW/0n7U8siGRc/nMLnEYUC4SPVBjZbO1fjIKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsX45KeNGzI6a1KJODwjuHnJrs4h6qPT5Q3bDyeq7RSltnrZi
	RGmfGd7L79oBkv+Vmtk3AwHaHtIX9x3DbAFE2DvBdGuy3dzD+nD6Ae17Jkmk3f91t8Y=
X-Gm-Gg: AfdE7cnG7nS4zIsaMHEWr1JkK3yEdZF4f+tAqKEX84vsI61xhuFBixHIgFF356wgbO9
	ETEMVUA578Eph+hmlIrf7SNliySOZ4/wW6I0Zq9spGSCgqIuU1AoXd65PD6JxoBngK1KCNWu34g
	KsPZEWu78pWSf5P134LcmoV+7OIvMVS0hXWS5WprMMLFOuESNxt5xYZ4DV2k53HdcLNYEcgoeFF
	Q/2u7cm1VLf2pyB2tpWN8LXN31dcwrGKhT4Ry1oyMgihN/MgED98GejEmB9FDCo9xjBxI9kA+eL
	b1iw+Amj6vbk73+vuQpx0ka3hrWZtu6pZq+FDjvvixCV9f1qYZuMrSJs3Zr8lgSHIDHA8W76RTZ
	rFYYi9mF7CFrMkqNM9N3tLxhg1PBPawtnPRguVn/AGolrHBVmFL3r8yINRJ7fHDsSK4Mgh+CHml
	z9KH8wb7rDt/n1acXtHxMSj6ClsHqIgsKAq+5XLawLi7Q3rtkQlQsh8d0B0usLcbbjbTVjav4Hn
	GW64IY1fL3xE/aZ
X-Received: by 2002:a05:6000:18a5:b0:474:64bf:8fb6 with SMTP id ffacd0b85a97d-47aad54eaa7mr10471195f8f.39.1783322697650;
        Mon, 06 Jul 2026 00:24:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 02/18] fs/ceph/super: make field `i_truncate_pagecache_size` optional
Date: Mon,  6 Jul 2026 09:24:33 +0200
Message-ID: <20260706072450.3920010-3-max.kellermann@ionos.com>
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

