Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4930E82D
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160939; cv=pass; b=ZZOabL18lNSl9FO6icJ2xa9eCy4uDBJRqZStho1wGs9I6BVlSJEei6x7+2IUoPfNDbJxdT44dYkL4BT7jzT4h3E7sw/KyFqYfIA/cc8keH0N1mYxsdPCc28UFQpARg4tCdSNLRlDJWKujnj/Owmz6SAXOz3KVjkgm6P9et9UJy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160939; c=relaxed/simple;
	bh=yK9iwFmZQ9c212Cy65Xp3ryUktREFY61FxLH61jOBfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQQWRkcRWS7hiUBWUwIORrxIGXwgmrYXBUejPSSM5cRwzOOmy1SyyTMO1UsvPmY6dN3VZ+epKSTFq+d7KtSg1E2F7Lb8/DmNLU8Qq0Wwi2MjzrrmnbVAv6jaYYCw+D86RrvfOZYP6URfDrRm3umxWZBxvrmaMVQdFz0ckARxoWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=nWyz1rYm; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="nWyz1rYm"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so54184266b.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 03:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790160929; cv=none;
        d=google.com; s=arc-20260327;
        b=D1GcbZz1YBnSMEuZxDOIKsBYo/2G8VMXYGNPAFjTM+gFAj9shz0c7zkqJCzaXDxH0N
         xk/gvTp4uicAuKXfJwcVyVxrgzcBdoFI1zGmpkYPfwPXOAIB+MMIF0Tqvof6diwi+Dtz
         L+/jGVcMmT9qVhjjFOLqHtQsbodL41yuWH03An3lkgHlMfuH4z32elqog4RNpwd3ykZd
         J88nUyJIHO+Qvrs0W9qqpnfECNY1eVPpFsEimU92RJPieOruPjJjjCZWCeJxzrJFiM+N
         k62RDgjyXDh+8pX4uo2O5ichD6h3KBnjskrMWl0K4XOU3xZ2Fh7gRH2itXKjRhgGnJcf
         sg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5V+DQLQHaFEVoroOWDbf0mG5q3zv6h9DZ6FGtxrQ/GI=;
        fh=fC59a5iCD/exGE8xC8ycBBm3A4XEz99srqGSt3uqUJw=;
        b=IdeJr/WgJSmzs0mN1lDILFDkXZy6XmSpMV6qit1fiNgJ9suhK+MfecU2+Ryc+mTAF+
         3DpihXj9hCXpHq+occnDPkxDGK3kuR/MY3q2+PG7gUyhxeGXgnLF5buWWYyVYTC114Bw
         ow6Kvy5Gp+MazlqDqHvw87Mjwofvmw20oK07G38mljpxMrP2Ib63+WjGJjM/p3y28QYq
         KH+kt2pShlQb4VZ7PEsZGzINKj6NBgF25Pmt6PhMIAXuLM+ERfpRiWSLtsaGFK01v7VU
         SL3xN5DCZQafgJ8Q3vg4xeIXVgkOK6xMNeoRcVTaxSAYPdHfpBxjqDJWsdyKPeewHSXC
         mT2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1790160929; x=1790765729; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5V+DQLQHaFEVoroOWDbf0mG5q3zv6h9DZ6FGtxrQ/GI=;
        b=nWyz1rYmr9R2vtsFEQcicM9dloHGhNECaw5blN1cAcjCL7mMgrkpGQaiZ105JkxyCt
         7UtC2ih52/sN6HMQTaJT8ORqfvF2Mr7Olgb5/zVo7xuXdajXkhX9A7DwGgcxG7iSRtpK
         19XpHmSERRJeZ4xm9UANs8Aii8VOy+G3S3/moGyIa5xD8qm2hXnS1ndS+KhEbKaC+04P
         oERiAEJCxiJ8l8wwA8DHhE5z3KfCWs7V5Fc8jdBEdBH4R4JdDJKn5qI9MAQ7jNFyNo9y
         h96RtXRTxtQ44djKjAOVsEg1wKTWPVI/YVh2ygulwwSgA9X8XJWh/pBSW25NQAVBv9tV
         Ne9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160929; x=1790765729;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5V+DQLQHaFEVoroOWDbf0mG5q3zv6h9DZ6FGtxrQ/GI=;
        b=T9L+f9l0HyCO7rE0XxxNjOqwaEwAFQRLdywsxaOjbrWNHkdBJ6ZLGipxJUGuOrJlEO
         kp+eePMPRnSnt7tz5jjLAB8tQIaPe4ENbWeOaJQ/OsaOx4netg6lABNujSSV63KPdCm1
         m93xeMgl669KrXQOyklMMzBCXTEm24mcgLuWuv41QTPRI0qVbwfpjbhdHECa+xKk9wMR
         JARfHHxvKkopsr5NTTKBnKS8rugJzTlPHBR2HQQzWFh32S7KycSNMMD6Yu0r8CyL5rbi
         98fqlQ9jJpFjn3tI86cu/FTpJnqAZug3uGV2/d0wttfsD08100whpdUcrI92/y4f/AEY
         B6hA==
