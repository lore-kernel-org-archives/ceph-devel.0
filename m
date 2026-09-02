Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657A4AA1F9
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366492; cv=none; b=UTPRLnDuYXR9CF49GHJE22ril1u1lBiVJoQqhJprXp7rOa9G2II1GofhwHNAKiIpREfI1NFDS62dXUFbOSImWM6GLxANAd5RKMmjsW8PyqFv3i/eS1o/kkXuNJwMVmlxHJjcdkrsS8ji4QuMidIZqReHxePxr5xwsqPehYyUAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366492; c=relaxed/simple;
	bh=aPHQkljfEe1s3wH6QncEykDHcZWJ2hZ3Gx1zL49+q4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mrgGfVO2KHvARFVJSBgG7gk4ifMlyTjNwLmIm1cgriGOta2VZGhVL2q2sxI2P4ZiJOYQ+q4YHMFBvJ++7MmULWwZeDYyIG7C1M7+2/7jmXC0uZiSSiwt8EXGd4J+U8kXJFH5iEUqditdhbe2T0dms9hqsHUO8HXVYEzyQucmUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmohSZ3I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oc/F+y3M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmohSZ3I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oc/F+y3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HgIwEmTiJ5LJ0RcSrKnCu3vSx10jRwcDN1IS812+2mo=;
	b=GmohSZ3IYxJPsYAPM6q+UZhOjyb70rgmQRPejVIR0TQ6i7O+yh56ZYGbup7d7NL2zxKV0D
	RRYBpe4sFlPYICLhD2j4KDKHQm7OLyvizFJFbxqTcIwHc8m3XdsaKaT8xVRmSkBxqybW+5
	GLT6YTlRHn9aqaRo48WaFObj3/OSJlo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ztl3pYp_OASramsPmBi6wQ-1; Wed, 02 Sep 2026 12:28:05 -0400
X-MC-Unique: ztl3pYp_OASramsPmBi6wQ-1
X-Mimecast-MFC-AGG-ID: ztl3pYp_OASramsPmBi6wQ_1788366484
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25148e933eso95256166b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366484; x=1788971284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgIwEmTiJ5LJ0RcSrKnCu3vSx10jRwcDN1IS812+2mo=;
        b=oc/F+y3M7A/OhZ7cACFqs1Y4kvEj8plvFywdy6vhLFgtsj3Q8+YDj7pCcY92h9hiCj
         aiWEMxEpRjGXkzVfiaer6RmqVXWSwJ73dmhden7fWQ/7l3RgcRPjqlF/ud0R5UFXSKRJ
         6OKcs5vWvHT4jBrDrn//R+6YpIiy0XVBHTNWp0X3o+ZMMnSFsX8/B297Lg8hvyFZKJ1y
         SokzzMQDXTr+3Xbu8uf1g3Sx9jp5OvDpQJtZnFvY9fuE/EqUB8MO8RaBoeZzaqjf8yuD
         7hrmWXv1hCx6dXpwOyWojoxctwFqbMH+4FuibN3TLq4Q+cNb7DDRhsUwPTxqCWNNhcF/
         LX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366484; x=1788971284;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgIwEmTiJ5LJ0RcSrKnCu3vSx10jRwcDN1IS812+2mo=;
        b=KANybxl+DXSbpXCa7JBfIr/HiltSmilRX5TcFFOfxJ5lr03RsaMlhf0xGSEdLCH242
         h4ijzxKWO4LbZDGTLpI+F8S4qhfwTCYXV7o6dSdXzdzIhqbDa39FjW8WqPq5MQ9X6zvl
         Tlv/9e7lJq2w3ziyp7GePyz9H5rC3wRnQbFq+RF5UD5vLNyeEzbquvMMaQ7biUz2nY3p
         3McvUd0vzqyXCg+nZSaJbJsiL1veL+cIknrOpR4nvwvCTEXYQZFJgjruOAsA6zsHjgqR
         WdCo6lah8cSOmes1QA8Xa0m/qIHQtr/FrjUn0HqgIiQ0pRQ4qGRvkdxmH7FcbphbjHbv
         2b+Q==
X-Gm-Message-State: AFuF++npTnHQT0TQiS1L8R4K2Z7/x1zAGz+yDlZOlu9jU+hdoQ+jEQ4t
	B3zEuXYRuIrWnInrcKBCCPhBxeAcHUjrn99kQ7CD1y1BjifzzBPwH8q9soE+8lnQfhpocG+ItjE
	q7p43yw2oCfqzXvCVp/Jj2o5Kqeq6Hr6cb4hRWY+US4SNu0ghLtCsRUmH9JDuWj/Xk3TM1WBMg9
	FirUiGvo0PlaB56TePBYOf3zaOI5keFUQfnD2oPfjrTKDa7sbh4w==
X-Gm-Gg: AYBFou3v/kM2vZ24yXoGoayOqNzikE4Z31YU9dtkFrF1HjInjxSyZKC5sltHmA4HSR5
	JmEFlpc0U+WvbSSOyRs63cxOceXOTNoh1jHgTd/N2znDk9nBNAri7iV4DC3QixaG8SuExcDvzjj
	wgOGsh2PlTLNSi3RzCdTRj6M6262QwvIpImi3PWIqtncdTvT5KOhV6LlXAlRCBBWjpRBzIL1AJ8
	5yYF69uw7XkHn9Ak8rrik+sZZ9X765SNmkLJGiu7JC4PTxSHcqj+WKkiUvximS+pFIMontP9zbu
	OgI+wuWdFUedOK5y2Ra7fsiEm4HpX01p5LFDYwr8F7//FovTMvt9dfc31kQKCiGfp5w+U9KvnSc
	7EV4JN/FB8+DCYNptdQrKVbIaB/DS94lKm4N/+0o7wSPhS7mKSvuZUn2mR50m6CX1xRe2nMWXCj
	RHFEEIXqLaJEAW3A==
X-Received: by 2002:a17:907:3e93:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c25d54e1bcbmr352773266b.17.1788366483021;
        Wed, 02 Sep 2026 09:28:03 -0700 (PDT)
X-Received: by 2002:a17:907:3e93:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c25d54e1bcbmr352763966b.17.1788366481883;
        Wed, 02 Sep 2026 09:28:01 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:01 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 00/14] ceph: add binary logging (BLOG) for CephFS
Date: Wed,  2 Sep 2026 16:27:46 +0000
Message-Id: <20260902162800.3197342-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a binary logging subsystem for the CephFS kernel
client.  On hot I/O paths every dout() call formats a printk-style
string even when nobody is reading the log.  After a client hang or
crash, operators often want the last slice of those messages without
having attached ftrace in advance.  BLOG is an opt-in flight recorder
for that corpus: it stores compact binary records keyed by a source-ID
and decodes them through debugfs.

It is not a replacement for Ceph tracepoints.  Tracepoints remain the
right interface for stable, structured events consumed by ftrace, perf,
and BPF.  Putting the dout corpus on tracepoints would mean a maintained
event schema for every internal debug line, mount identity in every
event, and a collector running before the failure.  BLOG keeps the
printf-style call sites, is enabled per mount, and retains recent
records for collection after the fact.

All new code lives under fs/ceph/ and include/linux/ceph/.  There are
no changes outside the Ceph subsystem.  BLOG objects are linked only
when CONFIG_DEBUG_FS=y (the only UI).  There is no CONFIG_CEPH_BLOG.
Runtime enablement is a per-mount debugfs knob and defaults to off.
When the static key is down, boutc() is doutc() -- one unlikely branch,
no formatting tax from BLOG.  When the key is up but this task has no
enter, boutc() still falls back to doutc().

Load-time module parameters blog_max_sources (default 4096) and
blog_max_clients (default 256) size the ID tables.  blog_max_full
(default 16) is the reader-visible full-magazine window.

Design
------

Record format.  Each record is a small header (timestamp delta from
the buffer base, source-ID, client-ID, payload length) plus serialized
arguments.  The format string lives in the source table, not in every
record.  Arguments are packed once; strings are length-delimited.
Decoding walks the source table and reconstructs text, including the
'#' flag for hex/octal.

Allocation.  Each logging task owns a 4K live buffer.  A page-fragment
allocator hands out slices without a global lock; freed buffers recycle
through per-CPU magazine batches, so the warm path does not allocate.
When the live buffer cannot fit the next record it is retired onto a
reader-visible snapshot list (fresh monotonic ID) and a new live buffer
is taken from the magazine or allocated.  On GFP_ATOMIC OOM the full
window is kept and only the new record is dropped -- the live buffer is
not wiped in place.  Wipe/reset happens on pool reuse or debugfs clear
(clear generation).  Sleepable first-touch uses GFP_NOFS.  Folio-locked
and other atomic callbacks (dirty_folio, invalidate_folio, write_end,
OSD writeback completion) use GFP_ATOMIC: reuse an existing context or
skip logging.  RCU-walk permission with MAY_NOT_BLOCK returns -ECHILD
before enter.

