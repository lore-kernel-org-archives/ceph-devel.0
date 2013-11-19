From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Tue, 19 Nov 2013 11:35:52 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6A01C0@PLOXCHG03.cern.ch>
References: <-7369304096744919226@unknownmsgid>
 <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
 <523C40B7.5060902@dachary.org>
 <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
 <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch>,<52826E2D.2040503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:28784 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab3KSLf4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Nov 2013 06:35:56 -0500
In-Reply-To: <52826E2D.2040503@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic et al,=A0
Dan pointed me to this:

http://sourceforge.net/p/snapraid/code/ci/master/tree/raid.c

It has a very straight forward API and GPL license ...

The implementation seems more performant than the current Jerasure libr=
ary probably due to the use of ssse3 extensions and slightly less flexi=
bility.... maybe it is worth a plugin or to become "the" plugin? It see=
ms also worth to rewrite the xoring function I use with the sse2 assemb=
ler xor ...

It comes also with a nice benchmark tool, here are the results on my 's=
tandard' Xeon for a 4MB block with 8 disks + parity disks ....:

=2E/snapraid -T
snapraid v5.0 by Andrea Mazzoleni, http://snapraid.sourceforge.net
Compiler gcc 4.8.1
CPU GenuineIntel, family 6, model 26, flags mmx sse2 ssse3 sse42
Memory is little-endian 64-bit
Support nanosecond timestamps with futimens()


Speed test using 8 buffers of 524288 bytes, for a total of 4096 KiB.
The reported value is the sustainable aggregate bandwidth of all data d=
isks in MiB/s (not counting parity disks).

Memory write speed using the C memset() function:
=A0 memset =A0 15873

CRC used to check the content file integrity:
=A0 =A0table =A0 =A0 857
=A0 =A0intel =A0 =A06689

Hash used to check the data blocks integrity:
=A0 =A0 =A0 =A0 =A0 =A0 best murmur3 spooky2
=A0 =A0 hash spooky2 =A0 =A02987 =A0 =A06998

RAID functions used for computing the parity with 'sync':
=A0 =A0 =A0 =A0 =A0 =A0 best =A0 =A0int8 =A0 int32 =A0 int64 =A0 =A0sse=
2 =A0 sse2e =A0 ssse3 =A0ssse3e
=A0 =A0 par1 =A0 =A0sse2 =A0 =A0 =A0 =A0 =A0 =A06201 =A0 11080 =A0 1940=
4
=A0 =A0 par2 =A0 sse2e =A0 =A0 =A0 =A0 =A0 =A01851 =A0 =A03462 =A0 =A09=
949 =A0 10359
=A0 =A0 parz =A0 sse2e =A0 =A0 =A0 =A0 =A0 =A01134 =A0 =A02020 =A0 =A05=
157 =A0 =A05738
=A0 =A0 par3 =A0ssse3e =A0 =A0 421 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04766 =A0 =A05225
=A0 =A0 par4 =A0ssse3e =A0 =A0 303 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03449 =A0 =A03844
=A0 =A0 par5 =A0ssse3e =A0 =A0 241 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02750 =A0 =A02830
=A0 =A0 par6 =A0ssse3e =A0 =A0 198 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02189 =A0 =A02261

RAID functions used for recovering with 'fix':
=A0 =A0 =A0 =A0 =A0 =A0 best =A0 =A0int8 =A0 ssse3
=A0 =A0 rec1 =A0 ssse3 =A0 =A0 496 =A0 =A01029
=A0 =A0 rec2 =A0 ssse3 =A0 =A0 208 =A0 =A0 477
=A0 =A0 rec3 =A0 ssse3 =A0 =A0 =A051 =A0 =A0 261
=A0 =A0 rec4 =A0 ssse3 =A0 =A0 =A033 =A0 =A0 170
=A0 =A0 rec5 =A0 ssse3 =A0 =A0 =A022 =A0 =A0 112
=A0 =A0 rec6 =A0 ssse3 =A0 =A0 =A016 =A0 =A0 =A086



________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 12 November 2013 19:06
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

Hi Andreas,

On 12/11/2013 02:11, Andreas Joachim Peters wrote:
> Hi Loic,
>
> I am finally doing the benchmark tool and I found a bunch of wrong pa=
rameter checks which can make the whole thing SEGV.
>
> All the RAID-6 codes have restrictions on the parameters but they are=
 not correctly enforced for Liberation & Blaum-Roth codes in the CEPH w=
rapper class ... see text from PDF
>
> "Minimal Density RAID-6 codes are MDS codes based on binary matrices =
which satisfy a lower-bound on the number  of non-zero entries. Unlike =
Cauchy coding, the bit-matrix elements do not correspond to elements in=
 GF (2 w ). Instead, the bit-matrix itself has the proper MDS property.=
 Minimal Density RAID-6 codes perform faster than Reed-Solomon and Cauc=