X-Gm-Message-State: AFuF++nJg2KTfhflS5J7AFkeEAQ91rXSt7UvaUUAKFcoeLC2xUjMIy6I
	dddfSGMcemjy4HYgvOKayNiFv+JQN3hFTAAgqdKJkBnbHGA+FaUKf/iE2eXx10uuQU2zyjSU2t0
	shsojUtEqXtcgdgGGRSZJoTqyNbv6VvMf3WCaDQPHKPWd7MvKOC7hG4lhA1Pf
X-Gm-Gg: AYBFou09f+NT1B6IRDwkbLF8uSTANc0izfm24su1t3XjH2oJrXk3jXNjVTeWAf1GA67
	1gBgMJeHbhyXi04ks10H6hjWMljIGsY3eDqV7E08yDrLbSNpi15LKQK+mIVFKwYdq/D+mobITVq
	IMhz7CQVDJVCXeHV+3zuNCHayWGAoctet+VWSPfgy3kQFzfK06FSaoSzhp/Rkx2E+WAP8oORofx
	vSca6Mh2hHpq3k7NWRUcLUSrAbz5fGVC3iVA6iJ5Ih5Fh0l3fzKqn+jVG1HxitGcCO1ZZttoc7b
	mbVbUxT0+dAkyY1H29nRRPqzfge6vbJmwMuCCjrMbdGjmiM8hU+o+6uDgUgcPn0t91dT
X-Received: by 2002:a17:907:9729:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c2aacdf9419mr211259366b.6.1790160928726; Wed, 23 Sep 2026
 03:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922140047.794405-1-amarkuze@redhat.com>
In-Reply-To: <20260922140047.794405-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 23 Sep 2026 12:55:17 +0200
X-Gm-Features: AclHuK-xupjAI-hI_5RwyJ-HANvwi3Oyi-16L_fqfdoICMtnVVbcvqWzJi8b0gA
Message-ID: <CAOJNxRJTiUkSAW6diKfZA51mGMCeGdKsbcb5mdkYxqf+-+e8fQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] ceph: add binary logging (BLOG) for CephFS
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

I ran a thorough tests against V6 with a vstart cluster for 4 hours.

Summary: one real use-after-free when BLOG is enabled, and one unbounded
growth of empty magazines. Details below.

Setup
=====

- x86_64 VM, GCC 16.1.1, CEPH_FS=m, DEBUG_FS=y, DYNAMIC_DEBUG=y,
  KASAN=y (generic, inline), PROVE_LOCKING=y, DEBUG_ATOMIC_SLEEP=y,
  booted with kasan_multi_shot.
- vstart cluster: 1 MON, 3 OSD, 2 MDS (max_mds=1), msgr2 prefer-crc.

1) KASAN slab-use-after-free in __ceph_destroy_xattrs() [patch 14/14]
======================================================================

