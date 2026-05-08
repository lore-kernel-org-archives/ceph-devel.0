Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18264218AF
	for <ceph-devel@vger.kernel.org>; Fri,  8 May 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262596; cv=none; b=UZ+sxNDmR660Xr167flO8hmnIWSFwf0Z7wzhGXdipc5iropMQcI/5e2t7uwKSu0jYb89mh47RnPQxd+OobM/U0vF3QPtIxEYzHh4T6o94n49zNoIWsLUUuJ+hRno8sZYiuYQLCbw1iGihjNgFxU+2mGQXf5oZD0rpAwLWqZcRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262596; c=relaxed/simple;
	bh=u4ME0m1100EkvCeExQwt6TOT2R065IW1fxbghSF1LhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHU9zqLooA7JeKcnwnPNSHSrXjqgIZaOGVVtdfLF1HqHnZSNDn8XHKsgESUlIu8CPJWMhHXZULcRfUlGwRypZbJv/wz3wHQx/q+E5NBBQniPuNWTZmxfqkI6jncpDgc1I4LLG6d+an0//rElYP3j+a0TQXNZXoV3+MzExl4N4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRHMSyUn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sbhVTtrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRHMSyUn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sbhVTtrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778262592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Grp5uB9s1kMDRMEQDniy91FFGKNxYoejXWAs2fHzLIU=;
	b=YRHMSyUnY79hu3CoW70U03oj0t0sTSDaT2n5Fgtfdc8tq8TaX3sZcEqfEQAFSnxGuPouWe
	7GZQLmtyd7GozGtI+pYwVWYcCp5TRmyKZ87dPuvFaT5+EEsUsrGMYPon+NrGt73N6rLWsj
	Fe/g5AiaUo7uBtdbmTt6a0r0rE8oFZc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-02iMFynRNG-SQ_eO5fR5cg-1; Fri, 08 May 2026 13:49:51 -0400
X-MC-Unique: 02iMFynRNG-SQ_eO5fR5cg-1
X-Mimecast-MFC-AGG-ID: 02iMFynRNG-SQ_eO5fR5cg_1778262591
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd8cb25471so45626907b3.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2026 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778262591; x=1778867391; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Grp5uB9s1kMDRMEQDniy91FFGKNxYoejXWAs2fHzLIU=;
        b=sbhVTtrb/I8YWX48F+a8zQ6VnHiO7CX83qcQQiP/YYW+lxAWg2JKmR5S1JitMKtykF
         tYn7N4urxPEEKoff1oRi6Qb3Y/osyqkqBOkcC+Ei2l+CVOkPoBtzp5rd273Uff0qybR2
         94oRY0yFe7AQ/F0xwfu0JEUPU3klpxY/nFEtCVJ2lAUru82LYhNtNNiQnKI+lfAputkw
         8QXGKMyPTwG7qXoG25IfQQ0Zuwy3ysDwrmxBgwYEStvR0qVt20flBkxSYOx3LymRrSaB
         3/xrGvt+tpILNrQHrEdXqbg7QJ2XZocqNU3fLc/qK4hWW9pRuiMBYMhtIxrfzdzrl3Mf
         QX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262591; x=1778867391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Grp5uB9s1kMDRMEQDniy91FFGKNxYoejXWAs2fHzLIU=;
        b=W9WbueOg2o7EkVAhzOwwez74BCxI3pTYtWUcc5FJYb64nbNq9+xO1bK4paeDEBzglK
         wxOW8oUXn8d/tHF4QMG9VQm2PPe9yAcVr5jjJucl7NzZJKZEpiQizESj88xxEqINphOX
         winGqO06cBLNECv3JDU9f14pH+cfYMx+Ug3TQuc600F0mrJAa+hcQoYPNrz755N0OKMr
         M3lgnBEHJoe2SM4NkptOsmQ6ivhLQPo0Tmcns3bAiJeqHouniH1ZgMUVZ9roYx9Qcogu
         cmG1OyEBpH90KmYTUQ3iY+RWQZXlIMks6kpI+E1DmtbFMmuAgOGuTGSzOwZlmt4Z0Tw8
         0x2A==
