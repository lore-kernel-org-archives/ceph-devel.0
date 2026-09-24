Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA72489878
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263854; cv=none; b=uLmxAsYYeArr59K2acir8q93Njb15IkYh4QzbIhlY8lHeDo+07kONjleQJ9ZS/eH2KNwHdGzD3sSCM/3wirEPAKNed+XV0Gc77Ofx3uL2Tlg21Q56+IadqW/IaV+7PY5ua5dk1rgfUepIhzQDTFA44Z33gq/syUlpncPjL7WSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263854; c=relaxed/simple;
	bh=os7gL12OYCRlFf+1dnEuB6oeKtp5rnxtLI0o0whPrWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+cCUWNzDntiW82KMhdabO/olGkM624BMXCx20QtO9DIWKLG0WhKsiKXcJyE0ETkLJLWpJBsmonf+utoQNQEuXC41zjUI5hwdhASP/lnhQ8KewdQleY/B1XNMkvd2SizHAMR9qbc2TOTErPMzYN83e2NY306rvCJT2srArwR/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPyD1cRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gICIMP2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPyD1cRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gICIMP2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T5as6Y23J6pNzAvYdXmYzoFL0Gptjz7a2IsM9y8E6II=;
	b=GPyD1cRMKbGUcIOjQohwsrrhRfeJEhmZ6NpujtY9joK4g3M6vllWBGEWGtU/RYIT8dilDM
	S5IWok5B0erG2lLslhpxM21kB/VOYOCJucGiNlfdmZzcrXzLheStYX9Lyq/KN1Fd7/EFpn
	lepzwEgvGOcIZqc9Jb/ioio9fU8bYBQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-KQSmJ0xiNzGAaJ0SAJkqRQ-1; Thu, 24 Sep 2026 11:30:49 -0400
X-MC-Unique: KQSmJ0xiNzGAaJ0SAJkqRQ-1
X-Mimecast-MFC-AGG-ID: KQSmJ0xiNzGAaJ0SAJkqRQ_1790263848
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a9b7c7f405so2473076a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263848; x=1790868648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5as6Y23J6pNzAvYdXmYzoFL0Gptjz7a2IsM9y8E6II=;
        b=gICIMP2FE/Jc0qwRFaTXJjjflTJ6VNY2BRAvtEJnv5syln3zIUYOai85HTomjrOXxI
         bZaQtR+KltXyYKAEscuaudhH0gzRQYxczdVzhg7hgq0nLr3x4xLeUvDeO949sv5vkVMl
         VEIX09j/quWUA5ThyG5z0L+B8BAeys/n84/4H7HtPsFg376t7An2c6xVOTne9Uk+/RXi
         /J8Op57XLuQc+IXCWEK2FbEYSx1N4w5BAlo3M8WznWV1lm5Dyf6QsP9rOafKtyI3b/Kq
         oHdsMDg8HZgi5C2/njhE7Jl/nU5qZrv3Dg1DeZe4Ab5BMYZ6JdwFDznsiP9Uw7MXtwhe
         6+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263848; x=1790868648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5as6Y23J6pNzAvYdXmYzoFL0Gptjz7a2IsM9y8E6II=;
        b=gDJupwz5hWW8WjsynldtYdZ8zpnsVRhAIep4JApafh4oJgspHjKhu5fW8SQbHELjoX
         ru49ZFrKAVqMA3+BlpBja17MdBu65NS3ZI1LFNY7oKSsVH/NOB/yEIADByg2I53hV48f
         fTNSbUg2e4lralLqhHc1UG8CwFnW35iQHLjKoeF10ElY/BEzPUjy1DlxOaJHAIpqRfOf
         K3NL0p3Vymda+UEevYq48NhEYrFgO8BxeReSOGZLFRMO/7ZRIKlyKzrReguQ5/g7r4Zb
         Oec9UroO6p22NJjoe5LtqL0gZktybUR069hq1LsVZZGNcZjZfudmy4Kf2w8giJCKNyFs
         TzSA==
X-Gm-Message-State: AFuF++kTy8iNx24pgiM9cAQmP5dqOjXcgoDxBHRWBpz7qkeABGOsFV2G
	8rPV2SJtYTce4QPusAlRq+rSHP2XZuNDsp6GMhqq0HU+oemgPBQ2Z2NZf64D937TNb2NjKOc7jM
	Artx4RpGmf0jumieUGGyedQTcn0klhcjby/j8hyT53GAqBq6yL6PvQg+4kZ5T3QCbv4yHBozTQn
	VYUX44GxpFmgF0hCiWPBDus5ifMc00/Ytkko75DY+P8zoElzo=
