Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5B3A1A21
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327215; cv=none; b=SAwpJinpW7X5AjX8VjW9IUpIsZhscZNfYmamC+DCcH1fmbIThho4Y81SOGFTsdpwiqS58pKjJVV8f02uSImuLsXxIjbkZRcj+DsAHW8fDiGjymn0cLHpeumBvV+N9Sw5QiDXIxOdtY7sCsm8y3qrtUFj6t7UwvFjftk7mptRqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327215; c=relaxed/simple;
	bh=e63n+1rAZnD7Qdf59l6vprJ4f2AGBjSdcDAeVacg8UA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUTSopAPna5FMBxhFcQWoY85um5LX4QRZWNwFTK3umlQY0Tz4YPpFRV9Z86wpdyOP0JIfT5OUj+ExbCIvdaefRiUxLld5m8oZQTlsyHSx7af6VG3HFBV2GKXO0ZcbchEIpO7/TeVDjokFyacfJYfHSb91PRad2p2zrg5De4xvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZxJe02F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVq7SS3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZxJe02F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVq7SS3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777327212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9P1J0I6C+Y4ucFeQdtSrWCxt3KuQjtdzTVKNGZ573Wc=;
	b=dZxJe02Fr7ikYrrPHuzQ3Q/A6fuaT6azlLkQvuxLdjWZomqTMfdznYRyeAH7xI1gW9XClW
	r1ygry9jPFh0qnAJxM6P1L8aGdfxjQUFnQUFmD5SprI0u0ghluGZVGhsyGVvIR3OZa7Yc6
	yzUuQwCUQfIbbo7NU82/+CsUSuUYSSY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ujPXcJzyMMC8CisJMht0WQ-1; Mon, 27 Apr 2026 18:00:11 -0400
X-MC-Unique: ujPXcJzyMMC8CisJMht0WQ-1
X-Mimecast-MFC-AGG-ID: ujPXcJzyMMC8CisJMht0WQ_1777327211
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79aa3a19ea3so189166197b3.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777327211; x=1777932011; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9P1J0I6C+Y4ucFeQdtSrWCxt3KuQjtdzTVKNGZ573Wc=;
        b=GVq7SS3QnBbLWLdjh7qqA5UcB5imIOHpQeuo8H32ZZl66l4TLYWTPhkvi50XPy+TSa
         +S37YFJx3Bp7pypeutri8o2oT46TnTKA4N9z2pe5TJujKaUoHehFf7lXBo2DduVEacDg
         zPrNJmoo3U4/96NoH+C12po6AevoWCdoS2gaAkgZQFr6xsKYPxDCY7YHFhIu1+CLqnXl
         VyUOKKK351zJ4fldrxFWgMvbiQ573KEXJvYFC+IP8rJ25rMm5UoA1100lEvn57DuYuel
         6xfuAzIIuEX6FXJ0bimTuB91Hj4NI1bvC9xMRY3R8m7pBHg9PmKXTlL1V5/17URzVdeo
         vKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327211; x=1777932011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P1J0I6C+Y4ucFeQdtSrWCxt3KuQjtdzTVKNGZ573Wc=;
        b=KUubvVGe2or0zWvO3ULZYCl3bRDDEGPOLuxlwkHtJs1Q0ERvNHH+eceKmFG4d6ug7z
         xYA3eCWVYmpBXY4c1n2+2rfjlxdLs5QQPzZpMFfx6Ya9E+zzfW+MkTz8b0ISbr01e2l8
         2s45yqyXAuDpkcWAYgATRTnEkNWR+uVX4f5B7fhGAWMU7awZNPVkPSrZEFleVJBEEERc
         s3qhLZCcN8OdIGCSQ5CAGMT2NWpNVHAmcs9f0ZkHhgDxpV2egwdkkAVT9nXKTCswMVkg
         mLD9DuLEq8gzr3BRVQWRHgKJG2RWBWXuqD+eRKp4qciiIAiXlMjUtTHY1ps9EHKiIFkP
         w7YA==
X-Gm-Message-State: AOJu0YzaP5jTWgPGMUKxtDUQ1Dxa5S7wUM1wAJzlbnc4HAzSZkPKfNvC
	+1IyWvbLoDkSizKQBZBVb8qv+TOAEwsVSYzaXrgSCrMC43VzfF7fyqVg3ENjgbXZvgli4OpFnH+
	/UJHl5pFj6waZd1MSvHjBRdMGtXYZtskK0piflzMhBKQD3Cb6a8yhEyEpC6fBCLk=
X-Gm-Gg: AeBDievjzzKqAwpTqj6ISEQkAVvUM1lr5/8hll0uVveBuTOo3G2pviETDf6dIJdBfWA
	YaGN8zDXlp+RrgFG73fRt8vm6nGxe6gCK6p9VfnAymFaD1veXEDiqLpfCZ49ZkTSEcDl35Sz5Hg
	H9qzxsiHHEQlslNAYLr+BNTiHLTsO5DwAAa1JBSSr9mWKr4T2lbTEWqchn8WY3tM0XoMATLE6WD
	s8qyciquNVzuURNPxZl1nTbYxxi3d0/9Ttylm5yxF0Zyi+aE9b83IOoVLocKxTyOlQJFc7kvzoi
	NxGc9qUBYVWL8YdZLv+XSb6d5+B5CAWO+jvdtqHhrv9rf7wTGFtDRFYssRy70pw01El7SYhy0h6
	6sYyzl30d29B/8UMBr6oi6NNx6nRncTkT0yWYxkghoXiqAOZOXJQfEUrLKIsxbPE=