With BLOG enabled, a listxattr after a snapshot triggers:

  BUG: KASAN: slab-use-after-free in __ceph_destroy_xattrs+0x7ad/0xa50 [ceph]
  Read of size 1 at addr ffff888112eb9f88 by task ls/11093
  Call Trace:
   __ceph_destroy_xattrs+0x7ad/0xa50 [ceph]
   __build_xattrs+0x247/0xc80 [ceph]
   ceph_listxattr+0x3c5/0xf20 [ceph]
   vfs_listxattr+0xfb/0x190
   ...
  Allocated by task 5111:
   __kvmalloc_node_noprof+0x31e/0xa30
   ceph_buffer_new+0xd6/0x260 [libceph]
   ceph_fill_inode+0x20e6/0x5590 [ceph]
   ceph_fill_trace+0xbaf/0x67d0 [ceph]
   handle_reply+0xe4a/0x2ba0 [ceph]
  Freed by task 8150:
   kfree+0x272/0x6e0
   ceph_buffer_release+0x33/0x70 [libceph]
   ceph_queue_cap_snap+0xf94/0x1840 [ceph]
   queue_realm_cap_snaps.isra.0+0x251/0x640 [ceph]
   ceph_update_snap_trace+0x845/0x12a0 [ceph]
   ceph_handle_snap+0xcbe/0x2130 [ceph]

Root cause: __build_xattrs() creates the index with
__set_xattr(ci, name, ..., 0, 0, ...), so each xattr->name points into
ci->i_xattrs.blob and is not copied. When the xattrs are dirty,
ceph_queue_cap_snap() calls __ceph_build_xattrs_blob(), which swaps in
prealloc_blob and returns the old blob. ceph_queue_cap_snap() then
frees it with ceph_buffer_put(old_blob). The index nodes still point
into the freed blob. Only i_xattrs.version++ keeps them from being
used, because it forces the next __build_xattrs() to destroy the index
first.

__ceph_destroy_xattrs() is the one place that reads those stale names:

    boutc_bounded(cl, "next p=%p (%.*s)\n",
                  (p, xattr->name_len,
                   BLOG_STR(xattr->name, xattr->name_len)),
                  ...);

The stale pointer already exists upstream. There the name is only read
by doutc(), i.e. when dynamic debug is on for that site. With BLOG, the
string is copied eagerly whenever BLOG is enabled, so the latent bug
becomes a real UAF.

Deterministic reproducer (20 iterations per case, original v6 ceph.ko):

    mkdir d; touch d/f
    setfattr -n user.aaaaaaaa -v 1 d/f
    getfattr -d d/f          # build index from blob
    setfattr -n user.bbbbbbbb -v 2 d/f   # xattrs dirty
    mkdir d/.snap/s          # cap snap frees the old blob
    getfattr -d d/f          # rebuild -> __ceph_destroy_xattrs()

  BLOG off, dyndbg off                   : 0 reports
  BLOG off, dyndbg on for that function  : 30 reports (in vsprintf string())
  BLOG on,  dyndbg off                   : 23 reports in __ceph_destroy_xattrs
                                           + 16 in blog_serialize_args

Suggested fix: do not dereference xattr->name in that message, for
example

    boutc(cl, "next p=%p xattr=%p\n", p, xattr);

With only that change I saw no further KASAN reports in the full run
below.

A related site in the same patch, in __copy_xattr_names():

    boutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name, ...);

This uses %s on xattr->name, which is not NUL-terminated when it points
into the blob. The doutc() had the same issue. On the binary path it
can over-read. Printing dest (which is terminated) or using
%.*s / BLOG_STR with name_len would avoid it.

2) Empty magazines in alloc_batch are never reclaimed [patches 04/06]
======================================================================

The "Allocation Batch: Empty magazines" count in blog/stats grows with
context churn and never goes down:

  after blog_test basic/rotate/parallel : 321
  after one 16-way fsstress run        : 6984  (first run: 318 -> 7439)

The flow is one-way:

- blog_module_rebalance_log_batch() moves whole full magazines from
  log_batch to alloc_batch.full_magazines.
- blog_batch_get() on alloc_batch drains them and parks the emptied
  magazine on alloc_batch.empty_magazines.
- Nothing returns those magazines to log_batch or frees them before
  blog_batch_cleanup().
- log_batch.empty_magazines therefore stays empty, and every
  blog_batch_put() that fills a magazine calls
  alloc_magazine(GFP_ATOMIC) for a new one.

At 256 bytes per magazine this is about 1.8 MB after one fsstress run,
and it keeps growing for the lifetime of the mount. The empties should
either go back to log_batch or be trimmed like the full list.

