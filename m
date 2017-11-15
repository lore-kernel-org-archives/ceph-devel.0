From: Sage Weil <sage@newdream.net>
Subject: Re: config on mons
Date: Wed, 15 Nov 2017 21:26:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711151855430.28240@piezo.novalocal>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal> <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com> <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal>
 <20171115171637.ycmpu4ovmp4laz5l@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:48858 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757776AbdKOV0W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Nov 2017 16:26:22 -0500
In-Reply-To: <20171115171637.ycmpu4ovmp4laz5l@suse.com>
Content-ID: <alpine.DEB.2.11.1711152115571.28240@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 15 Nov 2017, Lars Marowsky-Bree wrote:
> On 2017-11-15T13:32:55, Sage Weil <sage@newdream.net> wrote:
> > > > 1- a default value (compiled in)
> > > > 2- a value from the mon
> > > > 3- a value from ceph.conf
> > > > 4- a value set via command line, 'ceph tell', 'ceph daemon ... config set
> > > > ...', etc.
> 
> I'm opposed to 3 and 4.
> 
> I *can* see the need to override a value on a per-host or on a
> per-daemon instance basis (including combinations thereof, e.g., all
> OSDs on node X). (Back when, we also expected these to be way more
> frequently needed; to this day, I can count on my fingers the times I
> needed per-host overrides, I think; really the only use case where this
> happens more often are debug flags.)
> 
> But if you want any sort of consistency, those modify the settings in
> the respective map on the MON, and the daemon *then* gets that one from
> the single authoritative source of truth.

The problem is this makes the system more fragile, and with a 
complex distributed, and the types of things I've needed to diagnose and 
debug in the past, I am very nervous about taking away the ability to 
force a config value locally (e.g., via 'ceph daemon ...', when it is 
having trouble pulling config from the mon for whatever reason).

...

As far as broad principles go, I think we are mostly in alignment: (1) we 
want centrally managed config, (2) managed by the mons, for (3) a 
simplified user experience, and (4) an easy upgrade path to get there.  
I think the implementation required to get that is roughly what I 
described, and although it sounds complicated, none of the key pieces can 
really be taken away.

1. Daemons report running config to mgr.  We need some form of this no 
matter what for the upgrade/transition.  Beyond that, I think it's still 
important in order to tell whether the "single source of truth" is 
something that even can be true: (1) some options cannot be changed at 
runtime and require a restart, (2) some options may have illegal/invalid 
values, (3) the set of allowed options may change build to build, so 
something that used to valid may not be anymore or may not be if the 
daemon is newer or older than the mon.

2. Local overrides are possible.  This can/should be rare and reserved 
for extraordinary circumstances, but I don't feel comfortable removing 
this.  In a complex there are many things that could prevent the daemon 
from speaking to the mon to get an updated config.

3. ceph.conf is allowed in at least some cases.  This is more or less a 
given on the mon in order to handle bootstraping and to resolve bad 
changes to the mon config (that, say, break paxos itself).  There are also 
still cases where initial options are needed to fetch the rest of the 
config from the mon.  And during the transition period it is required.

I think the real question is whether, post-nautilus, we continue to 
encourage or allow ceph.conf for daemons.  I think this is a decision that 
amounts to turning it off in certain circumstances to force users into a 
better world, but it's not something we can do away with to simplify the 
world today.  We can still ignore this possibility from the GUI, perhaps, 
but I think we're better off lumping it together with #2 and doing 
something extremely simple like, say, putting a (!) icon next to options 
that the daemon isn't respecting (because they have overridden it, or need 
to restart, or it is not valid, or whatever else).

I can't see a way to change 1-3 above without a very different approach 
(like, using something external to the mons).  Am I missing something?

sage