X-Received: by 2002:a05:690c:1d:b0:7b3:9175:30a4 with SMTP id 00721157ae682-7bcf51fbcedmr4206967b3.15.1777327210592;
        Mon, 27 Apr 2026 15:00:10 -0700 (PDT)
X-Received: by 2002:a05:690c:1d:b0:7b3:9175:30a4 with SMTP id 00721157ae682-7bcf51fbcedmr4206487b3.15.1777327209968;
        Mon, 27 Apr 2026 15:00:09 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf0aec5f1sm3361017b3.23.2026.04.27.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 15:00:09 -0700 (PDT)
Message-ID: <f2bb92bd6f5b34b92f229a3ec1f2e4fe20931240.camel@redhat.com>
Subject: Re: [RFC PATCH] ceph: fix kernel memory exposure issue in
 ceph_netfs_issue_op_inline()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com
Date: Mon, 27 Apr 2026 15:00:07 -0700
In-Reply-To: <CAO8a2Sh+=ef4mjp8tOR4HeqY9r4CaPJ7rCq1-WEmO25on7uSRA@mail.gmail.com>
References: <20260226223042.2027550-1-slava@dubeyko.com>
	 <CAO8a2ShPx3j4UUwAY404VdzG7wE8O-nGRiv5twwyLek07_RVhA@mail.gmail.com>
	 <CAO8a2Sh+=ef4mjp8tOR4HeqY9r4CaPJ7rCq1-WEmO25on7uSRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-27 at 15:27 +0300, Alex Markuze wrote:
> Apologies, I acked the wrong patch here.
>=20
> The Bug is real and needs fixing, but there is a problem:
>=20
>=20
>   1. subreq->start is silently dropped
>=20
>   The original code:
>   len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
>   err =3D copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->=
io_iter);

The subreq->start is meaningless here. We cannot use subreq->start at all. =
We
need to know the offset inside of inline buffer. Mostly, it should be small
enough. If we would like to process it in the correct way, probably, we nee=
d to
introduce some special field in some structure. But subreq->start is comple=
tely
inapplicable in this calculation.

During testing I saw that subreq->start was 0. And I saw subreq->start =3D=
=3D 32768
something for the case of issue.

>=20
>   The new code:
>   len =3D min_t(size_t, iinfo->inline_len, subreq->len);
>   err =3D copy_to_iter(iinfo->inline_data, len, &subreq->io_iter);
>=20
>   The subreq->start offset is completely removed. If subreq->start > 0
> with valid inline data, the wrong bytes are copied (always from offset
> 0 instead of the requested offset).
>    While CephFS inline data is typically small and subreq->start is
> likely 0 in practice, the fix is still semantically incorrect for the
> general case.
>=20
>   2. -EFAULT is the wrong error code. When inline_len =3D=3D 0, the data
> was uninlined; there's no inline payload.
>       Returning -EFAULT signals a user-address fault, which is
> misleading and will propagate as an I/O error instead of falling back
> to the OSD path.
>=20

Which error code do you suggest to use here?

>   3. Coding style violation. The } else without braces:
>       } else
>           err =3D -EFAULT;
>=20

I can rework it.

>   I suggest the following:
>=20
>   A cleaner approach would preserve the offset logic and handle the
> edge cases properly:
>=20
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
>=20
>   Or alternatively, treat inline_len =3D=3D 0 the same way as
> inline_version =3D=3D CEPH_INLINE_NONE and return false to let the caller
> fall back to a normal OSD read.
>=20

We can use subreq->start at all. We need to consider something else.

Thanks,
Slava.

>  Alex
>=20
> On Mon, Apr 27, 2026 at 3:16=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> >=20
> > Reviewed-by: Alex Markuze <amarkuze@redhat.com>
> >=20
> > On Fri, Feb 27, 2026 at 12:30=E2=80=AFAM Viacheslav Dubeyko <slava@dube=
yko.com> wrote:
> > >=20
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >=20
> > > Repeatable running of generic/013 test has revealed
> > > the kernel memory exposure attempt for 6.19.0-rc8+ in
> > > ceph_netfs_issue_op_inline():
> > >=20
> > > while true; do
> > >   sudo ./check generic/013
> > > done
> > >=20
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
> > >=20
> > > The reason of the issue is located in this code:
> > >=20
> > > err =3D copy_to_iter(iinfo->inline_data + subreq->start,
> > >                    len, &subreq->io_iter);
> > >=20
> > > We have valid pointer iinfo->inline_data ffff8881000b0112.
> > > The iinfo->inline_len has 0 size in bytes. However, subreq->start
> > > has really big value 328187904. Finally, the sum of iinfo->inline_dat=
a
> > > and subreq->start results in the pointer that is out of available
> > > memory area.
> > >=20
> > > This patch checks the iinfo->inline_len value. If it has zero value,
> > > then -EFAULT code error will be return. Otherwise, the copy_to_iter()
> > > logic will be executed.
> > >=20
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  fs/ceph/addr.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index e87b3bb94ee8..426121e38f3f 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -314,14 +314,18 @@ static bool ceph_netfs_issue_op_inline(struct n=
etfs_io_subrequest *subreq)
> > >                 return false;
> > >         }
> > >=20
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
> > >=20
> > >         ceph_mdsc_put_request(req);
> > >  out:
> > > --
> > > 2.53.0
> > >=20

