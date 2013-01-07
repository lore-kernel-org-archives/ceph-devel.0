From: Gregory Farnum <greg@inktank.com>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Mon, 7 Jan 2013 13:30:34 -0800
Message-ID: <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:61864 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab3AGVaj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 16:30:39 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so10816572pbc.4
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 13:30:39 -0800 (PST)
In-Reply-To: <50EB0518.9050304@ledeuns.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Monday, January 7, 2013 at 9:25 AM, Denis Fondras wrote:
> Hello all,
> 
> > I'm using Ceph 0.55.1 on a Debian Wheezy (1 mon, 1 mds et 3 osd over
> > btrfs) and every once in a while, an OSD process crashes (almost never
> > the same osd crashes).
> > This time I had 2 osd crash in a row and so I only had one replicate. I
> > could bring the 2 crashed osd up and it started to recover.
> > Unfortunately, the "source" osd crashed while recovering and now I have
> > a some lost PGs.
> > 
> > If I happen to bring the primary OSD up again, can I imagine the lost PG
> > will be recovered too ?
> 
> 
> 
> Ok, so it seems I can't bring back to life my primary OSD :-(
> 
> ---8<---------------
> health HEALTH_WARN 72 pgs incomplete; 72 pgs stuck inactive; 72 pgs 
> stuck unclean
> monmap e1: 1 mons at {a=192.168.0.132:6789/0}, election epoch 1, quorum 0 a
> osdmap e1130: 3 osds: 2 up, 2 in
> pgmap v1567492: 624 pgs: 552 active+clean, 72 incomplete; 1633 GB 
> data, 4766 GB used, 3297 GB / 8383 GB avail
> mdsmap e127: 1/1/1 up {0=a=up:active}
> 
> 2013-01-07 18:11:10.852673 mon.0 [INF] pgmap v1567492: 624 pgs: 552 
> active+clean, 72 incomplete; 1633 GB data, 4766 GB used, 3297 GB / 8383 
> GB avail
> ---8<---------------
> 
> When I "rbd list", I can see all my images.
> When I do "rbd map", I can map only a few of them and when I mount the 
> devices, none can mount (the mount process hangs and I cannot even ^C 
> the process).
> 
> Is there something I can try ?

What's wrong with your primary OSD? In general they shouldn't really be crashing that frequently and if you've got a new bug we'd like to diagnose and fix it.

If that can't be done (or it's a hardware failure or something), you can mark the OSD lost, but that might lose data and then you will be sad.
-Greg

