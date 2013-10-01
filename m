From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Tue, 1 Oct 2013 23:00:29 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A5278DA2@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>
 <523FED54.8040208@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>
 <5242FDDC.3060504@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
 <52433014.3030109@dachary.org>
 <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>,<5244887A.80503@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A52741F6@PLOXCHG03.cern.ch>,<52455279.1020702@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:43181 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3JAXAd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 19:00:33 -0400
In-Reply-To: <52455279.1020702@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20

here is the patch implementing the basic pyramid code adding local pari=
ty to erasure encoding. I tried to keep it 100% identical to the behavi=
our of the original version besides I changed the alignment to 128-bit =
words. Atleast your unit tests works ;-)

https://github.com/apeters1971/ceph/commit/b2de7af1a49dc98940d5685eab00=
a339bf81a0e5

in src:=20

make unittest_erasure_code_pyramid_jerasure

=2E/unittest_erasure_code_pyramid_jerasure --gtest_filter=3D*.* --log-t=
o-stderr=3Dtrue --object-size=3D64

It tests (8,2,2)

[ -TIMING- ] technique=3Dcauchy_good      [           encode ] speed=3D=
1.840 [GB/s] latency=3D34.791 ms
[ -TIMING- ] technique=3Dcauchy_good      [        encode-lp ] speed=3D=
1.305 [GB/s] latency=3D49.057 ms
[ -TIMING- ] technique=3Dcauchy_good      [      encode-lp-3 ] speed=3D=
1.307 [GB/s] latency=3D48.956 ms
[ -TIMING- ] technique=3Dcauchy_good      [ encode-lp-crc32c ] speed=3D=
1.036 [GB/s] latency=3D61.752 ms
[ -TIMING- ] technique=3Dcauchy_good      [             reco ] speed=3D=
1.780 [GB/s] latency=3D35.959 ms
[ -TIMING- ] technique=3Dcauchy_good      [          reco-lp ] speed=3D=
4.348 [GB/s] latency=3D14.720 ms
[ -TIMING- ] technique=3Dcauchy_good      [        reco-lp-3 ] speed=3D=
1.256 [GB/s] latency=3D50.962 ms
[ -TIMING- ] technique=3Dcauchy_good      [   reco-lp-crc32c ] speed=3D=
2.300 [GB/s] latency=3D27.832 ms
[ -TIMING- ] technique=3Dliber8tion       [           encode ] speed=3D=
2.297 [GB/s] latency=3D27.865 ms
[ -TIMING- ] technique=3Dliber8tion       [        encode-lp ] speed=3D=
1.498 [GB/s] latency=3D42.731 ms
[ -TIMING- ] technique=3Dliber8tion       [      encode-lp-3 ] speed=3D=
1.505 [GB/s] latency=3D42.513 ms
[ -TIMING- ] technique=3Dliber8tion       [ encode-lp-crc32c ] speed=3D=
1.142 [GB/s] latency=3D56.018 ms
[ -TIMING- ] technique=3Dliber8tion       [             reco ] speed=3D=
2.238 [GB/s] latency=3D28.601 ms
[ -TIMING- ] technique=3Dliber8tion       [          reco-lp ] speed=3D=
4.399 [GB/s] latency=3D14.550 ms
[ -TIMING- ] technique=3Dliber8tion       [        reco-lp-3 ] speed=3D=
1.878 [GB/s] latency=3D34.070 ms
[ -TIMING- ] technique=3Dliber8tion       [   reco-lp-crc32c ] speed=3D=
2.307 [GB/s] latency=3D27.737 ms

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 27 September 2013 11:40
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: CEPH Erasure Encoding + OSD Scalability

On 26/09/2013 23:49, Andreas Joachim Peters wrote:> Sure,
> this text is clear, but it does not talk about the cost of reconstruc=
tion e.g. not to select a data chunk but a parity chunk costs CPU and i=
ncreases latency, but is not reflected by the external cost parameter e=
=2Eg. if you have RS (3,2), 3 data and 2 parity chunks with chunks [0,1=
,2,3,4] with equal cost values,  I would select [0,1,2] since it avoids=
 computation, however the retrieval cost for [2,3,4] would be the same =
but the computational cost is higher.

The implementation knows about the computational cost already and is ab=
le to figure out that [0,1,2] is going to be cheaper. It does not need =
input from the caller and the minimum_to_decode method (without the cos=
t)
https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L45
does this. If you want to read [0,1,2] and have [0,1,2,3,4] available i=
t will return that you need to retreive [0,1,2] and not [2,3,4] althoug=
h both would allow to get the content of [0,1,2].

