From: Sage Weil <sage@newdream.net>
Subject: Re: pre_start command not executed with upstart
Date: Thu, 30 Jul 2015 05:28:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507300526420.22099@cobra.newdream.net>
References: <55B73581.3040501@42on.com> <alpine.DEB.2.00.1507280528210.22099@cobra.newdream.net> <55B9D5A5.9060301@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43123 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbG3M2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 08:28:19 -0400
In-Reply-To: <55B9D5A5.9060301@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 30 Jul 2015, Wido den Hollander wrote:
> On 28-07-15 14:29, Sage Weil wrote:
> > On Tue, 28 Jul 2015, Wido den Hollander wrote:
> >> Hi,
> >>
> >> I was trying to inject a pre_start command on a bunch of OSDs under
> >> Ubuntu 14.04, but that didn't work.
> >>
> >> I found out that only the sysvinit script execute pre_start commands,
> >> but the upstart nor the systemd scripts do this.
> >>
> >> Is this a thing which will disappear or is this just a oversight?
> >>
> >> I'm actually using "sleep 30" as a pre-start to prevent all OSDs from
> >> starting at the same time. Big boxes which die under the workload of all
> >> OSDs starting at the same time.
> >>
> >> I also try to prevent a lot of OSDMap changes by booting the OSDs slowly
> >> so I tried to fix this with "pre_start".
> > 
> > I was hoping to let it die...
> > 
> > I would take a fresh look at systemd and see if there is a 
> > different/better mechanism there to address the startup issue.  You can 
> > manually add a prestart script/command to the unit file...
> > 
> 
> Oh, it doesn't matter if it dies out. It's just that there will probably
> be scenarios where users want to do some sort of pre-start before a OSD
> is executed.
> 
> The update_crush hook is one of the examples which is already executed
> for example.
> 
> A pre_start which does a mount for example (for those without udev)
> might be useful.

For what it's worth, the view from Leannart is that unit files are simple 
enough to be configuration, in which case such users can just add a 
ExecStartPre to their ceph-osd@.service file (instead of doing the same in 
the ceph.conf file).

sage
