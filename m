Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C13769EB
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085661; cv=none; b=GVwUZGrGmfQ7PJeCjsQ+Ax1sxdS4p7PqlTjqRb7ZmlIYtVBlwbe1rYl/eYjYNlYgct9o0004v+4HJlGuwUAs9cuj7ifbu/q7Ghz+DufusD9widoqGVrfhuSxx0rbiQCOckwbzRrOdthjmjiK0SVvqqIrH4Xbquq2F5/XYsNA/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085661; c=relaxed/simple;
	bh=6V/AEA6NXf3UPKgXGvaUvpxq301jK5Wr/Cr0lNdykto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zvpn/1NJlQMUxgU7BUqDliay7c5Edt1M56Q+YOjjoybugZoXTHXskxTEazle6lx4BG25z/LWfWyaRhvKI5zCh0gkvosyVovlA++XqD05DZZjHsBC6qP9v8lZLWbcBQujYgwhs8Qc13/hCoKsB41OWT2yWyCYdEMuuUaq7aI5JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZWdjLb3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRqqU73G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZWdjLb3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRqqU73G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZpSh7paRO2Hew2TD5JPyr9a2B/LhlPe+LuqyhLL5jZI=;
	b=HZWdjLb36kBdUPMPx4mR/Sa2I+Slr6DrnBezQRjm0s/PmeS4C18hpxYrnTjhZj4hY4eyG4
	y58TH27G3jPkFLkQeRgpiarKFo5uz0daLonvjEBsH24q189mnN0t9WHApPTlTzlMLkc3+l
	0h7s0M/qX6YfDOBiQpEkIsB9xE/m7xo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-lICUAfMMP2K7rfm_KTwWIw-1; Tue, 22 Sep 2026 10:00:57 -0400
X-MC-Unique: lICUAfMMP2K7rfm_KTwWIw-1
X-Mimecast-MFC-AGG-ID: lICUAfMMP2K7rfm_KTwWIw_1790085657
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66ce3040ea9so4386771d50.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085656; x=1790690456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZpSh7paRO2Hew2TD5JPyr9a2B/LhlPe+LuqyhLL5jZI=;
        b=JRqqU73GFLsHO0PDyzgN594LAqX4KK0+BW1colqiSIOYqqyIVdnpSBpiBtNjUilKfe
         Ze/AUL8j/xBPzymCOrQmq1ntbPyotLpHQZFHAqbvA4FiUg5ebK4gyFZX1uvZenJLZ44s
         MQAyoMxSY0LbnnKDNt2PpkP3QQ/sqVbNBIVwk4TuulprpqZ5byqLgzWDPLCVDOSfgdU7
         jBLErQQ8hZPST/tbm9crDWfoT07Ns00ugD5Ylk1ZvPKpHDa8853KDVZ/H7maNcY47S3i
         s5xarTbMpWdeIDSSBxxQxQIEXHXqRM3A5Ojh2tgqDMS8fD5ubwtEa0JtRENnr3N7noSU
         0+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085656; x=1790690456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpSh7paRO2Hew2TD5JPyr9a2B/LhlPe+LuqyhLL5jZI=;
        b=0ZjF9CI9GCacXxkBSIqLAtiYVuzg1iqG5NNCpivVno0fGcfiVHKy1CCOQo0ZMOEfu9
         pPiQYh8zYRymlXm8aG02vnMdFbqmb0l0pbdiO9YFQgfbG9iwzk9mjanqoIpIBo6vSq9G
         NDt6nuZL5YXKD0ATntvyP6B9aTRfR3oMQZAkTCSTqPIFQ6Y51SH2jZPBVN8MeD/eSQLW
         fIa1UmPzjvloUYphPKf4CTzkWdAqjTwbfs/YPS55k/I8puQ5DSI6EyzzES89E9qXSG/B
         aKLSiAMLpIFUq3p0BQTHrerSgClcboVlcIfgtP04PSO0IBR3X9OSqueONqZfh1A0BPNL
         IRMw==
X-Gm-Message-State: AFuF++kF7LwF/4+Hyr/r+BjqvD70H1zl2ii4Yl6sDkVQd9pfZRNabJKe
	VetmL/oU4TRn/Lwyxm8/eoisc5m50iyoEvxIK2smsrkk1RpnyEDi6W6p0hgsx1N080Vw6tOBWsR
	5txGzjVOqW/QVOLq51LS5AztbOZD+071hlxU7n2IH3LPZHyPHuJVNhYVExP9JkT21FMfnn0Znvx
	r09KYiduvAcnRz287j+2pH3LpXKuxK7tIrOvioixRCvN3b7Aiu3g==
