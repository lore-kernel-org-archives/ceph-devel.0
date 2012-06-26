From: Sage Weil <sage@inktank.com>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 09:02:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206260902100.12113@cobra.newdream.net>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
 <20120626081442.GA12789@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55219 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab2FZQC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 12:02:56 -0400
In-Reply-To: <20120626081442.GA12789@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Jun 2012, Christoph Hellwig wrote:
> On Mon, Jun 25, 2012 at 03:11:17PM -0700, Sage Weil wrote:
> > On Sat, 23 Jun 2012, Stefan Priebe wrote:
> > > Hi,
> > > 
> > > i got stuck while selecting the right FS for ceph / RBD.
> > > 
> > > XFS:
> > > - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
> > 
> > There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla 
> > 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.
> 
> Stefan, which deadlock is this, did you report it to the XFS list?
> 
> Sage, which lockdep noise?

There are two versions of the warning at 

	http://tracker.newdream.net/issues/2523

It hit it several times per night; very reproducible.

Thanks!
sage

