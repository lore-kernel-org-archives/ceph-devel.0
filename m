From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sun, 16 Jun 2013 23:31:29 +0200
Message-ID: <51BE2EB1.2020807@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA2A3C90E76481DCCA04A8C21"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:59476 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3FPVbd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Jun 2013 17:31:33 -0400
In-Reply-To: <loom.20130616T214215-201@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Beno=EEt_Parrein?= <benoit.parrein@polytech.univ-nantes.fr>
Cc: ceph-devel@vger.kernel.org, "James S. Plank" <plank@cs.utk.edu>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2A3C90E76481DCCA04A8C21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Beno=EEt,

=46rom the ( na=EFve ) point of view of engineering, performances are imp=
ortant. The recent works of James Plank ( cc'ed ) greatly improved them
 and I'm looking forward to the next version of jerasure ( http://web.eec=
s.utk.edu/~plank/plank/papers/CS-08-627.html ). Rozofs Mojette Transform =
implementation ( https://github.com/rozofs/rozofs/blob/master/rozofs/comm=
on/transform.h & https://github.com/rozofs/rozofs/blob/master/rozofs/comm=
on/transform.cc ) does not seem to make use of SIMD. Is it because the pe=
rformances are good enough to not require them ?

Cheers

On 06/16/2013 09:51 PM, Beno=EEt Parrein wrote:
> Paul Von-Stamwitz <PVonStamwitz <at> us.fujitsu.com> writes:
>=20
> Hi Paul,=20
>=20
>>
>> Loic, I know nothing about Mojette Transforms. From what little I glea=
ned,=20
> it might be good for repair
>> (needing only a subset of chunks within a range to recalculate a missi=
ng=20
> chunk) but I'm worried about the
>> storage efficiency. RozoFS claims 1.5x. I'd like to do better than tha=
t.
>>
>> All the best,
>> Paul
>>
>=20
> If you want to do better than that you will probably lose in availabili=
ty.=20
> 1.5x give the same availability than 3 replicats and that for any kind =
of=20
> erasure coding.
> FYI, Mojette transform has no constraint in terms of Galois fields. It =
is the=20
> big advantage to use discrete geometry rather than algebra.
>=20
> best regards,
> bp
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigA2A3C90E76481DCCA04A8C21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlG+LrEACgkQ8dLMyEl6F20JbACdErjMvLzvIr4tLUcajL22FqtI
1J0AnRDAHpU6DE8wcHoEMzFqZJTAiQ7j
=K1I4
-----END PGP SIGNATURE-----

--------------enigA2A3C90E76481DCCA04A8C21--