X-Gm-Gg: AYBFou2viZSBQMBQa2zV8Ja95mZoi9E5b/5/iu88MiDnPkVGaxnrbvM/EzHn4UQ1VPP
	9GRBQ1T4GOCGuJ6JDg+OR8TH1BVSGUZcDFjPY+wfWJFgSg2N2hv+Lv+jyqIe4p+ryQOeSy5qCq0
	LqVsgbytVuH/QErJIPl56/bQw1b7+/iE+BLh5HU+7AUr2HhwdZ10DUQPuen9yxl7r2VJ1Tfu4Y4
	GlEwAbrHRW1UxKemfJW7VYv+2JcG1ZkUuAYWXmbTruDlQlJ3WBenRm5uCu3RDQ89h+P6T+5X1AX
	pI9uqUj4uL2dAI9gU9892OgQx3Mov51sZfMP6pcRoFgJfRdgZ7/7vw/ox2dxpHcN99PF/NXIHaw
	OlOOChgGyrOrvTeBU17Ba5Ro1+Lo7xZGNsg/cnKmMLlYa5+IA/MJ4yZW0I6VdXdApQBYRtdqqd3
	Cy1+iY3vNdQyCO+A==
X-Received: by 2002:a05:690e:4846:b0:672:99e0:ec03 with SMTP id 956f58d0204a3-67299e0ef74mr2436558d50.155.1790085656174;
        Tue, 22 Sep 2026 07:00:56 -0700 (PDT)
X-Received: by 2002:a05:690e:4846:b0:672:99e0:ec03 with SMTP id 956f58d0204a3-67299e0ef74mr2436289d50.155.1790085651807;
        Tue, 22 Sep 2026 07:00:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:00:50 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 00/14] ceph: add binary logging (BLOG) for CephFS
Date: Tue, 22 Sep 2026 14:00:33 +0000
Message-Id: <20260922140047.794405-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a per-mount binary flight recorder for CephFS debug
messages. It stores typed arguments in per-task page-fragment buffers
and reconstructs text through debugfs. BLOG complements the existing
tracepoints by covering the changing corpus of internal debug messages.

CONFIG_DEBUG_FS remains the only build gate. No new Kconfig option is
added. Runtime enablement is per mount and defaults to off. When no
binary context is available, logging falls back to the existing text
debug path. Normal CephFS operation does not depend on BLOG availability.

The per-task buffers, snapshot_mutex versus atomic-rotation split,
clear_seq handshake and reference-pinned teardown are unchanged from
v5. This 14-patch revision is based on testing commit 9015db49ecbf.

Changes since v5:

  - Select the optional context first, then choose binary or text
    logging. Each boutc wrapper expands its doutc fallback only once,
    avoiding duplicate dynamic-debug sites. Keep the per-task argument
    scratch and noinline record emitter.
  - Move readdir and unlink-conflict name snapshots, and cross-cluster
    UUID formatting, into binary-only noinline helpers. Retain lazy
    %pd/%pU text formatting and hold name snapshots through serialization.
  - Replace the unrolled argument-fill macros with recursive expansion.
    Preserve argument order and single evaluation without stack arrays.
    Remove the unused initializer macro family.
  - Allow normal CephFS initialization to continue if BLOG's global
    allocations fail. Enabling unavailable BLOG returns -ENODEV. MDS
    request tracking and xattr recursion protection remain available.
  - Correct commit subjects and stale references to bout().
  - Rebase the complete series onto current local testing, retaining its
    lazyio support and subsequent CephFS/libceph fixes.

Measurements use x86_64 GCC 11.4 with identical configurations:
CEPH_FS=m, PREEMPT=y, DEBUG_FS=y, DYNAMIC_DEBUG=y,
CEPH_LIB_PRETTYDEBUG=n and FS_ENCRYPTION=y. The baseline is 9015db49ecbf.
Individual frame estimates from objdump | checkstack.pl, in bytes:

                              testing    v6
  write_folio_nounlock            1128  1144
  __ceph_setattr                   568   616
  ceph_readdir                     544   616
  ceph_read_iter                   280   392
  ceph_splice_read                  80   328
  ceph_write_iter                  344   440

These are individual frames, not worst-case call-chain measurements.
All six v6 frames are unchanged by the rebases. Before rebasing, the
same-base v5-to-v6 comparison reduced write_folio_nounlock from 1336 to
1144 bytes and removed 43,303 bytes of text and 34,552 bytes of data.

The current composite ceph.o text/data/bss sizes are:

  testing: 496516 / 75790 /   976
  v6:      692799 / 87305 / 16288

Substantial DEBUG_FS=y build-size overhead remains: 196,283 bytes of
text, 11,515 bytes of data and 15,312 bytes of bss above this baseline.

