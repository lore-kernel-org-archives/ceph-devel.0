From: "Curley, Matthew" <matthew.curley@hpe.com>
Subject: RE: Reproducing allocator performance differences
Date: Tue, 13 Oct 2015 23:32:01 +0000
Message-ID: <E011655B53F0CC41BB273E3A0B53F14409B88A37@G2W2527.americas.hpqcorp.net>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
 <560D6ADA.4000107@redhat.com>
 <E011655B53F0CC41BB273E3A0B53F14409B74ACF@G1W3777.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:31153 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbJMXfr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 19:35:47 -0400
Received: from g1t5425.austin.hp.com (g1t5425.austin.hp.com [15.216.225.55])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id BC540EB3
	for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 23:35:46 +0000 (UTC)
In-Reply-To: <E011655B53F0CC41BB273E3A0B53F14409B74ACF@G1W3777.americas.hpqcorp.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Got a pass of results out here:
https://drive.google.com/file/d/0B2kp18maR7axRmdVZGMyckRYc0k/view?usp=sharing

Bringing the config closer to the memory per OSD ratio Mark used and fiorbd + multiple block devices per client does appear to reproduce significant performance differences under load.  For random read anyway, the testing we did didn't show much difference on writes.  Still not seeing hackathon 700k+ IOPs, but I didn't really expect that :)

Would be interested in any further feedback, also on how the impact of any allocator changes from today's model is meaningful.  Clearly there appear to be cases where we're not seeing a difference with Hammer tcmalloc vs jemalloc, but is it always just a matter of time before degradation kicks in?  Or, do the changes not really impact certain configurations/data sets?

Thanks for the help!
-- MC

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Curley, Matthew
Sent: Thursday, October 01, 2015 1:09 PM
To: Mark Nelson; ceph-devel@vger.kernel.org
Subject: RE: Reproducing allocator performance differences

Thanks a bunch for the feedback Mark.  I'll push this back to the guy doing the test runs and get more data, including the writes.

Some responses:
* There's definitely a fair amount of CPU available even at higher queue depths, but I don't have current results.  I'll get a colmux grab for a representative sample.

* We did try fio with librbd (and multiple block devices/workers per client) previously on a different rig, what we saw was no real benefit over kernel + libaio.  We'll get concrete data on this rig though.

* Yes on fio with direct I/O, yes on the pre-fill, and yes on the drop cache (with a 3).  Not dropping cache has actually caused some frustrating results inconsistency, but that's a whole different topic.

* For these results--especially with more outstanding I/O--you definitely run completely out of page cache pretty quickly and see almost nothing at the NVMe device.  I was less worried for this particular test since we were after demonstrating a % shift in processing efficiency at the OSD rather than accurate representation of the backing storage, but correct me if that's a poor assumption here.  

* We'll try to track more closely to your memory per OSD ratio. When we shift the block devices size and reduce the kernel memory to force a % of I/O to not come from page cache you definitely see a lowering in overall performance (about 70K IOPS between lowest and highest results, for consistent queue depth and client count).  

--MC

On 10/01/2015 10:32 AM, Curley, Matthew wrote:
> We've been trying to reproduce the allocator performance impact on 4K random reads seen in the Hackathon (and more recent tests).  At this point though, we're not seeing any significant difference between tcmalloc and jemalloc so we're looking for thoughts on what we're doing wrong.  Or at least some suggestions to try out.
>
> More detail here:
> https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?usp=
> sharing
>
> Thanks for any input!

Hi Mathew,

I can point out a couple of differences in our setups:

1) I have 4 NVMe cards with 4 OSDs per card in each node, ie 16 OSDs total per node.  I'm also running the fio processes on the same nodes as the OSDs, so there is far less CPU available per OSD in my setup.

2) You have more memory per node than I do (and far more memory per OSD)

3) I'm using fio with the librbd engine, not fio+libaio on kernel RBD. 
It would be interesting to know if if this is having an effect.

4) I'm using RBD cache (and allowing writeback before flush)

5) I'm not using nobarriers

I suspect that in my setup I am very much bound by things other than the NVMe cards.  I think we should look at this in terms of per-node throughput rather than per-OSD.  What I find very interesting is that you are seeing much higher per-node tcmalloc performance than I am but fairly similar per-node jemalloc performance.  For 4K random reads I saw about 14K random read IOPs per node for tcmalloc+32MB TC and around 40K IOPS per node with tcmalloc+128MB tc or jemalloc.  It appears to me that for both tcmalloc and jemalloc you saw around 50K IOPS per node in the 4 OSD per card case.

A couple of thoughts:

1) Did you happen to record any CPU usage data during your tests? 
Perhaps with only 4 OSDs per node there is less CPU contention.

2) Did you test 4K random writes?  It would be interesting to see if those results show the same behavior.

3) I'm going to assume that since you saw differences in performance with different queue depths that this is O_DIRECT?  Did you sync/drop cache on the OSDs before the tests?  Was the data pre-filled on the RBD volumes?

4) Even given the above, you have a lot more memory available for buffer cache.  Did you happen to look at how many of the IOs were actually hitting the NVMe devices?

Mark
