Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B333E49ED
	for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170795; cv=pass; b=n3s/Li0qHFLKEZg31GVIujgGAAh290rLWYPvr5GnZ4VYzdjqFOmR51r/IFjf6e54gLHa9611/OpYksK/X/YROi7LBuMug7uNB5GhBfhlZ+I4ht5fHMPJ8XmCkr1ph34i1h56IM87sYmZWPhNmyh63BoNOXn7PqUCr/0Rryycczo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170795; c=relaxed/simple;
	bh=vB8PUtEku+qJoVPysA0x2AWZLUAMJ/C+h5213+mElfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfXVKE628c600edsARtWF7ciXYbGFgxT3JLegMzaVxFGbSkVbEN+aTsD3Ush1uVuX2oFiL0Y4tvE3XQte714jMZs0qnTppmJU9loWhxlThUVxJsZghMdoxkhwdrEaPN0pBmD8IdOjjk3QHhFgNZ/MkuhV0op/RTdg9eplsufBl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=A4mqjbAk; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="A4mqjbAk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5f968ada7so6567080a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 03:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788170790; cv=none;
        d=google.com; s=arc-20260327;
        b=q860jU7d07dtMmtkFHzYjWcC3ncmaQJSQuNupaW3AAMb/aIs/d2OYChvxtKrIXHuO9
         XTGnLp3dtalL0YaxKd5JkDQ9NBbiQt0Jw57hCLrAeTvfh/+X840W8IKMiDdULG0c5rON
         3gnnlBfgOQIQrGV8ByHc/glHZw8WyOVoahmldoh/OWlqAkWPoVC0tuzIRRygljUs5iKR
         CaE0t3wEha8Qq8mKFUyZQrRSZlBAEWFdcSgpYm4pmDZ7BJ3ueoZ45qH49aHVxHTRv2Op
         v0VXcAgJaNijQkh5bhkOCxVybPPszpUdNpi5+6xBjnXojdBbpWBuHtvU3ofMs/qEAH6t
         mNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wWNgoP9eBQCAazIlrSvBz1ZAMhpbZ/35K5liVVimXM=;
        fh=h48fRnveUl1vdmzVuhvVnq39GQgA69ReJE4iqTKnnHY=;
        b=f23Upwir3r/Ow4AYTRce0ysP4FSN7gTktBCZvNfwYOmzYpF+F5GKX6MtDrYsf5tTSn
         jBcGR6tHdJnzc6iJ2KkPFulerQGhHLQWpUYe9zSZfrmCqw+UaL+5Ud0sU5Zx/NBanjXw
         0jLdEkpe0XUXXri82g9bypSpE2GvYRTyOXrExIN1G7RlpS+BUGJcATa0KBaIdCILZHf9
         6DYanrSFDNtCw7Cbo34EZYBPxt4QEGsXJ4iiS8VBM5avcLi5lx1G6wauVTePKzbVgM6W
         kgev/a4rW4ZPojJO86HdwA8HdQ5MfC90h8To128f35V4raRJTWuFL1epxAnOONqfcimP
         dDeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788170790; x=1788775590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wWNgoP9eBQCAazIlrSvBz1ZAMhpbZ/35K5liVVimXM=;
        b=A4mqjbAk+PrbKp7himTVc1ugI7YxIztme3xmM63BtSxpOkfvun7HbqjQFcbBi4PDH2
         2HaU9ZbuRW+nJDszFwwFafozds3Fht9wpXO/kjsBmoKtitUgPEUtny4n5TWkxLYpwTXY
         GvOjskfU/9F3fKk2+KulJnUy8FmZuICf7nk+DwpAY8KnlAXpeUp5n019pEIjPxK6jjl0
         c7dPb+m/aNH3gg7wfDMiYvXuga1dEGDWeB5tRMd/NXTTWCyuaoV9/u5B2mi3eluIyAdN
         A5IbfIV3IesKe27gHzONcSoDrlyeTIM9tE3UG1lvS+50nvSP1ThUVi70ZwNklXTP9Q7+
         PSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170790; x=1788775590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wWNgoP9eBQCAazIlrSvBz1ZAMhpbZ/35K5liVVimXM=;
        b=UzdMzI+OFZi22L95vCgogKKc+HUpge71EXZDz85PImw8s4GUhHP4GlmBv+Jbtgwv9k
         k3SV6ZfZ1sHNA+xbfCw9ouI32RLu9kauZQ4LS0abCucjtZYQYFRKxPZ/yd3ZBGi4b01j
         cPfl9VRvOlRq84EksuWL8QncUbo6Utt6HsIb8RBkXcOs8ArcyV0Dvi9LwDS1d8tXLFbd
         4pS8DBdQCNRrOSw59HpXv/ChY8y0UKixosSHcVISgplP+Rh5dCpO6ghQkFHpzVgthXN4
         XOMMcW4CnTDb5+kSx3F0yJYJCR6vUfikvZFQ8fcFp1idpd9jW4fPo3ChXX62Pwfwwjej
         D22g==
X-Gm-Message-State: AFuF++nw+HyAXTCM69+VoD7m2iRVKnQthA6yZB/JLTlwTQvj/f5nQSKk
	kgmFRPVkdWa55Lro4v+6sXLvn/npLOZvbHo1/M9DU7d7wFcfqcrGSeatedsaRzHHip+RT94OvI/
	swlzP87cRvYVceIFSAr+zOvAP197kFSygvCeTAynUfQ==
