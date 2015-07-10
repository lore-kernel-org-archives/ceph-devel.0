From: Loic Dachary <loic@dachary.org>
Subject: Re: Duplicate issues?
Date: Fri, 10 Jul 2015 23:21:25 +0200
Message-ID: <55A03755.6000900@dachary.org>
References: <55A0326C.2090303@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nuTrsPcOrALcuujkB9S3NM5cWf6E75iTk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48254 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932641AbbGJVV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 17:21:28 -0400
In-Reply-To: <55A0326C.2090303@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nuTrsPcOrALcuujkB9S3NM5cWf6E75iTk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For the record, here is the conclusion of the IRC chat: tracker.ceph.com/=
issues/9064#note-18

On 10/07/2015 23:00, Nathan Cutler wrote:
> Hi Loic:
>=20
> Please look at the following two issues that are earmarked for backport=
 to firefly:
>=20
> http://tracker.ceph.com/issues/8674 osd: cache tier: avoid promotion on=
 first read
> http://tracker.ceph.com/issues/9064 RadosModel assertion failure
>=20
> They both seem to be fixed by the same commit, namely:
>=20
> https://github.com/ceph/ceph/commit/0ed3adc1e0a74bf9548d1d956aece11f019=
afee0
>=20
> . . . which would mean that the corresponding backport tracker issues a=
re duplicates?
>=20
> Can you confirm/deny this?
>=20
> Thanks,
> Nathan

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nuTrsPcOrALcuujkB9S3NM5cWf6E75iTk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWgN1UACgkQ8dLMyEl6F20QJACfROyCkR6McMU0PSwefiygwMMy
YrAAoJszhPBJxnArP6DOrE2S2k6pfKIV
=/6ZA
-----END PGP SIGNATURE-----

--nuTrsPcOrALcuujkB9S3NM5cWf6E75iTk--
