Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E73016FB
	for <ceph-devel@vger.kernel.org>; Thu,  3 Sep 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397999; cv=pass; b=TYSCLrnXaXL46TLzLxSVsUgj2SikX/TEaJeXiRJsz+S0wg/gs0VEX0u1fc7VjsJG0tjCdhu5phq5QgGGZq6uLEn4oPIXqX4ZaY09UWVJ0v4Pi+skuPjuI+aP8sMvn0u3OT10zUQHFIfq5FPkAYEGWbgJvdD07DXPTqNbZUAJUyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397999; c=relaxed/simple;
	bh=AWL//7gBMB967WTjCdq3hAD2WM0oaaejISR23zIz1kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpoTkf8jS1VGIKdGU6RKvaUf9iZXayjsXEf6pey41dUqMb5oA3Rk0k1HBBATXgAg9Lq2Ni8hKdMSTJfs7zzYNuMfbFS0AQg+Fniz592kIglo10/U5sL0s5QMNtW923DtDVbRDxFC/pFxRLcddjoaWQOZGeQJnxp9pl77GZ2dmTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=Lq+Bxceu; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="Lq+Bxceu"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so1785296a12.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 18:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788397991; cv=none;
        d=google.com; s=arc-20260327;
        b=nMftL8PqAnK6va46DevAyVfLbk4/2tWK91MM8TXEe6Q+kgtKqCWktX+Es+KpvSwjSP
         U+MCjA8EIg2CHjprmRlPfYjM50kWyluj6COuGR9jKL5CYWgk86ejUGIvUEKmfSz2hiqc
         0H4wCuKesEBmFpZ19biLTjL52qtMPTPL2iomFPjnXh6nQ3UNpVWTN9iuY0gUTnDc/X66
         3CqkH6SQrFtBzVoUhu7hHzDJoh9tJy6DwwUGfU15xHmd4p5iwT8k4GNgo0hefYi31aXg
         nCUGWsQ+hnLf0T0+APz8rOiGdfeZWEjyGONOaPVcnBH1gP4ZXmiyx94GVneTAGCogbSD
         NqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AfNBBcEEmjAQdyLP7yOI45hzXhfl6XsvylFOrDtikfg=;
        fh=fC59a5iCD/exGE8xC8ycBBm3A4XEz99srqGSt3uqUJw=;
        b=Fh1Fa07FUSV11l1219g/8PxFh9l/6d4E+ywx/hqtjn3McwJibbHuFUk+MVgF2zaa+5
         xDcQ5ML28ihxQNgdIttikXR9beoXukYV5V6iSZpFm6B8jRLT+FpuHypd7KqjOv/sQbrx
         2afOgt46Mc1xECXZM0DkBY0SDnRhJVhBWh7Ouev0zZ6clNii+w5yzi28TPXHe+XGT55Y
         WGPabrKFacXq3kfDa1ZF2AOmKpIHDYVZMg+c6YRkTkAACNOf/hw7XwCa+MC7IjcPLba2
         98bipwedB/k95eYdiPJbvP2+cKq1MEqN1KwHSrFn6snEIh8zsnp8whstELO+2cDMkl3o
         kYAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788397991; x=1789002791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AfNBBcEEmjAQdyLP7yOI45hzXhfl6XsvylFOrDtikfg=;
        b=Lq+BxceuuQ4fAwjFCq5Yo2nCNVKGFIH0TdtFhXB56SJpo5RWpGbEJCvHrUuY43Srda
         tFptTBIrdPw63VBs9kzAxBGXXteR9eDQrjh4q2BFJEeMoxACqBOi3IyWK/qPCMx0fD6U
         DJmoMm+JZK5nMHR61m4R5dZJoocZnYiRJCDJePy7tgIorNpqjiaUCWm37q8pmVk/sIip
         WgPNRQKJTZ3wx5/bYmGpfVOJD/Nxls/1ZeWQfGFffXMsyQkxEdE/I/f6FJVZHodc1Tnz
         FfzrafIbRCtgAufahLmQMJfJ6ZytQPrpwLhWRvPVlmieD+lcFzvx2CfwWIXi8BVQsaEb
         gbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788397991; x=1789002791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfNBBcEEmjAQdyLP7yOI45hzXhfl6XsvylFOrDtikfg=;
        b=f4C2x+fkD+l2pSNQF5KYVLbdZ15JANU/fkn6OJxz7aazNuEWIPHaxzUsiHuDD+e6X5
         4YCgM4bbq4vJsDC+L+J4xK/f5JchwBdtHLZu6pApJfh0Yx+tLj1XECW/Rcmcu5/GOQX/
         wD3VPhmnL6qd15YWOOfbxR2D8ir/sFSlvTbsrMdRfx1WtViLVLYdX8xwegnstnKovzJh
         FLVy97vrv43lwht3aJS4KMvq0xL86IxGsHGBEsb9uEi5ti194xVtnvyabx8WrgGvn1QS
         sWlesqBY7of4CMMVn3+LVjpSjXTRI8NdQVvXp/syE2vqCJuP7l1llmrr0udpSHAemKYh
         oVJw==
X-Gm-Message-State: AFuF++mERCUkpU+7G8Q/ku+BLNdgxhW0ZOh2lqLkqn3lzDtPaLtv+Ebd
	NtwdFBpd2IhkEpgDmG6ZQSIEHUWnCUM3fVrI8E7PawjYw5SJaWGkJOIsGSB4Dj5qErmoChSGtRR
	frbiR65BfTYKcyFNkUhwXknCjOwWqh40iVuzaeZ6U+Jtq6R1CVooFD5M=
X-Gm-Gg: AYBFou2fVPdAf0aNL5equK17yyKoAI2aEjX+5ep8mLO0tCUCH5fYcEvZx1ZheHkPupb
	TGnc/VODOX6qR0r725vwiS0AdKFe+pQbN0SCrbv3p91Eo8e6/3KKQ5ClA+rDxSpJ0ZMN1MZ8nQ5
	G1RL5W15at03F7NH8TZ5EAgEo/1oTB8qAp9SD+h8t9rUyJMdQK+kgvjOh7GKed6niDcN3l3GWhG
	+VE+AgKWnu7qy5mPP1Qr6Iat7yjVUPLJxiHxyON0YvhlCodGfySLIBJ4gWQrhEMN4lhKRofzNN1
	YHNEbLRU4vanW94MQSmIgBxqsvkMTBug5IbUh9Kqigu3Bw==
X-Received: by 2002:a05:6402:440b:b0:6a5:f9ab:bdfd with SMTP id
 4fb4d7f45d1cf-6a6817d4555mr6875430a12.0.1788397990374; Wed, 02 Sep 2026
 18:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787229471.git.amarkuze@redhat.com> <20260902160407.3196013-1-amarkuze@redhat.com>
In-Reply-To: <20260902160407.3196013-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 2 Sep 2026 18:12:57 -0700
X-Gm-Features: AcwNN1U2-gKTBd1CMwgTlayyQoVa3y8aA0uF18EzG8j6dYrxINu_5-JksJjhJm4
Message-ID: <CAOJNxRKm=TrPojeVT=-9t3YtNW6FS76ivEUgnbK3Z8fuFxU1dw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] ceph: add binary logging (BLOG) for CephFS
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

For this whole series feel free to add:

Tested-by: Xiubo Li <xiubo.li@clyso.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Wed, 2 Sept 2026 at 09:04, Alex Markuze <amarkuze@redhat.com> wrote:
>
> This series adds a binary logging subsystem for the CephFS kernel
> client.  On hot I/O paths every dout() call formats a printk-style
> string even when nobody is reading the log.  After a client hang or
> crash, operators often want the last slice of those messages without
> having attached ftrace in advance.  BLOG is an opt-in flight recorder
> for that corpus: it stores compact binary records keyed by a source-ID
> and decodes them through debugfs.
>
> It is not a replacement for Ceph tracepoints.  Tracepoints remain the
> right interface for stable, structured events consumed by ftrace, perf,
> and BPF.  Putting the dout corpus on tracepoints would mean a maintained
> event schema for every internal debug line, mount identity in every
> event, and a collector running before the failure.  BLOG keeps the
> printf-style call sites, is enabled per mount, and retains recent
> records for collection after the fact.
>
> All new code lives under fs/ceph/ and include/linux/ceph/.  There are
> no changes outside the Ceph subsystem.  BLOG objects are linked only
> when CONFIG_DEBUG_FS=3Dy (the only UI).  There is no CONFIG_CEPH_BLOG.
> Runtime enablement is a per-mount debugfs knob and defaults to off.
> When the static key is down, boutc() is doutc() -- one unlikely branch,
> no formatting tax from BLOG.  When the key is up but this task has no
> enter, boutc() still falls back to doutc().
>
> Load-time module parameters blog_max_sources (default 4096) and
> blog_max_clients (default 256) size the ID tables.  blog_max_full
> (default 16) is the reader-visible full-magazine window.
>
> Design
> ------
>
> Record format.  Each record is a small header (timestamp delta from
> the buffer base, source-ID, client-ID, payload length) plus serialized
> arguments.  The format string lives in the source table, not in every
> record.  Arguments are packed once; strings are length-delimited.
> Decoding walks the source table and reconstructs text, including the
> '#' flag for hex/octal.
>
> Allocation.  Each logging task owns a 4K live buffer.  A page-fragment
> allocator hands out slices without a global lock; freed buffers recycle
> through per-CPU magazine batches, so the warm path does not allocate.
> When the live buffer cannot fit the next record it is retired onto a
> reader-visible snapshot list (fresh monotonic ID) and a new live buffer
> is taken from the magazine or allocated.  On GFP_ATOMIC OOM the full
> window is kept and only the new record is dropped -- the live buffer is
> not wiped in place.  Wipe/reset happens on pool reuse or debugfs clear
> (clear generation).  Sleepable first-touch uses GFP_NOFS.  Folio-locked
> and other atomic callbacks (dirty_folio, invalidate_folio, write_end,
> OSD writeback completion) use GFP_ATOMIC: reuse an existing context or
> skip logging.  RCU-walk permission with MAY_NOT_BLOCK returns -ECHILD
> before enter.
>
> Source-ID caching.  Each (file, func, line, fmt) tuple is registered
> once per logger into an open-addressed table and assigned a u32
> source-ID.  A per-callsite cache avoids that lookup after the first
> hit.  The cache is a seqcount_spinlock_t associated with its spinlock
> so a PREEMPT_RT writer cannot livelock readers on an odd sequence.  A
> generation counter on the logger prevents stale hits across
> mount/unmount of the same callsite.
>
> Per-superblock ownership.  Every mounted CephFS instance, including
> -o noshare, gets its own blog_module_context and logger.  Enable,
> buffers, source table, and debugfs are isolated per mount.  Client IDs
> map (fsid, global_id) so decoded output can name the Ceph client.
>
> Context propagation.  Binary records are only emitted while a task has
> a bound blog_tls_ctx (enter_depth > 0).  ceph_blog_enter() acquires or
> reuses that context from a task-keyed rhashtable and publishes it in a
> per-CPU cache {task, ctx}.  The cache hit requires current, enter_depth,
> and logger match; a miss refills from the map.  Plain enter does not
> write current->journal_info, so ordinary VFS callbacks do not expose a
> Ceph pointer to foreign filesystem reclaim and do not run the whole
> operation under GFP_NOFS.
>
> ceph_blog_enter_req() still installs a tagged ceph_journal_info for
> the MDS fill-trace window (handle_reply -> ceph_fill_trace) so xattr
> and security paths can see the in-flight mds_request.  That window is
> already covered by memalloc_nofs_save().  Nested enter under fill-trace
> may inherit mds_req; it still does not use journal_info as the BLOG
> carrier.
>
> Last module put never calls blog_module_free() in line (that path
> cancel_delayed_work_sync's).  Free is queued on ceph_blog_free;
> ceph_blog_fsc_cleanup and module exit flush the queue.  Dead-task GC
> only collects pointers during rhashtable_walk; retire/sleep happens
> after walk_stop.  Snapshot readers hold snapshot_mutex; a context is
> unlinked from the reader list before it can be freed.
>
> debugfs.  Per-client directory:
>
>   /sys/kernel/debug/ceph/<client>/blog/enabled   # 0/1, default 0
>   /sys/kernel/debug/ceph/<client>/blog/entries   # decoded records
>   /sys/kernel/debug/ceph/<client>/blog/stats
>   /sys/kernel/debug/ceph/<client>/blog/sources   # source-ID table
>   /sys/kernel/debug/ceph/<client>/blog/clients
>   /sys/kernel/debug/ceph/<client>/blog/clear     # write-only
>
> Logging macros.  boutc() / boutc_bounded() / boutc_formats() replace
> doutc() at CephFS call sites (fs/ceph/ only; they take fsc from
> client->private).  boutc_formats() splits binary vs text backends
> where %pd cannot be serialized.  Arguments are evaluated only after a
> cached ctx is present.
>
> Why BLOG
> --------
>
> When enabled, boutc() packs arguments into a 4K per-task ring instead of
> running printk formatting on the hot path.  The format string lives in
> the source table, not in every record, so the retained window is compact
> enough to keep until after a hang.  Disabled, the static key is down and
> boutc() is doutc(): one unlikely branch, no extra work.  Enablement is
> per mount, so a debug session does not tax every CephFS superblock.
>
> Stable events still belong on tracepoints.  BLOG is only for the existing
> dout/doutc corpus: sites that churn with debug work, need a recent-record
> dump without a collector attached in advance, and are too numerous to
> promote one-for-one into TRACE_EVENT.
>
> Patch breakdown
> ---------------
>
>   01-06  BLOG infrastructure, one patch per compilation unit:
>          private headers, deserializer, pagefrag allocator,
>          magazine batcher, logger core, per-module context manager.
>
>   07     Ceph BLOG scaffolding -- ceph_blog.h, blog_client.c,
>          super.h / libceph.h additions, Makefile wiring
>          (ceph-$(CONFIG_DEBUG_FS)).
>
>   08     boutc macro definitions in ceph_debug.h.
>
>   09     MDS fill-trace plumbing -- ceph_blog_enter_req() /
>          ceph_blog_exit() around handle_reply's ceph_fill_trace().
>
>   10     debugfs interface -- blog_debugfs.c and lifecycle hooks.
>
>   11-14  Callsite conversions -- doutc -> boutc, grouped by
>          subsystem: inodes+dirs, data I/O, caps+snaps, helpers.
>
> Changes since v3
> ----------------
>
>   - rebase onto current ceph-client testing (folio writeback,
>     ceph_in_snap(), ceph_ino()/ceph_vino(), mdsc->mutex in
>     ceph_mds_check_access(), u32 time_warp_seq, dentry-caps
>     drop_inode retention)
>   - ceph_blog_free workqueue: add WQ_UNBOUND so v6.19's
>     alloc_workqueue() warning is not hit (WQ_MEM_RECLAIM | WQ_UNBOUND)
>   - visible magazine window is module parameter blog_max_full
>     (default 16, sysfs-writable) instead of a compile-time 16
>   - blog/entries: strip a trailing newline from reconstructed
>     formats so seq_printf does not double-space lines
>
> Changes since v2
> ----------------
>
>   - move private headers under fs/ceph/; only the shared CephFS
>     integration surface stays in include/linux/ceph/
>   - no CONFIG_CEPH_BLOG; compile with CONFIG_DEBUG_FS
>   - 4K buffers and rotate-on-full; snapshot inherits the live context
>     ID (live takes the next ID) so blog/entries stays chronological;
>     clear live before publishing; a failed log-batch put keeps the
>     live window rather than wiping it
>   - BLOG context is task-local (CPU cache on the hot path).
>     journal_info + NOFS are only used for MDS fill-trace
>   - GFP_ATOMIC enter on folio-locked a_ops; last module put defers
>     free to a workqueue, umount/rmmod flush it
>   - seqcount_spinlock_t for the source-id cache; GC does not sleep
>     in the RCU walk
>   - drop the kselftest patch from this posting
>   - annotate lockless client_map[] reads with data_race(); document
>     slot reuse rather than tearing
>
> Alex Markuze (14):
>   ceph: add BLOG private headers
>   ceph: add BLOG deserialization support
>   ceph: add BLOG page-fragment allocator
>   ceph: add BLOG magazine batch allocator
>   ceph: add BLOG logger core
>   ceph: add BLOG per-module context management
>   ceph: add Ceph BLOG scaffolding
>   ceph: add bout and boutc wrappers for BLOG
>   ceph: switch MDS request plumbing to struct ceph_journal_info
>   ceph: add BLOG debugfs interface
>   ceph: convert VFS inode and directory paths to bout
>   ceph: convert VFS data I/O paths to bout
>   ceph: convert capability and snapshot paths to bout
>   ceph: convert remaining helper paths to bout
>
>  fs/ceph/Makefile                |   3 +
>  fs/ceph/addr.c                  | 198 ++++---
>  fs/ceph/blog.h                  | 220 +++++++
>  fs/ceph/blog_batch.c            | 259 +++++++++
>  fs/ceph/blog_batch.h            |  44 ++
>  fs/ceph/blog_client.c           | 641 ++++++++++++++++++++
>  fs/ceph/blog_core.c             | 257 +++++++++
>  fs/ceph/blog_debugfs.c          | 686 ++++++++++++++++++++++
>  fs/ceph/blog_des.c              | 335 +++++++++++
>  fs/ceph/blog_des.h              |  16 +
>  fs/ceph/blog_module.c           | 995 ++++++++++++++++++++++++++++++++
>  fs/ceph/blog_module.h           |  42 ++
>  fs/ceph/blog_pagefrag.c         |  62 ++
>  fs/ceph/blog_pagefrag.h         |  27 +
>  fs/ceph/blog_ser.h              | 234 ++++++++
>  fs/ceph/caps.c                  | 112 ++--
>  fs/ceph/crypto.c                |  14 +-
>  fs/ceph/debugfs.c               |  11 +-
>  fs/ceph/dir.c                   | 322 ++++++++---
>  fs/ceph/export.c                |  83 ++-
>  fs/ceph/file.c                  | 271 ++++++---
>  fs/ceph/inode.c                 | 242 +++++---
>  fs/ceph/locks.c                 |  66 ++-
>  fs/ceph/mds_client.c            | 358 +++++++-----
>  fs/ceph/snap.c                  |  17 +-
>  fs/ceph/super.c                 |  58 +-
>  fs/ceph/super.h                 |   7 +
>  fs/ceph/xattr.c                 | 102 ++--
>  include/linux/ceph/ceph_blog.h  | 292 ++++++++++
>  include/linux/ceph/ceph_debug.h |  84 ++-
>  include/linux/ceph/libceph.h    |   2 +
>  31 files changed, 5423 insertions(+), 637 deletions(-)
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
> Range-diff:
>  1:  f048198bc28b !  1:  a88a37f81be5 ceph: add BLOG private headers
>     @@ fs/ceph/blog.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Infrastructure (BLOG)
>     -+ *
>     -+ * Generic binary logging infrastructure for kernel subsystems.
>     -+ * Modules maintain their own client mappings and debugfs interface=
s.
>     ++ * CephFS binary logging (BLOG) private types.
>      + */
>      +#ifndef _FS_CEPH_BLOG_H
>      +#define _FS_CEPH_BLOG_H
>     @@ fs/ceph/blog_batch.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Batch Management
>     ++ * BLOG magazine batcher.
>      + */
>      +#ifndef _FS_CEPH_BLOG_BATCH_H
>      +#define _FS_CEPH_BLOG_BATCH_H
>     @@ fs/ceph/blog_des.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Deserialization
>     ++ * BLOG record deserialization.
>      + */
>      +#ifndef _FS_CEPH_BLOG_DES_H
>      +#define _FS_CEPH_BLOG_DES_H
>     @@ fs/ceph/blog_module.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
>     -+ *
>     -+ * Each kernel module can have its own isolated logging context.
>     -+ * Per-task context association uses an rhashtable keyed by task po=
inter.
>     -+ * Entries hold task references until exit reaping or logger teardo=
wn.
>     ++ * Per-superblock BLOG context and task-keyed rhashtable.
>      + */
>      +#ifndef _FS_CEPH_BLOG_MODULE_H
>      +#define _FS_CEPH_BLOG_MODULE_H
>     @@ fs/ceph/blog_pagefrag.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Page Fragment Management
>     ++ * BLOG page-fragment allocator.
>      + */
>      +#ifndef _FS_CEPH_BLOG_PAGEFRAG_H
>      +#define _FS_CEPH_BLOG_PAGEFRAG_H
>     @@ fs/ceph/blog_ser.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0 */
>      +/*
>     -+ * Binary Logging Serialization
>     ++ * BLOG argument packing.
>      + */
>      +#ifndef _FS_CEPH_BLOG_SER_H
>      +#define _FS_CEPH_BLOG_SER_H
>  2:  2243f9e892ce !  2:  4c24b2f04234 ceph: add BLOG deserialization supp=
ort
>     @@ fs/ceph/blog_des.c (new)
>      @@
>      +// SPDX-License-Identifier: GPL-2.0
>      +/*
>     -+ * Binary Logging Deserialization
>     ++ * BLOG record deserialization.
>      + */
>      +
>      +#include "blog_des.h"
>     @@ fs/ceph/blog_des.c (new)
>      + * @size: Size of the buffer in bytes
>      + * @out: Buffer to store the reconstructed string
>      + * @out_size: Size of the output buffer
>     -+ *
>     -+ * Return: Number of bytes written to out buffer, or negative error=
 code on failure
>      + */
>      +int blog_des_reconstruct(const char *fmt, const void *buffer,
>      +                   size_t size, char *out, size_t out_size)
>     @@ fs/ceph/blog_des.c (new)
>      +
>      +  *out_ptr =3D '\0';
>      +
>     -+  /* Process the format string */
>      +  while (*fmt_ptr && remaining > 0) {
>      +          int is_long;
>      +          int is_long_long;
>     @@ fs/ceph/blog_des.c (new)
>      +          int dyn_precision =3D -1;
>      +
>      +          if (*fmt_ptr !=3D '%') {
>     -+                  /* Copy literal character */
>      +                  *out_ptr++ =3D *fmt_ptr++;
>      +                  remaining--;
>      +                  continue;
>      +          }
>      +
>     -+          /* Skip the '%' */
>      +          fmt_ptr++;
>      +
>     -+          /* Handle %% */
>      +          if (*fmt_ptr =3D=3D '%') {
>      +                  *out_ptr++ =3D '%';
>      +                  fmt_ptr++;
>     @@ fs/ceph/blog_des.c (new)
>      +                  continue;
>      +          }
>      +
>     -+          /* Skip flags (-+#0 space); remember '#' for hex/octal (P=
1.10). */
>     ++          /* Skip flags (-+#0 space); remember '#' for hex/octal. *=
/
>      +          while (*fmt_ptr && (*fmt_ptr =3D=3D '-' || *fmt_ptr =3D=
=3D '+' || *fmt_ptr =3D=3D '#' ||
>      +                             *fmt_ptr =3D=3D '0' || *fmt_ptr =3D=3D=
 ' ')) {
>      +                  if (*fmt_ptr =3D=3D '#')
>     @@ fs/ceph/blog_des.c (new)
>      +                          is_long =3D 1;
>      +          }
>      +
>     -+          /* Parse and handle format specifier */
>      +          switch (*fmt_ptr) {
>      +          case 's': {
>      +                  const char *str;
>     @@ fs/ceph/blog_des.c (new)
>      +          arg_count++;
>      +  }
>      +
>     -+  /* Null-terminate the output */
>      +  *out_ptr =3D '\0';
>      +
>      +  return out_ptr - out;
>  3:  b00fb0bec0de <  -:  ------------ ceph: add BLOG page-fragment alloca=
tor
>  -:  ------------ >  3:  8667935d30a9 ceph: add BLOG page-fragment alloca=
tor
>  4:  655f71ca4eed !  4:  8babcc520b0c ceph: add BLOG magazine batch alloc=
ator
>     @@ Commit message
>          ceph: add BLOG magazine batch allocator
>
>          Add blog_batch.c: per-CPU magazine batching for TLS context recy=
cling.
>     -    Freed composites go to a local magazine; subsequent acquisitions=
 reclaim
>     -    from the magazine, making the common-case log path allocation-fr=
ee.
>     +    Freed composites go to a local magazine; subsequent acquisitions
>     +    reclaim from the magazine without allocating.
>
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>     @@ fs/ceph/blog_batch.c (new)
>      @@
>      +// SPDX-License-Identifier: GPL-2.0
>      +/*
>     -+ * Binary Logging Batch Management
>     -+ *
>     -+ * Magazine-based batching for efficient object recycling.
>     ++ * Per-CPU magazine batching for BLOG TLS context recycling.
>      + */
>      +
>      +#include <linux/slab.h>
>     @@ fs/ceph/blog_batch.c (new)
>      +{
>      +  struct blog_magazine *mag;
>      +
>     -+  /* Allocate magazine structure from cache */
>      +  mag =3D kmem_cache_zalloc(batch->magazine_cache, gfp);
>      +  if (!mag)
>      +          return NULL;
>     @@ fs/ceph/blog_batch.c (new)
>      +  int i;
>      +  struct blog_tls_pagefrag *composite;
>      +
>     -+  /* Free all composites in this magazine before freeing magazine i=
tself */
>      +  for (i =3D 0; i < mag->count; i++) {
>      +          composite =3D mag->elements[i];
>      +          if (composite)
>      +                  kvfree_atomic(composite);
>      +  }
>      +
>     -+  /* Free the magazine structure itself */
>      +  kmem_cache_free(batch->magazine_cache, mag);
>      +}
>      +
>     @@ fs/ceph/blog_batch.c (new)
>      + * @nr_prealloc: Number of composites to preallocate (0 =3D none)
>      + * @retain_limit: Max composites to retain on put; excess are freed=
 (0 =3D unlimited)
>      + *
>     -+ * Allocates and initializes the per-CPU magazines and global pools=
.
>     -+ * Composites are allocated via kvzalloc() in BLOG_MAGAZINE_SIZE
>     -+ * batches.  Pass nr_prealloc =3D 0 for batches that start empty
>     -+ * (e.g. the log_batch).
>     -+ *
>     -+ * Return: 0 on success, negative error code on failure
>     ++ * Pass nr_prealloc =3D 0 for batches that start empty (e.g. log_ba=
tch).
>      + */
>      +int blog_batch_init(struct blog_batch *batch, struct kmem_cache *ma=
g_cache,
>      +              unsigned int nr_prealloc, unsigned int retain_limit)
>     @@ fs/ceph/blog_batch.c (new)
>      +  struct blog_magazine *mag;
>      +  struct blog_tls_pagefrag *composite;
>      +
>     -+  /* Initialize counters */
>      +  batch->nr_full =3D 0;
>      +  batch->nr_empty =3D 0;
>      +  batch->retain_limit =3D retain_limit;
>      +
>     -+  /* Use caller-provided cache or create one */
>      +  if (mag_cache) {
>      +          batch->magazine_cache =3D mag_cache;
>      +          batch->external_cache =3D true;
>     @@ fs/ceph/blog_batch.c (new)
>      +          batch->external_cache =3D false;
>      +  }
>      +
>     -+  /* Initialize global magazine lists */
>      +  INIT_LIST_HEAD(&batch->full_magazines);
>      +  INIT_LIST_HEAD(&batch->empty_magazines);
>      +  raw_spin_lock_init(&batch->full_lock);
>      +  raw_spin_lock_init(&batch->empty_lock);
>      +
>     -+  /* Allocate per-CPU magazines */
>      +  batch->cpu_magazines =3D alloc_percpu(struct blog_cpu_magazine);
>      +  if (!batch->cpu_magazines)
>      +          goto cleanup_cache;
>      +
>     -+  /* Initialize per-CPU magazines to NULL (magazines allocated on-d=
emand) */
>      +  for_each_possible_cpu(cpu) {
>      +          cpu_mag =3D per_cpu_ptr(batch->cpu_magazines, cpu);
>      +          cpu_mag->mag =3D NULL;
>      +  }
>      +
>     -+  /* Pre-populate magazines with composites */
>      +  nr_mags =3D DIV_ROUND_UP(nr_prealloc, BLOG_MAGAZINE_SIZE);
>      +  for (i =3D 0; i < nr_mags; i++) {
>      +          mag =3D alloc_magazine(batch, GFP_KERNEL);
>     @@ fs/ceph/blog_batch.c (new)
>      +  return -ENOMEM;
>      +}
>      +
>     -+/**
>     -+ * blog_batch_cleanup - Clean up the batching system
>     -+ * @batch: Batch structure to clean up
>     -+ *
>     -+ * Frees all magazines and composites, and destroys the magazine ca=
che.
>     -+ */
>      +void blog_batch_cleanup(struct blog_batch *batch)
>      +{
>      +  int cpu;
>      +  struct blog_magazine *mag, *tmp;
>      +  struct blog_cpu_magazine *cpu_mag;
>      +
>     -+  /* Free per-CPU magazines */
>      +  if (batch->cpu_magazines) {
>      +          for_each_possible_cpu(cpu) {
>      +                  cpu_mag =3D per_cpu_ptr(batch->cpu_magazines, cpu=
);
>     @@ fs/ceph/blog_batch.c (new)
>      +          free_percpu(batch->cpu_magazines);
>      +  }
>      +
>     -+  /* Free magazines in the full pool */
>      +  raw_spin_lock(&batch->full_lock);
>      +  list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) =
{
>      +          list_del(&mag->list);
>     @@ fs/ceph/blog_batch.c (new)
>      +  }
>      +  raw_spin_unlock(&batch->full_lock);
>      +
>     -+  /* Free magazines in the empty pool */
>      +  raw_spin_lock(&batch->empty_lock);
>      +  list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list)=
 {
>      +          list_del(&mag->list);
>     @@ fs/ceph/blog_batch.c (new)
>      +  }
>      +  raw_spin_unlock(&batch->empty_lock);
>      +
>     -+  /* Destroy magazine cache */
>      +  if (!batch->external_cache && batch->magazine_cache)
>      +          kmem_cache_destroy(batch->magazine_cache);
>      +
>     @@ fs/ceph/blog_batch.c (new)
>      +  batch->external_cache =3D false;
>      +}
>      +
>     -+/**
>     -+ * blog_batch_get - Get an element from the batch
>     -+ * @batch: Batch to get element from
>     -+ *
>     -+ * Return: Element from the magazine, or NULL if none available
>     -+ */
>      +void *blog_batch_get(struct blog_batch *batch)
>      +{
>      +  struct blog_cpu_magazine *cpu_mag;
>     @@ fs/ceph/blog_batch.c (new)
>      +  preempt_disable();
>      +  cpu_mag =3D this_cpu_ptr(batch->cpu_magazines);
>      +
>     -+  /* If we have a magazine and it has elements, use it */
>      +  if (cpu_mag->mag && cpu_mag->mag->count > 0) {
>      +          element =3D cpu_mag->mag->elements[--cpu_mag->mag->count]=
;
>      +          goto out;
>      +  }
>      +
>     -+  /* Current magazine is empty, try to get a full one */
>      +  old_mag =3D cpu_mag->mag;
>      +
>     -+  /* Return old magazine to empty pool if we have one */
>      +  if (old_mag) {
>      +          raw_spin_lock(&batch->empty_lock);
>      +          list_add(&old_mag->list, &batch->empty_magazines);
>     @@ fs/ceph/blog_batch.c (new)
>      +  }
>      +
>      +  if (READ_ONCE(batch->nr_full) > 0) {
>     -+          /* Try to get a full magazine */
>      +          raw_spin_lock(&batch->full_lock);
>      +          if (!list_empty(&batch->full_magazines)) {
>      +                  new_mag =3D list_first_entry(&batch->full_magazin=
es,
>     @@ fs/ceph/blog_batch.c (new)
>      +  return element;
>      +}
>      +
>     -+/**
>     -+ * blog_batch_put - Put an element back into the batch
>     -+ * @batch: Batch to put element into
>     -+ * @element: Element to put back
>     -+ *
>     -+ * Return: true if the batch retained the element, false otherwise
>     -+ */
>      +bool blog_batch_put(struct blog_batch *batch, void *element)
>      +{
>      +  struct blog_cpu_magazine *cpu_mag;
>     @@ fs/ceph/blog_batch.c (new)
>      +  preempt_disable();
>      +  cpu_mag =3D this_cpu_ptr(batch->cpu_magazines);
>      +
>     -+  /* Optimistically try to add to current magazine */
>      +  if (likely(cpu_mag->mag && cpu_mag->mag->count < BLOG_MAGAZINE_SI=
ZE)) {
>      +          cpu_mag->mag->elements[cpu_mag->mag->count++] =3D element=
;
>      +          goto out;
>      +  }
>      +
>     -+  /* If current magazine is full, move it to full pool */
>      +  if (likely(cpu_mag->mag && cpu_mag->mag->count >=3D BLOG_MAGAZINE=
_SIZE)) {
>      +          raw_spin_lock(&batch->full_lock);
>      +          list_add_tail(&cpu_mag->mag->list, &batch->full_magazines=
);
>     @@ fs/ceph/blog_batch.c (new)
>      +          cpu_mag->mag =3D NULL;
>      +  }
>      +
>     -+  /* Get new magazine if needed */
>      +  if (likely(!cpu_mag->mag)) {
>     -+          /* Try to get from empty pool first */
>      +          raw_spin_lock(&batch->empty_lock);
>      +          if (!list_empty(&batch->empty_magazines)) {
>      +                  mag =3D list_first_entry(&batch->empty_magazines,
>     @@ fs/ceph/blog_batch.c (new)
>      +                  goto out;
>      +          }
>      +  }
>     -+  /* Add element to magazine */
>      +  cpu_mag->mag->elements[cpu_mag->mag->count++] =3D element;
>      +out:
>      +  preempt_enable();
>  5:  5758a7dd8e71 !  5:  18135902d8f2 ceph: add BLOG logger core
>     @@ fs/ceph/blog_core.c (new)
>      @@
>      +// SPDX-License-Identifier: GPL-2.0
>      +/*
>     -+ * Binary Logging Infrastructure - Core Implementation
>     -+ *
>     -+ * Per-module logger instances, source-ID registration, log-entry
>     -+ * reservation/commit, and pagefrag-based context management.
>     ++ * BLOG logger: source-ID registry and log iteration.
>      + */
>      +
>      +#include <linux/module.h>
>     @@ fs/ceph/blog_core.c (new)
>      + * @func: Function name
>      + * @line: Line number
>      + * @fmt: Format string
>     -+ *
>     -+ * Returns a unique ID for this source location
>      + */
>      +u32 blog_get_source_id(struct blog_logger *logger, const char *file=
,
>      +                 const char *func, unsigned int line, const char *f=
mt)
>     @@ fs/ceph/blog_core.c (new)
>      +  return sid;
>      +}
>      +
>     -+/**
>     -+ * blog_get_source_info - Get source info for a given ID
>     -+ * @id: Source ID
>     -+ *
>     -+ * Returns the source information for this ID
>     -+ */
>      +struct blog_source_info *blog_get_source_info(struct blog_logger *l=
ogger, u32 id)
>      +{
>      +  if (!logger || unlikely(id =3D=3D 0 || id >=3D logger->max_source=
_ids))
>     @@ fs/ceph/blog_core.c (new)
>      +  return &logger->source_map[id];
>      +}
>      +
>     -+/**
>     -+ * blog_log_iter_init - Initialize the iterator for a specific page=
frag
>     -+ */
>      +void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pag=
efrag *pf,
>      +                  u64 head_snapshot)
>      +{
>     @@ fs/ceph/blog_core.c (new)
>      +  iter->steps =3D 0;
>      +}
>      +
>     -+/**
>     -+ * blog_log_iter_next - Get next log entry
>     -+ */
>      +struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *ite=
r)
>      +{
>      +  struct blog_log_entry *entry;
>     @@ fs/ceph/blog_core.c (new)
>      +  return entry;
>      +}
>      +
>     -+/**
>     -+ * blog_des_entry - Deserialize entry with callback
>     -+ */
>      +int blog_des_entry(struct blog_logger *logger, struct blog_log_entr=
y *entry,
>      +             char *output, size_t out_size, blog_client_des_fn clie=
nt_cb)
>      +{
>     @@ fs/ceph/blog_core.c (new)
>      +  if (!entry || !output)
>      +          return -EINVAL;
>      +
>     -+  /* Let module handle client_id if callback provided */
>      +  if (client_cb) {
>      +          len =3D client_cb(output, out_size, entry->client_id);
>      +          if (len < 0)
>     @@ fs/ceph/blog_core.c (new)
>      +                  return len;
>      +  }
>      +
>     -+  /* Get source info */
>      +  source =3D blog_get_source_info(logger, entry->source_id);
>      +  if (!source) {
>      +          len +=3D scnprintf(output + len, out_size - len,
>  6:  f02df3b34736 !  6:  5fd13e885c2f ceph: add BLOG per-module context m=
anagement
>     @@ Commit message
>          ceph: add BLOG per-module context management
>
>          Add blog_module.c: per-superblock rhashtable mapping tasks to
>     -    blog_task_entry structures, with context acquire/release and saf=
e
>     +    blog_task_entry structures, with context acquire/release and
>          retirement that clears the RETIRED bit on removal failure.
>
>     -    Task references pin hash keys until periodic dead-task collectio=
n or
>     -    logger teardown.  Retired buffers remain reader-visible until th=
e
>     -    bounded retention batches reclaim them.  Filesystem-reachable al=
location
>     -    paths use GFP_NOFS to avoid reclaim recursion.
>     -
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>       ## fs/ceph/blog_module.c (new) ##
>      @@
>      +// SPDX-License-Identifier: GPL-2.0
>      +/*
>     -+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
>     -+ *
>     -+ * Per-task context association via rhashtable keyed by task pointe=
r.
>     -+ * Task references keep keys stable until periodic exit reaping rem=
oves them.
>     ++ * Per-superblock BLOG context. Tasks map to TLS contexts via rhash=
table.
>     ++ * Task references keep keys stable until exit reaping removes them=
.
>      + */
>      +
>      +#include <linux/module.h>
>     @@ fs/ceph/blog_module.c (new)
>      +static void blog_module_free_workfn(struct work_struct *work);
>      +
>      +#define BLOG_LOG_BATCH_MAX_FULL 16
>     ++#define BLOG_LOG_BATCH_MAX_FULL_CAP 1024
>      +#define BLOG_MAX_TASK_CONTEXTS 64
>      +#define BLOG_TASK_GC_INTERVAL (5 * HZ)
>      +#define BLOG_TASK_ENTRY_RETIRED 0
>      +
>     -+/* --- rhashtable parameters for task -> context mapping --- */
>     ++static int blog_max_full =3D BLOG_LOG_BATCH_MAX_FULL;
>     ++module_param_named(blog_max_full, blog_max_full, int, 0644);
>     ++MODULE_PARM_DESC(blog_max_full,
>     ++           "Visible full-magazine count for BLOG entries (default 1=
6)");
>     ++
>     ++static unsigned int blog_param_max_full(void)
>     ++{
>     ++  int n =3D READ_ONCE(blog_max_full);
>     ++
>     ++  if (n < 1)
>     ++          n =3D 1;
>     ++  if (n > BLOG_LOG_BATCH_MAX_FULL_CAP)
>     ++          n =3D BLOG_LOG_BATCH_MAX_FULL_CAP;
>     ++  return n;
>     ++}
>      +
>      +static const struct rhashtable_params blog_task_ht_params =3D {
>      +  .key_offset =3D offsetof(struct blog_task_entry, task),
>     @@ fs/ceph/blog_module.c (new)
>      +  .automatic_shrinking =3D true,
>      +};
>      +
>     -+/* --- helper: recycle a TLS context back to the magazine batches -=
-- */
>     -+
>      +static void blog_module_free_magazine(struct blog_logger *logger,
>      +                                struct blog_magazine *mag)
>      +{
>     @@ fs/ceph/blog_module.c (new)
>      +  struct blog_magazine *mag;
>      +  bool retain;
>      +
>     -+  if (!logger || logger->log_batch.nr_full <=3D BLOG_LOG_BATCH_MAX_=
FULL)
>     ++  if (!logger || logger->log_batch.nr_full <=3D blog_param_max_full=
())
>      +          return;
>      +
>      +  raw_spin_lock(&logger->log_batch.full_lock);
>     @@ fs/ceph/blog_module.c (new)
>      +  }
>      +  mutex_unlock(&logger->snapshot_mutex);
>      +
>     -+  while (logger->log_batch.nr_full > BLOG_LOG_BATCH_MAX_FULL)
>     ++  while (logger->log_batch.nr_full > blog_param_max_full())
>      +          blog_module_rebalance_log_batch(logger);
>      +
>      +  spin_lock(&logger->lock);
>     @@ fs/ceph/blog_module.c (new)
>      +  /*
>      +   * Only task-map contexts are charged against allocated_contexts.
>      +   * Rotate-on-full snap buffers share this recycle path but were
>     -+   * never counted =E2=80=94 do not let them underflow the 64-task =
cap.
>     ++   * never counted. Do not let them underflow the 64-task cap.
>      +   */
>      +  if (test_and_clear_bit(BLOG_CTX_TASK_COUNTED, &ctx->flags) &&
>      +      logger->owner_ctx)
>     @@ fs/ceph/blog_module.c (new)
>      +  blog_module_queue_to_log_batch(logger, ctx);
>      +}
>      +
>     -+/* --- task-entry lifecycle --- */
>     -+
>      +/*
>      + * Retire a stale rhashtable entry: remove it from the hash table, =
retain its
>      + * TLS context on the reader-visible list while the log batch owns =
it, and
>     @@ fs/ceph/blog_module.c (new)
>      +  return tls_ctx;
>      +}
>      +
>     -+/* --- public module API --- */
>     -+
>      +struct blog_module_context *blog_module_init(const char *module_nam=
e)
>      +{
>      +  struct blog_module_context *ctx;
>     @@ fs/ceph/blog_module.c (new)
>      +  if (!logger)
>      +          return;
>      +
>     -+
>      +  WRITE_ONCE(logger->task_gc_stopping, true);
>      +  cancel_delayed_work_sync(&logger->task_gc_work);
>      +  cancel_work_sync(&logger->reclaim_work);
>      +
>     -+  /* Drain the task hash table */
>      +  rhashtable_free_and_destroy(&logger->task_map,
>      +                              blog_task_entry_free_cb, logger);
>      +
>     @@ fs/ceph/blog_module.c (new)
>      +  blog_module_free(ctx);
>      +}
>      +
>     -+/* --- per-task context acquisition (rhashtable-based) --- */
>     -+
>      +static void blog_discard_unmapped_ctx(struct blog_logger *logger,
>      +                                struct blog_tls_ctx *tls_ctx)
>      +{
>     @@ fs/ceph/blog_module.c (new)
>      +{
>      +  if (blog_free_wq)
>      +          return 0;
>     -+  blog_free_wq =3D alloc_workqueue("ceph_blog_free", WQ_MEM_RECLAIM=
, 0);
>     ++  blog_free_wq =3D alloc_workqueue("ceph_blog_free",
>     ++                                 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>      +  return blog_free_wq ? 0 : -ENOMEM;
>      +}
>      +
>     @@ fs/ceph/blog_module.c (new)
>      +  blog_free_wq =3D NULL;
>      +}
>      +
>     -+/* --- blog_log_with_ctx / blog_log_commit_with_ctx --- */
>     -+
>      +/*
>      + * Retire the live buffer's published records into a reader-visible
>      + * snapshot, then reset the live pagefrag so logging can continue.
>     @@ fs/ceph/blog_module.c (new)
>      +  if (!logger || !tls_ctx)
>      +          return -EINVAL;
>      +
>     -+  /* Validate that actual_size fits within the reservation */
>      +  total_size =3D round_up(sizeof(struct blog_log_entry) + actual_si=
ze, 8);
>      +  if (total_size > tls_ctx->pending_size) {
>      +          tls_ctx->pending_offset =3D 0;
>  7:  45f84fa4b82d !  7:  198bf57e5058 ceph: add Ceph BLOG scaffolding
>     @@ Commit message
>          (blog_enabled, blog_ctx, debugfs_blog), libceph.h (blog_client_i=
d),
>          and Makefile (gate all BLOG objects on CONFIG_DEBUG_FS).
>
>     -    Runtime enablement remains per-mount via debugfs. Load-time modu=
le
>     -    parameters size the source and client ID tables.
>     -
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>       ## fs/ceph/Makefile ##
>     @@ fs/ceph/blog_client.c (new)
>      +         !data_race(memchr_inv(entry->fsid, 0, sizeof(entry->fsid))=
);
>      +}
>      +
>     -+/**
>     -+ * ceph_blog_init - Initialize Ceph BLOG integration
>     -+ *
>     -+ * Initializes the shared client ID mapping state used by per-super=
block
>     -+ * BLOG instances.
>     -+ *
>     -+ * Return: 0 on success, negative error code on failure
>     -+ */
>      +int ceph_blog_init(void)
>      +{
>      +  u32 max_clients;
>     @@ fs/ceph/blog_client.c (new)
>      +  return 0;
>      +}
>      +
>     -+/**
>     -+ * ceph_blog_cleanup - Clean up Ceph BLOG integration
>     -+ *
>     -+ * Cleans up Ceph's module-specific BLOG context and client mapping=
s.
>     -+ */
>      +void ceph_blog_cleanup(void)
>      +{
>      +  void *client_map =3D NULL;
>     @@ fs/ceph/blog_client.c (new)
>      +  if (!gfpflags_allow_blocking(gfp)) {
>      +          /*
>      +           * Non-blocking: reuse an existing per-task ctx only.  Do=
 not
>     -+           * pin the module until lookup hits =E2=80=94 a miss must=
 not call
>     ++           * pin the module until lookup hits. A miss must not call
>      +           * blog_module_put(), which can sleep in blog_module_free=
().
>      +           */
>      +          tls_ctx =3D blog_lookup_tls_ctx(ctx);
>     @@ fs/ceph/blog_client.c (new)
>      +  }
>      +
>      +hold:
>     -+  /* Keep the module ref for the enter=E2=86=92exit window; put via=
 blog_mod. */
>     ++  /* Keep the module ref for the enter-exit window; put via blog_mo=
d. */
>      +  if (held_mod)
>      +          *held_mod =3D ctx;
>      +  else
>     @@ fs/ceph/blog_client.c (new)
>      +
>      +  /*
>      +   * Publish into the per-CPU cache under preempt_disable only.
>     -+   * Do not migrate_disable() across the enter=E2=86=92exit window:=
 on !RT
>     ++   * Do not migrate_disable() across the enter-exit window: on !RT
>      +   * that is preempt_disable and would leave preempt elevated for
>      +   * the whole VFS call.  Keep each ctx on at most one CPU slot:
>      +   * clear the prior publish before installing the new one.
>     @@ fs/ceph/blog_client.c (new)
>      +          if (READ_ONCE(ctx->task) =3D=3D current &&
>      +              READ_ONCE(ctx->enter_depth) &&
>      +              ctx->logger =3D=3D want_logger)
>     -+                  ; /* hit =E2=80=94 mount-scoped */
>     ++                  ; /* hit. Mount-scoped */
>      +          else {
>      +                  WRITE_ONCE(c->task, NULL);
>      +                  WRITE_ONCE(c->ctx, NULL);
>     @@ fs/ceph/blog_client.c (new)
>      +   * Cache miss after preemption.  Prefer the mount-scoped
>      +   * journal_info ctx when it matches @fsc so nested multi-mount
>      +   * work does not attach to another mount's logger.  Plain
>     -+   * ceph_blog_enter() never installs journal_info =E2=80=94 recove=
r only
>     ++   * ceph_blog_enter() never installs journal_info. Recover only
>      +   * from @fsc's own task map (not a cross-mount module-list walk).
>      +   */
>      +  ji =3D ceph_ji_from_current();
>     @@ fs/ceph/blog_client.c (new)
>      + *
>      + * Returns the actual ID of the pair. If the given ID doesn't match=
, scans for
>      + * existing matches or allocates a new ID if no match is found.
>     -+ *
>     -+ * Return: Client ID for this fsid/global_id pair
>      + */
>      +u32 ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_=
id)
>      +{
>     @@ fs/ceph/blog_client.c (new)
>      +  struct ceph_blog_client_info *entry;
>      +
>      +  if (unlikely(!ceph_blog_state.initialized)) {
>     -+          WARN_ON_ONCE(1);  /* Should never happen - init_ceph() in=
itializes BLOG */
>     -+          return 0;  /* Drop the log entry */
>     ++          WARN_ON_ONCE(1);
>     ++          return 0;
>      +  }
>      +
>      +  spin_lock(&ceph_blog_state.lock);
>      +  max_clients =3D ceph_blog_state.max_clients;
>      +
>     -+  /* Reuse caller-provided hint when it still matches */
>      +  if (id !=3D 0 && id < max_clients) {
>      +          entry =3D &ceph_blog_state.client_map[id];
>      +          if (ceph_blog_ids_match(entry, fsid, global_id)) {
>     @@ fs/ceph/blog_client.c (new)
>      +          }
>      +  }
>      +
>     -+  /* Search for an existing entry with matching identity */
>      +  for (id =3D 1; id < max_clients; id++) {
>      +          entry =3D &ceph_blog_state.client_map[id];
>      +          if (ceph_blog_ids_match(entry, fsid, global_id)) {
>     @@ fs/ceph/blog_client.c (new)
>      +          }
>      +  }
>      +
>     -+  /* Assign new identifier; reuse freed slots before failing */
>      +  if (ceph_blog_state.next_client_id < max_clients) {
>      +          found_id =3D ceph_blog_state.next_client_id++;
>      +  } else {
>     @@ fs/ceph/blog_client.c (new)
>      + * Writers store fields under the lock. Callers accept the benign
>      + * race: a concurrent slot release and reuse may cause old log
>      + * entries to show a new client's identity; the impact is cosmetic.
>     -+ *
>     -+ * Return: Client information for this ID, or NULL if invalid
>      + */
>      +const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 i=
d)
>      +{
>     @@ fs/ceph/blog_client.c (new)
>      +  return entry;
>      +}
>      +
>     -+/**
>     -+ * ceph_blog_client_des_callback - Deserialization callback for Cep=
h client info
>     -+ * @buf: Output buffer
>     -+ * @size: Buffer size
>     -+ * @client_id: Client ID to deserialize
>     -+ *
>     -+ * This is the callback that BLOG will use to deserialize client in=
formation.
>     -+ *
>     -+ * Return: Number of bytes written to buffer
>     -+ */
>      +int ceph_blog_client_des_callback(char *buf, size_t size, u8 client=
_id)
>      +{
>      +  const struct ceph_blog_client_info *info;
>     @@ fs/ceph/blog_client.c (new)
>      +
>      +  global_id =3D data_race(info->global_id);
>      +  data_race(memcpy(fsid, info->fsid, sizeof(fsid)));
>     -+  /* Use %pU to format fsid, matching boutc and other Ceph client l=
ogging */
>      +  return snprintf(buf, size, "[%pU %llu] ", fsid, global_id);
>      +}
>      +
>     -+/**
>     -+ * ceph_blog_get_client_id - Get or allocate client ID for a Ceph c=
lient
>     -+ * @client: Ceph client structure
>     -+ *
>     -+ * Return: Client ID for this client
>     -+ */
>      +u32 ceph_blog_get_client_id(struct ceph_client *client)
>      +{
>      +  u32 cached;
>     @@ include/linux/ceph/ceph_blog.h (new)
>      + *       acquires only reuse an existing per-task context; first-to=
uch
>      + *       allocation is skipped and logging is a no-op for that ente=
r.
>      + *
>     -+ * Option C: BLOG state lives in the per-task map (+ CPU cache).  P=
lain VFS
>     -+ * enters never publish into current->journal_info.  Only enter_req=
 (MDS
>     ++ * BLOG state lives in the per-task map and CPU cache.  Plain VFS e=
nters
>     ++ * never publish into current->journal_info.  Only enter_req (MDS
>      + * fill-trace, which already runs under memalloc_nofs_save) install=
s the
>      + * tagged carrier so xattr paths can see mds_req.
>      + */
>  8:  ec5c411f64f3 =3D  8:  a936734b5d86 ceph: add bout and boutc wrappers=
 for BLOG
>  9:  79ee84e3168c !  9:  aa203cbe62da ceph: switch MDS request plumbing t=
o struct ceph_journal_info
>     @@ fs/ceph/mds_client.c: static int trim_caps_cb(struct inode *inode,=
 int mds, void
>      -                  doutc(cl, "%p %llx.%llx cap %p pruned, count now =
%d\n",
>      +                  boutc(cl, "%p %llx.%llx cap %p pruned, count now =
%d\n",
>                               inode, ceph_vinop(inode), cap, count);
>     -           } else {
>     -                   dput(dentry);
>     +           }
>     +           return 0;
>      @@ fs/ceph/mds_client.c: int ceph_trim_caps(struct ceph_mds_client *=
mdsc,
>         struct ceph_client *cl =3D mdsc->fsc->client;
>         int trim_caps =3D session->s_nr_caps - max_caps;
>     @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_cl=
ient *mdsc, ch
>      +  boutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
>               tpath, mask, caller_uid, caller_gid);
>
>     -   for (i =3D 0; i < mdsc->s_cap_auths_num; i++) {
>     +   mutex_lock(&mdsc->mutex);
>      @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_c=
lient *mdsc, char *tpath, int mask)
>
>         put_cred(cred);
>     @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_cl=
ient *mdsc, ch
>      +  boutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_pe=
rms,
>               rw_perms_s);
>         if (root_squash_perms && rw_perms_s =3D=3D NULL) {
>     +           mutex_unlock(&mdsc->mutex);
>      -          doutc(cl, "access allowed\n");
>      +          boutc(cl, "access allowed\n");
>                 return 0;
>     @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_cl=
ient *mdsc, ch
>         }
>      -  doutc(cl, "access denied\n");
>      +  boutc(cl, "access denied\n");
>     +   mutex_unlock(&mdsc->mutex);
>         return -EACCES;
>       }
>     -
>      @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_c=
lient *mdsc, char *tpath, int mask)
>        */
>       void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
> 10:  1ce9ea0e36ff ! 10:  7f3cc903af71 ceph: add BLOG debugfs interface
>     @@ Commit message
>          Add blog_debugfs.c: per-superblock debugfs files under
>          /sys/kernel/debug/ceph/<fsid>/blog/ (entries, stats, sources,
>          clients, enable, clear).  Wire lifecycle hooks in super.c and
>     -    debugfs.c.  Readers use smp_load_acquire() on pf->head to pair
>     -    with writers' smp_store_release() publication.
>     +    debugfs.c.
>
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>     @@ fs/ceph/blog_debugfs.c (new)
>      @@
>      +// SPDX-License-Identifier: GPL-2.0
>      +/*
>     -+ * Ceph BLOG debugfs interface
>     -+ *
>     -+ * Provides debugfs entries to view and manage BLOG entries for Cep=
h
>     ++ * Ceph BLOG debugfs.
>      + */
>      +
>      +#include <linux/ceph/ceph_debug.h>
>     @@ fs/ceph/blog_debugfs.c (new)
>      +}
>      +
>      +/**
>     -+ * blog_entries_show - Show all BLOG entries for Ceph
>     -+ *
>     -+ * Iterates through all contexts, deserializing their pagefrag entr=
ies.
>     ++ * blog_entries_show - dump decoded records
>      + *
>     -+ * To avoid holding logger->lock for the entire (potentially large)
>     -+ * iteration, we use an ID-cursor: each pass finds the next context=
 by
>     -+ * ascending ID, drops logger->lock, and snapshots only its publish=
ed bytes
>     -+ * under pf->lock.  snapshot_mutex keeps retained contexts from bei=
ng
>     -+ * reclaimed between the list lookup and the snapshot.
>     ++ * ID-cursor walk: each pass finds the next context by ascending ID=
, drops
>     ++ * logger->lock, and snapshots only its published bytes under pf->l=
ock.
>     ++ * snapshot_mutex keeps retained contexts from being reclaimed betw=
een the
>     ++ * list lookup and the snapshot.
>      + */
>      +static int blog_entries_show(struct seq_file *s, void *p)
>      +{
>     @@ fs/ceph/blog_debugfs.c (new)
>      +          u64 head;
>      +          int ret;
>      +
>     -+          /* Find the next context by ascending ID */
>      +          mutex_lock(&logger->snapshot_mutex);
>      +          spin_lock(&logger->lock);
>      +          list_for_each_entry(ctx, &logger->contexts, list) {
>     @@ fs/ceph/blog_debugfs.c (new)
>      +           * snapshot and give this ctx a new id.  Any id mismatch
>      +           * means this copy is not the retired window; leave the
>      +           * cursor so the next walk finds the snapshot.  Do not
>     -+           * advance just because head is non-zero =E2=80=94 that m=
ay be
>     ++           * advance just because head is non-zero. That may be
>      +           * the *new* live tail.
>      +           */
>      +          spin_lock(&logger->lock);
>     @@ fs/ceph/blog_debugfs.c (new)
>      +                  if (jiffies_to_formatted_time(entry_jiffies, time=
_buf,
>      +                                                sizeof(time_buf)) <=
 0)
>      +                          strscpy(time_buf, "(invalid)", sizeof(tim=
e_buf));
>     ++                  if (ret > 0 && output_buf[ret - 1] =3D=3D '\n')
>     ++                          output_buf[ret - 1] =3D '\0';
>      +                  seq_printf(s, "%s %s\n", time_buf, output_buf);
>      +          }
>      +  }
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  .release =3D blog_dbg_release,
>      +};
>      +
>     -+/**
>     -+ * blog_stats_show - Show BLOG statistics
>     -+ */
>      +static int blog_stats_show(struct seq_file *s, void *p)
>      +{
>      +  struct blog_dbg_file *priv =3D s->private;
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  .release =3D blog_dbg_release,
>      +};
>      +
>     -+/**
>     -+ * blog_sources_show - Show all registered source locations
>     -+ */
>      +static int blog_sources_show(struct seq_file *s, void *p)
>      +{
>      +  struct blog_dbg_file *priv =3D s->private;
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  .release =3D blog_dbg_release,
>      +};
>      +
>     -+/**
>     -+ * blog_clients_show - Show all registered Ceph clients
>     -+ */
>      +static int blog_clients_show(struct seq_file *s, void *p)
>      +{
>      +  struct blog_dbg_file *priv =3D s->private;
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  .release =3D blog_dbg_release,
>      +};
>      +
>     -+/**
>     -+ * blog_clear_write - Clear all BLOG entries (write-only)
>     -+ */
>      +static ssize_t blog_clear_write(struct file *file, const char __use=
r *buf,
>      +                          size_t count, loff_t *ppos)
>      +{
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  .llseek =3D generic_file_llseek,
>      +};
>      +
>     -+/**
>     -+ * ceph_blog_debugfs_init - Initialize Ceph BLOG debugfs entries
>     -+ * @fsc: CephFS client whose debugfs directory hosts BLOG entries
>     -+ *
>     -+ * Return: 0 on success, negative error code on failure
>     -+ */
>      +int ceph_blog_debugfs_init(struct ceph_fs_client *fsc)
>      +{
>      +  struct dentry *dir;
>     @@ fs/ceph/blog_debugfs.c (new)
>      +          return PTR_ERR(dir);
>      +  fsc->debugfs_blog =3D dir;
>      +
>     -+  /* Create debugfs entries */
>      +  debugfs_create_file("enabled", 0600, fsc->debugfs_blog, fsc,
>      +                      &blog_enabled_fops);
>      +  debugfs_create_file("entries", 0444, fsc->debugfs_blog, fsc,
>     @@ fs/ceph/blog_debugfs.c (new)
>      +  return 0;
>      +}
>      +
>     -+/**
>     -+ * ceph_blog_debugfs_cleanup - Clean up Ceph BLOG debugfs entries
>     -+ * @fsc: CephFS client whose BLOG debugfs directory should be remov=
ed
>     -+ */
>      +void ceph_blog_debugfs_cleanup(struct ceph_fs_client *fsc)
>      +{
>      +  if (!fsc || !fsc->debugfs_blog)
> 11:  ffbfd6fc63e4 ! 11:  223c11d37e7b ceph: convert VFS inode and directo=
ry paths to bout
>     @@ fs/ceph/dir.c: static int ceph_mknod(struct mnt_idmap *idmap, stru=
ct inode *dir,
>      +
>      +  ceph_blog_enter(fsc, &__ji);
>
>     --  if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>     -+  if (ceph_snap(dir) !=3D CEPH_NOSNAP) {
>     +-  if (ceph_in_snap(dir))
>     ++  if (ceph_in_snap(dir)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
>     @@ fs/ceph/dir.c: static int ceph_symlink(struct mnt_idmap *idmap, st=
ruct inode *di
>         int err;
>      +  struct ceph_journal_info __ji;
>
>     --  if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>     +-  if (ceph_in_snap(dir))
>      +  ceph_blog_enter(fsc, &__ji);
>      +
>     -+  if (ceph_snap(dir) !=3D CEPH_NOSNAP) {
>     ++  if (ceph_in_snap(dir)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
>     @@ fs/ceph/dir.c: static struct dentry *ceph_mkdir(struct mnt_idmap *=
idmap, struct
>      +                        "mksnap %llx.%llx/'%pd' dentry %p\n",
>      +                        (ceph_vinop(dir), dentry->d_name.name, dent=
ry),
>      +                        (ceph_vinop(dir), dentry, dentry));
>     -   } else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>     +   } else if (!ceph_in_snap(dir)) {
>      -          doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
>      -                ceph_vinop(dir), dentry, dentry, mode);
>      +          boutc_formats(cl, "mkdir %llx.%llx/'%s' dentry %p mode 0%=
ho\n",
>     @@ fs/ceph/dir.c: static int ceph_link(struct dentry *old_dentry, str=
uct inode *dir
>                 return err;
>      +  }
>
>     --  if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>     -+  if (ceph_snap(dir) !=3D CEPH_NOSNAP) {
>     +-  if (ceph_in_snap(dir))
>     ++  if (ceph_in_snap(dir)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
>     @@ fs/ceph/dir.c: static int ceph_unlink(struct inode *dir, struct de=
ntry *dentry)
>      +                        (ceph_vinop(dir), dentry->d_name.name),
>      +                        (ceph_vinop(dir), dentry));
>                 op =3D CEPH_MDS_OP_RMSNAP;
>     -   } else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>     +   } else if (!ceph_in_snap(dir)) {
>      -          doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n=
",
>      -                ceph_vinop(dir), dentry, ceph_vinop(inode));
>      +          boutc_formats(cl,
>     @@ fs/ceph/dir.c: static int ceph_rename(struct mnt_idmap *idmap, str=
uct inode *old
>      +          ceph_blog_exit(&__ji);
>                 return -EXDEV;
>      +  }
>     -   if (ceph_snap(old_dir) !=3D CEPH_NOSNAP) {
>     +   if (ceph_in_snap(old_dir)) {
>                 if (old_dir =3D=3D new_dir && ceph_snap(old_dir) =3D=3D C=
EPH_SNAPDIR)
>                         op =3D CEPH_MDS_OP_RENAMESNAP;
>      -          else
>     @@ fs/ceph/export.c: static int ceph_encode_snapfh(struct inode *inod=
e, u32 *rawfh,
>         int type;
>      +  struct ceph_journal_info __ji;
>
>     --  if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>     +-  if (ceph_in_snap(inode))
>      -          return ceph_encode_snapfh(inode, rawfh, max_len, parent_i=
node);
>      +  ceph_blog_enter(fsc, &__ji);
>      +
>     -+  if (ceph_snap(inode) !=3D CEPH_NOSNAP) {
>     ++  if (ceph_in_snap(inode)) {
>      +          int ret =3D ceph_encode_snapfh(inode, rawfh, max_len,
>      +                                       parent_inode);
>      +          ceph_blog_exit(&__ji);
>     @@ fs/ceph/export.c: static struct dentry *__get_parent(struct super_=
block *sb,
>      +
>      +  ceph_blog_enter(fsc, &__ji);
>
>     -   if (ceph_snap(inode) !=3D CEPH_NOSNAP) {
>     +   if (ceph_in_snap(inode)) {
>                 struct inode* dir;
>      @@ fs/ceph/export.c: static struct dentry *ceph_get_parent(struct de=
ntry *child)
>                 dn =3D __get_parent(child->d_sb, child, 0);
>     @@ fs/ceph/export.c: static int ceph_get_name(struct dentry *parent, =
char *name,
>         int err;
>      +  struct ceph_journal_info __ji;
>
>     --  if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>     +-  if (ceph_in_snap(inode))
>      +  ceph_blog_enter(fsc, &__ji);
>      +
>     -+  if (ceph_snap(inode) !=3D CEPH_NOSNAP) {
>     ++  if (ceph_in_snap(inode)) {
>      +          ceph_blog_exit(&__ji);
>                 return __get_snap_name(parent, name, child);
>      +  }
>     @@ fs/ceph/inode.c: void ceph_free_inode(struct inode *inode)
>      @@ fs/ceph/inode.c: void ceph_evict_inode(struct inode *inode)
>          */
>         if (ci->i_snap_realm) {
>     -           if (ceph_snap(inode) =3D=3D CEPH_NOSNAP) {
>     +           if (!ceph_in_snap(inode)) {
>      -                  doutc(cl, " dropping residual ref to snap realm %=
p\n",
>      +                  boutc(cl, " dropping residual ref to snap realm %=
p\n",
>                               ci->i_snap_realm);
>     @@ fs/ceph/inode.c: void ceph_evict_inode(struct inode *inode)
>      +  ceph_blog_exit(&__ji);
>       }
>
>     - static inline blkcnt_t calc_inode_blocks(u64 size)
>     + /*
>      @@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int=
 issued,
>
>         if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
>     @@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int =
issued,
>                       ci->i_truncate_size, truncate_size,
>                       !!IS_ENCRYPTED(inode));
>
>     -           ci->i_truncate_size =3D truncate_size;
>     +@@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int=
 issued,
>
>     + #ifdef CONFIG_FS_ENCRYPTION
>                 if (IS_ENCRYPTED(inode)) {
>      -                  doutc(cl, "truncate_pagecache_size %lld -> %llu\n=
",
>      +                  boutc(cl, "truncate_pagecache_size %lld -> %llu\n=
",
>     @@ fs/ceph/inode.c: void ceph_fill_file_time(struct inode *inode, int=
 issued,
>                 }
>         }
>         if (warn) /* time_warp_seq shouldn't go backwards */
>     --          doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
>     -+          boutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
>     +-          doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
>     ++          boutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
>                       time_warp_seq, ci->i_time_warp_seq);
>       }
>
>     @@ fs/ceph/inode.c: static void __update_dentry_lease(struct inode *d=
ir, struct den
>      +  boutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
>
>         /* only track leases on regular dentries */
>     -   if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>     +   if (ceph_in_snap(dir))
>      @@ fs/ceph/inode.c: static int splice_dentry(struct dentry **pdn, st=
ruct inode *in)
>         }
>
>     @@ fs/ceph/inode.c: void __ceph_do_pending_vmtruncate(struct inode *i=
node)
>                                              inode->i_sb->s_maxbytes);
>      @@ fs/ceph/inode.c: void __ceph_do_pending_vmtruncate(struct inode *=
inode)
>
>     -   to =3D ci->i_truncate_pagecache_size;
>     +   to =3D ceph_get_truncate_pagecache_size(ci);
>         wrbuffer_refs =3D ci->i_wrbuffer_ref;
>      -  doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode)=
,
>      +  boutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode)=
,
>     @@ fs/ceph/inode.c: int ceph_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry
>      +
>      +  ceph_blog_enter(fsc, &__ji);
>
>     --  if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>     -+  if (ceph_snap(inode) !=3D CEPH_NOSNAP) {
>     +-  if (ceph_in_snap(inode))
>     ++  if (ceph_in_snap(inode)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
>     @@ fs/ceph/inode.c: int ceph_getattr(struct mnt_idmap *idmap, const s=
truct path *pa
>         u32 valid_mask =3D STATX_BASIC_STATS;
>         int err =3D 0;
>      +  struct ceph_journal_info __ji;
>     -+
>     -+  ceph_blog_enter(fsc, &__ji);
>
>      -  if (ceph_inode_is_shutdown(inode))
>     ++  ceph_blog_enter(fsc, &__ji);
>     ++
>      +  if (ceph_inode_is_shutdown(inode)) {
>      +          ceph_blog_exit(&__ji);
>                 return -ESTALE;
> 12:  7de4cc38e58d ! 12:  259575d1ffd0 ceph: convert VFS data I/O paths to=
 bout
>     @@ Commit message
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>       ## fs/ceph/addr.c ##
>     -@@ fs/ceph/addr.c: static inline struct ceph_snap_context *page_snap=
_context(struct page *page)
>     +@@ fs/ceph/addr.c: struct ceph_snap_context *ceph_folio_snap_context=
(const struct folio *folio)
>       static bool ceph_dirty_folio(struct address_space *mapping, struct =
folio *folio)
>       {
>         struct inode *inode =3D mapping->host;
>     @@ fs/ceph/addr.c: static void finish_netfs_read(struct ceph_osd_requ=
est *req)
>      +  ceph_blog_exit(&__ji);
>       }
>
>     - static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *=
subreq)
>     + #ifdef CONFIG_CEPH_FS_INLINE_DATA
>      @@ fs/ceph/addr.c: static void ceph_netfs_issue_read(struct netfs_io=
_subrequest *subreq)
>                         goto out;
>         }
>     @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *foli=
o,
>         if (ceph_inode_is_shutdown(inode))
>      @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *fol=
io,
>         /* verify this is a writeable snap context */
>     -   snapc =3D page_snap_context(&folio->page);
>     +   snapc =3D ceph_folio_snap_context(folio);
>         if (!snapc) {
>      -          doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(i=
node),
>      +          boutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(i=
node),
>     @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *foli=
o,
>               snapc->seq);
>
>      @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *fol=
io,
>     -   osd_req_op_extent_osd_data_pages(req, 0,
>     -                   bounce_page ? &bounce_page : &page, wlen, 0,
>     -                   false, false);
>     +   WARN_ON_ONCE(len > folio_size(folio));
>     +   page =3D bounce_page ? bounce_page : &folio->page;
>     +   osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, f=
alse);
>      -  doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
>      +  boutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
>               ceph_vinop(inode), page_off, len, wlen,
>     @@ fs/ceph/addr.c: static void writepages_finish(struct ceph_osd_requ=
est *req)
>                                 WARN_ON(atomic64_read(&mdsc->dirty_folios=
) < 0);
>                         }
>
>     --                  doutc(cl, "unlocking %p\n", page);
>     -+                  boutc(cl, "unlocking %p\n", page);
>     +-                  doutc(cl, "unlocking %p\n", folio);
>     ++                  boutc(cl, "unlocking %p\n", folio);
>
>                         if (remove_page)
>                                 generic_error_remove_folio(inode->i_mappi=
ng,
>      @@ fs/ceph/addr.c: static void writepages_finish(struct ceph_osd_req=
uest *req)
>
>     -                   unlock_page(page);
>     +                   folio_unlock(folio);
>                 }
>      -          doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n"=
,
>      +          boutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n"=
,
>     @@ fs/ceph/addr.c: int ceph_define_writeback_range(struct address_spa=
ce *mapping,
>         }
>
>         ceph_put_snap_context(ceph_wbc->last_snapc);
>     -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_s=
pace *mapping,
>     +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_=
space *mapping,
>
>         /* only dirty folios, or our accounting breaks */
>         if (unlikely(!folio_test_dirty(folio) || folio->mapping !=3D mapp=
ing)) {
>     @@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_sp=
ace *mapping,
>         }
>
>         /* only if matching snap context */
>     -   pgsnapc =3D page_snap_context(&folio->page);
>     +   pgsnapc =3D ceph_folio_snap_context(folio);
>         if (pgsnapc !=3D ceph_wbc->snapc) {
>      -          doutc(cl, "folio snapc %p %lld !=3D oldest %p %lld\n",
>      +          boutc(cl, "folio snapc %p %lld !=3D oldest %p %lld\n",
>                       pgsnapc, pgsnapc->seq,
>                       ceph_wbc->snapc, ceph_wbc->snapc->seq);
>
>     -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_s=
pace *mapping,
>     +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_=
space *mapping,
>         }
>
>         if (folio_pos(folio) >=3D ceph_wbc->i_size) {
>     @@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_sp=
ace *mapping,
>                       folio->index, ceph_wbc->i_size);
>
>                 if ((ceph_wbc->size_stable ||
>     -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_s=
pace *mapping,
>     +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_=
space *mapping,
>
>         if (ceph_wbc->strip_unit_end &&
>             (folio->index > ceph_wbc->strip_unit_end)) {
>     @@ fs/ceph/addr.c: void ceph_fill_inline_data(struct inode *inode, st=
ruct page *loc
>
>         if (len > 0) {
>      @@ fs/ceph/addr.c: int ceph_uninline_data(struct file *file)
>     -   inline_version =3D ci->i_inline_version;
>     +   inline_version =3D ceph_inline_version(ci);
>         spin_unlock(&ci->i_ceph_lock);
>
>      -  doutc(cl, "%llx.%llx inline_version %llu\n", ceph_vinop(inode),
>     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *fi=
le)
>      +  boutc(cl, "%p %llx.%llx file %p flags %d (%d)\n", inode,
>               ceph_vinop(inode), file, flags, file->f_flags);
>         fmode =3D ceph_flags_to_mode(flags);
>     -
>     +   wanted =3D ceph_caps_for_mode(fmode);
>      @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *f=
ile)
>
>                 /* For none EACCES cases will let the MDS do the mds auth=
 check */
>     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *fi=
le)
>         }
>
>         /* snapped files are read-only */
>     --  if (ceph_snap(inode) !=3D CEPH_NOSNAP && (file->f_mode & FMODE_WR=
ITE))
>     -+  if (ceph_snap(inode) !=3D CEPH_NOSNAP && (file->f_mode & FMODE_WR=
ITE)) {
>     +-  if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE))
>     ++  if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
>     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *fi=
le)
>
>      +          ceph_blog_exit(&__ji);
>                 return ceph_init_file(inode, file, fmode);
>     -   } else if (!do_sync && ceph_snap(inode) !=3D CEPH_NOSNAP &&
>     +   } else if (!do_sync && ceph_in_snap(inode) &&
>                    (ci->i_snap_caps & wanted) =3D=3D wanted) {
>                 __ceph_touch_fmode(ci, mdsc, fmode);
>                 spin_unlock(&ci->i_ceph_lock);
>     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *fi=
le)
>                 err =3D PTR_ERR(req);
>      @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *f=
ile)
>         if (!err)
>     -           err =3D ceph_init_file(inode, file, fmode);
>     +           err =3D ceph_init_file(inode, file, req->r_fmode);
>         ceph_mdsc_put_request(req);
>      -  doutc(cl, "open result=3D%d on %llx.%llx\n", err, ceph_vinop(inod=
e));
>      +  boutc(cl, "open result=3D%d on %llx.%llx\n", err, ceph_vinop(inod=
e));
>     @@ fs/ceph/file.c: static ssize_t ceph_sync_read(struct kiocb *iocb, =
struct iov_ite
>               (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>
>      @@ fs/ceph/file.c: ceph_direct_read_write(struct kiocb *iocb, struct=
 iov_iter *iter,
>     -   if (write && ceph_snap(file_inode(file)) !=3D CEPH_NOSNAP)
>     +   if (write && ceph_in_snap(file_inode(file)))
>                 return -EROFS;
>
>      -  doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n"=
,
>     @@ fs/ceph/file.c: ceph_direct_read_write(struct kiocb *iocb, struct =
iov_iter *iter
>
>                 flags =3D /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_W=
RITE;
>      @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>     -   if (ceph_snap(file_inode(file)) !=3D CEPH_NOSNAP)
>     +   if (ceph_in_snap(file_inode(file)))
>                 return -EROFS;
>
>      -  doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
>     @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_ite=
r *from, loff_
>
>      -          doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw=
\n",
>      +          boutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw=
\n",
>     -                 ci->i_vino.ino, pos, len, write_pos, write_len,
>     +                 ceph_ino(inode), pos, len, write_pos, write_len,
>                       rmw ? "" : "no ");
>
>      @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>     @@ fs/ceph/file.c: static ssize_t ceph_write_iter(struct kiocb *iocb,=
 struct iov_it
>                 return -ESTALE;
>      +  }
>
>     --  if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>     -+  if (ceph_snap(inode) !=3D CEPH_NOSNAP) {
>     +-  if (ceph_in_snap(inode))
>     ++  if (ceph_in_snap(inode)) {
>      +          ceph_blog_exit(&__ji);
>                 return -EROFS;
>      +  }
> 13:  a72970fda744 ! 13:  961dbc6413b5 ceph: convert capability and snapsh=
ot paths to bout
>     @@ Commit message
>          Replace dout()/doutc() with bout()/boutc() only on MDS/VFS paths=
 that
>          already bind a BLOG context via ceph_blog_enter() (ceph_handle_c=
aps and
>          its handle_cap_* helpers, ceph_handle_snap/flush_snaps, ceph_fsy=
nc,
>     -    ceph_write_inode). Leave enter-less helpers and async/workqueue =
sites
>     -    on doutc to avoid false binary coverage (spec P2.2).
>     +    ceph_write_inode).
>
>          Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
>     @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
>                         ci->i_max_size =3D max_size;
>                         if (max_size >=3D ci->i_wanted_max_size) {
>      @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
>     +   wanted =3D __ceph_caps_wanted(ci);
>         used =3D __ceph_caps_used(ci);
>     -   used =3D ceph_adjust_caps_used_for_lazyio(used, cap->issued, cap-=
>implemented);
>         dirty =3D __ceph_caps_dirty(ci);
>      -  doutc(cl, " my wanted =3D %s, used =3D %s, dirty %s\n",
>      +  boutc(cl, " my wanted =3D %s, used =3D %s, dirty %s\n",
>     @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
>      +          boutc(cl, "revocation: %s -> %s (revoking %s)\n",
>                       ceph_cap_string(cap->issued), ceph_cap_string(newca=
ps),
>                       ceph_cap_string(revoking));
>     -           /*
>     +           if (S_ISREG(inode->i_mode) &&
>      @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
>                 cap->issued =3D newcaps;
>                 cap->implemented |=3D newcaps;
> 14:  762c2cff158c =3D 14:  43a8e69ecc4e ceph: convert remaining helper pa=
ths to bout
> --
> 2.34.1
>
