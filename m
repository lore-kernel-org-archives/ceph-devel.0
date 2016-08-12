From: Sage Weil <sage@newdream.net>
Subject: Re: Fork and RDMA operations
Date: Fri, 12 Aug 2016 13:22:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608121314380.17762@piezo.us.to>
References: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58725 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbcHLNWt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 09:22:49 -0400
In-Reply-To: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vu Pham <vuhuong@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Avner Ben Hanoch <avnerb@mellanox.com>, Oren Duer <oren@mellanox.com>

On Thu, 11 Aug 2016, Vu Pham wrote:
> Hello all,
> 
> The background:
> We have tested scaling with xio messenger and faced multiple *unknown* 
> problems (hard to trace and reproduce). We recently find out that the 
> daemonize/fork support isn't full in ibverbs. It assumes that the parent 
> process will do the RDMA operations. Any child process try to do rdma 
> operations will experience various unexpected problems.
> 
> ceph-osd/ceph-mon/ceph-mds daemonize (fork) after creating messengers.
> Xio messenger will initialize accelio library and register RDMA memory 
> in the 1st call to XioMessenger constructor.
> This situation is very problematic where child process do rdma 
> operations as described above
> 
> http://www.rdmamojo.com/2012/05/24/ibv_fork_init
> http://www.spinics.net/lists/linux-rdma/msg03364.html
> I create this PR which forces to daemonize/fork before creating 
> messenger
> 
> https://github.com/ceph/ceph/pull/10600
> 
> I have tested this patch by bringing up a cluster with 4 nodes, 8 
> osds/node, two monitors and run I/Os (4K - 4M block size) from 4 fio 
> clients.
> 
> Is there any known problem to daemonize/fork before creating messenger?
> Could you help to review and provide feedback?

This more or less works.  The main issue is that we don't catch errors as 
early as we did and a daemon may appear to start and then immediately 
exit without printing an error.

There is a Preforker class in common that is meant to address this (it's 
used by ceph-fuse and ceph-mon already).  It does the fork early, when 
prefork() is called, and keeps stdout/stderr open for an interim period 
until you call preforker.exit() or .daemonize().  Any exit code gets 
passed back to the parent over a socket.  I'm guessing that the mon is 
already working fine since you're just moving the prefork.daemonize() line 
around (the actual fork happened way back at

	https://github.com/vuhuong/ceph-upstream/blob/5cd5546fb7ddb9ef69380476b0a80038ba74a405/src/ceph_mon.cc#L500

) and you just need to make ceph_osd.cc and ceph_mds.cc use Preforker in a 
similar way.

sage
