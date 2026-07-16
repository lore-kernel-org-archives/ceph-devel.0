Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B363502A6
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176602; cv=pass; b=PrBpPUyrlKMI+tAbn+tu8Fj6B2n93YJ/AzaGla5U6inLx/YqLeRW2WIKZlsmat5PyZUdXqISPld2l76bTJ349vDPh8rdbNPqx2sBEbQ0n5kE4ucHD1+AhtysfWUR5PsVZ9ZHZymY07sM8ZroZNcPyPyEubzcr6eTCICoWkK32vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176602; c=relaxed/simple;
	bh=2f/y9DzKqrcN3WVID5VuACAL+DktfCoQM/Ns/1ZW1n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcHSTSoChu4VkoSxRbY4yQ12vUsnbkpKvAwrYzy713x2MEr+KtTwvlk4s3yLs0tvr4janvDDXtuToQb4lK8AQwVH2ypu6NHFzv0cuV22ToURfahz5n7eFWak/+vZKD6ujtz8fuP5SBgMTx/G1JONI8Rlpyin2C7frR5Tz7ZePno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=kRWWtD31; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="kRWWtD31"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c167bda216fso241565266b.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 21:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784176597; cv=none;
        d=google.com; s=arc-20260327;
        b=Jhm5AonEAypAMBLwUQjd1lfojPkkzMBV4F4sQpCizfYMH8+XVZM+CuwLPKGUx++yCS
         UNU/If3t6q//5M+DNYUOpu7qRuJePE2Bions9h9fAis3kCTu2um8EVQa0etQJ9yv+Y14
         cnibbVVgC0zMDAdWBjLbiGQVlOK63rEcaaxuFW7srMeR94d/AQ1dnoezJdQqlE9gze5L
         cmw4YZDqk4mM1RX4blUCdrxLYwog8kyRLQcjl6JCD80Pnr6YbeKtnNpAAsD6wN2N8qbw
         J3hLi5K1Ck2zRnstqJ98r9Gp5GQZpIEKIbwFSMwKh0Yn+u7fx2SvwjFBGzk571I7wG4p
         liIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A6yzbNphsf8LfBxQLTLtbU7Pd6E9BuE5uSaaGe1mzS0=;
        fh=NC2k/2xOsK9bE8xU9HcjB/MveIbHlVqnJO9pg8GZRNw=;
        b=fUOdvjoeF2gvnMuqS2sXT30jKL9JevPQLoytLSve+r4kNORnY2tn+TCtTqJulDX+It
         uZ+PcCIRDxuAUVTjnbkbjvBVL3v5Nyt4G32OD+/2QUMF33kawV5XLAC/M3uHcL77xkZ/
         0ddhYKspGy5zwkxvDxzwhrjpDFPk2+RGNc7/ei+lB/fiPgQ8viBXf+749ODPrFWpOlOV
         pc4f+G8ot4NkL45RIvJxTRMzsTgdT/DooxzCtCAtN+q5HAUsBDH0qWYsdGmy6gEPtMMe
         CwlZD2iU8MaeOWWvV2f289C1R8kTAk7NUyFb+RX7LieVrpteWWtxOaQNLjD2btpDxXSP
         VV0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784176597; x=1784781397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A6yzbNphsf8LfBxQLTLtbU7Pd6E9BuE5uSaaGe1mzS0=;
        b=kRWWtD31rX9ngchdL2dK7NWZn3FkMkKAuHM/O/TbkWFwGakr7+wfkWu9mb1Ju2XThj
         LiVSEKniZ83O/WA6AgWJ2fGRT2Ls/1QQwIOBCf96lAIqgrakyjwlwrjkvhYdYw5UV9ix
         QEhYlgM0TntO1JQGyn9p/xUhqdtnQRDqoh2loDFt5ufMiLCWMwVWYDyJ9V9nAYepU3Oi
         S7df+E+CkKd0Y2X4roy/9fMH7op+zWep6guzAq3gM/cytmjSC7Oe89y0sQuh7w62jdpC
         oGHkg2KE8l3BBfBg0dFSaV8Fe4bgN6UhdrpPXXY6XvSPUsUl+B/OqIqmnHXJmxg774bQ
         HIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176597; x=1784781397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6yzbNphsf8LfBxQLTLtbU7Pd6E9BuE5uSaaGe1mzS0=;
        b=HDRZ8HOOq8k3ZRmUpSwU17K3uGBVhsjW+8V3QxUyvm8MIlra29KOoL7yya9kHYOAzJ
         qmaebYnuff5OJlcVsEBylGdPDRAENXO1Xn4NU+hKs8XYlRBR9dpBeQdTM1yNruncdcdb
         SCMOTQ/suxn2AQxh/XOELZ+zYHIO1x1KmNPB9Y8KUh9fPAT+wdSE0V9E8RoZiAlRijAr
         C2hss0nofXRBBHNDBwiUUrHi1OrG74VQOI/hhtmljIdeoSF79mWGUVYjnCNyezJ+FfjQ
         eQpbHw9/h6s/p9t8PenGxmXdJrT5MzX1sUehbHZ/XIEWQ1+ot/wuU+L1brEuixsf8klg
         Fb+A==
