From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: RBD mirroring design draft
Date: Wed, 20 May 2015 14:30:00 -0700
Message-ID: <555CFCD8.5060404@redhat.com>
References: <55529E04.1070202@redhat.com>	<CACJqLyZA2+eXd=cqDwYOyqeE+O+kovHOF=HavGp=SWkrJ-LgVw@mail.gmail.com>	<555422DC.6050400@redhat.com> <CAAW3nmh+XxB8K2XsWgnD_cWWPZGw=VpsuomodMM1SNad8LmZAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbbETVaJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 May 2015 17:30:09 -0400
In-Reply-To: <CAAW3nmh+XxB8K2XsWgnD_cWWPZGw=VpsuomodMM1SNad8LmZAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris H <fuzz19881@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/18/2015 09:22 AM, Chris H wrote:
> I am actually working on something very similar to this for another
> project. Writing very small sequential IO groups with flushes to the
> "cloud" is very slow. The structure I am working on is nearly identical
> as well (I originally did padding, but might be not be necessary). My
> updating structure is a bit different. The server not the client will
> know what is in the log and what is in the "cloud". It will be complex
> to organize reads and writes to multiple chunks that reside in memory or
> the cloud, but doable.

Yeah, it's a lot simpler when the only client using the data is the one
keeping track of whether it's written back yet.

> Some ideas I had further for this project (And directly relates to this
> thread) is to incorporate some sort of HA setup too. It would have
> various checks to see if certain servers are up, certain daemons are
> running (And working correctly). Also, a single NIC port would be
> dedicated to writing to it's partner's LOG and to receive it's partners
> LOG. This is to ensure there's no stale data upon a failure/crash to
> eliminate a single point of failure.
>
> How long are the rbd-mirror time outs usually? The reason I ask is our
> potential use case is to use a parallel FS on top of RBD. I'd love to
> continue this discussion further.

The timeout would be configurable, but perhaps 30s by default? Ideally
other checks would be done too, so you don't fail over just because the 
connection between sites temporarily went away, but they're each still
operating correctly individually. This kind of higher-level monitoring 
info for each site's health could perhaps come from calamari.

Josh

> On Wed, May 13, 2015 at 10:21 PM, Josh Durgin <jdurgin@redhat.com
> <mailto:jdurgin@redhat.com>> wrote:
>
>     On 05/13/2015 01:07 AM, Haomai Wang wrote:
>
>         On Wed, May 13, 2015 at 8:42 AM, Josh Durgin <jdurgin@redhat.com
>         <mailto:jdurgin@redhat.com>> wrote:
>
>             Some other possible optimizations:
>             * reading a large window of the journal to coalesce
>             overlapping writes
>             * decoupling reading from the leader zone and writing to
>             follower zones,
>             to allow optimizations like compression of the journal or other
>             transforms as data is sent, and relaxing the requirement for
>             one node
>             to be directly connected to more than one ceph cluster
>
>
>         Maybe we could add separate NIC/network support which only used to
>         write journaling data to journaling pool? From my mind, a multi-site
>         cluster always need another low-latency fiber.
>
>
>     Yeah, this seems desirable. It seems like it'd be possible based on
>     the way the NICs and routing tables are setup, without needing any
>     special
>     configuration from ceph, or am I missing something?
>
>
>             Failover
>             --------
>
>             Watch/notify could also be used (via a predetermined object) to
>             communicate with rbd-mirror processes to get sync status
>             from each,
>             and for managing failover.
>
>             Failing over means preventing changes in the original leader
>             zone, and
>             making the new leader zone writeable. The state of a zone
>             (read-only vs
>             writeable) could be stored in a zone's metadata in rados to
>             represent
>             this, and images with the journal feature bit could check
>             this before
>             being opened read/write for safety. To make it race-proof,
>             the zone
>             state can be a tri-state - read-only, read-write, or changing.
>
>             In the original leader zone, if it is still running, the
>             zone would be
>             set to read-only mode and all clients could be blacklisted
>             to avoid
>             creating too much divergent history to rollback later.
>
>             In the new leader zone, the zone's state would be set to
>             'changing',
>             and rbd-mirror processes would be told to stop copying from the
>             original leader and close the images they were mirroring
>             to.  New
>             rbd-mirror processes should refuse to start mirroring when
>             the zone is
>             not read-only. Once the mirroring processes have stopped,
>             the zone
>             could be set to read-write, and begin normal usage.
>
>             Failback
>             ^^^^^^^^
>
>             In this scenario, after failing over, the original leader
>             zone (A)
>             starts running again, but needs to catch up to the current
>             leader
>             (B). At a high level, this involves syncing up the image by
>             rolling
>             back the updates in A past the point B synced to as noted in an
>             images's journal in A, and mirroring all the changes since
>             then from
>             B.
>
>             This would need to be an offline operation, since at some point
>             B would need to go read-only before A goes read-write.
>             Making this
>             transition online is outside the scope of mirroring for now,
>             since it
>             would require another level of indirection for rbd users
>             like QEMU.
>
>
>         So do you mean when primary zone failed we need to switch
>         primary zone
>         offline by hand?
>
>
>     I think we'd want to have some higher-level script controlling it, with
>     a pluggable trigger that could be based on user-defined monitoring.
>
>     This is something I'm less sure of though, it'd be good to get more
>     feedback on what users are interested in here. Would ceph detecting
>     failure based on e.g. rbd-mirror timing out reads from the leader zone
>     be good enough for most users?
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>

