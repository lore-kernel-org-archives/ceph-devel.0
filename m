From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: [ceph-users] v0.80 Firefly released
Date: Wed, 07 May 2014 14:18:27 -0400
Message-ID: <536A78F3.8020607@cloudapt.com>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>	<536A54C6.4060202@cern.ch> <CAPYLRzhyt3i0sXOGrqZxzrH02+VOjBeMS37xk8ua2K2C2oydkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34709 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaEGSSb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 14:18:31 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so1414583iec.36
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 11:18:30 -0700 (PDT)
In-Reply-To: <CAPYLRzhyt3i0sXOGrqZxzrH02+VOjBeMS37xk8ua2K2C2oydkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Dan van der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>


On 5/7/2014 11:53 AM, Gregory Farnum wrote:
> On Wed, May 7, 2014 at 8:44 AM, Dan van der Ster
> <daniel.vanderster@cern.ch> wrote:
>> Hi,
>>
>>
>> Sage Weil wrote:
>>
>> * *Primary affinity*: Ceph now has the ability to skew selection of
>>    OSDs as the "primary" copy, which allows the read workload to be
>>    cheaply skewed away from parts of the cluster without migrating any
>>    data.
>>
>>
>> Can you please elaborate a bit on this one? I found the blueprint [1] but
>> still don't quite understand how it works. Does this only change the crush
>> calculation for reads? i.e writes still go to the usual primary, but reads
>> are distributed across the replicas? If so, does this change the consistency
>> model in any way.
>
> It changes the calculation of who becomes the primary, and that
> primary serves both reads and writes. In slightly more depth:
> Previously, the primary has always been the first OSD chosen as a
> member of the PG.
> For erasure coding, we added the ability to specify a primary
> independent of the selection ordering. This was part of a broad set of
> changes to prevent moving the EC "shards" around between different
> members of the PG, and means that the primary might be the second OSD
> in the PG, or the fourth.
> Once this work existed, we realized that it might be useful in other
> cases, because primaries get more of the work for their PG (serving
> all reads, coordinating writes).
> So we added the ability to specify a "primary affinity", which is like
> the CRUSH weights but only impacts whether you become the primary. So
> if you have 3 OSDs that each have primary affinity = 1, it will behave
> as normal. If two have primary affinity = 0, the remaining OSD will be
> the primary. Etc.

Is it possible (and/or advisable) to set primary affinity low while 
backfilling / recovering an OSD in an effort to prevent unnecessary slow 
reads that could be directed to less busy replicas? I suppose if the 
cost of setting/unsetting primary affinity is low and clients are 
starved for reads during backfill/recovery from the osd in question, it 
could be a win.

Perhaps the workflow for maintenance on osd.0 would be something like:

- Stop osd.0, do some maintenance on osd.0
- Read primary affinity of osd.0, store it for later
- Set primary affinity on osd.0 to 0
- Start osd.0
- Enjoy a better backfill/recovery experience. RBD clients happier.
- Reset primary affinity on osd.0 to previous value

If the cost of setting primary affinity is low enough, perhaps this 
strategy could be automated by the ceph daemons.

Thanks,
Mike Dawson

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