What passed (second run, with the one-line fix from (1), lockdep active)
=========================================================================

- blog/ debugfs layout, enabled defaults to 0, garbage writes to
  "clear" are rejected.
- fsstress 8 procs x 3000 ops with BLOG disabled.
- BLOG enabled: basic ops (xattrs up to 600 bytes, flock, buffered and
  O_DIRECT I/O, fsync, snapshots), readdir of 2000 entries forcing
  rotation, and 70 concurrent tasks with 10 killed mid-flight.
  entries decoded correctly (about 17k-22k records, 1000+ sources).
- fsstress 16 procs with BLOG enabled, racing a continuous entries
  reader, "clear" every 1s and enabled toggling every 3s. No splat and
  no hang. It did not complete 16x8000 ops within 25 minutes under
  lockdep+KASAN, so it was stopped by the timeout.
- Dynamic debug and BLOG enabled at the same time.
- Two mounts with noshare: separate blog/ directories and entries, and
  a cross-mount copy.
- umount + rmmod/modprobe ceph cycles with BLOG enabled.
- xfstests with BLOG enabled on all mounts and a background entries
  reader: generic/001 002 005 006 007 011 013 020 023 028 035 037 062
  070 074 080 084 087 088 091 098 112 117 124 184 221 236 245 257 294
  306 337 393 passed. 014, 024 and 258 were not run (ceph limitations).
- No lockdep reports during the whole run.

I did not include a performance comparison here.

All the others LGTM.

Thanks,
Xiubo Li

