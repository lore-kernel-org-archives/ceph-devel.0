From: Sage Weil <sage@newdream.net>
Subject: Re: Single slow OSD can cause unfound object
Date: Thu, 13 Oct 2016 16:53:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610111935530.18626@piezo.us.to>
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl> <alpine.DEB.2.11.1610111340430.31080@piezo.us.to> <8b92ccce-1e31-7a0d-06d0-9126c3d02ffd@sadziu.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-546007032-1476214784=:18626"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50199 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbcJMQxd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 12:53:33 -0400
In-Reply-To: <8b92ccce-1e31-7a0d-06d0-9126c3d02ffd@sadziu.pl>
Content-ID: <alpine.DEB.2.11.1610131643300.19763@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <pawel@sadziu.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-546007032-1476214784=:18626
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1610131643301.19763@piezo.us.to>

On Tue, 11 Oct 2016, Pawe³ Sadowski wrote:
> Hi Sage,
> 
> W dniu 11.10.2016 o 15:45, Sage Weil pisze:
> 
> > Hi Pawel,
> > 
> > On Tue, 11 Oct 2016, Pawe³ Sadowski wrote:
> > > Hi,
> > > 
> > > I managed to trigger unfound objects on a pool with size 3 and min_size
> > > 2 just by removing 'slow' OSD (out and then stop) which is quite
> > > frightening. Shouldn't Ceph stop IO if there is only one copy in this
> > > case (even during recovery/peering/etc)? I'm able to reproduce this on
> > > Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So far I wasn't able to
> > > trigger this behavior by just stopping such OSD (still testing).
> > This is definitely concerning.  I have a couple questions...
> > 
> > 1. Looking at the log, I see that at one point all of the OSDs mark
> > themselves down, here:
> > 
> > 2016-10-11 08:46:23.473335 mon.0 10.99.128.50:6789/0 3275 : cluster [INF]
> > osd.1 marked itself down
> > 
> > Do you know why they do that?
> 
> It's probably due to load triggered by rebalance after marking OSD out.
> In other tests OSDs stayed up during this period. It didn't happen
> in my last test (logs posted via ceph-post-file).
> 
> > 2. Are you throttling the CPU on just a single OSD, or on a whole host?  I
> > also see that the monitors are calling elections.  (This shouldn't have
> > anything to do with the problem, but I'm not sure I understand the test
> > setup.)
> 
> I'm throttling CPU for single OSD process (in our production we had disk
> that was slowing down OSD). Monitors share device with one of the OSD.
> Sometimes election happens after marking OSD out, sometimes not. Probably
> caused by load on the underlaying device (didn't happen in last test).
> 
> > > Second thing: throttling mechanism is blocking recovery operations/whole
> > > OSD[4] when there is a lot of client requests for missing objects. I
> > > think it shouldn't be like that.
> > Yeah, there is a similar problem with a PG is inactive and requests pile
> > up, eventually preventing ops even on active PGs... and 'ceph tell $pgid
> > query' admin commands.  It's non-trivial to fix, though: we need a way to
> > inform the client that a PG or individual object is blocked so that they
> > stop sending requests... and then also a way to inform them that the PG is
> > unblocked so they can start again.
> 
> OK. Is it wise to increase this throttling limit and if yes how much?
> Anyway, in the end it'll probably just delay moment until OSD is blocked.

Yeah, I wouldn't increase it (at least not by much)... it'll just delay 
the inevitable.

> > > 1: logs from Jewel
> > > https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883
> > Do you mind reproducing this sequence with debug ms = 1, debug osd = 20,
> > and capture all of the OSD logs as well as the cluster ceph.log?  You can
> > send us the tarball with the ceph-post-file utility.
> 
> Sure. Gzipped logs are about ~2.7G, ceph-post-file id:
> 7e16f69e-c410-49c2-b11c-e727854ce7b3

Thanks!  I took a look at this and I see what is going on.  
It's... subtle.

Initially the PG is, say, OSDs [1,2,3].  We are writing a sequence of 
updates to existing objects.  Eventually we mark osd.1 out.  At that point 
we have

osd.1: object A version '23 in flight to disk and replicas
osd.2,3: object A version '22 (hasn't gotten replicated write yet)

If osds 2 and 3 learn about the new osdmap (osd.1 is out) before osd.1, 
they will toss the replicate write away when they get it (they've already 
moved on and are part of the way through peering in the new [2,3] 
interval.  And during peering they learn from osd.1 that it has a newer 
version of the object, '23.  They assume this is the best one and include 
the '23 write as part of the official history.

All is well as long as osd.1 stays alive long enough for them to also 
fetch version '23 of the object.  If osd.1 is then killed before that 
happens, though, we are in the situation where osds [2,3] know there was a 
newer write but there is no longer a copy available.

Since the '23 didn't actually complete (all replicas didn't commit it 
so the client didn't get an ack) it is equally valid for us to throw it 
out and say that '22 is the "official" version.  But if we do that we 
could fall into a similar situation where, say, osd.1 and osd.3 had 
'23 and osd.2 had '22, we chose '22, osd.1 and 3 throw away their 
'divergent' '23, but then osd.2 fails before we copy '22 around.

Somewhere in there is a better strategy that recognizes that either 
version is okay and either picks the official version that is least likely 
to lead to one of these failure cases *or* adds some complicated logic to 
record that either is okay and adjust the official record 
as-needed if one of those failure situations comes up.

For now, the way to address this is to do the mark-unfound-revert thing, 
which takes you from a situation where the history says '22 was modified 
to get '23 but you don't have a '23 copy (only '22's).  This is a manual 
admin intervention, but it's generally safe and is designed to handle 
exactly this case.

Perhaps the simplest improvement would be to automatically recognized 
that the '23 version was never acked to the client and automatic revert 
to '22 is safe...

Sam's on vacation, but I suspect he'll have some additional thoughts on 
this when he gets back next week!

sage



> 
> > Thanks!
> > sage
> > 
> > > 2: steps to reproduce
> > >   - put some load on the cluster (run FIO with high iodepth)
> > >   - slow down single OSD (in my case reduce CPU time using cgroups:
> > > cpu.cfs_quota_us 15000)
> > >   - sleep 120
> > >   - ceph osd out 6
> > >   - sleep 15
> > >   - stop ceph-osd id=6
> > >   - unfound objects appear
> > > 
> > > This is not 100% reproducible but in my test lab (9 OSDs) I'm able to
> > > trigger this very easily.
> > > 
> > > 3:
> > > mon-01:~ # ceph osd pool get rbd size
> > > size: 3
> > > mon-01:~ # ceph osd pool get rbd min_size
> > > min_size: 2
> > > mon-01:~ # ceph --version
> > > ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)
> > > 
> > > 4:
> > > perf dump | grep -A 2 'throttle-osd_client_messages'
> > >      "throttle-osd_client_messages": {
> > >          "val": 100,
> > >          "max": 100,
> > > 
> > > ops_in_flight:
> > > https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea
> 
> Thanks!
> 
> 
> -- 
> PS
> 
> 
--8323329-546007032-1476214784=:18626--
