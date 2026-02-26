Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B5332902
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117717; cv=pass; b=sd6TgL2oS6Pnb374hyv9RJ3s6Dd8MUQfwu6KEaC9J/jjKgYPUFhd0y6/UAuaIHQ2YQKr1O74zRlIWtzQ4CAWaPbmn7tMLqkwS7tj6U3e391SsJcoC3tB4o+yKMHJs8S3R0FrzYmzAi5oV+P74U1nSYVli/9vk6GRUZz+s7vutdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117717; c=relaxed/simple;
	bh=JjxxiXXZWgMFxudX4ekizp1A/oNO/hFL2M0/NegHUi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIufgGoY/57Ks11mFIXQLM8iJm7qWNnagFObaJKoOi4XKEbVmeG6Cpl6iEypU50J6GdQ+7UFPJdiwlfRQiJVYMXSY5ME4kG3fGjgoa7B46vEQzn721OFmNp74KZY30fv8KTcqgkMnCl2Di+d8mxhNqUhVbHNFNxSZ3bU6OeJfp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXOAbtbO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtdvbAvC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXOAbtbO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtdvbAvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bzt1awm7sHAcRDD8LgZDdEZ4lqJ7TP1WSTZGq6P9xEo=;
	b=HXOAbtbO4sTjpKBs8qMYxlKswPCHqdIf2bQrbbN+BsL7b9LiUyDNftdf+hdRNqF5gg/M13
	TAWs/Y3zvhaW3GCmGWLM0YWKxtknRJ8WrKzJDLyfuTYDmKSDYtthvETCly6fXpqGld0BaY
	ltSMXCTngT2BXqxVo8h/kDYhK/FSBh4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-_6VzDm23MeS7-jAPrU92kA-1; Thu, 26 Feb 2026 09:55:09 -0500
X-MC-Unique: _6VzDm23MeS7-jAPrU92kA-1
X-Mimecast-MFC-AGG-ID: _6VzDm23MeS7-jAPrU92kA_1772117709
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fd145a9d40so1282557137.2
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 06:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772117709; cv=none;
        d=google.com; s=arc-20240605;
        b=iJG5ZGIU+IXbXWsXdLJRF0/M3goZF6YBrlZJg6+BHRw6WIw9L2pkwyF3ZvJr/Cot1v
         V3Whrp5SRW1s20mjrMTwSsOvQ6IXaQ8YzYrsthyYheovhohvtS5Hq6+tUMG1jeajyVFZ
         cx+M2NNlwAAnidtaL2k0lRxAi8UzCIJpMxxmbG9ImxDJc03IfduM8rFZzGkSfG2XhtLW
         DiEVNd+W82CZnpImskhpsj+TNZF6JsQ3WLZTK12jeTY8vAzYQN2OJ65KrDWtpsA9Raac
         /lQWgxYZJiGU0d2z882bm+fQGZV+n28fk8bsjRTBfhxdmZnQs5hd6Hz7NiTz/0uqwMwM
         qnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bzt1awm7sHAcRDD8LgZDdEZ4lqJ7TP1WSTZGq6P9xEo=;
        fh=8l0u/IMevTe27ybXs5OlkEsvMOknoS1EIIe0cqMmo1Y=;
        b=ErDU1cGtOi9m8WOfkFCd74rQmX0eJjIXR7DLz029AOcS527FVPDiW+hfZhdc99Yvx9
         Njd9EgBDj2+5mjrDaFl9MnLvwEVZFt7VTasQKEzaTtWjNgXYxOeQvk7rWDkOQzRCL6v9
         qIsBk7C71yB/UPJ214q7nDRtpiF8xnT82TGy4HrKlHIPkMLgUSL6AzorRSWFacoKilrj
         WFbrUY2OAmYcxYi/4vQ9PZraXDgmD+u8slxIWlTQ+9g4ieUgoB2hAK0v2RD+4A+8Iafp
         MMEapn4uq18mJ3JVyB65rHH9TBKSVSMgNBw99d5+sNgtR6X5T6iZfv+1Gq8vFK21iDdC
         W7rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772117709; x=1772722509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzt1awm7sHAcRDD8LgZDdEZ4lqJ7TP1WSTZGq6P9xEo=;
        b=NtdvbAvCmWzW8ARoUcrzLrsRmP3Bayv1bCZVSt5Rbq3+zyb04fOlQ2CABj09ZXy4nC
         nLrTHfUhXUIKNH8sXxMyhEyGttRLVKq0C4oxGTkz3mTddF+gUPId1oz+8/66pFH72jhe
         7PW4KT9WEl9DHxmiek4TLus6nOkjGU5VcwsO9nkNfCfS1Avg1JG/Iy6rehu2m/lwz7qY
         7ggqKYMhw5NyIvjgYo2IwIop026VaBICDg+pZD3QZHiE+nkNK78UbhyvoqGeQ/4kq+Zh
         NTP+US9OlBaRXl51WTMJWMEWJ1gFsaVjdZZzxqva1bUhWavPNGPntoImaXqpxRJk7oRB
         T1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772117709; x=1772722509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bzt1awm7sHAcRDD8LgZDdEZ4lqJ7TP1WSTZGq6P9xEo=;
        b=Rs1LrRNEucSXOdBgYk4673Ogu+Fm7IU0U5DTbmbDaLSnXc9Nq+ByixQjhu3KZiHXd5
         4ll3X0z+5rI2Rq2IcHgBQgFxfxE9axxlS9jURYcsktJVNtYRfBcWxaHVTGHM5nNhus9I
         8zFRzivsOrddHFDFBHxsvAccopXxyu+PIJH9ApCYm3uD3ckt4uzrG9ARh0h9X2rbrmpq
         GlA6yK8d6sUuQKOtR52dsHgn2Our1vScb0ChyXa8MiUzJQ2u2B9gMVW67+MNgCAyK+3/
         X1ZIHAimMpK9g16g/enqgK7Hw7s9UoGtCpXc9aJpm4sVcEDqq0piodFq8zIXo6cjnui+
         xNYQ==
