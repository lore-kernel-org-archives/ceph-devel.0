Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C438DC6E
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766196; cv=none; b=bIzq/MHz99JDBeYerkSX/fIT3ipjdFq5YIKHTeUxz6vQEqK4/xPflPCMNLu9VHTNA38sGPTz/267O+fhmR4ZHjjk6wabyBiqS1AblyaFSPPIoFuu57q4tgx33pxIqY0yBYroTIWfYmyPKGwJa4Hit5SNful9YrlBQYspu87J0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766196; c=relaxed/simple;
	bh=lkxA/Yi/r1pEZkAmG4U4oN4Gc0k28Foyk5b7C0j/oUg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XBSL93VieG8k/SoJxuec7DHKf032rVMcozVO5HfyIgzRS1rznadMS8eWvYfqisKcsOH8YzPuH3v0AkRZsOXU3gmgii2H1r2fSCPX/h6IYWxxSfKSAqoN8Cn+flklATyLCuMv3gmzN0URtqR7ubaKtcJ8cB2/hPZT3mIQkXS0Mps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dreamsnake.net; spf=none smtp.mailfrom=dreamsnake.net; dkim=pass (2048-bit key) header.d=dreamsnake-net.20251104.gappssmtp.com header.i=@dreamsnake-net.20251104.gappssmtp.com header.b=iisAFzYQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dreamsnake.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dreamsnake.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dreamsnake-net.20251104.gappssmtp.com header.i=@dreamsnake-net.20251104.gappssmtp.com header.b="iisAFzYQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5b048375so66746085a.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dreamsnake-net.20251104.gappssmtp.com; s=20251104; t=1787766170; x=1788370970; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tCV0RWMvT8jbLiSsS9F6Ee8N1Qth96i6roxU7oqMk00=;
        b=iisAFzYQSU5fnPo+dZQ780uZ3bzfnoPzS9kdONNxaUiNB16tmWbJb08etZbyB1idtY
         qevN86Twxbmpslt0SRFNrln4HDaLnUTVN1mGPwRWQA80u+6LHFEmWAk7MxuVCCdfWOn+
         tQi9/O0nl0Uh3Ah6xRv6xveUkcO43yizCPAJpx9wghQ4dOCv7Ct+73Sb7mmQMdaxSx2O
         YPekddiS0TiXtHvSg0uNgjoKJ54hCf2wAqZ7ODngZb+5wGd+jeEIq20CWvZlqAiVZp3B
         juV4ndySlwGYZM8VIEYPUK9awCjHxAWeptmThVBE4DH/SJPAIMlHomFkdwMmS9YFDB7M
         ttKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766170; x=1788370970;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCV0RWMvT8jbLiSsS9F6Ee8N1Qth96i6roxU7oqMk00=;
        b=mCZHRPnZjsTUtCCOGp266ehRQ881/VMHbhtnwRNYaEv99ORZlIrt3yFxxXrGSdt0gb
         jp3xUpCJ23agJ8nR06LKWYbrqnFHzgGLNW64Zao+PO52Fx41Q+32ifq+qWiU+bYaGN0N
         HeQe0QZsMWGGT2umLFSRp2khnZCRFiBysn+2AGRRgtgT5JzSxKh7wQ/zDkHej9MqeamR
         PlXDO20Dzqn22OqyXqLTp+JwWUlR+OVJjv8GylgX3SUAP/XOG0mafjR2zDJMUoKJk457
         tLlmvk8zO431JvtWTUJcsFKQ+wmshbPjOrW/mKF144nmZe9XM4i/ToaKAPfSGvowLguD
         oJ6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqlIHEMFCDPhzocmvF/5DJO1Jf0F/st8k+DCTRCiY93ObITwIH7pcBpiElO29zt3sEmrWLkMBQgrEBZ@vger.kernel.org
X-Gm-Message-State: AFuF++nnWD1g6gBHvRlgkeMdRiquQycOzwU/AS9WHa27SQy9UiIWVBNG
	Jmv4hmmbIokrL92JQ1aOhjWjVO9vJggVM+O0ivBFZLCfgUITEPFMOSLYdMuzyKYv81Z0vMkPJiQ
	bkw==
X-Gm-Gg: AR+sD13CxmoKdgl/1D0EuBBeH0aHo8VTif1qRIOqjNUCnyofklfnMZOh1fSc5fx6XNx
	FqsBzTMxPqnzicbJpUO7+BnFJhUvvwvZJwmIUjR4nu2DvhoQ7grYYRxjFuKfqxupqj5gp4mzedb
	rGK7vi0ZUGkxmeTbrwW6Qdorew2TqOsmxDg06XJnlEKaaSjoJJ/ytPutdNCogunOBDMt5sphJRv
	VMnznIz69yhsW8l7fjX0o4fe+CTUJ2546cjh1v4ckODA8zFNk2JUcOzJnPZlOxu0+q/jDXS7LsR
	zW7/vShPzbeSg0Qjbr23SI65XLRdZudSkbnBIuWT1Pr1WwuQ6zNStZMmbbdon6mrQs385S/d9ZV
	d9UrX58a8cYE8XTLhtIIOuY57fU0qMG4sCdc377D3XZgDf5NJrxhLbfT2rakr7XJa7VZFWZp015
	9A9nlna+ladzmKf4RDim16gNl3R+tKL/f8leiFg19J/YNkQeT5JHi2KKo8HmZgX5gCOEtKIu1vO
	kCtxHCgJT+e6DatMswS8TXNFDDQHE+rJJdPRc4EViTWXQ==