X-Gm-Gg: AYBFou1AE3neVSqShoQbLTl6gIgWi1CgFCrL3GD0P/5IUVUrgGSrdVo0wl0tJvOd+9e
	DmEiuEpqjaK97BiEjlu+pRhjd+8icxp/fwdlCRg174YxGA+lEH0x2a12ILnSdMbM8j9ft4AWge3
	VICaINHSccUPnlIE6IERw+jbqIMGICwS58eOMooKJgK4TPV2sQp3JQP50sXkugQCmpnB323qNq3
	4GWIOSIkUeutz0bb5cOAi3qiK0e2sD2V9H7tN4T12Gne6nqpH+l6iA4+OgEaiZjbXjMn6/d3QBX
	3nKUW+Pftg+yaiWkUZLnqNXsbKbNoBMBrvpwJEkF2BkqN7oiht2DcP2Q
X-Received: by 2002:a05:6402:20c6:10b0:6a6:485b:3b7e with SMTP id
 4fb4d7f45d1cf-6a6485b3bf0mr2804588a12.1.1788170789464; Mon, 31 Aug 2026
 03:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787229471.git.amarkuze@redhat.com>
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 31 Aug 2026 03:06:17 -0700
X-Gm-Features: AcwNN1X_WEPXXVOPa070O-MZLKykcTC8hi3SJgSvZyo3oa-GaB8P7mY1IfEKlxI
Message-ID: <CAOJNxRLcM9BSEy-NNi=EV_9NFkr0P_a1gZkhHGK=128_tY0M6A@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] ceph: add binary logging (BLOG) for CephFS
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I just test it locally and three comments on the series, all minor:

1. (ceph: add BLOG per-module context management)
   blog_module_wq_init() creates the free workqueue with only
   WQ_MEM_RECLAIM:

      blog_free_wq =3D alloc_workqueue("ceph_blog_free", WQ_MEM_RECLAIM, 0)=
;

   Since v6.19 ("workqueue: Add warnings and ensure one among WQ_PERCPU
   or WQ_UNBOUND is present"), __alloc_workqueue() warns when neither
   flag is given.  I hit this at ceph.ko load time on v6.19.10:

WARNING: kernel/workqueue.c:5851 at __alloc_workqueue+0x513/0x580,
CPU#11: modprobe/8036
workqueue: ceph_blog_free is using neither WQ_PERCPU or WQ_UNBOUND.
Setting WQ_PERCPU.

   The other ceph workqueues are already explicit (ceph-inode:
   WQ_UNBOUND, ceph-cap: WQ_PERCPU).  The free/reclaim work has no
   CPU-affinity requirement, so:

      blog_free_wq =3D alloc_workqueue("ceph_blog_free",
                                     WQ_MEM_RECLAIM | WQ_UNBOUND, 0);

2. (ceph: add BLOG per-module context management)
   The reader-visible history window is fixed at 16 full magazines
   (BLOG_LOG_BATCH_MAX_FULL): rebalance hides the oldest magazine once
   log_batch exceeds that, leaving ~256 4K contexts plus the live task
   contexts visible in the entries dump.  Under heavy logging that window
   rolls over in minutes, and everything older is silently gone.

   For production troubleshooting it would be useful to widen that window
   (or shrink it on memory-constrained hosts) without recompiling.  How
   about making the visible-magazine count (and/or the alloc_batch
   retain_limit) a per-mount debugfs knob, or at least a module parameter
   like blog_max_sources?  The check sites already run in sleepable
   contexts, so a logger field with READ_ONCE/WRITE_ONCE should be
   enough.
3. (ceph: add BLOG debugfs interface)
   Every line in the entries dump is followed by a blank line: the stored
   formats keep their trailing '\n' after reconstruction, and
   blog_entries_show() appends its own =E2=80=94 so wc -l counts each entry
   twice.  Stripping the trailing newline before printing (multi-line
   formats keep their embedded newlines) fixes it:

      if (ret > 0 && output_buf[ret - 1] =3D=3D '\n')
              output_buf[ret - 1] =3D '\0';

FWIW, aside from these the series held up well in my testing: 70
concurrent logging tasks (past the 64-task cap) with tasks killed
mid-flight, ~9k log entries with zero deserialization errors, concurrent
cat/clear/enable-disable cycling, and 4K buffer rotation via readdir on
a 1000-file directory. I also did several stress tests, for example with
fsstress...

Thanks,
Xiubo

On Thu, 20 Aug 2026 at 05:56, Alex Markuze <amarkuze@redhat.com> wrote:
>
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
> blog_max_clients (default 256) size the ID tables.
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
>     slot reuse rather than tearing; clear pending state on ENOSPC
>     commit
>
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
>  fs/ceph/blog.h                  | 223 +++++++
>  fs/ceph/blog_batch.c            | 307 ++++++++++
>  fs/ceph/blog_batch.h            |  44 ++
>  fs/ceph/blog_client.c           | 678 ++++++++++++++++++++++
>  fs/ceph/blog_core.c             | 279 +++++++++
>  fs/ceph/blog_debugfs.c          | 713 +++++++++++++++++++++++
>  fs/ceph/blog_des.c              | 343 +++++++++++
>  fs/ceph/blog_des.h              |  16 +
>  fs/ceph/blog_module.c           | 994 ++++++++++++++++++++++++++++++++
>  fs/ceph/blog_module.h           |  46 ++
>  fs/ceph/blog_pagefrag.c         |  84 +++
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
>  31 files changed, 5593 insertions(+), 637 deletions(-)
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
> --
> 2.34.1
>