On Tue, 22 Sept 2026 at 16:00, Alex Markuze <amarkuze@redhat.com> wrote:
>
> This series adds a per-mount binary flight recorder for CephFS debug
> messages. It stores typed arguments in per-task page-fragment buffers
> and reconstructs text through debugfs. BLOG complements the existing
> tracepoints by covering the changing corpus of internal debug messages.
>
> CONFIG_DEBUG_FS remains the only build gate. No new Kconfig option is
> added. Runtime enablement is per mount and defaults to off. When no
> binary context is available, logging falls back to the existing text
> debug path. Normal CephFS operation does not depend on BLOG availability.
>
> The per-task buffers, snapshot_mutex versus atomic-rotation split,
> clear_seq handshake and reference-pinned teardown are unchanged from
> v5. This 14-patch revision is based on testing commit 9015db49ecbf.
>
> Changes since v5:
>
>   - Select the optional context first, then choose binary or text
>     logging. Each boutc wrapper expands its doutc fallback only once,
>     avoiding duplicate dynamic-debug sites. Keep the per-task argument
>     scratch and noinline record emitter.
>   - Move readdir and unlink-conflict name snapshots, and cross-cluster
>     UUID formatting, into binary-only noinline helpers. Retain lazy
>     %pd/%pU text formatting and hold name snapshots through serialization.
>   - Replace the unrolled argument-fill macros with recursive expansion.
>     Preserve argument order and single evaluation without stack arrays.
>     Remove the unused initializer macro family.
>   - Allow normal CephFS initialization to continue if BLOG's global
>     allocations fail. Enabling unavailable BLOG returns -ENODEV. MDS
>     request tracking and xattr recursion protection remain available.
>   - Correct commit subjects and stale references to bout().
>   - Rebase the complete series onto current local testing, retaining its
>     lazyio support and subsequent CephFS/libceph fixes.
>
> Measurements use x86_64 GCC 11.4 with identical configurations:
> CEPH_FS=m, PREEMPT=y, DEBUG_FS=y, DYNAMIC_DEBUG=y,
> CEPH_LIB_PRETTYDEBUG=n and FS_ENCRYPTION=y. The baseline is 9015db49ecbf.
> Individual frame estimates from objdump | checkstack.pl, in bytes:
>
>                               testing    v6
>   write_folio_nounlock            1128  1144
>   __ceph_setattr                   568   616
>   ceph_readdir                     544   616
>   ceph_read_iter                   280   392
>   ceph_splice_read                  80   328
>   ceph_write_iter                  344   440
>
> These are individual frames, not worst-case call-chain measurements.
> All six v6 frames are unchanged by the rebases. Before rebasing, the
> same-base v5-to-v6 comparison reduced write_folio_nounlock from 1336 to
> 1144 bytes and removed 43,303 bytes of text and 34,552 bytes of data.
>
> The current composite ceph.o text/data/bss sizes are:
>
>   testing: 496516 / 75790 /   976
>   v6:      692799 / 87305 / 16288
>
> Substantial DEBUG_FS=y build-size overhead remains: 196,283 bytes of
> text, 11,515 bytes of data and 15,312 bytes of bss above this baseline.
>
> Validation after rebase:
>
>   - GCC and Clang builds of fs/ceph/ceph.o and net/ceph/libceph.o.
>   - GCC builds of both objects with DEBUG_FS=n and with DYNAMIC_DEBUG=n.
>   - GCC/Clang host tests using actual serializer/request helper code
>     with kernel primitives stubbed: arities 0..32, argument order and
>     single evaluation, multi-argument macro expansion, bounded strings,
>     and nested/cross-mount request tracking with BLOG disabled/enabled.
>   - Host fault injection for each global BLOG allocation failure,
>     enable failure and ordinary CephFS initialization cleanup.
>   - All 14 formatted patches apply to the stated base and reproduce
>     the branch tree. Range-diff shows all 14 unchanged by this rebase.
>   - The 31 argument-fill checkpatch errors are gone. Full-series strict
>     checkpatch still reports 73 warnings and 45 checks, with no errors.
>
> These are composite-object builds and host tests, not full module links
> or booted-kernel/Ceph-cluster tests. No lockdep, KASAN or KCSAN run was
> performed for this revision.
>
> Known follow-up: existing %ptSp call sites still decode as pointer values
> on the binary path. Timestamp-by-value serialization and its format tests
> are deferred; text logging is unaffected.
>
> AI assistance was used for the v6 wrapper/macro changes, lazy logging
> helpers, optional-init failure handling, test harnesses and this cover
> letter. The substantive changes carry Assisted-by attribution.
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
>  fs/ceph/Makefile                |   3 +
>  fs/ceph/addr.c                  | 202 ++++---
>  fs/ceph/blog.h                  | 216 +++++++
>  fs/ceph/blog_batch.c            | 259 +++++++++
>  fs/ceph/blog_batch.h            |  44 ++
>  fs/ceph/blog_client.c           | 643 +++++++++++++++++++++
>  fs/ceph/blog_core.c             | 297 ++++++++++
>  fs/ceph/blog_debugfs.c          | 688 ++++++++++++++++++++++
>  fs/ceph/blog_des.c              | 335 +++++++++++
>  fs/ceph/blog_des.h              |  16 +
>  fs/ceph/blog_module.c           | 995 ++++++++++++++++++++++++++++++++
>  fs/ceph/blog_module.h           |  42 ++
>  fs/ceph/blog_pagefrag.c         |  62 ++
>  fs/ceph/blog_pagefrag.h         |  27 +
>  fs/ceph/blog_ser.h              | 404 +++++++++++++
>  fs/ceph/caps.c                  | 116 ++--
>  fs/ceph/crypto.c                |  18 +-
>  fs/ceph/debugfs.c               |  11 +-
>  fs/ceph/dir.c                   | 329 ++++++++---
>  fs/ceph/export.c                |  83 ++-
>  fs/ceph/file.c                  | 287 ++++++---
>  fs/ceph/inode.c                 | 256 ++++----
>  fs/ceph/locks.c                 |  66 ++-
>  fs/ceph/mds_client.c            | 369 +++++++-----
>  fs/ceph/snap.c                  |  17 +-
>  fs/ceph/super.c                 |  61 +-
>  fs/ceph/super.h                 |   7 +
>  fs/ceph/xattr.c                 | 104 ++--
>  include/linux/ceph/ceph_blog.h  | 292 ++++++++++
>  include/linux/ceph/ceph_debug.h |  81 ++-
>  include/linux/ceph/libceph.h    |   2 +
>  31 files changed, 5676 insertions(+), 656 deletions(-)
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
> base-commit: 9015db49ecbfdc2a96129342c5bc1a471e04882a
> --
> 2.34.1
>
