From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 10:13:03 +0200 (CEST)
Message-ID: <acf48b9c-2c6a-46a7-9939-318325999f89@mailpro>
References: <4FB8A3A5.5090809@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47685 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2ETINZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 04:13:25 -0400
In-Reply-To: <4FB8A3A5.5090809@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

I think that depend how much random writes io you have and acceptable l=
atency you need.

(As the purpose of the journal is to take random io then flush them seq=
uentially to slow storage).

Maybe some slower ssd will fill your needs.
(just be carefull of performance degradation in time, trim,....)




----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Gregory Farnum" <greg@inktank.com>=20
Envoy=C3=A9: Dimanche 20 Mai 2012 09:56:21=20
Objet: Re: Designing a cluster guide=20

Am 19.05.2012 18:15, schrieb Alexandre DERUMIER:=20
> Hi,=20
>=20
> For your journal , if you have money, you can use=20
>=20
> stec zeusram ssd drive. (around 2000=E2=82=AC /8GB / 100000 iops read=
/write with 4k block).=20
> I'm using them with zfs san, they rocks for journal.=20
> http://www.stec-inc.com/product/zeusram.php=20
>=20
> another interessesting product is ddrdrive=20
> http://www.ddrdrive.com/=20

Great products but really expensive. The question is do we really need=20
this in case of rbd block device.=20

Stefan=20



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
