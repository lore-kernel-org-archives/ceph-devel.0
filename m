From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: not able to run src/ceph any longer
Date: Mon, 23 May 2016 11:07:35 +0200
Message-ID: <2b8f5ecb-04a1-14e7-716f-0e24f336c780@digiware.nl>
References: <c6296508-10eb-f78a-f0e1-6bac2d1be6ea@digiware.nl>
 <CO1PR02MB15969B16BE9ECF2C0A4A07B944E0@CO1PR02MB159.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:25086 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbcEWJR5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2016 05:17:57 -0400
In-Reply-To: <CO1PR02MB15969B16BE9ECF2C0A4A07B944E0@CO1PR02MB159.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomy Cheru <Tomy.Cheru@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23-5-2016 06:10, Tomy Cheru wrote:
> Try "export LD_LIBRARY_PATH=3D/usr/srcs/Ceph/work/ceph/src"

I currently fixed it real hardcore:

- Added libglobal.la to the LD_ADD for librados.
Although that works, but is probably not the way to go.

Also had trouble with lots of the rgw unit tests that were also
complaining about this during linking. That is not solved by the above
sollution. So started adding CEPH_GLOBAL to their LD_ADD make options,
but that agina is probably not the way to do it.

I guess I've changed too much in a lot of the build files.

--WjW

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Willem Jan Withagen
> Sent: Monday, May 23, 2016 4:40 AM
> To: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: not able to run src/ceph any longer
>=20
> Hi,
>=20
> When the testscripts try to run src/ceph I get:
>=20
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH *** =
Traceback (most recent call last):
>   File "src/ceph", line 118, in <module>
>     import rados
> ImportError: /usr/srcs/Ceph/work/ceph/src/.libs/librados.so.2: Undefi=
ned symbol "g_ceph_context"
>=20
> which is in libglobal, but if I try to link that to librados I'm just=
 getting nothing but dubble definitions and errors.
>=20
> Where have things gone wrong for me?
> How should "import rados" get the g_ceph_context?
>=20
> Thanx
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
