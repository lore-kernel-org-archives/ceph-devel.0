From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 20 Sep 2013 14:33:59 +0200
Message-ID: <523C40B7.5060902@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB4CBFDF16E01AE9455F1EF0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:40174 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3ITMeC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 08:34:02 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB4CBFDF16E01AE9455F1EF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Great work on these benchmarks ! It's definitely an incentive to improve =
as much as possible. Could you push / send the scripts and sequence of op=
erations you've used ? I'll reproduce this locally while getting rid of t=
he extra copy. It would be useful to capture that into a script that can =
be conveniently run from the teuthology integrations tests to check again=
st performance regressions.

Regarding the 3P implementation, in my opinion it would be very valuable =
for some people who prefer low CPU consumption. And I'm eager to see more=
 than one plugin in the erasure code plugin directory ;-)

Cheers

On 20/09/2013 13:35, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
> I have now some benchmarks on a Xeon 2.27 GHz 4-core with gcc 4.4 (-O2)=
 for ENCODING based on the CEPH Jerasure port.
> I measured for objects from 128k to 512 MB with random contents (if you=
 encode 1 GB objects you see slow downs due to caching inefficiencies ...=
), otherwise results are stable for the given object sizes.
>=20
> I quote only the benchmark for ErasureCodeJerasureReedSolomonRAID6 (3,2=
) , the other are significantly slower (2-3x slower) and my 3P(3,2,1) imp=
lementation providing the same redundancy level like RS-Raid6[3,2] (doubl=
e disk failure) but using more space (66% vs 100% overhead).
>=20
> The effect of out.c_str() is significant ( contributes with factor 2 sl=
ow-down for the best jerasure algorithm for [3,2] ).
>=20
> Averaged results for Objects Size 4MB:
>=20
> 1) Erasure CRS [3,2] - 2.6 ms buffer preparation (out.c_str()) - 2.4 ms=
 encoding =3D> ~780 MB/s
> 2) 3P [3,2,1] - 0,005 ms buffer preparation (3P adjusts the padding in =
the algorithm) - 0.87ms encoding =3D> ~4.4 GB/s
>=20
> I think it pays off to avoid the copy in the encoding if it does not ma=
tter for the buffer handling upstream and pad only the last chunk.
>=20
> Last thing I tested is how performances scales with number of cores run=
ning 4 tests in parallel:
>=20
> Jerasure (3,2) limits at ~2,0 GB/s for a 4-core CPU (Xeon 2.27 GHz).
> 3P(3,2,1) limits ~8 GB/s for a 4-core CPU (Xeon 2.27 GHz).
>=20
> I also implemented the decoding for 3P, but didn't test yet all reconst=
ruction cases. There is probably room for improvements using AVX support =
for XOR operations in both implementations.
>=20
> Before I invest more time, do think it is useful to have this fast 3P a=
lgorithm for double disk failures with 100% space overhead? Because I bel=
ieve that people will always optimize for space and would rather use some=
thing like (10,2) even if the performance degrades and CPU consumption go=
es up?!? Let me know, no problem in any case!
>=20
> Finally I tested some combinations for ErasureCodeJerasureReedSolomonRA=
ID6:
>=20
> (3,2) (4,2) (6,2) (8,2) (10,2) they all run around 780-800 MB/s
>=20
> Cheers Andreas.
>=20
>=20
>=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigAB4CBFDF16E01AE9455F1EF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI8QLcACgkQ8dLMyEl6F20x9QCfeuEz4nceBWHHnQUmZse/Ibjg
GOQAoIzrHMzA2YNOSCVuh0wK2IVdIUOX
=QZgb
-----END PGP SIGNATURE-----

--------------enigAB4CBFDF16E01AE9455F1EF0--
