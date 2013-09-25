From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 25 Sep 2013 18:33:08 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>,<523FED54.8040208@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>,<5242FDDC.3060504@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:6996 "EHLO CERNMX32.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381Ab3IYSdN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 14:33:13 -0400
In-Reply-To: <5242FDDC.3060504@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, sure. I actually thought the same in the meanwhile ...  I have some questions:

Q: Can/should it stay in the framework of google test's or you would prefer just a plain executable ?

I have added local parity support to your erasure class adding a new argument: "erasure-code-lp" and
two new methods:

localparity_encode(...)
localparity_decode(...)

I made a more complex benchmark of (8,2) + 2 local parities (1^2^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as speed & effective write-latency for three cases (each for liberation & cauchy_good codecs):

1 (8,2)
2 (8,2,lp=2)
3 (8,2,lp=2) + crc32c (blocks)

and several failure scenarios ... single, double, triple disk failures. Probably the best is if I make all this parameters configurable. 

Q: For the local parity implementation .... shall I inherit from your erasure plugin and overwrite the encode/decode method or you would consider a patch to the original class?

I have also a 128-bit XOR implementation for the local parities. This will work with new gcc's & clang compilers ... 

Q: Which compilers/platforms are supported by CEPH? Is there a minimal GCC version?

Q: is there some policy restricting comments within code? In general I see very few or no comments within the code ..

Cheers Andreas.




