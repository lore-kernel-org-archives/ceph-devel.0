From: Sage Weil <sage@inktank.com>
Subject: Re: Filesystem size inconsistance problem
Date: Sat, 5 Jan 2013 22:31:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052230260.15430@cobra.newdream.net>
References: <CAJiejCTmQYy7DpY-p27oseEAbbeNiFcxonL2pZGTofnwz1D79A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50829 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3AFGbi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:31:38 -0500
In-Reply-To: <CAJiejCTmQYy7DpY-p27oseEAbbeNiFcxonL2pZGTofnwz1D79A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

On Sun, 6 Jan 2013, Drunkard Zhang wrote:
> Some times ago, I did ceph upgrade offline, then ethernet bonding
> while ceph online, and also I removed some OSDs, the cluster
> experienced big movements, after sometime it calms down finally. When
> I verify the consistance, I found that the filesystem size by 'ceph
> -s'(true size) and mounted size is different. What's the problem?
> 
> It's still usable, and the used percent is right too, but the wrong
> size displayed looks really uncomfortable !!!

What OS and kernel are you running?  In order to get big numbers to come 
out of statfs, we report a huge block size, and some combinations of the 
system utilies, glibc, or something else result in bad output.  I don't 
think we've ever fully tracked it down... :(

> 
> log3 ~ # mount -t ceph log3:/ /mnt/temp/
> log3 ~ # df -t ceph
> Filesystem      Size  Used Avail Use% Mounted on
> 10.205.119.2:/  404G   62G  343G  16% /mnt/temp
> log3 ~ # ceph -s
>    health HEALTH_OK
>    monmap e1: 3 mons at
> {log21=10.205.118.21:6789/0,log3=10.205.119.2:6789/0,squid86-log12=150.164.100.218:6789/0},
> election epoch 376, quorum 0,1,2 log21,log3,squid86-log12
>    osdmap e15719: 37 osds: 37 up, 37 in
>     pgmap v383025: 9224 pgs: 9224 active+clean; 7829 GB data, 15731 GB
> used, 87614 GB / 100 TB avail
>    mdsmap e283: 1/1/1 up {0=log3=up:active}, 1 up:standby
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
