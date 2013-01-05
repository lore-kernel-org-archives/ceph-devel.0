From: Sage Weil <sage@inktank.com>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 5 Jan 2013 09:40:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net> <50E85EB1.8060803@profihost.ag> <50E86008.30000@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45504 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab3AERkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 12:40:23 -0500
In-Reply-To: <50E86008.30000@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 5 Jan 2013, Stefan Priebe wrote:
> Hi,
> Am 05.01.2013 18:11, schrieb Stefan Priebe:
> > Hi,
> > 
> > i just stopped EVERYTHING and have now started ALL osds again. It seems
> > to recover now. But here is the output.
> Just an illusion. Still hangs.

Can you turn up logging, or attach with gdb, so we can see what they are 
doing with all that CPU?

s


> 
> # ceph -s
>    health HEALTH_WARN 934 pgs degraded; 23 pgs down; 1887 pgs peering; 1330
> pgs stale; 670 pgs stuck inactive; 882 pgs stuck stale; 7632 pgs stuck
> unclean; recovery 4811/79122 degraded (6.080%)
>    monmap e1: 3 mons at
> {a=10.255.0.100:6789/0,b=10.255.0.101:6789/0,c=10.255.0.102:6789/0}, election
> epoch 1996, quorum 0,1,2 a,b,c
>    osdmap e8393: 24 osds: 24 up, 24 in
>     pgmap v2212487: 7632 pgs: 475 peering, 4013 active+remapped, 18
> down+peering, 490 active+degraded, 798 stale+active+remapped, 1
> active+replay+degraded, 1305 remapped+peering, 84 stale+remapped+peering, 5
> stale+down+remapped+peering, 364 stale+active+degraded+remapped, 79
> stale+active+replay+degraded+remapped; 152 GB data, 314 GB used, 5021 GB /
> 5336 GB avail; 4811/79122 degraded (6.080%)
>    mdsmap e1: 0/0/1 up
> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
