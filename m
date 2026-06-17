Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B91C862F
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708397; cv=none; b=QGt82CgCtO100AOQNvJVCAxQhhDfKf+Wi1rByI2RHa4XUiuLssGx6qUkpD46EqeWY7eMoFOle4XuaaZGecN2IolnoaLS1XG6CJzaZLzNFwTHZ9tb0Akp7pIZl3VwUTFDtoZY3MEoYD2ws6JwccS64cu9+K1B453blUaAXaxcoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708397; c=relaxed/simple;
	bh=l9AhsV9yqBDjSTP7uRc4DYYWN3E3nRHzJfTk4CTlsNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQ70j+mq6/V8hpLYn35gCsXIjT+lpaocv5QMqG/ive6UXAQy3hERPCzj+YY1fj1VOlqJCZsfp3nbA0LfNVvMTQ+VH+KF5XMtWe6XAxNYMXB44/PlVyfQbRNhIlvkWvLt9TXNH5ns3sCnj1EFX7pkhc1/isDRhSA1U52VSJwy0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTer8Tm2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYThnA3G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTer8Tm2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYThnA3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=70vVlKIsy87sxz5mEsRlgPKPwqXbZgi9qwntFNo5UWY=;
	b=ZTer8Tm2wxhRwgjLsVKl6r9baIVMQbjgl2VB6D9PhZ5cs7CNTgj3fcMuwkJkWsnJY0UoPc
	Hpq84khMHPshGzhWcvcpgZU//+8eHd9H07Bmj3z0Og9soOgYCTNI3YYI0ZBqrTMURfj1Kq
	+U4eSEVwOf4d2OLcjRp51NA2TKTWw5U=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-6SyN3mXPN7WrvzOtfsVnaA-1; Wed, 17 Jun 2026 10:59:53 -0400
X-MC-Unique: 6SyN3mXPN7WrvzOtfsVnaA-1
X-Mimecast-MFC-AGG-ID: 6SyN3mXPN7WrvzOtfsVnaA_1781708392
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6c8a160c4so11753496a34.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708392; x=1782313192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70vVlKIsy87sxz5mEsRlgPKPwqXbZgi9qwntFNo5UWY=;
        b=OYThnA3GNWAM66gpJYbi8MgmWFTqUopr+iEh566xb4stMZT+BWq1ZNgRjidgafHnVD
         RdA608YBZy3IiRO0v9XPsaMraczZwNGUpsOVP5VF5jG2ixd5yIYhAirpk8r60o3iCwyt
         zzJOGc2cDCRj6g4Dnv4rZZeDmk6V5ZA0RAYVNY0x/qXcZVd12zh6HEeyljy+91ACkQh6
         YSc5Bmnb4apJtF1EpEIma3XVYehPDVRo3K/mZYoF8uGd4hopbDIgm4w8//xvVxRIvZHj
         C1jqYZevPqU6dheBoQ18SAe+xA9BMlPPHk8xsRyzuUAdoDI5Pp3WFTN/qobZJUSImACi
         64UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708392; x=1782313192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70vVlKIsy87sxz5mEsRlgPKPwqXbZgi9qwntFNo5UWY=;
        b=UGlHg2qBf2oM/Zum8HiiYzFH117EGgox82bq7wRZf6VqF/UrICas5tDVnmxZEDfzLx
         SIFeI47osX8l2EeZI1tj8bh058BzC9xjEGn8m3Sj7gYSFM/A7Tz4SOPUSMZRXhd5kC5W
         migsACRwdygVSTvwisgTejw/R48ZnK7VR6i4TJnAX7/wPZbBpp0Mdww5w/wwMjJ4veJ/
         RJKz/r+MbgyCJK8H/p+sT5ybjTVUtl9P8d7G8fZwP5OLQ+qD7Dji84Zbt+rCnl/ddbNC
         9VcPas0NsGKRenL6emPLQyGWnYv4DFMDtqjdElgPjaYxSemF568OvWm+IU+Hy2wzzmqo
         RP3Q==
X-Gm-Message-State: AOJu0YzlDyvg0zv0lyh7gtspYopuR8T16130IP22Cf1m8d6gqljo0XyP
	EEiWhQf2yrPiUtxeUrU2bKhM9xXV3jRvPQG7MbTmLhCHHY1pH0Dn5xQ6U0fk+mbT0xW8ZRP9Nsw
	tNfRFwTLZVK9OsmO1WemnKbdkEUoMaYbfQ6PLP6ZzCOB3ox8G1DC8mf9lOdgprQsdtoyXzcaqqW
	kME/HYLLyq/oAzozEcGs2J5D9FcygoHjyRxdsQm56LNcO2ahw=
