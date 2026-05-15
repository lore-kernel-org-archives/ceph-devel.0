Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D040314A
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866633; cv=none; b=Y6arsy4GwvehXMcpYQOWRK+J09CeXn/3IUgBESurtUD+0L7TZ2apMvTM8ljaH77/qQ90VV0MlhiOhOkIyCYf8Yj227mmVjlGbeOuEdPiZEU4J3VPCh/7nd/iJO6FFvo/Jl17Ku15QwWlEwQgYU+twFmCD3dbGSMrbVe6DIfn5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866633; c=relaxed/simple;
	bh=yDyzqr5he/6LNgp4fSca6XKjINKx6apkFWYU8wO8e+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXfvxH+SEJcaksC2NX7cTVi2GwgnmAiZfRzANpdecZEidTqnaDexR8nvqU9SUklCi4LmVMpxBNHkRW99XW2z22/J6bkASBpAmCEbov+D3qPtflN4+jrpe0hrh48nEtNtB1GJ8npani+sJNRbgVBFhyDq1DGPf1lTNeCjkHYH+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmTzatak; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmTzatak"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so115616d6.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866631; x=1779471431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6SgnQukwSsizf2FExSwKJyxsMbDssUzOaNIWNxcVUg=;
        b=lmTzatak4SkekgzwbN16wrNBL6C5eNDA7iELQJwsc5F7O9Kwi+uqMZdVYbszzXAIpk
         9ikwJ4n05TryVOxdAqozO8rHHkNqSFMKvARDzo1PVIWXA1yrhnadKFX89f4ZJdMymKrW
         syx7MOycEXTV31dS0nOtzeQbGNHHBV4IPNHLBqUltr5Z7xXlFxnuT9Ir2wkL4zlRUjoH
         gwIcQ5Ms1AEatiaWSQLukqweUxVhgK9eu8hCYkuzb7+nvXdcwjYbO7opnpxii1ykzzAy
         dl1gsyov9aIN0/dIb2Y3I3U+1G9lmZwhAn12kd4YAYa4lDdAYIH87JnPWMts/PgSyUHE
         N1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866631; x=1779471431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6SgnQukwSsizf2FExSwKJyxsMbDssUzOaNIWNxcVUg=;
        b=dJSd0/hK+daPaore+LmpvCSlTHu4+DRuuqEeRFhWgg2crHDM4OBScrNKbpSgFDY6fR
         LacHfcLOA4wCg+okyW6ve0ZtmAblxoXA7gnVzwWixs+YTYZP2aNVyY7koTzAf8N/nhXR
         W0ocVak2BrmmW9pNunjyjqs8NHu2SGXX/UvhaHgt45PtfDMMn3Pe9dyOhyzYUc2DhWeM
         43In86T3qlNIv+h/8s0Lw2aB0AslkFz8cp+3K1KyNcRBxQjLP0R7REKyPPfITidV0lrQ
         WfCGHdbYv241hb0gM/iei4/RxLpwSLbjtRc9miQyVne60xiuN5kcr5IbqhDcHhhOOLNw
         AMEQ==
X-Gm-Message-State: AOJu0YwQ1LMq7PrGNx3rXWv2/YbC69MZDO5RNGT5T96sGA5ChsRtWuD0
	dkPUG3RcrQrGkgnBT+0a+T1BOFwPJc9ETrThw4Ew9KOxJI3KAoi4YqCAseScmg==
X-Gm-Gg: Acq92OE+p9gl62/YOQDHIq+tRS+S+s98Hpjb+WQ4WULbn106nxipvXptEkycUaQoh8D
	/VfB3V27FjCe+lgssNJyCXpj39g42tMopQJtO0flX1+cCuxx6uix+NW1KQbSmMCGmEIGevfAfrn
	GC41UdrRaXH4DXwkea1pSPpKbMHOZ7f5+kk4dgSWJwBAm7FeWY2ZlNTBWuQi5Ow7BujCXR89Q5l
	1xmoAGG3F3pDsbJAbL3QCTpud6wo1fpp6doTMSOog0dlzIW05/yjE1wmbVe3QqdOcxhv7r0EJ4k
	VWn+b2j1XB0T/9OyHc6E/XHRVNqFXEFLJk2zlGP0yiDbC8LNga2pFcyTeiPh/l0MTJAlKARTGPz
	HoWaZYu7u7Yy/m3ysOhP//0Q+kUkoTB9xrJqYmJ12ifpJpAk2L+Tra/6dKhyAgf9bnq2TDTUQTJ
	WGLXQ0KFitPi5ud8AM7pYqPtiEb3zr69TRG4ZtbPaHDYVbDNjA
X-Received: by 2002:a05:6214:76c:b0:8c9:6960:15aa with SMTP id 6a1803df08f44-8ca0f67c851mr83780716d6.23.1778866631119;
        Fri, 15 May 2026 10:37:11 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d19csm58141336d6.13.2026.05.15.10.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:37:10 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 7.1-rc4
Date: Fri, 15 May 2026 19:36:46 +0200
Message-ID: <20260515173702.1273592-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc4

for you to fetch changes up to 28b0a2ab8c82d0bbdeb8013029c67c978ce6e4bf:

  libceph: Fix potential null-ptr-deref in decode_choose_args() (2026-05-12 21:00:59 +0200)

----------------------------------------------------------------
An important patch from Hristo that squashes a folio reference leak
that could lead to OOM kills in CephFS and a number of miscellaneous
fixes from Raphael and Slava.  All but two are marked for stable.

----------------------------------------------------------------
Hristo Venev (1):
      ceph: put folios not suitable for writeback

Raphael Zimmer (6):
      libceph: Fix potential out-of-bounds access in crush_decode()
      libceph: Fix unnecessarily high ceph_decode_need() for uniform bucket
      libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
      libceph: Fix potential out-of-bounds access in osdmap_decode()
      libceph: handle rbtree insertion error in decode_choose_args()
      libceph: Fix potential null-ptr-deref in decode_choose_args()

Viacheslav Dubeyko (3):
      ceph: fix a buffer leak in __ceph_setxattr()
      ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size
      ceph: add ceph_has_realms_with_quotas() check to ceph_quota_update_statfs()

 fs/ceph/addr.c         |  2 ++
 fs/ceph/quota.c        | 37 +++++++++++++++++++++++++++----------
 fs/ceph/xattr.c        | 17 +++++++++++++++++
 net/ceph/auth_x.c      |  5 +++++
 net/ceph/crush/crush.c |  6 +-----
 net/ceph/osdmap.c      | 17 ++++++++++++-----
 6 files changed, 64 insertions(+), 20 deletions(-)
