From: Loic Dachary <loic@dachary.org>
Subject: Re: What crush ruleset for a given SHEC configuration ?
Date: Tue, 19 May 2015 12:47:00 +0200
Message-ID: <555B14A4.5000008@dachary.org>
References: <555ADA6F.7000702@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AAF9098@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="257Bn8i7qMslu9wPvP6GDD2Uo2wCT5r9C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37723 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753405AbbESKrE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 06:47:04 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AAF9098@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--257Bn8i7qMslu9wPvP6GDD2Uo2wCT5r9C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/05/2015 11:11, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> to recover D6 which is in rack 2 it may be necessary to use P2 from ra=
ck 1
>=20
> Because D6 can be recovered from P3 as well, P2 is not necessarily used=
 to recover D6.
> However, when D6 is recovered from P3, D5 which is in rack 1 must be re=
ad.
> Therefore, I believe Ceph-LRC is more efficient when network resources =
is poor such as
> in case of Geo-Replication. SHEC should be used in a single data center=
 that has enough
> network resources.

Thanks for the detailed explanation, it is clear now :-)

Cheers

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Tuesday, May 19, 2015 3:39 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development
> Subject: What crush ruleset for a given SHEC configuration ?
>=20
> Hi Takeshi,
>=20
> In the context of http://ceph.com/docs/master/rados/operations/erasure-=
code-shec/ it would be useful to have a more detailed explanation of why =
SHEC is more efficient during recovery (in the introduction).=20
>=20
> Am I correct to assume that SHEC does not provide a way to control the =
locality of the chunks ? For instance in the following scenario:
>=20
> rack 1 has 10 OSDs
> rack 2 has 10 OSDs
>=20
> a crush ruleset is made to provide 15 OSDs with 7 in the first rack, 8 =
in the last rack: the first 7 are in rack 1, the last 8 in rack 2. When S=
HEC is used with such a crush ruleset, it cannot guarantee that the loss =
of one chunk in rack 2 can always be recovered with chunks from rack 2. W=
hen reading at figure 3 of
>=20
> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code_=
%28SHEC%29
>=20
> with D1 to D5, P1 and P2 in rack 1 and D6 to D10, P3, P4, P5 in rack 2,=
 my understanding is that to recover D6 which is in rack 2 it may be nece=
ssary to use P2 from rack 1. And to recover D5 which is in rack 1 it may =
be necessary to use P3 from rack 2.
>=20
> Maybe I'm missing something ? Thanks in advance for your explanations :=
-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--257Bn8i7qMslu9wPvP6GDD2Uo2wCT5r9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVbFKQACgkQ8dLMyEl6F20hbACgpBti3cuJ8W/FETyWZYrMcwKl
C+sAn0+x/VUa7U35I2CQS4sz7U6NqIQa
=hXyE
-----END PGP SIGNATURE-----

--257Bn8i7qMslu9wPvP6GDD2Uo2wCT5r9C--
