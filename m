From: Sage Weil <sage@inktank.com>
Subject: Re: MDS boot loop
Date: Fri, 22 Nov 2013 15:06:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311221505490.2298@cobra.newdream.net>
References: <CAGdUFVY+PsZ5Adso7mmjMSwYBNxa0PbRkMUDOmqLNOk9-TGM7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34377 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab3KVXGj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Nov 2013 18:06:39 -0500
In-Reply-To: <CAGdUFVY+PsZ5Adso7mmjMSwYBNxa0PbRkMUDOmqLNOk9-TGM7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Holcombe <xfactor973@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 17 Nov 2013, Chris Holcombe wrote:
> I've noticed from time to time that my ceph-mds-a server will get
> stuck in a boot loop.  I see log messages like this:
> 
> 2013-11-17 20:42:42.476334 mon.0 [INF] osdmap e496905: 12 osds: 12 up, 12 in
> 2013-11-17 20:42:42.566744 mon.0 [INF] mds.? 192.168.1.20:6803/4047 up:boot
> 2013-11-17 20:42:42.566867 mon.0 [INF] mdsmap e488649: 1/1/1 up
> {0=dlceph01=up:active}, 2 up:standby
> 2013-11-17 20:42:42.644621 mon.0 [INF] pgmap v2247917: 2232 pgs: 2232
> active+clean; 23785 MB data, 61294 MB used, 11053 GB / 11113 GB avail;
> 45180B/s wr, 0op/s
> 2013-11-17 20:42:43.295421 mon.0 [INF] osdmap e496906: 12 osds: 12 up, 12 in
> 2013-11-17 20:42:43.371436 mon.0 [INF] mds.? 192.168.1.20:6809/7263 up:boot
> 2013-11-17 20:42:43.371495 mon.0 [INF] mdsmap e488650: 1/1/1 up
> {0=dlceph01=up:active}, 2 up:standby
> 2013-11-17 20:42:43.475032 mon.0 [INF] pgmap v2247918: 2232 pgs: 2232
> active+clean; 23785 MB data, 61294 MB used, 11053 GB / 11113 GB avail
> 2013-11-17 20:42:43.629813 mon.0 [INF] osdmap e496907: 12 osds: 12 up, 12 in
> 2013-11-17 20:42:43.697628 mon.0 [INF] mds.? 192.168.1.20:6804/26768 up:boot
> 2013-11-17 20:42:43.697700 mon.0 [INF] mdsmap e488651: 1/1/1 up
> {0=dlceph01=up:active}, 2 up:standby
> 2013-11-17 20:42:43.772643 mon.0 [INF] pgmap v2247919: 2232 pgs: 2232
> active+clean; 23785 MB data, 61294 MB used, 11053 GB / 11113 GB avail
> 2013-11-17 20:42:44.866154 mon.0 [INF] pgmap v2247920: 2232 pgs: 2232
> active+clean; 23785 MB data, 61294 MB used, 11053 GB / 11113 GB avail
> 2013-11-17 20:42:46.014768 mon.0 [INF] pgmap v2247921: 2232 pgs: 2232
> active+clean; 23785 MB data, 61295 MB used, 11053 GB / 11113 GB avail
> 2013-11-17 20:42:46.484480 mon.0 [INF] osdmap e496908: 12 osds: 12 up, 12 in
> 2013-11-17 20:42:46.561228 mon.0 [INF] mds.? 192.168.1.20:6803/4047 up:boot
> 2013-11-17 20:42:46.561327 mon.0 [INF] mdsmap e488652: 1/1/1 up
> {0=dlceph01=up:active}, 2 up:standby
> 2013-11-17 20:42:46.653518 mon.0 [INF] pgmap v2247922: 2232 pgs: 2232
> active+clean; 23785 MB data, 61296 MB used, 11053 GB / 11113 GB avail;
> 44045B/s wr, 0op/s

That looks a bit like a mon problem, since the mdsmap status isn't 
changing.  Can you do 'ceph mds dump 488652' and 'ceph mds dump 488651' 
(or some other consecutive mdsmaps) to see what, if anything, is changing?

sage

> 
> 
> After watching it do that for a few minutes and cephfs operations
> being extremely slow I kill -9 the ceph-mds processes on that host.  A
> few seconds later I see a reconnect message and all is fine again.
> Any idea why the mds servers are doing this?
> 
> I'm running ubuntu 13.04 x64 with the latest dumpling version of ceph.
>  I have 3 mds servers, 1 is active and the other 2 are standby.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
