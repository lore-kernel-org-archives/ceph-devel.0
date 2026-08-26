Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDA4772B5
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766601; cv=pass; b=szBJmrrRZhbyK0Lo1eUXP/VllxqwIbMy3LIbOvnQ/iAYRIxbPTtm8NB+13XmDQ5DVeAm+8NeB9H2yN/iOn5iCOH5HRC090lxkP+nm66HcHkFKxmbQW6rZomh9mjiByi2QzTrBOS/EAbwkmKmWlHv9DiWructvLQeGVWUY0BEliE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766601; c=relaxed/simple;
	bh=19LNv6bOlVl5jN28X+Y9Wq+5zDQP9K++7dxCtVi496A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip1vdUA4kcd8GPsxwvi90n31GqETajA3vA7BMSQRAA33+yT2x6j6Fw/fnNpREy8olh6jeHe+oYpIjjeoxadpSCUdwusoPGM/7RPREYeqpX0+JfXa0fc6GHjHwBFPpJFYfCACIVAqsoRRPHGAaEvrAmIR5HKYwVJi69zfXcDOkuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLXsMm7S; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLXsMm7S"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so1063490e0c.0
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 10:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787766579; cv=none;
        d=google.com; s=arc-20260327;
        b=JxuvX7lcr885ae4trMitFj5DJqSNxx+xgOL/Scz3j1F8WyJ9sjBSrq5+miVuOp/fUG
         23mFdX2uMC0ztaRYyzraSWFnuKLIQsRIFIf/m/gvClQqXEUlBbghIXV3nSOcN1SYJM+9
         DYYqeuU256l8GHUbIIwG5ft30Hwvzz0bmbYAXnitZdf/+ftp2pvridZHTjwfJP9M5AvO
         GuYGFM0ZS7AOEv8z7JHT92xY3UQGomtpTdAkvbF41aNM1PilKwM41o6f600cCUjnagOA
         55vLwcHjmf0To5akNPjz59nuIOC9LTVXR1sjYqrmSD0v8REKqWHmPtF9FRPWstDYRdDI
         Ro+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeK6/aSWFsd2xPOP4mCpu0gukqDd9a4UTYtDzq0Y0D8=;
        fh=AQgE7P+c9jnfiZMnx/ZHvs6syj77hgy8Tkn2HiGIHlE=;
        b=EJli7MJjfiSxIUqzF2UVcRwjsRySSjHq5u89+qPAuvAJO9w65iOpq5oR1xVplRJwdP
         doGgNem4Xq47o4WcRpRGaRvojVX3U3Lmt06nWohGwEof/9h5IxpXbYpyLR9M/l4vde+n
         dKfX89Nn8gpFFcgqd+rR8wxOzUg+dGNFFVe8tQiT9WghV6JFdUrcznRBtizhIoBjJaS5
         je0yqM3DsOTB7J9iFWGqMMK8gPDZsIZeEOOWdN2ThA0SMhD7AwqCWCk7LVaoz0YnKecG
         cP/MDQqU9d7MX+tR1owB7N6WtwovrEFDL5TBZ4Rbm84jhpJhhoMj4ghOvLn9j4bmZRWn
         g5VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766579; x=1788371379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeK6/aSWFsd2xPOP4mCpu0gukqDd9a4UTYtDzq0Y0D8=;
        b=TLXsMm7SOYHU6YdiZP6MFarP8b8ubBFGtq+/8Gul7EetvoCTCLt8sG2r5BhQ6T30Th
         sK7/78a2A0cPdo8wjGIlUgP4up1ZFazW8Z9INAfmZfqv05xwvBwG7zLBAevE4BhOCGR8
         S8kkH3Q8UMoky+0R23V0IBZ6amoJNB1Fv622Dk34lE6k/WYrvRNxLloNIhpBc2YZY6ed
         P67U9xzgHCUe4srehLgSEJuoYtFqqUsRkov6GglhKrZ83fjyicKxK6BLD8SZpCnCYysT
         bnBGJ9p32yPDntGNWVoPsb+Dq4yVvpPiFEGxSCmztJtCtkBGgOohnR8eMYZmBZKoVeA/
         96sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766579; x=1788371379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeK6/aSWFsd2xPOP4mCpu0gukqDd9a4UTYtDzq0Y0D8=;
        b=Yd6Y4zl62RCiBBd05r3v+rV3IqMZlW1eXnJF2PvMMkrqpXuWS4OspX6MH42BfUB0pm
         3yGOCFm9MYCEvY3SHRgfRKJUiubxsabx2KIK8lfkPksXGkFUBwuvjlLSABnXUHeFBmdg
         BmZuhZTMuJeJVybvB7o0iyM0PTCrBqTNp5VuF9rXXsHNsLcBod1831aGectUTpNYuf3A
         OGnWmPIsKhsmF0DjgbPx7i51xntrQ2nQ6Nn/sY5lrXMFh9G3rmLCCDRAw8DRFdAAYGgg
         ZsbO07OX/TTcMcbZwuESQFRcd8EK4lSNdXd+mtOzHlrSo7fBHXi8QB/VW5qO3QZ6kXUE
         r35A==
