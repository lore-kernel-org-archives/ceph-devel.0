Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46435DA71
	for <ceph-devel@vger.kernel.org>; Tue,  3 Mar 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577442; cv=none; b=GURxa8h5i2Z5O2qZ51TQkw2t/SzVS5riwWO+gkdDVVVM0Hia+Lx7Ik/a8rcvGKpNcbKlr+Kp076XX+YTrf82ienIWwumO5B7TzXcjAxo45AumxC4sEdNh0WgEy1bsd5/31BJp5o7tN+fOlDYn9AwZsVdsUgdYhpidNHBMpgldPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577442; c=relaxed/simple;
	bh=5pmS8fF2W99C0594GClt6XF/N3xiVI/srFHO6JIl+nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZVbSSHkWEN3Co0v6NLtttJCnHbfX0uOGiQXCzSgbJiJnQ55M3TNU4AIqbvdFgL0yBiojfL8wGmhU6478lSJr+A8h8/8Ob2Q2D9ILt0uhXl/SoSmK5ZZR6CQxCQG+BiuqYapmgk0B54B1N++6UhOImVUVRx+CK8kMy/rj2RCYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFgZ2Bam; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pE1VhOFa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFgZ2Bam";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pE1VhOFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772577440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onOrEzUV0c7gKK623ROJRQeG1aWC/oa+9/nT9NgXSqE=;
	b=DFgZ2BamrJjO8hldsJFbQnyoE6Gw2qXRx4dRThSfj6vKMX4hAB7EY6jwQzMcbKN47JtXt6
	i3Z6pHy30m++hxZuK0D7JOTfHcAEyDqcu2xVK8uEta5QxdQoqmUwymRg3oedNCtiNooR70
	uYgf8Pniv3H8NYl0Xs8neresopmTJwo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-fH_NjBL2PT2lGXePF4uMhw-1; Tue, 03 Mar 2026 17:37:19 -0500
X-MC-Unique: fH_NjBL2PT2lGXePF4uMhw-1
X-Mimecast-MFC-AGG-ID: fH_NjBL2PT2lGXePF4uMhw_1772577438
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40ee65ba6f9so10534265fac.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Mar 2026 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772577438; x=1773182238; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onOrEzUV0c7gKK623ROJRQeG1aWC/oa+9/nT9NgXSqE=;
        b=pE1VhOFaEhlLiZn/Jab+HV7x8k6vjor4imhV5jkPOI7Nc8sGdTcRECr7hqDak/tj82
         6ckCrhLh6W3e7pmMaai7a1xJAWPNbHSHiXIgXPKs2UOgzArV0jySVJUyWiUbhcMgyYgq
         LRqCa9gmBfhlWFb57Hjiks1IkkvkrOAyv4CHt/7oEBd9JdE/QJ++tduWoMLmBhx4bLci
         Qb3OOvYBKwKh+0YhwSP6JabG/WmGcpztKzSX8sePsNaow5PufanRVPP9kzISZ4m0vCEL
         g52aovCfS0SvvvXq/7lRimxpLvH8kH2mQAOXTGWnwXQUv+GTTofTR7dsO0QXXa3lrliT
         vSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577438; x=1773182238;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onOrEzUV0c7gKK623ROJRQeG1aWC/oa+9/nT9NgXSqE=;
        b=a/jL9GQcJo/yAGv8MrbAwmBm28BPAfIRbnvRnp5puRkXvHysmHtJFTm8QSR+frf73E
         T3OoXjBiByJvvgvf3xJSKTxEF8muPUy3UuoIUZ7Em1NCp0P943ByksuWZgc157xN0jpg
         4+Hh6wnT2OgDtN4tDRc0j2sxG/Hjl67SjBYZxSchaUCOuxL1RoSEWf68p79oAktd5bAG
         c1GhcVFrJHG5wrq0OPsO059khW1aCVdM92+4OJYGFT6n5howb4FdNaoSTRgzLb25KOyg
         zf49tUwEM9GjjmXT5sMqDOZ+GvyAzIpDXKYGYjuwATqZmT4D6CErLVhXLtTUJWzK5PBq
         Qxgg==
X-Gm-Message-State: AOJu0YwzJBHgyMgeTMl8+wwNWnwcdFISqT3L1gezwvE38psGLsGCj7Ox
	bLV0rzlGpbBspBXOhytUVtKTTuxXrSrKkwqoXAdDTPFCPw/guuwwEzbeXELnK60OcVmYRunG75M
	Pzwi2EELCRxsPjFBuc5uhM9WIAZA5EZI3vhUlE2srEVGD7FXJpBTF6GpH//qXp3o=
X-Gm-Gg: ATEYQzyxqQS8ubSJG50fYNSNIj8QyVsBpy+/gZs9QX28MoW+azfK4C5pLOlvsKfEmVZ
	swfLY/1uJRrnQchW0vjKMVoc5kLM+auqU8R6wrB9nZhGar3fe+Fa5TLo9PfXDEmeC05foUv6EcC
	KH0f59iQB+PwasEiaOOSuD15fYZmoL7Lm3De5MzKg0klb40KQain4EwKzYQ4Dgr6b8Mhiz327ys
	waGDlZqgPBwRzX7CHPJSgO59yopzCsmjD0ZOKFVO4+H92z/JtJdXvD/V0LvWo2wAju44bx8E0EZ
	pHmkKPdpSBT/kjhPLlMXGGtXv0FTsFK/HoDuYh6RkkG5YLzwRjy5j/rtlQraI2kRgcc4prNqHRV
	Xk8JYHoEHhjQXwRAkLvugNF0fmhvOJumbiDoHpOGgaAUD/COBDxW1
X-Received: by 2002:a05:6871:4c9:b0:409:e025:a47f with SMTP id 586e51a60fabf-416270cf118mr11379237fac.53.1772577438109;
        Tue, 03 Mar 2026 14:37:18 -0800 (PST)
X-Received: by 2002:a05:6871:4c9:b0:409:e025:a47f with SMTP id 586e51a60fabf-416270cf118mr11379225fac.53.1772577437645;
        Tue, 03 Mar 2026 14:37:17 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cff1aacsm15261678fac.9.2026.03.03.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:37:16 -0800 (PST)
Message-ID: <a89f7def4cba0efd018a46c4e4281f6c1c9b5bd9.camel@redhat.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 0/4] ceph: manual client session reset
 via debugfs
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 03 Mar 2026 14:37:15 -0800
In-Reply-To: <CAO8a2SgkgCDubKkRp6ZOQVFpbTEXbSX9Rjooya6x4DF_R-PEBA@mail.gmail.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
		 <c64f9d66a10d151e3725336d2980f56ca5aff5a4.camel@redhat.com>
	 <CAO8a2SgkgCDubKkRp6ZOQVFpbTEXbSX9Rjooya6x4DF_R-PEBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 16:54 +0200, Alex Markuze wrote:
> > What do you mean by "reason text"? Usually, it should be some command. =
Do you
> > mean that any string will trigger the reset? Is it good approach? What =
if a user
> > sends something by mistake or any malicious garbage? Potentially, it co=
uld be
> > security breach.
>=20
> The string is an optional free-form operator note that gets logged and
> recorded in the status output for post-mortem diagnostics (e.g.
> "RHBZ#12345" or "mds0 stuck after failover"). Any write to the
> trigger file initiates the reset -- the content is not interpreted as
> a command.

First of all, people are lazy and nobody like to compose any string. So, yo=
u
will have completely useless strings at the end of the day ("1234", "dgdgdf=
fgd",
or something like this). This string could be really confusing point becaus=
e
everybody will expect to have some clear command that triggers the reset. I
expect that end-users will be confused by likewise "free-form operator".

>=20
> The input length is capped at `CEPH_CLIENT_RESET_REASON_LEN - 1`
> (63 bytes) via `min_t()` before `copy_from_user()`, then
> null-terminated and `strim()`'d. Anything longer is silently
> truncated -- no overflow is possible.
>=20
> Regarding security: the trigger file is created with mode 0200
> (write-only, owner-only), and debugfs itself is typically mounted
> root-only. So the write is restricted to a privileged operator, same
> as any other debugfs knob. That said, I agree the interface question
> is open -- see below.
>=20
> > This "reset/status" sounds slightly ambiguous. Is it status of reset pr=
ocess? If
> > we didn't request the reset, then what this status means?
>=20
> It is the status of the reset subsystem. When no reset has been
> requested, it shows the idle state:
>=20
> ```
> in_progress: no
> trigger_count: 0
> success_count: 0
> failure_count: 0
> last_start_ms_ago: (never)
> last_finish_ms_ago: (never)
> last_errno: 0
> last_reason: (none)
> inject_error_pending: no
> pending_reconnects: 0
> blocked_requests: 0
> ```
>=20
> Happy to rename it to something less ambiguous, maybe
> `reset/reset_status` or just moving the counters into the existing
> top-level `status` file. Open to suggestions.

