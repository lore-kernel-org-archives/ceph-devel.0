From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: RBD mirroring design draft
Date: Wed, 13 May 2015 21:21:48 -0700
Message-ID: <555422DC.6050400@redhat.com>
References: <55529E04.1070202@redhat.com> <CACJqLyZA2+eXd=cqDwYOyqeE+O+kovHOF=HavGp=SWkrJ-LgVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbbENEVt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 00:21:49 -0400
In-Reply-To: <CACJqLyZA2+eXd=cqDwYOyqeE+O+kovHOF=HavGp=SWkrJ-LgVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/13/2015 01:07 AM, Haomai Wang wrote:
> On Wed, May 13, 2015 at 8:42 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>> Some other possible optimizations:
>> * reading a large window of the journal to coalesce overlapping writes
>> * decoupling reading from the leader zone and writing to follower zones,
>> to allow optimizations like compression of the journal or other
>> transforms as data is sent, and relaxing the requirement for one node
>> to be directly connected to more than one ceph cluster
>
> Maybe we could add separate NIC/network support which only used to
> write journaling data to journaling pool? From my mind, a multi-site
> cluster always need another low-latency fiber.

Yeah, this seems desirable. It seems like it'd be possible based on the 
way the NICs and routing tables are setup, without needing any special
configuration from ceph, or am I missing something?

>> Failover
>> --------
>>
>> Watch/notify could also be used (via a predetermined object) to
>> communicate with rbd-mirror processes to get sync status from each,
>> and for managing failover.
>>
>> Failing over means preventing changes in the original leader zone, and
>> making the new leader zone writeable. The state of a zone (read-only vs
>> writeable) could be stored in a zone's metadata in rados to represent
>> this, and images with the journal feature bit could check this before
>> being opened read/write for safety. To make it race-proof, the zone
>> state can be a tri-state - read-only, read-write, or changing.
>>
>> In the original leader zone, if it is still running, the zone would be
>> set to read-only mode and all clients could be blacklisted to avoid
>> creating too much divergent history to rollback later.
>>
>> In the new leader zone, the zone's state would be set to 'changing',
>> and rbd-mirror processes would be told to stop copying from the
>> original leader and close the images they were mirroring to.  New
>> rbd-mirror processes should refuse to start mirroring when the zone is
>> not read-only. Once the mirroring processes have stopped, the zone
>> could be set to read-write, and begin normal usage.
>>
>> Failback
>> ^^^^^^^^
>>
>> In this scenario, after failing over, the original leader zone (A)
>> starts running again, but needs to catch up to the current leader
>> (B). At a high level, this involves syncing up the image by rolling
>> back the updates in A past the point B synced to as noted in an
>> images's journal in A, and mirroring all the changes since then from
>> B.
>>
>> This would need to be an offline operation, since at some point
>> B would need to go read-only before A goes read-write. Making this
>> transition online is outside the scope of mirroring for now, since it
>> would require another level of indirection for rbd users like QEMU.
>
> So do you mean when primary zone failed we need to switch primary zone
> offline by hand?

I think we'd want to have some higher-level script controlling it, with
a pluggable trigger that could be based on user-defined monitoring.

This is something I'm less sure of though, it'd be good to get more
feedback on what users are interested in here. Would ceph detecting 
failure based on e.g. rbd-mirror timing out reads from the leader zone
be good enough for most users?
