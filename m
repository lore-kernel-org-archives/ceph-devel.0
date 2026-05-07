Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470512DB788
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156870; cv=none; b=uAS1+KcXxXy311mwVuNWyFRwAI8pFdBDMlGQwV0xDv2+4UiwXJC/zds9hFOx3ok9/RT6tv7yiewxvp5zI/qLTVqt9nGuF706EVX+UgOH85R7RTGKLj9eHhQQtPzT6kIlxg/gsO9SupSawn0MnmTsHWASCk8fPE8q+t3NY6tQHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156870; c=relaxed/simple;
	bh=n9xUSq+CgF/HoTkhcg1ovXhodC9Lf7dcnp/oGwsRsWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SDmmEIhklkdqN04Tu9ki5pL3DHD3PpWUpqZxuznk07WTl+exZHUu8PUeaeRrQiy1c+F+J1COxVKICObo3mF+hpWFLW8OhASKcGGmYXw6jxDJEjMt3TLLQV8bpDJb2maBAHnViED4c83EStk4NFAx41izqS0SPEZchMwGSEmPJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KULykeDP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7m3pBdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KULykeDP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7m3pBdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sH6HxK5bHOwiUyRvbU/AAVnaaifL50arexDXP1yWMkY=;
	b=KULykeDPwBZCSFoJux6fbHEZtXJeuv+g8rsXolBoGph6M/tF6A/FTKVA/hmNEsimM2+Gby
	nblSvgl96YCmfzq8jNQwGH933LyYagBnS9F2OX130axdaXIJz5Y4oL/WttavjnXRE6LsH+
	ACM4fRt+6lMRDy1z731QYYeAB/TrUcY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-NdVh3WfoP7qgZ_cG6QD_rg-1; Thu, 07 May 2026 08:27:44 -0400
X-MC-Unique: NdVh3WfoP7qgZ_cG6QD_rg-1
X-Mimecast-MFC-AGG-ID: NdVh3WfoP7qgZ_cG6QD_rg_1778156863
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ba70cda6755so70003066b.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156863; x=1778761663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sH6HxK5bHOwiUyRvbU/AAVnaaifL50arexDXP1yWMkY=;
        b=Z7m3pBdT2KS5hsWcAqFEPdGUyr70MNhKL7lCwF/QmD/P5lthyIGSoUodq6MsQBK/8e
         6GFmKuJrBQGXNRFFLMEmkuglY1Pk1ZgKqPiCjL6L8HRCa1nlQb4oH61koQo6gwNUP18a
         Xv6ggkpu+JWcROIYNAMTAFovBWjKNVVwuDK+BxK61C3V1kt8djMltEhnovHtl3IDI5YI
         T9JiQ8a48/YvP9IJhqEpKNd6SgNxX9QMwtsXU3wqASdmygYKXeJfxkFdFu3tl/9pGgBs
         dU1S2JZFPKtfUt2yiRiuI4rGs6XBENRkILbcWg8FRcxxMHZod2j/bbwe7jFbItAUjRit
         zmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156863; x=1778761663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH6HxK5bHOwiUyRvbU/AAVnaaifL50arexDXP1yWMkY=;
        b=TY4V+ayrNZKJZDSeAiiD3piZvRIlsgPJ6zcEa3sHLdUgPSqNCUcjuVwU+q0tZGjZz7
         XRJVu+y9xg6YaDbVw5Ktu4SnDFM7c9CrDgJK+gQnPXu+n1nC3005aZvtHWQxUCjieSce
         qhj0ZoFcyhes1MpoEW94D3cd5cjEne3CNZNAkilhH994cRNuKzZUZmkelWbfHO+LoKWN
         8H8/uNmujkmwPDQkbU1sXo66EYz2n0NFQZ053zpqcM/YpR0wlp4vyc4IxTZkeAdjyguf
         6EGeNWLcIhDfC1RaZF1XafaIIK1YqZT1/6N6HwS4EFyTsnQFajXOOr5nuhmp9f+i5gtj
         liYw==
X-Gm-Message-State: AOJu0YxhNPA2evTVM/R3A1klr1vjhLL+Fa+s8+JIKzQOApS4ASIbG3Bw
	cvK0KoU4Nztn7t3UKc5vOYWw04b84Z8iQi2VgXkaXsm2J+bD4Q8jCw5ejZFo0cnnH76uqUIQ22Z
	TriSAzM0R1KZpTEwij8b7h2BWOkn0qZY+YhuanF6JO1Ok/JhBfLiROe53YNZ03d/az+BhvsWA7+
	L9h1BuRtHy7a3ROXGV5EtUionflgTuM+wlmoXpSxKhNvSmo8Y=
