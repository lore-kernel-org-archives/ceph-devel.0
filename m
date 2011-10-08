From: Sage Weil <sage@newdream.net>
Subject: Re: OSD::disk_tp timeout
Date: Sat, 8 Oct 2011 15:44:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110081544270.26432@cobra.newdream.net>
References: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
 <Pine.LNX.4.64.1110081427160.26432@cobra.newdream.net> <4E90CB7C.3010304@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54106 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1JHWo7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 18:44:59 -0400
In-Reply-To: <4E90CB7C.3010304@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 9 Oct 2011, Martin Mailand wrote:
> Hi,
> I am using v3.1-rc9, so the fix in there. Maybe I can nail it down a bit more
> specific.

You might try sysrq-t or -w to see what the spinning CPUs are doing.

Thanks!
sage


> 
> Best Regards,
>  martin
> 
> Sage Weil schrieb:
> > Hi Christian,
> > 
> > On Sat, 8 Oct 2011, Christian Brunner wrote:
> > > Hi,
> > > 
> > > I've upgraded ceph from 0.32 to 0.36 yesterday. Now I have a totaly
> > > screwed ceph cluster. :(
> > > 
> > > What bugs me most is the fact, that OSDs become unresponsive
> > > frequently. The process is eating a lot of cpu and I can see the
> > 
> > What version of btrfs are you running?  This sound a bit like the bug fixed
> > by this patch:
> > 
> > http://www.spinics.net/lists/linux-btrfs/msg12627.html
> > 
> > (That was just merged into mainline this week.)
> > 
> > > following messages in the log:
> > > 
> > > Oct  8 22:30:05 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > Oct  8 22:30:10 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > Oct  8 22:30:15 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > Oct  8 22:30:20 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > Oct  8 22:30:25 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > Oct  8 22:30:30 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> > > is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> > > 
> > > Do you have any idea, what to do about that?
> > 
> > Those messages just mean that a thread in the disk threadpool (which is
> > doing all the writes to btrfs) is blocked/stopped.
> > 
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
