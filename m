From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 27 Sep 2013 11:40:09 +0200
Message-ID: <52455279.1020702@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch> <523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch> <5242FDDC.3060504@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch> <52433014.3030109@dachary.org> <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>,<5244887A.80503@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52741F6@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sXrc3xHRsMrkDdl4qt4brwiwFASeblopX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:47152 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3I0JkL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Sep 2013 05:40:11 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52741F6@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sXrc3xHRsMrkDdl4qt4brwiwFASeblopX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 26/09/2013 23:49, Andreas Joachim Peters wrote:> Sure,=20
> this text is clear, but it does not talk about the cost of reconstructi=
on e.g. not to select a data chunk but a parity chunk costs CPU and incre=
ases latency, but is not reflected by the external cost parameter e.g. if=
 you have RS (3,2), 3 data and 2 parity chunks with chunks [0,1,2,3,4] wi=
th equal cost values,  I would select [0,1,2] since it avoids computation=
, however the retrieval cost for [2,3,4] would be the same but the comput=
ational cost is higher.

The implementation knows about the computational cost already and is able=
 to figure out that [0,1,2] is going to be cheaper. It does not need inpu=
t from the caller and the minimum_to_decode method (without the cost)
https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJerasur=
e/ErasureCodeJerasure.cc#L45
does this. If you want to read [0,1,2] and have [0,1,2,3,4] available it =
will return that you need to retreive [0,1,2] and not [2,3,4] although bo=
th would allow to get the content of [0,1,2].

>=20
> Now if [0] has for example the double cost compared to chunk [3], it is=
 not clear to me if [1,2,3] is a better set than [0,1,2] ... is the meani=
ng of a higher cost actually more a binary flag saying 'avoid to read thi=
s chunk if possible' ?=20
>=20
> Could you give a practical example when a chunk can have a higher cost =
in a CEPH setup and a rough range for the 'cost' parameter?

At the moment I can't because it depends on the implementation of the era=
sure code placement group and it's not complete yet. You are correct : th=
e interpretation of the cost by the plugin cannot be fully described with=
out an intimate knowledge of the implementation. It also means that if th=
e implementation of the caller changes, the semantic of the cost will cha=
nge an may require a different strategy.

Cheers

> Thanks Andreas.
>=20
>=20
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 26 September 2013 21:18
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>=20
> [re-adding ceph-devel to the cc]
>=20
> On 26/09/2013 20:36, Andreas-Joachim Peters wrote:> Hi Loic,
>> today I forked he CEPH repository and will commit my changes to my Git=
Hub fork asap ... (I am not familiar with GitHub in particular).
>> I was finalizing the minimim_to_decode function today with test cases =
(it is more sophisticated in this case ...) ... I didn't fully get what t=
he 'with cost' function is supposed to do diffrent from the one without c=
ost?
>=20
> I'd be happy to explain if
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h=
#L131
> is unclear. Would you be so kind as to tell me what is confusing in the=
 description ?
>=20
>>
>>
>> Cheers Andreas.
>>
>> On Wed, Sep 25, 2013 at 8:48 PM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>>
>>
>>
>>     On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I a=
ctually thought the same in the meanwhile ...  I have some questions:
>>     >
>>     > Q: Can/should it stay in the framework of google test's or you w=
ould prefer just a plain executable ?
>>     >
>>
>>     A plain executable would make sense. An simple example from src/te=
st/Makefile.am :
>>
>>     ceph_test_trans_SOURCES =3D test/test_trans.cc
>>     ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
>>     bin_DEBUGPROGRAMS +=3D ceph_test_trans
>>
>>
>>     > I have added local parity support to your erasure class adding a=
 new argument: "erasure-code-lp" and
>>     > two new methods:
>>     >
>>     > localparity_encode(...)
>>     > localparity_decode(...)
>>     >
>>     > I made a more complex benchmark of (8,2) + 2 local parities (1^2=
^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as speed=
 & effective write-latency for three cases (each for liberation & cauchy_=
good codecs):
>>     >
>>     > 1 (8,2)
>>     > 2 (8,2,lp=3D2)
>>     > 3 (8,2,lp=3D2) + crc32c (blocks)
>>     >
>>     > and several failure scenarios ... single, double, triple disk fa=
ilures. Probably the best is if I make all this parameters configurable.
>>
>>     Great :-) Do you have a public git repository where I could clone =
this & give it a try ?
>>
>>     > Q: For the local parity implementation .... shall I inherit from=
 your erasure plugin and overwrite the encode/decode method or you would =
consider a patch to the original class?
>>
>>     It is a perfect timing for a patch to the original class.
>>
>>     > I have also a 128-bit XOR implementation for the local parities.=
 This will work with new gcc's & clang compilers ...
>>     >
>>     > Q: Which compilers/platforms are supported by CEPH? Is there a m=
inimal GCC version?
>>
>>     You can see all supported platforms here:
>>
>>     http://ceph.com/gitbuilder.cgi
>>
>>     I don't think the GCC version shows in the logs but you can probab=
ly figure it out from the corresponding distribution.
>>
>>     > Q: is there some policy restricting comments within code? In gen=
eral I see very few or no comments within the code ..
>>
>>     :-) The mon code tends to be more heavily commented than the osd c=
ode (IMO) but I'm not aware of any policy. When I feel the need to commen=
t, I write a unit test. If the unit test is difficult, I tend to comment =
to clarify its purpose. The problem with comments is that they quickly be=
come obsolete and/or misleading. That being said, I don't think anyone wi=
ll object if you heavily comment your code.
>>
>>     Cheers
>>
>>     > Cheers Andreas.
>>     >
>>     >
>>     >
>>     >
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>     All that is necessary for the triumph of evil is that good people =
do nothing.
>>
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


--sXrc3xHRsMrkDdl4qt4brwiwFASeblopX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJFUnkACgkQ8dLMyEl6F21E9wCdEOLHPCl3TF/FN0nUNOpWvdee
NTsAoJdP/GcPD8WJQTc/hJee1Kf10trM
=an2T
-----END PGP SIGNATURE-----

--sXrc3xHRsMrkDdl4qt4brwiwFASeblopX--
