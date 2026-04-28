Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23240DFD6
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415689; cv=pass; b=sFd775xpsvnjJEHMGl9X/PcmWIHO9oV585hQ6uR9k0JEqxG8cneuctCIAV7fqgPjzQSllTYYdlnl6OAebmeBUS0yq6SZmuI95DmfKtVi+iIhOaF/1M4q+Ye6tPV7ximkvwGgRUKLB3R8clk/Rb9REass32q54DBSSK2Z5RCzPyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415689; c=relaxed/simple;
	bh=yKoOiPmhcRtpX0I6DLS42A+1exFXEhNhbZxwynXSpRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jS077zcuMYHCNbyOWf7HYV7orsy4FMQD0Vec7ghEIHtVWUIM68d/qddRaJoQFq+gzRW08Wfo5zc7eNVGQAHjBKbgNDZ0BYBrT8s40Ap8Fiu+4npxAoOPwkaq5GB7gANQw82zzpujMV6xF1O+w/71g7/U0X+KL010aUrPuJ19WBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBN14k86; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBN14k86"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c7212836bso3686614c88.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 15:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777415687; cv=none;
        d=google.com; s=arc-20240605;
        b=WoSVau6l0Zpr1FtswZiarBaZif51l6fWhjb0zW6q3fDrGDyMoZJXCDP08UXwvSLvN/
         9y0ACSvCgVTeGP/gU+CIe0r/Nnkj5OTaKjr+fm7LlS6gSJMQZJRiFH2Ik7lZhDJxIh6u
         7Xz7F/SHUGgsH9Vhz7+cKgwkwJYLrfTmCT7Y24M9XiZBw+WCsucAnh91YscOwrTLyrTn
         SvX1txIKHeyaEohwuFFMtmoShCnPx7uIQIwKGn+sbaPb6iwWtni9I6z4OBkRH8SoHSPH
         3O8+BrAWIl/lbiCJW7A7Kxt0pYVNiZs7xqX7tvUntc1ZAeYnllsDs+2SMG7ZbZMKTi+5
         0yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAmVh6YDfejT/E2URYUh9RId3WZuUlsUzlWuUv497GI=;
        fh=eHMtetnPgul94AghKfzNEL2HvifnGH2jF7cl+tATRPo=;
        b=kBqrQ776EXBqiGY0wKMJ2NL45c90c915DQ5PgPov97SaDD7nniHscFAU9LGmqmxyz1
         tyNl9ecpYa1Lm+owLx9TnTGjwTkaAI6DQrZYHZWZ3QzhG1tTMab4DI+TyLO8SVnVBtOV
         fnIhOmYXNe/y1axXqsgeZXl4WaL5eRCoNVCiNhImIJxNa5SNKy0NrEJfbbRLLWKCRRd/
         vtPP/D11NsXYRL4UBiFq31/P2nZ1gJY6wssCRSAUT6IO3HScXO/Vmjb3gGuDoDXHIs29
         CIRuHCjBxGRyXoZ1ZR6Duhr3a++3y7n7vklL63htqxIrJhe7g092NCN+Zkhud6QQfwPi
         toSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777415687; x=1778020487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAmVh6YDfejT/E2URYUh9RId3WZuUlsUzlWuUv497GI=;
        b=NBN14k86u+BNzr96dt6+6B0+N0VrAfH/dC2hYY3+h5D7Ey+17cDlFYXOC8A+fbD1uK
         krdi5fI0r+O9nz+rUgOWq9ywqv2xm76RhiPzPCGIrpjGcRrtKgTzhepGUjOsAovpWLae
         fTXm79+xoTaiOkGi11djfHiXmoSqVnWvuq9KIagYelBWspvjEauZExtdsuJv/t5o8rae
         t4/yWbKC1F/zhiGL2l1k5PzjW93gGZLMO6J3qaHyMLF1wJaw250rzjx/9VCiHp44RW6y
         QXUdXbcPvCyXD6ZMAlyOaBnAco6fRx/6YsqEgNmALSGt02MD46gsK5QirDPSrfXrQZp8
         2d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777415687; x=1778020487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAmVh6YDfejT/E2URYUh9RId3WZuUlsUzlWuUv497GI=;
        b=dp5abCA3jBcqycP5i/O2eqNV0yLstvtQQNcWwigLJJ+p71ESyOxyq4Rb/GR9sLiy5G
         E2swOe2zPHhuBrcidjQQqoNCUPCnknJH3JYB5EuPcYrxOmARdISdc9rje4wlU+z1VNG6
         /VqjhxcSfEoA/7In7+PvM+3TUK6GaOvZ5NeLaMcjGpeUpVUi2cYZayLJ4OuboDTk3ipN
         WqsAUmTXQr0JBbNjK7A3Up5ZTDRpfG4McGdPVlRTh3hB2JOxM0HkR4ESM8T8nI2lqOSb
         g9o9pekuy5PInVXKca+zdswJJFUE4QtkN52olIk456/z8bq/CLtxbNuqxzpt/0WNFKNh
         I6cw==
