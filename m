From: Sage Weil <sage@newdream.net>
Subject: Re: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 15:16:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709131513130.24068@piezo.novalocal>
References: <1505314715.4822.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56111 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdIMPQG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 11:16:06 -0400
In-Reply-To: <1505314715.4822.24.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 13 Sep 2017, Jeff Layton wrote:
> I recently hit the problem described in this bug when rolling some new
> tests for cephfs:
> 
>     http://tracker.ceph.com/issues/20988
> 
> While I hit it in a testcase, I suspect something like ganesha or samba
> could also hit this, as they can create several CephContexts in the
> course of their duties and their teardown is not necessarily coordinated
> in any way.
> 
> The problem is basically that the CephContext is a random pile of stuff,
> some of which has an effect on global objects (the lockdep stuff, in
> particular, but there may be more).
> 
> There are a few ways to fix it...we could just ensure that the lockdep
> stuff is handled cleanly, but I wonder...is there any real-world
> use-case for having multiple CephContexts in a single process image?
> 
> It contains stuff like admin sockets, and certain threads are tied to
> it, etc. This seems like the sort of thing that should just have a
> single instance per process. Should we start moving things in that
> direction, or should I look at fixing this another way?

There are a couple of reasons why it's not a singleton:

 - It makes library usage awkward.  Having "global" state in a shared lib 
is an antipattern, so librados was set up with create/destroy functions, 
which are built around the cct.  In practice it means you can instantiate 
multiple independent clients in the same process, which is IMO useful.
 - We would eventually like to host multiple OSD daemons within the same 
process in order to multiplex the network IO across the same connections 
(reducing e.g. RDMA connection count) and allowing more efficient use of 
DPDK/SPDK.  Moving from g_ceph_context -> explicit ccts is a step in that 
direction, and further away from any singletons.

sage
