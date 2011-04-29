From: Wido den Hollander <wido@widodh.nl>
Subject: Re: All osd are marked down and out...
Date: Fri, 29 Apr 2011 10:58:36 +0200
Message-ID: <1304067516.2932.119.camel@wido-desktop>
References: <BANLkTikmS+PesggpexM+MDnzVE6R2c8pEA@mail.gmail.com>
	 <1304065314.2932.102.camel@wido-desktop>
	 <BANLkTim3quk4omvi12HMYoHntxoRRzxqOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49686 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab1D2I6Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 04:58:25 -0400
In-Reply-To: <BANLkTim3quk4omvi12HMYoHntxoRRzxqOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Fri, 2011-04-29 at 16:42 +0800, AnnyRen wrote:
> 2011/4/29 Wido den Hollander <wido@widodh.nl>:
> > Hi,
> >
> > On Fri, 2011-04-29 at 15:20 +0800, AnnyRen wrote:
> >> Hi,
> >>
> >> I Set up a Ceph environment with 3 mon, 2 mds and 30 osd,
> >> Recently, we are testing the stalibility of mon,
> >>
> >> The following are my test steps:
> >> 1. on MON1(where mon.0 running):
> >>     -> ceph mon remove 0
> >>
> >> 2. on MON2 (where mon.1 running)
> >>     --> ceph mon add 0 192.268.200.181:6789 (mon.0 ip:port)
> >>
> >> 3. on MON2:  rsync
> >>     --> rsync -av /data1/mon1/ MON1:/data1/mon0
> >>
> >> 4. on MON1: start mon.0 daemon
> >>    --> cmon -i 0 -c /etc/ceph/ceph.conf
> >
> > I'm missing what you did here? You say you have 3 monitors, but here you
> > see to have two monitors?
> 
> originally, I have 3 monitor, I want to remove the leader monitor to
> see whether removing a monitor will affect client writes files.
> so I use ceph mon remove instruction to modify monmap, and It's ok and
> works well,

Aha, ok. I think it was easier just to kill mon.0. By doing so another
monitor will become the leader and take over.

You really removed the monitor from the monmap, that is not necessary
for trying to do a monitor failover. 

> 
> but when I use 'ceph mon add' to modify monmap, and rsync monmap to
> the removed monitor, and then start the mon service on that rejoined
> monitor.
> 

> >
> > Could you sent your ceph.conf?
> >
> 
> ceph.conf is as attachment.
> 
> Dear Wido, thanks for your quickly response!!

I would recommend giving your monitors alphanumeric names, like:

[mon.alpha]
  host = MON1

[mon.beta]
  host = MON2

[mon.charlie]
  host = MON3

Your logging of the OSD's and MON's is turned off, so there is no way to
figure out what is actually going on.

Could you turn up the logging a bit?

[global]
  debug ms = 1

The messaging traffic should be enough I think.

I still think your OSD's got cut off at some point, but I'm not 100%
sure yet.

Wido