hy Reed-Solomon codes for the same parameters. Liberation coding, Liber=
8tion coding, and Blaum-Roth coding are three examples of this kind of =
coding that are supported in jerasure.
>
> With each of these codes, m must be equal to two and k must be less t=
han or equal to w. The value of w has restrictions based on the code:
>
> =95 With Liberation coding, w must be a prime number [Pla08b].
> =95 With Blaum-Roth coding, w + 1 must be a prime number [BR99]. =95 =
With Liber8tion coding, w must equal 8 [Pla08a].
>
> ...
>
> Do you add this fixes?

Nice catch. I created and assigned to myself : http://tracker.ceph.com/=
issues/6754
>
> For the benchmark suite it runs currently 308 different configuration=
s for the 2 algorithm which make sense from the performance point of vi=
ew and provides this output:
>
>
> # -----------------------------------------------------------------
> # Erasure Coding Benchmark - (C) CERN 2013 - Andreas.Joachim.Peters@c=
ern.ch
> # Ram-Size=3D12614856704 Allocation-Size=3D100000000
> # -----------------------------------------------------------------
> # [ -BENCH- ] [       ] technique=3Dmemcpy                           =
                                 speed=3D5.408 [GB/s] latency=3D9.245 m=
s
> # [ -BENCH- ] [       ] technique=3Dd=3Da^b^c-xor                    =
                                   speed=3D4.377 [GB/s] latency=3D17.13=
6 ms
> # [ -BENCH- ] [001/304] technique=3Dcauchy_good:k=3D05:m=3D2:w=3D8:lp=
=3D0:packet=3D00064:size=3D50000000          speed=3D1.308 [GB/s] laten=
cy=3D038    [ms] size-overhead=3D40   [%]
> ..
> ..
> # [ -BENCH- ] [304/304] technique=3Dliberation:k=3D24:m=3D2:w=3D29:lp=
=3D2:packet=3D65536:size=3D50000000          speed=3D0.083 [GB/s] laten=
cy=3D604    [ms] size-overhead=3D16   [%]
> # -----------------------------------------------------------------
> # Erasure Code Performance Summary::
> # -----------------------------------------------------------------
> # RAM:                   12.61 GB
> # Allocation-Size        0.10 GB
> # -----------------------------------------------------------------
> # Byte Initialization:   29.35 MB/s
> # Memcpy:                5.41 GB/s
> # Triple-XOR:            4.38 GB/s
> # -----------------------------------------------------------------
> # Fastest RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Fastest Triple Failure 0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Fastest Quadr. Failure 0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # -----------------------------------------------------------------
> # .................................................................
> # Top 1  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 2  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D=
0:packet=3D16384:size=3D50000000
> # Top 3  RAID6          2.64 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D=
0:packet=3D65536:size=3D50000000
> # Top 4  RAID6          2.60 GB/s liberation:k=3D07:m=3D2:w=3D7:lp=3D=
0:packet=3D16384:size=3D50000000
> # Top 5  RAID6          2.59 GB/s liberation:k=3D05:m=3D2:w=3D7:lp=3D=
0:packet=3D04096:size=3D50000000
> # .................................................................
> # Top 1  Triple         0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 2  Triple         0.94 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D16384:size=3D50000000
> # Top 3  Triple         0.93 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D65536:size=3D50000000
> # Top 4  Triple         0.89 GB/s cauchy_good:k=3D07:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 5  Triple         0.87 GB/s cauchy_good:k=3D05:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # .................................................................
> # Top 1  Quadr.         0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 2  Quadr.         0.65 GB/s cauchy_good:k=3D07:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 3  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D16384:size=3D50000000
> # Top 4  Quadr.         0.64 GB/s cauchy_good:k=3D05:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
> # Top 5  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D65536:size=3D50000000
> # .................................................................
>
> It takes around 30 second on my box.


That looks great :-) If I understand correctly, it means https://github=
=2Ecom/ceph/ceph/pull/740 will no longer have benchmarks as they are mo=
ved to a separate program. Correct ?

> I will add a measurement how the XOR and the 3 top algorithms scale w=
ith the number of cores and make the object-size configurable from the =
command line. Anything else ?

It would be convenient to run this from a "workunit" ( i.e. a script in=
 ceph/qa/workunits/ ) so that it can later be run by teuthology integra=
tion tests. That could be used to show regression.

Shall I add the possiblity to test a single user specified configuratio=
n via command line arguments?
>
I would need to play with it to comment usefully.

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