X-Gm-Gg: AYBFou2SI62EonERYYXtOYMUlI/ejoTwjNfTfi79morjtQ7vEmOXFyxv1TQv2pN6q3f
	fCqlRHp+1VSPvVUUVNW6ZvKMhkmCqSWS61vk4CRXFMVIPGtMvDzljt/zRSutKPSdvs4AE+h7EXa
	9IB4GLJMlqD6oLvulkT7xV0kzUvjG2FpkDutJgohwgwewLPGqVmuzFrYOzMTXKGAfQJo/HF16jO
	uAw66IEnO55ixkfDS0aOTF84wopOs1vBdjo+baFIJvjV/p2KGaVyZJRQsJ7FECAERn4YOhGpCjh
	5Cf+2Y020EHRhBUjWvDxZCnqTGk02Sb4AcRXCKf2pFk588C2vmXBsJcp9zRZsqLbmtbTcLlnFkY
	C2zjUEo2r+xZ5OEhiI8kppSP2q19DT4Y8i3wkTk1VxWR+TX1j4hJUQlTv0PfeGp/lNzGzBy1a9z
	6jOv5ReB+hgogdLA==
X-Received: by 2002:a05:6402:4505:b0:6aa:96f:bb2f with SMTP id 4fb4d7f45d1cf-6aac8eed57dmr2587285a12.12.1790263848299;
        Thu, 24 Sep 2026 08:30:48 -0700 (PDT)
X-Received: by 2002:a05:6402:4505:b0:6aa:96f:bb2f with SMTP id 4fb4d7f45d1cf-6aac8eed57dmr2587242a12.12.1790263847748;
        Thu, 24 Sep 2026 08:30:47 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 00/14] ceph: add binary logging (BLOG) for CephFS
Date: Thu, 24 Sep 2026 15:30:30 +0000
Message-Id: <20260924153045.994784-1-amarkuze@redhat.com>
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
and reconstructs text through debugfs. Runtime enablement is per mount
and defaults to off; CONFIG_DEBUG_FS remains the build gate.

Thanks to Xiubo for the detailed v6 testing and reproducer. This revision
addresses the two xattr logging hazards and the empty-magazine growth
reported in that review. Further code reviews and a 32-bit build also
found issues in cache lookup, counted-name logging, debugfs controls,
dump completion, record timestamps and stack usage, fixed here. The
complete 14-patch series is based on testing tip 6a8449a3f814.

Changes since v6:

  - In __ceph_destroy_xattrs(), log the node pointers without reading
    xattr->name. Snapshot encoding can free the blob backing the old
    index before its destruction; a bounded string read is still unsafe.
  - In __copy_xattr_names(), log the NUL-terminated destination and xattr
    pointer. The borrowed source name is length-delimited and cannot be
    passed to an unbounded %s.
  - Return exhausted allocation magazines directly to log_batch's empty
    list, where blog_batch_put() can refill them. Do this for both task
    context allocation and atomic buffer rotation. Detach the per-CPU
    magazine before publishing it under the destination empty-list lock.
    Both batches use the same magazine slab cache.
  - Load the per-CPU cached context once and check that same pointer.
    A remote migration or retirement can clear the slot between the old
    check and reload, causing a NULL dereference despite local preemption
    being disabled.
  - On a long encrypted snapshot-name lookup failure, log the existing
    terminated copy, restoring the leading underscore in the format.
    The original input is length-delimited.
  - Bound binary capture of the base64-encoded ciphertext name with
    BLOG_STR(p, elen). base64_encode() does not append a terminator;
    %.*s alone only bounds the text path.
  - Make the BLOG read files root-readable (0400), matching the other
    Ceph debugfs data files. Recorded names and xattr values must not be
    exposed when the debugfs root is traversable by other users.
  - Check the mount's enabled flag during context lookup. Disabling one
    mount must stop subsequent capture even if another enabled mount
    keeps the global static key active.
  - Bound an entries dump by a maximum context ID, preserving that bound
    across seq_file overflow retries. Stop formatting on overflow so
    sustained rotation cannot keep a reader chasing new contexts.
  - Store record base times as u64 from get_jiffies_64(), including the
    delta calculation. Protect published base updates with the pagefrag
    lock used by readers. This preserves the epoch on 32-bit kernels,
    whose low jiffies word first wraps about five minutes after boot.
    Use one clock sample for the overflow check and stored delta, so a
    tick between them cannot wrap an exactly U32_MAX delta to zero.
  - Prepare each argument directly in its existing TLS scratch slot.
    Returning a temporary struct for every argument pushed the GCC i386
    __ceph_setattr() frame over its 1280-byte build limit. Direct filling
    brings reported stack usage to 300 bytes without changing evaluation
    order, string bounds or the recursive arity macros.
  - Rebase onto testing with the subsequent CephFS fixes already applied.
    Fold the fixes into patches 01, 04, 06, 07, 10 and 14; retain 14 patches.

