Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C83FB072
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467145; cv=none; b=mFQNeN+dLWo6vkVIpNQ3uwUHLMHWA1RwlBdJm/s7Rh+HrALue1/rQOQ/yahtBKo1wg8xBSZ6Bbx8j1nBeSCjEocItGq/HzRwd0Te6DoZ15lEJNAb+NdFMoQwrhSHN7GcmkIAsNg4rQnjM8WPl/+h6/1tU/eTmN68pcUkQVhcON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467145; c=relaxed/simple;
	bh=BwjkyJLeZiqHYyWD5mTk8iHUSaCjTOaIPgA93nRYbtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k7Aqs5xmeeLsNkNhO0meXuvJXQkfJEzAbfmao/JEdezYv0XKeV0z9WcfrWni19b5A9UCbWV5PG/7tCuCaLF9ROWw7wtUu/DLsZ/O2+YhN4ajSNjLWQNUJBPcWqbuLV6xZAWtipS9/fPFLzdDJwHEGsyslPgINULwYGEUJG+JlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFYODH//; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1Qekn0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFYODH//";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Qekn0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCzJ6FkZLDcqrGtXMAH74U+DOuMPDmLoTUfepDou1SI=;
	b=DFYODH//PbW35lGF712J0nSD2IU/ZLDTjL9DMrna+Xm2dEeDx+v5dnZaMMoH80XgE3u9cg
	SYYojb7UwMVZ1jZyY+pdCtfCW4n9m26+RlP1DQgrrLAGHheYFCWHaZMQn8HbjnipzbXpek
	xmRMkI37IgAp+SXKdSowlMTxe8jXG20=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-oRgtkaG1PDywFJcCD-DrGg-1; Wed, 29 Apr 2026 08:52:18 -0400
X-MC-Unique: oRgtkaG1PDywFJcCD-DrGg-1
X-Mimecast-MFC-AGG-ID: oRgtkaG1PDywFJcCD-DrGg_1777467137
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ba70e65b632so1056152566b.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467137; x=1778071937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCzJ6FkZLDcqrGtXMAH74U+DOuMPDmLoTUfepDou1SI=;
        b=E1Qekn0spSxZ7HWn2PLlIrXX0OXcQJddUI3QcMqibAsupLNp4UpX4sDh3G7KkG38cj
         Qmh5IJIQP4CjDtlvhUkAbD9btYh8WlTsE4Iz57B3ECtMtd0U45Olm+zZg1Orfgsbds0Y
         WWBD0FO0xofMZ2d1hHCGf+zamgggy63MqHHpUMSieTT7dSOPOt/Ufip9zFF6auxIgdPp
         W0209oKw7g5dCQfKmKeOEKuS1U6czai1YpvP7eMR/8/ZYq4vn6bS1B2mTyCFGUTDsrzX
         Rj10Px3b47WIh4H90NPsF6StKM/T7x5Y7kUPajUWm4ahjXcMfh13voB4dEH2PJys+DrA
         OeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467137; x=1778071937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCzJ6FkZLDcqrGtXMAH74U+DOuMPDmLoTUfepDou1SI=;
        b=I4Zopo62RejS8Q+dA1/AChl8+Oo2in70o+B5BmGgwgTv5CmnFXp2wXrQvx5TcEJpYB
         DAsM8V6Jq4/VH1O4ZEfhiw0dRMo1muEMKeE93Uko2cZwsujKKzCfujGleoG/FiGgxQ2j
         is3QCFI7eFpS+jYhnBE2LggBzw7HhtAmdQEQjlq+yfvPNwqZV0k6O9ZLk0X2R9odRjRk
         7fHuflQ1HdP4dq2rxT14teKWOqoDXEktUmc8v3zLLIAx/k6QFPyQTMhtOfpzLZEsBrGy
         Gi6T6SkzuvrcWj6jeeJp6hmvWQ+EuQJ2nu+jYsBN1AkU9MN9MqSkxnUDJWkGwkLbjpFC
         8dvw==
X-Gm-Message-State: AOJu0YxWY60qjVBw3en7KAwI9ocE9oduvLe27//mgpK1N+bgfWGzAhQA
	UbSKuXv1srizlfSKVORg5VN2+DQgmj/HyPBciYB0+NvhB2kFidDVegSHKx2ojmfgf0Q/UAhVLNa
	JoTPdiEZiw4Dw1LC/YmM0Zoue52zS+RhorqNA2zGyxdz7MHCxYF1vczRKrpeA/pHomvVXUBJapI
	684Xk8sDBU183IUIX8NYrv6a7T+DIN5WVg5JCE817+g0WKChGZWQ==
