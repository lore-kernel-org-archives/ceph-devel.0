From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] crush choose firstn vs. indep
Date: Tue, 14 Jan 2014 09:33:50 +0100
Message-ID: <52D4F66E.3060301@dachary.org>
References: <24E144B8C0207547AD09C467A8259F75592E55C0@lisa.maurer-it.com> <52D32729.40400@dachary.org> <CADTt812pZoObC+LWRGPSDFudpFSW4KR9B+z5=cMFsJLQoXCGWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KtPFDHiDsPOAJqwh0VSAwmXTqn1WLdNOf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42796 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaANIdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 03:33:54 -0500
In-Reply-To: <CADTt812pZoObC+LWRGPSDFudpFSW4KR9B+z5=cMFsJLQoXCGWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ZHOU Yuan <dunk007@gmail.com>
Cc: Dietmar Maurer <dietmar@proxmox.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KtPFDHiDsPOAJqwh0VSAwmXTqn1WLdNOf
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 14/01/2014 07:49, ZHOU Yuan wrote:> Hi Loic, thanks for the education!=

>=20
> I=92m also trying to understand the new =91indep=92 mode. Is this new m=
ode designed for Ceph-EC only? It seems that all of the data in 3-copy sy=
stem are equivalent and this new algorithm should also work?
>=20

In the best case scenario, using indep instead of firstn on replicated po=
ols won't make a difference. However, if the crush mapper does not find t=
he required amount of items, firstn will give ( for instance ) [1,2,4] in=
stead of [1,2,3,4] and the replicated pool code will gracefully handle th=
is. If using indep the result will be [1,2,CRUSH_ITEM_NONE,4] and will pr=
obably assert somewhere.

Here is an example from the test suite run when you make check :
https://github.com/ceph/ceph/blob/master/src/test/cli/crushtool/bad-mappi=
ngs.t
where 2147483647 =3D=3D CRUSH_ITEM_NONE

I don't know of an other reason preventing the use of indep for replicate=
d pools.

Cheers

>=20
> Sincerely, Yuan
>=20
>=20
> On Mon, Jan 13, 2014 at 7:37 AM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 12/01/2014 15:55, Dietmar Maurer wrote:
>     > From the docs:
>     >
>     >
>     >
>     > step [choose|chooseleaf] [firstn|indep] <N> <bucket-type>
>     >
>     >
>     >
>     > What exactly is the difference between =91firstn=92 and =91indep=92=
?
>     >
>     Hi,
>=20
>     For Ceph releases up to Emperor[1], firstn is used and I'm not awar=
e of a use case requiring indep. As part of the effort to implement erasu=
re coded pools, firstn[2] and indep[3] were separated in two functions. T=
he firstn method is best suited for replicated pools. The indep method tr=
ies to minimize the position changes in case an OSD becomes unavailable. =
For instance, if indep finds
>=20
>       [1,2,3,4]
>=20
>     and after a while 3 become unavailable, it is very likely to replac=
e it with
>=20
>       [1,2,5,4]
>=20
>     It matters to erasure coded pools because
>=20
>       [4,5,2,1]
>=20
>     (i.e. the same OSDs but in different positions), implies more I/O. =
Another difference is that in the case of a mapping failure (i.e. unable =
to find the required number of OSDs), firstn will return a short list ( f=
or instance [1,2,3] when 4 are required ) and indep will return a list wi=
th a placeholder at the missing position ( for instance [1,2,CRUSH_ITEM_N=
ONE,4] ).
>=20
>     Cheers
>=20
>     [1] implementation in releases up to Emperor https://github.com/cep=
h/ceph/blob/v0.72/src/crush/mapper.c#L295
>     [2] firstn https://github.com/ceph/ceph/blob/v0.74/src/crush/mapper=
=2Ec#L295
>     [3] indep https://github.com/ceph/ceph/blob/v0.74/src/crush/mapper.=
c#L459
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
>     _______________________________________________
>     ceph-users mailing list
>     ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KtPFDHiDsPOAJqwh0VSAwmXTqn1WLdNOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLU9m8ACgkQ8dLMyEl6F23sBQCgqQkR2o2GLYMnM8iJaAoEL6gW
L+8An063qytip4LPBlbFIZB/bltvnM6/
=hTC0
-----END PGP SIGNATURE-----

--KtPFDHiDsPOAJqwh0VSAwmXTqn1WLdNOf--