Local validation:

  - GCC 11.4 and Clang 18.1 builds of fs/ceph/ceph.o and
    net/ceph/libceph.o with DEBUG_FS=y and DYNAMIC_DEBUG=y; GCC also
    builds both objects with DEBUG_FS=n. A GCC i386 build of both objects
    also passes with the default 1280-byte frame limit.
  - ASan/UBSan host tests using the actual xattr functions, BLOG argument
    serializer and kernel string-reading loop reproduce the v6 UAF and
    over-read. The v7 cases pass with BLOG and dynamic debug off/on.
  - Host tests using the actual magazine get/put/cleanup and rebalance
    code check both allocation call sites, sustained churn, reuse with
    new magazine allocations disabled, and 64,000 cycles on eight
    pthread workers. v6 exposes the growth; v7 reuses the magazines and
    releases all remaining objects at cleanup.
  - Additional ASan/UBSan host checks inject a remote cache clear and use
    exact-sized, unterminated encrypted names. They reproduce all three
    additional faults in the earlier v7 draft and pass with these fixes.
    The decoder passes 200,000 randomized malformed-payload cases with
    exact-sized input and output allocations under ASan/UBSan.
  - Before/after reader tests cover continuous context-ID churn and a
    stable bound across overflow retries. A cache test covers disabling
    a mount with an active context. Native freestanding i386 checks of
    the actual timestamp expressions cover crossing the first wrap,
    creating a context after it, detecting an expired u32 delta, and a
    clock tick at the exact U32_MAX boundary.
  - GCC/Clang serializer, request-context and initialization-failure
    host tests pass. The review-fix diff has no strict checkpatch errors,
    warnings or checks.

These are composite-object builds and host regression checks. Kernel
primitives are substituted in the host harnesses; they do not establish
kernel scheduling, interrupt, KASAN or lockdep behavior. A v7 booted
kernel and Ceph-cluster rerun remains for Xiubo; KASAN is not available
in the local setup. Xiubo's reported cluster results were against v6
with the destructor logging fix.

Known follow-up: existing %ptSp arguments still decode as pointer values
on the binary path. Timestamp-by-value serialization and further style
cleanup remain deferred as in v6.

AI assistance was used for the v7 fixes, code review, regression harnesses
and this cover letter. The changed implementation commits carry
Assisted-by attribution.

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

 fs/ceph/Makefile                |    3 +
 fs/ceph/addr.c                  |  202 ++++---
 fs/ceph/blog.h                  |  216 +++++++
 fs/ceph/blog_batch.c            |  267 ++++++++
 fs/ceph/blog_batch.h            |   44 ++
 fs/ceph/blog_client.c           |  644 ++++++++++++++++++++
 fs/ceph/blog_core.c             |  297 +++++++++
 fs/ceph/blog_debugfs.c          |  702 +++++++++++++++++++++
 fs/ceph/blog_des.c              |  335 +++++++++++
 fs/ceph/blog_des.h              |   16 +
 fs/ceph/blog_module.c           | 1003 +++++++++++++++++++++++++++++++
 fs/ceph/blog_module.h           |   42 ++
 fs/ceph/blog_pagefrag.c         |   62 ++
 fs/ceph/blog_pagefrag.h         |   27 +
 fs/ceph/blog_ser.h              |  404 +++++++++++++
 fs/ceph/caps.c                  |  116 ++--
 fs/ceph/crypto.c                |   19 +-
 fs/ceph/debugfs.c               |   11 +-
 fs/ceph/dir.c                   |  329 +++++++---
 fs/ceph/export.c                |   83 ++-
 fs/ceph/file.c                  |  287 ++++++---
 fs/ceph/inode.c                 |  256 ++++----
 fs/ceph/locks.c                 |   66 +-
 fs/ceph/mds_client.c            |  369 +++++++-----
 fs/ceph/snap.c                  |   17 +-
 fs/ceph/super.c                 |   61 +-
 fs/ceph/super.h                 |    7 +
 fs/ceph/xattr.c                 |  101 ++--
 include/linux/ceph/ceph_blog.h  |  292 +++++++++
 include/linux/ceph/ceph_debug.h |   81 ++-
 include/linux/ceph/libceph.h    |    2 +
 31 files changed, 5705 insertions(+), 656 deletions(-)
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


base-commit: 6a8449a3f81444b6a25adc41cfd2c0ac33f8f96a
-- 
2.34.1

