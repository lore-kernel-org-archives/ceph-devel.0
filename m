From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Sun, 22 Sep 2013 07:26:32 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
References: <-7369304096744919226@unknownmsgid>
 <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
 <523C40B7.5060902@dachary.org>
 <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
 <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:39773 "EHLO
	CERNMX32.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab3IVH0f convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 03:26:35 -0400
In-Reply-To: <523DB725.2070104@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20
I run a benchmark with the changed code tomorrow ... I actually had to =
insert some of my realtime benchmark macro's into your Jerasure code to=
 see the different time fractions between buffer preparation & encoding=
 step, but for you QA suite it is probably enough to get a total value =
after your fix. I will send you a program sampling the performance at d=
ifferent buffer sizes and encoding types.

I changed my code to use vector operations (128-bit XOR's) and it gives=
 another 10% gain. I also want to try out if it makes sense to do the C=
RC32C computation in-line in the encoding step and compare it with the =
two step procedure first encoding all blocks, then CRC32C on all blocks=
=2E

Cheers Andreas.



________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 21 September 2013 17:11
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

Hi Andreas,

It's probably too soon to be smart about reducing the number of copies,=
 but you're right : this copy is not necessary. The following pull requ=
est gets rid of it:

https://github.com/ceph/ceph/pull/615

Cheers

On 20/09/2013 18:49, Loic Dachary wrote:
> Hi,
>
> This is a first attempt at avoiding unnecessary copy:
>
> https://github.com/dachary/ceph/blob/03445a5926cd073c11cd8693fb110729=
e40f35fa/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L66
>
> I'm not sure how it could be made more readable / terse with bufferli=
st iterators. Any kind of hint would be welcome :-)
>
> Cheers
>
> On 20/09/2013 17:36, Sage Weil wrote:
>> On Fri, 20 Sep 2013, Loic Dachary wrote:
>>> Hi Andreas,
>>>
>>> Great work on these benchmarks ! It's definitely an incentive to im=
prove as much as possible. Could you push / send the scripts and sequen=
ce of operations you've used ? I'll reproduce this locally while gettin=
g rid of the extra copy. It would be useful to capture that into a scri=
pt that can be conveniently run from the teuthology integrations tests =
to check against performance regressions.
>>>
>>> Regarding the 3P implementation, in my opinion it would be very val=
uable for some people who prefer low CPU consumption. And I'm eager to =
see more than one plugin in the erasure code plugin directory ;-)
>>
>> One way to approach this might be to make a bufferlist 'multi-iterat=
or'
>> that you give you bufferlist::iterator's and will give you back a pa=
ir of
>> points and length for each contiguous segment.  This would capture t=
he
>> annoying iterator details and let the user focus on processing chunk=
s that
>> are as large as possible.
>>
>> sage
>>
>>
>>  >
>>> Cheers
>>>
>>> On 20/09/2013 13:35, Andreas Joachim Peters wrote:
>>>> Hi Loic,
>>>>
>>>> I have now some benchmarks on a Xeon 2.27 GHz 4-core with gcc 4.4 =
(-O2) for ENCODING based on the CEPH Jerasure port.
>>>> I measured for objects from 128k to 512 MB with random contents (i=
f you encode 1 GB objects you see slow downs due to caching inefficienc=
ies ...), otherwise results are stable for the given object sizes.
>>>>
>>>> I quote only the benchmark for ErasureCodeJerasureReedSolomonRAID6=
 (3,2) , the other are significantly slower (2-3x slower) and my 3P(3,2=
,1) implementation providing the same redundancy level like RS-Raid6[3,=
2] (double disk failure) but using more space (66% vs 100% overhead).
>>>>
>>>> The effect of out.c_str() is significant ( contributes with factor=
 2 slow-down for the best jerasure algorithm for [3,2] ).
>>>>
>>>> Averaged results for Objects Size 4MB:
>>>>
>>>> 1) Erasure CRS [3,2] - 2.6 ms buffer preparation (out.c_str()) - 2=
=2E4 ms encoding =3D> ~780 MB/s
>>>> 2) 3P [3,2,1] - 0,005 ms buffer preparation (3P adjusts the paddin=
g in the algorithm) - 0.87ms encoding =3D> ~4.4 GB/s
>>>>
>>>> I think it pays off to avoid the copy in the encoding if it does n=
ot matter for the buffer handling upstream and pad only the last chunk.
>>>>
>>>> Last thing I tested is how performances scales with number of core=
s running 4 tests in parallel:
>>>>
>>>> Jerasure (3,2) limits at ~2,0 GB/s for a 4-core CPU (Xeon 2.27 GHz=
).
>>>> 3P(3,2,1) limits ~8 GB/s for a 4-core CPU (Xeon 2.27 GHz).
>>>>
>>>> I also implemented the decoding for 3P, but didn't test yet all re=
construction cases. There is probably room for improvements using AVX s=
upport for XOR operations in both implementations.
>>>>
>>>> Before I invest more time, do think it is useful to have this fast=
 3P algorithm for double disk failures with 100% space overhead? Becaus=
e I believe that people will always optimize for space and would rather=
 use something like (10,2) even if the performance degrades and CPU con=
sumption goes up?!? Let me know, no problem in any case!
>>>>
>>>> Finally I tested some combinations for ErasureCodeJerasureReedSolo=
monRAID6:
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
>>> --
>>> Lo?c Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people d=
o nothing.
>>>
>>>
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