X-Gm-Gg: Acq92OEG0phnvWm2btx0Vza0CgsWgZEBcqZuJc3xd2jgbjBS9IqmTpFPMw5fasspb+W
	nQPn8P+kOPpeV0ux4CbwU4R0oET1mGr8P2KIBO6tC+0s0PmGCbE1zaBds46ll/BlI06GienP22h
	8+dOanXutOhRPr6wGwT17naR+CfxqAqJZ2gsVA2lpkN5Ks7yhF9dx2+XFC+M5LW7OKZOtnLWRRW
	qZuF4dWPhXi0P1xwpsuR9FQjPqu6P91HihxNMXTLTTrd9AfJkVOTcdzSIiXfDuZh+Xwk1q2043u
	mKcwJsoTTa8Opy/tMi0FCktdzrnSK25rGHX73bQclLhnRzhJJU3668gOJfD9lNT1i5XWX7Eszxu
	sW3afuGgw463sb8WHzcTso3lMsO5kdYYImJSjFotyL+X1
X-Received: by 2002:a05:6830:3886:b0:7e6:e453:25b6 with SMTP id 46e09a7af769-7e90c5bab2amr4040466a34.6.1781708392339;
        Wed, 17 Jun 2026 07:59:52 -0700 (PDT)
X-Received: by 2002:a05:6830:3886:b0:7e6:e453:25b6 with SMTP id 46e09a7af769-7e90c5bab2amr4040424a34.6.1781708391744;
        Wed, 17 Jun 2026 07:59:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:59:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 00/15] ceph: add binary logging (BLOG) for CephFS
Date: Wed, 17 Jun 2026 14:59:30 +0000
Message-Id: <20260617145945.1912736-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a binary logging subsystem for the CephFS kernel
client.  On hot I/O paths every dout() call formats a printk-style
string even when nobody is reading the log.  BLOG sidesteps that cost
by storing compact binary records keyed by a source-ID; the records
are decoded offline or via debugfs.

All new code lives under fs/ceph/ and include/linux/ceph/.  There
are no changes outside the Ceph subsystem apart from the kselftests.

Design
------

Allocation.  A page-fragment allocator hands out buffer slices without
taking any global lock.  Freed fragments are recycled through per-CPU
magazine batches so the common-case log path is allocation-free.
Filesystem-reachable allocation uses GFP_NOFS to avoid reclaim
recursion.

Source-ID caching.  Each (file, func, line, fmt) tuple is registered
once in a per-logger rhashtable and assigned a u32 source-ID.  A
per-callsite cache with smp_store_release / smp_load_acquire avoids
the rhashtable lookup after the first hit.  A generation counter on
the logger prevents stale cache hits across mount/unmount cycles.

Per-superblock ownership.  Every mounted CephFS instance (including
-o noshare mounts) gets its own blog_module_context, so enable/disable
and debugfs are fully isolated between mounts.

Context propagation.  ceph_blog_enter() stashes the owning
ceph_fs_client and an optional mds_request pointer in a
ceph_journal_info that lives in current->journal_info.  Nested VFS
re-entry inherits the context only when the owning fsc matches,
preventing cross-mount leaks.  Task pointers used as hash keys are
not pinned; stale entries are retired lazily via PID-mismatch
detection on reuse.

debugfs.  Per-superblock files appear under
  /sys/kernel/debug/ceph/<fsid>/blog/{entries,stats,sources,clients}
plus a bool "enable" knob and a write-only "clear" trigger.

Logging macros.  bout() and boutc() are drop-in replacements for
dout() and doutc(), gated on fsc->blog_enabled.  The serializer
supports all kernel printf specifiers used by Ceph debug logs
including %o.

Patch breakdown
---------------

  01-06  BLOG infrastructure, one patch per compilation unit:
         headers, deserializer, pagefrag allocator, magazine batcher,
         logger core, per-module context manager.

  07     Ceph BLOG scaffolding -- ceph_blog.h, blog_client.c,
         super.h / libceph.h additions, Makefile wiring.

  08     bout/boutc macro definitions in ceph_debug.h.

  09     MDS request plumbing -- switch __do_request() to
         ceph_blog_enter() / ceph_blog_exit().

  10     debugfs interface -- blog_debugfs.c and lifecycle hooks.

  11-14  Callsite conversions -- dout/doutc -> bout/boutc, grouped
         by subsystem: inodes+dirs, data I/O, caps+snaps, helpers.

  15     Selftests and MAINTAINERS update.

