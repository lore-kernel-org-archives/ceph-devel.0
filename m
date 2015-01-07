From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Wed, 07 Jan 2015 23:28:10 +0100
Message-ID: <54ADB2FA.9030204@dachary.org>
References: <54AD3C8B.4030705@dachary.org> <CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="egVFUSck4IhX5TeipgcE19LcfdLRiMC2r"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35069 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752978AbbAGW2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 17:28:13 -0500
In-Reply-To: <CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--egVFUSck4IhX5TeipgcE19LcfdLRiMC2r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/01/2015 23:20, Tamil Muthamizhan wrote:
> hi Loic,
>=20
> we have a suite to perform smoke tests for rados/rbd/rgw.
> maybe you can try that to make sure things work.

Are these the suites I should try:

https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados
https://github.com/ceph/ceph-qa-suite/tree/master/suites/rbd
https://github.com/ceph/ceph-qa-suite/tree/master/suites/rgw

any specific settings or just all of three without restrictions (i.e. all=
 os versions etc.)

Cheers

>=20
> once it looks good, we can have them scheduled to run using teuthology =
for a more elaborate run.
>=20
> Thanks,
> Tamil
>=20
>=20
> On Wed, Jan 7, 2015 at 6:02 AM, Loic Dachary <loic@dachary.org <mailto:=
loic@dachary.org>> wrote:
>=20
>     Hi Tamil,
>=20
>     I've merged / integrated the giant backports found at
>=20
>     https://github.com/ceph/ceph/pull/3186
>     https://github.com/ceph/ceph/pull/3178
>     https://github.com/ceph/ceph/pull/2954
>     https://github.com/ceph/ceph/pull/3191
>     https://github.com/ceph/ceph/pull/3168
>     https://github.com/ceph/ceph/pull/3289
>=20
>     into
>=20
>     http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710f46=
9454ab3f964bfa7c9d2
>=20
>     and successfully ran make check on it
>=20
>     http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backports=

>=20
>     If I'm not mistaken the next step would be to run teuthology. If I'=
m to do it, would you be so kind as to let me know which suites are most =
relevant ? If someone else will take care of it, should I push the integr=
ation branch somewhere ?
>=20
>     Cheers
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20
> --=20
> Regards,
> Tamil

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--egVFUSck4IhX5TeipgcE19LcfdLRiMC2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlStsvoACgkQ8dLMyEl6F21AkgCfU2mklZxQrArNPgHypp/mErlU
KHcAn1/R9srt0s1IVxmx1PFeoKL3NeSz
=LaoI
-----END PGP SIGNATURE-----

--egVFUSck4IhX5TeipgcE19LcfdLRiMC2r--
