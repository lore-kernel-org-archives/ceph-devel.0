From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Wed, 11 Feb 2015 09:32:55 +0100
Message-ID: <54DB13B7.5080901@profihost.ag>
References: <54DA541E.9000608@profihost.ag> <1998825137.362471.1423640652791.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52278 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbBKIc6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 03:32:58 -0500
In-Reply-To: <1998825137.362471.1423640652791.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Am 11.02.2015 um 08:44 schrieb Alexandre DERUMIER:
>>> same fio, same qemu, same vm, same host, same ceph dumpling storage=
,=20
>>> different librados / librbd: 16k iop/s for random 4k writes
>>>
>>> What's wrong with librbd / librados2 since firefly?
>=20
> Maybe could we bissect this ?
>=20
> Maybe testing intermediate librbd releases between dumpling and firef=
ly,
>=20
> http://gitbuilder.ceph.com/ceph-deb-wheezy-x86_64-basic/ref/

Yes may be. Sadly i've currently another problem on my newest cluster
having strange kworker workload - i've never noticed before on any ceph
system. All writes are hanging - while using the same kernel as everywh=
ere.

Stefan

>=20
> could we give us an hint.
>=20
>=20
> ----- Mail original -----
> De: "Stefan Priebe" <s.priebe@profihost.ag>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mardi 10 F=C3=A9vrier 2015 19:55:26
> Objet: speed decrease since firefly,giant,hammer the 2nd try
>=20
> Hello,=20
>=20
> last year in june i already reported this but there was no real resul=
t.=20
> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070=
=2Ehtml)=20
>=20
> I then had the hope that this will be fixed itself when hammer is=20
> released. Now i tried hammer an the results are bad as before.=20
>=20
> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s=20
> than dumpling - this is also the reason why i still stick to dumpling=
=2E=20
>=20
> I've now modified my test again to be a bit more clear.=20
>=20
> Ceph cluster itself completely dumpling.=20
>=20
> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for ran=
dom=20
> 4k writes=20
>=20
> - stopped qemu=20
> - cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/=20
> - cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/=20
> - start qemu=20
>=20
> same fio, same qemu, same vm, same host, same ceph dumpling storage,=20
> different librados / librbd: 16k iop/s for random 4k writes=20
>=20
> What's wrong with librbd / librados2 since firefly?=20
>=20
> Greets,=20
> Stefan=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
