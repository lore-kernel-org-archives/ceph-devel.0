From: Loic Dachary <loic@dachary.org>
Subject: Re: Cehp - tip - build break ?
Date: Sun, 05 Apr 2015 12:07:48 +0200
Message-ID: <55210974.2010009@dachary.org>
References: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KAb4i3dpVD3aXXn76hKMJSQSNveAm4RhB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41835 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751211AbbDEKHv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Apr 2015 06:07:51 -0400
In-Reply-To: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KAb4i3dpVD3aXXn76hKMJSQSNveAm4RhB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

My guess is that it's because the gmock directory has been replaced by a =
gmock submodule and git pull won't be enough to do the right thing. The s=
implest workaround is to git clone a fresh copy. Or you can try ./autogen=
=2Esh which should also do what's necessary.

Cheers

On 05/04/2015 07:07, kernel neophyte wrote:
> Hi,
>=20
> I am seeing build break in ceph master.
>=20
> make[3]: *** No rule to make target
> `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.
> Stop.
>=20
> make[3]: *** Waiting for unfinished jobs....
>=20
>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
>=20
>=20
> Am I missing anything obvious ?
>=20
>=20
> -Neo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--KAb4i3dpVD3aXXn76hKMJSQSNveAm4RhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUhCXUACgkQ8dLMyEl6F23XkgCePjFnpu9oUBS2suanJsAY1b1J
DoIAmwQENhmQrFhhl+0PAkuOv4kOMEak
=Cs6L
-----END PGP SIGNATURE-----

--KAb4i3dpVD3aXXn76hKMJSQSNveAm4RhB--
