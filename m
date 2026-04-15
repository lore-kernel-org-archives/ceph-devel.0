Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2764396567
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272519; cv=none; b=pmsUVtTNzn0ar1mw4MoscDPIiRzl3fn6OULbKCX4dLeSuanFU3MmXIchzyBqSmfLA/8x2cr2TySAlskW16aJuPHt//ci7rTBX5v3m3IFhMmiNErMuav8Kpw4SfUhaLuHVBiFMz++rjUBL8cZ1DtxrBDEwn9sTnda2hVJCJg+1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272519; c=relaxed/simple;
	bh=EjpLUZD65b4tabg+yzSnnYbDXhagBAIufBacfc+cllk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i/IMq9kvt7vMIc/hFOz0mIx2mdRsKGZvHfyRozUYnuN3tHOK1eIjXYER6pBkuVbadMtm+1ito5p5yuuk4mzbMbRQ4HIhfCeqL0MqYJ51gdsxE4GALFiwoC7r6HFBv63JHXv0dOy+l1clyX7Rypc6p62T3+0pUJgynfe1Q1pax6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI6W+HGC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=odByD+At; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI6W+HGC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="odByD+At"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H4wsvwRJbqgcLtEjgPuYkCxpD7ZHOSfOGTS4tTJGptA=;
	b=MI6W+HGCvORXjzx1uCKETbisUvjhBg9QwFtxr59JqsVEzKug9jQjRJzl/hPXUvxAYBsFxs
	W8TG0pfJJTS1TU391y2TIelvPe+eC927WGcRPpZIVhhLqqzZljxnVaY3b22NAFcHXiIQmL
	+YoMwM3JWExuytvTLcAoitXZaZ7cGCM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-h3OJSDVTOGSDRLy4STfX7Q-1; Wed, 15 Apr 2026 13:01:55 -0400
X-MC-Unique: h3OJSDVTOGSDRLy4STfX7Q-1
X-Mimecast-MFC-AGG-ID: h3OJSDVTOGSDRLy4STfX7Q_1776272515
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca6f796d5so117543786d6.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272514; x=1776877314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4wsvwRJbqgcLtEjgPuYkCxpD7ZHOSfOGTS4tTJGptA=;
        b=odByD+At41nheLjEeH8pyOv8YkAn6Q2ng95mjgKmXK5GiZg6Dj7aTGwPndugVz5mbG
         IxPdJCTN3E7s1LkVIAixSCjqmBOjyaYgtmv37mmTU39DcbUtyRr1C5ooSsw/Z8Un4oz9
         5ZSiRVZbAz0fvr3aHKsd8sJAhoTVzDtf5IsjJ7IAev0bumSG1Lt9NlZqjLyjmJkS7LGR
         PoIVyJB/4PredtunK2jPOWPKlHF7rsnZjbcleWKXAQj4tDJu3/2Fge4bOfPTUQnWGDb2
         FVyu4CZnzc1YP59Jknc2xEisIbQn1J78q7IrjZ5pbeDTbKJddU83Uu/rQ2b4vGJtALjq
         Tx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272514; x=1776877314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4wsvwRJbqgcLtEjgPuYkCxpD7ZHOSfOGTS4tTJGptA=;
        b=kt9S/qlXqiEpx1HhIzYEQ+MUhtHDdxWHORT5lc5AW/iaHTkNqKNSRcmspvbtg1WRu4
         3RxyM9iF1h1KJSD76l8wOJOz5i4uvp8hpSuo6d/7atxtIZvGEHmjQlA93k4yZyqlx8d7
         Gw/Wrqn/mDq6Y1+zWmc0MMkiaUBFQ5PGPZ+c8c0nqRyPR4/sTKOYapjwjcOzWSJYEkLj
         LIqAdFVBC5ABhzVJAtApGyNa0VPAG4gEGx0yx2Gc3kgZ1pH9h1KwEYKDHYCk0+1ClXG8
         OdKDLGJOWCsmXBjORyWmajHF38T9Lct36ueJFh/upPs2+JSoSklW3P/U7lA3N/qCvGGf
         cC2g==
X-Gm-Message-State: AOJu0YwagPWsYtL8tAsGQh6hMbecBrckoeYUBJ4fO2n5ZcAYnng9srkV
	cZgECL+E/rqYzbzwtQbOadbOLbX4kJjdG/40H/MrPaD1Nkh+W7GrUmuNpPAAS6tAwX9H8YTvVG5
	+pSFmC5uo3TaUauRfQbgP7QT/gUzhUHtN8zFkdjC9RTilGSgm5V5z8NuZ92OnIeHw18dj2ENSp5
	YFWcBuYB6sCacMombXPPbWteqp1y5ojHccmqns0GJ6Ksi9DeMt1g==
X-Gm-Gg: AeBDiesUVFXTQS08u38pblXUDoSR0DuSwBOVat39mCA+tGhn7V2/fHw7BSCPLoyWfJp
	lTIgio5qo1reXx45iAPD4YoRNHAqzrM17/4sk/+kODVt6wGOhhQ61KP/JfqVaCWdYA6dpaHHqn4
	+7CxehTbVka0/H88lY3pTsYXqug7eLdaT+CSLgmjHD86t3JbHdqL7HkgSojhauMH07CJGnk6lRQ
	WHWZlDSqKNnxCUkBbTBd5OydHeGVSiAdtbuNqDj4m6diBufQNFdLhXcanhSFDeGomD7WY66CRns
	Dv6lNGAFa+wB56NLceQnTDzMnfKbH+VWlqr/3UKsO980KrVg2Xlggk4Mb3Ov6AbT7Hjdq4jXf20
	8T04aWhumyd0zKEVYaSt0hz4cB4lW52Oda5Qjz0xLlI99glOyaAXJMSpyoBhbgbZCXw==