X-Forwarded-Encrypted: i=1; AFNElJ+TepTsTYK9FG9TqfrTsd7Q7qwgbwSdXPC0SsRYhla3732aowojkaJvjVsFpRk4agZSMs7AgbBzPOan@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fEPz/I2ijOp9HkiQQlaFx56YUwo6vdY4J68cGwBNBISN9mpD
	DDWcC5ce3RgfgvzxcY6OfcK6eVJ7Dfq6X/eSKBM0PHOsnX2yhW7DerqEkGbwU/i5gAK33u3bjlf
	WHl38JmTo8JxjreoKgctTyT/ts9F6fwY=
X-Gm-Gg: AeBDiesRKRAOa7YuUVIdgUnr7YX0Zm8EMdGe9bAXSpLOW5Xa/+2iOhtMOkn37ahFOLB
	PTb24o5Ei10Bc7Uljlbv0rE1+ANT9VHXIx/3tzXVy1HUCzZ2CWb4LRaA4EFfa4yIHiTJ8by74ua
	uwadDwF8eKxBeMSjCIRFfWxrLsn7ceB7+hpJDF4Jun333jJAbW4bEopX/cWyAc23BGqDXgoty33
	1kbxFr344m92cwkafy3nYd6t6SfnJx2/Rc3/e3knv4fQccVFNemmC2hMUdpCEzuv0uif09iL2wb
	sR/7K5/Ec0VAT8lSRA==
X-Received: by 2002:a05:7022:6706:b0:12d:ce34:3f92 with SMTP id
 a92af1059eb24-12ddd9ae28dmr2409836c88.31.1777415686775; Tue, 28 Apr 2026
 15:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226223042.2027550-1-slava@dubeyko.com> <CAO8a2ShPx3j4UUwAY404VdzG7wE8O-nGRiv5twwyLek07_RVhA@mail.gmail.com>
 <CAO8a2Sh+=ef4mjp8tOR4HeqY9r4CaPJ7rCq1-WEmO25on7uSRA@mail.gmail.com>
