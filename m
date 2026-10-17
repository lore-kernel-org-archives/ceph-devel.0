Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317435C6B4
	for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244428; cv=none; b=Do2fkXm9Afa7gjyxS7zEqLPeZR55BryH16mhS73PGtqVDyNK9+fHR4W+UE8PRP8pxOsHkyyQNJbzodswy8Tm9tX2NZvsTk2JWTJc2z8AB6Tx65dY+39xAxu91xp32QGt9SCfKwcrqb0h17h9z/bD5j4mSHaN4Rx/Tcl1Ng4BkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244428; c=relaxed/simple;
	bh=fGhpFHhnxJbeuyXdQDXOoiQeUDoWhcJ8jAOHC6D6C1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sn+o6iX/IWi7W8Y8CLjQXtJ7BqDhIDit6GsX5/rnBJTaMqOMu5culklbkS1XUvXnthwFPOh4vQCk7b5zxmkeo7cJumfjmIHxXch6WLthLexuVqRlULLTv0cORlcWHuZxGWt32RFt6fMY61tIF3T+MbuCLcH6ppybzI2O//1wSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJk6vtcw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nQIaPBmg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJk6vtcw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nQIaPBmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
	b=VJk6vtcwega8JSs80XKrWvftfxvfvyKNIjxUaaSrLHbZzVYhN8rPDSiD97x0M5LoUt21Wu
	3TwFsgghE9rupnuJMMZvWrpSQCo3lNN2UF/GUCNlpus0MRTxFwvCir4iE0Ws9Hvs5tavFe
	/rF8Co/kjnPKVtrol/F1QUUgdpdovQ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-vrvnnC6jMU-gJAphWRgOxA-1; Sat, 17 Oct 2026 13:40:23 +0000
X-MC-Unique: vrvnnC6jMU-gJAphWRgOxA-1
X-Mimecast-MFC-AGG-ID: vrvnnC6jMU-gJAphWRgOxA_1792244422
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1ab11f4a3so655969a12.0
        for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792244422; x=1792849222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
        b=nQIaPBmgfWQI92C23rCovKoLyViOqODI9pG45SpqZO/rH+JM6HY+nQEVdj2MIi+UPN
         awF9uG4jGGObFmGg+MKK7Xy1SdHv/ESBdRw1Mv5S9TjbnrDMbbdSqX6uye9dE8PPdrjl
         o1llR+m0H2mdYOaqqMwRIeDfA0OMld9TUBwpPimwh0+ZGIXnScvA5u9g9oAnnQZl3rIp
         2mVHeIzkxP3n63i0nV+N2QjOSNe0C9qrvFijZ8g4ViJ9L2yo95DCnfEnhTRKnj8lgnTg
         oqHHHyDZs2sJcVBrBacBMrUKcA6UMGPZVl3KxTb0oGACs/kYPnc0VjP/g5W4QxTSrm7s
         I9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792244422; x=1792849222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
        b=VugQ2jwooeBcUkYat4Vc59W70i5+FmytnW6yl1QmDkcsCjzFsPXNSWOjQRnuJLBwWn
         EwScEJzvBrShlmwWJm/dV2+8Z4dnU6ukwE70ur1MzGi/dKrf6Sm3IdsmCDIHqu1RMgZ5
         TpqHIz3nJe5eL7LkxwtzvHlx05OGfvUgcwtbmhmxBUuB9V0yaGiM8cayC12iiO3FY5WM
         zxJjwBV8kS32Dll9At4oViN2Y3vLeDgNlDbOjJruLjwdFRJ0S6+/WC1emYg0UZevdFC9
         wtiOWn1povxA1lcLPtW7Fa4ttdGA2Y3gRrMWDGtxxSE6xnsowBlu7wk9gJhIra2qcNJ0
         tyOw==
X-Gm-Message-State: AFq9FYI3E4RqObbPJbYvXSzuMJjFSiEx7JRT75kEd0gpzjVJZUA71vcE
	r3ZlDENzTipP6A3jTiSy3FAq1/q/nLeO7AcwwKYnhUe0uMcN1qhbErtIIRfeeKudlX70iHWZNK3
	dagcDgnMyDvSUiWIculu9KjTvswiOVVpPyqrYJ1TvbqNFSaVr82KUpJgqd51sEqjsvbYx/MRewT
	0xnTfVTHoSaVObHoTAv8SueL0R9/zzuf3a+R5zbdEQSW0kaBW5Vw==
X-Gm-Gg: AYBFou1sa2gYxstEXSm3nQdITU6WQu1QHkCiXmjB1auiKSHJBtCYR/eMVl+wdUr81+E
	4ketdlUTcDdDIYsQuRTLTpEEXvUPtO2Zdmr6/EkM0qbzNJJSx9dya6h/+qh6RfpFDMWVQsKmFzS
	r/zd3YiBG8rfoRq9aJJ3Ut3sZYs6XlGNMKudiwlNU2fX71KoyLAKrUO8h8usKO3C/zF6aZBftiB
	9TjschnEa/4wZIX8d7gN6GEvDboV0AGZimSouB12oCtgUcPlAjM9ahV0tUhzVW4A2hyzneoAkuY
	VhtT89JIJhdvPpFLQClmD5Ub9OkyEm7ggLyFPyGU6di1xzCijv3+X6fZV10f8/9QMTfTYjwNgYO
	Yu/zNSjXO/+5YHIhCQaxdM1kFU+EK22HvuG5bi+EnMShBkGmlG/U+E1KnVbwIEynvC38TYj9Y4C
	tisGjCb/3fjxaZGaA7HtZc9IMWK2hNr6oI9wtELRyTM3KcT7/kZ2FXPEGK9pSXdtd2ICX5loDE/
	No=