X-Gm-Gg: AeBDiet+7jNqT2A0xSHNlmnJlRsX/N5wyJU6agLHSyMm7xGHbYpFSD9gAsJjEuVGNQ9
	cO3bpI2jS342T3/om4rGATfoT3ycKJtAnUy0TNnx+J/9XeFPbWhv63CTAVxKmxi/Oj4KuTJgOMl
	w3FuY3vgN6mHZIxyBFrNHDI+2Tp0awpgQLPzGJrZSAE3GwRLeb1kYIPOZzRMD+R3BpXW1pc4LT6
	AuRqoklObAk4UHQ5vsWIsAJUPdl+r49OUtJqL5f2wVui+y00xEJXYX9z6fRpEfi7sWzDUZKEXm1
	CfDA7hSIu2z/g8YqhPKmIgT1Gdun5NncXNOidbN8X8Y9rl2Rd0ehVn89TSe8+s1UOMZAtWUNSnx
	LVtL7Yhv5O2CmbncaZuieQqWn9IaVpdgWhA8EemisKhaB88XV4qqjKVCyvX61R269jw==
X-Received: by 2002:a17:907:c91f:b0:bc5:fdd8:4ba8 with SMTP id a640c23a62f3a-bc5fdd85a33mr286176266b.35.1778156862705;
        Thu, 07 May 2026 05:27:42 -0700 (PDT)
X-Received: by 2002:a17:907:c91f:b0:bc5:fdd8:4ba8 with SMTP id a640c23a62f3a-bc5fdd85a33mr286173666b.35.1778156861925;
        Thu, 07 May 2026 05:27:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:41 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 00/11] ceph: manual client session reset
Date: Thu,  7 May 2026 12:27:26 +0000
Message-Id: <20260507122737.2804094-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds operator-initiated manual client session reset for
CephFS, providing a controlled escape hatch for client/MDS stalemates
in which caps, locks, or unsafe metadata state stop making forward
progress.

Motivation

When a CephFS client enters a stalemate with the MDS -- stuck cap
flushes, hung file locks, or unsafe requests that cannot be journaled --
the only current recovery options are client eviction from the MDS side
or a full client node restart.  Both are disruptive and can cascade to
other workloads on the same node.

Manual reset gives the operator a targeted tool: block new metadata
work, attempt a bounded best-effort drain of dirty client state while
sessions are still alive, then tear sessions down and let new requests
re-open fresh sessions.  State that cannot drain (the stuck state
causing the stalemate) is force-dropped -- that is the point of the
reset.

Design

The reset is triggered via debugfs:

    echo "reason" > /sys/kernel/debug/ceph/<client>/reset/trigger
    cat /sys/kernel/debug/ceph/<client>/reset/status

The state machine tracks four phases:

    IDLE -> QUIESCING -> DRAINING -> TEARDOWN -> IDLE

QUIESCING is set synchronously by schedule_reset() before the workqueue
item is dispatched.  This provides immediate request gating from the
caller's context -- new metadata requests and file-lock acquisitions
block the moment the operator triggers the reset, with no race window
between scheduling and the work function starting.  All non-IDLE phases
block callers on blocked_wq; the hot path adds only a single READ_ONCE
per request.

The drain phase uses a single shared deadline (bounded at 30 seconds)
across all drain legs.  It first waits for unsafe write requests
(creates, renames, setattrs) to reach safe status, then flushes dirty
caps and pushes pending cap releases, using whatever time remains
within the shared deadline.  Non-stuck state drains in milliseconds;
stuck state times out and is force-dropped during teardown.  The
drain_timed_out flag is monotonic: once set by any drain leg, it stays
true for the lifetime of the reset.

The session teardown follows the established check_new_map()
forced-close pattern: unregister sessions under mdsc->mutex, then
clean up caps and requests under s->s_mutex.  Reconnect is not
attempted because the MDS only accepts CLIENT_RECONNECT during its
own RECONNECT phase after restart, not from an active client.  A
SESSION_REQUEST_CLOSE is sent to each MDS before local teardown so
the MDS can release server-side state promptly rather than waiting
for session_autoclose timeout.

Blocked callers are released when reset completes and observe the
final result via -EAGAIN (reset failed, retry later) or 0 (success).
Internal work-function errors such as -ENOMEM are not propagated to
unrelated callers like open() or flock(); the detailed error remains
in debugfs and tracepoints.

The work function checks st->shutdown before each phase transition
(DRAINING, TEARDOWN) so that a concurrent ceph_mdsc_destroy() is not
overwritten.  If destroy already took ownership, the work function
releases session references and returns without touching the state.

The destroy path marks reset as failed and wakes blocked waiters
before cancel_work_sync() so unmount does not stall.

Patch breakdown

Prep / cleanup:

 1. Convert all CEPH_I_* inode flags to named bit-position constants
    and switch all flag modifications to atomic bitops (set_bit,
    clear_bit, test_and_clear_bit).  The previous code mixed lockless
    atomics with non-atomic read-modify-write on the same unsigned
    long, which is a correctness hazard.  Flag reads under i_ceph_lock
    that only test lock-serialised flags retain bitmask tests.

 2. Fix a __force endian cast in reconnect_caps_cb() to use the
    proper cpu_to_le32() macro and the new test_bit() accessor.

Hardening / diagnostics:

 3. Harden send_mds_reconnect() with error return, early bailout for
    closed/rejected/unregistered sessions, state restoration on
    transient failure.  Rewrite mds_peer_reset() to handle active-MDS
    (past RECONNECT phase) by tearing the session down locally.

 4. Convert wait_caps_flush() to a diagnostic timeout loop that
    periodically dumps pending flush state, improving observability
    for reset-drain stalls and existing sync/writeback hangs.

