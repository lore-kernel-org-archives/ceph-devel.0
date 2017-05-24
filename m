From: Sage Weil <sweil@redhat.com>
Subject: Re: Handling is_readable=0 periods in mon
Date: Wed, 24 May 2017 21:37:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705242132180.3646@piezo.novalocal>
References: <CALe9h7cSEaLD90iDwjhi1GYogo7SV0mnc=8MjGQG_bnDVA0ygw@mail.gmail.com> <CAJ4mKGaARoBiG+A4PSLzBLNVuZqCBHi2VWTGmsfU8ofVTeEUkQ@mail.gmail.com> <CALe9h7dqh9mw=raWFF1gcn=DyKZTPVVswN8V14SMpPV+WaZPXw@mail.gmail.com> <CAJ4mKGaC0BuxsYPsZoqosAf2YXMKpte2WTpma=Q4TxpT+WbBVw@mail.gmail.com>
 <CALe9h7efSpCVT9Ddk4tyvTKbCDN0_ZhYOL6_qttF3DGijHefVg@mail.gmail.com> <CAJ4mKGbyiBV7uDvAdwRKUVuDNPw=sFhOQWJqJAsa3+HBogHiow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941010AbdEXVhX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 17:37:23 -0400
In-Reply-To: <CAJ4mKGbyiBV7uDvAdwRKUVuDNPw=sFhOQWJqJAsa3+HBogHiow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>, Joao Eduardo Luis <joao@suse.de>

On Wed, 24 May 2017, Gregory Farnum wrote:
> On Wed, May 24, 2017 at 2:15 PM John Spray <jspray@redhat.com> wrote:
> >
> > On Wed, May 24, 2017 at 9:45 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > > On Wed, May 24, 2017 at 3:20 AM John Spray <jspray@redhat.com> wrote:
> > >>
> > >> On Wed, May 24, 2017 at 6:12 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > >> > On Tue, May 23, 2017 at 10:31 AM John Spray <jspray@redhat.com> wrote:
> > >> >>
> > >> >> Hi all,
> > >> >>
> > >> >> I could use some help from people who understand the mon better than I
> > >> >> do with this ticket: http://tracker.ceph.com/issues/19706
> > >> >>
> > >> >> The issue is that MDSMonitor is incorrectly killing MDSs because it
> > >> >> hasn't seen beacon messages, but the beacon messages are actually just
> > >> >> held up because is_readable = 0, like this:
> > >> >> 2017-05-23 13:34:20.054785 7f772f1c2700 10
> > >> >> mon.b@0(leader).paxosservice(mdsmap 1..11) dispatch 0x7f7742989740
> > >> >> mdsbeacon(4141/a up:active seq 96 v9) v7 from mds.0
> > >> >> 172.21.15.77:6809/2700711429 con 0x7f77428d8f00
> > >> >> 2017-05-23 13:34:20.054788 7f772f1c2700  5 mon.b@0(leader).paxos(paxos
> > >> >> recovering c 1..293) is_readable = 0 - now=2017-05-23 13:34:20.054789
> > >> >> lease_expire=0.000000 has v0 lc 293
> > >> >> 2017-05-23 13:34:20.054791 7f772f1c2700 10
> > >> >> mon.b@0(leader).paxosservice(mdsmap 1..11)  waiting for paxos ->
> > >> >> readable (v9)
> > >> >>
> > >> >> This appears to be happening when one or more mons are a bit laggy,
> > >> >> but it is happening before an election has happened.
> > >> >>
> > >> >> We have code for handling slow elections by checking how long it has
> > >> >> been since the last tick, and resetting our timeout information for
> > >> >> MDS beacons if it has been too long
> > >> >> (https://github.com/ceph/ceph/blob/master/src/mon/MDSMonitor.cc#L2070)
> > >> >>
> > >> >>
> > >> >> However, in this case the tick() function is getting called
> > >> >> throughout, we're just not seeing the beacons because they're held up
> > >> >> waiting for readable.
> > >> >
> > >> >
> > >> > This story doesn't seem quite right/complete This code is only invoked
> > >> > if the monitor is the leader, which certainly doesn't happen when the
> > >> > monitor is out of quorum. Is the beacon maybe going to a peon which
> > >> > isn't forwarding quickly enough?
> > >>
> > >> That was what I thought (the messages are indeed being forwarded and
> > >> getting held up a bit there), but then I looked at the leader's log
> > >> and they were getting held up there too.
> > >
> > >
> > > Okay, so it's not that one peon is laggy but that the monitors are
> > > knowingly not in a quorum, including the one who is leader on both
> > > sides of the election (but not while things are laggy!). And then when
> > > the election happens, the leader does a tick and notices it hasn't
> > > gotten a beacon from any MDSes in the past timeout interval.
> >
> > That's what I thought too, until I noticed that the elections were
> > only happening *after* we've had our tick() and mistakenly killed an
> > MDS.  There's this period where the beacons are getting ignored, but
> > our tick() is still getting called.
> >
> > I've snipped out the timeline in an attachment to this mail (easier to
> > read in a nice widescreen text editor than most mail clients).
> 
> 
> Okay, now I get it.
> 
> 1) leader is not readable because there's a proposal pending
> (presumably, waiting on some slow peon)
> 2) leader receives forwarded beacons, holds off until readable
> 3) leader ticks() and says it hasn't processed a beacon in an
> acceptable amount of time so it kills MDS
> 4) peon finally times out so an election is called
> 
> So, yeah, I don't think we have any good patterns established there.
> You could presumably narrow the race by not doing the eviction
> processing while not readable, but I don't have any particular reason
> to think that closes it. You could perhaps try and track unprocessed
> beacons, and not evaluate it until you've seen them all?

We could measure the time that a PaxosService is proposing (and not 
readable), and add that value to the threshold for killing an mds or mgr.  
That should work as long as we assume during any given readable 
interval we'll be able to process all pending beacons.  I suspect that is 
normally the case.

We could also make it so that propose_pending doesn't happen while we are 
processing backlogged/delayed ops.  There are a very small number of 
instances where we *force* an immediate proposal (and arguably those 
should be fixed to not require that since they do not scale).  (FWIW this 
might also address the potential for livelock on cross-service 
proposals.)

sage
