From: Wido den Hollander <wido@42on.com>
Subject: Re: placement group sizing
Date: Fri, 26 Apr 2013 14:22:38 +0200
Message-ID: <517A718E.2000203@42on.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:34143 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab3DZMWk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Apr 2013 08:22:40 -0400
In-Reply-To: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anders Saaby <anders@saaby.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

On 04/25/2013 02:39 PM, Anders Saaby wrote:
> Hi,
>
> We are working on prototype infrastructure for RADOS clusters, and are now ready to deploy the first production size storage pool. One question remains; How many placement groups will we need, balancing memory footprint and ability to level data placement and data reads. - And still keeping stuff within sane limits.
>
> Our initial plan is to deploy 4PB pools, based on 4TB drives with 3 replicas (One OSD/disk). So, 3.000 disks per pool.
>
> Acording to the documentation 1), we should have: 3.000 OSDs * 100 / 3 replicas == 100.000 placement groups.
>
>  From the maillist, 100.000 PG's is way more than I have seen, so, do you have any insights and advises on pg_num for a RADOS pool with these characteristics? Also, will it be a problem with a pg_num size this bit, if the pool is started out with only ~100 OSDs, and then grown to 3.000.
>

While the example says 100, the text above it says:

"We recommend approximately 50-100 placement groups per OSD to balance 
out memory and CPU requirements and per-OSD load"

So the question is, what is the workload going to be? What kind of data 
are you going to store? Will this be something with RBD or will it be a 
plain RADOS store?

How many OSDs per machine do you have and how much memory do you have 
per machine?

The more PGs you have, the more peering PGs you will have when an OSD 
boots again, so that could be heavy for the CPU in the machines.

The question also is, how many pools are you expecting? If you start 
creating 10 pools with 100.000 pgs each you'd get an insane amount of PGs.

Could you shed some light on this?

Wido

>
> Thanks in advance,
> Anders
>
> 1: http://ceph.com/docs/master/rados/operations/placement-groups/
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
