Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEE3E7150
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053212; cv=none; b=HwCNJIY40unLbWt0WmViTOYJp1qqHT3yAnuiL3kFkHh5Rq+EJS9oqCU5s1Zgrgdt/npGUn+0jFb/wKjROQohXAGi+anRBFSpk8LqS5gKwim1pLyhwQg6ah5gYFQ1o7DOmdt+0ctzvtIaoXSNgvL6KXlxpPrTE5BHJZZiFbvannU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053212; c=relaxed/simple;
	bh=Lm+n96F4MsUOZh2J0V7FqRyvAdyt/Ej0jiO0vn+zsX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBIKslJF26agWoA4kIcxYGEopcd4mCjSEPLmSU64YlHD9B4WnXaB1x/gkWoKN4ndLn5pK2gMjo5cqO0xf48BY1Bt19dIEpYmhg/JTv7kUc9yo8224RZCLQIZmPbGgbcwiWiofw7tJueqTXALlyNp91y3z8tVwgGW3GTjTpICEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcZ7M1ej; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcZ7M1ej"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ed4dd182efso369094385a.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777053210; x=1777658010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nnj9K1Sy4yoAYWsAvrupUIgMEbUx4MKjZUsZlSxJzsc=;
        b=gcZ7M1ejNdHQj5JjIWiuFgCxHl2l4YSBXMf9muZUNF7NphlyXdu+w4vU+H/j+8u9Ls
         //9RlKo1gZHnrbvu0A7B8LWgIPrt0ZTZCzeDrZ0h7GBBq+sD/iNquWIel7vHYRfW9Tvc
         RMRCh+pqCzSGvMAvwSP9pml897aJz8R+wyzZ1WVEpgy6CYjLxdDdaq/jZSPQzUmmG0wY
         EbsX8Ualcd3c0nLvhmuVmQLgsxBcAY3UA1Pl2wvklU15Amq7QyeD0jZ7eLSabIy+slz4
         LCa/sF4aL/LG4qm6oKrfF4FqdbySu/mnJ2NzXVB8CZgPTIrCCl5KFk/hALb68ivdCUaP
         FE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777053210; x=1777658010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnj9K1Sy4yoAYWsAvrupUIgMEbUx4MKjZUsZlSxJzsc=;
        b=j7QUGCfqMym3kJbigQzxKsUqUtY+Y9UJLRnU2kkjzTZTrpvVfLUulYK4lG4V9oEUun
         sgBIXyKl3sAQH3EInDUx80imEMHuE+zTQpDsCKrYCzmAW20PiScHjddkOD4AnlLPPvJz
         BGcUxzrcpORdb9eIp9HfR5vAHw2Iff0oPo7a5cV1+XPLm03Z6fcxPmb+buTjPDO63hOH
         a0TT6PAlsT6iswhJ70QYjAQP5TnXLwXTGpGiJHKIAS4Ixh+DpBR7+taSsRyJrmnr+Q+T
         U7kzzv6UweidOeQ1lWSOYf/Ppp1CNEIl0GedbAp39rEUwbVbUEZUAF5h/PRtUK9vxuFj
         ZP1g==
X-Gm-Message-State: AOJu0YzAuXt68QyoOyTA0q4SvWhR4z+zKM8maiAgXWGNjQQ9s/dE9pCh
	zVKQLtfZSajsoSY93OPfKJtftjVt7pv/ETQhUarjSX2y+ydYWh9Q7J+0PbnlmQ==
X-Gm-Gg: AeBDieuEwXWEx1aUx/3ufC8rLQUT5gxJXLBNSWmpPS9BhQiokyZwBcEnr4aZ9j1OrKi
	mSUOt+sGpBuBEstxxtbY/vrVE9Ty8Afm5lR6QB7HrZqgBKNtvBhZ4WPnM89qN4/yTI9ydGmqdgp
	7gOSnKL+ZkH1YmsqdUMnoASu3SzABpR3h8fWKTZ+kc5J39a3vvqcVr5LUKYhVpYZdlEL5ZJLxWF
	igG991BD7stvXX02xEnpMVXkuEXg2NoSq46K7hXqLso4jUM4qZypjY80NXzpF4E3re2oLhD6lOa
	6VS7ptPCrQMyp6vOxhRMkSs3odQ9ovlb+vxahggsLhwRv2uJgRXnLyXeSPCF4uNFovF2PqGeGrS
	05UO2Sp3I0N3NoaPJs/rVOzIJxfUwe0CobJNDIiglcXwWOan2ZaThnLGP7tW3e1RTV3Szb6ZHp/
	pzelOjuLGsi2byMHz6+ym+KpnU4+k1RyF19EZEq2f13nyWOtA5gWQoT90TfwJsZR44lXUXQe12h
	3Qsx/J5j5vPUFY=
X-Received: by 2002:a05:620a:29c3:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8e7918a1473mr4420469385a.32.1777053209848;
        Fri, 24 Apr 2026 10:53:29 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cce76sm2036738685a.14.2026.04.24.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:53:29 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 7.1-rc1
Date: Fri, 24 Apr 2026 19:53:19 +0200
Message-ID: <20260424175320.279295-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc1

for you to fetch changes up to b1137e0b3d4bad1cad73fa9bac763c74ddd1813d:

  ceph: add subvolume metrics collection and reporting (2026-04-22 01:40:23 +0200)

----------------------------------------------------------------
We have a series from Alex which extends CephFS client metrics with
support for per-subvolume data I/O performance and latency tracking
(metadata operations aren't included) and a good variety of fixes and
cleanups across RBD and CephFS.

----------------------------------------------------------------
Alex Markuze (3):
      ceph: handle InodeStat v8 versioned field in reply parsing
      ceph: parse subvolume_id from InodeStat v9 and store in inode
      ceph: add subvolume metrics collection and reporting

Dawei Feng (1):
      rbd: fix null-ptr-deref when device_add_disk() fails

Eric Biggers (1):
      libceph: Remove obsolete session key alignment logic

Max Kellermann (2):
      ceph: only d_add() negative dentries when they are unhashed
      ceph: clear s_cap_reconnect when ceph_pagelist_encode_32() fails

Raphael Zimmer (2):
      libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
      libceph: Fix slab-out-of-bounds access in auth message processing

Sam Edwards (1):
      ceph: fix num_ops off-by-one when crypto allocation fails

Viacheslav Dubeyko (1):
      crush: cleanup in crush_do_rule() method

kexinsun (1):
      libceph: update outdated comment in ceph_sock_write_space()

 drivers/block/rbd.c         |   6 +-
 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  18 ++
 fs/ceph/debugfs.c           | 157 +++++++++++++++++
 fs/ceph/dir.c               |   6 +-
 fs/ceph/file.c              |  68 +++++++-
 fs/ceph/inode.c             |  41 +++++
 fs/ceph/mds_client.c        |  98 +++++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 183 ++++++++++++++++++-
 fs/ceph/metric.h            |  39 ++++-
 fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 +++++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |  11 ++
 net/ceph/auth.c             |   4 +-
 net/ceph/crush/mapper.c     |   7 +-
 net/ceph/messenger.c        |   4 +-
 net/ceph/messenger_v2.c     |  13 +-
 net/ceph/mon_client.c       |   2 +
 20 files changed, 1144 insertions(+), 50 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h