X-Received: by 2002:ac8:5ac4:0:b0:50d:e298:8f1c with SMTP id d75a77b69052e-50defc74506mr255466861cf.32.1776272504776;
        Wed, 15 Apr 2026 10:01:44 -0700 (PDT)
X-Received: by 2002:ac8:5ac4:0:b0:50d:e298:8f1c with SMTP id d75a77b69052e-50defc74506mr255421761cf.32.1776272458487;
        Wed, 15 Apr 2026 10:00:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:00:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 0/7] ceph: manual client session reset
Date: Wed, 15 Apr 2026 17:00:36 +0000
Message-Id: <20260415170043.3882912-1-amarkuze@redhat.com>
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
----------

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
------

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

The drain phase (bounded at 5 seconds) flushes the MDS journal, dirty
caps, and pending cap releases.  Non-stuck state drains in milliseconds;
stuck state times out and is force-dropped during teardown.

The session teardown follows the established check_new_map() forced-close
pattern: unregister sessions under mdsc->mutex, then clean up caps and
requests under s->s_mutex.  Reconnect is not attempted because the MDS
only accepts CLIENT_RECONNECT during its own RECONNECT phase after
restart, not from an active client.  A SESSION_REQUEST_CLOSE is sent to
each MDS before local teardown so the MDS can release server-side state
promptly rather than waiting for session_autoclose timeout.

Blocked callers are released when reset completes and observe the final
result.  The wait path verifies the phase is still IDLE under the lock
after wakeup, looping back if a new reset was scheduled in the interim.

Patch breakdown
---------------

Prep / cleanup:

 1. Convert all CEPH_I_* inode flags to named bit-position constants
    and switch all flag modifications to atomic bitops (set_bit,
    clear_bit, test_and_clear_bit).  The previous code mixed lockless
    atomics with non-atomic read-modify-write on the same unsigned long,
    which is a correctness hazard.  Flag reads under i_ceph_lock that
    only test lock-serialised flags retain bitmask tests.

 2. Fix a __force endian cast in reconnect_caps_cb() to use the proper
    cpu_to_le32() macro and the new test_bit() accessor.

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

 7. Add kselftest-integrated shell tests: stress testing with
    concurrent I/O and random-interval reset injection, targeted
    corner cases (overlapping resets, dirty data across reset,
    stale locks, unmount during reset), a five-stage validation
    wrapper with per-stage timeouts, and a post-run data integrity
    checker.  All 5 validation stages pass on a real CephFS cluster.

Changes since v1
-----------------

 - Patch 1 now converts ALL flag modifications to atomic bitops,
   eliminating the mixed atomic/non-atomic RMW hazard on the shared
   i_ceph_flags field.  Removed mask defines for flags that are only
   accessed via the _BIT form.  Fixed Co-authored-by -> Co-developed-by.
 - Rewrote mds_peer_reset() to handle active-MDS state correctly
   instead of sending a doomed reconnect (patch 3).
 - Added state restoration in send_mds_reconnect() failure path to
   prevent sessions stranding in RECONNECTING (patch 3).
 - Added early bailout checks in send_mds_reconnect() for
   closed/rejected/unregistered sessions (patch 3).
 - Added diagnostic timeout loop to wait_caps_flush() (patch 4).
 - Patch 5 commit message now documents the QUIESCING phase purpose
   (synchronous request gating before async work dispatch).
 - Fixed TOCTOU in ceph_mdsc_wait_for_reset(): the phase is now
   re-verified under the lock after wakeup, with a deadline-based
   retry loop if a new reset was scheduled in the interim (patch 5).
 - Added tracepoints for reset lifecycle events (patch 6).
 - Added selftest validation harness with kselftest integration
   (patch 7).
 - Rebased onto v7.0.

Alex Markuze (7):
  ceph: convert inode flags to named bit positions and atomic bitops
  ceph: use proper endian conversion for flock_len in reconnect
  ceph: harden send_mds_reconnect and handle active-MDS peer reset
  ceph: add diagnostic timeout loop to wait_caps_flush()
  ceph: add client reset state machine and session teardown
  ceph: add manual reset debugfs control and tracepoints
  ceph: add manual reset selftests and validation harness

 MAINTAINERS                                   |   1 +
 fs/ceph/addr.c                                |  16 +-
 fs/ceph/caps.c                                |  29 +-
 fs/ceph/debugfs.c                             | 104 +++
 fs/ceph/file.c                                |  12 +-
 fs/ceph/inode.c                               |   5 +-
 fs/ceph/locks.c                               |  38 +-
 fs/ceph/mds_client.c                          | 656 ++++++++++++++++-
 fs/ceph/mds_client.h                          |  44 +-
 fs/ceph/snap.c                                |   2 +-
 fs/ceph/super.h                               |  73 +-
 fs/ceph/xattr.c                               |   2 +-
 include/trace/events/ceph.h                   |  63 ++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/ceph/Makefile       |   7 +
 .../selftests/filesystems/ceph/README.md      |  84 +++
 .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++++
 .../filesystems/ceph/reset_stress.sh          | 694 ++++++++++++++++++
 .../filesystems/ceph/run_validation.sh        | 350 +++++++++
 .../selftests/filesystems/ceph/settings       |   1 +
 .../filesystems/ceph/validate_consistency.py  | 297 ++++++++
 21 files changed, 3025 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

--
2.34.1

