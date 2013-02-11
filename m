From: Sage Weil <sage@inktank.com>
Subject: Re: IPv6 address confusion in OSDs
Date: Mon, 11 Feb 2013 05:41:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302110540510.5429@cobra.newdream.net>
References: <20760.44431.980428.594955@Simons-MacBook-Air-33597.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35331 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab3BKNle (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 08:41:34 -0500
In-Reply-To: <20760.44431.980428.594955@Simons-MacBook-Air-33597.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Leinen <simon.leinen@switch.ch>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Feb 2013, Simon Leinen wrote:
> We run a ten-node 64-OSD Ceph cluster and use IPv6 where possible.
> 
> Today I noticed this error message from an OSD just after I restarted
> it (in an attempt to resolve an issue with some "stuck" pgs that
> included that OSD):
> 
> 2013-02-11 09:24:57.232811 osd.35 [ERR] map e768 had wrong cluster addr ([2001:620:0:6::106]:6822/1990 != my [fe80::67d:7bff:fef1:78b%vlan301]:6822/1990)
> 
> These two addresses belong to the same interface:
> 
> root@h1:~# ip -6 addr list dev vlan301
> 7: vlan301@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 
>     inet6 2001:620:0:6::106/64 scope global 
>        valid_lft forever preferred_lft forever
>     inet6 fe80::67d:7bff:fef1:78b/64 scope link 
>        valid_lft forever preferred_lft forever
> 
> 2001:620:... is the global-scope address, and this is how OSDs are
> addressed in our ceph.conf.  fe80:... is the link-local address that
> every IPv6 interface has.  Shouldn't these be treated as equivalent?

Is this OSD by chance sharing a host with one of the monitors?

The 'my address' value is learned by looking at the socket we connect to 
the monitor with...

sage
