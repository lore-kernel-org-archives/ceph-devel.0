Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02063016E0
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999730; cv=none; b=uEXx2WiOF/nr13HKClcBtgY7cmghZkR5rXxQeghIJ81u/oUhHQx4NOJyH7II5rdbK+yasMKMgXvJsK5Sl1zo0uLN3134Ko8MVjIgw9ZFz6ZdFo+Ixr+diYXQcko4AsXJYhD7z+LRMn0BV+AXDWQAVbqIvasop8KoOzcZzgOcYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999730; c=relaxed/simple;
	bh=8r3Njt8panVzaDyqKXn/pvgpQoA+kH4AbvtZB3YhhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQqZEPuGodHeq8POdsCAq+eEFqk+YCwHFnl35gGJ5VN4gRho7ONqmuU4yh/1xY2T1iLWki/GUMTuIUty9QC2wlfKaijsRcJPs2tOEU30oMO1aL4XRnpSFj0GM9mFhhLr6b9IABjHafXWTAXQhCC11ei9KcEId+Q2zdFEoilWYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haWb59rv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haWb59rv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so67175a91.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779999729; x=1780604529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvVT0II3dEilSbYrBZE5Ytb4041NB7ZsFn14SAB4u14=;
        b=haWb59rvJjBrnh/KE1CyLwsmwK7M4ximKxm1/arnsKrv709NK+S8XTL0r9sPVIR2bK
         yUGa0ngl5dy4TUeNIWL+PF5vugF+NYq12ehSZoOdS/VWMgutbyylUzvh5DNnbu+GCRwH
         sRLGdgpNodocXvDF/QJLhulhA0c+G+rx1/L26xTdJV74W2j3fOF1vhkDWo/39uUjNqhn
         QczCmBxty9LJ1Bm8XE0n2y/ANxcl/AgoSWj8jY7uefdTIAsudkvLNm8pDUY95Vwti5Yk
         i1ZMbm8VJFopXstkl5XGnJVZ5c3yycJpr/ddYj49lzXIMIx1xA3jTWxxawi9C69CwuLL
         J5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999729; x=1780604529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvVT0II3dEilSbYrBZE5Ytb4041NB7ZsFn14SAB4u14=;
        b=VoAXNnHxJTc7ympLy5g0u2OmUOmLBrgmhc3eVwKws2hz50KfFav9E+TIE6sS450+ZF
         NG4tB7Dh3hD42MzDqHB30UxzNzq6jmOwkmMbbXqNSqUvZlmdxCDQsEfHgXnIvu9yPRWK
         kbcKxD4CxDLFyTO/30a9c4MALZTjUFk9t4cacT+FZVPusb23/hoTVXq5H6jWykyNP0GY
         u7YH2lXbbqKminlgtcUAUoxeFiKFv9LHIrfbdV8t5NNrhEGeceJodK+BGpNZuYqZ8+0A
         a9Q4nTlzjtAse57sFZ0DVpggcqhcEberdUQdJUf5+3y5M9EcwHCUPY+ZCUwpz5sKHuRd
         TRsg==
X-Forwarded-Encrypted: i=1; AFNElJ8KUYZO/XuuxpwNAj2AY+SPk27swftVgTNQiGaFmfoxQqxeQrL8NsvSm6gxOqVXRMdCGWyOAVomlHcu@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHAr9NM9CnTgEoh9fIu3Rx65L+LDc7UfxgLPsoC/rq7qgnRFM
	NB9GsKv6nvUVMS7G89k7UMRv7hBkJaloH1r3YhaOSfOUzBHqfibi/ojekvtp+2NJ
X-Gm-Gg: Acq92OE/qlRp84fDZlVZhF6xEMFnj/janIifmi7I+Sn7aX84XOvtGMmxsZGGRxfl94u
	HH8TgN7tYLOTCho7Awe1r1sv/Z02Cp5byR0fCur3DJxjAvTSN7aH97SaKbegLEiSBDQdiz65H9Q
	FoVO9gJcEhIlTu+SeovBSpE4mzujSv7VAVp4+MclLbpQqcnAiydpZ1GutQw4yKA0QNXNoauLMlU
	8biwmIOTOfOK1dlBfBzs5dbxeCGHYqlzv6x3rXAvy4atxO0/ZwTGkWxfWz9RyGGu7rLnYYvqScO
	6NSNq8AHrGMOUzBLfkABZzOa+uhmprqCm5nkxwDE0f6bwdUx/CvcfyHhA42Bcm6RWe/miBmRrz+
	oTeuTawk1nMkuhW2DLgFT8hqMWKpuS9uvKtN+XIeVgYQaBWglCZqCL1qq19HCCWHTaV+bNngfVP
	GfQKx3s6dA5KFaUIOTuLCn1AcO43PwuG0w15TLse0j5IZtYCzPBtIQ/RPXsVKmglxH9JZN3MG5V
	lppMN/FUdRaI/mFtZEkljzZoEYErU6pHTnT/P7SaAsYfA==
X-Received: by 2002:a17:90a:dfcf:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-36bbcc146f3mr122373a91.6.1779999729076;
        Thu, 28 May 2026 13:22:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908da770sm2334406a91.2.2026.05.28.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:22:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	ceph-devel@vger.kernel.org (open list:RADOS BLOCK DEVICE (RBD)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] rbd: cast snap_count to size_t to avoid tautological comparison warning
Date: Thu, 28 May 2026 13:21:51 -0700
Message-ID: <20260528202151.136274-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snap_count is u32 but the comparison is against a SIZE_MAX-derived value
(~2^61 on 64-bit), which clang flags as always false with
-Wtautological-constant-out-of-range-compare. Cast to size_t so the
comparison is done in the correct width.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94709466ad19..b4ba51db9a28 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
 	 * make sure the computed size of the snapshot context we
 	 * allocate is representable in a size_t.
 	 */
-	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
+	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
 				 / sizeof (u64)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.54.0

