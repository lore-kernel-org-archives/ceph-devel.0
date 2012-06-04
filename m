From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 15:07:03 +0200 (CEST)
Message-ID: <09037cad-1a2a-4adb-bedb-91fbdeb5ad79@mailpro>
References: <4FCCB14E.6030109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:32950 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab2FDNHZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 09:07:25 -0400
In-Reply-To: <4FCCB14E.6030109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

Thanks Mark,
I'll rebuild my cluster with ubuntu precise tomorrow. (Don't have time =
to backport/maintain libc6 ;)


BTW, do you use mainly ubuntu at intank for your tests ?

I'd like to have a setup as close as possible of intank setup.


----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Amon Ott" <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann =
Dupont" <Yann.Dupont@univ-nantes.fr>=20
Envoy=C3=A9: Lundi 4 Juin 2012 14:59:58=20
Objet: Re: Infiniband 40GB=20

On 6/4/12 6:40 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm currently doing some tests with xfs, debian wheezy with standard =
libc6 (2.11.3-3) and 3.2 kernel.=20
>=20
> I'm doing some iostats(3 nodes with 5 osd), and I see constant writes=
 to disks.(as the datas are flushed each second from journal to disk).=20
>=20
> Journal is big enough (20GB tmpfs) to handle 30s of write.=20
>=20
> Do you think it's related to the missing syncfs() support ?=20
>=20
> -Alexandre=20

Hi Alexandre,=20

I've included some seekwatcher results for rados bench tests using 16=20
concurrent 4MB writes on XFS OSD. One shows ubuntu oneiric and the=20
other precise (ie no syncfs support vs syncfs support in libc).=20
Unfortunately the original test was on 0.46 and the second test was on=20
0.47.2, so multiple things changed between the tests. Both were tested=20
with kernel 3.4. Interestingly the seeks/second don't seem to drop much=
=20
but the overall performance has about doubled. This was using a single=20
7200rpm disk for the OSD data disk and a seperate 7200rpm disk for the=20
journal in both cases. I'd definitely try 0.47.2 with a new libc though=
=20
and see how that works for you.=20

ceph 0.46/oneiric:=20
http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-oneiric-3.4.mpg=20

ceph 0.47.2/precise:=20
http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-precise-3.4.mpg=20

Mark=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
