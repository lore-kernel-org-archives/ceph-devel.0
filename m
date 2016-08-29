From: Sage Weil <sage@newdream.net>
Subject: Re: SIMD accelerated crush_do_rule proof of concept
Date: Mon, 29 Aug 2016 13:57:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608291355550.24244@piezo.us.to>
References: <57C41F9E.7090309@dachary.org> <5b169584-0350-d232-0ef9-697e0d1b4e96@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46867 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756545AbcH2N5T (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 09:57:19 -0400
In-Reply-To: <5b169584-0350-d232-0ef9-697e0d1b4e96@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 29 Aug 2016, Mark Nelson wrote:
> Anything we can do to help on the CPU usage front is a win IMHO, though I
> would be interested in seeing an example where we are spending a lot of time
> on crush in a real usage scenario?

The monitor prime_pg_temp has to calculate a crush mapping for every PG 
when the osdmap changes in significant ways.  A 2x improvement there is a 
big help since the work has to be timeboxed and aborted if it runs too 
long.  Same goes for the crushtool test that runs whenever the crush map 
changes.

sage


> 
> Mark
> 
> On 08/29/2016 06:42 AM, Loic Dachary wrote:
> > Hi,
> > 
> > TL;DR: crush_do_rule using SIMD goes twice faster, the implementation is
> > straightforward and would help with crushmap validation, is there any reason
> > not to do it ?
> > 
> > When resolving a crush rule (crush_do_rule in mapper.c), the straw2 function
> > (bucket_straw2_choose) calls the hashing function (crush_hash32_3) for each
> > item in a bucket and keeps the best match. When a bucket has four items, the
> > hash function can be run using SIMD instructions. Each item value is 32 bits
> > and four can fit in a __m128i.
> > 
> > I tried to inline the hash function when the conditions are right[1] and run
> > a test to measure the difference.
> > 
> > crushtool -o /tmp/t.map --num_osds 1024 --build node straw2 8 datacenter
> > straw2 4 root straw2 0
> > time crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test
> > --rule 0 --min-x 1 --max-x 2048000 --num-rep 4
> > rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4
> > rule 0 (replicated_ruleset) num_rep 4 result size == 4:
> > 2048000/2048000
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
> > rm crush.callgrind ; valgrind --tool=callgrind
> > --callgrind-out-file=crush.callgrind crushtool -i /tmp/t.map
> > --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x
> > 204800 --num-rep 4
> > kcachegrind crush.callgrind
> > 
> > With SIMD    : crush_do_rule is estimated to use 21 205 cycles
> > Without SIMD : crush_do_rule is estimated to use 53 068 cycles
> > 
> > This proof of concept relies on instructions that are available on all ARM &
> > Intel processors, nothing complicated is going on. It is beneficial to crush
> > maps that have more than four disks per host, more than four hosts per rack
> > etc. It probably is a small win for an OSD or even a client. For crushmap
> > validation it helps significantly since the MON are not able to run
> > crushtool asynchronously and it needs to run within a few seconds (because
> > it blocks the MON).
> > 
> > The implementation is straightforward: it needs sub/xor/lshift/rshift. The
> > only relatively tricky part is runtime / compile time detection of the SIMD
> > instructions for both Intel and ARM processors. Luckily this has already
> > been taken care of when integrating with the jerasure erasure code plugin.
> > 
> > Is there any reason why it would not be good to implement this ?
> > 
> > Cheers
> > 
> > [1]
> > https://github.com/dachary/ceph/commit/71ae4584d9ed57f70aad718d0ffe206a01e91fef
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
