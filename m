From: Loic Dachary <loic@dachary.org>
Subject: Re: With ceph-detect-init changes, make install fails
Date: Wed, 13 May 2015 12:51:30 +0200
Message-ID: <55532CB2.8060201@dachary.org>
References: <CAFkUHxdwK4YkoJ+B1Vkcn5006wXpj5nKDu5tR1w16Q_1mBntBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ndJ8v8HmXGsR4ugEdlphvrqrr93ti0rCU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34389 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933947AbbEMKvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 06:51:40 -0400
In-Reply-To: <CAFkUHxdwK4YkoJ+B1Vkcn5006wXpj5nKDu5tR1w16Q_1mBntBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ndJ8v8HmXGsR4ugEdlphvrqrr93ti0rCU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

http://tracker.ceph.com/issues/11598 should be fixed with https://github.=
com/ceph/ceph/pull/4663. Would you have time to review this fix ?

Thanks !

On 12/05/2015 20:26, kernel neophyte wrote:
> Hi,
>=20
> With the recent ceph-detect-init changes, make install now fails (
> make succeeds hence this is not detected by build bots )
>=20
> Error:
>=20
> cd ceph-detect-init ; \
>=20
> if lsb_release -si | grep --quiet 'Ubuntu\|Debian\|Devuan' ; then \
>=20
> options=3D--install-layout=3Ddeb ; \
>=20
> else \
>=20
> options=3D--prefix=3D/usr ; \
>=20
> fi ; \
>=20
> python setup.py install --root=3D $options
>=20
> running install
>=20
> Checking .pth file support in usr/lib/python2.7/dist-packages/
>=20
> /usr/bin/python -E -c pass
>=20
> TEST FAILED: usr/lib/python2.7/dist-packages/ does NOT support .pth fil=
es
>=20
> error: bad install directory or PYTHONPATH
>=20
>=20
> You are attempting to install a package to a directory that is not
>=20
> on PYTHONPATH and which Python does not read ".pth" files from.  The
>=20
> installation directory you specified (via --install-dir, --prefix, or
>=20
> the distutils default setting) was:
>=20
>=20
>     usr/lib/python2.7/dist-packages/
>=20
>=20
> and your PYTHONPATH environment variable currently contains:
>=20
>=20
>     '../src/pybind'
>=20
>=20
> Here are some of your options for correcting the problem:
>=20
>=20
> * You can choose a different installation directory, i.e., one that is
>=20
>   on PYTHONPATH or supports .pth files
>=20
>=20
> * You can add the installation directory to the PYTHONPATH environment
>=20
>   variable.  (It must then also be on PYTHONPATH whenever you run
>=20
>   Python and want to use the package(s) you are installing.)
>=20
>=20
> * You can set up the installation directory to support ".pth" files by
>=20
>   using one of the approaches described here:
>=20
>=20
>   https://pythonhosted.org/setuptools/easy_install.html#custom-installa=
tion-locations
>=20
>=20
> -Neo
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ndJ8v8HmXGsR4ugEdlphvrqrr93ti0rCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVTLLMACgkQ8dLMyEl6F23zswCeKwzgbEgzaUuwWSy6bJ+KpYSI
bv4AoLfR+pbWPSAKGAbM0ZwiyIQDaWqq
=Qig2
-----END PGP SIGNATURE-----

--ndJ8v8HmXGsR4ugEdlphvrqrr93ti0rCU--