Alex Markuze (15):
  ceph: add BLOG public headers
  ceph: add BLOG deserialization support
  ceph: add BLOG page-fragment allocator
  ceph: add BLOG magazine batch allocator
  ceph: add BLOG logger core
  ceph: add BLOG per-module context management
  ceph: add Ceph BLOG scaffolding
  ceph: add bout and boutc wrappers for BLOG
  ceph: switch MDS request plumbing to struct ceph_journal_info
  ceph: add BLOG debugfs interface
  ceph: convert VFS inode and directory paths to bout
  ceph: convert VFS data I/O paths to bout
  ceph: convert capability and snapshot paths to bout
  ceph: convert remaining helper paths to bout
  selftests: add Ceph BLOG smoke test and collection helpers

 MAINTAINERS                                   |   1 +
 fs/ceph/Makefile                              |   6 +
 fs/ceph/addr.c                                | 168 ++---
 fs/ceph/blog_batch.c                          | 312 ++++++++++
 fs/ceph/blog_client.c                         | 266 ++++++++
 fs/ceph/blog_core.c                           | 424 +++++++++++++
 fs/ceph/blog_debugfs.c                        | 434 +++++++++++++
 fs/ceph/blog_des.c                            | 342 ++++++++++
 fs/ceph/blog_module.c                         | 584 ++++++++++++++++++
 fs/ceph/blog_pagefrag.c                       |  95 +++
 fs/ceph/caps.c                                | 252 ++++----
 fs/ceph/crypto.c                              |  14 +-
 fs/ceph/debugfs.c                             |  23 +-
 fs/ceph/dir.c                                 | 290 ++++++---
 fs/ceph/export.c                              |  83 ++-
 fs/ceph/file.c                                | 274 +++++---
 fs/ceph/inode.c                               | 233 ++++---
 fs/ceph/ioctl.c                               |   6 +-
 fs/ceph/locks.c                               |  66 +-
 fs/ceph/mds_client.c                          | 293 ++++-----
 fs/ceph/mdsmap.c                              |   8 +-
 fs/ceph/quota.c                               |   2 +-
 fs/ceph/snap.c                                |  66 +-
 fs/ceph/super.c                               |  58 +-
 fs/ceph/super.h                               |   5 +
 fs/ceph/xattr.c                               |  88 ++-
 include/linux/ceph/blog.h                     |   0
 include/linux/ceph/blog_batch.h               |   0
 include/linux/ceph/blog_des.h                 |   0
 include/linux/ceph/blog_module.h              |   0
 include/linux/ceph/blog_pagefrag.h            |   0
 include/linux/ceph/blog_ser.h                 |   0
 include/linux/ceph/ceph_blog.h                | 284 +++++++++
 include/linux/ceph/ceph_debug.h               |  44 +-
 include/linux/ceph/libceph.h                  |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/ceph_blog/Makefile    |   7 +
 .../selftests/ceph_blog/blog_analyze.sh       | 124 ++++
 .../selftests/ceph_blog/blog_collect.sh       | 116 ++++
 .../selftests/ceph_blog/blog_smoke_test.sh    | 363 +++++++++++
 tools/testing/selftests/ceph_blog/config      |   2 +
 41 files changed, 4583 insertions(+), 753 deletions(-)
 create mode 100644 fs/ceph/blog_batch.c
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 fs/ceph/blog_core.c
 create mode 100644 fs/ceph/blog_debugfs.c
 create mode 100644 fs/ceph/blog_des.c
 create mode 100644 fs/ceph/blog_module.c
 create mode 100644 fs/ceph/blog_pagefrag.c
 create mode 100644 include/linux/ceph/blog.h
 create mode 100644 include/linux/ceph/blog_batch.h
 create mode 100644 include/linux/ceph/blog_des.h
 create mode 100644 include/linux/ceph/blog_module.h
 create mode 100644 include/linux/ceph/blog_pagefrag.h
 create mode 100644 include/linux/ceph/blog_ser.h
 create mode 100644 include/linux/ceph/ceph_blog.h
 create mode 100644 tools/testing/selftests/ceph_blog/Makefile
 create mode 100644 tools/testing/selftests/ceph_blog/blog_analyze.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_collect.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_smoke_test.sh
 create mode 100644 tools/testing/selftests/ceph_blog/config

-- 
2.34.1

