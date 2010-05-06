From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 14:02:40 -0700 (PDT)
Message-ID: <190959.13001.qm@web36108.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36108.mail.mud.yahoo.com ([66.163.179.222]:25070 "HELO
	web36108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751203Ab0EFVCm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:02:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

--- On Thu, 5/6/10, Sage Weil <sage@newdream.net> wrote:

> > -Also, can reads be spreadout over replicas?
> > 
> > This might be a nice optimization to reduce seek
> > times under certain conditions, when there are no
> > writers or the writer is the only reader (and thus
> > is aware of all the writes even before they complete).  
> > Under these conditions it seems like it
> > would be possible to not enforce the "tail reading"
> > order of replicas and thus additionally benefit
> > from "read stripping" across the replicas the way
> > many raid implementations do with RAID1.
> > 
> > I thought that this might be particularly useful
> > for RBD when it is used exclusively (say by mounting
> > a local FS)  since even with replicas, it seems like
> > it could then relax the replica tail reading 
> > constraint.
> 
> The idea certainly has it's appeal, and I played with it
> for a while a few years back.  At that time I had a
> _really_ hard time trying to manufacture a workload
>  scenario where it actually mades things faster
> and not slower.  In general, spreading out reads will
> pollute caches (e.g., spreading across two replicas means
> caches are half as effective).  

Hmm, I wonder if using a local FS on top of RBD would
be such a different use case from ceph that this may
not be very difficult to produce such a workload with.  
With a local FS on RBD I would expect massive local 
kernel level caching.  With this in mind I wonder how
effective OSD level caching would actually be.

I am particularly thinking of heavy seeky workloads 
which perhaps are somewhat already spreadout due to
stripping.  In other words RAID1 (mirroring) can 
decrease latencies over a non RAID setup locally even
though that is not the objective of RAID1, but does
RAID01 decrease latencies much over RAID0, maybe not?
That might explain the difficulty in creating such
a scenario.

To put this in the perspective of OSD setups, if you 
already have stripping, using the replicas also may 
not make much of a difference, but I wonder how a two
node OSD setup with double redundancy would fair?  
With such a setup there will not really be any 
stripping will there?  With such a setup (one that I 
can easily see being popular for simple/minimal RBD
redundancy setups), perhaps replica "stripping"
would help.  A 'smart' RBD could detect non 
contiguous reads and spread the reads out in that
case.

All theory I know, but it seems worth investigating 
various RBD specific workloads, at least for the 
RBD users/developers. :)


Also, with ceph many seeky workloads (small multi
file writes) might additionally already be spread 
out (and thus "stripped") due to CRUSH since they
are in different files.  But with RBD, it is all
one file so CRUSH will not help as much in this 
respect.



> What I tried to do was use fast heartbeats between OSDs to
> shared average request queue lengths, so that the primary 
> could 'shed' a read request to a replica if it's queue 
> length/request latency was significantly shorter.  
> I wasn't really able to make it work.

This sounds more 'intelligent" than what I was 
suggesting since it would take the status of the 
entire OSD cluster into account, not just the 
single RBD reads.
 
> For cold objects, shedding could help, but only if 
> there is a sufficient load disparity between replicas to 
> compensate for the overhead of shedding.

I could see how "shedding" as you mean it would 
add some overhead, but a simple client based 
fanout shouldn't really add much overhead.  You 
have designed CRUSH to allow fast direct IO with 
the OSDs, shedding seems to be a step backwards 
performance wise from this design, but client 
fanout to replicas directly is really not much 
different than stripping using CRUSH, it should 
be fast!

If this client fanout does help, one way to make
it smarter, or more cluster responsive would be
to expose some OSD queue/length info via the 
client APIs allowing clients themselves to do some
smart load balancing in these situations.  This 
could be applicable not just for seeky workloads, 
but also for unusual workloads which for some 
reason might bog down a particular OSD.  CRUSH
should normally prevent this from happening in
a well balanced cluster, but if a cluster is not
very heterogenous and has many OSD nodes with
varying latencies and perhaps other external
(non OSD) loads on them, your queue length idea 
with smart clients could help balance such a 
cluster on the clients themselves.

That's a lot of armchair talking I know, 
sorry. ;)  Thanks for listening...

-Martin




      