Source-ID caching.  Each (file, func, line, fmt) tuple is registered
once per logger into an open-addressed table and assigned a u32
source-ID.  A per-callsite cache avoids that lookup after the first
hit.  The cache is a seqcount_spinlock_t associated with its spinlock
so a PREEMPT_RT writer cannot livelock readers on an odd sequence.  A
generation counter on the logger prevents stale hits across
mount/unmount of the same callsite.

Per-superblock ownership.  Every mounted CephFS instance, including
-o noshare, gets its own blog_module_context and logger.  Enable,
buffers, source table, and debugfs are isolated per mount.  Client IDs
map (fsid, global_id) so decoded output can name the Ceph client.

Context propagation.  Binary records are only emitted while a task has
a bound blog_tls_ctx (enter_depth > 0).  ceph_blog_enter() acquires or
reuses that context from a task-keyed rhashtable and publishes it in a
per-CPU cache {task, ctx}.  The cache hit requires current, enter_depth,
and logger match; a miss refills from the map.  Plain enter does not
write current->journal_info, so ordinary VFS callbacks do not expose a
Ceph pointer to foreign filesystem reclaim and do not run the whole
operation under GFP_NOFS.

ceph_blog_enter_req() still installs a tagged ceph_journal_info for
the MDS fill-trace window (handle_reply -> ceph_fill_trace) so xattr
and security paths can see the in-flight mds_request.  That window is
already covered by memalloc_nofs_save().  Nested enter under fill-trace
may inherit mds_req; it still does not use journal_info as the BLOG
carrier.