X-Forwarded-Encrypted: i=1; AFNElJ/0Y3/cV3A3+0Wrba968Llh62Mqt53fIVMye+PF8qkOYBkKg2HTq9XS3xVptj6r+qs9rAjzr94CUjVU@vger.kernel.org
X-Gm-Message-State: AOJu0YzIznku3VOEJupvUmYKt1gbClmY3kwo9cnZU/oBObxUREEEuRaG
	MlrbtsXt9aYgdq5WvA+WN1f/vxElPGJEtyRIh/5gSoSN+zzyPYKBnpHe2lamsHlf1OpQZWGxEV0
	zvxjnj6UBZoTZFl/Q+5FW3+OQYmT0OM6a+4ELHyjQZpeAsQ/Va4RZ5qW0rqQCkbw=
X-Gm-Gg: Acq92OF5F/24PUVBaSEo9rjzR4eQs5qWmR8R1cDVgTE1SY3bTd1GjDlKoHaFYJGEQQK
	RrP82sHKq34X4t2PQw7a007rpy/8vv0jfH4TklE/yze3HPBmHwTNcoVvhIeSj6nJdPJ8biO16yw
	PGBu0X9+5cmsxomn5LHuICCucpup1wbnBp7n5+drEgAbPvbRdFytP3lWH+MC35Cg7XF8o5Iqfcz
	UW7tYtofx4TyDtkf429YmsvYqRFzKoTxKvzSwi6aJcD96jG1tDS3gKb5IMJbKX5mzZ0iqtb3T7+
	C8ZK/2vO0529bGlLONJLmy+82uGEew6sq7ztKxxl98E5AtpESqoMWY2nM0K9E0JbJPRZ7pffTwP
	/L9S/A/tWmhmm/rlgndMIrPFcgMDLKmf0fTKhcWNLgQTL8cF7iHV1
X-Received: by 2002:a05:690c:113:b0:7bf:ff7:ea72 with SMTP id 00721157ae682-7bf0ff7ec09mr74229647b3.34.1778262590375;
        Fri, 08 May 2026 10:49:50 -0700 (PDT)
X-Received: by 2002:a05:690c:113:b0:7bf:ff7:ea72 with SMTP id 00721157ae682-7bf0ff7ec09mr74229147b3.34.1778262589663;
        Fri, 08 May 2026 10:49:49 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm109240167b3.23.2026.05.08.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:49:49 -0700 (PDT)
