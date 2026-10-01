Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E748423A
	for <ceph-devel@vger.kernel.org>; Thu,  1 Oct 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861161; cv=pass; b=NK9wyd/O7z00NnaTETgc2P2YQBjQAR17GasgcoYT2UJOZwDZloyd5/alzdZ2GHmjgXmHTQzk7Y2EYE7k48MUgJH24UXk2A7B+/4PP277sVP6at+KDCyOaZhichsrok5tsvm3cDEJyMJVfZbmIWbiHJoIsl11bdtZYzM1yQrsjj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861161; c=relaxed/simple;
	bh=565PGayVXQj5jtKv9MFCBcWuJpqzzUICJfanKKuB8vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dthF8sNSfDYhQ5yOKtJx00HrtccWNgShOy39XOTXs+O+CyGzWmdxyT9Sjl9UUQbG/CkXlHDsJdxzF7GPzPoaWm6gZj28LYAGaqVbz4sgAxHgNZDpKquNA56Wzot9bZuEAhzvy8CYgKP4IoFOVl5Uip32P0G8BwN64H6/M4jOgfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=ZGAfnY6s; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="ZGAfnY6s"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e32f913c3so166604266b.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Oct 2026 06:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790861155; cv=none;
        d=google.com; s=arc-20260327;
        b=WjTxo3VgkbjywHXYrjoXrct8/dZR3YLYIzBCuoe32bHHGhwNzWjlyET7J/cQRyI1wJ
         djYcSKO5iOAQwOqXB1lrJOrFvXWHH7n0b+lNICcOJhysbj2v22w1ASM2WZ/BIX6FXQZ+
         ZrYqLW/dcGyWPxFJ4AGIZAFD8EKN+JioPIL2j0sOP7WWwrkj+hxg68S4R7B3TTv5LW8M
         45VYAwyuewKS27dFcBC29e6wfqeixLTALJxpSxb1AaBJZK0igVmMeu2MCMROqbrfm5I9
         Xgr8J54pTU7wOQHbH9o+T1rgrVmX2S50XFDjhGdDROp40yKMeFmhPpJ+t7f3gr+7XqoH
         zwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=505r/y+jettzqMN0YyNqCg9Xz2MRb+eIJD2yXjRpv0Y=;
        fh=h48fRnveUl1vdmzVuhvVnq39GQgA69ReJE4iqTKnnHY=;
        b=g81m96R1tty9TnHZSczNCnORn5HzoAippZduIpYI+3af5SYg2AkQH928ZUoFZyUb5A
         FxXPLg8AXzZQ+UOVW0iBcdStM9IabAB/c26hXGo617nk5Mnu+j7yA7dFlt/vKTdKPlio
         j6+0xkqmVABZzuvNWWnBiCnvw1Mf9K1RTPKfbDlDHi4YSo+PLBz61tBtV4LYX+e84CyF
         M9phM5APmqttqUTVXmk8OuGfZL4OhDfrnnYvJLsZ5FeBFZcdT8FfyRPrcL7PCjJ3C51s
         HqVBz3Lj3kpvj8322Cv8FRVQ7J+QYEaWQcvS8UnkAWXmQJ1rcGROj+3H0qLWLjFjtETk
         cwhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1790861155; x=1791465955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=505r/y+jettzqMN0YyNqCg9Xz2MRb+eIJD2yXjRpv0Y=;
        b=ZGAfnY6sPUcKs73wnCD8dvcrgJREefqhb4eLQc/WCuoE0WV9zixiZD0F3WKOM8m3Zc
         32mIO73SpbN3k+GSFqedpmMEyNFJrP4KG2WgbAsReqaNfUjQU0V5BUmredCdfvqLG1Qt
         tNCUUTjYXPar67kEo1pMQsZEKq0PvZ5OyGY1f7OvUWlDx74lUROer58WPu1I5gY2MffU
         igXDVglr0eIqKj9bT9U5pxjRg0QhNoQ72FNrsw8vURNblqKbjoUgizXOhblnuSh3SnCS
         P9ZWnfhi582a2W5mEQHKViyB0ana2AmaVi9LFQBnp9540nDHg2qyK0kJs4NBKWlYmCl4
         nbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790861155; x=1791465955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=505r/y+jettzqMN0YyNqCg9Xz2MRb+eIJD2yXjRpv0Y=;
        b=1+U5ol6IAUQ56TK3epKw9Bnz+BkFavW5CTO6/0h1fON6a8wlOe5T0WFp0Ml/SBsmxg
         Txo6ryGyqQlh/+Qs1f7yMAn+W1ciwD4Uc5SRGEy/FWscoUfSHahxPfxB9dWpXshHRArQ
         /tfkZujnve+BYDV8GwmbRTU2SH89XqZG32aAc8CPnHt1yt0c0bDcyT4LhsFuLi1hGv0O
         zykvU1EVmxZvmQ4TwNMhpORk36gbLAZpS+OpJkHXhQAuyBOQ1biV3wgy16VYwACIm0fS
         DgBttXxVbFAkZml2fs3lK2YETS2TqGoVKS5fm5Ulhn6e0rQaRqe6q9EI+Rk+5TADFUmR
         XN9w==
