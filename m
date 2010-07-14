From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Linux 2.6.35-rc5
Date: Wed, 14 Jul 2010 10:49:08 -0700
Message-ID: <AANLkTilbabX3IoxHvC5ljAsNpKRg6YRhJ0GjyspIEh47@mail.gmail.com>
References: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com>
	<20100714174138.GC27457@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40716 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab0GNRtK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 13:49:10 -0400
Received: by fxm14 with SMTP id 14so3741fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 10:49:08 -0700 (PDT)
In-Reply-To: <20100714174138.GC27457@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Check out the backports at
http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-standalone=
=2Egit;a=3Dsummary.
-Greg

On Wed, Jul 14, 2010 at 10:41 AM, Andre Noll <maan@systemlinux.org> wro=
te:
> Hi Sage,
>
> On Mon, Jul 12, 16:37, Linus Torvalds wrote:
>> Sage Weil (10):
>> =A0 =A0 =A0 ceph: fix map handler error path
>> =A0 =A0 =A0 ceph: fix message memory leak, uninitialized variable
>> =A0 =A0 =A0 ceph: fix crush map update decoding
>> =A0 =A0 =A0 ceph: handle splice_dentry/d_materialize_unique error in
>> readdir_prepopulate
>> =A0 =A0 =A0 ceph: delay umount until all mds requests drop inode+den=
try refs
>> =A0 =A0 =A0 ceph: fix crush recursion
>> =A0 =A0 =A0 ceph: fix crush CHOOSE_LEAF when type is already a leaf
>> =A0 =A0 =A0 ceph: only release clean, unused caps with mds requests
>> =A0 =A0 =A0 ceph: fix caps usage accounting for import (non-reserved=
) case
>> =A0 =A0 =A0 ceph: fix crush device 'out' threshold to 1.0, not 0.1
>
> Are you planning to backport any of these to the 2.6.34 stable tree?
>
> Thanks
> Andre
> --
> The only person who always got his work done by Friday was Robinson C=
rusoe
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
>
> iD8DBQFMPfbSWto1QDEAkw8RAi7GAJ9o1oHBjrhcqOTmqVUblatXMk+0+gCeKwou
> qWcQxvWt+2F5Zs6Y87EOi14=3D
> =3DgDTp
> -----END PGP SIGNATURE-----
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
