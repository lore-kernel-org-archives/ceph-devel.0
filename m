Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624E37883C
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564435; cv=pass; b=WSt/9YIsCR8CslxVbI97PW8xdPLr18ZtwOfCEatsIwiuyU2ebOmfreP8WfiEHg5zHTNUv4v4ej4BCpoqanambDw0qiv9rf72ekjt50SCO7wdHTF+M8AFSwnLrAJ6+twJxWmtY08/qtd0zO4KsJ8gWeI3OddttrQT0E+yLJaS36o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564435; c=relaxed/simple;
	bh=Txboohc0dPKT1VBjRn+5jmfSyGJPi9It5KVsjVxJr5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7MgFN6XvP5T2M82rLyte3DSdw68NWTFoJRq6eGrDB0GZKKnMshsq2ZT8CAPKWhk2FspYTtJhLn2E8pP+zVcg425KwjCJ80aS99R/Gv/szq98cBbqlGRCcUPGPsF1AG1l4UAH21laCe/YXWmvooRM1WJU/uOi4fXWSbssFRX4VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9/FLFhl; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9/FLFhl"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-754acc61e10so564403137.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 12:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564433; cv=none;
        d=google.com; s=arc-20260327;
        b=hgPZpoH1YMwOgiJ9pAuCWD6UBImIZBfZz/tT92kdP+JKBYUpjeLNnVjASI+aV/X5UY
         j1PgQ4b15RARhyfiauPn29thkrFadAya+LQiedcVY7VP9qNI4DxOWbsFVBpq3nK01ZKu
         lxHJ5mo/ls7YJ4YIpyoCu4uMsV6M+mrFRA/nVT5jC9e/139Jy6fY6qE4+HK/R4SYzEjr
         CHRpO5KJNFF56Or6p3I8kHqCQPHnFANenftnX8oF9TBiSsEfIZ74rjul6SfTM4aG04Tt
         fGnqTJq1zdD999z556hryQdVb807bz4ud2ARz0cVyEzM6zXlFYaMeorrg9UyJdu4V1ge
         pvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        fh=q8ycdyoadFKoRgOoNPaaLQ0wXKDeFonqJDGYu78ABt0=;
        b=I5C3UMh68AsXAIxt50En5/iItol5x2+dJ7eaRf7tJmtwqGQyX9VynzYVkRxEWfrd+3
         chd9xIeYt3gJqF0keJ2iTZjIVIrB4MdpgJG1NFJtmAHDahzI1L04pbJG340hUJuymz5Q
         2+hbhKS7DZ9l1DPEHYLbR3kojV4rxCUMRK3tYZO+8tx+y8ihZV2uIr+JNAAft4ktW2HW
         n7tW2g+oXFybFL1vqIQvIQHDgB8U63A9WJmoT+4BRBa/P3ZXBG6Hqy1zvz1VoRduTec6
         piPdbs/9bxikc/f0WHEf8K6RKpQfxDSusEXwscpHhXFyYPoCufcdBwxcucSfbwUvBW2J
         +Fsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564433; x=1787169233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        b=S9/FLFhl/fAQljHcb4/ra0LojtWSBWJ4Ro2C4eAVACrx9FQMU3or8n0OkYeEbT4w8E
         hTPS6H+3x3nWpIpexdbFodyjM/OEf27PKzReV2lncNiotbB15uTVagiCLuc4E/aJ/ZNI
         2vTMFNqlj5066PGihZTlWQxXOcibCAxD43VwH/BPNSNMel1R9pdr6ebgK2/RzsMhP/s9
         kLu5eFW5MDH2k+in/1uwv/AtkCgB6St1t7QfqjzJwxbNmrApWHjRwbyfN1cqKb8hrG7z
         v3E7Wp86CCBDjNzin+UYUORAepyJDo/1L2JNlMRuIHGo6s1r+CPkypordNMrLZjRk+pB
         73bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564433; x=1787169233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        b=s0j/mzSKUwo/KfJLbtnKdHuXILTgB4/vkFBdrb3pwr7zBs/mWtj93livw+8+mFkLbD
         ZoKtaNBY3xGoXObwjSuD0sK1rRXMdILa8FRkoxx3ZQo9kA85kRxAqdnFjEXxBXKxO5Z2
         r12/tKKMO4nddTyZY7gWvcFP7zc+/5EBbtvwy5tUKrRh5DnanQc4odjrdHCN9Dc7Pmck
         Dj1HYe8Upq8TifQNqRvFvLx/TUB1Jr469c30BoHMXiVKy6tXB029Uo83GUqBPdTPyknu
         4e8VJ7y4lq2+UdRSNO2ncpuRDN6VmLtEMMEzjB3Fu49La3n1f25rR/Bftan8OKyJexld
         XFPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1vEGf3EngDzTbpABN/6nmszPxFQ5fPuCvvXpRxVuRukckz4VXbAJ1n4ELYtdwCbQOg+wxuBTqqwYd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4t6Hjw97sNQI4VQugz8tN/4GWLQOo2r8NaT7bVd2Mk3rBj8X
	vwljtDw/hZA5umxg1GcflZDCRtHbK1NFwOKfZ+wInn0V+TUogAYzxaNRJJ2bsQGJSZYy1TmgFso
	FCN7iJZH3l6pzB9ATTWwZ30auUcoLFXsS7O8L
