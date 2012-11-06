From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 06 Nov 2012 18:14:43 +0100 (CET)
Message-ID: <0b278d23-64b2-4219-9a0f-0ba8936cc095@mailpro>
References: <50993B61.3090500@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49728 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab2KFRPN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 12:15:13 -0500
In-Reply-To: <50993B61.3090500@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

syncfs is only available since glibc 2.14 (and kernel 2.6.39)

----- Mail original -----=20

De: "Oliver Francke" <Oliver.Francke@filoo.de>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 6 Novembre 2012 17:31:29=20
Objet: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend=20

In answer to myself,=20

On 11/06/2012 05:14 PM, Oliver Francke wrote:=20
> Hi *,=20
>=20
> anybody out there who's in Ubuntu 12.04.1/ in connection with libc +=20
> xfs + syncfs?=20

ii libc6 2.15-0ubuntu10.3=20

but:=20
apt-cache show...=20
=2E=20
=2E=20
Provides: glibc-2.13-1=20
=2E=20
=2E=20

playing with numbers, I think. But make clear, why syncfs-call is not i=
n :-\=20

=2E.. search continues...=20

>=20
> We bit the bullet and reinstalled two new nodes from debian to precis=
e=20
> in favour of possible performance increase?!=20
>=20
> *sigh*, still getting:=20
>=20
> 2012-11-06 17:05:51.863921 7f5cc52e3780 0 filestore(/data/osd6-3)=20
> mount syncfs(2) syscall not support by glibc=20
> 2012-11-06 17:05:51.863925 7f5cc52e3780 0 filestore(/data/osd6-3)=20
> mount no syncfs(2), must use sync(2).=20
>=20
> as a show-stopper.=20
>=20
> That's with 3.2.* and 3.6.6 kernel. Should be new enough. And=20
> ceph-0.48.2 ( eu.ceph.com mirror was installing 0.48.1.. though *ops*=
=20
> ;) )=20
>=20
> But both should be capable of this system-call?!=20
>=20
> We've been so very near... but now clueless, please sched some light=20
> in 8-)=20
>=20
> ( I hope this is not a very obvious human RTFM error ;) )=20
>=20
> And so I'm writing, should one enable directio + aio, as we're having=
=20
> the journals on a SSD-partition?=20
>=20
> Kind regards,=20
>=20
> Oliver.=20
>=20


--=20

Oliver Francke=20

filoo GmbH=20
Moltkestra=C3=9Fe 25a=20
33330 G=C3=BCtersloh=20
HRB4355 AG G=C3=BCtersloh=20

Gesch=C3=A4ftsf=C3=BChrer: S.Grewing | J.Rehp=C3=B6hler | C.Kunz=20

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