X-Gm-Gg: AeBDieuzP6HRBf+fU56bokHY4oVM2Wv9bncqQYUW/uu7howRfGgCxZDmMOwVmKksFLo
	i6DC7l5bws0i8Tai+P905LaNH+PcvB29r85xvkY/Jm933Sr42BjhanVSNbcUNyu0+78Viiq//yj
	rexG2j2EaBSCIFT3wqwmmOepzi+li4wVkXTDeD0Xuj3ee8rhBeqiz4h43yOAzMGdRrLnSiTDV9U
	0YjQXpIfVZfpqNhJdrBYrf7d4RGNjb4ZPcTqcnhVQjOYqz4vc6ddmbGV3oeGlghi4BgOMA0uB7v
	fDYgrQOiksmjoWP0BP30OlXO7w7+tVZah9vLZIHV2Um08z6QluflHhrCUa71CZfOxZAyWX95/0V
	ZPC729T4B7db1gCw8f1TyzTCfxagjeXZnZ13ChdK5jVKmadCCa/cxKWI9bOEaVSeIOQ==
X-Received: by 2002:a17:907:7b9d:b0:ba7:636d:e285 with SMTP id a640c23a62f3a-bb93c2a7c75mr201043966b.7.1777467134514;
        Wed, 29 Apr 2026 05:52:14 -0700 (PDT)
X-Received: by 2002:a17:907:7b9d:b0:ba7:636d:e285 with SMTP id a640c23a62f3a-bb93c2a7c75mr201039666b.7.1777467133603;
        Wed, 29 Apr 2026 05:52:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 00/11] ceph: manual client session reset
Date: Wed, 29 Apr 2026 12:51:55 +0000
Message-Id: <20260429125206.1512203-1-amarkuze@redhat.com>
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

 7-11. kselftest-integrated shell tests split into five patches:
    data integrity checker (7), stress test with concurrent I/O and
    random-interval reset injection (8), targeted corner cases --
    overlapping resets, dirty data across reset, stale locks, unmount
    during reset (9), five-stage validation wrapper with per-stage
    timeouts (10), and kselftest Makefile/MAINTAINERS wiring (11).
    All 5 validation stages pass on a real CephFS cluster.

Changes since v2

 - Patch 1: restored CEPH_I_SHUTDOWN mask define for
   ceph_inode_is_shutdown().  Kept CEPH_I_ERROR_FILELOCK alive for
   bisectability (patch 2 removes it).  Unconditional set_bit() is
   kept for hint flags like ERROR_WRITE -- the extra test-before-set
   branch is redundant on a plain atomic bitop.  Added comments
   clarifying the under-lock flag re-read in ceph_pool_perm_check()
   and the bit-operation sequence in wake_async_create_waiters().
 - Patch 2: unchanged from v2.
 - Patch 3: moved the "reconnect start" log after the early-bailout
   checks.  Added explicit CLOSED/REJECTED cases in the
   mds_peer_reset() switch.
 - Patch 4: reworked dump_cap_flushes() to collect data under
   cap_dirty_lock into an on-stack array and print after releasing
   the lock.  Added truncation count and a final suppression message.
   Changed null cf->ci to WARN_ON_ONCE.  Widened snap field to u64
   to match ceph_snap() return type.  Documented cf->ci
   inode-lifetime guarantee and flush-tid monotonic ordering (acks
   are processed in order under i_ceph_lock, so the latest-ack store
   is correct without max()).  The timeout expression
   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ is kept because 60 * HZ is
   bounded and no conversion helper is needed here.
 - Patch 5: ceph_mdsc_wait_for_reset() maps all internal errors to
   -EIO so unrelated callers (open, flock) do not see raw
   work-function failures like -ENOMEM.  Added max_t() guard on
   deadline-jiffies underflow.  Added st->shutdown checks before
   DRAINING and TEARDOWN phase transitions so a concurrent
   ceph_mdsc_destroy() is not overwritten by the work function.
   Documented the close-grace sleep as a best-effort nudge.
 - Patch 6: removed unused debugfs_reset_trigger and
   debugfs_reset_status struct fields.  Added null-safe access for
   monc.auth->global_id in all four reset tracepoints.
 - Old patch 7: split into five smaller patches (7-11) ordered by
   file dependency.

Changes since v1

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
 fs/ceph/addr.c                                |  17 +-
 fs/ceph/caps.c                                |  34 +-
 fs/ceph/debugfs.c                             | 102 +++
 fs/ceph/file.c                                |  13 +-
 fs/ceph/inode.c                               |   5 +-
 fs/ceph/locks.c                               |  38 +-
 fs/ceph/mds_client.c                          | 735 +++++++++++++++++-
 fs/ceph/mds_client.h                          |  44 +-
 fs/ceph/snap.c                                |   2 +-
 fs/ceph/super.h                               |  70 +-
 fs/ceph/xattr.c                               |   2 +-
 include/trace/events/ceph.h                   |  67 ++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/ceph/Makefile       |   7 +
 .../testing/selftests/filesystems/ceph/README |  84 ++
 .../filesystems/ceph/reset_corner_cases.sh    | 646 +++++++++++++++
 .../filesystems/ceph/reset_stress.sh          | 694 +++++++++++++++++
 .../filesystems/ceph/run_validation.sh        | 350 +++++++++
 .../selftests/filesystems/ceph/settings       |   1 +
 .../filesystems/ceph/validate_consistency.py  | 297 +++++++
 21 files changed, 3110 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

-- 
2.34.1

