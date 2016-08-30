From: Sage Weil <sage@newdream.net>
Subject: Re: SIMD accelerated crush_do_rule proof of concept
Date: Tue, 30 Aug 2016 16:53:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608301644200.24244@piezo.us.to>
References: <57C41F9E.7090309@dachary.org> <20160830132456.GE10692@predictor>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-600566478-1472576026=:24244"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53833 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756527AbcH3Qxr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2016 12:53:47 -0400
In-Reply-To: <20160830132456.GE10692@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-600566478-1472576026=:24244
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2016, Piotr Dałek wrote:
> On Mon, Aug 29, 2016 at 01:42:22PM +0200, Loic Dachary wrote:
> > Hi,
> > 
> > TL;DR: crush_do_rule using SIMD goes twice faster, the implementation is straightforward and would help with crushmap validation, is there any reason not to do it ?
> > 
> > When resolving a crush rule (crush_do_rule in mapper.c), the straw2 function (bucket_straw2_choose) calls the hashing function (crush_hash32_3) for each item in a bucket and keeps the best match. When a bucket has four items, the hash function can be run using SIMD instructions. Each item value is 32 bits and four can fit in a __m128i.
> > 
> > I tried to inline the hash function when the conditions are right[1] and run a test to measure the difference.
> > 
> > crushtool -o /tmp/t.map --num_osds 1024 --build node straw2 8 datacenter straw2 4 root straw2 0
> > time crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 2048000 --num-rep 4
> > rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4
> > rule 0 (replicated_ruleset) num_rep 4 result size == 4:	2048000/2048000
> > 
> > With SIMD
> > 
> > real	0m10.433s
> > user	0m10.428s
> > sys	0m0.000s
> > 
> > Without SIMD
> > 
> > real	0m19.344s
> > user	0m19.340s
> > sys	0m0.004s
> > 
> > Callgrind estimated cycles for each crush_do_rule are in the same range:
> > 
> > rm crush.callgrind ; valgrind --tool=callgrind --callgrind-out-file=crush.callgrind crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 204800 --num-rep 4
> > kcachegrind crush.callgrind
> > 
> > With SIMD    : crush_do_rule is estimated to use 21 205 cycles
> > Without SIMD : crush_do_rule is estimated to use 53 068 cycles
> > 
> > This proof of concept relies on instructions that are available on all ARM & Intel processors, nothing complicated is going on. It is beneficial to crush maps that have more than four disks per host, more than four hosts per rack etc. It probably is a small win for an OSD or even a client. For crushmap validation it helps significantly since the MON are not able to run crushtool asynchronously and it needs to run within a few seconds (because it blocks the MON).
> > 
> > The implementation is straightforward: it needs sub/xor/lshift/rshift. The only relatively tricky part is runtime / compile time detection of the SIMD instructions for both Intel and ARM processors. Luckily this has already been taken care of when integrating with the jerasure erasure code plugin.
> > 
> > Is there any reason why it would not be good to implement this ?
> 
> I like this and I hope you'll be able to get it into master. I was wondering
> if straw2 can be optimized further and realized that crush_ln() looks quite
> expensive. I did some basic statistics and it looks like that crush_ln
> accepts inputs in 0-65535 range, making lookup table solution feasible.
> I tried it out:
> 
> Original:
> 
> [branch@localhost bin]$ time ./crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 2048000 --num-rep 4                                                                                                                
> rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4                                                                       
> rule 0 (replicated_ruleset) num_rep 4 result size == 4: 2048000/2048000                                                          
>                                                                                                                                  
> real    0m25.635s                                                                                                                
> user    0m25.553s                                                                                                                
> sys     0m0.072s                                                                                                                 
> 
> Loic's SIMD:
> 
> [branch@localhost bin]$ time ./crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 2048000 --num-rep 4                                                                                                                
> rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4                                                                       
> rule 0 (replicated_ruleset) num_rep 4 result size == 4: 2048000/2048000                                                          
>                                                                                                                                  
> real    0m15.292s                                                                                                                
> user    0m15.227s                                                                                                                
> sys     0m0.056s        
> 
> +Crush LN cache:
> 
> [branch@localhost bin]$ time ./crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 2048000 --num-rep 4                                                                                                                
> rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4                                                                       
> rule 0 (replicated_ruleset) num_rep 4 result size == 4: 2048000/2048000                                                          
>                                                                                                                                  
> real    0m11.828s                                                                                                                
> user    0m11.746s                                                                                                                
> sys     0m0.078s
> 
> There's a drawback, too - 65536 of__u64's take 512KB of ram, so the question is
> - is it worth it...

I think it probably isn't, since we'll miss the CPU cache and have to 
fetch from DRAM.  But we have a pretty long discussion about this here

http://www.spinics.net/lists/ceph-devel/msg21635.html

and then Xiaoxi at Intel came up with the current implementation 
(replacing my original lookup table).

http://www.spinics.net/lists/ceph-devel/msg22094.html

I don't remember the specifics unfortunately...
sage
--8323329-600566478-1472576026=:24244--