X-Forwarded-Encrypted: i=1; AHgh+Rq7DZUCGPsE0ybTwVhsAHtETz8AJX8hxoRCFSsJLaDPi6ENZ7yRNlBEtzd2cLlew4ZNed4CYdQU00v7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlutgj+mWule1HF7RCHQYGH8xDHeWZ0Bq0khyBTuUIRgBxvFVn
	GJzi7U+Or1rSdNJqewdmhRlJx+FZGW7G9H+gCAqBn+VDJfCDB46jpkuXUSGXd5KbCzvoLMJekOl
	bbj02igAwELWQ0T2sX6sgQfGKyxYlERglTybp+9nnFA==
X-Gm-Gg: AfdE7ck6VJBKZJ5s2T/Cli4MqkD6MYSZrkPHjIkD1ykJrpPmHKGz+qQ4xOuHRcQTAIy
	bl7E1Jrz0cdZJidAoSLN6P8oMYeRZEORP5PERinewvcGwfXCWEjkzaB+K/mKLayDHK9VATp4xTS
	7CYqtvnC3VTruTGFKVe03WJoRf3MYUP0j8JjG4UYvmGwCT8wm998lEBnCwHZQ3TeYIa2um/LgmD
	ychI4RExprRUc7g/JQNw3x0WCjA0nnXjywbq+oyRESIDh2FUys60tliFlU=
X-Received: by 2002:a17:907:a785:b0:c12:9285:8f0f with SMTP id
 a640c23a62f3a-c161e93cebamr1121952366b.15.1784176597345; Wed, 15 Jul 2026
 21:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
 <20260715-ceph-mdsc-mutex-optimization-v2-4-90e81b726724@clyso.com> <e341fc3bd013ffdb5252740ad9e0686544d239c4.camel@dubeyko.com>
In-Reply-To: <e341fc3bd013ffdb5252740ad9e0686544d239c4.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 12:36:26 +0800
X-Gm-Features: AUfX_mwh25niSuzXC-l03hiDQu24-qXrGyMY0TU-M3TrYzs6SOwlFiKAnjCmLeQ
Message-ID: <CAOJNxRJAfoQVroLyTQy82TdBPOvKjfh0j6JWjrGUVEmsRez_QQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ceph: move mdsc->mutex into __do_request()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 at 02:53, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > __do_request() now acquires mdsc->mutex on entry and unlocks at
> > every exit point, so callers no longer need to hold it.  As a
> > result kick_requests() is now completely free of mdsc->mutex:
> > xa_for_each() is internally locked, list_del_init() is guarded by
> > wait_list_lock, and __do_request() manages its own serialization.
> >
> > Remove the no-longer-needed mutex_lock/unlock around __do_request()
> > in ceph_mdsc_submit_request() and handle_forward().  The do_request()
> > wrapper introduced in the previous commit is no longer necessary
> > and is dropped.
>
> Which do_request() wrapper do you mean here? Maybe, I am missing
> something.

The commit message is stale =E2=80=94 do_request() wrapper was in an earlie=
r
draft and was already dropped. Current code has none.
Let me fix it.

[......]
> > @@ -7255,9 +7259,7 @@ static void mds_peer_reset(struct
> > ceph_connection *con)
> >
> >               wake_up_all(&mdsc->session_close_wq);
> >
> > -             mutex_lock(&mdsc->mutex);
> >               kick_requests(mdsc, s->s_mds);
> > -             mutex_unlock(&mdsc->mutex);
> >
> >               ceph_put_mds_session(s);
> >               break;
>
> Maybe, I am missing something. But kick_requests() reads req-
> >r_attempts [1] and req->r_session [2] with no lock at all. While
> __do_request()/__prepare_send_request() can write those same fields
> [3,4] from another thread without holding mdsc->mutex at the write
> point either. Could it be the issue?
>

It's fine.

r_attempts is indeed read and written without any lock now, but
the value is monotonic and the read side is purely advisory in
kick_requests() =E2=80=94 it decides whether to pull a request off the
wait list and retry it.  The worst case is that kick_requests()
either processes one extra request (which __do_request() will
immediately bail out on because GOT_RESULT or r_err is already
set), or misses one (which the next kick_requests() round will
pick up).  On all architectures Linux supports, an aligned int
read/write is single-instruction atomic, so there is no torn-read
risk.

r_session is a write-once field =E2=80=94 set once in __do_request() and
never changed afterwards.  The reader sees either NULL (and skips
the request) or a valid, stable pointer.  No concurrent writes
occur after the initial store.

That said, this is a data race in the formal sense and KCSAN will
flag it.  I'll add READ_ONCE()/WRITE_ONCE() annotations in the
next revision to make the intent explicit and keep the tooling
quiet.

Thanks
Xiubo

> Thanks,
> Slava.
>
> [1]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L38=
32
> [2]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L38=
34
> [3]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L36=
58
> [4]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L34=
75
