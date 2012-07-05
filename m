From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 05 Jul 2012 20:33:34 +0200 (CEST)
Message-ID: <1cbe6062-75ed-4fe1-b54c-ceab8bdd3bbf@mailpro>
References: <4FF5D5C3.80207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50957 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2GESd5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 14:33:57 -0400
In-Reply-To: <4FF5D5C3.80207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: David Blundell <David.Blundell@100percentit.com>, ceph-devel@vger.kernel.org

It was during a random write (fio benchmark).

I can't reproduce it now,I'll try to do tests again this week.

----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "David Blundell" <David.Blundell@100percentit.com>, ceph-devel@vger=
=2Ekernel.org=20
Envoy=C3=A9: Jeudi 5 Juillet 2012 19:58:27=20
Objet: Re: Slow request warnings on 0.48=20

On 07/04/2012 11:58 AM, Alexandre DERUMIER wrote:=20
> Hi, I see same messages here after upgrade to 0.48.=20
>=20
> with random write benchmark.=20
>=20
> I have more lags than before with 0.47 (but disks are at 100% usage, =
so can't tell if it's normal or not)=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "David Blundell"<David.Blundell@100percentit.com>=20
> =C3=80: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Mercredi 4 Juillet 2012 18:53:02=20
> Objet: Slow request warnings on 0.48=20
>=20
> I have three servers running mon and osd using Ubuntu 12.04 that I ha=
ve been testing with RADOS storing RBD KVM instances=20
>=20
> 0.47.3 worked extremely well (once I got over a few btrfs issues). Th=
e same servers running 0.48 give a large number of "[WRN] slow request"=
 messages whenever I generate a lot of random IO in the KVM instances u=
sing iozone. The slow responses eventually leads to disk timeouts on th=
e KVM instances.=20
>=20
> I have erased the osds and recreated on new btrfs volumes with the sa=
me result.=20
>=20
> I have also tried switching to xfs using mkfs.xfs -n size=3D64k with =
noatime, inode64,delaylog,logbufs=3D8,logbsize=3D256k=20
>=20
> Xfs gives the same result - the iozone tests run fine until the rando=
m IO starts and then there are lots of slow request warnings.=20
>=20
> Does anyone have any ideas about the best place to start troubleshoot=
ing / debugging?=20
>=20
> Thanks,=20
>=20
> David=20

Hi David and Alexandre,=20

Does this only happen with random writes or also sequential writes? If=20
it happens with sequential writes as well, does it happen with rados be=
nch?=20

--=20
Mark Nelson=20
Performance Engineer=20
Inktank=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
