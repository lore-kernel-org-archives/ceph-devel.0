From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Tue, 13 Aug 2013 21:47:38 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B63896729@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
	<CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au>
	<CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au>
	<CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au>
 <CAF6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:38507 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986Ab3HMVr4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 17:47:56 -0400
In-Reply-To: <CAF6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?iso-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Just noticed email subject "qemu-1.4.0 and onwards, linux kernel 3.2.x,=
 ceph-RBD, heavy I/O leads to kernel_hung_tasks_timout_secs message and=
 unresponsive qemu-process, [Qemu-devel] [Bug 1207686]" where Sage note=
d that he has seen a completion called twice in the logs the OP posted.=
 If that is actually happening (and not just an artefact of logging rin=
g buffer overflowing or something) then I think that could easily cause=
 a segfault in tapdisk rbd.

I'll try and see if I can log when that happens.

James

> -----Original Message-----
> From: Sylvain Munaut [mailto:s.munaut@whatever-company.com]
> Sent: Tuesday, 13 August 2013 7:20 PM
> To: James Harper
> Cc: Pasi K=E4rkk=E4inen; ceph-devel@vger.kernel.org; xen-devel@lists.=
xen.org
> Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wan=
ts to
> test ? :p
>=20
> Hi,
>=20
> > I hope not. How could I tell? It's not something I've explicitly en=
abled.
>=20
> It's disabled by default.
>=20
> So you'd have to have enabled it either in ceph.conf  or directly in
> the device path in the xen config. (option is 'rbd cache',
> http://ceph.com/docs/next/rbd/rbd-config-ref/ )
>=20
> Cheers,
>=20
>     Sylvain
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
