From: Sage Weil <sage@inktank.com>
Subject: Re: ceph init script does not start
Date: Sat, 14 Jul 2012 07:42:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net>
References: <50012AF1.4040300@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60215 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2GNOmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 10:42:35 -0400
In-Reply-To: <50012AF1.4040300@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 14 Jul 2012, Xiaopong Tran wrote:
> Hi,
> 
> I'm getting this funny issue. I had setup two test clusters, and
> mkcephfs and the ceph start up script worked just fine. We are
> now ready to go production, we have 6 nodes, with 10 disks
> each, and one osd per disk, with 3 mds and 3 mons.
> 
> The script mkcephfs ran without problem, everything was created
> properly. See attached log file. However, when I run
> 
> /etc/init.d/ceph start
> 
> nothing happens, not even a line of message, not on concole,
> neither in system log.
> 
> But can I manually start up each individual osd, mds, and mon.

This is usually related to the 'host = ...' lines in ceph.conf.  They need 
to match the output of the `hostname` command in order for that daemon to 
be automatically started or stopped.

If that appears correct, you can try running with -x (sh -x 
/etc/init.d/ceph start) to see exactly what the script it 
getting/comparing for the host.

sage


> 
> Here is more information:
> 
> root@s100001:~# ceph health
> HEALTH_OK
> root@s100001:~# ceph -s
>    health HEALTH_OK
>    monmap e1: 3 mons at
> {a=10.1.0.11:6789/0,b=10.1.0.13:6789/0,c=10.1.0.15:6789/0}, election epoch 6,
> quorum 0,1,2 a,b,c
>    osdmap e24: 60 osds: 60 up, 60 in
>     pgmap v143: 11520 pgs: 11520 active+clean; 8730 bytes data, 242 GB used,
> 83552 GB / 83794 GB avail
>    mdsmap e6: 1/1/1 up {0=c=up:active}, 2 up:standby
> 
> root@s100001:~# ceph -v
> ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
> root@s100001:~#
> 
> The only difference this time vs the time when I setup
> the test clusters was that, for the test clusters,
> I started with 0.47.3 (and one of the cluster did
> a rolling upgrade to 0.48), but for this, all machines
> started from fresh, with 0.48.
> 
> This is on Debian wheezy.
> 
> Can someone give a hint where else can I look into?
> 
> Thanks
> 
> Xiaopong
> 
