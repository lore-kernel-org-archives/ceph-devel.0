From: Sage Weil <sage@inktank.com>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 20 Sep 2013 08:36:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57708 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3ITPg6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 11:36:58 -0400
In-Reply-To: <523C40B7.5060902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 20 Sep 2013, Loic Dachary wrote:
> Hi Andreas,
> 
> Great work on these benchmarks ! It's definitely an incentive to improve as much as possible. Could you push / send the scripts and sequence of operations you've used ? I'll reproduce this locally while getting rid of the extra copy. It would be useful to capture that into a script that can be conveniently run from the teuthology integrations tests to check against performance regressions.
> 
> Regarding the 3P implementation, in my opinion it would be very valuable for some people who prefer low CPU consumption. And I'm eager to see more than one plugin in the erasure code plugin directory ;-)

One way to approach this might be to make a bufferlist 'multi-iterator' 
that you give you bufferlist::iterator's and will give you back a pair of 
points and length for each contiguous segment.  This would capture the 
annoying iterator details and let the user focus on processing chunks that 
are as large as possible.

sage


 > 
> Cheers
> 
> On 20/09/2013 13:35, Andreas Joachim Peters wrote:
> > Hi Loic, 
> > 
> > I have now some benchmarks on a Xeon 2.27 GHz 4-core with gcc 4.4 (-O2) for ENCODING based on the CEPH Jerasure port.
> > I measured for objects from 128k to 512 MB with random contents (if you encode 1 GB objects you see slow downs due to caching inefficiencies ...), otherwise results are stable for the given object sizes.
> > 
> > I quote only the benchmark for ErasureCodeJerasureReedSolomonRAID6 (3,2) , the other are significantly slower (2-3x slower) and my 3P(3,2,1) implementation providing the same redundancy level like RS-Raid6[3,2] (double disk failure) but using more space (66% vs 100% overhead).
> > 
> > The effect of out.c_str() is significant ( contributes with factor 2 slow-down for the best jerasure algorithm for [3,2] ).
> > 
> > Averaged results for Objects Size 4MB:
> > 
> > 1) Erasure CRS [3,2] - 2.6 ms buffer preparation (out.c_str()) - 2.4 ms encoding => ~780 MB/s
> > 2) 3P [3,2,1] - 0,005 ms buffer preparation (3P adjusts the padding in the algorithm) - 0.87ms encoding => ~4.4 GB/s
> > 
> > I think it pays off to avoid the copy in the encoding if it does not matter for the buffer handling upstream and pad only the last chunk.
> > 
> > Last thing I tested is how performances scales with number of cores running 4 tests in parallel:
> > 
> > Jerasure (3,2) limits at ~2,0 GB/s for a 4-core CPU (Xeon 2.27 GHz).
> > 3P(3,2,1) limits ~8 GB/s for a 4-core CPU (Xeon 2.27 GHz).
> > 
> > I also implemented the decoding for 3P, but didn't test yet all reconstruction cases. There is probably room for improvements using AVX support for XOR operations in both implementations.
> > 
> > Before I invest more time, do think it is useful to have this fast 3P algorithm for double disk failures with 100% space overhead? Because I believe that people will always optimize for space and would rather use something like (10,2) even if the performance degrades and CPU consumption goes up?!? Let me know, no problem in any case!
> > 
> > Finally I tested some combinations for ErasureCodeJerasureReedSolomonRAID6:
> > 
> > (3,2) (4,2) (6,2) (8,2) (10,2) they all run around 780-800 MB/s
> > 
> > Cheers Andreas.
> > 
> > 
> > 
> > 
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
