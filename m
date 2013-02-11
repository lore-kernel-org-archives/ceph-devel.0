From: Sage Weil <sage@inktank.com>
Subject: Re: IPv6 address confusion in OSDs
Date: Mon, 11 Feb 2013 05:59:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302110557470.5429@cobra.newdream.net>
References: <20760.44431.980428.594955@Simons-MacBook-Air-33597.local> <alpine.DEB.2.00.1302110540510.5429@cobra.newdream.net> <20760.63564.116948.748465@Simons-MacBook-Air-33597.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35462 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756466Ab3BKN7c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 08:59:32 -0500
In-Reply-To: <20760.63564.116948.748465@Simons-MacBook-Air-33597.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Leinen <simon.leinen@switch.ch>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Feb 2013, Simon Leinen wrote:
> Sage Weil writes:
> > On Mon, 11 Feb 2013, Simon Leinen wrote:
> >> We run a ten-node 64-OSD Ceph cluster and use IPv6 where possible.
> 
> I should have mentioned that this is under Ubuntu 12.10 with version
> 0.56.1-1quantal of the ceph packages.  Sorry about the omission.
> 
> >> Today I noticed this error message from an OSD just after I restarted
> >> it (in an attempt to resolve an issue with some "stuck" pgs that
> >> included that OSD):
> >> 
> >> 2013-02-11 09:24:57.232811 osd.35 [ERR] map e768 had wrong cluster addr ([2001:620:0:6::106]:6822/1990 != my [fe80::67d:7bff:fef1:78b%vlan301]:6822/1990)
> >> 
> >> These two addresses belong to the same interface:
> >> 
> >> root@h1:~# ip -6 addr list dev vlan301
> >> 7: vlan301@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 
> >> inet6 2001:620:0:6::106/64 scope global 
> >> valid_lft forever preferred_lft forever
> >> inet6 fe80::67d:7bff:fef1:78b/64 scope link 
> >> valid_lft forever preferred_lft forever
> >> 
> >> 2001:620:... is the global-scope address, and this is how OSDs are
> >> addressed in our ceph.conf.  fe80:... is the link-local address that
> >> every IPv6 interface has.  Shouldn't these be treated as equivalent?
> 
> > Is this OSD by chance sharing a host with one of the monitors?
> 
> Yes, indeed! We have five monitors, i.e. every other server runs a
> ceph-mon in addition to the 4-9 ceph-osd processes each server has.
> This (h1) is one of the servers that has both.
> 
> > The 'my address' value is learned by looking at the socket we connect to 
> > the monitor with...
> 
> Thanks for the hint! I'll look at the code and try to understand
> what's happening and how this could be avoided.
> 
> The cluster seems to have recovered from this particular error by
> itself. 

That makes sense if the trigger here is it random choosely to connect to 
the local monitor first and learning the address that way.  Adding 
'debug ms = 20' to your ceph.conf may give a hint.. looked for a 'learned 
by addr' message (or somethign similar) right at startup time.

> But in general, when I reboot servers, there's often some pgs
> that remain stuck, and I have to restart some OSDs until ceph -w shows
> everything as "active+clean".

Note that 'ceph osd down NN' may give similar results as restarting the 
daemon.

> (Our network setup is somewhat complex, with IPv6 over VLANs over
> "bonded" 10GEs redundantly connected to a pair of Brocade switches
> running VLAG (something like multi-chassis Etherchannel).  So it's
> possible that there are some connectivity issues hiding somewhere.)

Let us know what you find!
sage


> -- 
> Simon.
> 
> 