> 
> > Wido
> >
> >>
> >> 2011-04-29 06:51:57.309468 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 0.
> >> Marking down!
> >> 2011-04-29 06:51:57.309499 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 1.
> >> Marking down!
> >> 2011-04-29 06:51:57.309513 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 2.
> >> Marking down!
> >> 2011-04-29 06:51:57.309523 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 3.
> >> Marking down!
> >> 2011-04-29 06:51:57.309532 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 4.
> >> Marking down!
> >> 2011-04-29 06:51:57.309541 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 5.
> >> Marking down!
> >> 2011-04-29 06:51:57.309550 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 6.
> >> Marking down!
> >> 2011-04-29 06:51:57.309558 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 7.
> >> Marking down!
> >> 2011-04-29 06:51:57.309567 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 8.
> >> Marking down!
> >> 2011-04-29 06:51:57.309576 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 9.
> >> Marking down!
> >> 2011-04-29 06:51:57.309585 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 10. Marking down!
> >> 2011-04-29 06:51:57.309594 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 11. Marking down!
> >> 2011-04-29 06:51:57.309603 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 12. Marking down!
> >> 2011-04-29 06:51:57.309613 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 13. Marking down!
> >> 2011-04-29 06:51:57.309622 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 14. Marking down!
> >> 2011-04-29 06:51:57.309631 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 15. Marking down!
> >> 2011-04-29 06:51:57.309648 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 16. Marking down!
> >> 2011-04-29 06:51:57.309657 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 17. Marking down!
> >> 2011-04-29 06:51:57.309666 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 18. Marking down!
> >> 2011-04-29 06:51:57.309674 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 19. Marking down!
> >> 2011-04-29 06:51:57.309682 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 20. Marking down!
> >> 2011-04-29 06:51:57.309691 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 21. Marking down!
> >> 2011-04-29 06:51:57.309699 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 22. Marking down!
> >> 2011-04-29 06:51:57.309707 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 23. Marking down!
> >> 2011-04-29 06:51:57.309716 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 24. Marking down!
> >> 2011-04-29 06:51:57.309724 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 25. Marking down!
> >> 2011-04-29 06:51:57.309732 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 26. Marking down!
> >> 2011-04-29 06:51:57.309741 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 27. Marking down!
> >> 2011-04-29 06:51:57.309749 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 28. Marking down!
> >> 2011-04-29 06:51:57.309757 7fb17da56710 mon.0@0(leader).osd e148
> >> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
> >> 29. Marking down!
> >>
> >> 2011-04-29 06:57:02.359021 7fb17da56710 log [INF] : osd0 out (down for
> >> 304.884685)
> >> 2011-04-29 06:57:02.359070 7fb17da56710 log [INF] : osd1 out (down for
> >> 304.884684)
> >> 2011-04-29 06:57:02.359090 7fb17da56710 log [INF] : osd2 out (down for
> >> 304.884684)
> >> 2011-04-29 06:57:02.359109 7fb17da56710 log [INF] : osd3 out (down for
> >> 304.884683)
> >> 2011-04-29 06:57:02.359126 7fb17da56710 log [INF] : osd4 out (down for
> >> 304.884683)
> >> 2011-04-29 06:57:02.359145 7fb17da56710 log [INF] : osd5 out (down for
> >> 304.884682)
> >> 2011-04-29 06:57:02.359162 7fb17da56710 log [INF] : osd6 out (down for
> >> 304.884682)
> >> 2011-04-29 06:57:02.359179 7fb17da56710 log [INF] : osd7 out (down for
> >> 304.884682)
> >> 2011-04-29 06:57:02.359197 7fb17da56710 log [INF] : osd8 out (down for
> >> 304.884682)
> >> 2011-04-29 06:57:02.359215 7fb17da56710 log [INF] : osd9 out (down for
> >> 304.884682)
> >> 2011-04-29 06:57:02.359234 7fb17da56710 log [INF] : osd10 out (down
> >> for 304.884681)
> >> 2011-04-29 06:57:02.359252 7fb17da56710 log [INF] : osd11 out (down
> >> for 304.884681)
> >> 2011-04-29 06:57:02.359270 7fb17da56710 log [INF] : osd12 out (down
> >> for 304.884681)
> >> 2011-04-29 06:57:02.359289 7fb17da56710 log [INF] : osd13 out (down
> >> for 304.884680)
> >> 2011-04-29 06:57:02.359308 7fb17da56710 log [INF] : osd14 out (down
> >> for 304.884680)
> >> 2011-04-29 06:57:02.359328 7fb17da56710 log [INF] : osd15 out (down
> >> for 304.884680)
> >> 2011-04-29 06:57:02.359347 7fb17da56710 log [INF] : osd16 out (down
> >> for 304.884679)
> >> 2011-04-29 06:57:02.359367 7fb17da56710 log [INF] : osd17 out (down
> >> for 304.884679)
> >> 2011-04-29 06:57:02.359386 7fb17da56710 log [INF] : osd18 out (down
> >> for 304.884679)
> >> 2011-04-29 06:57:02.359406 7fb17da56710 log [INF] : osd19 out (down
> >> for 304.884679)
> >> 2011-04-29 06:57:02.359425 7fb17da56710 log [INF] : osd20 out (down
> >> for 304.884678)
> >> 2011-04-29 06:57:02.359458 7fb17da56710 log [INF] : osd21 out (down
> >> for 304.884678)
> >> 2011-04-29 06:57:02.359480 7fb17da56710 log [INF] : osd22 out (down
> >> for 304.884678)
> >> 2011-04-29 06:57:02.359499 7fb17da56710 log [INF] : osd23 out (down
> >> for 304.884677)
> >> 2011-04-29 06:57:02.359518 7fb17da56710 log [INF] : osd24 out (down
> >> for 304.884677)
> >> 2011-04-29 06:57:02.359538 7fb17da56710 log [INF] : osd25 out (down
> >> for 304.884677)
> >> 2011-04-29 06:57:02.359557 7fb17da56710 log [INF] : osd26 out (down
> >> for 304.884676)
> >> 2011-04-29 06:57:02.359577 7fb17da56710 log [INF] : osd27 out (down
> >> for 304.884676)
> >> 2011-04-29 06:57:02.359596 7fb17da56710 log [INF] : osd28 out (down
> >> for 304.884676)
> >> 2011-04-29 06:57:02.359616 7fb17da56710 log [INF] : osd29 out (down
> >> for 304.884675)
> >>
> >>
> >> root@MON1:~# ceph -s
> >> 2011-04-29 07:17:00.226534    pg v3025: 7920 pgs: 7920 active+clean;
> >> 3650 MB data, 0 KB used, 0 KB / 0 KB avail
> >> 2011-04-29 07:17:00.239044   mds e42: 1/1/1 up {0=up:active}, 1 up:standby
> >> 2011-04-29 07:17:00.239080   osd e151: 30 osds: 0 up, 0 in
> >> 2011-04-29 07:17:00.239175   log 2011-04-29 06:57:02.359625 mon0
> >> 192.168.200.181:6789/0 71 : [INF] osd29 out (down for 304.884675)
> >> 2011-04-29 07:17:00.239233   mon e3: 3 mons at
> >> {0=192.168.200.181:6789/0,1=192.168.200.182:6789/0,2=192.168.200.183:6789/0}
> >>
> >>
> >> Anyone knows how to fix my environment to make ceph be health?
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >


