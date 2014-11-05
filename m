From: Sage Weil <sage@newdream.net>
Subject: Re: inode64 mount option for XFS
Date: Wed, 5 Nov 2014 05:01:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411050501150.15135@cobra.newdream.net>
References: <545774FA.2070102@42on.com> <alpine.DEB.2.00.1411030619220.15135@cobra.newdream.net> <54579213.5070900@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58410 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbaKENBs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 08:01:48 -0500
In-Reply-To: <54579213.5070900@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 3 Nov 2014, Wido den Hollander wrote:
> On 11/03/2014 03:20 PM, Sage Weil wrote:
> > On Mon, 3 Nov 2014, Wido den Hollander wrote:
> >> Hi,
> >>
> >> While look at init-ceph and ceph-disk I noticed a discrepancy between them.
> >>
> >> init-ceph mounts XFS filesystems with rw,noatime,inode64, but
> >> ceph-disk(-active) with rw,noatime
> >>
> >> As inode64 gives the best performance, shouldn't ceph-disk do the same?
> > 
> > I noticed this a while back but didn't finish fixing it.. can you take a 
> > look at wip-xfs-inode64 and see if it looks right?
> >  
> 
> Looks good to me. Simple fix, but that should do it.

..and I just realized this is already merged into giant.  Pushed a 
backport to the firefly branch.

Thanks!
sage