Message-ID: <d1684248d01ff5399d94e9596e0d4d4904f8e8db.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 00/11] ceph: manual client session reset
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Fri, 08 May 2026 10:49:48 -0700
In-Reply-To: <3bbabebd992c4efef81e4653ee2e04f4644ee57a.camel@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <3bbabebd992c4efef81e4653ee2e04f4644ee57a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 11:28 -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> > This series adds operator-initiated manual client session reset for
> > CephFS, providing a controlled escape hatch for client/MDS stalemates
> > in which caps, locks, or unsafe metadata state stop making forward
> > progress.
> >=20
> > Motivation
> >=20
> > When a CephFS client enters a stalemate with the MDS -- stuck cap
> > flushes, hung file locks, or unsafe requests that cannot be journaled -=
-
> > the only current recovery options are client eviction from the MDS side
> > or a full client node restart.  Both are disruptive and can cascade to
> > other workloads on the same node.
> >=20
> > Manual reset gives the operator a targeted tool: block new metadata
> > work, attempt a bounded best-effort drain of dirty client state while
> > sessions are still alive, then tear sessions down and let new requests
> > re-open fresh sessions.  State that cannot drain (the stuck state
> > causing the stalemate) is force-dropped -- that is the point of the
> > reset.
> >=20
> > Design
> >=20
> > The reset is triggered via debugfs:
> >=20
> >     echo "reason" > /sys/kernel/debug/ceph/<client>/reset/trigger
> >     cat /sys/kernel/debug/ceph/<client>/reset/status
> >=20
> > The state machine tracks four phases:
> >=20
> >     IDLE -> QUIESCING -> DRAINING -> TEARDOWN -> IDLE
> >=20
> > QUIESCING is set synchronously by schedule_reset() before the workqueue
> > item is dispatched.  This provides immediate request gating from the
> > caller's context -- new metadata requests and file-lock acquisitions
> > block the moment the operator triggers the reset, with no race window
> > between scheduling and the work function starting.  All non-IDLE phases
> > block callers on blocked_wq; the hot path adds only a single READ_ONCE
> > per request.
> >=20
> > The drain phase uses a single shared deadline (bounded at 30 seconds)
> > across all drain legs.  It first waits for unsafe write requests
> > (creates, renames, setattrs) to reach safe status, then flushes dirty
> > caps and pushes pending cap releases, using whatever time remains
> > within the shared deadline.  Non-stuck state drains in milliseconds;
> > stuck state times out and is force-dropped during teardown.  The
> > drain_timed_out flag is monotonic: once set by any drain leg, it stays
> > true for the lifetime of the reset.
> >=20
> > The session teardown follows the established check_new_map()
> > forced-close pattern: unregister sessions under mdsc->mutex, then
> > clean up caps and requests under s->s_mutex.  Reconnect is not
> > attempted because the MDS only accepts CLIENT_RECONNECT during its
> > own RECONNECT phase after restart, not from an active client.  A
> > SESSION_REQUEST_CLOSE is sent to each MDS before local teardown so
> > the MDS can release server-side state promptly rather than waiting
> > for session_autoclose timeout.
> >=20
> > Blocked callers are released when reset completes and observe the
> > final result via -EAGAIN (reset failed, retry later) or 0 (success).
> > Internal work-function errors such as -ENOMEM are not propagated to
> > unrelated callers like open() or flock(); the detailed error remains
> > in debugfs and tracepoints.
> >=20
> > The work function checks st->shutdown before each phase transition
> > (DRAINING, TEARDOWN) so that a concurrent ceph_mdsc_destroy() is not
> > overwritten.  If destroy already took ownership, the work function
> > releases session references and returns without touching the state.
> >=20
> > The destroy path marks reset as failed and wakes blocked waiters
> > before cancel_work_sync() so unmount does not stall.
> >=20
> > Patch breakdown
> >=20
> > Prep / cleanup:
> >=20
> >  1. Convert all CEPH_I_* inode flags to named bit-position constants
> >     and switch all flag modifications to atomic bitops (set_bit,
> >     clear_bit, test_and_clear_bit).  The previous code mixed lockless
> >     atomics with non-atomic read-modify-write on the same unsigned
> >     long, which is a correctness hazard.  Flag reads under i_ceph_lock
> >     that only test lock-serialised flags retain bitmask tests.
> >=20
> >  2. Fix a __force endian cast in reconnect_caps_cb() to use the
> >     proper cpu_to_le32() macro and the new test_bit() accessor.
> >=20
> > Hardening / diagnostics:
> >=20
> >  3. Harden send_mds_reconnect() with error return, early bailout for
> >     closed/rejected/unregistered sessions, state restoration on
> >     transient failure.  Rewrite mds_peer_reset() to handle active-MDS
> >     (past RECONNECT phase) by tearing the session down locally.
> >=20
> >  4. Convert wait_caps_flush() to a diagnostic timeout loop that
> >     periodically dumps pending flush state, improving observability
> >     for reset-drain stalls and existing sync/writeback hangs.
> >=20
> > Core feature:
> >=20
> >  5. Add the reset state machine, request gating, session teardown
> >     work function, scheduling, and destroy-path coordination.
> >=20
> >  6. Add the debugfs trigger/status interface and four tracepoints
> >     (schedule, complete, blocked, unblocked).
> >=20
> > Testing:
> >=20
> >  7-11. kselftest-integrated shell tests split into five patches:
> >     data integrity checker (7), stress test with concurrent I/O and
> >     random-interval reset injection (8), targeted corner cases --
> >     overlapping resets, dirty data across reset, stale locks, unmount
> >     during reset (9), five-stage validation wrapper with per-stage
> >     timeouts (10), and kselftest Makefile/MAINTAINERS wiring (11).
> >     All 5 validation stages pass on a real CephFS cluster.
> >=20
> > Changes since v3
> >=20
> >  - Rebased onto testing (7.1-rc1 + ceph fixes).
> >  - Dropped v3 patch 7 ("add trace points to the MDS client") --
> >    already upstream as d927a595ab2f.
> >  - Patch 1: fixed flags type from int to unsigned long in
> >    ceph_pool_perm_check() (Slava).  Added commit message paragraph
> >    documenting the set_bit() conversion in ceph_finish_async_create().
> >  - Patch 3: moved xa_destroy() under s_mutex with comment explaining
> >    serialization against ceph_get_deleg_ino() (Slava).  Added lock
> >    ordering comment at mdsc->mutex acquisition.  Added comment
> >    explaining why mds_peer_reset() narrows the RECONNECT state check
> >    from >=3D to =3D=3D.
> >  - Patch 4: split CEPH_CAP_FLUSH_MAX_DUMP_COUNT into separate
> >    CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES (array bound) and
> >    CEPH_CAP_FLUSH_MAX_DUMP_ITERS (iteration limit) (Slava).  Moved
> >    all flush timeout defines to mds_client.h alongside reset defines
> >    (Slava).  Split comment block into per-field struct documentation
> >    and separate function safety comment for dump_cap_flushes() (Slava).
> >    Fixed for-loop variable declaration to match fs/ceph/ convention.
> >    Fixed commit message to reference the correct macro names and to
> >    stay within 72-column body width.
> >  - Patch 5: added bounded wait for unsafe write requests during the
> >    drain phase, using a shared deadline across all drain legs so the
> >    total drain time stays within CEPH_CLIENT_RESET_DRAIN_SEC.  Made
> >    drain_timed_out monotonic (once set, stays true for the reset).
> >    Replaced spin_lock/spin_unlock around drain_timed_out writes with
> >    WRITE_ONCE() (Slava).  Added ceph_reset_is_idle() inline helper
> >    (Slava).  Added per-field comments to struct ceph_client_reset_state
> >    (Slava).  Changed -EIO return to -EAGAIN for reset-failure
> >    signalling to callers (Slava).  Increased CEPH_CLIENT_RESET_DRAIN_SE=
C
> >    from 5s to 30s (Slava).  Added sessions[i] =3D NULL after
> >    ceph_put_mds_session() in teardown skip path (Slava).  Added comment
> >    at out_sessions label explaining destroy ownership.  Expanded
> >    msleep() comment explaining why event-based waiting is not viable.
> >  - Patch 6: tracepoint placement fixed to fire before -EAGAIN return.
> >  - Patch 11: added MAINTAINERS F: entry for the test directory and
> >    the filesystems/ceph line in the top-level selftests Makefile.
> >=20
> > Alex Markuze (11):
> >   ceph: convert inode flags to named bit positions and atomic bitops
> >   ceph: use proper endian conversion for flock_len in reconnect
> >   ceph: harden send_mds_reconnect and handle active-MDS peer reset
> >   ceph: add diagnostic timeout loop to wait_caps_flush()
> >   ceph: add client reset state machine and session teardown
> >   ceph: add manual reset debugfs control and tracepoints
> >   selftests: ceph: add reset consistency checker
> >   selftests: ceph: add reset stress test
> >   selftests: ceph: add reset corner-case tests
> >   selftests: ceph: add validation harness
> >   selftests: ceph: wire up Ceph reset kselftests and documentation
> >=20
> >  MAINTAINERS                                   |   1 +
> >  fs/ceph/addr.c                                |  20 +-
> >  fs/ceph/caps.c                                |  34 +-
> >  fs/ceph/debugfs.c                             | 103 +++
> >  fs/ceph/file.c                                |  13 +-
> >  fs/ceph/inode.c                               |   5 +-
> >  fs/ceph/locks.c                               |  38 +-
> >  fs/ceph/mds_client.c                          | 800 +++++++++++++++++-
> >  fs/ceph/mds_client.h                          |  52 +-
> >  fs/ceph/snap.c                                |   2 +-
> >  fs/ceph/super.h                               |  70 +-
> >  fs/ceph/xattr.c                               |   2 +-
> >  include/trace/events/ceph.h                   |  67 ++
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/filesystems/ceph/Makefile       |   7 +
> >  .../testing/selftests/filesystems/ceph/README |  84 ++
> >  .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++
> >  .../filesystems/ceph/reset_stress.sh          | 694 +++++++++++++++
> >  .../filesystems/ceph/run_validation.sh        | 350 ++++++++
> >  .../selftests/filesystems/ceph/settings       |   1 +
> >  .../filesystems/ceph/validate_consistency.py  | 297 +++++++
> >  21 files changed, 3185 insertions(+), 102 deletions(-)
> >  create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
> >  create mode 100644 tools/testing/selftests/filesystems/ceph/README
> >  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corn=
er_cases.sh
> >  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stre=
ss.sh
> >  create mode 100755 tools/testing/selftests/filesystems/ceph/run_valida=
tion.sh
> >  create mode 100644 tools/testing/selftests/filesystems/ceph/settings
> >  create mode 100755 tools/testing/selftests/filesystems/ceph/validate_c=
onsistency.py
>=20
> I was able to apply the patchset on the v.7.1-rc2 successfully. Let me ru=
n
> xfstests for the patchset. I'll be back with results ASAP.
>=20
>=20

The xfestests run was successful. I don't see any critical issues with the
patchset.

Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

