From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Simplified LRC in CEPH
Date: Fri, 1 Aug 2014 08:00:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:5237 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbaHAIBB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 04:01:01 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic et. al.

I managed to prototype (and understand) LRC encoding similiar to Xorbas in the ISA plug-in.

As an example take a (16,4) code (which gives nice alignment for 4k blocks) :

For 4 sub groups of the data chunks you build e.g. local parities LP1-LP4

LP1 = 1 ^ 2 ^ 3 ^ 4

LP2 = 5 ^ 6 ^ 7 ^ 8

LP3 = 9 ^ 10 ^ 11 ^ 12

LP4 = 13 ^ 14 ^ 15 ^ 16

You do normal erasure encoding with 4 RS chunks:

RS(1..16) = (R1, R2, R3, R4)

You compute the local parity LP5 for the erasure chunks:

LP5 = R1 ^ R2 ^ R3 ^ R4

The relation which holds for Vandermonde matrices (because the first matrix row contains only 1's)

LP1 ^ LP2 ^ LP3 ^ LP4 = R1

So you need to store only 24 chunks (not 25):

(1 .. 16) (R2,R3,R4) (LP1,LP2,LP3,LP4,LP5)

Side remark: in this simplified explanation I imply R1, not LP5 as described in the Xorbas paper

The degree of the code is 5 e.g. you can construct a failure with 5 losses where you loose data, while if you are 'lucky' the code can even repair up to 8 failures (one loss in each sub group + LP5,R2,R3,R4).

The reconstruction traffic for single failures is:

[(20 x 4) + (4 x 8)]/24 =~ 4.66 x [disk size] instead of 16 x [disk size]

There are three repair scenarios:

1) only single failures in any of the local groups using LRC repair (simple parities)
2) multiple failures which can be reconstructed with RS parities without LRC repair
3) multiple failures which can be reconstructed with RS parities after LRC repair

[ 4) reconstruction impossible  ]

Having your proposed LRC layer (decoding) model in mind there is a certain contradiction here because there are cases where it is not required to use LRC since you can resolve all the failures with RS alone.

In the end I think, it is sufficient if we introduce a parameter l in the EC parameter list which defines the number of subgroups in the data chunks and imply to use always one local parity for all RS chunks. So you can specify an LRC easily with three simple parameters:

k=16 m=4 l=4

The Xorbas configuration would be written as k=10 m=4 l=2

Wouldn't that be much simpler and sufficient? What do you think?

Cheers Andreas.



















