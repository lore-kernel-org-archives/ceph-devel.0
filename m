From: Sage Weil <sage@newdream.net>
Subject: Re: logrotate and auto start = no
Date: Wed, 15 Feb 2012 06:40:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202150639050.3836@cobra.newdream.net>
References: <4F3BC08F.7090106@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33274 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759243Ab2BOOky (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 09:40:54 -0500
In-Reply-To: <4F3BC08F.7090106@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 15 Feb 2012, Wido den Hollander wrote:
> Hi,
> 
> When "auto start = no" is set for the OSD's, the logs won't get rotated.
> 
> I've set this to no so I can easily reboot machines without all OSD's
> starting, I think it's easier with testing or when you replace a broken disk.
> 
> Anyway, this prevents the logs from being rotated, causing my disks to fill
> up:
> 
> /var/log/ceph/*.log {
>     rotate 7
>     daily
>     compress
>     sharedscripts
>     postrotate
>         invoke-rc.d ceph reload >/dev/null || service ceph reload >/dev/null
>     endscript
>     missingok
> }
> 
> The init script doesn't touch daemons which have auto start set to no, but
> this also prevents logrotate from doing it's job.
> 
> Some suggestions:
> 
> 1. Don't use the init script for logrotation
> 2. Modify the init script

This is my choice.  We can probably just move the check into the 'start' 
block.  It also looks like the auto_start check is doing something weird 
if the value is "mds"... 

> 3. Add a note in the documentation about this behaviour
> 
> I think that logrotation should work regardless the setting of auto start?

Yeah, definitely!

sage


> 
> What do you think?
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