X-Gm-Message-State: AOJu0Yyo3NFklB1w7PNFCw7O0SKYLJpHBiiYokD09t3j/H6HGkpRUoGk
	GLjxx1R3rfUV2BVV4uEN/SRAyHbvS21IbG3koI3Nm4GzKgXpTbfMIy/a/L3k8rzjT8c9tMR4L/k
	EgTudBydYugHkyNdhZS078oX/lsXaOdU8unBGaWwmes2fE5JX3y+jFPshT6RDWOtXvYbxWN/z4s
	bgCcUx/I98SZqSEw7ETCkLbN8k25zsbnopqMwxpQ==
X-Gm-Gg: ATEYQzwc8evGFWvIwu9GRDbb4rcZa9T4skyAt5Ca02YqXT16szzGFFvK0zoG9j/ZUvk
	x12xEZPv/uxIVuAjkrDVp/hRcSpVrmUNqw66+NX7C1UfWVN70ES83lZe7/ykCzBTRhwk3YP78GD
	JdGGEqH27zPg7cr3WXtlUN85w/n6Nt8RLkMZDeXzy8FkmGWTQtm/wSYnUY7Qs85O3GAwtUXpACJ
	AhTfHtsRMF8U7MiZqDxxOcGOA==
X-Received: by 2002:a05:6102:ccd:b0:5ff:2cdb:4bf3 with SMTP id ada2fe7eead31-5ff2cdb4f19mr363124137.2.1772117708525;
        Thu, 26 Feb 2026 06:55:08 -0800 (PST)
X-Received: by 2002:a05:6102:ccd:b0:5ff:2cdb:4bf3 with SMTP id
 ada2fe7eead31-5ff2cdb4f19mr363105137.2.1772117707934; Thu, 26 Feb 2026
 06:55:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225125907.53851-1-amarkuze@redhat.com> <c64f9d66a10d151e3725336d2980f56ca5aff5a4.camel@redhat.com>
In-Reply-To: <c64f9d66a10d151e3725336d2980f56ca5aff5a4.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 26 Feb 2026 16:54:56 +0200
X-Gm-Features: AaiRm53XGOPV7oe7JMKPNdUKSqAPSxfZFf9OZj0774GR3VFmCVT2wZ2vkQNlFtg
Message-ID: <CAO8a2SgkgCDubKkRp6ZOQVFpbTEXbSX9Rjooya6x4DF_R-PEBA@mail.gmail.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 0/4] ceph: manual client session reset
 via debugfs
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> What do you mean by "reason text"? Usually, it should be some command. Do=
 you
> mean that any string will trigger the reset? Is it good approach? What if=
 a user
> sends something by mistake or any malicious garbage? Potentially, it coul=
d be
> security breach.