Core feature:

 5. Add the reset state machine, request gating, session teardown
    work function, scheduling, and destroy-path coordination.

 6. Add the debugfs trigger/status interface and four tracepoints
    (schedule, complete, blocked, unblocked).

Testing:

 7-11. kselftest-integrated shell tests split into five patches:
    data integrity checker (7), stress test with concurrent I/O and
    random-interval reset injection (8), targeted corner cases --
    overlapping resets, dirty data across reset, stale locks, unmount
    during reset (9), five-stage validation wrapper with per-stage
    timeouts (10), and kselftest Makefile/MAINTAINERS wiring (11).
    All 5 validation stages pass on a real CephFS cluster.

Changes since v3

 - Rebased onto testing (7.1-rc1 + ceph fixes).
 - Dropped v3 patch 7 ("add trace points to the MDS client") --
   already upstream as d927a595ab2f.
 - Patch 1: fixed flags type from int to unsigned long in
   ceph_pool_perm_check() (Slava).  Added commit message paragraph
   documenting the set_bit() conversion in ceph_finish_async_create().
 - Patch 3: moved xa_destroy() under s_mutex with comment explaining
   serialization against ceph_get_deleg_ino() (Slava).  Added lock
   ordering comment at mdsc->mutex acquisition.  Added comment
   explaining why mds_peer_reset() narrows the RECONNECT state check
   from >= to ==.
 - Patch 4: split CEPH_CAP_FLUSH_MAX_DUMP_COUNT into separate
   CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES (array bound) and
   CEPH_CAP_FLUSH_MAX_DUMP_ITERS (iteration limit) (Slava).  Moved
   all flush timeout defines to mds_client.h alongside reset defines
   (Slava).  Split comment block into per-field struct documentation
   and separate function safety comment for dump_cap_flushes() (Slava).
   Fixed for-loop variable declaration to match fs/ceph/ convention.
   Fixed commit message to reference the correct macro names and to
   stay within 72-column body width.
 - Patch 5: added bounded wait for unsafe write requests during the
   drain phase, using a shared deadline across all drain legs so the
   total drain time stays within CEPH_CLIENT_RESET_DRAIN_SEC.  Made
   drain_timed_out monotonic (once set, stays true for the reset).
   Replaced spin_lock/spin_unlock around drain_timed_out writes with
   WRITE_ONCE() (Slava).  Added ceph_reset_is_idle() inline helper
   (Slava).  Added per-field comments to struct ceph_client_reset_state
   (Slava).  Changed -EIO return to -EAGAIN for reset-failure
   signalling to callers (Slava).  Increased CEPH_CLIENT_RESET_DRAIN_SEC
   from 5s to 30s (Slava).  Added sessions[i] = NULL after
   ceph_put_mds_session() in teardown skip path (Slava).  Added comment
   at out_sessions label explaining destroy ownership.  Expanded
   msleep() comment explaining why event-based waiting is not viable.
 - Patch 6: tracepoint placement fixed to fire before -EAGAIN return.
 - Patch 11: added MAINTAINERS F: entry for the test directory and
   the filesystems/ceph line in the top-level selftests Makefile.

Alex Markuze (11):
  ceph: convert inode flags to named bit positions and atomic bitops
  ceph: use proper endian conversion for flock_len in reconnect
  ceph: harden send_mds_reconnect and handle active-MDS peer reset
  ceph: add diagnostic timeout loop to wait_caps_flush()
  ceph: add client reset state machine and session teardown
  ceph: add manual reset debugfs control and tracepoints
  selftests: ceph: add reset consistency checker
  selftests: ceph: add reset stress test
  selftests: ceph: add reset corner-case tests
  selftests: ceph: add validation harness
  selftests: ceph: wire up Ceph reset kselftests and documentation

 MAINTAINERS                                   |   1 +
 fs/ceph/addr.c                                |  20 +-
 fs/ceph/caps.c                                |  34 +-
 fs/ceph/debugfs.c                             | 103 +++
 fs/ceph/file.c                                |  13 +-
 fs/ceph/inode.c                               |   5 +-
 fs/ceph/locks.c                               |  38 +-
 fs/ceph/mds_client.c                          | 800 +++++++++++++++++-
 fs/ceph/mds_client.h                          |  52 +-
 fs/ceph/snap.c                                |   2 +-
 fs/ceph/super.h                               |  70 +-
 fs/ceph/xattr.c                               |   2 +-
 include/trace/events/ceph.h                   |  67 ++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/ceph/Makefile       |   7 +
 .../testing/selftests/filesystems/ceph/README |  84 ++
 .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++
 .../filesystems/ceph/reset_stress.sh          | 694 +++++++++++++++
 .../filesystems/ceph/run_validation.sh        | 350 ++++++++
 .../selftests/filesystems/ceph/settings       |   1 +
 .../filesystems/ceph/validate_consistency.py  | 297 +++++++
 21 files changed, 3185 insertions(+), 102 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

-- 
2.34.1