Last module put never calls blog_module_free() in line (that path
cancel_delayed_work_sync's).  Free is queued on ceph_blog_free;
ceph_blog_fsc_cleanup and module exit flush the queue.  Dead-task GC
only collects pointers during rhashtable_walk; retire/sleep happens
after walk_stop.  Snapshot readers hold snapshot_mutex; a context is
unlinked from the reader list before it can be freed.

debugfs.  Per-client directory:

  /sys/kernel/debug/ceph/<client>/blog/enabled   # 0/1, default 0
  /sys/kernel/debug/ceph/<client>/blog/entries   # decoded records
  /sys/kernel/debug/ceph/<client>/blog/stats
  /sys/kernel/debug/ceph/<client>/blog/sources   # source-ID table
  /sys/kernel/debug/ceph/<client>/blog/clients
  /sys/kernel/debug/ceph/<client>/blog/clear     # write-only

Logging macros.  boutc() / boutc_bounded() / boutc_formats() replace
doutc() at CephFS call sites (fs/ceph/ only; they take fsc from
client->private).  boutc_formats() splits binary vs text backends
where %pd cannot be serialized.  Arguments are evaluated only after a
cached ctx is present.

Why BLOG
--------

When enabled, boutc() packs arguments into a 4K per-task ring instead of
running printk formatting on the hot path.  The format string lives in
the source table, not in every record, so the retained window is compact
enough to keep until after a hang.  Disabled, the static key is down and
boutc() is doutc(): one unlikely branch, no extra work.  Enablement is
per mount, so a debug session does not tax every CephFS superblock.

Stable events still belong on tracepoints.  BLOG is only for the existing
dout/doutc corpus: sites that churn with debug work, need a recent-record
dump without a collector attached in advance, and are too numerous to
promote one-for-one into TRACE_EVENT.

Patch breakdown
---------------

  01-06  BLOG infrastructure, one patch per compilation unit:
         private headers, deserializer, pagefrag allocator,
         magazine batcher, logger core, per-module context manager.

  07     Ceph BLOG scaffolding -- ceph_blog.h, blog_client.c,
         super.h / libceph.h additions, Makefile wiring
         (ceph-$(CONFIG_DEBUG_FS)).

  08     boutc macro definitions in ceph_debug.h.

  09     MDS fill-trace plumbing -- ceph_blog_enter_req() /
         ceph_blog_exit() around handle_reply's ceph_fill_trace().

  10     debugfs interface -- blog_debugfs.c and lifecycle hooks.

  11-14  Callsite conversions -- doutc -> boutc, grouped by
         subsystem: inodes+dirs, data I/O, caps+snaps, helpers.

Changes since v3
----------------

  - this is the v4 posting as a new thread; please ignore the
    earlier mail today that was In-Reply-To the v3 cover
  - rebase onto current ceph-client testing (folio writeback,
    ceph_in_snap(), ceph_ino()/ceph_vino(), mdsc->mutex in
    ceph_mds_check_access(), u32 time_warp_seq, dentry-caps
    drop_inode retention)
  - ceph_blog_free workqueue: add WQ_UNBOUND so v6.19's
    alloc_workqueue() warning is not hit (WQ_MEM_RECLAIM | WQ_UNBOUND)
  - visible magazine window is module parameter blog_max_full
    (default 16, sysfs-writable) instead of a compile-time 16
  - blog/entries: strip a trailing newline from reconstructed
    formats so seq_printf does not double-space lines

Changes since v2
----------------

  - move private headers under fs/ceph/; only the shared CephFS
    integration surface stays in include/linux/ceph/
  - no CONFIG_CEPH_BLOG; compile with CONFIG_DEBUG_FS
  - 4K buffers and rotate-on-full; snapshot inherits the live context
    ID (live takes the next ID) so blog/entries stays chronological;
    clear live before publishing; a failed log-batch put keeps the
    live window rather than wiping it
  - BLOG context is task-local (CPU cache on the hot path).
    journal_info + NOFS are only used for MDS fill-trace
  - GFP_ATOMIC enter on folio-locked a_ops; last module put defers
    free to a workqueue, umount/rmmod flush it
  - seqcount_spinlock_t for the source-id cache; GC does not sleep
    in the RCU walk
  - drop the kselftest patch from this posting
  - annotate lockless client_map[] reads with data_race(); document
    slot reuse rather than tearing

Alex Markuze (14):
  ceph: add BLOG private headers
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

 fs/ceph/Makefile                |   3 +
 fs/ceph/addr.c                  | 198 ++++---
 fs/ceph/blog.h                  | 220 +++++++
 fs/ceph/blog_batch.c            | 259 +++++++++
 fs/ceph/blog_batch.h            |  44 ++
 fs/ceph/blog_client.c           | 641 ++++++++++++++++++++
 fs/ceph/blog_core.c             | 257 +++++++++
 fs/ceph/blog_debugfs.c          | 686 ++++++++++++++++++++++
 fs/ceph/blog_des.c              | 335 +++++++++++
 fs/ceph/blog_des.h              |  16 +
 fs/ceph/blog_module.c           | 995 ++++++++++++++++++++++++++++++++
 fs/ceph/blog_module.h           |  42 ++
 fs/ceph/blog_pagefrag.c         |  62 ++
 fs/ceph/blog_pagefrag.h         |  27 +
 fs/ceph/blog_ser.h              | 234 ++++++++
 fs/ceph/caps.c                  | 112 ++--
 fs/ceph/crypto.c                |  14 +-
 fs/ceph/debugfs.c               |  11 +-
 fs/ceph/dir.c                   | 322 ++++++++---
 fs/ceph/export.c                |  83 ++-
 fs/ceph/file.c                  | 271 ++++++---
 fs/ceph/inode.c                 | 242 +++++---
 fs/ceph/locks.c                 |  66 ++-
 fs/ceph/mds_client.c            | 358 +++++++-----
 fs/ceph/snap.c                  |  17 +-
 fs/ceph/super.c                 |  58 +-
 fs/ceph/super.h                 |   7 +
 fs/ceph/xattr.c                 | 102 ++--
 include/linux/ceph/ceph_blog.h  | 292 ++++++++++
 include/linux/ceph/ceph_debug.h |  84 ++-
 include/linux/ceph/libceph.h    |   2 +
 31 files changed, 5423 insertions(+), 637 deletions(-)
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

Range-diff:
 1:  f048198bc28b !  1:  a88a37f81be5 ceph: add BLOG private headers
    @@ fs/ceph/blog.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Infrastructure (BLOG)
    -+ *
    -+ * Generic binary logging infrastructure for kernel subsystems.
    -+ * Modules maintain their own client mappings and debugfs interfaces.
    ++ * CephFS binary logging (BLOG) private types.
     + */
     +#ifndef _FS_CEPH_BLOG_H
     +#define _FS_CEPH_BLOG_H
    @@ fs/ceph/blog_batch.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Batch Management
    ++ * BLOG magazine batcher.
     + */
     +#ifndef _FS_CEPH_BLOG_BATCH_H
     +#define _FS_CEPH_BLOG_BATCH_H
    @@ fs/ceph/blog_des.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Deserialization
    ++ * BLOG record deserialization.
     + */
     +#ifndef _FS_CEPH_BLOG_DES_H
     +#define _FS_CEPH_BLOG_DES_H
    @@ fs/ceph/blog_module.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
    -+ *
    -+ * Each kernel module can have its own isolated logging context.
    -+ * Per-task context association uses an rhashtable keyed by task pointer.
    -+ * Entries hold task references until exit reaping or logger teardown.
    ++ * Per-superblock BLOG context and task-keyed rhashtable.
     + */
     +#ifndef _FS_CEPH_BLOG_MODULE_H
     +#define _FS_CEPH_BLOG_MODULE_H
    @@ fs/ceph/blog_pagefrag.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Page Fragment Management
    ++ * BLOG page-fragment allocator.
     + */
     +#ifndef _FS_CEPH_BLOG_PAGEFRAG_H
     +#define _FS_CEPH_BLOG_PAGEFRAG_H
    @@ fs/ceph/blog_ser.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0 */
     +/*
    -+ * Binary Logging Serialization
    ++ * BLOG argument packing.
     + */
     +#ifndef _FS_CEPH_BLOG_SER_H
     +#define _FS_CEPH_BLOG_SER_H
 2:  2243f9e892ce !  2:  4c24b2f04234 ceph: add BLOG deserialization support
    @@ fs/ceph/blog_des.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Binary Logging Deserialization
    ++ * BLOG record deserialization.
     + */
     +
     +#include "blog_des.h"
    @@ fs/ceph/blog_des.c (new)
     + * @size: Size of the buffer in bytes
     + * @out: Buffer to store the reconstructed string
     + * @out_size: Size of the output buffer
    -+ *
    -+ * Return: Number of bytes written to out buffer, or negative error code on failure
     + */
     +int blog_des_reconstruct(const char *fmt, const void *buffer,
     +			 size_t size, char *out, size_t out_size)
    @@ fs/ceph/blog_des.c (new)
     +
     +	*out_ptr = '\0';
     +
    -+	/* Process the format string */
     +	while (*fmt_ptr && remaining > 0) {
     +		int is_long;
     +		int is_long_long;
    @@ fs/ceph/blog_des.c (new)
     +		int dyn_precision = -1;
     +
     +		if (*fmt_ptr != '%') {
    -+			/* Copy literal character */
     +			*out_ptr++ = *fmt_ptr++;
     +			remaining--;
     +			continue;
     +		}
     +
    -+		/* Skip the '%' */
     +		fmt_ptr++;
     +
    -+		/* Handle %% */
     +		if (*fmt_ptr == '%') {
     +			*out_ptr++ = '%';
     +			fmt_ptr++;
    @@ fs/ceph/blog_des.c (new)
     +			continue;
     +		}
     +
    -+		/* Skip flags (-+#0 space); remember '#' for hex/octal (P1.10). */
    ++		/* Skip flags (-+#0 space); remember '#' for hex/octal. */
     +		while (*fmt_ptr && (*fmt_ptr == '-' || *fmt_ptr == '+' || *fmt_ptr == '#' ||
     +				   *fmt_ptr == '0' || *fmt_ptr == ' ')) {
     +			if (*fmt_ptr == '#')
    @@ fs/ceph/blog_des.c (new)
     +				is_long = 1;
     +		}
     +
    -+		/* Parse and handle format specifier */
     +		switch (*fmt_ptr) {
     +		case 's': {
     +			const char *str;
    @@ fs/ceph/blog_des.c (new)
     +		arg_count++;
     +	}
     +
    -+	/* Null-terminate the output */
     +	*out_ptr = '\0';
     +
     +	return out_ptr - out;
 3:  b00fb0bec0de <  -:  ------------ ceph: add BLOG page-fragment allocator
 -:  ------------ >  3:  8667935d30a9 ceph: add BLOG page-fragment allocator
 4:  655f71ca4eed !  4:  8babcc520b0c ceph: add BLOG magazine batch allocator
    @@ Commit message
         ceph: add BLOG magazine batch allocator
     
         Add blog_batch.c: per-CPU magazine batching for TLS context recycling.
    -    Freed composites go to a local magazine; subsequent acquisitions reclaim
    -    from the magazine, making the common-case log path allocation-free.
    +    Freed composites go to a local magazine; subsequent acquisitions
    +    reclaim from the magazine without allocating.
     
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
    @@ fs/ceph/blog_batch.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Binary Logging Batch Management
    -+ *
    -+ * Magazine-based batching for efficient object recycling.
    ++ * Per-CPU magazine batching for BLOG TLS context recycling.
     + */
     +
     +#include <linux/slab.h>
    @@ fs/ceph/blog_batch.c (new)
     +{
     +	struct blog_magazine *mag;
     +
    -+	/* Allocate magazine structure from cache */
     +	mag = kmem_cache_zalloc(batch->magazine_cache, gfp);
     +	if (!mag)
     +		return NULL;
    @@ fs/ceph/blog_batch.c (new)
     +	int i;
     +	struct blog_tls_pagefrag *composite;
     +
    -+	/* Free all composites in this magazine before freeing magazine itself */
     +	for (i = 0; i < mag->count; i++) {
     +		composite = mag->elements[i];
     +		if (composite)
     +			kvfree_atomic(composite);
     +	}
     +
    -+	/* Free the magazine structure itself */
     +	kmem_cache_free(batch->magazine_cache, mag);
     +}
     +
    @@ fs/ceph/blog_batch.c (new)
     + * @nr_prealloc: Number of composites to preallocate (0 = none)
     + * @retain_limit: Max composites to retain on put; excess are freed (0 = unlimited)
     + *
    -+ * Allocates and initializes the per-CPU magazines and global pools.
    -+ * Composites are allocated via kvzalloc() in BLOG_MAGAZINE_SIZE
    -+ * batches.  Pass nr_prealloc = 0 for batches that start empty
    -+ * (e.g. the log_batch).
    -+ *
    -+ * Return: 0 on success, negative error code on failure
    ++ * Pass nr_prealloc = 0 for batches that start empty (e.g. log_batch).
     + */
     +int blog_batch_init(struct blog_batch *batch, struct kmem_cache *mag_cache,
     +		    unsigned int nr_prealloc, unsigned int retain_limit)
    @@ fs/ceph/blog_batch.c (new)
     +	struct blog_magazine *mag;
     +	struct blog_tls_pagefrag *composite;
     +
    -+	/* Initialize counters */
     +	batch->nr_full = 0;
     +	batch->nr_empty = 0;
     +	batch->retain_limit = retain_limit;
     +
    -+	/* Use caller-provided cache or create one */
     +	if (mag_cache) {
     +		batch->magazine_cache = mag_cache;
     +		batch->external_cache = true;
    @@ fs/ceph/blog_batch.c (new)
     +		batch->external_cache = false;
     +	}
     +
    -+	/* Initialize global magazine lists */
     +	INIT_LIST_HEAD(&batch->full_magazines);
     +	INIT_LIST_HEAD(&batch->empty_magazines);
     +	raw_spin_lock_init(&batch->full_lock);
     +	raw_spin_lock_init(&batch->empty_lock);
     +
    -+	/* Allocate per-CPU magazines */
     +	batch->cpu_magazines = alloc_percpu(struct blog_cpu_magazine);
     +	if (!batch->cpu_magazines)
     +		goto cleanup_cache;
     +
    -+	/* Initialize per-CPU magazines to NULL (magazines allocated on-demand) */
     +	for_each_possible_cpu(cpu) {
     +		cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
     +		cpu_mag->mag = NULL;
     +	}
     +
    -+	/* Pre-populate magazines with composites */
     +	nr_mags = DIV_ROUND_UP(nr_prealloc, BLOG_MAGAZINE_SIZE);
     +	for (i = 0; i < nr_mags; i++) {
     +		mag = alloc_magazine(batch, GFP_KERNEL);
    @@ fs/ceph/blog_batch.c (new)
     +	return -ENOMEM;
     +}
     +
    -+/**
    -+ * blog_batch_cleanup - Clean up the batching system
    -+ * @batch: Batch structure to clean up
    -+ *
    -+ * Frees all magazines and composites, and destroys the magazine cache.
    -+ */
     +void blog_batch_cleanup(struct blog_batch *batch)
     +{
     +	int cpu;
     +	struct blog_magazine *mag, *tmp;
     +	struct blog_cpu_magazine *cpu_mag;
     +
    -+	/* Free per-CPU magazines */
     +	if (batch->cpu_magazines) {
     +		for_each_possible_cpu(cpu) {
     +			cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
    @@ fs/ceph/blog_batch.c (new)
     +		free_percpu(batch->cpu_magazines);
     +	}
     +
    -+	/* Free magazines in the full pool */
     +	raw_spin_lock(&batch->full_lock);
     +	list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) {
     +		list_del(&mag->list);
    @@ fs/ceph/blog_batch.c (new)
     +	}
     +	raw_spin_unlock(&batch->full_lock);
     +
    -+	/* Free magazines in the empty pool */
     +	raw_spin_lock(&batch->empty_lock);
     +	list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list) {
     +		list_del(&mag->list);
    @@ fs/ceph/blog_batch.c (new)
     +	}
     +	raw_spin_unlock(&batch->empty_lock);
     +
    -+	/* Destroy magazine cache */
     +	if (!batch->external_cache && batch->magazine_cache)
     +		kmem_cache_destroy(batch->magazine_cache);
     +
    @@ fs/ceph/blog_batch.c (new)
     +	batch->external_cache = false;
     +}
     +
    -+/**
    -+ * blog_batch_get - Get an element from the batch
    -+ * @batch: Batch to get element from
    -+ *
    -+ * Return: Element from the magazine, or NULL if none available
    -+ */
     +void *blog_batch_get(struct blog_batch *batch)
     +{
     +	struct blog_cpu_magazine *cpu_mag;
    @@ fs/ceph/blog_batch.c (new)
     +	preempt_disable();
     +	cpu_mag = this_cpu_ptr(batch->cpu_magazines);
     +
    -+	/* If we have a magazine and it has elements, use it */
     +	if (cpu_mag->mag && cpu_mag->mag->count > 0) {
     +		element = cpu_mag->mag->elements[--cpu_mag->mag->count];
     +		goto out;
     +	}
     +
    -+	/* Current magazine is empty, try to get a full one */
     +	old_mag = cpu_mag->mag;
     +
    -+	/* Return old magazine to empty pool if we have one */
     +	if (old_mag) {
     +		raw_spin_lock(&batch->empty_lock);
     +		list_add(&old_mag->list, &batch->empty_magazines);
    @@ fs/ceph/blog_batch.c (new)
     +	}
     +
     +	if (READ_ONCE(batch->nr_full) > 0) {
    -+		/* Try to get a full magazine */
     +		raw_spin_lock(&batch->full_lock);
     +		if (!list_empty(&batch->full_magazines)) {
     +			new_mag = list_first_entry(&batch->full_magazines,
    @@ fs/ceph/blog_batch.c (new)
     +	return element;
     +}
     +
    -+/**
    -+ * blog_batch_put - Put an element back into the batch
    -+ * @batch: Batch to put element into
    -+ * @element: Element to put back
    -+ *
    -+ * Return: true if the batch retained the element, false otherwise
    -+ */
     +bool blog_batch_put(struct blog_batch *batch, void *element)
     +{
     +	struct blog_cpu_magazine *cpu_mag;
    @@ fs/ceph/blog_batch.c (new)
     +	preempt_disable();
     +	cpu_mag = this_cpu_ptr(batch->cpu_magazines);
     +
    -+	/* Optimistically try to add to current magazine */
     +	if (likely(cpu_mag->mag && cpu_mag->mag->count < BLOG_MAGAZINE_SIZE)) {
     +		cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
     +		goto out;
     +	}
     +
    -+	/* If current magazine is full, move it to full pool */
     +	if (likely(cpu_mag->mag && cpu_mag->mag->count >= BLOG_MAGAZINE_SIZE)) {
     +		raw_spin_lock(&batch->full_lock);
     +		list_add_tail(&cpu_mag->mag->list, &batch->full_magazines);
    @@ fs/ceph/blog_batch.c (new)
     +		cpu_mag->mag = NULL;
     +	}
     +
    -+	/* Get new magazine if needed */
     +	if (likely(!cpu_mag->mag)) {
    -+		/* Try to get from empty pool first */
     +		raw_spin_lock(&batch->empty_lock);
     +		if (!list_empty(&batch->empty_magazines)) {
     +			mag = list_first_entry(&batch->empty_magazines,
    @@ fs/ceph/blog_batch.c (new)
     +			goto out;
     +		}
     +	}
    -+	/* Add element to magazine */
     +	cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
     +out:
     +	preempt_enable();
 5:  5758a7dd8e71 !  5:  18135902d8f2 ceph: add BLOG logger core
    @@ fs/ceph/blog_core.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Binary Logging Infrastructure - Core Implementation
    -+ *
    -+ * Per-module logger instances, source-ID registration, log-entry
    -+ * reservation/commit, and pagefrag-based context management.
    ++ * BLOG logger: source-ID registry and log iteration.
     + */
     +
     +#include <linux/module.h>
    @@ fs/ceph/blog_core.c (new)
     + * @func: Function name
     + * @line: Line number
     + * @fmt: Format string
    -+ *
    -+ * Returns a unique ID for this source location
     + */
     +u32 blog_get_source_id(struct blog_logger *logger, const char *file,
     +		       const char *func, unsigned int line, const char *fmt)
    @@ fs/ceph/blog_core.c (new)
     +	return sid;
     +}
     +
    -+/**
    -+ * blog_get_source_info - Get source info for a given ID
    -+ * @id: Source ID
    -+ *
    -+ * Returns the source information for this ID
    -+ */
     +struct blog_source_info *blog_get_source_info(struct blog_logger *logger, u32 id)
     +{
     +	if (!logger || unlikely(id == 0 || id >= logger->max_source_ids))
    @@ fs/ceph/blog_core.c (new)
     +	return &logger->source_map[id];
     +}
     +
    -+/**
    -+ * blog_log_iter_init - Initialize the iterator for a specific pagefrag
    -+ */
     +void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pagefrag *pf,
     +			u64 head_snapshot)
     +{
    @@ fs/ceph/blog_core.c (new)
     +	iter->steps = 0;
     +}
     +
    -+/**
    -+ * blog_log_iter_next - Get next log entry
    -+ */
     +struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *iter)
     +{
     +	struct blog_log_entry *entry;
    @@ fs/ceph/blog_core.c (new)
     +	return entry;
     +}
     +
    -+/**
    -+ * blog_des_entry - Deserialize entry with callback
    -+ */
     +int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entry,
     +		   char *output, size_t out_size, blog_client_des_fn client_cb)
     +{
    @@ fs/ceph/blog_core.c (new)
     +	if (!entry || !output)
     +		return -EINVAL;
     +
    -+	/* Let module handle client_id if callback provided */
     +	if (client_cb) {
     +		len = client_cb(output, out_size, entry->client_id);
     +		if (len < 0)
    @@ fs/ceph/blog_core.c (new)
     +			return len;
     +	}
     +
    -+	/* Get source info */
     +	source = blog_get_source_info(logger, entry->source_id);
     +	if (!source) {
     +		len += scnprintf(output + len, out_size - len,
 6:  f02df3b34736 !  6:  5fd13e885c2f ceph: add BLOG per-module context management
    @@ Commit message
         ceph: add BLOG per-module context management
     
         Add blog_module.c: per-superblock rhashtable mapping tasks to
    -    blog_task_entry structures, with context acquire/release and safe
    +    blog_task_entry structures, with context acquire/release and
         retirement that clears the RETIRED bit on removal failure.
     
    -    Task references pin hash keys until periodic dead-task collection or
    -    logger teardown.  Retired buffers remain reader-visible until the
    -    bounded retention batches reclaim them.  Filesystem-reachable allocation
    -    paths use GFP_NOFS to avoid reclaim recursion.
    -
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
      ## fs/ceph/blog_module.c (new) ##
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
    -+ *
    -+ * Per-task context association via rhashtable keyed by task pointer.
    -+ * Task references keep keys stable until periodic exit reaping removes them.
    ++ * Per-superblock BLOG context. Tasks map to TLS contexts via rhashtable.
    ++ * Task references keep keys stable until exit reaping removes them.
     + */
     +
     +#include <linux/module.h>
    @@ fs/ceph/blog_module.c (new)
     +static void blog_module_free_workfn(struct work_struct *work);
     +
     +#define BLOG_LOG_BATCH_MAX_FULL 16
    ++#define BLOG_LOG_BATCH_MAX_FULL_CAP 1024
     +#define BLOG_MAX_TASK_CONTEXTS 64
     +#define BLOG_TASK_GC_INTERVAL (5 * HZ)
     +#define BLOG_TASK_ENTRY_RETIRED 0
     +
    -+/* --- rhashtable parameters for task -> context mapping --- */
    ++static int blog_max_full = BLOG_LOG_BATCH_MAX_FULL;
    ++module_param_named(blog_max_full, blog_max_full, int, 0644);
    ++MODULE_PARM_DESC(blog_max_full,
    ++		 "Visible full-magazine count for BLOG entries (default 16)");
    ++
    ++static unsigned int blog_param_max_full(void)
    ++{
    ++	int n = READ_ONCE(blog_max_full);
    ++
    ++	if (n < 1)
    ++		n = 1;
    ++	if (n > BLOG_LOG_BATCH_MAX_FULL_CAP)
    ++		n = BLOG_LOG_BATCH_MAX_FULL_CAP;
    ++	return n;
    ++}
     +
     +static const struct rhashtable_params blog_task_ht_params = {
     +	.key_offset = offsetof(struct blog_task_entry, task),
    @@ fs/ceph/blog_module.c (new)
     +	.automatic_shrinking = true,
     +};
     +
    -+/* --- helper: recycle a TLS context back to the magazine batches --- */
    -+
     +static void blog_module_free_magazine(struct blog_logger *logger,
     +				      struct blog_magazine *mag)
     +{
    @@ fs/ceph/blog_module.c (new)
     +	struct blog_magazine *mag;
     +	bool retain;
     +
    -+	if (!logger || logger->log_batch.nr_full <= BLOG_LOG_BATCH_MAX_FULL)
    ++	if (!logger || logger->log_batch.nr_full <= blog_param_max_full())
     +		return;
     +
     +	raw_spin_lock(&logger->log_batch.full_lock);
    @@ fs/ceph/blog_module.c (new)
     +	}
     +	mutex_unlock(&logger->snapshot_mutex);
     +
    -+	while (logger->log_batch.nr_full > BLOG_LOG_BATCH_MAX_FULL)
    ++	while (logger->log_batch.nr_full > blog_param_max_full())
     +		blog_module_rebalance_log_batch(logger);
     +
     +	spin_lock(&logger->lock);
    @@ fs/ceph/blog_module.c (new)
     +	/*
     +	 * Only task-map contexts are charged against allocated_contexts.
     +	 * Rotate-on-full snap buffers share this recycle path but were
    -+	 * never counted — do not let them underflow the 64-task cap.
    ++	 * never counted. Do not let them underflow the 64-task cap.
     +	 */
     +	if (test_and_clear_bit(BLOG_CTX_TASK_COUNTED, &ctx->flags) &&
     +	    logger->owner_ctx)
    @@ fs/ceph/blog_module.c (new)
     +	blog_module_queue_to_log_batch(logger, ctx);
     +}
     +
    -+/* --- task-entry lifecycle --- */
    -+
     +/*
     + * Retire a stale rhashtable entry: remove it from the hash table, retain its
     + * TLS context on the reader-visible list while the log batch owns it, and
    @@ fs/ceph/blog_module.c (new)
     +	return tls_ctx;
     +}
     +
    -+/* --- public module API --- */
    -+
     +struct blog_module_context *blog_module_init(const char *module_name)
     +{
     +	struct blog_module_context *ctx;
    @@ fs/ceph/blog_module.c (new)
     +	if (!logger)
     +		return;
     +
    -+
     +	WRITE_ONCE(logger->task_gc_stopping, true);
     +	cancel_delayed_work_sync(&logger->task_gc_work);
     +	cancel_work_sync(&logger->reclaim_work);
     +
    -+	/* Drain the task hash table */
     +	rhashtable_free_and_destroy(&logger->task_map,
     +				    blog_task_entry_free_cb, logger);
     +
    @@ fs/ceph/blog_module.c (new)
     +	blog_module_free(ctx);
     +}
     +
    -+/* --- per-task context acquisition (rhashtable-based) --- */
    -+
     +static void blog_discard_unmapped_ctx(struct blog_logger *logger,
     +				      struct blog_tls_ctx *tls_ctx)
     +{
    @@ fs/ceph/blog_module.c (new)
     +{
     +	if (blog_free_wq)
     +		return 0;
    -+	blog_free_wq = alloc_workqueue("ceph_blog_free", WQ_MEM_RECLAIM, 0);
    ++	blog_free_wq = alloc_workqueue("ceph_blog_free",
    ++				       WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
     +	return blog_free_wq ? 0 : -ENOMEM;
     +}
     +
    @@ fs/ceph/blog_module.c (new)
     +	blog_free_wq = NULL;
     +}
     +
    -+/* --- blog_log_with_ctx / blog_log_commit_with_ctx --- */
    -+
     +/*
     + * Retire the live buffer's published records into a reader-visible
     + * snapshot, then reset the live pagefrag so logging can continue.
    @@ fs/ceph/blog_module.c (new)
     +	if (!logger || !tls_ctx)
     +		return -EINVAL;
     +
    -+	/* Validate that actual_size fits within the reservation */
     +	total_size = round_up(sizeof(struct blog_log_entry) + actual_size, 8);
     +	if (total_size > tls_ctx->pending_size) {
     +		tls_ctx->pending_offset = 0;
 7:  45f84fa4b82d !  7:  198bf57e5058 ceph: add Ceph BLOG scaffolding
    @@ Commit message
         (blog_enabled, blog_ctx, debugfs_blog), libceph.h (blog_client_id),
         and Makefile (gate all BLOG objects on CONFIG_DEBUG_FS).
     
    -    Runtime enablement remains per-mount via debugfs. Load-time module
    -    parameters size the source and client ID tables.
    -
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
      ## fs/ceph/Makefile ##
    @@ fs/ceph/blog_client.c (new)
     +	       !data_race(memchr_inv(entry->fsid, 0, sizeof(entry->fsid)));
     +}
     +
    -+/**
    -+ * ceph_blog_init - Initialize Ceph BLOG integration
    -+ *
    -+ * Initializes the shared client ID mapping state used by per-superblock
    -+ * BLOG instances.
    -+ *
    -+ * Return: 0 on success, negative error code on failure
    -+ */
     +int ceph_blog_init(void)
     +{
     +	u32 max_clients;
    @@ fs/ceph/blog_client.c (new)
     +	return 0;
     +}
     +
    -+/**
    -+ * ceph_blog_cleanup - Clean up Ceph BLOG integration
    -+ *
    -+ * Cleans up Ceph's module-specific BLOG context and client mappings.
    -+ */
     +void ceph_blog_cleanup(void)
     +{
     +	void *client_map = NULL;
    @@ fs/ceph/blog_client.c (new)
     +	if (!gfpflags_allow_blocking(gfp)) {
     +		/*
     +		 * Non-blocking: reuse an existing per-task ctx only.  Do not
    -+		 * pin the module until lookup hits — a miss must not call
    ++		 * pin the module until lookup hits. A miss must not call
     +		 * blog_module_put(), which can sleep in blog_module_free().
     +		 */
     +		tls_ctx = blog_lookup_tls_ctx(ctx);
    @@ fs/ceph/blog_client.c (new)
     +	}
     +
     +hold:
    -+	/* Keep the module ref for the enter→exit window; put via blog_mod. */
    ++	/* Keep the module ref for the enter-exit window; put via blog_mod. */
     +	if (held_mod)
     +		*held_mod = ctx;
     +	else
    @@ fs/ceph/blog_client.c (new)
     +
     +	/*
     +	 * Publish into the per-CPU cache under preempt_disable only.
    -+	 * Do not migrate_disable() across the enter→exit window: on !RT
    ++	 * Do not migrate_disable() across the enter-exit window: on !RT
     +	 * that is preempt_disable and would leave preempt elevated for
     +	 * the whole VFS call.  Keep each ctx on at most one CPU slot:
     +	 * clear the prior publish before installing the new one.
    @@ fs/ceph/blog_client.c (new)
     +		if (READ_ONCE(ctx->task) == current &&
     +		    READ_ONCE(ctx->enter_depth) &&
     +		    ctx->logger == want_logger)
    -+			; /* hit — mount-scoped */
    ++			; /* hit. Mount-scoped */
     +		else {
     +			WRITE_ONCE(c->task, NULL);
     +			WRITE_ONCE(c->ctx, NULL);
    @@ fs/ceph/blog_client.c (new)
     +	 * Cache miss after preemption.  Prefer the mount-scoped
     +	 * journal_info ctx when it matches @fsc so nested multi-mount
     +	 * work does not attach to another mount's logger.  Plain
    -+	 * ceph_blog_enter() never installs journal_info — recover only
    ++	 * ceph_blog_enter() never installs journal_info. Recover only
     +	 * from @fsc's own task map (not a cross-mount module-list walk).
     +	 */
     +	ji = ceph_ji_from_current();
    @@ fs/ceph/blog_client.c (new)
     + *
     + * Returns the actual ID of the pair. If the given ID doesn't match, scans for
     + * existing matches or allocates a new ID if no match is found.
    -+ *
    -+ * Return: Client ID for this fsid/global_id pair
     + */
     +u32 ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_id)
     +{
    @@ fs/ceph/blog_client.c (new)
     +	struct ceph_blog_client_info *entry;
     +
     +	if (unlikely(!ceph_blog_state.initialized)) {
    -+		WARN_ON_ONCE(1);  /* Should never happen - init_ceph() initializes BLOG */
    -+		return 0;  /* Drop the log entry */
    ++		WARN_ON_ONCE(1);
    ++		return 0;
     +	}
     +
     +	spin_lock(&ceph_blog_state.lock);
     +	max_clients = ceph_blog_state.max_clients;
     +
    -+	/* Reuse caller-provided hint when it still matches */
     +	if (id != 0 && id < max_clients) {
     +		entry = &ceph_blog_state.client_map[id];
     +		if (ceph_blog_ids_match(entry, fsid, global_id)) {
    @@ fs/ceph/blog_client.c (new)
     +		}
     +	}
     +
    -+	/* Search for an existing entry with matching identity */
     +	for (id = 1; id < max_clients; id++) {
     +		entry = &ceph_blog_state.client_map[id];
     +		if (ceph_blog_ids_match(entry, fsid, global_id)) {
    @@ fs/ceph/blog_client.c (new)
     +		}
     +	}
     +
    -+	/* Assign new identifier; reuse freed slots before failing */
     +	if (ceph_blog_state.next_client_id < max_clients) {
     +		found_id = ceph_blog_state.next_client_id++;
     +	} else {
    @@ fs/ceph/blog_client.c (new)
     + * Writers store fields under the lock. Callers accept the benign
     + * race: a concurrent slot release and reuse may cause old log
     + * entries to show a new client's identity; the impact is cosmetic.
    -+ *
    -+ * Return: Client information for this ID, or NULL if invalid
     + */
     +const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 id)
     +{
    @@ fs/ceph/blog_client.c (new)
     +	return entry;
     +}
     +
    -+/**
    -+ * ceph_blog_client_des_callback - Deserialization callback for Ceph client info
    -+ * @buf: Output buffer
    -+ * @size: Buffer size
    -+ * @client_id: Client ID to deserialize
    -+ *
    -+ * This is the callback that BLOG will use to deserialize client information.
    -+ *
    -+ * Return: Number of bytes written to buffer
    -+ */
     +int ceph_blog_client_des_callback(char *buf, size_t size, u8 client_id)
     +{
     +	const struct ceph_blog_client_info *info;
    @@ fs/ceph/blog_client.c (new)
     +
     +	global_id = data_race(info->global_id);
     +	data_race(memcpy(fsid, info->fsid, sizeof(fsid)));
    -+	/* Use %pU to format fsid, matching boutc and other Ceph client logging */
     +	return snprintf(buf, size, "[%pU %llu] ", fsid, global_id);
     +}
     +
    -+/**
    -+ * ceph_blog_get_client_id - Get or allocate client ID for a Ceph client
    -+ * @client: Ceph client structure
    -+ *
    -+ * Return: Client ID for this client
    -+ */
     +u32 ceph_blog_get_client_id(struct ceph_client *client)
     +{
     +	u32 cached;
    @@ include/linux/ceph/ceph_blog.h (new)
     + *       acquires only reuse an existing per-task context; first-touch
     + *       allocation is skipped and logging is a no-op for that enter.
     + *
    -+ * Option C: BLOG state lives in the per-task map (+ CPU cache).  Plain VFS
    -+ * enters never publish into current->journal_info.  Only enter_req (MDS
    ++ * BLOG state lives in the per-task map and CPU cache.  Plain VFS enters
    ++ * never publish into current->journal_info.  Only enter_req (MDS
     + * fill-trace, which already runs under memalloc_nofs_save) installs the
     + * tagged carrier so xattr paths can see mds_req.
     + */
 8:  ec5c411f64f3 =  8:  a936734b5d86 ceph: add bout and boutc wrappers for BLOG
 9:  79ee84e3168c !  9:  aa203cbe62da ceph: switch MDS request plumbing to struct ceph_journal_info
    @@ fs/ceph/mds_client.c: static int trim_caps_cb(struct inode *inode, int mds, void
     -			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
     +			boutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
      			      inode, ceph_vinop(inode), cap, count);
    - 		} else {
    - 			dput(dentry);
    + 		}
    + 		return 0;
     @@ fs/ceph/mds_client.c: int ceph_trim_caps(struct ceph_mds_client *mdsc,
      	struct ceph_client *cl = mdsc->fsc->client;
      	int trim_caps = session->s_nr_caps - max_caps;
    @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_client *mdsc, ch
     +	boutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
      	      tpath, mask, caller_uid, caller_gid);
      
    - 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
    + 	mutex_lock(&mdsc->mutex);
     @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
      
      	put_cred(cred);
    @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_client *mdsc, ch
     +	boutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
      	      rw_perms_s);
      	if (root_squash_perms && rw_perms_s == NULL) {
    + 		mutex_unlock(&mdsc->mutex);
     -		doutc(cl, "access allowed\n");
     +		boutc(cl, "access allowed\n");
      		return 0;
    @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_client *mdsc, ch
      	}
     -	doutc(cl, "access denied\n");
     +	boutc(cl, "access denied\n");
    + 	mutex_unlock(&mdsc->mutex);
      	return -EACCES;
      }
    - 
     @@ fs/ceph/mds_client.c: int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
       */
      void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
10:  1ce9ea0e36ff ! 10:  7f3cc903af71 ceph: add BLOG debugfs interface
    @@ Commit message
         Add blog_debugfs.c: per-superblock debugfs files under
         /sys/kernel/debug/ceph/<fsid>/blog/ (entries, stats, sources,
         clients, enable, clear).  Wire lifecycle hooks in super.c and
    -    debugfs.c.  Readers use smp_load_acquire() on pf->head to pair
    -    with writers' smp_store_release() publication.
    +    debugfs.c.
     
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
    @@ fs/ceph/blog_debugfs.c (new)
     @@
     +// SPDX-License-Identifier: GPL-2.0
     +/*
    -+ * Ceph BLOG debugfs interface
    -+ *
    -+ * Provides debugfs entries to view and manage BLOG entries for Ceph
    ++ * Ceph BLOG debugfs.
     + */
     +
     +#include <linux/ceph/ceph_debug.h>
    @@ fs/ceph/blog_debugfs.c (new)
     +}
     +
     +/**
    -+ * blog_entries_show - Show all BLOG entries for Ceph
    -+ *
    -+ * Iterates through all contexts, deserializing their pagefrag entries.
    ++ * blog_entries_show - dump decoded records
     + *
    -+ * To avoid holding logger->lock for the entire (potentially large)
    -+ * iteration, we use an ID-cursor: each pass finds the next context by
    -+ * ascending ID, drops logger->lock, and snapshots only its published bytes
    -+ * under pf->lock.  snapshot_mutex keeps retained contexts from being
    -+ * reclaimed between the list lookup and the snapshot.
    ++ * ID-cursor walk: each pass finds the next context by ascending ID, drops
    ++ * logger->lock, and snapshots only its published bytes under pf->lock.
    ++ * snapshot_mutex keeps retained contexts from being reclaimed between the
    ++ * list lookup and the snapshot.
     + */
     +static int blog_entries_show(struct seq_file *s, void *p)
     +{
    @@ fs/ceph/blog_debugfs.c (new)
     +		u64 head;
     +		int ret;
     +
    -+		/* Find the next context by ascending ID */
     +		mutex_lock(&logger->snapshot_mutex);
     +		spin_lock(&logger->lock);
     +		list_for_each_entry(ctx, &logger->contexts, list) {
    @@ fs/ceph/blog_debugfs.c (new)
     +		 * snapshot and give this ctx a new id.  Any id mismatch
     +		 * means this copy is not the retired window; leave the
     +		 * cursor so the next walk finds the snapshot.  Do not
    -+		 * advance just because head is non-zero — that may be
    ++		 * advance just because head is non-zero. That may be
     +		 * the *new* live tail.
     +		 */
     +		spin_lock(&logger->lock);
    @@ fs/ceph/blog_debugfs.c (new)
     +			if (jiffies_to_formatted_time(entry_jiffies, time_buf,
     +						      sizeof(time_buf)) < 0)
     +				strscpy(time_buf, "(invalid)", sizeof(time_buf));
    ++			if (ret > 0 && output_buf[ret - 1] == '\n')
    ++				output_buf[ret - 1] = '\0';
     +			seq_printf(s, "%s %s\n", time_buf, output_buf);
     +		}
     +	}
    @@ fs/ceph/blog_debugfs.c (new)
     +	.release = blog_dbg_release,
     +};
     +
    -+/**
    -+ * blog_stats_show - Show BLOG statistics
    -+ */
     +static int blog_stats_show(struct seq_file *s, void *p)
     +{
     +	struct blog_dbg_file *priv = s->private;
    @@ fs/ceph/blog_debugfs.c (new)
     +	.release = blog_dbg_release,
     +};
     +
    -+/**
    -+ * blog_sources_show - Show all registered source locations
    -+ */
     +static int blog_sources_show(struct seq_file *s, void *p)
     +{
     +	struct blog_dbg_file *priv = s->private;
    @@ fs/ceph/blog_debugfs.c (new)
     +	.release = blog_dbg_release,
     +};
     +
    -+/**
    -+ * blog_clients_show - Show all registered Ceph clients
    -+ */
     +static int blog_clients_show(struct seq_file *s, void *p)
     +{
     +	struct blog_dbg_file *priv = s->private;
    @@ fs/ceph/blog_debugfs.c (new)
     +	.release = blog_dbg_release,
     +};
     +
    -+/**
    -+ * blog_clear_write - Clear all BLOG entries (write-only)
    -+ */
     +static ssize_t blog_clear_write(struct file *file, const char __user *buf,
     +				size_t count, loff_t *ppos)
     +{
    @@ fs/ceph/blog_debugfs.c (new)
     +	.llseek = generic_file_llseek,
     +};
     +
    -+/**
    -+ * ceph_blog_debugfs_init - Initialize Ceph BLOG debugfs entries
    -+ * @fsc: CephFS client whose debugfs directory hosts BLOG entries
    -+ *
    -+ * Return: 0 on success, negative error code on failure
    -+ */
     +int ceph_blog_debugfs_init(struct ceph_fs_client *fsc)
     +{
     +	struct dentry *dir;
    @@ fs/ceph/blog_debugfs.c (new)
     +		return PTR_ERR(dir);
     +	fsc->debugfs_blog = dir;
     +
    -+	/* Create debugfs entries */
     +	debugfs_create_file("enabled", 0600, fsc->debugfs_blog, fsc,
     +			    &blog_enabled_fops);
     +	debugfs_create_file("entries", 0444, fsc->debugfs_blog, fsc,
    @@ fs/ceph/blog_debugfs.c (new)
     +	return 0;
     +}
     +
    -+/**
    -+ * ceph_blog_debugfs_cleanup - Clean up Ceph BLOG debugfs entries
    -+ * @fsc: CephFS client whose BLOG debugfs directory should be removed
    -+ */
     +void ceph_blog_debugfs_cleanup(struct ceph_fs_client *fsc)
     +{
     +	if (!fsc || !fsc->debugfs_blog)
11:  ffbfd6fc63e4 ! 11:  223c11d37e7b ceph: convert VFS inode and directory paths to bout
    @@ fs/ceph/dir.c: static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
     +
     +	ceph_blog_enter(fsc, &__ji);
      
    --	if (ceph_snap(dir) != CEPH_NOSNAP)
    -+	if (ceph_snap(dir) != CEPH_NOSNAP) {
    +-	if (ceph_in_snap(dir))
    ++	if (ceph_in_snap(dir)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
    @@ fs/ceph/dir.c: static int ceph_symlink(struct mnt_idmap *idmap, struct inode *di
      	int err;
     +	struct ceph_journal_info __ji;
      
    --	if (ceph_snap(dir) != CEPH_NOSNAP)
    +-	if (ceph_in_snap(dir))
     +	ceph_blog_enter(fsc, &__ji);
     +
    -+	if (ceph_snap(dir) != CEPH_NOSNAP) {
    ++	if (ceph_in_snap(dir)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
    @@ fs/ceph/dir.c: static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct
     +			      "mksnap %llx.%llx/'%pd' dentry %p\n",
     +			      (ceph_vinop(dir), dentry->d_name.name, dentry),
     +			      (ceph_vinop(dir), dentry, dentry));
    - 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
    + 	} else if (!ceph_in_snap(dir)) {
     -		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
     -		      ceph_vinop(dir), dentry, dentry, mode);
     +		boutc_formats(cl, "mkdir %llx.%llx/'%s' dentry %p mode 0%ho\n",
    @@ fs/ceph/dir.c: static int ceph_link(struct dentry *old_dentry, struct inode *dir
      		return err;
     +	}
      
    --	if (ceph_snap(dir) != CEPH_NOSNAP)
    -+	if (ceph_snap(dir) != CEPH_NOSNAP) {
    +-	if (ceph_in_snap(dir))
    ++	if (ceph_in_snap(dir)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
    @@ fs/ceph/dir.c: static int ceph_unlink(struct inode *dir, struct dentry *dentry)
     +			      (ceph_vinop(dir), dentry->d_name.name),
     +			      (ceph_vinop(dir), dentry));
      		op = CEPH_MDS_OP_RMSNAP;
    - 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
    + 	} else if (!ceph_in_snap(dir)) {
     -		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
     -		      ceph_vinop(dir), dentry, ceph_vinop(inode));
     +		boutc_formats(cl,
    @@ fs/ceph/dir.c: static int ceph_rename(struct mnt_idmap *idmap, struct inode *old
     +		ceph_blog_exit(&__ji);
      		return -EXDEV;
     +	}
    - 	if (ceph_snap(old_dir) != CEPH_NOSNAP) {
    + 	if (ceph_in_snap(old_dir)) {
      		if (old_dir == new_dir && ceph_snap(old_dir) == CEPH_SNAPDIR)
      			op = CEPH_MDS_OP_RENAMESNAP;
     -		else
    @@ fs/ceph/export.c: static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh,
      	int type;
     +	struct ceph_journal_info __ji;
      
    --	if (ceph_snap(inode) != CEPH_NOSNAP)
    +-	if (ceph_in_snap(inode))
     -		return ceph_encode_snapfh(inode, rawfh, max_len, parent_inode);
     +	ceph_blog_enter(fsc, &__ji);
     +
    -+	if (ceph_snap(inode) != CEPH_NOSNAP) {
    ++	if (ceph_in_snap(inode)) {
     +		int ret = ceph_encode_snapfh(inode, rawfh, max_len,
     +					     parent_inode);
     +		ceph_blog_exit(&__ji);
    @@ fs/ceph/export.c: static struct dentry *__get_parent(struct super_block *sb,
     +
     +	ceph_blog_enter(fsc, &__ji);
      
    - 	if (ceph_snap(inode) != CEPH_NOSNAP) {
    + 	if (ceph_in_snap(inode)) {
      		struct inode* dir;
     @@ fs/ceph/export.c: static struct dentry *ceph_get_parent(struct dentry *child)
      		dn = __get_parent(child->d_sb, child, 0);
    @@ fs/ceph/export.c: static int ceph_get_name(struct dentry *parent, char *name,
      	int err;
     +	struct ceph_journal_info __ji;
      
    --	if (ceph_snap(inode) != CEPH_NOSNAP)
    +-	if (ceph_in_snap(inode))
     +	ceph_blog_enter(fsc, &__ji);
     +
    -+	if (ceph_snap(inode) != CEPH_NOSNAP) {
    ++	if (ceph_in_snap(inode)) {
     +		ceph_blog_exit(&__ji);
      		return __get_snap_name(parent, name, child);
     +	}
    @@ fs/ceph/inode.c: void ceph_free_inode(struct inode *inode)
     @@ fs/ceph/inode.c: void ceph_evict_inode(struct inode *inode)
      	 */
      	if (ci->i_snap_realm) {
    - 		if (ceph_snap(inode) == CEPH_NOSNAP) {
    + 		if (!ceph_in_snap(inode)) {
     -			doutc(cl, " dropping residual ref to snap realm %p\n",
     +			boutc(cl, " dropping residual ref to snap realm %p\n",
      			      ci->i_snap_realm);
    @@ fs/ceph/inode.c: void ceph_evict_inode(struct inode *inode)
     +	ceph_blog_exit(&__ji);
      }
      
    - static inline blkcnt_t calc_inode_blocks(u64 size)
    + /*
     @@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int issued,
      
      	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
    @@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int issued,
      		      ci->i_truncate_size, truncate_size,
      		      !!IS_ENCRYPTED(inode));
      
    - 		ci->i_truncate_size = truncate_size;
    +@@ fs/ceph/inode.c: int ceph_fill_file_size(struct inode *inode, int issued,
      
    + #ifdef CONFIG_FS_ENCRYPTION
      		if (IS_ENCRYPTED(inode)) {
     -			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
     +			boutc(cl, "truncate_pagecache_size %lld -> %llu\n",
    @@ fs/ceph/inode.c: void ceph_fill_file_time(struct inode *inode, int issued,
      		}
      	}
      	if (warn) /* time_warp_seq shouldn't go backwards */
    --		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
    -+		boutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
    +-		doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
    ++		boutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
      		      time_warp_seq, ci->i_time_warp_seq);
      }
      
    @@ fs/ceph/inode.c: static void __update_dentry_lease(struct inode *dir, struct den
     +	boutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
      
      	/* only track leases on regular dentries */
    - 	if (ceph_snap(dir) != CEPH_NOSNAP)
    + 	if (ceph_in_snap(dir))
     @@ fs/ceph/inode.c: static int splice_dentry(struct dentry **pdn, struct inode *in)
      	}
      
    @@ fs/ceph/inode.c: void __ceph_do_pending_vmtruncate(struct inode *inode)
      					     inode->i_sb->s_maxbytes);
     @@ fs/ceph/inode.c: void __ceph_do_pending_vmtruncate(struct inode *inode)
      
    - 	to = ci->i_truncate_pagecache_size;
    + 	to = ceph_get_truncate_pagecache_size(ci);
      	wrbuffer_refs = ci->i_wrbuffer_ref;
     -	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
     +	boutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
    @@ fs/ceph/inode.c: int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry
     +
     +	ceph_blog_enter(fsc, &__ji);
      
    --	if (ceph_snap(inode) != CEPH_NOSNAP)
    -+	if (ceph_snap(inode) != CEPH_NOSNAP) {
    +-	if (ceph_in_snap(inode))
    ++	if (ceph_in_snap(inode)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
    @@ fs/ceph/inode.c: int ceph_getattr(struct mnt_idmap *idmap, const struct path *pa
      	u32 valid_mask = STATX_BASIC_STATS;
      	int err = 0;
     +	struct ceph_journal_info __ji;
    -+
    -+	ceph_blog_enter(fsc, &__ji);
      
     -	if (ceph_inode_is_shutdown(inode))
    ++	ceph_blog_enter(fsc, &__ji);
    ++
     +	if (ceph_inode_is_shutdown(inode)) {
     +		ceph_blog_exit(&__ji);
      		return -ESTALE;
12:  7de4cc38e58d ! 12:  259575d1ffd0 ceph: convert VFS data I/O paths to bout
    @@ Commit message
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
      ## fs/ceph/addr.c ##
    -@@ fs/ceph/addr.c: static inline struct ceph_snap_context *page_snap_context(struct page *page)
    +@@ fs/ceph/addr.c: struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
      static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
      {
      	struct inode *inode = mapping->host;
    @@ fs/ceph/addr.c: static void finish_netfs_read(struct ceph_osd_request *req)
     +	ceph_blog_exit(&__ji);
      }
      
    - static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
    + #ifdef CONFIG_CEPH_FS_INLINE_DATA
     @@ fs/ceph/addr.c: static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
      			goto out;
      	}
    @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *folio,
      	if (ceph_inode_is_shutdown(inode))
     @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *folio,
      	/* verify this is a writeable snap context */
    - 	snapc = page_snap_context(&folio->page);
    + 	snapc = ceph_folio_snap_context(folio);
      	if (!snapc) {
     -		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
     +		boutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
    @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *folio,
      	      snapc->seq);
      
     @@ fs/ceph/addr.c: static int write_folio_nounlock(struct folio *folio,
    - 	osd_req_op_extent_osd_data_pages(req, 0,
    - 			bounce_page ? &bounce_page : &page, wlen, 0,
    - 			false, false);
    + 	WARN_ON_ONCE(len > folio_size(folio));
    + 	page = bounce_page ? bounce_page : &folio->page;
    + 	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
     -	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
     +	boutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
      	      ceph_vinop(inode), page_off, len, wlen,
    @@ fs/ceph/addr.c: static void writepages_finish(struct ceph_osd_request *req)
      				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
      			}
      
    --			doutc(cl, "unlocking %p\n", page);
    -+			boutc(cl, "unlocking %p\n", page);
    +-			doutc(cl, "unlocking %p\n", folio);
    ++			boutc(cl, "unlocking %p\n", folio);
      
      			if (remove_page)
      				generic_error_remove_folio(inode->i_mapping,
     @@ fs/ceph/addr.c: static void writepages_finish(struct ceph_osd_request *req)
      
    - 			unlock_page(page);
    + 			folio_unlock(folio);
      		}
     -		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
     +		boutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
    @@ fs/ceph/addr.c: int ceph_define_writeback_range(struct address_space *mapping,
      	}
      
      	ceph_put_snap_context(ceph_wbc->last_snapc);
    -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_space *mapping,
    +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_space *mapping,
      
      	/* only dirty folios, or our accounting breaks */
      	if (unlikely(!folio_test_dirty(folio) || folio->mapping != mapping)) {
    @@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_space *mapping,
      	}
      
      	/* only if matching snap context */
    - 	pgsnapc = page_snap_context(&folio->page);
    + 	pgsnapc = ceph_folio_snap_context(folio);
      	if (pgsnapc != ceph_wbc->snapc) {
     -		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
     +		boutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
      		      pgsnapc, pgsnapc->seq,
      		      ceph_wbc->snapc, ceph_wbc->snapc->seq);
      
    -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_space *mapping,
    +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_space *mapping,
      	}
      
      	if (folio_pos(folio) >= ceph_wbc->i_size) {
    @@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_space *mapping,
      		      folio->index, ceph_wbc->i_size);
      
      		if ((ceph_wbc->size_stable ||
    -@@ fs/ceph/addr.c: int ceph_check_page_before_write(struct address_space *mapping,
    +@@ fs/ceph/addr.c: int ceph_check_folio_before_write(struct address_space *mapping,
      
      	if (ceph_wbc->strip_unit_end &&
      	    (folio->index > ceph_wbc->strip_unit_end)) {
    @@ fs/ceph/addr.c: void ceph_fill_inline_data(struct inode *inode, struct page *loc
      
      	if (len > 0) {
     @@ fs/ceph/addr.c: int ceph_uninline_data(struct file *file)
    - 	inline_version = ci->i_inline_version;
    + 	inline_version = ceph_inline_version(ci);
      	spin_unlock(&ci->i_ceph_lock);
      
     -	doutc(cl, "%llx.%llx inline_version %llu\n", ceph_vinop(inode),
    @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
     +	boutc(cl, "%p %llx.%llx file %p flags %d (%d)\n", inode,
      	      ceph_vinop(inode), file, flags, file->f_flags);
      	fmode = ceph_flags_to_mode(flags);
    - 
    + 	wanted = ceph_caps_for_mode(fmode);
     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
      
      		/* For none EACCES cases will let the MDS do the mds auth check */
    @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
      	}
      
      	/* snapped files are read-only */
    --	if (ceph_snap(inode) != CEPH_NOSNAP && (file->f_mode & FMODE_WRITE))
    -+	if (ceph_snap(inode) != CEPH_NOSNAP && (file->f_mode & FMODE_WRITE)) {
    +-	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE))
    ++	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
    @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
      
     +		ceph_blog_exit(&__ji);
      		return ceph_init_file(inode, file, fmode);
    - 	} else if (!do_sync && ceph_snap(inode) != CEPH_NOSNAP &&
    + 	} else if (!do_sync && ceph_in_snap(inode) &&
      		   (ci->i_snap_caps & wanted) == wanted) {
      		__ceph_touch_fmode(ci, mdsc, fmode);
      		spin_unlock(&ci->i_ceph_lock);
    @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
      		err = PTR_ERR(req);
     @@ fs/ceph/file.c: int ceph_open(struct inode *inode, struct file *file)
      	if (!err)
    - 		err = ceph_init_file(inode, file, fmode);
    + 		err = ceph_init_file(inode, file, req->r_fmode);
      	ceph_mdsc_put_request(req);
     -	doutc(cl, "open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
     +	boutc(cl, "open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
    @@ fs/ceph/file.c: static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_ite
      	      (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
      
     @@ fs/ceph/file.c: ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
    - 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
    + 	if (write && ceph_in_snap(file_inode(file)))
      		return -EROFS;
      
     -	doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
    @@ fs/ceph/file.c: ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter
      
      		flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
     @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
    - 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
    + 	if (ceph_in_snap(file_inode(file)))
      		return -EROFS;
      
     -	doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
    @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_
      
     -		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
     +		boutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
    - 		      ci->i_vino.ino, pos, len, write_pos, write_len,
    + 		      ceph_ino(inode), pos, len, write_pos, write_len,
      		      rmw ? "" : "no ");
      
     @@ fs/ceph/file.c: ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
    @@ fs/ceph/file.c: static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_it
      		return -ESTALE;
     +	}
      
    --	if (ceph_snap(inode) != CEPH_NOSNAP)
    -+	if (ceph_snap(inode) != CEPH_NOSNAP) {
    +-	if (ceph_in_snap(inode))
    ++	if (ceph_in_snap(inode)) {
     +		ceph_blog_exit(&__ji);
      		return -EROFS;
     +	}
13:  a72970fda744 ! 13:  961dbc6413b5 ceph: convert capability and snapshot paths to bout
    @@ Commit message
         Replace dout()/doutc() with bout()/boutc() only on MDS/VFS paths that
         already bind a BLOG context via ceph_blog_enter() (ceph_handle_caps and
         its handle_cap_* helpers, ceph_handle_snap/flush_snaps, ceph_fsync,
    -    ceph_write_inode). Leave enter-less helpers and async/workqueue sites
    -    on doutc to avoid false binary coverage (spec P2.2).
    +    ceph_write_inode).
     
         Signed-off-by: Alex Markuze <amarkuze@redhat.com>
     
    @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
      			ci->i_max_size = max_size;
      			if (max_size >= ci->i_wanted_max_size) {
     @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
    + 	wanted = __ceph_caps_wanted(ci);
      	used = __ceph_caps_used(ci);
    - 	used = ceph_adjust_caps_used_for_lazyio(used, cap->issued, cap->implemented);
      	dirty = __ceph_caps_dirty(ci);
     -	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
     +	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
    @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
     +		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
      		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
      		      ceph_cap_string(revoking));
    - 		/*
    + 		if (S_ISREG(inode->i_mode) &&
     @@ fs/ceph/caps.c: static void handle_cap_grant(struct inode *inode,
      		cap->issued = newcaps;
      		cap->implemented |= newcaps;
14:  762c2cff158c = 14:  43a8e69ecc4e ceph: convert remaining helper paths to bout
-- 
2.34.1

