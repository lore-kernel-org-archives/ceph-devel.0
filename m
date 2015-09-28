From: Loic Dachary <loic@dachary.org>
Subject: Re: [Hammer Backports] Should rest-bench be removed on hammer ?
Date: Mon, 28 Sep 2015 13:00:59 +0200
Message-ID: <56091DEB.1070105@dachary.org>
References: <CAP3mxSymbxxh8k3==03EsR51jmAO6jyY_RZrUsKOyo=aN5tibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5H1Le5ei5prAh817De96qpfTLdoh6dAkP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33874 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932230AbbI1LBK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 07:01:10 -0400
In-Reply-To: <CAP3mxSymbxxh8k3==03EsR51jmAO6jyY_RZrUsKOyo=aN5tibw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5H1Le5ei5prAh817De96qpfTLdoh6dAkP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/09/2015 12:19, Abhishek Varshney wrote:
> Hi,
>=20
> The rest-bench tool has been removed in master through PR #5428
> (https://github.com/ceph/ceph/pull/5428). The backport PR #5812
> (https://github.com/ceph/ceph/pull/5812) is currently causing failures
> on the hammer-backports integration branch. These failures can be
> resolved by either backporting PR #5428 or by adding a hammer-specific
> commit to PR #5812.
>=20
> How should we proceed here?

It looks like rest-bench support was removed because cosbench can replace=
 it. The string cosbench or rest.bench does not show in ceph-qa-suite / c=
eph master or hammer, which probably means tests using rest-bench are out=
side of the scope of the ceph project. Deprecating rest-bench from hammer=
 by backporting https://github.com/ceph/ceph/pull/5428 seems sensible.

Cheers

>=20
> Thanks
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5H1Le5ei5prAh817De96qpfTLdoh6dAkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYJHesACgkQ8dLMyEl6F21NMwCgkKa9qPcOyYVGeE6kILKMRBSy
HMkAn0Xx7bZU+1Owj08DILp2AOY1E5Rv
=JkGF
-----END PGP SIGNATURE-----

--5H1Le5ei5prAh817De96qpfTLdoh6dAkP--
