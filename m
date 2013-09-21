From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 21 Sep 2013 17:11:33 +0200
Message-ID: <523DB725.2070104@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0F2184CA2610F371A2CE05A2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41108 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3IUPLi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 11:11:38 -0400
In-Reply-To: <523C7CAF.1020101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F2184CA2610F371A2CE05A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

It's probably too soon to be smart about reducing the number of copies, b=
ut you're right : this copy is not necessary. The following pull request =
gets rid of it:

https://github.com/ceph/ceph/pull/615

Cheers

On 20/09/2013 18:49, Loic Dachary wrote:
> Hi,
>=20
> This is a first attempt at avoiding unnecessary copy:
>=20
> https://github.com/dachary/ceph/blob/03445a5926cd073c11cd8693fb110729e4=
0f35fa/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L66
>=20
> I'm not sure how it could be made more readable / terse with bufferlist=
 iterators. Any kind of hint would be welcome :-)
>=20
> Cheers
>=20
> On 20/09/2013 17:36, Sage Weil wrote:
>> On Fri, 20 Sep 2013, Loic Dachary wrote:
>>> Hi Andreas,
>>>
>>> Great work on these benchmarks ! It's definitely an incentive to impr=
ove as much as possible. Could you push / send the scripts and sequence o=
f operations you've used ? I'll reproduce this locally while getting rid =
of the extra copy. It would be useful to capture that into a script that =
can be conveniently run from the teuthology integrations tests to check a=
gainst performance regressions.
>>>
>>> Regarding the 3P implementation, in my opinion it would be very valua=
ble for some people who prefer low CPU consumption. And I'm eager to see =
more than one plugin in the erasure code plugin directory ;-)
>>
>> One way to approach this might be to make a bufferlist 'multi-iterator=
'=20
>> that you give you bufferlist::iterator's and will give you back a pair=
 of=20
>> points and length for each contiguous segment.  This would capture the=
=20
>> annoying iterator details and let the user focus on processing chunks =
that=20
>> are as large as possible.
>>
>> sage
>>
>>
>>  >=20
>>> Cheers
>>>
>>> On 20/09/2013 13:35, Andreas Joachim Peters wrote:
>>>> Hi Loic,=20
>>>>
>>>> I have now some benchmarks on a Xeon 2.27 GHz 4-core with gcc 4.4 (-=
O2) for ENCODING based on the CEPH Jerasure port.
>>>> I measured for objects from 128k to 512 MB with random contents (if =
you encode 1 GB objects you see slow downs due to caching inefficiencies =
=2E..), otherwise results are stable for the given object sizes.
>>>>
>>>> I quote only the benchmark for ErasureCodeJerasureReedSolomonRAID6 (=
3,2) , the other are significantly slower (2-3x slower) and my 3P(3,2,1) =
implementation providing the same redundancy level like RS-Raid6[3,2] (do=
uble disk failure) but using more space (66% vs 100% overhead).
>>>>
>>>> The effect of out.c_str() is significant ( contributes with factor 2=
 slow-down for the best jerasure algorithm for [3,2] ).
>>>>
>>>> Averaged results for Objects Size 4MB:
>>>>
>>>> 1) Erasure CRS [3,2] - 2.6 ms buffer preparation (out.c_str()) - 2.4=
 ms encoding =3D> ~780 MB/s
>>>> 2) 3P [3,2,1] - 0,005 ms buffer preparation (3P adjusts the padding =
in the algorithm) - 0.87ms encoding =3D> ~4.4 GB/s
>>>>
>>>> I think it pays off to avoid the copy in the encoding if it does not=
 matter for the buffer handling upstream and pad only the last chunk.
>>>>
>>>> Last thing I tested is how performances scales with number of cores =
running 4 tests in parallel:
>>>>
>>>> Jerasure (3,2) limits at ~2,0 GB/s for a 4-core CPU (Xeon 2.27 GHz).=

>>>> 3P(3,2,1) limits ~8 GB/s for a 4-core CPU (Xeon 2.27 GHz).
>>>>
>>>> I also implemented the decoding for 3P, but didn't test yet all reco=
nstruction cases. There is probably room for improvements using AVX suppo=
rt for XOR operations in both implementations.
>>>>
>>>> Before I invest more time, do think it is useful to have this fast 3=
P algorithm for double disk failures with 100% space overhead? Because I =
believe that people will always optimize for space and would rather use s=
omething like (10,2) even if the performance degrades and CPU consumption=
 goes up?!? Let me know, no problem in any case!
>>>>
>>>> Finally I tested some combinations for ErasureCodeJerasureReedSolomo=
nRAID6:
>>>>
>>>> (3,2) (4,2) (6,2) (8,2) (10,2) they all run around 780-800 MB/s
>>>>
>>>> Cheers Andreas.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>> --=20
>>> Lo?c Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people do =
nothing.
>>>
>>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig0F2184CA2610F371A2CE05A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI9tyUACgkQ8dLMyEl6F21+PQCgvRb4G8QJifKvWTy5DLWv7YZk
6kcAoJkTnAIbNO3xvlT3WVEHj1IA7Hgk
=ZBVN
-----END PGP SIGNATURE-----

--------------enig0F2184CA2610F371A2CE05A2--
