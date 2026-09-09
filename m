Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB585592FF
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958470; cv=none; b=ZXadqUEmrIoqW+bNQz+UV1xWZU+BhXs+o2etEnItf3bEs9ncbvIIDAje1KzMuJpiXXen1Ve0qpRgDIEQ1sumdeiniO0YKbzfY5gCxk2YU3rimkt3rkLnzKtlmBo4YztuenJQkK5jqMdydALmFzYLHHGgAmZI7BgWwUkWYn7tN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958470; c=relaxed/simple;
	bh=M9eLplhibnkv8cNa8TfIOEUk0A3n1XgkERdymGMOjfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqamhvC5d7EJBUNTE8tgFVrnKNxUSR2gZhwZ6x2SsEK5xCFmp8RmwP0PeKKCpWRTmHmEBPaTjqSmCFUbuSerRXlMXdDCX2oc5QPcnHzQNElGwBCfCOQq8anzLKOzWgqaFarEDRbptkL6PbpR1zwxpH0T1WSHGY+sJdkvIXzjp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVj6h5Ng; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkLldqhL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVj6h5Ng";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkLldqhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nqDnuYgRNTErrvuF2n8kIroUO+yZbk4FlD4oG1bweYo=;
	b=RVj6h5NgKxeifYwRVKk5IwQPbvG4R0yN1VvkYW8xKPU0RFa05/MbkxazxrDHFxrIJV9f/u
	/aUDpgD+aA3qvij05UIGsD+9MQLAceb8SSx8tC2G7DdqhFkXt/aHlkl68bSObMWsi3M0sv
	weyqz3FPJrOZYTdmTwWu9vHLMYzhGwE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-emFf2ygLNcq1if7qgyp1iA-1; Wed, 09 Sep 2026 08:54:25 -0400
X-MC-Unique: emFf2ygLNcq1if7qgyp1iA-1
X-Mimecast-MFC-AGG-ID: emFf2ygLNcq1if7qgyp1iA_1788958465
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b571432fso906936385a.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958465; x=1789563265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nqDnuYgRNTErrvuF2n8kIroUO+yZbk4FlD4oG1bweYo=;
        b=FkLldqhLvWx6gk+K/oEyDDasuYLv6xC3ckUKJE43Xa3b4AeghEwEJ1ivL/QsBFtlhx
         6xLZkYHz8KAvRf5AYEtno34Kc+N3vcIaLaAb5QQ30YO1NTXzA7jLhMr00uWz+JCNFFYF
         OmeDYvxij0b8YHj7w8TCmtyHfiwNXiWVpO0kEYXEMbFIo0LJCMKDSO7TUKFodezD7tTs
         ThYaj6VVaUzS6NQ6CRTZkMd41QMhGDbE2qXHpWxgahLIacsbpiHv23VA2sT/2gL/3OHh
         LMGCTvFVM5Fq2iEiLJfWDBrnc7wMOMotdqlk6MItPv+rXfGrerppI2mJUMH1o9SdqmaR
         7MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958465; x=1789563265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqDnuYgRNTErrvuF2n8kIroUO+yZbk4FlD4oG1bweYo=;
        b=gosniKLscKxuoXgFxEAwQLL4LR0QhACQ5F0sWJOX3zFaAbYQZn/FUiyFoBcnjSaDrg
         keIH0W7TOo4pwCc/pQqWvNrVS7W2YNm2RogH5rSAwVG1AHzWUpPYcgZxcGD4F8eG9aLG
         /WjAfyT3iTvaWcJBUX/rie7TnqKZiQtcwTYgTOqFxztTjwi08SLovbJ+MIsX+/emmXgq
         yztzzttRfnxar/BnjjFvuENGqcxthZ53TD2+WoDOy+MTcUNvA9vr+NbmgkAgZT4o00yG
         IxXc/uamgUvSC6hx2OhhP+Duml807+hJL1f5d8CM2hePU1Yfuk7WKA5TOhJPr14redZy
         rnMg==
X-Gm-Message-State: AFuF++kl99Vg1xjFVwzqHtPaYPLjPDMQHgfu0JO1gDNBq6DF09t85JaJ
	lIxQ5IIYqaxaFV57iXdoOv5u7B6LSymoHLaXfBIfvDiTQzGH6c8XUHqR/pR9HKGwrznu6qktfRU
	jSmTpiF8+8aZeNNVbj5gb+V667Vn/6jXc3+BecuLcBng3+E0106SR1plcqWxTwn18WWjw9kP5gE
	UO4W1b3A+DY7vmSnQ4GNSEtdajpEgTD/aMd0C0Nc+LYZQXeRrXkw==
