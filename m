From: Sage Weil <sage@newdream.net>
Subject: Re: Failed OSDs not getting marked down or out
Date: Thu, 19 Mar 2015 08:01:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503190758590.7043@cobra.newdream.net>
References: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com> <alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net> <CAC6JEv9SMnuXE80Y8jtMv_Qsf7MpcCAmsYjV3r5ju1B7838+kg@mail.gmail.com> <CAKeiORShxjnSVO9cRJC9ucrq-UWgRXLgqkt_Q8WO+2T7rHn2dg@mail.gmail.com>
 <CAC6JEv8TJaybJhYpq067Bhrz86f9CHtY8Lz9haKXtqED34e+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbCSPBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 11:01:04 -0400
In-Reply-To: <CAC6JEv8TJaybJhYpq067Bhrz86f9CHtY8Lz9haKXtqED34e+Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Matt Conner <matt.conner@keepertech.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 19 Mar 2015, Gregory Farnum wrote:
> Can you share the actual map? I'm not sure exactly what "rack rules"
> means here but from your description so far I'm guessing/hoping that
> you've accidentally restricted OSD choices in a way that limits the
> number of peers each OSD is getting.

It may also be that the pg_num calculation is off.  If OSDs really have 
~200 PGs you would expect ~200-400 peers, not ~10.  Perhaps you plugged in 
the nubmer of OSD *hosts* into your calculation instead of the number of 
disks?

Either way, the 'ceph osd dump' and 'ceph osd crush dump' output should 
clear things up!

sage


> -Greg
> 
> On Thu, Mar 19, 2015 at 5:41 AM, Matt Conner <matt.conner@keepertech.com> wrote:
> > In this case we are using rack rules with the firefly tunables. The testing
> > was being done with a single, 3 copy, pool with placement group number 4096.
> > This was calculated based on 10% data and 200 PGs per OSD using the
> > calculator at http://ceph.com/pgcalc/.
> >
> > Thanks,
> > Matt
> >
> > Matt Conner
> > keepertechnology
> > matt.conner@keepertech.com
> > (240) 461-2657
> >
> > On Wed, Mar 18, 2015 at 4:11 PM, Gregory Farnum <greg@gregs42.com> wrote:
> >>
> >> On Wed, Mar 18, 2015 at 12:59 PM, Sage Weil <sage@newdream.net> wrote:
> >> > On Wed, 18 Mar 2015, Matt Conner wrote:
> >> >> I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
> >> >> of 4 servers), 640 OSD cluster and have run into an issue when failing
> >> >> a storage server or rack where the OSDs are not getting marked down
> >> >> until the monitor timeout is reached - typically resulting in all
> >> >> writes being blocked until the timeout.
> >> >>
> >> >> Each of our storage servers contains 36 OSDs, so in order to prevent a
> >> >> server from marking a OSD out (in case of network issues), we have set
> >> >> our "mon_osd_min_down_reporters" value to 37. This value is working
> >> >> great for a smaller cluster, but unfortunately seems to not work so
> >> >> well in this large cluster. Tailing the monitor logs I can see that
> >> >> the monitor is only receiving failed reports from 9-10 unique OSDs per
> >> >> failed OSD.
> >> >>
> >> >> I've played around with "osd_heartbeat_min_peers", and it seems to
> >> >> help, but I still run into issues where an OSD is not marked down. Can
> >> >> anyone explain how the number of heartbeat peers is determined and
> >> >> how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
> >> >> have enough peering to detect failures in large clusters?
> >> >
> >> > The peers are normally determined why which other OSDs we share a PG
> >> > with.
> >> > Increasing pg_num for your pools will tend to increase this.  It looks
> >> > like osd_heartbeat_min_peers will do the same (to be honest I don't
> >> > think
> >> > I've ever had to use it for this), so I'm not sure why that isn't
> >> > resolving the problem.  Maybe make sure it is set significantly higher
> >> > than 36?  It may simply be that several of the random choices were
> >> > within
> >> > the same host so that when it goes down there still aren't enough peers
> >> > to mark things down.
> >> >
> >> > Alternatively, you can give up on the mon_osd_min_down_reporters tweak.
> >> > It sounds like it creates more problems than it solves...
> >>
> >> This normally works out okay; in particular I'd expect a lot more than
> >> 10 peer OSDs in a cluster of this size. What's your CRUSH map and
> >> ruleset look like? How many pools and PGs?
> >> -Greg
> >
> >
> 
> 
