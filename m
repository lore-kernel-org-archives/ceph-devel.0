From: Loic Dachary <loic@dachary.org>
Subject: Re: LRC ec pool behaviour
Date: Thu, 28 May 2015 22:54:54 +0200
Message-ID: <5567809E.3010103@dachary.org>
References: <CAMxOGo2Te_jSVMEp6FeE9VdbjFi-WaY3Ud498V3g_QEtPq1hPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tEQNWeand80m2wEaAX9h7rulbTjSiwalX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52692 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754006AbbE1Uy5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 16:54:57 -0400
In-Reply-To: <CAMxOGo2Te_jSVMEp6FeE9VdbjFi-WaY3Ud498V3g_QEtPq1hPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shylesh kumar <shylesh.mohan@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tEQNWeand80m2wEaAX9h7rulbTjSiwalX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Shylesh,

On 28/05/2015 21:25, shylesh kumar wrote:
> Hi,
>=20
> I created a LRC ec pool with the configuration
>=20
> # ceph osd erasure-code-profile get  mylrc
> directory=3D/usr/lib64/ceph/erasure-code
> k=3D4
> l=3D3
> m=3D2
> plugin=3Dlrc
> ruleset-failure-domain=3Dosd
>=20
>=20
>=20
>=20
> One of the pg mapping looks like
> ----------------
> 11.4    579     0       0       0       0       11204014080     6      =
 6       active+clean    2015-05-28 10:14:40.937902      6771'15221      =
6771:16093      [0,1,9,2,8,6,7,4]       0       [0,1,9,2,8,6,7,4]       0=
       6746'2718       2015-05-28 03:07:01.864631      0'0     2015-05-21=
 03:37:24.438653
>=20
>=20
> I am appending data  to an object in the above pg with the follwoing sn=
ippet using librados
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   {
>                 char hello[4096] =3D {0,};
>                 (void) memcpy (hello, "hello world", 11);
>                 librados::bufferlist bl;
>                 bl.append(hello, 4096);
>=20
>                 int i=3D5000;
>                 while (i > 0)    {
>                 ret =3D io_ctx.append("another2", bl, 4096);
>                 if (ret < 0) {
>                         std::cerr << "Couldn't write object! error " <<=
 ret << std::endl;
>                 //        exit(EXIT_FAILURE);
>                 } else {
>                         std::cout << "Wrote new object 'newobj' " << st=
d::endl;
>                 }
>                 i--;
>                 }
>         }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> I could see that stripe_0 is on osd.0 , till now I wrote data nearly 7M=
B , all the data is going to osd.0 and stripe_1 is on osd.1 with just a t=
runcated file with no data ..osd.9 has global parity etc..

That does not seem right.=20

> I was wondering is there any chunk size limit in LRC so that it will no=
t write to other stripes till it fills upto the chunk size in one stripe.=


To assert if you have discovered a problem, I wrote a test case that look=
 similar to what you describe. You can repeat it with https://github.com/=
ceph/ceph/pull/4797 as follows:

  git clone -b wip-11665-erasure-code-lrc https://github.com/dachary/ceph=
 ceph
  cd ceph
  ./run-make-check.sh

and repeat it after that with

  cd ceph/src
  test/osd/osd-scrub-repair.sh TEST_corrupt_and_repair_lrc

I would be happy to repeat the problem you had if you provide me with spe=
cific instructions to do so.=20

Cheers

>=20
>=20
>=20
> --=20
> Thanks=20
> Shylesh
> =20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tEQNWeand80m2wEaAX9h7rulbTjSiwalX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVngJ4ACgkQ8dLMyEl6F20OagCgp+0kLUyJi/KCuJDSrJneaoke
QZ0AoIFwFIydohDT7wU01cLQJXICJg4G
=d1Po
-----END PGP SIGNATURE-----

--tEQNWeand80m2wEaAX9h7rulbTjSiwalX--
