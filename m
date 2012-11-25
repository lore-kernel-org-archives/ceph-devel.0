From: Sage Weil <sage@inktank.com>
Subject: Re: Redundancy when mount with multiple mon IP
Date: Sun, 25 Nov 2012 08:27:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211250826370.23552@cobra.newdream.net>
References: <CAJiejCRq2wcRVivDpXDGcQ4t5r=3ZM8-ywVh0EiuPdS+nuDqRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40757 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab2KYQ1N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 11:27:13 -0500
In-Reply-To: <CAJiejCRq2wcRVivDpXDGcQ4t5r=3ZM8-ywVh0EiuPdS+nuDqRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 25 Nov 2012, Drunkard Zhang wrote:
> I'm using ceph-0.51. I setup 3 monitors. then mount with 3 mon IP at
> another host with either kernel mode or fuse, neither give me
> redundancy.
> 
> Here's commands I used at client (IP: 10.0.0.2) side;
> mount -t ceph log3,log21,squid86-log12:/ /mnt/bc
> ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
> 
> When mounted, read/write is OK, then add a iptables rule at log3 to
> REJECT/DROP packets from client 10.0.0.2, operation at client stuck
> due to IO problem.
> 
> Related stuck processes on client look like this:
> log1 ~ # ps auwx |g bc
> root      1325  0.0  0.0 120100  3536 pts/0    Sl   23:10   0:00
> ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
> root      1404  0.0  0.0  16192   700 pts/0    S    23:10   0:00 ls
> --color=auto /mnt/bc

Can you repeat teh test with '--debug-monc 20 --debug-ms 1 --log-file /tmp/foo'
on the command line and attach the resulting log?

Thanks!
sage


> Is my test method wrong, or missed something while mount?
> 
> >From the mount.ceph man page, when I mounted with multiple monitor, it
> should be OK when one monitor dead. Has the monitor must be really
> dead. or just isn't reachable from the client?
> 
> One more question, is there any timeout option could be used at mount
> time? osdtimeout and mount_timeout doesn't look like.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
