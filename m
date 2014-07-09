From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Intel ISA-L EC plugin
Date: Wed, 9 Jul 2014 04:45:41 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE749AA2@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>,<53B5D2B6.2010406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:38558 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbaGIEpo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jul 2014 00:45:44 -0400
In-Reply-To: <53B5D2B6.2010406@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
probably one should do the same trick for Jerasure. However in the most=
 common situation (one lost), the decoding matrix is not generated anyw=
ay.

I used std::map + std::list where the map value is a pair with the iter=
ator pointing into the list + the matrix and I use the splice function =
to move an LRU entry in the list. The key is just a string defining the=
 decoding situation (erasures). I can also use lru.h ... should give th=
e same performance.

Cheers Andreas.

>
> I have chosen after benchmarking to use the LRU cache for the decodin=
g matrix. I can cache easily all decoding matrices (worst case scenario=
) for configurations up to (10,4) without trashing it. I will restrict =
the (k,m) in case of the vandermonde matrix to the ones which are inver=
tible, for cauchy they are all invertible anyway.
>
> I will rebase to your branch wip-7238-lrc then!

Hi Andreas,

=46rom what I read in https://bitbucket.org/jimplank/jerasure/src/21de9=
8383350e7c46e5ee329de2a93c696dee67a/src/jerasure.c?at=3Dmaster#cl-167 i=
t looks like it could benefit from a LRU cache also. Are you going to u=
se https://github.com/ceph/ceph/blob/master/src/include/lru.h for this =
?

Cheers
>
> Cheers Andreas.
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 02 July 2014 20:33
> To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
> Subject: Re: FW: Intel ISA-L EC plugin
>
> Hi Andreas,
>
> On 02/07/2014 19:54, Andreas Joachim Peters wrote:> Hi Sage & Loic et=
 al ...
>> getting some support from Paul Luse I have finished the refactoring =
of the EC ISA-L plug-in.
>>
>>
>> The essential ISA-L v 2.10 sources are now part of the source tree a=
nd it builds a single shared library which is portable on platforms wit=
h varying CPU extensions (SSE2, AVX, AVX2). I tested on various Intel &=
 AMD processor types.
>>
>> The build of the plug-in is coupled to the presence of 'yasm' simili=
ar to the crc32c extension in common/ ... (I couldn't build ISA-L on AR=
M).
>>
>> It supports two encoding matrices Vandermonde & Cauchy. The techniqu=
es are called similar to the one used by Loic in Jerasure "reed_sol_van=
" & "cauchy". "cauchy" is the default.
>>
>> Greg Tucker from Intel pointed me to the proper ( and faster ) way o=
f decoding if parity chunks are missing.
>
> Great !
>
>> ??? How do we proceed? I currently rebase against firefly and use it=
s API definition or should this be for a later release with Loic's refa=
ctored interface? Shall I make a pull request or shall I hand it over t=
o Loic and he takes care to do the integration including QA etc ...?
>
> It would be great if you could rebase against https://github.com/dach=
ary/ceph/tree/wip-7238-lrc. It contains the base class that will help u=
s share code common to plugins. I hope it will be merged in the next fe=
w days. During the last CDS the remapping of the data chunks has been a=
greed on and the only reason why it is not yet merged is that integrati=
on tests must first show it does not break anything and is fully backwa=
rd compatible.
>
> Cheers
>
>> ??? I have still an open question on the library optimization for de=
coding(=3Drepair). If you call decoding for a certain set one needs to =
do a matrix inversion coupled to the given set. If the payload is like =
1M the computation of the decoding matrix does not
>>  play a role. If the payload is 4k it plays a role. Can I assume tha=
t the plugin will be called concurrently for the same object with the s=
ame set of chunks or would the plugin be called interleaved for many ob=
jects with changing chunk configurations? Is the
>>  EC object called single-threaded or by a thread pool? Will backfill=
l use 4k IOs or larger?
>>
>> I would either commit the simple cache mechanism caching the last co=
mputed erasure configuration & corresponding matrix or put an LRU cache=
 for the last computed matrices. I prototyped both, but would stick to =
the simplest required.
>>
>> Cheers Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
