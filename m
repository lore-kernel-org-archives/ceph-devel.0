From: Sage Weil <sage@newdream.net>
Subject: Re: cmon daemon dies immediately
Date: Tue, 10 Aug 2010 13:43:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008101342120.9792@cobra.newdream.net>
References: <loom.20100810T194051-273@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52048 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0HJUnR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 16:43:17 -0400
In-Reply-To: <loom.20100810T194051-273@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shyamali Mukherjee <smukher@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hi Shyamali,

What's the last thing you see in /usr/src/ceph/ceph-0.20.2/src/out/mon.0.log?

Also, have you tried the newer 0.21 release?

sage


On Tue, 10 Aug 2010, Shyamali Mukherjee wrote:

> In an effort to try ceph and hadoop I am facing the problem where "cmon"  dies
> immediately. I have debug level set to 20. 
> 
> ./cmon -i 0 -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  **          testing and review.  Do not trust it with important data.       **
> starting mon0 at 192.168.2.118:6789/0 mon_data /data/mon0 fsid
> af52ab64-5ad2-9e9f-1e33-12f340b7d10c
> [root@recline18 src]# ps -aux | grep ceph
> Warning: bad syntax, perhaps a bogus '-'? See /usr/share/doc/procps-3.2.7/FAQ
> root      3633  0.0  0.0      0     0 ?        S    18:17   0:00 [ceph-msgr/0]
> root      3634  0.0  0.0      0     0 ?        S    18:17   0:00 [ceph-msgr/1]
> root      3635  0.0  0.0      0     0 ?        S    18:17   0:00 [ceph-msgr/2]
> root      3636  0.0  0.0      0     0 ?        S    18:17   0:00 [ceph-msgr/3]
> root      4344  0.0  0.0 148164  1636 ?        Ssl  18:20   0:00 ./cmds -i 0 -c
> ceph.conf
> root      4767  0.0  0.1 525312  2292 ?        Ssl  18:25   0:00
> /usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.4510
> root      4966  0.0  0.1 606308  2332 ?        Ssl  18:25   0:00
> /usr/local/bin/cosd -i 0 -c /tmp/ceph.conf.4510
> root      5299  0.0  0.0  61252   732 pts/0    S+   18:33   0:00 grep ceph
> 
> 
> **** I don't see cmon running anymore.. I tried to run it under "gdb" and I see 
> no errors.
> 
> Here is copy of my ceph.conf file:
> 
> 
> ; global
> [global]
> 	; enable secure authentication
> 
> 	
> 	log dir = /usr/src/ceph/ceph-0.20.2/src/out
> 	logger dir = /usr/src/ceph/ceph-0.20.2/src/log
> ; monitors
> 
> [mon]
> 	mon data = /data/mon$id
> 
> 	; some minimal logging (just message traffic) to aid debugging
> 	debug ms = 1
> 	debug mon = 20
> 
> [mon0]
> 	host = r18
> 	mon addr = 192.168.2.118:6789
> 
> 
> ; mds
> ;  You need at least one.  Define two to get a standby.
> [mds]
> 	; where the mds keeps it's secret encryption keys
> 	debug ms = 1
> 	debug mds = 20
> 
> [mds0]
> 	host = r18
> 
> 
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
> 	debug ms = 1
> 	debug osd = 25
> 	debug journal = 20
> 	debug filestore = 20
> 
> 	; This is where the btrfs volume will be mounted.
> 	osd data = /data/osd$id
> 	osd journal = /data/osd$id/journal
> 	osd journal size = 100
> 
> [osd0]
> 	host = r18
> 
> 	btrfs devs = /dev/sda3
> 
> [osd1]
> 	host = r19
> 	btrfs devs = /dev/sda3
> 
> [osd2]
> 	host = r20
> 	btrfs devs = /dev/sda3
> 
> 
> **** Other daemons are running fine *****
> 
> In last 2 weeks I was able to have thing running for say 2 hours where "mount
> ceph" worked and afterwards it hangs and I found it is due to "monitor" getting
> killed.
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
