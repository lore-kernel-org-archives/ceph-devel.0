From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Extremely high OSD memory utilization on Kraken
 11.2.0 (with XFS -or- bluestore)
Date: Tue, 16 May 2017 01:35:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705160133070.3646@piezo.novalocal>
References: <CAFFcurqEctQ2fHHDcGYfy3YCuaq9DxZr0VU4e8dNVACNVLDmqA@mail.gmail.com> <alpine.DEB.2.11.1704171457320.10661@piezo.novalocal> <CAFFcurrA8BKF0a+9gdGAsTDbE78ci9X8dwEaWEycoF4DNQN8uw@mail.gmail.com> <CAFFcuroumvWGZA+KC4V7wOiF9T0y7k9v+Ms=GgOh+bGm8gP__g@mail.gmail.com>
 <alpine.DEB.2.11.1705042124210.3646@piezo.novalocal> <CAFFcuroCpM7GGdsfcpNEvLQAsWEWqUbnPfP1FmZxq_-DyjgQeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56152 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdEPBfy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 May 2017 21:35:54 -0400
In-Reply-To: <CAFFcuroCpM7GGdsfcpNEvLQAsWEWqUbnPfP1FmZxq_-DyjgQeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aaron Ten Clay <aarontc@aarontc.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 15 May 2017, Aaron Ten Clay wrote:
> Hi Sage,
> 
> No problem. I thought this would take a lot longer to resolve so I
> waited to find a good chunk of time, then it only took a few minutes!
> 
> Here are the respective backtrace outputs from gdb:
> 
> https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.backtrace.txt
> https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508000000000000.backtrace.txt

Looks like it's in BlueFS replay.  Can you reproduce with 'log max recent 
= 1' and 'debug bluefs = 20'?

It's weird... the symptom is eating RAM, but it's hitting an assert during 
relay on mount...

Thanks!
sage



> 
> Hope that helps!
> 
> -Aaron
> 
> 
> On Thu, May 4, 2017 at 2:25 PM, Sage Weil <sage@newdream.net> wrote:
> > Hi Aaron-
> >
> > Sorry, lost track of this one.  In order to get backtraces out of the core
> > you need the matching executables.  Can you make sure the ceph-osd-dbg or
> > ceph-debuginfo package is installed on the machine (depending on if it's
> > deb or rpm) and then gdb ceph-osd corefile and 'thr app all bt'?
> >
> > Thanks!
> > sage
> >
> >
> > On Thu, 4 May 2017, Aaron Ten Clay wrote:
> >
> >> Were the backtraces we obtained not useful? Is there anything else we
> >> can try to get the OSDs up again?
> >>
> >> On Wed, Apr 19, 2017 at 4:18 PM, Aaron Ten Clay <aarontc@aarontc.com> wrote:
> >> > I'm new to doing this all via systemd and systemd-coredump, but I appear to
> >> > have gotten cores from two OSD processes. When xzipped they are < 2MIB each,
> >> > but I threw them on my webserver to avoid polluting the mailing list. This
> >> > seems oddly small, so if I've botched the process somehow let me know :)
> >> >
> >> > https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.xz
> >> > https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508000000000000.xz
> >> >
> >> > And for reference:
> >> > root@osd001:/var/lib/systemd/coredump# ceph -v
> >> > ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
> >> >
> >> >
> >> > I am also investigating sysdig as recommended.
> >> >
> >> > Thanks!
> >> > -Aaron
> >> >
> >> >
> >> > On Mon, Apr 17, 2017 at 8:15 AM, Sage Weil <sage@newdream.net> wrote:
> >> >>
> >> >> On Sat, 15 Apr 2017, Aaron Ten Clay wrote:
> >> >> > Hi all,
> >> >> >
> >> >> > Our cluster is experiencing a very odd issue and I'm hoping for some
> >> >> > guidance on troubleshooting steps and/or suggestions to mitigate the
> >> >> > issue.
> >> >> > tl;dr: Individual ceph-osd processes try to allocate > 90GiB of RAM and
> >> >> > are
> >> >> > eventually nuked by oom_killer.
> >> >>
> >> >> My guess is that there there is a bug in a decoding path and it's
> >> >> trying to allocate some huge amount of memory.  Can you try setting a
> >> >> memory ulimit to something like 40gb and then enabling core dumps so you
> >> >> can get a core?  Something like
> >> >>
> >> >> ulimit -c unlimited
> >> >> ulimit -m 20000000
> >> >>
> >> >> or whatever the corresponding systemd unit file options are...
> >> >>
> >> >> Once we have a core file it will hopefully be clear who is
> >> >> doing the bad allocation...
> >> >>
> >> >> sage
> >> >>
> >> >>
> >> >>
> >> >> >
> >> >> > I'll try to explain the situation in detail:
> >> >> >
> >> >> > We have 24-4TB bluestore HDD OSDs, and 4-600GB SSD OSDs. The SSD OSDs
> >> >> > are in
> >> >> > a different CRUSH "root", used as a cache tier for the main storage
> >> >> > pools,
> >> >> > which are erasure coded and used for cephfs. The OSDs are spread across
> >> >> > two
> >> >> > identical machines with 128GiB of RAM each, and there are three monitor
> >> >> > nodes on different hardware.
> >> >> >
> >> >> > Several times we've encountered crippling bugs with previous Ceph
> >> >> > releases
> >> >> > when we were on RC or betas, or using non-recommended configurations, so
> >> >> > in
> >> >> > January we abandoned all previous Ceph usage, deployed LTS Ubuntu 16.04,
> >> >> > and
> >> >> > went with stable Kraken 11.2.0 with the configuration mentioned above.
> >> >> > Everything was fine until the end of March, when one day we find all but
> >> >> > a
> >> >> > couple of OSDs are "down" inexplicably. Investigation reveals oom_killer
> >> >> > came along and nuked almost all the ceph-osd processes.
> >> >> >
> >> >> > We've gone through a bunch of iterations of restarting the OSDs, trying
> >> >> > to
> >> >> > bring them up one at a time gradually, all at once, various
> >> >> > configuration
> >> >> > settings to reduce cache size as suggested in this ticket:
> >> >> > http://tracker.ceph.com/issues/18924...
> >> >> >
> >> >> > I don't know if that ticket really pertains to our situation or not, I
> >> >> > have
> >> >> > no experience with memory allocation debugging. I'd be willing to try if
> >> >> > someone can point me to a guide or walk me through the process.
> >> >> >
> >> >> > I've even tried, just to see if the situation was  transitory, adding
> >> >> > over
> >> >> > 300GiB of swap to both OSD machines. The OSD procs managed to allocate,
> >> >> > in a
> >> >> > matter of 5-10 minutes, more than 300GiB of RAM pressure and became
> >> >> > oom_killer victims once again.
> >> >> >
> >> >> > No software or hardware changes took place around the time this problem
> >> >> > started, and no significant data changes occurred either. We added about
> >> >> > 40GiB of ~1GiB files a week or so before the problem started and that's
> >> >> > the
> >> >> > last time data was written.
> >> >> >
> >> >> > I can only assume we've found another crippling bug of some kind, this
> >> >> > level
> >> >> > of memory usage is entirely unprecedented. What can we do?
> >> >> >
> >> >> > Thanks in advance for any suggestions.
> >> >> > -Aaron
> >> >> >
> >> >> >
> >> >
> >> >
> >> >
> >> >
> >> > --
> >> > Aaron Ten Clay
> >> > https://aarontc.com
> >>
> >>
> >>
> >> --
> >> Aaron Ten Clay
> >> https://aarontc.com
> >>
> >>
> 
> 
> 
> -- 
> Aaron Ten Clay
> https://aarontc.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
