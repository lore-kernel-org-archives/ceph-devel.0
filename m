From: Sage Weil <sage@newdream.net>
Subject: Re: Failed OSDs not getting marked down or out
Date: Wed, 18 Mar 2015 12:59:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net>
References: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39420 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbbCRT7h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 15:59:37 -0400
In-Reply-To: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Conner <matt.conner@keepertech.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 Mar 2015, Matt Conner wrote:
> I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
> of 4 servers), 640 OSD cluster and have run into an issue when failing
> a storage server or rack where the OSDs are not getting marked down
> until the monitor timeout is reached - typically resulting in all
> writes being blocked until the timeout.
> 
> Each of our storage servers contains 36 OSDs, so in order to prevent a
> server from marking a OSD out (in case of network issues), we have set
> our "mon_osd_min_down_reporters" value to 37. This value is working
> great for a smaller cluster, but unfortunately seems to not work so
> well in this large cluster. Tailing the monitor logs I can see that
> the monitor is only receiving failed reports from 9-10 unique OSDs per
> failed OSD.
>
> I've played around with "osd_heartbeat_min_peers", and it seems to
> help, but I still run into issues where an OSD is not marked down. Can
> anyone explain how the number of heartbeat peers is determined and
> how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
> have enough peering to detect failures in large clusters?

The peers are normally determined why which other OSDs we share a PG with.  
Increasing pg_num for your pools will tend to increase this.  It looks 
like osd_heartbeat_min_peers will do the same (to be honest I don't think 
I've ever had to use it for this), so I'm not sure why that isn't 
resolving the problem.  Maybe make sure it is set significantly higher 
than 36?  It may simply be that several of the random choices were within 
the same host so that when it goes down there still aren't enough peers 
to mark things down.

Alternatively, you can give up on the mon_osd_min_down_reporters tweak.  
It sounds like it creates more problems than it solves...

sage


> 
> Has anyone had a similar experience with a large cluster? Any
> recommendations on how to correct this?
> 
> Thanks,
> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
