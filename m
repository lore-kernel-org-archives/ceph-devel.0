From: Anders Saaby <anders@saaby.com>
Subject: Re: placement group sizing
Date: Fri, 26 Apr 2013 19:07:13 +0200
Message-ID: <BE9322CA-90F7-4D71-9EB0-6FD7FA61E4AD@saaby.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com> <517A718E.2000203@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([95.170.88.191]:46078 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab3DZRHT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 13:07:19 -0400
In-Reply-To: <517A718E.2000203@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 26/04/2013, at 14.22, Wido den Hollander <wido@42on.com> wrote:
> Hello,
> 
> On 04/25/2013 02:39 PM, Anders Saaby wrote:
>> Hi,
>> 
>> We are working on prototype infrastructure for RADOS clusters, and are now ready to deploy the first production size storage pool. One question remains; How many placement groups will we need, balancing memory footprint and ability to level data placement and data reads. - And still keeping stuff within sane limits.
>> 
>> Our initial plan is to deploy 4PB pools, based on 4TB drives with 3 replicas (One OSD/disk). So, 3.000 disks per pool.
>> 
>> Acording to the documentation 1), we should have: 3.000 OSDs * 100 / 3 replicas == 100.000 placement groups.
>> 
>> From the maillist, 100.000 PG's is way more than I have seen, so, do you have any insights and advises on pg_num for a RADOS pool with these characteristics? Also, will it be a problem with a pg_num size this bit, if the pool is started out with only ~100 OSDs, and then grown to 3.000.
>> 
> 
> While the example says 100, the text above it says:
> 
> "We recommend approximately 50-100 placement groups per OSD to balance out memory and CPU requirements and per-OSD load"
> 
> So the question is, what is the workload going to be? What kind of data are you going to store? Will this be something with RBD or will it be a plain RADOS store?

Right. Here goes;

Workload will come from one of our applications using librados directly, so no RBD, no FS and no gateways. Low velocity I/O, should be well within SATA limits.

> How many OSDs per machine do you have and how much memory do you have per machine?

12 OSD's per machine. A bit over 1GB memory per OSD. (16GB per machine)

> The more PGs you have, the more peering PGs you will have when an OSD boots again, so that could be heavy for the CPU in the machines.

Right.

> The question also is, how many pools are you expecting? If you start creating 10 pools with 100.000 pgs each you'd get an insane amount of PGs.

Plan is, for now, to only have one pool (4PB) per cluster, and then just scale with the appropriate amount of clusters.

Our initial guesses for pgs, is in the 40K-64K range, that should give us the balancing we need, but we are not sure that is within sane memory consumption ranges.


best regards,
Anders