X-Forwarded-Encrypted: i=1; AHgh+RrG6IDoJRR8wjJltb5r56Jc6jSPbL6M5GucKfM5HJY8KdO2ECYTfqCZIEizV/QCclVkht5M6b3B6Wb4@vger.kernel.org
X-Gm-Message-State: AFuF++kpTxsYPUwf3fPZdgA+x9UjPW2NjPgT7kGyqc135B8wiQNu/SJP
	bdQaDKtKzEx4BhVQ3JIRvM2NnweDXNKv6b6W74F7xO57ZjoCGK2HAEfsjK8sGWncOyowJiFtqNb
	WIDtki9V6WdKAwBEe7t5M4xRdU3wPNNCjQj5t
X-Gm-Gg: AR+sD13U7m5FbuivlyT2N1b3g3bYi841KWPT5CpKSqYneY736tk0nnIsg2o5IdBpc9o
	sEMUdKoc3wGmAfVvyhkUCStqA5unBXUjDGXIFSaxkHw9Pu51Q2pm53KcSDxl1jDix80No0+XMox
	UVjj8B74wn9RXz9t97tDPQKMCjchdAJ+r2cIUslFhNY1I+PGyXxGXQf+DFhbtM2RtDGjvN9peAo
	qkhRiph77eN1C/C5mEcS5+qmrKf67GXU9+kxqH107FXUF0Dkg6CX6fpOQ7CJUiML0ck2Txlq0S/
	g0HZquL6TmkUorOijnaJX1sGen7EJziwCCHOKqOrxeUptCUoHZhfHSmuYnE7yjfvCbLSus+APNP
	tYA==
X-Received: by 2002:a05:6123:2e6:b0:5bf:9bfa:53a0 with SMTP id
 71dfb90a1353d-5c65ba40e65mr3905204e0c.1.1787766578976; Wed, 26 Aug 2026
 10:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com> <20260824064834.2509055-1-amarkuze@redhat.com>
 <4DE0FB03-58E3-4BF1-87AE-055075FE0891@dreamsnake.net>
In-Reply-To: <4DE0FB03-58E3-4BF1-87AE-055075FE0891@dreamsnake.net>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 26 Aug 2026 19:49:26 +0200
X-Gm-Features: AcwNN1XOdzB6BThXusoF-GlPyQjuri2cf4JIpEBxLfeQSsJlOCfJIS4NJe0ou0k
Message-ID: <CAOi1vP9HmkFa9swMLM+y1DjJVGeNX51bXe96E--2V3U3iPU_uA@mail.gmail.com>
Subject: Re: [v4] ceph: add 'lazyio' mount option to kclient
To: "Anthony D'Atri" <aad@dreamsnake.net>
Cc: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubo.li@clyso.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:43=E2=80=AFPM Anthony D'Atri <aad@dreamsnake.net>=
 wrote:
>
> Any chance of getting in as well the opt-out RFE for going synchronous wh=
en an OSD / pool crosses NEARFULL?

Hi Anthony,

That is already queued, courtesy of Alex:

https://github.com/ceph/ceph-client/commit/c7a12c20bfba96a76e94d8dfd700b33e=
92aa8323

Thanks,

                Ilya

>
> > On Aug 24, 2026, at 2:48=E2=80=AFAM, Alex Markuze <amarkuze@redhat.com>=
 wrote:
> >
> > Hi Xiubo,
> >
> > Thanks for the update and the extra testing.
> >
> > NACK for now =E2=80=94 please send a v5 for:
> >
> >  1. fs/ceph/caps.c:2354: FLUSH can ACK a LAZYIO revoke while pages are =
still cached
> >     Xiubo, `ceph_adjust_caps_used_for_lazyio()` is applied in
> >     `ceph_check_caps()` and `handle_cap_grant()`, but `__prep_cap()`
> >     still does `cap->implemented &=3D cap->issued | used` with the raw
> >     used set. `try_flush_caps()` and `__kick_flushing_caps()` pass
> >     `__ceph_caps_used()` straight in, so used is CACHE/BUFFER from
> >     `nrpages` / `i_wrbuffer_ref`, not LAZYIO. Once LAZYIO is gone from
> >     `issued`, that drops it from `implemented` and the FLUSH/reconnect
> >     message is an implicit revoke ACK. `ceph_fsync()` hits this easily:
> >     `file_write_and_wait_range()` leaves clean cached pages, then
> >     `try_flush_caps()` runs. After that ACK the MDS can hand CACHE to
> >     another client while we still have the old pages. That is the hole
> >     the v4 `implemented` comment is trying to close, and it still
> >     exists on the FLUSH path.
> >     Suggested fix: Run `used` through
> >     `ceph_adjust_caps_used_for_lazyio()` in `try_flush_caps()` and
> >     `__kick_flushing_caps()`, or once inside `__prep_cap()`. While
> >     `implemented` still has LAZYIO and CACHE/BUFFER are not issued,
> >     report LAZYIO as used so `implemented` keeps it until writeback and
> >     invalidation finish.
> >  2. fs/ceph/addr.c:1999: Non-lazy mmap can keep using stale page cache =
after a CACHE->LAZYIO transition
> >     The new revoke path keeps the inode page cache when CACHE is
> >     dropped but LAZYIO remains, and the used-cap rewrite then lets that
> >     revoke be ACKed. That is only safe if every opener is lazy. After
> >     `remount,lazyio`, `CEPH_IOC_LAZYIO` on one fd, or any mix of old
> >     non-lazy and new lazy opens, a non-lazy mapping still faults
> >     through `ceph_filemap_fault()` with `want =3D CACHE`, gets only RD,
> >     then calls `filemap_fault()` anyway because
> >     `!ceph_has_inline_data()`. Those retained pages were kept solely
> >     for the lazy fd, so the non-lazy mmap can observe stale data.
> >     `try_get_cap_refs()` correctly refuses to satisfy a non-lazy
> >     CACHE/BUFFER want with LAZYIO for `read_iter`/`write_iter`; mmap
> >     never got that gate.
> >     Suggested fix: Only let LAZYIO cover retained page cache when every
> >     opener on the inode is lazy, or skip/invalidate page-cache faults
> >     for non-lazy fds once CACHE has been revoked.
> >  3. fs/ceph/addr.c:2149: ceph_page_mkwrite() can sleep until killed if =
caps are gone
> >     The new lazy-fd path drops its refs and waits in
> >     `wait_event_killable(ci->i_cap_wq,
> >     ceph_have_dirtyable_caps(inode))` when it got WR but neither BUFFER
> >     nor LAZYIO. Session reset wakes `i_cap_wq` via cap purge, but
> >     `ceph_have_dirtyable_caps()` stays false once the caps are gone, so
> >     the waiter goes back to sleep. `ceph_inode_shutdown()` does not
> >     make the condition true and does not wake the queue.
> >     `try_get_cap_refs()` already fails with `-ESTALE` on shutdown; this
> >     wait sits outside that path, so a writable fault in that window
> >     wedges until SIGKILL.
> >     Suggested fix: Include shutdown/session-loss in the wait condition,
> >     and fail the fault once the inode can no longer regain BUFFER or
> >     LAZYIO.
> >
> > FLUSH/reconnect still ACKs a LAZYIO revoke while pages remain; non-lazy=
 mmap and mkwrite shutdown wait also need fixes.
> >
> >
> > --
> > Alex Markuze
> >
> >
>
>
