From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Fri, 21 Jun 2013 10:29:17 +0200
Message-ID: <51C40EDD.9090909@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local> <51C00FDB.6030803@polytech.univ-nantes.fr> <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu> <51C34932.4080304@dachary.org> <622F4407872BA447A16110F65453358C01A4D8066EE7@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C50D5D40BF3F6680EBD6131"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54134 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423228Ab3FUI3V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 04:29:21 -0400
In-Reply-To: <622F4407872BA447A16110F65453358C01A4D8066EE7@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C50D5D40BF3F6680EBD6131
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/21/2013 03:23 AM, Paul Von-Stamwitz wrote:
>=20
> On 06/20/2013 11:26 PM, Loic Dachary wrote:
>>
>> I wrote down a short description of the read/write path I plan to
>> implement in ceph :
> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/era=
sure-code.rst.
>> A quick look at the drawings will hopefully give you an idea. Each OSD=
 is > a disk connected to the others over the network. Although I chose K=
+M =3D 5 > I suspect the most common use case will be around K+M =3D 7+3 =
=3D 10
>=20
> Hi Loic,
>=20
> A couple questions regarding your proposal:
>=20
> Where would encode/decode occur? Client or OSD? Previous discussions se=
emed to want it at the OSD level. Your proposal seems that it could be ei=
ther.

I think it should be in the OSD. Although it would be possible to impleme=
nt it in the client, it would have to be implemented in the OSD anyway fo=
r scrubbing. Therefore I think it is simpler to implement it in the OSD a=
s a first step.

>=20
> What about partial reads? For example, if only 'H' was requested, would=
 you decode the entire object first?=20

Unless you see a good reason to implement this optimization from the star=
t, I think the entire object would be decoded.

> Or, read from OSD1 and reconstruct on error?

I think that's what we want, ultimately. And also to encode / decode larg=
e objects (1GB for instance) as a sequence of independant regions (4MB fo=
r instance or smaller).=20

I updated https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_inter=
nals/erasure-code.rst to reflect our discussion.

The first, simplest implementation is likely to be fit to use with RGW an=
d probably too slow to use with RBD. Do you think we should try to optimi=
ze for RBD right now ?=20

Cheers

>=20
> Thanks,
> Paul
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig1C50D5D40BF3F6680EBD6131
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHEDt0ACgkQ8dLMyEl6F22QgQCdG6Z07SKJpiaQeKRASohSJnl+
7dAAoL6mVo3Y/APg93D+8/Dg40XpnI22
=5OY1
-----END PGP SIGNATURE-----

--------------enig1C50D5D40BF3F6680EBD6131--