Validation after rebase:

  - GCC and Clang builds of fs/ceph/ceph.o and net/ceph/libceph.o.
  - GCC builds of both objects with DEBUG_FS=n and with DYNAMIC_DEBUG=n.
  - GCC/Clang host tests using actual serializer/request helper code
    with kernel primitives stubbed: arities 0..32, argument order and
    single evaluation, multi-argument macro expansion, bounded strings,
    and nested/cross-mount request tracking with BLOG disabled/enabled.
  - Host fault injection for each global BLOG allocation failure,
    enable failure and ordinary CephFS initialization cleanup.
  - All 14 formatted patches apply to the stated base and reproduce
    the branch tree. Range-diff shows all 14 unchanged by this rebase.
  - The 31 argument-fill checkpatch errors are gone. Full-series strict
    checkpatch still reports 73 warnings and 45 checks, with no errors.

These are composite-object builds and host tests, not full module links
or booted-kernel/Ceph-cluster tests. No lockdep, KASAN or KCSAN run was
performed for this revision.

Known follow-up: existing %ptSp call sites still decode as pointer values
on the binary path. Timestamp-by-value serialization and its format tests
are deferred; text logging is unaffected.

AI assistance was used for the v6 wrapper/macro changes, lazy logging
helpers, optional-init failure handling, test harnesses and this cover
letter. The substantive changes carry Assisted-by attribution.

Alex Markuze (14):
  ceph: add BLOG private headers
  ceph: add BLOG deserialization support
  ceph: add BLOG page-fragment allocator
  ceph: add BLOG magazine batch allocator
  ceph: add BLOG logger core
  ceph: add BLOG per-module context management
  ceph: add Ceph BLOG scaffolding
  ceph: add boutc wrappers for BLOG
  ceph: switch MDS request plumbing to struct ceph_journal_info
  ceph: add BLOG debugfs interface
  ceph: convert VFS inode and directory paths to BLOG logging
  ceph: convert VFS data I/O paths to BLOG logging
  ceph: convert capability and snapshot paths to BLOG logging
  ceph: convert remaining helper paths to BLOG logging

 fs/ceph/Makefile                |   3 +
 fs/ceph/addr.c                  | 202 ++++---
 fs/ceph/blog.h                  | 216 +++++++
 fs/ceph/blog_batch.c            | 259 +++++++++
 fs/ceph/blog_batch.h            |  44 ++
 fs/ceph/blog_client.c           | 643 +++++++++++++++++++++
 fs/ceph/blog_core.c             | 297 ++++++++++
 fs/ceph/blog_debugfs.c          | 688 ++++++++++++++++++++++
 fs/ceph/blog_des.c              | 335 +++++++++++
 fs/ceph/blog_des.h              |  16 +
 fs/ceph/blog_module.c           | 995 ++++++++++++++++++++++++++++++++
 fs/ceph/blog_module.h           |  42 ++
 fs/ceph/blog_pagefrag.c         |  62 ++
 fs/ceph/blog_pagefrag.h         |  27 +
 fs/ceph/blog_ser.h              | 404 +++++++++++++
 fs/ceph/caps.c                  | 116 ++--
 fs/ceph/crypto.c                |  18 +-
 fs/ceph/debugfs.c               |  11 +-
 fs/ceph/dir.c                   | 329 ++++++++---
 fs/ceph/export.c                |  83 ++-
 fs/ceph/file.c                  | 287 ++++++---
 fs/ceph/inode.c                 | 256 ++++----
 fs/ceph/locks.c                 |  66 ++-
 fs/ceph/mds_client.c            | 369 +++++++-----
 fs/ceph/snap.c                  |  17 +-
 fs/ceph/super.c                 |  61 +-
 fs/ceph/super.h                 |   7 +
 fs/ceph/xattr.c                 | 104 ++--
 include/linux/ceph/ceph_blog.h  | 292 ++++++++++
 include/linux/ceph/ceph_debug.h |  81 ++-
 include/linux/ceph/libceph.h    |   2 +
 31 files changed, 5676 insertions(+), 656 deletions(-)
 create mode 100644 fs/ceph/blog.h
 create mode 100644 fs/ceph/blog_batch.c
 create mode 100644 fs/ceph/blog_batch.h
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 fs/ceph/blog_core.c
 create mode 100644 fs/ceph/blog_debugfs.c
 create mode 100644 fs/ceph/blog_des.c
 create mode 100644 fs/ceph/blog_des.h
 create mode 100644 fs/ceph/blog_module.c
 create mode 100644 fs/ceph/blog_module.h
 create mode 100644 fs/ceph/blog_pagefrag.c
 create mode 100644 fs/ceph/blog_pagefrag.h
 create mode 100644 fs/ceph/blog_ser.h
 create mode 100644 include/linux/ceph/ceph_blog.h


base-commit: 9015db49ecbfdc2a96129342c5bc1a471e04882a
-- 
2.34.1

