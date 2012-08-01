From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: PG stuck stale
Date: Wed, 01 Aug 2012 11:41:02 -0700
Message-ID: <5019783E.4010705@inktank.com>
References: <CAF6-1L5R9DaP778-Wdcpni6C6KpYMd0t3zF9t91CLd5oqAW7ZA@mail.gmail.com> <50197493.1040805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47041 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab2HASlF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 14:41:05 -0400
Received: by pbbrp8 with SMTP id rp8so1484618pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 11:41:05 -0700 (PDT)
In-Reply-To: <50197493.1040805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On 08/01/2012 11:25 AM, Josh Durgin wrote:
> On 08/01/2012 08:12 AM, Sylvain Munaut wrote:
>> Hi,
>>
>> I'm doing a few tests on ceph (radosgw more precisely).
>>
>> One of the scenario I'm testing is:
>>   - A radogw bucket stored in a rados pool with size=1 (so no
>> replication)
>>   - Complete/Irrecoverable failure of an OSD ( osd.0 )
>>
>> Now obviously in that situation, some of the placement groups will be
>> completely lost and there will be no way to get the data back and I'm
>> OK with that.
>>
>> But my current issue is that after rebuilding a new osd.0 from
>> scratch, the PG that were previously on it and nowhere else are "stuck
>> stale" and I can't figure out how to tell it that it's OK to loose
>> those data but come back to HEALTHY ...
>
> Those pgs shouldn't be stale. How did you rebuild osd.0? Did you just
> redo ceph-osd --mkfs?
>
> The objects should show up as unfound in ceph -s, and then you can
> deal with them as described here:
>
> http://ceph.com/docs/master/ops/manage/failures/osd/#unfound-objects
>
>> I tried doing 'ceph osd lost 0' after I shut it down and before I
>> start it up from scratch again but that didn't change anything.
>
> This is probably not working due to the stale pgs. Stale means no osd
> is reporting anything about them, so they're probably not being updated
> and marked unfound.
>
>> So how can I make the cluster HEALTHY again ?

I didn't notice before, but since you only have 1 copy of the data,
no other osds will tell the new osd.0 that it should have those pgs.
That's why they're stale. You can force osd.0 to notice the pgs it needs
by running:

ceph pg force_create_pg <pgid>

for each pg that's mapped to osd.0 in 'ceph pg dump'.

Once those are all created, and recovery has noticed that those pgs are
all out of date, the mark_unfound_lost command should work.

Josh

>>
>> Cheers,
>>
>>      Sylvain

