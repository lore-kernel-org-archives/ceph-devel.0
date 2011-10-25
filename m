From: Sage Weil <sage@newdream.net>
Subject: Re: Repeated messages of "heartbeat_check: no heartbeat from"
Date: Tue, 25 Oct 2011 16:06:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110251603380.4437@cobra.newdream.net>
References: <1312546310.2754.41.camel@wido-laptop.pcextreme.nl>
 <1312972246.2742.7.camel@wido-desktop> <1318602360.3019.24.camel@wido-desktop>
 <Pine.LNX.4.64.1110140816060.3720@cobra.newdream.net> <4E9C4F45.8030704@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54823 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab1JYXGM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2011 19:06:12 -0400
In-Reply-To: <4E9C4F45.8030704@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi Wido,

Finally got to looking through these logs :( and I see osd.12 pinging lots 
of others OSDs but not osd.0.  The logs don't go far back enough to see 
osd.0 requesting heartbeats, though.

Is this something you are able to reproduce?  A similar log for the 
marker-down that extends back to when the process started will have more 
info.

Thanks!
sage



On Mon, 17 Oct 2011, Wido den Hollander wrote:

> Hi,
> 
> On 10/14/2011 05:16 PM, Sage Weil wrote:
> > On Fri, 14 Oct 2011, Wido den Hollander wrote:
> > > Hi,
> > > 
> > > I'm seeing this behavior again. In the monitor messages this started to
> > > appear:
> > > 
> > > 2011-10-14 16:22:19.853752   log 2011-10-14 16:22:14.887881 mon.0
> > > [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 3281 : [INF] osd.12
> > > [2a00:f10:113:1:225:90ff:fe33:49b0]:6800/8023 failed (by osd.0
> > > [2a00:f10:113:1:225:90ff:fe33:49fe]:6800/10678)
> > > 
> > > So, osd.0 is telling us that osd.12 is down, but the proces is running
> > > and seems alive.
> > > 
> > > The logs are saying:
> > > 
> > > Oct 14 16:20:52 atom0 osd.0[10679]: 7f81deeac700 osd.0 511
> > > heartbeat_check: no heartbeat from osd.12 since 2011-10-14
> > > 16:00:07.636627 (cutoff 2011-10-14 16:20:32.025154)
> > > Oct 14 16:20:52 atom0 osd.0[10679]: 7f81d2d93700 osd.0 511
> > > heartbeat_check: no heartbeat from osd.12 since 2011-10-14
> > > 16:00:07.636627 (cutoff 2011-10-14 16:20:32.108369)
> > > Oct 14 16:20:53 atom0 osd.0[10679]: 7f81deeac700 osd.0 511
> > > heartbeat_check: no heartbeat from osd.12 since 2011-10-14
> > > 16:00:07.636627 (cutoff 2011-10-14 16:20:33.025462)
> > > 
> > > While osd.12 reports getting messages from osd.0
> > > 
> > > Oct 14 16:20:54 atom3 osd.12[8024]: 7fa3621bb700 --
> > > [2a00:f10:113:1:225:90ff:fe33:49b0]:0/8024<== osd.0
> > > [2a00:f10:113:1:225:90ff:fe33:49fe]:6813/10678 1317 ====
> > > osd_ping(heartbeat e511 as_of 355) v1 ==== 61+0+0 (2126910847 0 0)
> > > 0x1e281c0 con 0x1f02c80
> > > 
> > > I see osd.0 sending pg_info messages:
> > > 
> > > Oct 14 16:20:58 atom0 osd.0[10679]: 7f81d769d700 --
> > > [2a00:f10:113:1:225:90ff:fe33:49fe]:6812/10678 -->  osd.12
> > > [2a00:f10:113:1:225:90ff:fe33:49b0]:6801/8023 -- pg_info(1 pgs e512) v1
> > > -- ?+0 0x3bf1e00
> > > 
> > > And osd.12 is also sending stuff back:
> > > 
> > > Oct 14 16:21:06 atom3 osd.12[8024]: 7fa3629bc700 --
> > > [2a00:f10:113:1:225:90ff:fe33:49b0]:6801/8023 -->  osd.0
> > > [2a00:f10:113:1:225:90ff:fe33:49fe]:6812/10678 -- pg_info(1 pgs e518) v1
> > > -- ?+0 0x6f3e540
> > > 
> > > I'm running the latest version, but I did do a complete powercycle of my
> > > cluster this morning. It's after the powercycle these messages started
> > > appearing.
> > > 
> > > Any ideas?
> > Can you post full osd logs for a pair where there was some marking-down
> > occuring?  I'll take a look.
> 
> Sure! Attached in the GZIP
> 
> I'm using remote-syslog, so the logs might be not how you want them. Let me
> know if so!
> 
> I used "ceph osd tell 0 injectargs '--debug-ms 20'" to set the debugging
> higher.
> 
> What I noticed was this:
> 
> $ tail -f osd.log |grep "osd\.0"|grep "osd\.12"
> 
> Oct 17 17:48:33 monitor mon.dga[560]: 7fa5fc520700 log [INF] : osd.12
> [2a00:f10:113:1:225:90ff:fe33:49b0]:6800/8023 failed (by osd.0
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6800/10678)
> Oct 17 17:48:33 monitor mon.dga[560]: 2011-10-17 17:48:33.930666 mon.0
> [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 2440 : [INF] osd.12
> [2a00:f10:113:1:225:90ff:fe33:49b0]:6800/8023 failed (by osd.0
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6800/10678)
> Oct 17 17:48:36 atom3 osd.12[8024]: 7fa356039700 --
> [2a00:f10:113:1:225:90ff:fe33:49b0]:0/8024 >>
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6813/10678 pipe(0x6e0e000 sd=20 pgs=133
> cs=1 l=0).reader got envelope type=70 src osd.0 front=61 data=0 off 0
> Oct 17 17:48:36 atom3 osd.12[8024]: 7fa3621bb700 --
> [2a00:f10:113:1:225:90ff:fe33:49b0]:0/8024 <== osd.0
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6813/10678 278150 ==== osd_ping(heartbeat
> e577 as_of 355) v1 ==== 61+0+0 (2665319624 0 0) 0x52e1540 con 0x1f02c80
> 
> $ tail -f osd.log |grep "osd\.0"|grep "osd\.15" (Random other OSD)
> 
> Oct 17 17:49:29 atom3 osd.15[10295]: 7fd2ee88c700 --
> [2a00:f10:113:1:225:90ff:fe33:49b0]:0/10295 <== osd.0
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6813/10678 277738 ==== osd_ping(heartbeat
> e577 as_of 404) v1 ==== 61+0+0 (1619141758 0 0) 0x33568c0 con 0x56a0c80
> Oct 17 17:49:33 atom3 osd.15[10295]: 7fd2ee88c700 --
> [2a00:f10:113:1:225:90ff:fe33:49b0]:0/10295 <== osd.0
> [2a00:f10:113:1:225:90ff:fe33:49fe]:6813/10678 277742 ==== osd_ping(heartbeat
> e577 as_of 404) v1 ==== 61+0+0 (116581228 0 0) 0x6739c40 con 0x56a0c80
> Oct 17 17:49:34 atom0 osd.0[10679]: 7f81c91ff700 --
> [2a00:f10:113:1:225:90ff:fe33:49fe]:0/10679 >>
> [2a00:f10:113:1:225:90ff:fe33:49b0]:6811/10294 pipe(0x4bbda00 sd=87 pgs=19
> cs=1 l=0).reader got envelope type=70 src osd.15 front=61 data=0 off 0
> Oct 17 17:49:34 atom0 osd.0[10679]: 7f81d6e9c700 --
> [2a00:f10:113:1:225:90ff:fe33:49fe]:0/10679 <== osd.15
> [2a00:f10:113:1:225:90ff:fe33:49b0]:6811/10294 278117 ==== osd_ping(heartbeat
> e577 as_of 404) v1 ==== 61+0+0 (116581228 0 0) 0x2fd5c40 con 0x5a6cb40
> 
> If you look at the log you'll see that osd.0 is reporting that osd.12 and
> osd.39 are down.
> 
> The logs show me that osd.0 is never communicating with osd.12 nor osd.39 and
> simply reports them as down.
> 
> The last time I saw this it was exactly the same. One OSD was repeating that
> two other OSD's were down.
> 
> My guess is that osd.0 is the problem here.
> 
> > 
> > Thanks!
> > sage
> > 
> > > Wido
> > > 
> > > On Wed, 2011-08-10 at 12:30 +0200, Wido den Hollander wrote:
> > > > Hi,
> > > > 
> > > > I tried reproducing this today with the new heartbeat code, couldn't.
> > > > 
> > > > The new heartbeat code seems to work much better under load, I haven't
> > > > seen any bouncing like I saw before.
> > > > 
> > > > Wido
> > > > 
> > > > On Fri, 2011-08-05 at 14:11 +0200, Wido den Hollander wrote:
> > > > > Hi,
> > > > > 
> > > > > I'm seeing something weird which I don't want to report in a issue yet
> > > > > in the tracker.
> > > > > 
> > > > > I suffered a pretty big crash which caused me to loose 15 of my 40
> > > > > OSDs.
> > > > > Some died because my WD Green 2TB disks failed, others since btrfs
> > > > > didn't survive the hard reboot I had to give them.
> > > > > 
> > > > > When watching 'ceph -w' I noticed this:
> > > > > 
> > > > > 2011-08-05 13:32:03.209958    pg v504313: 8008 pgs: 1 inactive, 334
> > > > > active+clean, 10 peering, 1 crashed+peering, 14 down+peering, 7 active
> > > > > +clean+degraded, 7624 crashed+down+peering, 8 down+degraded+peering, 9
> > > > > crashed+down+degraded+peering; 4417 GB data, 13121 GB used, 32504 GB /
> > > > > 46575 GB avail; 8255/3391107 degraded (0.243%)
> > > > > 2011-08-05 13:32:03.225712   mds e6033: 1/1/1 up
> > > > > {0=dga=up:replay(laggy
> > > > > or crashed)}
> > > > > 2011-08-05 13:32:03.225747   osd e9934: 40 osds: 25 up, 25 in
> > > > > 2011-08-05 13:32:03.225874   log 2011-08-05 13:32:01.646596 mon0
> > > > > [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 29796 : [INF] osd37
> > > > > [2a00:f10:113:1:225:90ff:fe33:49a4]:6803/17881 failed (by osd7
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6806/2746)
> > > > > 2011-08-05 13:32:03.225964   mon e1: 1 mons at
> > > > > {dga=[2a00:f10:113:1:230:48ff:fed3:b086]:6789/0}
> > > > > 2011-08-05 13:32:03.929650   log 2011-08-05 13:32:03.603681 mon0
> > > > > [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 29797 : [INF] osd19
> > > > > [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 failed (by osd5
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506)
> > > > > 
> > > > > Here you see that osd5 is reporting that osd37 is down and osd7 is
> > > > > reporting that osd19 is down.
> > > > > 
> > > > > These messages keep being repeated, over and over. My 'debug ms' is at
> > > > > 1, so I took a look at the logs:
> > > > > 
> > > > > Aug  5 13:32:41 atom1 osd.5[2507]: 7f75227fc700 osd5 9963
> > > > > heartbeat_check: no heartbeat from osd19 since 2011-08-04
> > > > > 17:01:02.504942 (cutoff 2011-08-05 13:32:21.916364)
> > > > > Aug  5 13:32:42 atom1 osd.5[2507]: 7f7531579700 osd5 9963
> > > > > heartbeat_check: no heartbeat from osd19 since 2011-08-04
> > > > > 17:01:02.504942 (cutoff 2011-08-05 13:32:22.381632)
> > > > > Aug  5 13:32:43 atom1 osd.5[2507]: 7f7531579700 osd5 9965
> > > > > heartbeat_check: no heartbeat from osd19 since 2011-08-04
> > > > > 17:01:02.504942 (cutoff 2011-08-05 13:32:23.474198)
> > > > > Aug  5 13:32:44 atom1 osd.5[2507]: 7f75227fc700 osd5 9965
> > > > > heartbeat_check: no heartbeat from osd19 since 2011-08-04
> > > > > 17:01:02.504942 (cutoff 2011-08-05 13:32:24.027161)
> > > > > 
> > > > > osd5 keeps claiming that osd19 is down, but when I check the logs I
> > > > > see
> > > > > that osd19 is running and exchanging heartbeat messages with the other
> > > > > OSDs in the cluster.
> > > > > 
> > > > > What seems odd to me is that there are no log messages about osd7
> > > > > claiming that osd37 is down, although it keeps being repeated by 'ceph
> > > > > -w'.
> > > > > 
> > > > > $ ceph osd injectargs 7 '--debug-ms 1'
> > > > > $ ceph osd injectargs 37 '--debug-ms 1'
> > > > > 
> > > > > I made sure that was injected, but still, no log messages.
> > > > > 
> > > > > Going through the logs a bit further (after setting the logging to 20)
> > > > > I
> > > > > saw osd.19 reporting:
> > > > > 
> > > > > Aug  5 13:48:23 atom4 osd.19[2741]: 7f634ca8e700 --
> > > > > [2a00:f10:113:1:225:90ff:fe33:49cc]:6810/2740>>
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6808/2506 pipe(0x7f64e4193ec0
> > > > > sd=56
> > > > > pgs=1530 cs=1 l=0).reader got envelope type=70 src osd5 front=61
> > > > > data=0
> > > > > off 0
> > > > > 
> > > > > It seems that it is communicating with osd5, but osd5 does not seem to
> > > > > communicate with osd19?
> > > > > 
> > > > > The log also confirms that:
> > > > > 
> > > > > Aug  5 14:10:05 atom1 osd.5[2507]: 7f7531579700 --
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506 -->
> > > > > [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 -- osd_failure(osd19
> > > > > [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020 v10020) v1 -- ?+0
> > > > > 0x6948000 con 0x1cd7710
> > > > > Aug  5 14:10:05 atom1 osd.5[2507]: 7f7531579700 --
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506 submit_message
> > > > > osd_failure(osd19 [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020
> > > > > v10020) v1 remote [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0
> > > > > Aug  5 14:10:05 atom1 osd.5[2507]: 7f75365a1700 --
> > > > > [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506>>
> > > > > [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 pipe(0x1cd74a0 sd=13
> > > > > pgs=178
> > > > > cs=1 l=1).writer encoding 17093 0x6948000 osd_failure(osd19
> > > > > [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020 v10020) v1
> > > > > 
> > > > > Now, to prevent (I tried...) my cluster from bouncing around I placed
> > > > > this in the OSD section:
> > > > > 
> > > > >      osd min down reporters = 3
> > > > >      osd min down reports = 5
> > > > > 
> > > > > Since only osd5 and osd7 are sending out these messages osd19 nor
> > > > > osd37
> > > > > get marked down, but what is going on here?
> > > > > 
> > > > > I haven't restarted the OSDs yet.
> > > > > 
> > > > > I noticed that the OSD heartbeat process is being revised currently,
> > > > > but
> > > > > I thought it might be helpful to report this.
> > > > > 
> > > > > Wido
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
