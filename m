Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413922;
	b=Er8+zJEP726Ne4Xr8jU6QI4UWIgfCOWCC/1qJ2bKu/5RV5NYf/Q+hlMeBg0H5rXNES1u
	 1/YA8AuqiRWaDOS/Vp17mjsY87YXZTJQ93PcQGNxTy640pqttkVjSUut1xas3IG2VO1R9
	 JuWX+8MI6zwiR31oiavHM2hvGlI9Kaj8lxaGVZXvWLxcuEfgL+S2c27n2yJDtuMZreVMj
	 AfCTvLG3FKiZQHYltziOhzcPRaTPxDWl23/9+qw0lAZdIy1/VNVWhA+URt8ffgI4GoqcK
	 DkhMI1+WClIqdBqtGxIreLhcPxpmbySlgU1h+0bghs44b7DdR8g/buoy/5jr1r1pxew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
	b=Tkl5nsHaUDc1PBnhYJPRJCRzkbTemqS99yzwW2VUipM/S4ir/32U1XAJvL9jxnqXMIP7
	 4LWT8ODC6nR1ZJjMJFObUr9KamKrQAgmrrGe2D9ht7n+PtBlrc4ShymUC3q/v2SWQTsgi
	 YovaFc2ubcnwnNRkgfmrN/yBJbwaHU/XzqZLHt9GD4kptbtF3/n+bXs3HBIilJRkdxzZF
	 rdtUHq5P7gfkms4noZeaShAzPjV5b2dDrISw+n8k40es7SAWr8Vo2nDDPeYfGBhfFqTNq
	 fB71Xv3hVop4/pa96quCVMg0llm32l7CIHFNPjGLhhFc7rYN7qE9RMEVYIJOWMEh9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gKStaRxV;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B060A380E
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714B060A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gKStaRxV
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1495694f8f.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413921; x=1795018721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
        b=gKStaRxVo5TTjFggIqYp7llrrzPcPl69s/GyATJGxs41sZ0V4cyMGFkBrH/x6LMWlY
         rMSSEiHNHFVmqZ7EpXsGhR1b5yv0ik3kyAcyJ0sMi96QNRuLdLgYYPReEXAuQlx3PEmf
         h70aKddg1nWWkOmUdN27YvD5SaMgRqwov54stAPfpwkyKt34fJoy5Rqvqt5pMkIaSopk
         LDSA6kACTUw+Rh3y+lXxB1tTFrdrF26jVk+DG96N7skf8AB0G7d+m4WGaPUKr78P3n5n
         rMkOwhMggK4QyH8u+UtVAd7OR2aUhZbhfxm5HAjSLf9B5e3hKcMyllDAhs/5vyhytI1F
         lbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413921; x=1795018721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
        b=Y4TdlIxWgeXzkH/MHZhlqm+iDJJp6L04mBsarzFJhhefUdfGpsdIo3uTYyIf+g4y/2
         8fmsKMUBabPf2FB+rzPwGPGP1PfLcE0M+698z4Lh9OrwYL7bQwSiFYYZHik8rMsjUbCa
         RMmyZDZ8TB4dx1GUlHT9pcFHe2DDyyhwUE7MjfSyTjXISgy1Ekfb261A0mjMfyapng/x
         H7Ts1PYRS+b+jJ5VvOsGPq1h82iRSkcwSb5SmvqNMmiV6+5ROG6B4JCVcb9zjPYzExBJ
         2CV/JIVs/2v1fke7PMkI/l0xIu8c2k+06LH9fOHUymVUZN8/gcHshJj4Oc7EBM88fpsE
         lPqQ==
X-Forwarded-Encrypted: i=1; AL+hErGlF2Ek2Sxl23MzyTTpebAX8mvFf7DHdQyFeEqqfpKw6nCO7Ukgp30F3LMCJGf7CCjcQEV6aU9IGLGQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/sPbLVGPeGxvt+rvyIJBo/TvJVvsTFDZE39676ofeqFlBOPEOp
	3A29c6rsjMMOdxZ+20B6wdU5fqr1AD27klXzrdbBBacAU8kDFhtRT5hIJFoT9iqureg=
X-Gm-Gg: AYBFou0inlhB9rFxHyHA4PCCWhzC6ve46LD0IglYg7pUmF0bAxQV+83zR/fXNb4gUMl
	Rz+YBnMU+N6f/tARz3nSz2/pFue5XE8/b6CnxasIRPSor97XJz4c2gfCDP198zR4i1HMc0Lkomk
	pbLpPT31KLeCL6To4SVs6D4MdyWoQRho6k1NxbFP4wUV/UkeDFWkTTgAGRX/+/m+guhG8Uj7neE
	cnygAjHX7QmGxkTQy465LrVSX4hNRkQjQGsGUBV9yNfLzj5n8QJCVxEn3+5MEhQpMaWqHqlmfYv
	R2tSpMDiko6w9gdCRz11Xh06Er9729fe+ygmGGcfm5f4K5NT5H8zVKGifY0JQvzHxHuD7JEkSqz
	n5g77qo2uv+TrdMBDB7VWSKDGxr8jHD2MLKxMGQyH7bAnHlj/lYLx7zmzTd+PdPDaJWJlg4iOVA
	cQVKfuanGeAocMiI/IUvUHcrD1isdQBiPEX+T2ffSuCk0MS0mY8K0R1FkEKIQ5k0dOdSeISlbOC
	ipOi06sK8kbMeHFLOwzfEJ4T0yiEKiDZq8lmOkauL12DRlQXsE0q9bRnrgZxtGK9agNbvFBk3mh
	LKULXHlzQ5awCzKS01o4xzzsVYMrVAy1LzOy0SbntVvXGGtLqJX3JfJa6Ou3BJPXLSrPfrqDVMx
	Bb45/t86KIeZzJ8mpWyYo/5pLiyuuEgk1rfGyYLY121khdeXnCK0=
X-Received: by 2002:a05:6000:4914:b0:48d:f391:5c45 with SMTP id ffacd0b85a97d-499c6f8d953mr4709372f8f.42.1794413920839;
        Wed, 11 Nov 2026 08:18:40 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/9] ceph: fix mdsmap use-after-free in ceph_get_tree() error path
Date: Wed, 11 Nov 2026 17:18:27 +0100
Message-ID: <20261111161830.1336485-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting fails, ceph_get_tree() calls
ceph_mdsmap_is_cluster_available() on mdsc->mdsmap without holding
mdsc->mutex.  The MDS client is still running at that point, and
ceph_mdsc_handle_mdsmap() can replace the mdsmap and free the old one
concurrently, so this can walk freed memory.

Check the map while holding mdsc->mutex.

Fixes: 97820058fb28 ("ceph: check availability of mds cluster on mount after wait timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 01f92d77ef45..94ff935492e5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1364,6 +1364,7 @@ static int ceph_get_tree(struct fs_context *fc)
 	struct dentry *res;
 	int (*compare_super)(struct super_block *, struct fs_context *) =
 		ceph_compare_super;
+	bool available;
 	int err;
 
 	dout("ceph_get_tree\n");
@@ -1429,7 +1430,11 @@ static int ceph_get_tree(struct fs_context *fc)
 	return 0;
 
 out_splat:
-	if (!ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap)) {
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&fsc->mdsc->mutex);
+	available = ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap);
+	mutex_unlock(&fsc->mdsc->mutex);
+	if (!available) {
 		pr_info("No mds server is up or the cluster is laggy\n");
 		err = -EHOSTUNREACH;
 	}
-- 
2.53.0