>
> Now if [0] has for example the double cost compared to chunk [3], it =
is not clear to me if [1,2,3] is a better set than [0,1,2] ... is the m=
eaning of a higher cost actually more a binary flag saying 'avoid to re=
ad this chunk if possible' ?
>
> Could you give a practical example when a chunk can have a higher cos=
t in a CEPH setup and a rough range for the 'cost' parameter?

At the moment I can't because it depends on the implementation of the e=
rasure code placement group and it's not complete yet. You are correct =
: the interpretation of the cost by the plugin cannot be fully describe=
d without an intimate knowledge of the implementation. It also means th=
at if the implementation of the caller changes, the semantic of the cos=
t will change an may require a different strategy.

Cheers

> Thanks Andreas.
>
>
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 26 September 2013 21:18
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>
> [re-adding ceph-devel to the cc]
>
> On 26/09/2013 20:36, Andreas-Joachim Peters wrote:> Hi Loic,
>> today I forked he CEPH repository and will commit my changes to my G=
itHub fork asap ... (I am not familiar with GitHub in particular).
>> I was finalizing the minimim_to_decode function today with test case=
s (it is more sophisticated in this case ...) ... I didn't fully get wh=
at the 'with cost' function is supposed to do diffrent from the one wit=
hout cost?
>
> I'd be happy to explain if
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface=
=2Eh#L131
> is unclear. Would you be so kind as to tell me what is confusing in t=
he description ?
>
>>
>>
>> Cheers Andreas.
>>
>> On Wed, Sep 25, 2013 at 8:48 PM, Loic Dachary <loic@dachary.org <mai=
lto:loic@dachary.org>> wrote:
>>
>>
>>
>>     On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I=
 actually thought the same in the meanwhile ...  I have some questions:
>>     >
>>     > Q: Can/should it stay in the framework of google test's or you=
 would prefer just a plain executable ?
>>     >
>>
>>     A plain executable would make sense. An simple example from src/=
test/Makefile.am :
>>
>>     ceph_test_trans_SOURCES =3D test/test_trans.cc
>>     ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
>>     bin_DEBUGPROGRAMS +=3D ceph_test_trans
>>
>>
>>     > I have added local parity support to your erasure class adding=
 a new argument: "erasure-code-lp" and
>>     > two new methods:
>>     >
>>     > localparity_encode(...)
>>     > localparity_decode(...)
>>     >
>>     > I made a more complex benchmark of (8,2) + 2 local parities (1=
^2^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as s=
peed & effective write-latency for three cases (each for liberation & c=
auchy_good codecs):
>>     >
>>     > 1 (8,2)
>>     > 2 (8,2,lp=3D2)
>>     > 3 (8,2,lp=3D2) + crc32c (blocks)
>>     >
>>     > and several failure scenarios ... single, double, triple disk =
failures. Probably the best is if I make all this parameters configurab=
le.
>>
>>     Great :-) Do you have a public git repository where I could clon=
e this & give it a try ?
>>
>>     > Q: For the local parity implementation .... shall I inherit fr=
om your erasure plugin and overwrite the encode/decode method or you wo=
uld consider a patch to the original class?
>>
>>     It is a perfect timing for a patch to the original class.
>>
>>     > I have also a 128-bit XOR implementation for the local paritie=
s. This will work with new gcc's & clang compilers ...
>>     >
>>     > Q: Which compilers/platforms are supported by CEPH? Is there a=
 minimal GCC version?
>>
>>     You can see all supported platforms here:
>>
>>     http://ceph.com/gitbuilder.cgi
>>
>>     I don't think the GCC version shows in the logs but you can prob=
ably figure it out from the corresponding distribution.
>>
>>     > Q: is there some policy restricting comments within code? In g=
eneral I see very few or no comments within the code ..
>>
>>     :-) The mon code tends to be more heavily commented than the osd=
 code (IMO) but I'm not aware of any policy. When I feel the need to co=
mment, I write a unit test. If the unit test is difficult, I tend to co=
mment to clarify its purpose. The problem with comments is that they qu=
ickly become obsolete and/or misleading. That being said, I don't think=
 anyone will object if you heavily comment your code.
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
>>     All that is necessary for the triumph of evil is that good peopl=
e do nothing.
>>
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
