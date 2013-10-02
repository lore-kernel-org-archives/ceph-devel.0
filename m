From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 02 Oct 2013 12:04:01 +0200
Message-ID: <524BEF91.2050608@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch> <523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch> <5242FDDC.3060504@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch> <52433014.3030109@dachary.org> <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>,<5244887A.80503@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52741F6@PLOXCHG03.cern.ch>,<52455279.1020702@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5278DA2@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="txggQWgQ1XKxGFGxOMfkT0e00F2kBaMiT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:51503 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab3JBKEE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 06:04:04 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A5278DA2@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txggQWgQ1XKxGFGxOMfkT0e00F2kBaMiT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Cool :-) Could you create a pull request so I can review it ?

Cheers

On 02/10/2013 01:00, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
> here is the patch implementing the basic pyramid code adding local pari=
ty to erasure encoding. I tried to keep it 100% identical to the behaviou=
r of the original version besides I changed the alignment to 128-bit word=
s. Atleast your unit tests works ;-)
>=20
> https://github.com/apeters1971/ceph/commit/b2de7af1a49dc98940d5685eab00=
a339bf81a0e5
>=20
> in src:=20
>=20
> make unittest_erasure_code_pyramid_jerasure
>=20
> ./unittest_erasure_code_pyramid_jerasure --gtest_filter=3D*.* --log-to-=
stderr=3Dtrue --object-size=3D64
>=20
> It tests (8,2,2)
>=20
> [ -TIMING- ] technique=3Dcauchy_good      [           encode ] speed=3D=
1.840 [GB/s] latency=3D34.791 ms
> [ -TIMING- ] technique=3Dcauchy_good      [        encode-lp ] speed=3D=
1.305 [GB/s] latency=3D49.057 ms
> [ -TIMING- ] technique=3Dcauchy_good      [      encode-lp-3 ] speed=3D=
1.307 [GB/s] latency=3D48.956 ms
> [ -TIMING- ] technique=3Dcauchy_good      [ encode-lp-crc32c ] speed=3D=
1.036 [GB/s] latency=3D61.752 ms
> [ -TIMING- ] technique=3Dcauchy_good      [             reco ] speed=3D=
1.780 [GB/s] latency=3D35.959 ms
> [ -TIMING- ] technique=3Dcauchy_good      [          reco-lp ] speed=3D=
4.348 [GB/s] latency=3D14.720 ms
> [ -TIMING- ] technique=3Dcauchy_good      [        reco-lp-3 ] speed=3D=
1.256 [GB/s] latency=3D50.962 ms
> [ -TIMING- ] technique=3Dcauchy_good      [   reco-lp-crc32c ] speed=3D=
2.300 [GB/s] latency=3D27.832 ms
> [ -TIMING- ] technique=3Dliber8tion       [           encode ] speed=3D=
2.297 [GB/s] latency=3D27.865 ms
> [ -TIMING- ] technique=3Dliber8tion       [        encode-lp ] speed=3D=
1.498 [GB/s] latency=3D42.731 ms
> [ -TIMING- ] technique=3Dliber8tion       [      encode-lp-3 ] speed=3D=
1.505 [GB/s] latency=3D42.513 ms
> [ -TIMING- ] technique=3Dliber8tion       [ encode-lp-crc32c ] speed=3D=
1.142 [GB/s] latency=3D56.018 ms
> [ -TIMING- ] technique=3Dliber8tion       [             reco ] speed=3D=
2.238 [GB/s] latency=3D28.601 ms
> [ -TIMING- ] technique=3Dliber8tion       [          reco-lp ] speed=3D=
4.399 [GB/s] latency=3D14.550 ms
> [ -TIMING- ] technique=3Dliber8tion       [        reco-lp-3 ] speed=3D=
1.878 [GB/s] latency=3D34.070 ms
> [ -TIMING- ] technique=3Dliber8tion       [   reco-lp-crc32c ] speed=3D=
2.307 [GB/s] latency=3D27.737 ms
>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 27 September 2013 11:40
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>=20
> On 26/09/2013 23:49, Andreas Joachim Peters wrote:> Sure,
>> this text is clear, but it does not talk about the cost of reconstruct=
ion e.g. not to select a data chunk but a parity chunk costs CPU and incr=
eases latency, but is not reflected by the external cost parameter e.g. i=
f you have RS (3,2), 3 data and 2 parity chunks with chunks [0,1,2,3,4] w=
ith equal cost values,  I would select [0,1,2] since it avoids computatio=
n, however the retrieval cost for [2,3,4] would be the same but the compu=
tational cost is higher.
>=20
> The implementation knows about the computational cost already and is ab=
le to figure out that [0,1,2] is going to be cheaper. It does not need in=
put from the caller and the minimum_to_decode method (without the cost)
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L45
> does this. If you want to read [0,1,2] and have [0,1,2,3,4] available i=
t will return that you need to retreive [0,1,2] and not [2,3,4] although =
both would allow to get the content of [0,1,2].
>=20
>>
>> Now if [0] has for example the double cost compared to chunk [3], it i=
s not clear to me if [1,2,3] is a better set than [0,1,2] ... is the mean=
ing of a higher cost actually more a binary flag saying 'avoid to read th=
is chunk if possible' ?
>>
>> Could you give a practical example when a chunk can have a higher cost=
 in a CEPH setup and a rough range for the 'cost' parameter?