X-Gm-Gg: AR+sD13b11S1Frf/ettJFrpWGOAEfUBplaBoAC522/QqZRm4aXwbKzMSKMLUjFnbKsM
	j1hZC9RrFG0mUwuj3da7HzlSekqsTgsMaK3u6ml1KVSx34RJKD+8HiGUsIzy8Qn0xIU1HwSAQ71
	hdNzda36uX85aBoTE+ngeE44ch708FIgMbdJuoa31+yEN2D5opOIhMAqK0PUQbNdDG8Fjem7ubX
	n/4W94IVEoM8bakrueC4h3bi26PMueA+YV4ut7o7QZL5CM02cDHe9gQZ2+JCzBXrSBvRu9cArVo
	LiCQhZd6yDdjiA5SRUTrc/6DdMdKVi7rfRbMjxANN2dB/zIUBCbYlp1asINQ9iwI9sq5WFEYZa0
	v8Q==
X-Received: by 2002:a05:6102:5710:b0:74c:11b2:a944 with SMTP id
 ada2fe7eead31-76db887588cmr296208137.14.1786564432588; Wed, 12 Aug 2026
 12:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
 <20260602050219.1043295-1-jhapavitra98@gmail.com> <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
In-Reply-To: <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:53:40 +0200
X-Gm-Features: AUfX_mzvUMHPCEecas1eXo38odx26JmTVRgozyq00E4iJXJ4uRlURPqLza5wv9U
Message-ID: <CAOi1vP9fRZUyS5rkThq0ChszVHJx6B3xWXhESULuj8WX3ECExA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: fix multiple unsafe decodes in decode_locker()
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Slava.Dubeyko@ibm.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:15=E2=80=AFPM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> Ilya,
>
> This has been Reviewed-by'd by Slava since Jun 2 (v3), no outstanding
> comments or NACKs on this one. It's been quiet for two months now.
> Any blocker to applying, or should I rebase and resend?

Hi Pavitra,

On a second look, I didn't see an actual Reviewed-by tag from Slava
on any of the revisions, so formally this patch was still unreviewed.
I went ahead and reviewed it myself, it's now applied with a small
modification to use ceph_decode_skip_string() helper instead of two
separate calls to ceph_decode_32_safe() and ceph_decode_skip_n():

https://github.com/ceph/ceph-client/commit/437b6551cfcc235eea1d735a874f9d42=
1f555e17

Thanks,

                Ilya

>
> thanks,
> Pavitra
>
> On Tue, 2 Jun 2026 at 10:32, Pavitra Jha <jhapavitra98@gmail.com> wrote:
> >
> > decode_locker() in cls_lock_client.c contains three unsafe decode
> > operations that allow a malicious or compromised OSD to trigger
> > slab-out-of-bounds reads:
> >
> > 1. ceph_decode_copy() at the locker_id_t name field has no preceding
> >    bounds check. With p =3D=3D end after ceph_start_decoding() accepts
> >    struct_len=3D0, this reads sizeof(ceph_entity_name) =3D 9 bytes past
> >    the validated buffer boundary.
> >
> > 2. *p +=3D sizeof(struct ceph_timespec) after the locker_info_t header
> >    is an unchecked pointer advance. A malicious OSD can position p
> >    past end, causing all subsequent _safe checks to pass against a
> >    bogus boundary.
> >
> > 3. len =3D ceph_decode_32(p) has no preceding bounds check, and the
> >    immediately following *p +=3D len is uncapped. A malicious OSD can
> >    send len=3D0xffffffff, advancing p gigabytes past end and escaping
> >    the decode window entirely.
> >
> > Fix all three by replacing bare operations with their safe variants:
> >   ceph_decode_copy   -> ceph_decode_copy_safe
> >   *p +=3D sizeof(...)  -> ceph_decode_skip_n
> >   ceph_decode_32(p)  -> ceph_decode_32_safe
> >   *p +=3D len          -> ceph_decode_skip_n
> >
> > A new out_bad: label is added to return -EINVAL on any bounds
> > violation. -EINVAL is appropriate here: the data received from the OSD
> > is structurally malformed, which is an invalid argument to the decode
> > contract regardless of whether the caller or the wire is at fault.
> >
> > KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
> >
> >   [   26.183969] ceph_oob4_poc: buf=3Dffff888009e31000 end=3Dffff888009=
e31fa0
> >   [   26.186087] ceph_oob4_poc: struct_v=3D1 struct_len=3D0 p=3D=3Dend:=
 1
