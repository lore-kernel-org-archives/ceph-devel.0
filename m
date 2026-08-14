Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC348D864
	for <ceph-devel@vger.kernel.org>; Fri, 14 Aug 2026 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727845; cv=none; b=Z8x+370+eTyN9hO48NlrXYBKdc1Y8jy09kzKLWTH3KDDS1k16JzoZ4hWwbQFXZTkRy0J/hs7RjlVQs8OXHRO16DGKzwGCrkzifOTv7XfKbuDyrSfQ1LucRsWgqB+fL217IrGw06pJem+7OpR+UmIYKL1WWYfQGlZWT+pvs6UftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727845; c=relaxed/simple;
	bh=c0Bx0y03G3JA1xg7tlPmt5I3GWfuKaMBDET9Duvbzc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKlFJlCJR83ovX4dOUAT1QehGqckNn4o714iKMxJ4m1n17/aj2FG0PEH8LFpO4oVwetYlC2nKDdN3Qcwap6dNzHwAUkJ9ViZscYFTk2WWcprlxPR7D18bt2e660GN2euJrRj0gK6dH1gOs8DAWozEauxXOa8ppjk9UxlU3HARvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpvtM81n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpvtM81n"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-936cda0e3fbso108505485a.3
        for <ceph-devel@vger.kernel.org>; Fri, 14 Aug 2026 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727842; x=1787332642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UJuP8cblpEM18OsTLBBDIvTtr4PpM2qo+/k0bzxnlc=;
        b=MpvtM81n4Xr0ixSkR80gwA+m1MQw6r0aFTukzWP01v6NMmn5C82+FRabCzV21Gd93N
         0vdho8JFmMN8PQIyqLYocwVNs5n9vCWX/yRg091/aqi/JX0RLWXiB+xkSA3v8RZQzlfV
         MDCuRK5AZ3mL0XqcKpeP056QvcVxvJn6eldYssjpXZnJDzkGm9NL4HwWwfVvMUqEj0hd
         VCds9D68CdBAyB6o5rLIjfILTw3UVgmnv7F8is+kmJI00XE95Ika+A6TqIjLrQQoVcAx
         eJhHJqwDgMLfWX3Hn9wX4dmJNTuZtYmVvG9DtFtCmLIuRILjCJXa6zPPYFta16ehm/2G
         A5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727842; x=1787332642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UJuP8cblpEM18OsTLBBDIvTtr4PpM2qo+/k0bzxnlc=;
        b=T3BblWjD/MqvhNBDMN/HdLKgnPEUkTLaWmr8PSWu0Pjc76NrQn5ZL7jimusi9veg12
         GzyjoDaezGVN9XV+m4E/kIg1k2HO1IfZ04vGBYGK6+rT3tMJyGZyFfGGw7M3S6cAByPz
         bif+c7RNm7/R37UpwBqmEXZoeyetYoFua4JDgOU2r4X3qFFSSJEs9nzFU60YFQklX374
         v7pGmprj1zcpiv/Uzyk6bQXlY+aRJMCd6Odk3EL0ZbZGDSjsTeK5zqBjh8GyoucYE8nE
         5BxlPpuxCG28nSnHM3wpRnH/HjA7SnD2VLeR32IxTdq6slrFyweNTUP0dtO54IqQl5Ge
         3TCw==
X-Gm-Message-State: AOJu0YzzhDEHfh6xMZbVIzIMhuGasjeYJjjhF7r+ZblcitIHzWftbizR
	V7mV5sHt/97BzFahWHonTgWCTKxsHil6K6B4/vtgPHv7gG+UXbytawOyPW63FA==
X-Gm-Gg: AR+sD11a5/BpuQeTbMj3zCH7ZUdKanA5K9GS+YMB3HtN8F5lqs8pMyttFiXcVIUQvRI
	nrsLDXAi+zP32Qk6jHwsOHeI+KPo4kTZoDdh/PF4tpr4CJwY4tXfTA7LQyD5lX3m3B+e0XxQNQa
	Rthgw3lc+/0Nl9IY9dEYpTp7or5NRvN/aeNQJ29tcBbB9cSdjaZRkVhOofk2s4cnSjOJ7hmwjQB
	RyK3ASxyjB8mJZd9GLxf7z11IukVCY5w09cyxCueZzMzTzChAcEwe6/Li0SQfLQRYhAY7+tsyeF
	kyR9nyEyoDRc8HSqbdbapG20vejQPwv/FimoI+JJQ/X4OMJGgwPcQ4LVVnutd2NN3cWWjnI+Am9
	Rbuhf83FI6ctpVcOb+EkTvjEkrkZRGCp2mpgB36UNf3E3xGKq9AIrvB1bAFUiX7ojtAE1bzeaVK
	+xGWdOJ1clBKNcnxOwuggystawZIuFDqrqEuNyWKzo2tWl0JcUs2aFnHN8Rgjx0Q4hm6ooMx9lQ
	siyq7CGt4bOiSmxqVsuWoY=
X-Received: by 2002:a05:620a:a906:b0:930:f35d:41ba with SMTP id af79cd13be357-936d22ff1cdmr729753585a.36.1786727841854;
        Fri, 14 Aug 2026 10:17:21 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1ea65fsm309771285a.30.2026.08.14.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:17:20 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 7.2-rc8
Date: Fri, 14 Aug 2026 19:17:02 +0200
Message-ID: <20260814171705.995932-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc8

for you to fetch changes up to 91880e4a7fac45bc407771bc57bbaf4f37e9b4c3:

  ceph: use the mount idmap for the owner checks in the SET_LAYOUT ioctls (2026-08-12 21:21:41 +0200)

----------------------------------------------------------------
A handful of tiny fixes, with the main ones being a follow-up for
CEPH_IOC_SET_LAYOUT{,_POLICY} ioctl permissions check that went into
-rc5 and a userspace compatibility fixup.  The rest mostly harden
against malformed network input.  All marked for stable.

----------------------------------------------------------------
Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix OOB read in decode_watchers() via missing bounds check

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Zhan Xusheng (1):
      ceph: use the mount idmap for the owner checks in the SET_LAYOUT ioctls

 fs/ceph/ioctl.c            |  4 ++--
 fs/ceph/mdsmap.c           |  2 +-
 net/ceph/cls_lock_client.c | 13 +++++++++----
 net/ceph/decode.c          | 18 +++++++++---------
 net/ceph/osd_client.c      |  5 ++++-
 net/ceph/osdmap.c          |  5 +++--
 6 files changed, 28 insertions(+), 19 deletions(-)