>=20
> At the moment I can't because it depends on the implementation of the e=
rasure code placement group and it's not complete yet. You are correct : =
the interpretation of the cost by the plugin cannot be fully described wi=
thout an intimate knowledge of the implementation. It also means that if =
the implementation of the caller changes, the semantic of the cost will c=
hange an may require a different strategy.
>=20
> Cheers
>=20
>> Thanks Andreas.
>>
>>
>>
>>
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 26 September 2013 21:18
>> To: Andreas Joachim Peters
>> Cc: Ceph Development
>> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>>
>> [re-adding ceph-devel to the cc]
>>
>> On 26/09/2013 20:36, Andreas-Joachim Peters wrote:> Hi Loic,
>>> today I forked he CEPH repository and will commit my changes to my Gi=
tHub fork asap ... (I am not familiar with GitHub in particular).
>>> I was finalizing the minimim_to_decode function today with test cases=
 (it is more sophisticated in this case ...) ... I didn't fully get what =
the 'with cost' function is supposed to do diffrent from the one without =
cost?
>>
>> I'd be happy to explain if
>> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.=
h#L131
>> is unclear. Would you be so kind as to tell me what is confusing in th=
e description ?
>>
>>>
>>>
>>> Cheers Andreas.
>>>
>>> On Wed, Sep 25, 2013 at 8:48 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>>
>>>
>>>
>>>     On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I =
actually thought the same in the meanwhile ...  I have some questions:
>>>     >
>>>     > Q: Can/should it stay in the framework of google test's or you =
would prefer just a plain executable ?
>>>     >
>>>
>>>     A plain executable would make sense. An simple example from src/t=
est/Makefile.am :
>>>
>>>     ceph_test_trans_SOURCES =3D test/test_trans.cc
>>>     ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
>>>     bin_DEBUGPROGRAMS +=3D ceph_test_trans
>>>
>>>
>>>     > I have added local parity support to your erasure class adding =
a new argument: "erasure-code-lp" and
>>>     > two new methods:
>>>     >
>>>     > localparity_encode(...)
>>>     > localparity_decode(...)
>>>     >
>>>     > I made a more complex benchmark of (8,2) + 2 local parities (1^=
2^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as spee=
d & effective write-latency for three cases (each for liberation & cauchy=
_good codecs):
>>>     >
>>>     > 1 (8,2)
>>>     > 2 (8,2,lp=3D2)
>>>     > 3 (8,2,lp=3D2) + crc32c (blocks)
>>>     >
>>>     > and several failure scenarios ... single, double, triple disk f=
ailures. Probably the best is if I make all this parameters configurable.=

>>>
>>>     Great :-) Do you have a public git repository where I could clone=
 this & give it a try ?
>>>
>>>     > Q: For the local parity implementation .... shall I inherit fro=
m your erasure plugin and overwrite the encode/decode method or you would=
 consider a patch to the original class?
>>>
>>>     It is a perfect timing for a patch to the original class.
>>>
>>>     > I have also a 128-bit XOR implementation for the local parities=
=2E This will work with new gcc's & clang compilers ...
>>>     >
>>>     > Q: Which compilers/platforms are supported by CEPH? Is there a =
minimal GCC version?
>>>
>>>     You can see all supported platforms here:
>>>
>>>     http://ceph.com/gitbuilder.cgi
>>>
>>>     I don't think the GCC version shows in the logs but you can proba=
bly figure it out from the corresponding distribution.
>>>
>>>     > Q: is there some policy restricting comments within code? In ge=
neral I see very few or no comments within the code ..
>>>
>>>     :-) The mon code tends to be more heavily commented than the osd =
code (IMO) but I'm not aware of any policy. When I feel the need to comme=
nt, I write a unit test. If the unit test is difficult, I tend to comment=
 to clarify its purpose. The problem with comments is that they quickly b=
ecome obsolete and/or misleading. That being said, I don't think anyone w=
ill object if you heavily comment your code.
>>>
>>>     Cheers
>>>
>>>     > Cheers Andreas.
>>>     >
>>>     >
>>>     >
>>>     >
>>>
>>>     --
>>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>>     All that is necessary for the triumph of evil is that good people=
 do nothing.
>>>
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do no=
thing.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--txggQWgQ1XKxGFGxOMfkT0e00F2kBaMiT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJL75IACgkQ8dLMyEl6F23eGwCeJd5qmdeKG2dEMGIjsrrMpTZm
5w4AoLeSItsMZHPNv5HvpgFuapXD/wUG
=udJa
-----END PGP SIGNATURE-----

--txggQWgQ1XKxGFGxOMfkT0e00F2kBaMiT--