In-Reply-To: <CAO8a2Sh+=ef4mjp8tOR4HeqY9r4CaPJ7rCq1-WEmO25on7uSRA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Apr 2026 00:34:34 +0200
X-Gm-Features: AVHnY4LpsUYfIo17tkzDzwjEMMBNEEXetao_2GCk-Cw8QjStyfVLY7UzMpRZiLo
Message-ID: <CAOi1vP9myLQWxNaqVGU__oPFO7gV=A-Jj15WShaWJ-iFd=36ww@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: fix kernel memory exposure issue in ceph_netfs_issue_op_inline()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:27=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Apologies, I acked the wrong patch here.
>
> The Bug is real and needs fixing, but there is a problem:
>
>
>   1. subreq->start is silently dropped
>
>   The original code:
>   len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
>   err =3D copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->=
io_iter);
>
>   The new code:
>   len =3D min_t(size_t, iinfo->inline_len, subreq->len);
>   err =3D copy_to_iter(iinfo->inline_data, len, &subreq->io_iter);
>
>   The subreq->start offset is completely removed. If subreq->start > 0
> with valid inline data, the wrong bytes are copied (always from offset
> 0 instead of the requested offset).
>    While CephFS inline data is typically small and subreq->start is
> likely 0 in practice, the fix is still semantically incorrect for the
> general case.
>
>   2. -EFAULT is the wrong error code. When inline_len =3D=3D 0, the data
> was uninlined; there's no inline payload.
>       Returning -EFAULT signals a user-address fault, which is
> misleading and will propagate as an I/O error instead of falling back
> to the OSD path.
>
>   3. Coding style violation. The } else without braces:
>       } else
>           err =3D -EFAULT;
>
>   I suggest the following:
>
>   A cleaner approach would preserve the offset logic and handle the
> edge cases properly:
>
>   if (iinfo->inline_len =3D=3D 0 || subreq->start >=3D iinfo->inline_len)=
 {
>       /* Nothing to copy; CLEAR_TAIL flag will zero-fill */
>       len =3D 0;
>   } else {
>       len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->le=
n);
>       err =3D copy_to_iter(iinfo->inline_data + subreq->start,
>                          len, &subreq->io_iter);
>       if (err =3D=3D 0)
>           err =3D -EFAULT;
>       else {
>           subreq->transferred +=3D err;
>           err =3D 0;
>       }
>   }
>
>   Or alternatively, treat inline_len =3D=3D 0 the same way as
> inline_version =3D=3D CEPH_INLINE_NONE and return false to let the caller
> fall back to a normal OSD read.

Hi Slava, Alex,

I'd suggest digging into why ceph_netfs_issue_op_inline() got invoked
in the first place instead, in a vein similar to my comments on
"[PATCH] ceph: fix generic/639 xfstests failure".  The call appears to
be conditioned on ceph_has_inline_data() so it won't be exactly the
same root cause but there is _got_ to be something else going on here.
I don't see how a file created by generic/013 (i.e. fsstress) on top of
the kernel client can legitimately have ceph_has_inline_data() return
false.

Thanks,

                Ilya

>
>  Alex
>
> On Mon, Apr 27, 2026 at 3:16=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> >
> > Reviewed-by: Alex Markuze <amarkuze@redhat.com>
> >
> > On Fri, Feb 27, 2026 at 12:30=E2=80=AFAM Viacheslav Dubeyko <slava@dube=
yko.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > Repeatable running of generic/013 test has revealed
> > > the kernel memory exposure attempt for 6.19.0-rc8+ in
> > > ceph_netfs_issue_op_inline():
> > >
> > > while true; do
> > >   sudo ./check generic/013
> > > done
> > >
> > > [17660.888303] ceph: ceph_netfs_issue_op_inline():317 iinfo->inline_d=
ata ffff8881000b0112,
> > > iinfo->inline_len 0, subreq->start 328187904, subreq->len 4096, len 0
> > > [17660.891728] usercopy: Kernel memory exposure attempt detected from=
 SLUB object 'kmemleak_object' (offset 274, size 4096)!
