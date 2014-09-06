From: Sage Weil <sweil@redhat.com>
Subject: Re: ms_tcp_nodelay no effect on kernel-rbd
Date: Sat, 6 Sep 2014 06:22:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409060621010.17200@cobra.newdream.net>
References: <9E914F5BD7F48A4782456CEB550A4228061207A0@SACMBXIP02.sdcorp.global.sandisk.com> <CALFYKtAwobOy9B0-=Kpqi680=GG-+Oogp3PB4DMPkyfHAZR9VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaIFNW5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Sep 2014 09:22:57 -0400
In-Reply-To: <CALFYKtAwobOy9B0-=Kpqi680=GG-+Oogp3PB4DMPkyfHAZR9VQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 4 Sep 2014, Ilya Dryomov wrote:
> On Thu, Sep 4, 2014 at 3:39 PM, Chaitanya Huilgol
> <Chaitanya.Huilgol@sandisk.com> wrote:
> > Hi,
> >
> > In our benchmarking tests we observed that the ms_tcp_nodelay in ceph.conf option is not affecting the kernel rbd and as expected we see poor latency numbers for lower queue depths and 4K rand reads. There is significant increase in latency from qd=2  to 24 and starts tapering down for higher queue depths.
> > We did not find relevant kernel_setsockopt  with TCP_NODELAY in the kernel RBD/libceph (messenger.c) source. Unless we are missing something, looks like currently the kernel RBD is not setting this and this is affecting latency numbers are lower queue depths.
> >
> > I have tested with userspace fio(rbd engine) and rados bench and we see similar latency behavior when ms_tcp_nodelay is set to false. However setting this to true gives consistent low latency numbers for all queue depths
> >
> > Any ideas/thoughts on this?
> >
> > OS Ubuntu 14.04
> > Kernel: 3.13.0-24-generic #46-Ubuntu SMP
> > Ceph: Latest Master
> 
> No, we don't set TCP_NODELAY in the kernel client, but I think we can
> add it as a rbd map/mount option.  Sage?

We definitely can, and I think more importantly it should be on by 
default, as it is in userspace.  I'm surpised we missed that.  :( IIRC we 
are carefully setting the MORE (or CORK?) flag on all but the last write 
for a message, but I take it there is a socket-level option we missed?

sage
