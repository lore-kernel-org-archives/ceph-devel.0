From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: crush rule definitions
Date: Wed, 04 May 2011 21:20:38 +0200
Message-ID: <4DC1A706.1000205@provocation.net>
References: <4DC197F3.3050200@provocation.net> <Pine.LNX.4.64.1105041119310.648@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:51553 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1EDTUr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 15:20:47 -0400
In-Reply-To: <Pine.LNX.4.64.1105041119310.648@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 05/04/2011 08:21 PM, Sage Weil wrote:

>> does "min_size 2, max_size 2" mean that I want "2 copies of the data on each
>> host" or "2 copies of the data in total in the entire cluster"?

> Neither, actually.  It means that this rule will be used when we ask crush 
> for ruleset 0 and 2 replicas.  If you change a pg to have 3x replication, 
> ceph will ask for ruleset 0 and 3 replicas, and this rule won't be used.

In other words, the total number of replicas in the cluster is determined on
the PG level? But then how do I control which PGs are physically stored where?

> You probably want min_size 1 and max_size 10.

Taking what you just wrote together with a re-reading of the wiki, I must admit
that I still don't quite grasp it. The wiki says

  That is, when placing object replicas, we start at the root hierarchy, and
  choose N items of type 'device'. ('0' means to grab however many replicas.
  The rules are written to be general for some range of N, 1-10 in this case.)

What I make out of all this is that

rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type device
        step emit
}

means that IF the PGs are set to create anything between 1 and 10 replicas, then
the replicas should be placed on devices, using an unlimited number of devices.

Is that correct?

My problem really is how to configure ceph to put exactly 1 replica of the data
(and metadata) on each and every of some kind of target. For example, if I have
10 racks, I want exactly 1 copy of the data in each rack, no more, no less (and
I don't care which host in that rack the data lands on). If I have 10 hosts,
I want exactly 1 copy of the data on each host (and I don't care which OSD on
that host the data lands on). If I only have 10 OSDs, I want exactly 1 copy of
the data on each and every OSD.

Assuming that the number of targets is fixed and known, what is the way to do
this?


And going back to PGs, if "ceph osd dump -o -|grep pg_size" says

 pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash rjenkins pg_num 128 pgp_num 128 lpg_num 2 lpgp_num 2 last_change 66 owner 0)

and "ceph -w" says

 pg v319405: 528 pgs: 528 active+clean; 22702 MB data, 77093 MB used, 346 GB / 446 GB avail

how do the 128 PGs of "ceph osd dump" relate to the 528 PGs of "ceph -w"?

*

As an aside, I think that, to a certain extent, improving the documentation could
contribute more to the code base than improving the actual code. You guys spend a
lot of time answering the kind of questions that I've been posing (and thank you
for doing so), while at the same time missing out on the debugging help you could
be getting instead if your user base could move past its trivial problems. If I were
your scrum master, I'd dedicate an entire sprint on the wiki alone.

Z



