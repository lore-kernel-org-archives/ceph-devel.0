From: Sage Weil <sweil@redhat.com>
Subject: RE: FW: CURSH optimization for unbalanced pg distribution
Date: Thu, 11 Sep 2014 21:41:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409112122050.29849@cobra.newdream.net>
References: <51FC7A40FB29414D88A121A7FFEF9A4710DC2188@SHSMSX104.ccr.corp.intel.com> <53299E33.5060809@inktank.com> <alpine.DEB.2.00.1403190814520.316@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710DC3018@SHSMSX104.ccr.corp.intel.com>
 <540F0252.7040609@dachary.org> <51FC7A40FB29414D88A121A7FFEF9A4710F570D6@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1409091805530.17200@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710F5D3CF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34796 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaILEln (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 00:41:43 -0400
In-Reply-To: <51FC7A40FB29414D88A121A7FFEF9A4710F5D3CF@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "He, Yujie" <yujie.he@intel.com>

Hi,

This is pretty exciting.  I haven't read through all of it, but have 
some initial comments on the pps mapping portion.

On Wed, 10 Sep 2014, Zhang, Jian wrote:
> Thanks. 
> 
> Created a feature here: http://tracker.ceph.com/issues/9410, to include all the attachments. .
> http://tracker.ceph.com/attachments/download/1383/adaptive-crush-modify.patch
> http://tracker.ceph.com/attachments/download/1384/crush_proposals.pdf
> http://tracker.ceph.com/attachments/download/1385/crush_optimization.pdf
> 
> 
> Hi all,
>     Several months ago we met an issue of read performance issues (17% degradation) when working on ceph object storage performance evaluation with 10M objects (scaling from 10K objects to 1Million objects) , and found the root cause is unbalanced pg distribution among all osd disks, leading to unbalanced data distribution. We did some further investigation then and identified that CRUSH failed to map pgs evenly to each osd. Please refer to the attached pdf (crush_proposals) for details.
> 
> Key Message:
>     As mentioned in the attached pdf, we described possible optimization proposals (http://tracker.ceph.com/attachments/download/1384/crush_proposals.pdf) for CRUSH and got some feedback from community (http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/18979 ) . Sage suggested us take the idea of "Change placement strategy only for step of selecting devices from hosts", by adding a new bucket type called "linear", and applying a modulo-like hash function to this kind of buckets to achieve balanced distribution. We followed this suggestion and designed an optimized CRUSH algorithm, with new hash methods and an adaptive module. Please refer to the Design and Implementation part for details. We also wrote some POC for it, see the attached patch. And as a result, we got more than
  10% read performance improvement using the optimized CRUSH algorithm.
> 
> Design and Implementation:
> 1.Problem Identification
> 1.1 Input key (pps) space of CRUSH is not uniform
>     Since PG# on the nested devices of a host is not uniform even if we select the device using simple modulo operation, we decide to change the algorithm of hashing raw pg to pps.
> 1.2 Algorithm of selecting items from buckets is not uniform
>     After we get uniform input key space, we should make the procedure of selecting devices from host be uniform. Since current CRUSH algorithm uses Jenkins hash based strategies and failed to reach the goal, we decide to add a new bucket type and apply new (modulo based) hash algorithm to make it.
> 2.Design
> 2.1New pps hash algorithm
>     We design the new pps hash algorithm based on the "Congruential pseudo-random number generator" (http://comjnl.oxfordjournals.org/content/10/1/74.full.pdf) . It defines a bijection between the original sequence {0, ...,2^N-1} and some permutation of it. In other words, given different keys between 0 and 2^N-1, the generator will produce different integers, but within the same range {0,...,2^N-1}. 
>     Assume there are np PGs in a pool, we can regard pgid (0?pgid<2^n, np?2^n<2*np) as the key, and then it will be hashed into a pps value between 0 and 2^n-1. Since PG# in a pool is usually 2^N, the generator just shuffles the original pgid sequence as output in this case, making the key space consisting of a permutation of {0,...,2^n-1}, which achieves the best uniformity. Moreover, poolid can be regarded as a seed in the generator, producing different pps value even with the same pgid but different poolid. Therefore, pgid sequences of various pools are mapped into distinct pps sequences, getting rid of PG overlapping.

I made a few comments on github at

	https://github.com/ceph/ceph/pull/2402/files#r17462015

I have some questions about the underlying math.  If this is similar to 
the approach used by the uniform buckets, I think 1033 needs to be > the 
denominator?  Also, I looked a bit at the referenced paper and I think the 
denominator should be prime, not 2^n-1 (pg_num_mask).

My other concern is with raw_pg_to_congruential_pps.  Adding poolid into 
the numerator before you do the modulo means that each pool has a 
different permutation.  But, if you have two pools both with (say) 1024 
PGs, they will map to the same 1024 outputs (0..1023).  The pool is added 
in to the final pps, but this doesn't really help as it only means a 
handful of PGs get unique mappings... and they'll be overlap with the next 
pool.  This is exactly the problem we were solving with the HASHPSPOOL 
flag.  Perhaps adding a pseudorrandom value between 0 and 2^32 based on 
the poolid will (usually) give the pools distinct output ranges and the 
linear mapping will still be happy with that (since the inputs for each 
pool live in a contiguous range).

In any case, though, yes: this general approach will mean that the pps 
values live in a packed range instead of being spread uniformly across the 
0..2^32 range.

The other concern I have is whehter the pgid -> pps mapping is stable when 
pg_num is adjusted up.  Specifically, what we want is that when moving 
from pg_num to pg_num * 2, pg_num of the original inputs will keep the 
same output pps value, while the other half will get a new value.  It 
doesn't seem like this is true for this strategy.  That may be a tradeoff 
the user is willing to make, but we'll need to be very careful about 
making that apparent to the user.. it means that bumping pg_num will 
reshuffle all (not just half) of their data for each power of 2.

> 2.2 New bucket type, Linear
>     We introduce a new bucket type called "linear", and apply a new modulo based hash algorithm to it. As the pps values assigned to each host are a pseudo-random subset of the original permutation and is possibly out of uniformity, in which situation applying modulo operation directly on integers in the subset cannot produce balanced distribution among disks in the host. To decrease deviation of the subset, we apply a balance parameter 1/balance_param to the key before conducting the modulo method.
>     For osd failure and recovery, it assumes that items nested in this kind of bucket will not be removed, nor new items are added, same as the UNIFORM bucket. Linear host will not introduce more data movement than the uniform bucket.
> 2.3 Adaptive Strategy
>     Since there is no one constant balance parameter applying for all cases that will result in the best PG distribution. We make it an adaptive procedure by adjusting the balance parameter automatically during the preparation for creating a new pool, according to different cluster topology, PG# and replica#, in order to gain a most uniform distribution.
>     1) Try different balance_param when preparing for a new pool
>     a. Iteratively call CRUSH(map, ruleno, x, balance_param) to get corresponding PG distribution with different balance_params
> ??b. Calculate stdev of PG# among all osds
> ?  c. Choose the balance_param with the minimal stdev 
>  	2) Add a member variable to pool struct pg_pool_t to save the best balance_param value
>     The adaptive procedure can be described as following:
>     Input: cluster map, total PG number m, adaptive retry times n
>     Output: local optimal balance parameter balance_param min_pg_stdev = MAX; balance_param = a; // initial value for trial from 0 to n { 
>     for pgid from 0 to m {
>         calculate pps using the new generator in 2.1;
>         for bucket b in cluster map // apply CRUSH algorithm
>             apply corresponding bucket hashing algorithm and get a osd list for pgid
>     }
>     calculate pg_stdev_a by gathering all osd lists; // stdev of PG distribution among all osds
>     if pg_stdev_a < min_pg_stdev {
>         min_pg_stdev = pg_stdev_a;
>         balance_param = a; 
>     }
>     adjust a to a new value;
> }

