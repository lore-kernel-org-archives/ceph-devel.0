From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: q. about rbd-header
Date: Wed, 14 Mar 2012 21:49:15 +0100
Message-ID: <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de>
References: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:47328 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759099Ab2CNUtS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 16:49:18 -0400
In-Reply-To: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Well,

nobody able to sched some light in?
Did some math and found out how to fill the size bytes.

But, one question never got answered:
    - why is - with busy VMs - frequently the first block affected,
      with the result of damaged grub-loaders/partition-tables/filesyst=
ems?
      Is this some NULL/zero pointer thingy in case of ceph-failure?

If you demand some broken images=85 we have many of them to investigate=
,
unfortunately.

Maybe this sounds a bit harsh, after the 5th night-shift trying to repa=
ir images
and keep customers calm, I think this is forgivable.

Oliver.

Am 14.03.2012 um 16:05 schrieb Oliver Francke:

> Hey,
>=20
> anybody out there who could explain the structure of a rbd-header? Af=
ter=20
> last crash we have about 10 images with a:
>   2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading=20
> header: 2 No such file or directory
> error opening image vm-266-disk-1.rbd: 2 No such file or directory
> ... error?
> I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But=20
> the size/count encoding is not intuitive ;)
>=20
> Besides one file, where I "created" a header and putted it via "rados=
=20
> put" back into the pool, and got some files
> back, many of the other images with lost headers have different sizes=
=2E
>=20
> We got bad luck again, too many crashed VM's, too much data-loss...
>=20
> Comments welcome ;)
>=20
> Oliver.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
