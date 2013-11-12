From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Tue, 12 Nov 2013 01:11:49 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch>
References: <-7369304096744919226@unknownmsgid>
 <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
 <523C40B7.5060902@dachary.org>
 <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
 <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:39010 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab3KLBRK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 20:17:10 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20

I am finally doing the benchmark tool and I found a bunch of wrong para=
meter checks which can make the whole thing SEGV.

All the RAID-6 codes have restrictions on the parameters but they are n=
ot correctly enforced for Liberation & Blaum-Roth codes in the CEPH wra=
pper class ... see text from PDF

"Minimal Density RAID-6 codes are MDS codes based on binary matrices wh=
ich satisfy a lower-bound on the number  of non-zero entries. Unlike Ca=
uchy coding, the bit-matrix elements do not correspond to elements in G=
=46 (2 w ). Instead, the bit-matrix itself has the proper MDS property.=
 Minimal Density RAID-6 codes perform faster than Reed-Solomon and Cauc=
hy Reed-Solomon codes for the same parameters. Liberation coding, Liber=
8tion coding, and Blaum-Roth coding are three examples of this kind of =
coding that are supported in jerasure.

With each of these codes, m must be equal to two and k must be less tha=
n or equal to w. The value of w has restrictions based on the code:

=95 With Liberation coding, w must be a prime number [Pla08b].
=95 With Blaum-Roth coding, w + 1 must be a prime number [BR99]. =95 Wi=
th Liber8tion coding, w must equal 8 [Pla08a].

=2E..

Do you add this fixes?

=46or the benchmark suite it runs currently 308 different configuration=
s for the 2 algorithm which make sense from the performance point of vi=
ew and provides this output:


# -----------------------------------------------------------------
# Erasure Coding Benchmark - (C) CERN 2013 - Andreas.Joachim.Peters@cer=
n.ch
# Ram-Size=3D12614856704 Allocation-Size=3D100000000
# -----------------------------------------------------------------
# [ -BENCH- ] [       ] technique=3Dmemcpy                             =
                               speed=3D5.408 [GB/s] latency=3D9.245 ms
# [ -BENCH- ] [       ] technique=3Dd=3Da^b^c-xor                      =
                                 speed=3D4.377 [GB/s] latency=3D17.136 =
ms
# [ -BENCH- ] [001/304] technique=3Dcauchy_good:k=3D05:m=3D2:w=3D8:lp=3D=
0:packet=3D00064:size=3D50000000          speed=3D1.308 [GB/s] latency=3D=
038	[ms] size-overhead=3D40	[%]
=2E.
=2E.
# [ -BENCH- ] [304/304] technique=3Dliberation:k=3D24:m=3D2:w=3D29:lp=3D=
2:packet=3D65536:size=3D50000000          speed=3D0.083 [GB/s] latency=3D=
604	[ms] size-overhead=3D16	[%]
# -----------------------------------------------------------------
# Erasure Code Performance Summary::
# -----------------------------------------------------------------
# RAM:                   12.61 GB
# Allocation-Size        0.10 GB
# -----------------------------------------------------------------
# Byte Initialization:   29.35 MB/s
# Memcpy:                5.41 GB/s
# Triple-XOR:            4.38 GB/s
# -----------------------------------------------------------------
# Fastest RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Fastest Triple Failure 0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
# Fastest Quadr. Failure 0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
# -----------------------------------------------------------------
# .................................................................
# Top 1  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0:=
packet=3D04096:size=3D50000000
# Top 2  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0:=
packet=3D16384:size=3D50000000
# Top 3  RAID6          2.64 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0:=
packet=3D65536:size=3D50000000
# Top 4  RAID6          2.60 GB/s liberation:k=3D07:m=3D2:w=3D7:lp=3D0:=
packet=3D16384:size=3D50000000
# Top 5  RAID6          2.59 GB/s liberation:k=3D05:m=3D2:w=3D7:lp=3D0:=
packet=3D04096:size=3D50000000
# .................................................................
# Top 1  Triple         0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Top 2  Triple         0.94 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D0=
:packet=3D16384:size=3D50000000
# Top 3  Triple         0.93 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D0=
:packet=3D65536:size=3D50000000
# Top 4  Triple         0.89 GB/s cauchy_good:k=3D07:m=3D3:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Top 5  Triple         0.87 GB/s cauchy_good:k=3D05:m=3D3:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# .................................................................
# Top 1  Quadr.         0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Top 2  Quadr.         0.65 GB/s cauchy_good:k=3D07:m=3D4:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Top 3  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D0=
:packet=3D16384:size=3D50000000
# Top 4  Quadr.         0.64 GB/s cauchy_good:k=3D05:m=3D4:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
# Top 5  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D0=
:packet=3D65536:size=3D50000000
# .................................................................

It takes around 30 second on my box. I will add a measurement how the X=
OR and the 3 top algorithms scale with the number of cores and make the=
 object-size configurable from the command line. Anything else ? Shall =
I add the possiblity to test a single user specified configuration via =
command line arguments?

Cheers Andreas.




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