Frankly speaking, I expected to see something like:

/sys/fs/ceph/<info>

And if we are talking about MDS sessions, then, maybe, we need to have MDS =
node
and some status there:

/sys/fs/ceph/<fsid>/mds/status

>=20
> > Recently, I had short discussion with Greg Kroah-Hartman. He was comple=
tely
> > against of using sysfs for transferring commands from user-space to ker=
nel-
> > space. So, we could have troubles of using sysfs for this. And
> > /sys/kernel/debug/ sounds like completely wrong place. Because, this is=
 not
> > debug feature or option. You are suggesting this as a regular feature f=
or
> > production.
> >=20
> > Maybe, we can consider eBPF here?
>=20
> Yeah, debugfs is not the right place for a production feature.
>=20
> The debugfs interface is there for now as a development/testing
> trigger while the core reset mechanism is reviewed. The longer-term
> goal is automated recovery: the client would detect stuck/hung
> sessions and trigger the reset internally without operator
> intervention. Once that's in place, the manual trigger becomes a
> fallback rather than the primary interface.
>=20
> For production manual triggering (before automated recovery is
> ready), we can consider other approaches, e.g.,  ioctl, netlink, or
> extending the existing `recover_session=3Dclean` path. That path
> already handles automatic recovery from blocklisting via
> `maybe_recover_session()` / `ceph_force_reconnect()`; the manual
> reset solves a related but different problem (sessions stuck without
> blocklisting), so the machinery could potentially be unified.

The ioctl sounds like more reasonable way. However, this /sys/../<trigger_r=
eset>
sounds like an easy way to initiates the reset from command line.

>=20
> > So, we have "MDS sessions become stuck or hung" and we are trying to su=
bmit
> > another request. Is it sane enough? We already have a dead session. :)
>=20
> The gating does not submit requests to the dead session, it does
> the opposite. When a reset is in progress,
> `ceph_mdsc_wait_for_reset()` blocks new incoming requests (and new
> lock acquisitions) until the reset completes and sessions are
> re-established. Only then do the blocked requests proceed through
> the normal `__do_request()` path, which will find the freshly
> reconnected sessions.
>=20
> The "best-effort" note refers to the fact that we don't take a lock
> on the hot path, a request could slip past the check in the narrow
> window before `in_progress` is set. That's acceptable because such
> a request would either complete normally on the still-alive session
> or fail and be retried by the caller after the reset.
>=20
> > I think we already have some timeout option in the mount options. Are y=
ou
> > suggesting yet another one?
>=20
> Fair point. The existing `mount_timeout` controls how long mount and
> reconnect operations wait. The two timeouts here are:
>=20
> - 60s for the reset work to wait for session reconnects to complete
> - 120s for blocked requests to wait for the reset to finish
>=20
> I think these can stay as compile-time constants
> (`CEPH_CLIENT_RESET_TIMEOUT_SEC` / `CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC`)
> rather than becoming mount options. They're operational bounds for a
> rare manual operation, not something an admin would typically need to
> tune. If reviewers feel otherwise I can tie them to `mount_timeout`.

Potentially, we could have both options available.

>=20
> > Do you mean patch 3 or 4? Because, patch 3 is huge in size.
>=20
> You're right, patch 3 is the large one (~700 lines). I can split it
> further if that helps review. A natural split would be:
>=20
> - 3a: `ceph_client_reset_state` struct, init/destroy, and
> =C2=A0=C2=A0`ceph_mdsc_wait_for_reset()` blocking infrastructure
> - 3b: `ceph_mdsc_reset_workfn()`, `send_mds_reconnect()` changes,
> =C2=A0=C2=A0and session completion tracking
> - 3c: debugfs interface (trigger, status, inject_error)
> - 3d: tracepoints
>=20
> Let me know if that granularity makes sense or if you'd prefer a
> different split.

I think it makes sense.

Thanks,
Slava.

