From: Sage Weil <sage@newdream.net>
Subject: Re: pre_start command not executed with upstart
Date: Tue, 28 Jul 2015 05:29:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507280528210.22099@cobra.newdream.net>
References: <55B73581.3040501@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59252 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbG1M3P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 08:29:15 -0400
In-Reply-To: <55B73581.3040501@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 28 Jul 2015, Wido den Hollander wrote:
> Hi,
> 
> I was trying to inject a pre_start command on a bunch of OSDs under
> Ubuntu 14.04, but that didn't work.
> 
> I found out that only the sysvinit script execute pre_start commands,
> but the upstart nor the systemd scripts do this.
> 
> Is this a thing which will disappear or is this just a oversight?
> 
> I'm actually using "sleep 30" as a pre-start to prevent all OSDs from
> starting at the same time. Big boxes which die under the workload of all
> OSDs starting at the same time.
> 
> I also try to prevent a lot of OSDMap changes by booting the OSDs slowly
> so I tried to fix this with "pre_start".

I was hoping to let it die...

I would take a fresh look at systemd and see if there is a 
different/better mechanism there to address the startup issue.  You can 
manually add a prestart script/command to the unit file...

sage