The string is an optional free-form operator note that gets logged and
recorded in the status output for post-mortem diagnostics (e.g.
"RHBZ#12345" or "mds0 stuck after failover"). Any write to the
trigger file initiates the reset -- the content is not interpreted as
a command.

The input length is capped at `CEPH_CLIENT_RESET_REASON_LEN - 1`
(63 bytes) via `min_t()` before `copy_from_user()`, then
null-terminated and `strim()`'d. Anything longer is silently
truncated -- no overflow is possible.

Regarding security: the trigger file is created with mode 0200
(write-only, owner-only), and debugfs itself is typically mounted
root-only. So the write is restricted to a privileged operator, same
as any other debugfs knob. That said, I agree the interface question
is open -- see below.

> This "reset/status" sounds slightly ambiguous. Is it status of reset proc=
ess? If
> we didn't request the reset, then what this status means?

It is the status of the reset subsystem. When no reset has been
requested, it shows the idle state:

```
in_progress: no
trigger_count: 0
success_count: 0
failure_count: 0
last_start_ms_ago: (never)
last_finish_ms_ago: (never)
last_errno: 0
last_reason: (none)
inject_error_pending: no
pending_reconnects: 0
blocked_requests: 0
```

Happy to rename it to something less ambiguous, maybe
`reset/reset_status` or just moving the counters into the existing
top-level `status` file. Open to suggestions.

> Recently, I had short discussion with Greg Kroah-Hartman. He was complete=
ly
> against of using sysfs for transferring commands from user-space to kerne=
l-
> space. So, we could have troubles of using sysfs for this. And
> /sys/kernel/debug/ sounds like completely wrong place. Because, this is n=
ot
> debug feature or option. You are suggesting this as a regular feature for
> production.
>
> Maybe, we can consider eBPF here?

Yeah, debugfs is not the right place for a production feature.

The debugfs interface is there for now as a development/testing
trigger while the core reset mechanism is reviewed. The longer-term
goal is automated recovery: the client would detect stuck/hung
sessions and trigger the reset internally without operator
intervention. Once that's in place, the manual trigger becomes a
fallback rather than the primary interface.

For production manual triggering (before automated recovery is
ready), we can consider other approaches, e.g.,  ioctl, netlink, or
extending the existing `recover_session=3Dclean` path. That path
already handles automatic recovery from blocklisting via
`maybe_recover_session()` / `ceph_force_reconnect()`; the manual
reset solves a related but different problem (sessions stuck without
blocklisting), so the machinery could potentially be unified.

> So, we have "MDS sessions become stuck or hung" and we are trying to subm=
it
> another request. Is it sane enough? We already have a dead session. :)

The gating does not submit requests to the dead session, it does
the opposite. When a reset is in progress,
`ceph_mdsc_wait_for_reset()` blocks new incoming requests (and new
lock acquisitions) until the reset completes and sessions are
re-established. Only then do the blocked requests proceed through
the normal `__do_request()` path, which will find the freshly
reconnected sessions.

The "best-effort" note refers to the fact that we don't take a lock
on the hot path, a request could slip past the check in the narrow
window before `in_progress` is set. That's acceptable because such
a request would either complete normally on the still-alive session
or fail and be retried by the caller after the reset.

> I think we already have some timeout option in the mount options. Are you
> suggesting yet another one?

Fair point. The existing `mount_timeout` controls how long mount and
reconnect operations wait. The two timeouts here are:

- 60s for the reset work to wait for session reconnects to complete
- 120s for blocked requests to wait for the reset to finish

I think these can stay as compile-time constants
(`CEPH_CLIENT_RESET_TIMEOUT_SEC` / `CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC`)
rather than becoming mount options. They're operational bounds for a
rare manual operation, not something an admin would typically need to
tune. If reviewers feel otherwise I can tie them to `mount_timeout`.

> Do you mean patch 3 or 4? Because, patch 3 is huge in size.

You're right, patch 3 is the large one (~700 lines). I can split it
further if that helps review. A natural split would be:

- 3a: `ceph_client_reset_state` struct, init/destroy, and
  `ceph_mdsc_wait_for_reset()` blocking infrastructure
- 3b: `ceph_mdsc_reset_workfn()`, `send_mds_reconnect()` changes,
  and session completion tracking
- 3c: debugfs interface (trigger, status, inject_error)
- 3d: tracepoints

Let me know if that granularity makes sense or if you'd prefer a
different split.

