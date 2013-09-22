From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sun, 22 Sep 2013 11:41:52 +0200
Message-ID: <523EBB60.4000702@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B9B65317D7670C54B22E3C9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41646 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3IVJlz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 05:41:55 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B9B65317D7670C54B22E3C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

That sounds reasonable. Would you be so kind as to send a patch with your=
 changes ? I'll rework it into something that fits the test infrastructur=
e of Ceph.

Cheers

On 22/09/2013 09:26, Andreas Joachim Peters wrote:
> Hi Loic,=20
> I run a benchmark with the changed code tomorrow ... I actually had to =
insert some of my realtime benchmark macro's into your Jerasure code to s=
ee the different time fractions between buffer preparation & encoding ste=
p, but for you QA suite it is probably enough to get a total value after =
your fix. I will send you a program sampling the performance at different=
 buffer sizes and encoding types.
>=20
> I changed my code to use vector operations (128-bit XOR's) and it gives=
 another 10% gain. I also want to try out if it makes sense to do the CRC=
32C computation in-line in the encoding step and compare it with the two =
step procedure first encoding all blocks, then CRC32C on all blocks.
>=20
> Cheers Andreas.
>=20
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 21 September 2013 17:11
> To: Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>=20
> Hi Andreas,
>=20
> It's probably too soon to be smart about reducing the number of copies,=
 but you're right : this copy is not necessary. The following pull reques=
t gets rid of it:
>=20
> https://github.com/ceph/ceph/pull/615
>=20
> Cheers
>=20
> On 20/09/2013 18:49, Loic Dachary wrote:
>> Hi,
>>
>> This is a first attempt at avoiding unnecessary copy:
>>
>> https://github.com/dachary/ceph/blob/03445a5926cd073c11cd8693fb110729e=
40f35fa/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L66
>>
>> I'm not sure how it could be made more readable / terse with bufferlis=
t iterators. Any kind of hint would be welcome :-)
>>
>> Cheers
>>
>> On 20/09/2013 17:36, Sage Weil wrote:
>>> On Fri, 20 Sep 2013, Loic Dachary wrote:
>>>> Hi Andreas,
>>>>
>>>> Great work on these benchmarks ! It's definitely an incentive to imp=
rove as much as possible. Could you push / send the scripts and sequence =
of operations you've used ? I'll reproduce this locally while getting rid=
 of the extra copy. It would be useful to capture that into a script that=
 can be conveniently run from the teuthology integrations tests to check =
against performance regressions.
>>>>
>>>> Regarding the 3P implementation, in my opinion it would be very valu=
able for some people who prefer low CPU consumption. And I'm eager to see=
 more than one plugin in the erasure code plugin directory ;-)
>>>
>>> One way to approach this might be to make a bufferlist 'multi-iterato=
r'
>>> that you give you bufferlist::iterator's and will give you back a pai=
r of
>>> points and length for each contiguous segment.  This would capture th=
e
>>> annoying iterator details and let the user focus on processing chunks=
 that
>>> are as large as possible.
>>>
>>> sage
>>>
>>>
>>>  >
>>>> Cheers
>>>>
>>>> On 20/09/2013 13:35, Andreas Joachim Peters wrote:
>>>>> Hi Loic,
>>>>>
>>>>> I have now some benchmarks on a Xeon 2.27 GHz 4-core with gcc 4.4 (=
-O2) for ENCODING based on the CEPH Jerasure port.
>>>>> I measured for objects from 128k to 512 MB with random contents (if=
 you encode 1 GB objects you see slow downs due to caching inefficiencies=
 ...), otherwise results are stable for the given object sizes.
>>>>>
>>>>> I quote only the benchmark for ErasureCodeJerasureReedSolomonRAID6 =
(3,2) , the other are significantly slower (2-3x slower) and my 3P(3,2,1)=
 implementation providing the same redundancy level like RS-Raid6[3,2] (d=
ouble disk failure) but using more space (66% vs 100% overhead).
>>>>>
>>>>> The effect of out.c_str() is significant ( contributes with factor =
2 slow-down for the best jerasure algorithm for [3,2] ).
>>>>>
>>>>> Averaged results for Objects Size 4MB:
>>>>>
>>>>> 1) Erasure CRS [3,2] - 2.6 ms buffer preparation (out.c_str()) - 2.=
4 ms encoding =3D> ~780 MB/s
>>>>> 2) 3P [3,2,1] - 0,005 ms buffer preparation (3P adjusts the padding=
 in the algorithm) - 0.87ms encoding =3D> ~4.4 GB/s
>>>>>
>>>>> I think it pays off to avoid the copy in the encoding if it does no=
t matter for the buffer handling upstream and pad only the last chunk.
>>>>>
>>>>> Last thing I tested is how performances scales with number of cores=
 running 4 tests in parallel:
>>>>>
>>>>> Jerasure (3,2) limits at ~2,0 GB/s for a 4-core CPU (Xeon 2.27 GHz)=
=2E
>>>>> 3P(3,2,1) limits ~8 GB/s for a 4-core CPU (Xeon 2.27 GHz).
>>>>>
>>>>> I also implemented the decoding for 3P, but didn't test yet all rec=
onstruction cases. There is probably room for improvements using AVX supp=
ort for XOR operations in both implementations.
>>>>>
>>>>> Before I invest more time, do think it is useful to have this fast =
3P algorithm for double disk failures with 100% space overhead? Because I=
 believe that people will always optimize for space and would rather use =
something like (10,2) even if the performance degrades and CPU consumptio=
n goes up?!? Let me know, no problem in any case!
>>>>>
>>>>> Finally I tested some combinations for ErasureCodeJerasureReedSolom=
onRAID6:
>>>>>
>>>>> (3,2) (4,2) (6,2) (8,2) (10,2) they all run around 780-800 MB/s
>>>>>
>>>>> Cheers Andreas.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>>>
>>>>
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do no=
thing.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig2B9B65317D7670C54B22E3C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI+u2AACgkQ8dLMyEl6F23uNgCffrKhSznRasnaczWPTZiErt4j
SsIAn2yxM5xlnflClfL0ImViS0kbOC81
=m/La
-----END PGP SIGNATURE-----

--------------enig2B9B65317D7670C54B22E3C9--
