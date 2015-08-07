From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure packaging and Ceph
Date: Fri, 07 Aug 2015 21:27:43 +0200
Message-ID: <55C506AF.4080309@dachary.org>
References: <55C4EA1C.3080601@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1e1WaDrevO7JlmuoN2Wb0Mj4hckXB15IQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35038 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945960AbbHGT1r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 15:27:47 -0400
In-Reply-To: <55C4EA1C.3080601@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1e1WaDrevO7JlmuoN2Wb0Mj4hckXB15IQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

On 07/08/2015 19:25, Ken Dreyer wrote:
> Hi Loic,
>=20
> I was looking through Ceph's bundled libraries recently and I was
> wondering why Ceph bundles its own copy of jerasure.
>=20
> Could you give some background on that? Why don't we link to an separat=
e
> system package?

Mainly because there is no proper non regression testing of the packages =
found in the distributions. It is absolutely critical for Ceph to ensure =
there is no regression because it would mean data loss. The packagers do =
not have that concern in mind right now, nor do they have the infrastruct=
ure to run non regression tests, to the best of my knowledge.

Even if they had non regression tests, whenever a new package is publishe=
d, we would need to run Ceph integration tests before it lands in the dis=
tribution repositories to ensure that everything is fine from the Ceph pe=
rspective. The recent work with teuthology and OpenStack simplified this =
quite a lot and anyone can run teuthology now. However the level of coord=
ination it would require between the jerasure packager and the ceph packa=
ger is far from what is going on currently.

I offered to package jerasure for Debian to solve that problem in the Deb=
ian / Ubuntu realm. I thought a first step to decouple ceph from jerasure=
 could be that I care for jerasure because I have access to the test infr=
astructure and I understand what Ceph needs. And I could gradually make i=
t possible for any packager to do the same, somehow (I have no idea how t=
o do that, honestly). Unfortunately the person responsible for packaging =
jerasure did not respond favorably to my offer. Nor does he plan to imple=
ment integration or non regression tests.

Hopefully that will change in the future, but for now I think bundling je=
rasure with Ceph is the best way to preserve the data of our users.

Cheers

>=20
> - Ken
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1e1WaDrevO7JlmuoN2Wb0Mj4hckXB15IQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXFBq8ACgkQ8dLMyEl6F23IEgCgrUUic4DfPeJKOVJkGoRqIkKE
OBsAoJIKaM8Z6/VAc3L7xu/Xqn5FpkuB
=eZdU
-----END PGP SIGNATURE-----

--1e1WaDrevO7JlmuoN2Wb0Mj4hckXB15IQ--