> >   [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past sla=
b boundary...
> >   [   26.187679] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b=
/0xff0 [ceph_oob4_poc]
> >   [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod=
/59
> >   [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G         =
  O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
> >   [   26.188236] Tainted: [O]=3DOOT_MODULE
> >   [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> >   [   26.188236] Call Trace:
> >   [   26.188236]  <TASK>
> >   [   26.188236]  dump_stack_lvl+0x4d/0x70
> >   [   26.188236]  print_report+0x170/0x4f3
> >   [   26.188236]  kasan_report+0xda/0x110
> >   [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
> >   [   26.188236]  do_one_initcall+0x9a/0x3a0
> >   [   26.188236]  do_init_module+0x27c/0x790
> >   [   26.188236]  load_module+0x4a9a/0x6350
> >   [   26.188236]  init_module_from_file+0x15c/0x180
> >   [   26.188236]  idempotent_init_module+0x21f/0x750
> >   [   26.188236]  __x64_sys_finit_module+0xba/0x120
> >   [   26.188236]  do_syscall_64+0xe2/0x570
> >   [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   [   26.188236]  </TASK>
> >   [   26.188236] The buggy address belongs to the object at ffff888009e=
31000
> >   [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
> >   [   26.188236] The buggy address is located 0 bytes to the right of
> >   [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888=
009e31fa0)
> >   [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236]                                ^
> >   [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.255513] ceph_oob4_poc: len=3D0xcccccccc (OOB garbage from KASA=
N redzone)
> >
> >   0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
> >   the slab redzone immediately past the 4000-byte allocation.
> >
> > Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> > deployment can trigger this against any kernel client that issues the
> > lock.get_info class method (e.g. during RBD exclusive lock acquisition)
> > without any further privileges beyond OSD session establishment.
> >
> > Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> > ---
> > v3: Split ceph_decode_copy_safe call to fit 80-column limit,
> >     per Viacheslav Dubeyko's review of v2.
> > v2: Move inline comments above ceph_decode_skip_n calls, rename
> >     label bad -> out_bad, per Viacheslav Dubeyko's review.
> > ---
> >  net/ceph/cls_lock_client.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> > index 4e6a6d3e4..79a449897 100644
> > --- a/net/ceph/cls_lock_client.c
> > +++ b/net/ceph/cls_lock_client.c
> > @@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struc=
t ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
> > +       ceph_decode_copy_safe(p, end, &locker->id.name,
> > +                             sizeof(locker->id.name), out_bad);
> >         s =3D ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
> >         if (IS_ERR(s))
> >                 return PTR_ERR(s);
> > @@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, str=
uct ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       *p +=3D sizeof(struct ceph_timespec); /* skip expiration */
> > +       /* skip expiration */
> > +       ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_ba=
d);
> >
> >         ret =3D ceph_decode_entity_addr(p, end, &locker->info.addr);
> >         if (ret)
> >                 return ret;
> >
> > -       len =3D ceph_decode_32(p);
> > -       *p +=3D len; /* skip description */
> > +       ceph_decode_32_safe(p, end, len, out_bad);
> > +       /* skip description */
> > +       ceph_decode_skip_n(p, end, len, out_bad);
> >
> >         dout("%s %s%llu cookie %s addr %s\n", __func__,
> >              ENTITY_NAME(locker->id.name), locker->id.cookie,
> >              ceph_pr_addr(&locker->info.addr));
> >         return 0;
> > +out_bad:
> > +       return -EINVAL;
> >  }
> >
> >  static int decode_lockers(void **p, void *end, u8 *type, char **tag,
> > --
> > 2.53.0
> >