X-Received: by 2002:a05:620a:370e:b0:938:fd23:1e29 with SMTP id af79cd13be357-938fd232669mr277627185a.4.1787766169836;
        Wed, 26 Aug 2026 10:42:49 -0700 (PDT)
Received: from smtpclient.apple (pool-100-6-75-232.pitbpa.fios.verizon.net. [100.6.75.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f217c5asm250181885a.15.2026.08.26.10.42.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:42:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [v4] ceph: add 'lazyio' mount option to kclient
From: Anthony D'Atri <aad@dreamsnake.net>
In-Reply-To: <20260824064834.2509055-1-amarkuze@redhat.com>
Date: Wed, 26 Aug 2026 13:42:37 -0400
Cc: Xiubo Li <xiubo.li@clyso.com>,
 ceph-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DE0FB03-58E3-4BF1-87AE-055075FE0891@dreamsnake.net>
References: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com>
 <20260824064834.2509055-1-amarkuze@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Any chance of getting in as well the opt-out RFE for going synchronous =
when an OSD / pool crosses NEARFULL?

> On Aug 24, 2026, at 2:48=E2=80=AFAM, Alex Markuze =
<amarkuze@redhat.com> wrote:
>=20
> Hi Xiubo,
>=20
> Thanks for the update and the extra testing.
>=20
> NACK for now =E2=80=94 please send a v5 for:
>=20
>  1. fs/ceph/caps.c:2354: FLUSH can ACK a LAZYIO revoke while pages are =
still cached
>     Xiubo, `ceph_adjust_caps_used_for_lazyio()` is applied in
>     `ceph_check_caps()` and `handle_cap_grant()`, but `__prep_cap()`
>     still does `cap->implemented &=3D cap->issued | used` with the raw
>     used set. `try_flush_caps()` and `__kick_flushing_caps()` pass
>     `__ceph_caps_used()` straight in, so used is CACHE/BUFFER from
>     `nrpages` / `i_wrbuffer_ref`, not LAZYIO. Once LAZYIO is gone from
>     `issued`, that drops it from `implemented` and the FLUSH/reconnect
>     message is an implicit revoke ACK. `ceph_fsync()` hits this =
easily:
>     `file_write_and_wait_range()` leaves clean cached pages, then
>     `try_flush_caps()` runs. After that ACK the MDS can hand CACHE to
>     another client while we still have the old pages. That is the hole
>     the v4 `implemented` comment is trying to close, and it still
>     exists on the FLUSH path.
>     Suggested fix: Run `used` through
>     `ceph_adjust_caps_used_for_lazyio()` in `try_flush_caps()` and
>     `__kick_flushing_caps()`, or once inside `__prep_cap()`. While
>     `implemented` still has LAZYIO and CACHE/BUFFER are not issued,
>     report LAZYIO as used so `implemented` keeps it until writeback =
and
>     invalidation finish.
>  2. fs/ceph/addr.c:1999: Non-lazy mmap can keep using stale page cache =
after a CACHE->LAZYIO transition
>     The new revoke path keeps the inode page cache when CACHE is
>     dropped but LAZYIO remains, and the used-cap rewrite then lets =
that
>     revoke be ACKed. That is only safe if every opener is lazy. After
>     `remount,lazyio`, `CEPH_IOC_LAZYIO` on one fd, or any mix of old
>     non-lazy and new lazy opens, a non-lazy mapping still faults
>     through `ceph_filemap_fault()` with `want =3D CACHE`, gets only =
RD,
>     then calls `filemap_fault()` anyway because
>     `!ceph_has_inline_data()`. Those retained pages were kept solely
>     for the lazy fd, so the non-lazy mmap can observe stale data.
>     `try_get_cap_refs()` correctly refuses to satisfy a non-lazy
>     CACHE/BUFFER want with LAZYIO for `read_iter`/`write_iter`; mmap
>     never got that gate.
>     Suggested fix: Only let LAZYIO cover retained page cache when =
every
>     opener on the inode is lazy, or skip/invalidate page-cache faults
>     for non-lazy fds once CACHE has been revoked.
>  3. fs/ceph/addr.c:2149: ceph_page_mkwrite() can sleep until killed if =
caps are gone
>     The new lazy-fd path drops its refs and waits in
>     `wait_event_killable(ci->i_cap_wq,
>     ceph_have_dirtyable_caps(inode))` when it got WR but neither =
BUFFER
>     nor LAZYIO. Session reset wakes `i_cap_wq` via cap purge, but
>     `ceph_have_dirtyable_caps()` stays false once the caps are gone, =
so
>     the waiter goes back to sleep. `ceph_inode_shutdown()` does not
>     make the condition true and does not wake the queue.
>     `try_get_cap_refs()` already fails with `-ESTALE` on shutdown; =
this
>     wait sits outside that path, so a writable fault in that window
>     wedges until SIGKILL.
>     Suggested fix: Include shutdown/session-loss in the wait =
condition,
>     and fail the fault once the inode can no longer regain BUFFER or
>     LAZYIO.
>=20
> FLUSH/reconnect still ACKs a LAZYIO revoke while pages remain; =
non-lazy mmap and mkwrite shutdown wait also need fixes.
>=20
>=20
> --=20
> Alex Markuze
>=20
>=20

