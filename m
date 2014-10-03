From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure: galois_uninit_default_field
Date: Fri, 03 Oct 2014 20:52:50 +0200
Message-ID: <542EF082.7050403@dachary.org>
References: <54294C6C.5090307@dachary.org> <CA+AFVBhtJfpemsDZ8D+pZ=fYk7QUJ_ik71Y6HjbGD-ZH_3pLMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JP8oSUF5k76jsiNV9i0up0wCu9qPskRDR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37538 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751573AbaJCSw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Oct 2014 14:52:57 -0400
In-Reply-To: <CA+AFVBhtJfpemsDZ8D+pZ=fYk7QUJ_ik71Y6HjbGD-ZH_3pLMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JP8oSUF5k76jsiNV9i0up0wCu9qPskRDR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Thanks for your review ! I've addressed your comments, rebased and repush=
ed.

Cheers

On 29/09/2014 20:08, Kevin Greenan wrote:
> Hey Loic,
>=20
> Thanks!  I'll review today or tomorrow.
>=20
> -kevin
>=20
> On Mon, Sep 29, 2014 at 5:11 AM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi,
>=20
>     The following patch helps maintain the caller program valgrind clea=
n:
>=20
>         https://bitbucket.org/jimplank/jerasure/pull-request/24/define-=
galois_uninit_default_field/diff
>=20
>     Please let me know if you would like that done differently and I'll=
 work on it.
>=20
>     Cheers
>=20
>     Reference: http://tracker.ceph.com/issues/8741
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--JP8oSUF5k76jsiNV9i0up0wCu9qPskRDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQu8IIACgkQ8dLMyEl6F20ccQCfU4pglS2+USKDDsuMnXWSheO/
bD4AnRefRexw1fXNHkkFeyBOQJ5jE7rl
=w26I
-----END PGP SIGNATURE-----

--JP8oSUF5k76jsiNV9i0up0wCu9qPskRDR--