X-Gm-Message-State: AFuF++lmFL/RgOlUVybTDW18sPoaBAeArkvMuL66rX7TSeEhLYABk+TV
	9on5VwQKCK0Zb5g6mYMZ3JlR+7+Sm9cBjrGvs43DEeSFm/afikQe8s6cmIsh5POght2Ibu8E4m4
	7YZWJbaxdJz6hgPwh6Z1hLUPHPOateF1enB4CoDtL8D0ad2eCC9mXj9ZdcA==
X-Gm-Gg: AYBFou0J9w8xQutnUh4ewsf/Hu49RkCRf02CpiALBRkiLFwvlgllSq4xOkaHpTMquSO
	qcsOTrlH/FkpXPxntq220LYlhHvlzwepw4jSkHiqLejdbVohyLmA2o63G0wEZawfvEaBpmU6Ay2
	geTkWpfk7sBbPn2p7tyBjLSpmwhxREFpRwgRbczOdAM4kyc5ZMRaJU7cRzo/SXxMRSPKCML6e4x
	I1xLWiiu00znI2nR5B/KHKrzhT2mnieN+blPYtbV91aFEs9C2H+lI7ZoDE6sHXLiXD/+sC+ZwN+
	zYt/c6ICQniZCxklWCXVWrgn4LdA+ivfXXu5Q5ox75qLrtYBiJ3QiR4EpQ==
X-Received: by 2002:a17:906:c155:b0:c2d:d1d8:b220 with SMTP id
 a640c23a62f3a-c2e23e0edf8mr410937466b.42.1790861154842; Thu, 01 Oct 2026
 06:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924153045.994784-1-amarkuze@redhat.com>
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 1 Oct 2026 15:25:42 +0200
X-Gm-Features: AclHuK9lDP_qj1VMdPgVj1JhNws2hiEsLPRZOF7IakDufK3_sJsAR_-3aHEcpg0
Message-ID: <CAOJNxR+rerahdi4cwUpMgDthLCNXuTZRQ1i0_2g-O93E4keytw@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] ceph: add binary logging (BLOG) for CephFS
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks Alex.

This whole series LGTM and tested it. Just feel free to add:

Tested-by: Xiubo Li <xiubo.li@clyso.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Thu, 24 Sept 2026 at 17:30, Alex Markuze <amarkuze@redhat.com> wrote:
>
> This series adds a per-mount binary flight recorder for CephFS debug
> messages. It stores typed arguments in per-task page-fragment buffers
> and reconstructs text through debugfs. Runtime enablement is per mount
> and defaults to off; CONFIG_DEBUG_FS remains the build gate.
>
> Thanks to Xiubo for the detailed v6 testing and reproducer. This revision
> addresses the two xattr logging hazards and the empty-magazine growth
> reported in that review. Further code reviews and a 32-bit build also
> found issues in cache lookup, counted-name logging, debugfs controls,
> dump completion, record timestamps and stack usage, fixed here. The
> complete 14-patch series is based on testing tip 6a8449a3f814.
>
> Changes since v6:
>
>   - In __ceph_destroy_xattrs(), log the node pointers without reading
>     xattr->name. Snapshot encoding can free the blob backing the old
>     index before its destruction; a bounded string read is still unsafe.
>   - In __copy_xattr_names(), log the NUL-terminated destination and xattr
>     pointer. The borrowed source name is length-delimited and cannot be
>     passed to an unbounded %s.
>   - Return exhausted allocation magazines directly to log_batch's empty
>     list, where blog_batch_put() can refill them. Do this for both task
>     context allocation and atomic buffer rotation. Detach the per-CPU
>     magazine before publishing it under the destination empty-list lock.
>     Both batches use the same magazine slab cache.
>   - Load the per-CPU cached context once and check that same pointer.
>     A remote migration or retirement can clear the slot between the old
>     check and reload, causing a NULL dereference despite local preemption
>     being disabled.
>   - On a long encrypted snapshot-name lookup failure, log the existing
>     terminated copy, restoring the leading underscore in the format.
>     The original input is length-delimited.
>   - Bound binary capture of the base64-encoded ciphertext name with
>     BLOG_STR(p, elen). base64_encode() does not append a terminator;
>     %.*s alone only bounds the text path.
>   - Make the BLOG read files root-readable (0400), matching the other
>     Ceph debugfs data files. Recorded names and xattr values must not be
>     exposed when the debugfs root is traversable by other users.
>   - Check the mount's enabled flag during context lookup. Disabling one
>     mount must stop subsequent capture even if another enabled mount
>     keeps the global static key active.
>   - Bound an entries dump by a maximum context ID, preserving that bound
>     across seq_file overflow retries. Stop formatting on overflow so
>     sustained rotation cannot keep a reader chasing new contexts.
>   - Store record base times as u64 from get_jiffies_64(), including the
>     delta calculation. Protect published base updates with the pagefrag
>     lock used by readers. This preserves the epoch on 32-bit kernels,
>     whose low jiffies word first wraps about five minutes after boot.
>     Use one clock sample for the overflow check and stored delta, so a
>     tick between them cannot wrap an exactly U32_MAX delta to zero.
>   - Prepare each argument directly in its existing TLS scratch slot.
>     Returning a temporary struct for every argument pushed the GCC i386
>     __ceph_setattr() frame over its 1280-byte build limit. Direct filling
>     brings reported stack usage to 300 bytes without changing evaluation
>     order, string bounds or the recursive arity macros.
>   - Rebase onto testing with the subsequent CephFS fixes already applied.
>     Fold the fixes into patches 01, 04, 06, 07, 10 and 14; retain 14 patches.
>
> Local validation:
>
>   - GCC 11.4 and Clang 18.1 builds of fs/ceph/ceph.o and
>     net/ceph/libceph.o with DEBUG_FS=y and DYNAMIC_DEBUG=y; GCC also
>     builds both objects with DEBUG_FS=n. A GCC i386 build of both objects
>     also passes with the default 1280-byte frame limit.
>   - ASan/UBSan host tests using the actual xattr functions, BLOG argument
>     serializer and kernel string-reading loop reproduce the v6 UAF and
>     over-read. The v7 cases pass with BLOG and dynamic debug off/on.
>   - Host tests using the actual magazine get/put/cleanup and rebalance
>     code check both allocation call sites, sustained churn, reuse with
>     new magazine allocations disabled, and 64,000 cycles on eight
>     pthread workers. v6 exposes the growth; v7 reuses the magazines and
>     releases all remaining objects at cleanup.
>   - Additional ASan/UBSan host checks inject a remote cache clear and use
>     exact-sized, unterminated encrypted names. They reproduce all three
>     additional faults in the earlier v7 draft and pass with these fixes.
>     The decoder passes 200,000 randomized malformed-payload cases with
>     exact-sized input and output allocations under ASan/UBSan.
>   - Before/after reader tests cover continuous context-ID churn and a
>     stable bound across overflow retries. A cache test covers disabling
>     a mount with an active context. Native freestanding i386 checks of
>     the actual timestamp expressions cover crossing the first wrap,
>     creating a context after it, detecting an expired u32 delta, and a
>     clock tick at the exact U32_MAX boundary.
>   - GCC/Clang serializer, request-context and initialization-failure
>     host tests pass. The review-fix diff has no strict checkpatch errors,
>     warnings or checks.
>
> These are composite-object builds and host regression checks. Kernel
> primitives are substituted in the host harnesses; they do not establish
> kernel scheduling, interrupt, KASAN or lockdep behavior. A v7 booted
> kernel and Ceph-cluster rerun remains for Xiubo; KASAN is not available
> in the local setup. Xiubo's reported cluster results were against v6
> with the destructor logging fix.
>
> Known follow-up: existing %ptSp arguments still decode as pointer values
> on the binary path. Timestamp-by-value serialization and further style
> cleanup remain deferred as in v6.
>
> AI assistance was used for the v7 fixes, code review, regression harnesses
> and this cover letter. The changed implementation commits carry
> Assisted-by attribution.
>
> Alex Markuze (14):
>   ceph: add BLOG private headers
>   ceph: add BLOG deserialization support
>   ceph: add BLOG page-fragment allocator
>   ceph: add BLOG magazine batch allocator
>   ceph: add BLOG logger core
>   ceph: add BLOG per-module context management
>   ceph: add Ceph BLOG scaffolding
>   ceph: add boutc wrappers for BLOG
>   ceph: switch MDS request plumbing to struct ceph_journal_info
>   ceph: add BLOG debugfs interface
>   ceph: convert VFS inode and directory paths to BLOG logging
>   ceph: convert VFS data I/O paths to BLOG logging
>   ceph: convert capability and snapshot paths to BLOG logging
>   ceph: convert remaining helper paths to BLOG logging
>
>  fs/ceph/Makefile                |    3 +
>  fs/ceph/addr.c                  |  202 ++++---
>  fs/ceph/blog.h                  |  216 +++++++
>  fs/ceph/blog_batch.c            |  267 ++++++++
>  fs/ceph/blog_batch.h            |   44 ++
>  fs/ceph/blog_client.c           |  644 ++++++++++++++++++++
>  fs/ceph/blog_core.c             |  297 +++++++++
>  fs/ceph/blog_debugfs.c          |  702 +++++++++++++++++++++
>  fs/ceph/blog_des.c              |  335 +++++++++++
>  fs/ceph/blog_des.h              |   16 +
>  fs/ceph/blog_module.c           | 1003 +++++++++++++++++++++++++++++++
>  fs/ceph/blog_module.h           |   42 ++
>  fs/ceph/blog_pagefrag.c         |   62 ++
>  fs/ceph/blog_pagefrag.h         |   27 +
>  fs/ceph/blog_ser.h              |  404 +++++++++++++
>  fs/ceph/caps.c                  |  116 ++--
>  fs/ceph/crypto.c                |   19 +-
>  fs/ceph/debugfs.c               |   11 +-
>  fs/ceph/dir.c                   |  329 +++++++---
>  fs/ceph/export.c                |   83 ++-
>  fs/ceph/file.c                  |  287 ++++++---
>  fs/ceph/inode.c                 |  256 ++++----
>  fs/ceph/locks.c                 |   66 +-
>  fs/ceph/mds_client.c            |  369 +++++++-----
>  fs/ceph/snap.c                  |   17 +-
>  fs/ceph/super.c                 |   61 +-
>  fs/ceph/super.h                 |    7 +
>  fs/ceph/xattr.c                 |  101 ++--
>  include/linux/ceph/ceph_blog.h  |  292 +++++++++
>  include/linux/ceph/ceph_debug.h |   81 ++-
>  include/linux/ceph/libceph.h    |    2 +
>  31 files changed, 5705 insertions(+), 656 deletions(-)
>  create mode 100644 fs/ceph/blog.h
>  create mode 100644 fs/ceph/blog_batch.c
>  create mode 100644 fs/ceph/blog_batch.h
>  create mode 100644 fs/ceph/blog_client.c
>  create mode 100644 fs/ceph/blog_core.c
>  create mode 100644 fs/ceph/blog_debugfs.c
>  create mode 100644 fs/ceph/blog_des.c
>  create mode 100644 fs/ceph/blog_des.h
>  create mode 100644 fs/ceph/blog_module.c
>  create mode 100644 fs/ceph/blog_module.h
>  create mode 100644 fs/ceph/blog_pagefrag.c
>  create mode 100644 fs/ceph/blog_pagefrag.h
>  create mode 100644 fs/ceph/blog_ser.h
>  create mode 100644 include/linux/ceph/ceph_blog.h
>
>
> base-commit: 6a8449a3f81444b6a25adc41cfd2c0ac33f8f96a
> --
> 2.34.1
>
