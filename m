Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890E427F9E
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230591; cv=none; b=dh1XhY7Y/PSShAZzOwqwvrrMtrIWcFKshLD1mchHeCGbAaYAGpFMpXr1kSEsbmoexkLRmVHzV1zHdfdfwtZpGvWRR30FMuPk3ruHykQY2u0d0seM9s5Yqvv43r194J2J8ob8d6QP2O5owHSGOuhY8lewyMRs26bHIwCWy1wFXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230591; c=relaxed/simple;
	bh=xSYOnhLV86B3xeB5B5uWWx+8xN4fvllv2XvlzLmzLTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xod6M/g1SB4W0u9/bRRnJT3ZjbjL0Rqc//vftabyNUFg2P/TX6LjnK7MvoMYOpApzj1nzWe+W0yMCdPV3bSWnQdU4PMwRPAVsApfyc8rSJHvZKizdnhE8LCEH4/j2LfRTBA/4E17+WAEuNm1d0SRmKS882hYS/EOvCMB3rYRypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPLy6PRE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+xE4kon; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPLy6PRE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+xE4kon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jc4OHz03ZuHvmgh2GoYpaNulqNfsFy6ArubCamzHzqY=;
	b=KPLy6PREwgKFEmEdqAuXxtJxApE2sJ5q1IaFP0ktD4KaS1SuFPFISCAraQqb2+lsHysxw3
	JQ5tzopeV0CFK1WOtHIiTgxmPcxPnQiCaEbZUTzOHFhIGQlb6hADPxs5O6J5jEXxb2zhZj
	llkG/LsQpAVjgbVb4aJe++NalcoqmBo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-8MYNX7NHNFyoUtIZ-XAZEw-1; Thu, 20 Aug 2026 08:56:21 -0400
X-MC-Unique: 8MYNX7NHNFyoUtIZ-XAZEw-1
X-Mimecast-MFC-AGG-ID: 8MYNX7NHNFyoUtIZ-XAZEw_1787230580
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1670dd0f5dso190720266b.2
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230580; x=1787835380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jc4OHz03ZuHvmgh2GoYpaNulqNfsFy6ArubCamzHzqY=;
        b=O+xE4konFrzdF84n7FjEJKLLVLHeaOEEZWjPGFmQzZg6xuCs1vYMUyXZqMeNjQlnAE
         2Gh6FocQfaYAHgX/l4wic2DD6yV5abroIRhGrCq2PeVPQCcwT0MYvqbypQduUztDkwRY
         sXnEcjYW8lHlrr+Q59AD/wLRTvT+XkgnNQLF1gqahBzmGfKObdAPX2GrDQW1BlcE0YW4
         z30yUHSVNObUx2SY0o8FdbqgA0bTasUR6KIaV9XEWVFNd8DSvGtOvijG+lJDb/tAgaaS
         lDtWr47yLi0YxgcbvpYti0rgIDnUPNID+Zde9nzEJOTv2X6SI+pL0B1GYVQXKewbbwRD
         lw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230580; x=1787835380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jc4OHz03ZuHvmgh2GoYpaNulqNfsFy6ArubCamzHzqY=;
        b=s/XZU3eW0EyO2Vt+mvmm9gobpr1DanfipdJ5JBAKaD1NfxbpGtSh3sxwEt2w4FxFEz
         0LW7bxVlT7qOHsTQSpbIeGOTGoPkWh4KUcois3cxo3fMg1o8c/p88VxxO+OHnUr1MzQE
         r6vlUP5zVcuvAaglCPCKh6FUoeIWDRmpnYAsHGVHldx7UPWDJUVDM4+wEJQDSp+p+s0w
         TkbNW9QNgAeo+hoPmP2wRrSXFqYUT+oT89hD2jbkAEeIW21nKdpPtBLJR5yjGOVWgWCi
         aPStjUxKBs98tSE507DDRJApEpyX/UXO2ev0MGOnkV/W61yhpHjQ2rsV4Yf88A0iKQUJ
         ZYPg==
X-Gm-Message-State: AOJu0YyQfCEWnXVRA+VevJXNVFDxwHvU9iyxDiUZrDtD7tHMWczedW5m
	okdXkeirm5c4/0nyoBN19vAsOqzccbaDcys56ZnB90GMNPQnopp3iFJdjM8u5N7QlU78Wx8hCiC
	3IjSkfm0ZRxTeOdYTnWmtfbkNpDWq2bT/vSooBVFD6/aKnU9H1JG0dxzfdJJbSyUIBelpRnRRQV
	8yGNPfV/ic5oPhiT7rJ6gp6AFSAzbmUUbTN34JMspGzKO7Vz2eZQ==
X-Gm-Gg: AR+sD133IeF+ffGifrJ/zfhc3lTaZ6KXtlfOMP+kB5lIMq5dlSLPgJC8jFTmoAWC6/t
	a8HByq+U6OBBns0g3naTTsYp8bXLxDdqO+diAZGf8CN4NnbDDtYaQy8kiAXhguTNmP+yYrm2pLm
	8oTcMvq0/rjIwjWdyvYZg60Gut0lQYcksU6N8MSXNYYI3ze5kbiwZwyU+R6A1iqHCpyCfu8TqUa
	nO1+H4LHyU6fgvbUjEIhLWgMiWHCXVoyyYqD/0fwN7o0cUBAsRFz8h9U7vHhz1Ff0p5wl/LAEVu
	h855XmvgMEbs0qJnq2VvDZX+P1LMseN655N10XY/tkeCm9geoSY2mhLj5Ax6K0LNdbbCouCyUA7
	YeXd1/snGZC/BugR20Ztfwuq5gFvPQzBnRA==
X-Received: by 2002:a17:906:9c82:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c242e3e6948mr895045466b.20.1787230580222;
        Thu, 20 Aug 2026 05:56:20 -0700 (PDT)
X-Received: by 2002:a17:906:9c82:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c242e3e6948mr895039866b.20.1787230579648;
        Thu, 20 Aug 2026 05:56:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 00/14] ceph: add binary logging (BLOG) for CephFS
Date: Thu, 20 Aug 2026 12:56:03 +0000
Message-Id: <cover.1787229471.git.amarkuze@redhat.com>
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
blog_max_clients (default 256) size the ID tables.

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
    slot reuse rather than tearing; clear pending state on ENOSPC
    commit


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
 fs/ceph/blog.h                  | 223 +++++++
 fs/ceph/blog_batch.c            | 307 ++++++++++
 fs/ceph/blog_batch.h            |  44 ++
 fs/ceph/blog_client.c           | 678 ++++++++++++++++++++++
 fs/ceph/blog_core.c             | 279 +++++++++
 fs/ceph/blog_debugfs.c          | 713 +++++++++++++++++++++++
 fs/ceph/blog_des.c              | 343 +++++++++++
 fs/ceph/blog_des.h              |  16 +
 fs/ceph/blog_module.c           | 994 ++++++++++++++++++++++++++++++++
 fs/ceph/blog_module.h           |  46 ++
 fs/ceph/blog_pagefrag.c         |  84 +++
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
 31 files changed, 5593 insertions(+), 637 deletions(-)
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

