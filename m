From: Sage Weil <sage@newdream.net>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Sun, 11 Sep 2011 20:14:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109112004390.25151@cobra.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net> <4E68CD7E.2050704@redhat.com>
 <Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net> <4E69CBDB.1000401@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60532 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab1ILDIi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Sep 2011 23:08:38 -0400
In-Reply-To: <4E69CBDB.1000401@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, yehudasa@gmail.com

On Fri, 9 Sep 2011, Kevin Wolf wrote:
> Am 08.09.2011 18:36, schrieb Sage Weil:
> > On Thu, 8 Sep 2011, Kevin Wolf wrote:
> >> Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
> >>> The following set of patches improve the qemu-img conversion process
> >>> performance. When using a higher latency backend, small writes have a
> >>> severe impact on the time it takes to do image conversion. 
> >>> We switch to using async writes, and we avoid splitting writes due to
> >>> holes when the holes are small enough.
> >>>
> >>> Yehuda Sadeh (2):
> >>>   qemu-img: async write to block device when converting image
> >>>   qemu-img: don't skip writing small holes
> >>>
> >>>  qemu-img.c |   34 +++++++++++++++++++++++++++-------
> >>>  1 files changed, 27 insertions(+), 7 deletions(-)
> >>>
> >>
> >> This doesn't seem to be against git master or the block tree. Please rebase.
> >>
> >> I think that commit a22f123c may obsolete your patch 2/2.
> > 
> > With git.kernel.org down, where should I be looking for the latest 
> > upstream?
> 
> qemu has never been on kernel.org. The interesting repositories for you are:
> 
> * Upstream: git://git.qemu.org/qemu.git master
> * Block development branch: git://repo.or.cz/qemu/kevin.git block

Oh right.  I've been working from qemu-kvm.git.  

I've done some (still minimal) testing, and it looks like the combination 
of a22f123c and the new writeback/flush stuff in librbd gets the same 
result as doing async io explicitly from qemu-img.c.  Want to take a look, 
Yehuda?  It still defaults to off, so you'll need to add 
rbd_writeback_window=8000000 or similar to the rbd device string.

Thanks!
sage