Thanks for the review, Slava.

On Wed, Feb 25, 2026 at 10:51=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> > In production CephFS deployments we regularly encounter situations
> > where MDS sessions become stuck or hung, requiring a full unmount/
> > remount cycle to recover.  This is disruptive for workloads that
> > cannot tolerate the downtime or the loss of cached state that comes
> > with unmounting.
> >
> > This series adds a mechanism to manually trigger MDS session
> > reconnection from the client side without unmounting, exposed via
> > debugfs:
> >
> >   echo "reason text" > /sys/kernel/debug/ceph/<fsid>/reset/trigger
>
> What do you mean by "reason text"? Usually, it should be some command. Do=
 you
> mean that any string will trigger the reset? Is it good approach? What if=
 a user
> sends something by mistake or any malicious garbage? Potentially, it coul=
d be
> security breach.
>
> >   cat /sys/kernel/debug/ceph/<fsid>/reset/status
>
> This "reset/status" sounds slightly ambiguous. Is it status of reset proc=
ess? If
> we didn't request the reset, then what this status means?
>
> >
> > The reset lifecycle:
> >   1. Operator writes to the trigger file
> >   2. A work item collects all active sessions and initiates
> >      reconnection on each (via send_mds_reconnect with from_reset=3Dtru=
e)
> >   3. New metadata requests and lock acquisitions are blocked until
> >      the reset completes (120s timeout)
> >   4. Session completions are tracked via a per-session generation
> >      counter to handle stale completions from timed-out prior resets
> >   5. Lock reclamation is always attempted during reset-initiated
> >      reconnects, regardless of prior CEPH_I_ERROR_FILELOCK state
> >
> > Patch breakdown:
> >   1. Convert CEPH_I_* flags to named bit positions so test_bit/
> >      set_bit/clear_bit can be used in reconnect paths
> >   2. Make wait_caps_flush() bounded with periodic diagnostic dumps
> >      to aid debugging hung flush scenarios (independent improvement
> >      that surfaced during development)
> >   3. The core reset implementation: debugfs interface, reset work
> >      function, request/lock blocking, tracepoints, and session
> >      reconnect completion tracking
> >   4. Rework mds_peer_reset() to properly handle all session states
> >      and integrate with the reset completion tracking
> >
> > Open questions / areas for review:
> >   - Is debugfs the right interface, or should this be a mount option
> >     / sysfs attribute / netlink command?
>
> Recently, I had short discussion with Greg Kroah-Hartman. He was complete=
ly
> against of using sysfs for transferring commands from user-space to kerne=
l-
> space. So, we could have troubles of using sysfs for this. And
> /sys/kernel/debug/ sounds like completely wrong place. Because, this is n=
ot
> debug feature or option. You are suggesting this as a regular feature for
> production.
>
> Maybe, we can consider eBPF here?
>
> >   - The request gating in ceph_mdsc_submit_request() is best-effort
> >     (no lock serialization) to avoid penalizing the normal path.
> >     Is this acceptable?
>
> So, we have "MDS sessions become stuck or hung" and we are trying to subm=
it
> another request. Is it sane enough? We already have a dead session. :)
>
> >   - Should the 60s reconnect timeout and 120s blocked-request timeout
> >     be configurable (e.g. via mount options)?
>
> I think we already have some timeout option in the mount options. Are you
> suggesting yet another one?
>
> >   - mds_peer_reset() rework (patch 4) is substantial -- would
> >     reviewers prefer it split further?
>
> Do you mean patch 3 or 4? Because, patch 3 is huge in size.
>
> Thanks,
> Slava.
>
> >
> >
> > Alex Markuze (4):
> >   ceph: convert inode flags to named bit positions
> >   ceph: add bounded timeout and diagnostics to wait_caps_flush()
> >   ceph: implement manual client session reset via debugfs
> >   ceph: rework mds_peer_reset() for robust session recovery
> >
> >  fs/ceph/caps.c              |   7 +
> >  fs/ceph/debugfs.c           | 171 ++++++++++-
> >  fs/ceph/locks.c             |  24 +-
> >  fs/ceph/mds_client.c        | 577 ++++++++++++++++++++++++++++++++++--
> >  fs/ceph/mds_client.h        |  33 +++
> >  fs/ceph/super.h             |  60 ++--
> >  include/trace/events/ceph.h |  60 ++++
> >  7 files changed, 879 insertions(+), 53 deletions(-)
>
>