X-Gm-Gg: AYBFou3b7nC7S/aJvERTkSmlM7zsS+caeEBIcraQk9EANXzGLoxpufGVZyLEKOpsWVs
	bYy+p7SPk6iVyPtfMlHMElwHEw16j0yb3xEuVYLNUDRC4oqqeX+cK9mgmSx1Sa5pgUSqAUHZMiz
	sk5SnGCClGEBA7D48ylUDdAr5AfqtCxyXyhQVGCQ7m6d4C/AoGZoIX/4LlTOCvlPBgOr9P70db+
	fuGrRzRwT/4aDyTgS/80YArhjeulAtGd6fWQgdOqbZyhNZ1Je/poID5q7o0GOH4jolSeUmkM8x0
	6soe4I/q7ZC5iju3RidAosfxWZJoq2RAhm55PgROQynUY/simbiW97wzGuwG8gi4J3IUVUrHowS
	r0e+BtqvAQeCvuwRBuMTo+00npB53dq5wbmkRKjOyaYG06adLyibx0qWORgnxNjbQL0wqoX1CLm
	DposAO0zYF0UABRQ==
X-Received: by 2002:a05:620a:711c:b0:939:a8b1:3696 with SMTP id af79cd13be357-939a8b13b38mr1671672585a.27.1788958460177;
        Wed, 09 Sep 2026 05:54:20 -0700 (PDT)
X-Received: by 2002:a05:620a:711c:b0:939:a8b1:3696 with SMTP id af79cd13be357-939a8b13b38mr1671666785a.27.1788958459397;
        Wed, 09 Sep 2026 05:54:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 00/14] ceph: add binary logging (BLOG) for CephFS
Date: Wed,  9 Sep 2026 12:54:02 +0000
Message-Id: <20260909125416.3969532-1-amarkuze@redhat.com>
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

Changes since v4
----------------

  - Intel 0-day on the posted v4 (ARM allyesconfig, gcc 16,
    -Wframe-larger-than=1280): ceph_readdir and
    write_folio_nounlock exceeded the limit because boutc()
    inlined a struct blog_arg[] at every call site. v5 stages
    packed args in the per-task TLS context (arg_scratch) and
    emits from noinline blog_log_client_emit(). Same-width
    values go through unsigned long so 32-bit sparse does not
    see pointer-to-u64. blog_entries_show() kernel-doc now
    documents @s and @p. Folded into 01/05/10; still 14 patches.
  - rebase onto current ceph-client testing (Tal extract_bvecs,
    Jiangshan longname overflow, writeback congestion, Max
    pending-truncate, folio writeback)

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
 fs/ceph/addr.c                  | 202 ++++---
 fs/ceph/blog.h                  | 206 +++++++
 fs/ceph/blog_batch.c            | 259 +++++++++
 fs/ceph/blog_batch.h            |  44 ++
 fs/ceph/blog_client.c           | 641 ++++++++++++++++++++
 fs/ceph/blog_core.c             | 297 ++++++++++
 fs/ceph/blog_debugfs.c          | 688 ++++++++++++++++++++++
 fs/ceph/blog_des.c              | 335 +++++++++++
 fs/ceph/blog_des.h              |  16 +
 fs/ceph/blog_module.c           | 995 ++++++++++++++++++++++++++++++++
 fs/ceph/blog_module.h           |  42 ++
 fs/ceph/blog_pagefrag.c         |  62 ++
 fs/ceph/blog_pagefrag.h         |  27 +
 fs/ceph/blog_ser.h              | 285 +++++++++
 fs/ceph/caps.c                  | 116 ++--
 fs/ceph/crypto.c                |  18 +-
 fs/ceph/debugfs.c               |  11 +-
 fs/ceph/dir.c                   | 322 ++++++++---
 fs/ceph/export.c                |  83 ++-
 fs/ceph/file.c                  | 277 ++++++---
 fs/ceph/inode.c                 | 256 ++++----
 fs/ceph/locks.c                 |  66 ++-
 fs/ceph/mds_client.c            | 358 +++++++-----
 fs/ceph/snap.c                  |  17 +-
 fs/ceph/super.c                 |  58 +-
 fs/ceph/super.h                 |   7 +
 fs/ceph/xattr.c                 | 104 ++--
 include/linux/ceph/ceph_blog.h  | 292 ++++++++++
 include/linux/ceph/ceph_debug.h |  84 ++-
 include/linux/ceph/libceph.h    |   2 +
 31 files changed, 5519 insertions(+), 654 deletions(-)
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

-- 
2.34.1