I see the core placement is basically just x % n.  But there is the 
balance_param value (which is an integer value in the range 1..5?).  I 
don't really understand intuitively what this is accomplishing.  Is the 
goal just to have a different permutation and pick the best of 5?  Or is 
it specifically dividing the raw x so that it is squished into a narrower 
range that is accomplishing a more balance distribution?  I'm hoping the 
goal is just another permutation, because then we can modify x in some 
other way *prior* to feeding it into CRUSH and we can avoid duplicating 
half of the code in mapper.c just to pass down the extra argument.

Thanks!
sage


> Evaluation:
>     We evaluated the performance of optimized and current CRUSH in a cluster consisting of 4 hosts, and each attaching with 10x1T disks. We designed two test cases, for the first one, by creating a pool with 2048 pgs, 2 replicas, preparing 100 million 128KB objects, and then evaluating read performance of these objects; for the second one, by creating a pool with 2048 pgs, 3 replicas, preparing 1 million 10MB objects, and then evaluating read performance of these objects.
>     We compared the PG & data distribution and read performance of the two CRUSH algorithms, and got results as follows:
> 1.PG and data distribution is more balanced using optimized CRUSH algorithm
>     a) For 2048 PGs with 3 replicas, stdev of PG# on 40 osds decreases from 12.13 to 5.17; for 2048 PGs with 2 replicas, stdev of PG# on 40 osds decreases from 10.09 to 6.50
>     b) For 1 million 10MB objects with 3 replicas, stdev of disk use% on 40 osds decreases from 0.068 to 0.026; for 100 million 128KB objects with 2 replicas, stdev of disk use% on 40 osds decreases from 0.067 to 0.042
> 2.Large scaled performance is improved since data distribution is more balanced
>     a) More than 10% performance improvement for 128K and 10M read
>     b) Write performance not impacted
> Detailed performance data can be found in the http://tracker.ceph.com/attachments/download/1385/crush_optimization.pdf .
> 
> We also created a pull request: https://github.com/ceph/ceph/pull/2402 
> 
> 
> Thanks
> Jian
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Wednesday, September 10, 2014 9:06 AM
> To: Zhang, Jian
> Cc: Loic Dachary; ceph-devel@vger.kernel.org; He, Yujie
> Subject: RE: FW: CURSH optimization for unbalanced pg distribution
> 
> The lists are rejecting the email because of the big attachments.  Send with links instead?
> 
> On Tue, 9 Sep 2014, Zhang, Jian wrote:
> 
> > Yujie sent out the following email yesterday, but it seems it was missed. Resending it. 
> > 
> > =============
> > Hi all,
> > ?  Several months ago we met an issue of read performance issues (17% degradation) when working on ceph object storage performance evaluation with 10M objects (scaling from 10K objects to 1Million objects) , and found the root cause is unbalanced pg distribution among all osd disks, leading to unbalanced data distribution. We did some further investigation then and identified that CRUSH failed to map pgs evenly to each osd. Please refer to the attached pdf (crush_proposals) for details.
> > 
> > Key Message:
> > ?  As mentioned in the attached pdf, we described possible optimization proposals for CRUSH and got some feedback from community (http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/18979) . Sage suggested us take the idea of "Change placement strategy only for step of selecting devices from hosts", by adding a new bucket type called ?linear?, and applying a modulo-like hash function to this kind of buckets to achieve balanced distribution. We followed this suggestion and designed an optimized CRUSH algorithm, with new hash methods and an adaptive module. Please refer to the Design and Implementation part for details. We also wrote some POC for it, see the attached patch. And as a result, we got more than 10% read performance improvement using the optimized CRUSH algorithm.
> > 
> > Design and Implementation:
> > 1.   Problem Identification
> > 1.1  Input key (pps) space of CRUSH is not uniform
> >     Since PG# on the nested devices of a host is not uniform even if we select the device using simple modulo operation, we decide to change the algorithm of hashing raw pg to pps.
> > 1.2  Algorithm of selecting items from buckets is not uniform
> >     After we get uniform input key space, we should make the procedure of selecting devices from host be uniform. Since current CRUSH algorithm uses Jenkins hash based strategies and failed to reach the goal, we decide to add a new bucket type and apply new (modulo based) hash algorithm to make it.
> > 2.   Design
> > 2.1  New pps hash algorithm
> >     We design the new pps hash algorithm based on the "Congruential pseudo-random number generator" (http://comjnl.oxfordjournals.org/content/10/1/74.full.pdf) . It defines a bijection between the original sequence {0, ...,2^N-1} and some permutation of it. In other words, given different keys between 0 and 2^N-1, the generator will produce different integers, but within the same range {0,...,2^N-1}. 
> >     Assume there are np PGs in a pool, we can regard pgid (0?pgid<2^n, np?2^n<2*np) as the key, and then it will be hashed into a pps value between 0 and 2^n-1. Since PG# in a pool is usually 2^N, the generator just shuffles the original pgid sequence as output in this case, making the key space consisting of a permutation of {0,...,2^n-1}, which achieves the best uniformity. Moreover, poolid can be regarded as a seed in the generator, producing different pps value even with the same pgid but different poolid. Therefore, pgid sequences of various pools are mapped into distinct pps sequences, getting rid of PG overlapping.
> > 2.2  New bucket type, Linear
> >     We introduce a new bucket type called "linear", and apply a new modulo based hash algorithm to it. As the pps values assigned to each host are a pseudo-random subset of the original permutation and is possibly out of uniformity, in which situation applying modulo operation directly on integers in the subset cannot produce balanced distribution among disks in the host. To decrease deviation of the subset, we apply a balance parameter 1/balance_param to the key before conducting the modulo method.
> >     For osd failure and recovery, it assumes that items nested in this kind of bucket will not be removed, nor new items are added, same as the UNIFORM bucket. Linear host will not introduce more data movement than the uniform bucket.
> > 2.3  Adaptive Strategy
> >     Since there is no one constant balance parameter applying for all cases that will result in the best PG distribution. We make it an adaptive procedure by adjusting the balance parameter automatically during the preparation for creating a new pool, according to different cluster topology, PG# and replica#, in order to gain a most uniform distribution.
> > ??1) Try different balance_param when preparing for a new pool
> > ????- Iteratively call CRUSH(map, ruleno, x, balance_param) to get 
> > corresponding PG distribution with different balance_params
> > ????- Calculate stdev of PG# among all osds
> > ????- Choose the balance_param with the minimal stdev 
> >  	2) Add a member variable to pool struct pg_pool_t to save the best 
> > balance_param value ??The adaptive procedure can be described as following:
> > Input: cluster map, total PG number m, adaptive retry times n
> > Output: local optimal balance parameter balance_param min_pg_stdev = MAX; balance_param = a; // initial value for trial from 0 to n { 
> >     for pgid from 0 to m {
> >         calculate pps using the new generator in 2.1;
> >         for bucket b in cluster map // apply CRUSH algorithm
> >             apply corresponding bucket hashing algorithm and get a osd list for pgid
> >     }
> >     calculate pg_stdev_a by gathering all osd lists; // stdev of PG distribution among all osds
> >     if pg_stdev_a < min_pg_stdev {
> >         min_pg_stdev = pg_stdev_a;
> >         balance_param = a; 
> >     }
> >     adjust a to a new value;
> > }
> > 
> > 
> > Evaluation:
> >     We evaluated the performance of optimized and current CRUSH in a cluster consisting of 4 hosts, and each attaching with 10x1T disks. We designed two test cases, for the first one, by creating a pool with 2048 pgs, 2 replicas, preparing 100 million 128KB objects, and then evaluating read performance of these objects; for the second one, by creating a pool with 2048 pgs, 3 replicas, preparing 1 million 10MB objects, and then evaluating read performance of these objects.
> >     We compared the PG & data distribution and read performance of the two CRUSH algorithms, and got results as follows:
> > 1.   PG and data distribution is more balanced using optimized CRUSH algorithm
> > ??a) For 2048 PGs with 3 replicas, stdev of PG# on 40 osds decreases 
> > from 12.13 to 5.17; for 2048 PGs with 2 replicas, stdev of PG# on 40 
> > osds decreases from 10.09 to 6.50
> > ??b) For 1 million 10MB objects with 3 replicas, stdev of disk use% on 40 osds decreases from 0.068 to 0.026; for 100 million 128KB objects with 2 replicas, stdev of disk use% on 40 osds decreases from 0.067 to 0.042
> > 2.   Large scaled performance is improved since data distribution is more balanced
> > ??a) More than 10% performance improvement for 128K and 10M read
> > ??b) Write performance not impacted
> > Detailed performance data can be found in the attached pdf (crush_optimization).
> > 
> > We also created a pull request: https://github.com/ceph/ceph/pull/2402
> > 
> > Thanks
> > Jian
> > 
> > 
> > -----Original Message-----
> > From: Loic Dachary [mailto:loic@dachary.org]
> > Sent: Tuesday, September 09, 2014 9:36 PM
> > To: Zhang, Jian; ceph-devel@vger.kernel.org
> > Subject: Re: FW: CURSH optimization for unbalanced pg distribution
> > 
> > 
> > 
> > On 20/03/2014 04:54, Zhang, Jian wrote:
> > > Forwarding per Sage's suggestion. 
> > 
> > Very interesting discussion :-) For the record the corresponding pull 
> > request is https://github.com/ceph/ceph/pull/2402
> > 
> > > 
> > > 
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@inktank.com]
> > > Sent: Wednesday, March 19, 2014 11:29 PM
> > > To: Mark Nelson
> > > Cc: Zhang, Jian; Duan, Jiangang; He, Yujie
> > > Subject: Re: CURSH optimization for unbalanced pg distribution
> > > 
> > > On Wed, 19 Mar 2014, Mark Nelson wrote:
> > >> On 03/19/2014 03:24 AM, Zhang, Jian wrote:
> > >>> For more detail data, please refer to the *Testing results* part.
> > >>>
> > >>> *Optimization proposals: *
> > >>>
> > >>> After we dived into the source code of CRUSH and related papers, 
> > >>> we proposed two possible optimizations:
> > >>>
> > >>> 1.Add different hash algorithms, as an alternative for the 
> > >>> Jenkin's hash, e.g. algorithm that will produce even values when 
> > >>> range of input value (pg#) is relatively small. Or add new bucket 
> > >>> type at the same time if necessary.
> > > 
> > > This *might* work, but I don't have a strong intuition about it.  The modeling we've done now has essentially assumed a statistically uniform distribution, which has some inherent inbalance for low values of n (num pgs in our case).  I have generally assumed we can't do better than "random", and still have the other properties we want (independent, deterministic placement), but it may be possible.
> > > 
> > >>>
> > >>> 2.Find a better replica placement strategy instead of current 
> > >>> retry logic of crush_choose_firstn, which may cause CRUSH to behave badly.
> > >>>
> > >>> We find there are several threshold of retry times by referring to 
> > >>> code, choose_total_tries, choose_local_tries and choose_local_fallback_tries.
> > >>> They are used to decide whether to do a retry_bucket, 
> > >>> retry_descent or use permutation to do an exhaustive bucket 
> > >>> search. We are wondering if there is another retry strategy:
> > >>>
> > >>> a)Backtracking retry. Now the logic of crush_choose_firstn can 
> > >>> only issue an retry either from the initial bucket(retry_descent) 
> > >>> or from the current bucket (retry_bucket), how about retrying the intervening buckets?
> > >>>
> > >>> b)Adjust threshold of retry times by other values. We do noticed 
> > >>> that the 'optimal' crush tunable could be used to make it, but we 
> > >>> still encounter unbalanced [g distribution by using the optimal strategy.
> > >>> Please refer to 4 of the Testing results part.
> > >>>
> > >>> c)Add an mechanism that can adjust above mentioned thresholds 
> > >>> adaptively. Maybe we can record the retry times of the previous 
> > >>> call for CRUSH, and adjust retry thresholds automatically according to the record.
> > > 
> > > I suggest ignoring all of this retry logic.  The original version of 
> > > CRUSH has the local retries to try to make data move "less far", but 
> > > when we went back a year ago and did a statistical analysis of the 
> > > distribution we found that *all* of these hacks degraded the quality 
> > > of the placement,a nd by turning them all off (setting the 'optimal'
> > > values which zeroes them all out excent for total_retries) we got 
> > > something that was indistinguishable from a uniform distribution.
> > > 
> > >>> 3.Add soft link for pg directories. During pg creation, we can 
> > >>> create soft links for the pgs if pg# on the selected osd is more 
> > >>> than some threshold, say 10% more than desired average number, to 
> > >>> move objects that will be stored in this pg to another osd. 
> > >>> Balanced disk utilization may be gained in this way.
> > > 
> > > I think you need to be careful, but yes, this is an option.  There 
> > > is a similar exception mechanism in place that is used for other 
> > > purposes and something similar could be done here.  The main 
> > > challenge will be in ensuring that the soft links/exceptions follow 
> > > the same overall policy that CRUSH does after the raw mapping is 
> > > performed.  This is an option, but I would put it toward the bottom of the list...
> > > 
> > >>> 4.Change placement strategy only for step of selecting devices 
> > >>> from hosts. We found in our testing results that pg distribution 
> > >>> was balanced among hosts, which is reasonable since pg# of each 
> > >>> host is above 1K (according to the current BKM that pg# per osd 
> > >>> should be about 100). So how about we apply CRUSH only on the 
> > >>> interval buckets and find another simple but more balanced method to choose osd from host?
> > > 
> > > This idea has a lot of potential.  For example:
> > > 
> > > If you know the chassis can hold 12 disks, you can force the bucket 
> > > size to twelve and somehow prevent users from adjusting the 
> > > structure of the tree.  Then you can use a simple mapping that is 
> > > truly flat (like a linear mapping, disk = x % num_disks) for that bucket/subtree.
> > > The downside of course is that if you remove a disk *everything* 
> > > reshuffles, hence some sort of guardrails to prevent a user from 
> > > inadvertantly doing that.  If a disk *does* fail, you just need to 
> > > make sure the disk is marked "out" but not removed from the CRUSH hierarchy and the normal retry will kick in.
> > > 
> > > Note that all this is reall doing is increasing the size of the "buckets" 
> > > that we are (pseudo)randomly distribution over.  It is still a 
> > > random/uniform distribution, but the N value is 12 times bigger (for 
> > > a
> > > 12 disk chassis) and as a result the variance is substantially lower.
> > > 
> > > I would suggest making a new bucket type that is called 'linear' and 
> > > does a simple modulo and trying this out.  We will need a bunch of 
> > > additional safety checks to help users avoid doing silly things 
> > > (like adjusting the number of items in the linear buckets, which 
> > > reshuffle
> > > everything) but that wouldn't be needed for an initial analysis of the performance impact.
> > > 
> > > Do you mind if we shift this thread over to ceph-devel?  I think 
> > > there are lots of people who would be interested in this discussion.  
> > > We can of course leave off your attachment if you prefer.
> > > 
> > > Thanks!
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > --
> > Lo?c Dachary, Artisan Logiciel Libre
> > 
> > 
> 
