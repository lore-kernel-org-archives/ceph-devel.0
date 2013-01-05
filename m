From: Sage Weil <sage@inktank.com>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 5 Jan 2013 09:56:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301050955150.15430@cobra.newdream.net>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net> <50E85EB1.8060803@profihost.ag> <50E86008.30000@profihost.ag> <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net>
 <50E86708.6070909@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45619 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab3AER4C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 12:56:02 -0500
In-Reply-To: <50E86708.6070909@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 5 Jan 2013, Stefan Priebe wrote:
> Hi,
> Am 05.01.2013 18:40, schrieb Sage Weil:
> > On Sat, 5 Jan 2013, Stefan Priebe wrote:
> > > Hi,
> > > Am 05.01.2013 18:11, schrieb Stefan Priebe:
> > > > Hi,
> > > > 
> > > > i just stopped EVERYTHING and have now started ALL osds again. It seems
> > > > to recover now. But here is the output.
> > > Just an illusion. Still hangs.
> > 
> > Can you turn up logging, or attach with gdb, so we can see what they are
> > doing with all that CPU?
> 
> Right now i've imported the OLD crushmap and i've no stale PGs nor hanging
> OSDs anymore.
> 
> But my rbd images are gone ?!
> 
> [1202: ~]# rbd -p kvmpool1 ls
> [1202: ~]#

Oh.. I think this is related to the librados/librbd compatibility issue I 
mentioned yesterday.  Please make sure the clients (librados, librbd) are 
also running the latest testing branch.

sage
