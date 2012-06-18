From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 16:04:58 +0200 (CEST)
Message-ID: <1442f6d7-6fd3-4518-89f3-2bcaa21f1949@mailpro>
References: <4FDF2D56.7010108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41177 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2FROFY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 10:05:24 -0400
In-Reply-To: <4FDF2D56.7010108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark,

>>Sorry I got behind at looking at your output last week. I've created =
a=20
>>seekwatcher movie of your blktrace results here:=20
>>
>>http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20

how do you create seekwatcher movie from blktrace ? (I'd like to create=
 them myself, seem good to debug)


>>The results match up well with your iostat output. Peaks and valleys =
in=20
>>the writes every couple of seconds. Low numbers of seeks, so probably=
=20
>>not limited by the filestore (a quick "osd tell X bench" might confir=
m=20
>>that).=20

yet, i'm pretty sure that the limitation if not hardware. (each osd are=
 15k drive, handling around 10MB/S during the test, so I think it shoul=
d be ok ^_^ )
how do you use "osd tell X bench" ?

>>I'm wondering if you increase "filestore max sync interval" to someth=
ing=20
>>bigger (default is 5s) if you'd see somewhat different behavior. Mayb=
e=20
>>try something like 30s and see what happens?=20

I have done test with 30s, that doesn't change nothing.
I have try with filestore min sync interval =3D 29  + filestore max syn=
c interval =3D 30




----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 15:29:58=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On 6/18/12 7:34 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm doing test with rados bench, and I see constant writes to osd dis=
ks.=20
> Is it the normal behaviour ? with write-ahead should write occur each=
 20-30 seconde ?=20
>=20
>=20
> Cluster is=20
> 3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1 =
journal on tmpfs 8GB - 1 osd (xfs) on sas disk - 1 gigabit link=20
>=20
>=20
> 8GB journal can handle easily 20s of write (1 gigabit link)=20
>=20
> [osd]=20
> osd data =3D /srv/osd.$id=20
> osd journal =3D /tmpfs/osd.$id.journal=20
> osd journal size =3D 8000=20
> journal dio =3D false=20
> filestore journal parallel =3D false=20
> filestore journal writeahead =3D true=20
> filestore fiemap =3D false=20
>=20
>=20
>=20
>=20
> I have done tests with differents kernel (3.0,3.2,3.4) , differents f=
ilesystem (xfs,btrfs,ext4), forced journal mode to writeahead.=20
> Bench were done write rados bench and fio.=20
>=20
> I always have constant write since the first second of bench start.=20
>=20
> Any idea ?=20

Hi Alex,=20

Sorry I got behind at looking at your output last week. I've created a=20
seekwatcher movie of your blktrace results here:=20

http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20

The results match up well with your iostat output. Peaks and valleys in=
=20
the writes every couple of seconds. Low numbers of seeks, so probably=20
not limited by the filestore (a quick "osd tell X bench" might confirm=20
that).=20

I'm wondering if you increase "filestore max sync interval" to somethin=
g=20
bigger (default is 5s) if you'd see somewhat different behavior. Maybe=20
try something like 30s and see what happens?=20

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
