From: Anders Saaby <anders@saaby.com>
Subject: Re: placement group sizing
Date: Fri, 26 Apr 2013 19:09:36 +0200
Message-ID: <8119AA08-0CA8-414E-B9B6-FD33C8588CBA@saaby.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com> <517A7E7C.8070602@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([95.170.88.191]:46091 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab3DZRJj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 13:09:39 -0400
In-Reply-To: <517A7E7C.8070602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 26/04/2013, at 15.17, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 04/25/2013 07:39 AM, Anders Saaby wrote:
>> Hi,
>> 
>> We are working on prototype infrastructure for RADOS clusters, and are now ready to deploy the first production size storage pool. One question remains; How many placement groups will we need, balancing memory footprint and ability to level data placement and data reads. - And still keeping stuff within sane limits.
>> 
>> Our initial plan is to deploy 4PB pools, based on 4TB drives with 3 replicas (One OSD/disk). So, 3.000 disks per pool.
>> 
>> Acording to the documentation 1), we should have: 3.000 OSDs * 100 / 3 replicas == 100.000 placement groups.
>> 
>> From the maillist, 100.000 PG's is way more than I have seen, so, do you have any insights and advises on pg_num for a RADOS pool with these characteristics? Also, will it be a problem with a pg_num size this bit, if the pool is started out with only ~100 OSDs, and then grown to 3.000.
> 
> I pretty regularly test single-mon configurations with 64k PGs.  ~100k PGs tends to be starting to get a bit intense, but with a larger mon cluster and some tweaking it should be doable.

OK, that sounds encouraging. So, 40K-64K pgs should be doable with ~1GB mem per OSD?

> I don't mean to push anything on you, but if you guys are really thinking about deploying multiple 4PB pools, you might want to talk to us about some kind of support/consulting agreement.  That's a lot of storage!


I agree.


best regards,
Anders