X-Received: by 2002:a05:6402:4018:b0:6b1:bcde:9f32 with SMTP id 4fb4d7f45d1cf-6b3a817697bmr1371830a12.7.1792244421948;
        Sat, 17 Oct 2026 06:40:21 -0700 (PDT)
X-Received: by 2002:a05:6402:4018:b0:6b1:bcde:9f32 with SMTP id 4fb4d7f45d1cf-6b3a817697bmr1371813a12.7.1792244421483;
        Sat, 17 Oct 2026 06:40:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm1913032a12.10.2026.10.17.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:40:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ceph: support subvolume quarantine
Date: Sat, 17 Oct 2026 13:40:12 +0000
Message-Id: <cover.1792241577.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792074165.git.amarkuze@redhat.com>
References: <cover.1792074165.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine isolates a subvolume while allowing access
by recovery clients with q/Q MDS auth caps. The kernel client currently
does not advertise quarantine support, so the MDS can hold its requests
until quarantine is lifted.

This series handles MClientCaps v14 quarantine notifications, checks
cached data and metadata access, and handles disable notifications.
Fresh MDS replies allow recovery after a lost disable. It applies directly
to the base below and has no fscrypt prerequisite.

The first patch exports d_find_alias_rcu() to GPL modules. The remaining
three patches add the wire definitions, record quarantine state and
ancestry generations, then install the access checks before advertising
the session feature.

Changes since v2:
- Add the VFS export prerequisite to fix the undefined d_find_alias_rcu
  symbol reported by the kernel test robot with CONFIG_CEPH_FS=m.
  The fix carries Reported-by and Closes tags.
- Keep all three Ceph patches unchanged from v2.
- Replace object-only compile validation with a complete W=1 kernel and
  module build using GCC 14.2.0 and the robot's x86_64-rhel-9.4 config.

Validation:
A complete W=1 build with the kernel.org GCC 14.2.0 toolchain and the
robot's x86_64-rhel-9.4 config after olddefconfig passes. It produces
vmlinux, bzImage and all 2,233 configured modules, including ceph.ko and
libceph.ko. MODPOST succeeds, and Module.symvers contains the GPL export
of d_find_alias_rcu. Configuration changes are limited to olddefconfig's
toolchain capability normalization; there are no manual config changes.
W=1 warnings remain elsewhere in the kernel; none come from Ceph or
dcache.c.
All four patches pass strict checkpatch and apply in order to reproduce
the tested source tree. Seven deterministic source-extraction regression
runners pass; the ASan/UBSan/LSan VFS runner also demonstrates the remaining
cached encrypted-readlink bypass.

Known limitation: cached encrypted symlink targets can bypass quarantine
checks. fscrypt populates inode->i_link, which the VFS can use for readlink
or symlink traversal without calling Ceph's get_link operation. Uncached
encrypted targets and plaintext symlinks still pass through Ceph's checks.
Closing the encrypted-target cache gap needs the separate fscrypt support
and Ceph opt-in follow-up.

Live cluster, KASAN/lockdep, multi-MDS recovery and depth benchmarks have
not been run for this version. Existing snapshot mappings need server
notifications to revoke already installed PTEs. Disable messages carry
no generation, so same-rank ordering relies on ordered MDS delivery.
Recovery assumes the intended rwq/rwQ delegation; overlapping ordinary
rw and read-only q/Q grants still need server-side cap filtering.

v2: https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com
Robot report:
https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/

Alex Markuze (4):
  dcache: export d_find_alias_rcu() for modular filesystems
  ceph: add subvolume quarantine wire definitions
  ceph: record subvolume quarantine from MDS cap updates
  ceph: fail quarantined subvolume access with EACCES

 fs/ceph/acl.c                |  28 +-
 fs/ceph/addr.c               |  72 ++-
 fs/ceph/caps.c               | 291 +++++++++++-
 fs/ceph/debugfs.c            |   1 +
 fs/ceph/dir.c                |  51 ++-
 fs/ceph/file.c               | 117 +++--
 fs/ceph/inode.c              | 841 ++++++++++++++++++++++++++++++++++-
 fs/ceph/ioctl.c              |  13 +
 fs/ceph/mds_client.c         |  23 +-
 fs/ceph/mds_client.h         |  26 +-
 fs/ceph/super.c              |   2 +
 fs/ceph/super.h              |  80 +++-
 fs/ceph/xattr.c              |  54 ++-
 fs/dcache.c                  |   1 +
 include/linux/ceph/ceph_fs.h |  13 +
 net/ceph/ceph_common.c       |   2 +
 16 files changed, 1482 insertions(+), 133 deletions(-)


base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
-- 
2.34.1