> > > [17660.893370] ------------[ cut here ]------------
> > > [17660.893377] kernel BUG at mm/usercopy.c:102!
> > > [17660.894426] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > > [17660.895749] CPU: 1 UID: 0 PID: 150873 Comm: fsstress Not tainted 6=
.19.0-rc8+ #13 PREEMPT(voluntary)
> > > [17660.896823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.17.0-9.fc43 06/10/2025
> > > [17660.897891] RIP: 0010:usercopy_abort+0x7a/0x7c
> > > [17660.898575] Code: 48 c7 c6 80 bb 3e 8c eb 0e 48 c7 c7 c0 bb 3e 8c =
48 c7 c6 00 bc 3e 8c 52
> > > 48 89 fa 48 c7 c7 40 bc 3e 8c 50 41 52 e8 e6 00 fb ff <0f> 0b e8 ef 0=
e fb 00 4d 89 e0 31 c9 44 89 f2 48 c7 c6 c0 bd 3e 8c
> > > [17660.901225] RSP: 0018:ffff888179fbf340 EFLAGS: 00010246
> > > [17660.901762] RAX: 000000000000006d RBX: ffff8881139ac112 RCX: 00000=
00000000000
> > > [17660.902295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000000
> > > [17660.902813] RBP: ffff888179fbf358 R08: 0000000000000000 R09: 00000=
00000000000
> > > [17660.903317] R10: 0000000000000000 R11: 0000000000000000 R12: 00000=
00000001000
> > > [17660.903820] R13: ffff8881139ad112 R14: 0000000000000001 R15: ffff8=
88119da8bb0
> > > [17660.904283] FS:  0000747714d62740(0000) GS:ffff888266112000(0000) =
knlGS:0000000000000000
> > > [17660.904719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [17660.905122] CR2: 00007477143ffff0 CR3: 00000001014f9005 CR4: 00000=
00000772ef0
> > > [17660.905555] PKRU: 55555554
> > > [17660.905743] Call Trace:
> > > [17660.905902]  <TASK>
> > > [17660.906042]  __check_heap_object+0xf1/0x130
> > > [17660.906372]  ? __virt_addr_valid+0x26b/0x510
> > > [17660.906667]  __check_object_size+0x401/0x700
> > > [17660.906959]  ceph_netfs_issue_read.cold+0x295/0x2f1
> > > [17660.907322]  ? __pfx_ceph_netfs_issue_read+0x10/0x10
> > > [17660.907657]  ? __kasan_check_write+0x14/0x30
> > > [17660.907940]  ? kvm_sched_clock_read+0x11/0x20
> > > [17660.908268]  ? sched_clock_noinstr+0x9/0x10
> > > [17660.908531]  ? local_clock_noinstr+0xf/0x120
> > > [17660.908817]  netfs_read_to_pagecache+0x45a/0x10f0
> > > [17660.909168]  ? netfs_read_to_pagecache+0x45a/0x10f0
> > > [17660.909482]  netfs_write_begin+0x589/0xfc0
> > > [17660.909761]  ? __kasan_check_read+0x11/0x20
> > > [17660.910019]  ? __pfx_netfs_write_begin+0x10/0x10
> > > [17660.910340]  ? mark_held_locks+0x46/0x90
> > > [17660.910629]  ? inode_set_ctime_current+0x3d0/0x520
> > > [17660.910965]  ceph_write_begin+0x8c/0x1c0
> > > [17660.911237]  generic_perform_write+0x391/0x8f0
> > >
> > > The reason of the issue is located in this code:
> > >
> > > err =3D copy_to_iter(iinfo->inline_data + subreq->start,
> > >                    len, &subreq->io_iter);
> > >
> > > We have valid pointer iinfo->inline_data ffff8881000b0112.
> > > The iinfo->inline_len has 0 size in bytes. However, subreq->start
> > > has really big value 328187904. Finally, the sum of iinfo->inline_dat=
a
> > > and subreq->start results in the pointer that is out of available
> > > memory area.
> > >
> > > This patch checks the iinfo->inline_len value. If it has zero value,
> > > then -EFAULT code error will be return. Otherwise, the copy_to_iter()
> > > logic will be executed.
> > >
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  fs/ceph/addr.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index e87b3bb94ee8..426121e38f3f 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -314,14 +314,18 @@ static bool ceph_netfs_issue_op_inline(struct n=
etfs_io_subrequest *subreq)
> > >                 return false;
> > >         }
> > >
> > > -       len =3D min_t(size_t, iinfo->inline_len - subreq->start, subr=
eq->len);
> > > -       err =3D copy_to_iter(iinfo->inline_data + subreq->start, len,=
 &subreq->io_iter);
> > > -       if (err =3D=3D 0) {
> > > +       if (iinfo->inline_len > 0) {
> > > +               len =3D min_t(size_t, iinfo->inline_len, subreq->len)=
;
> > > +
> > > +               err =3D copy_to_iter(iinfo->inline_data, len, &subreq=
->io_iter);
> > > +               if (err =3D=3D 0) {
> > > +                       err =3D -EFAULT;
> > > +               } else {
> > > +                       subreq->transferred +=3D err;
> > > +                       err =3D 0;
> > > +               }
> > > +       } else
> > >                 err =3D -EFAULT;
> > > -       } else {
> > > -               subreq->transferred +=3D err;
> > > -               err =3D 0;
> > > -       }
> > >
> > >         ceph_mdsc_put_request(req);
> > >  out:
> > > --
> > > 2.53.0
> > >
>
