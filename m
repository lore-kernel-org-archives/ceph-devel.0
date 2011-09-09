From: Sage Weil <sage@newdream.net>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Thu, 8 Sep 2011 21:52:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109082143100.27481@cobra.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
 <20110908075628.GA23849@stefanha-thinkpad.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60863 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1IIEqX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 00:46:23 -0400
In-Reply-To: <20110908075628.GA23849@stefanha-thinkpad.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, yehudasa@gmail.com

On Thu, 8 Sep 2011, Stefan Hajnoczi wrote:
> On Wed, Sep 07, 2011 at 04:06:51PM -0700, Yehuda Sadeh wrote:
> > The following set of patches improve the qemu-img conversion process
> > performance. When using a higher latency backend, small writes have a
> > severe impact on the time it takes to do image conversion. 
> > We switch to using async writes, and we avoid splitting writes due to
> > holes when the holes are small enough.
> > 
> > Yehuda Sadeh (2):
> >   qemu-img: async write to block device when converting image
> >   qemu-img: don't skip writing small holes
> > 
> >  qemu-img.c |   34 +++++++++++++++++++++++++++-------
> >  1 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.7.5.1
> 
> This has nothing to do with the patch itself, but I've been curious
> about the existence of both a QEMU and a Linux kernel rbd block driver.
> 
> The I/O latency with qemu-img has been an issue for rbd users.  But they
> have the option of using the Linux kernel rbd block driver, where
> qemu-img can take advantage of the page cache instead of performing
> direct I/O.
>
> Does this mean you intend to support both QEMU block/rbd.c and Linux
> drivers/block/rbd.c?  As a user I would go with the Linux kernel driver
> instead of the QEMU block driver because it offers page cache and host
> block device features.  On the other hand a userspace driver is nice
> because it does not require privileges.

We intend to support both drivers, yes.  The native qemu driver is 
generally more convenient because there is no kernel dependency, so we 
want to make qemu-img perform reasonably one way or another.

There are plans to implement some limited buffering (and flush) in librbd 
to make the device behave a bit more like a disk with a cache.  That will 
mask the sync write latency, but I suspect that doing these writes using 
the aio interface (and ignoring small holes) will help everyone...

sage
