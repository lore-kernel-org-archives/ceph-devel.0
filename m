From: Dave Chinner <david@fromorbit.com>
Subject: Re: file journal fadvise
Date: Tue, 2 Dec 2014 13:01:35 +1100
Message-ID: <20141202020135.GL9561@dastard>
References: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net>
 <CALurOm2tEV=RqN21eFJvfU1zTtJkbz2gHDCk_Ntsy4oz9iwHoA@mail.gmail.com>
 <alpine.DEB.2.00.1411301922220.352@cobra.newdream.net>
 <547CBEFA.3000204@redhat.com>
 <alpine.DEB.2.00.1412011122020.3471@cobra.newdream.net>
 <547CEC36.6070309@redhat.com>
 <20141201225100.GO16151@dastard>
 <alpine.DEB.2.00.1412011559200.3471@cobra.newdream.net>
 <20141202003239.GP16151@dastard>
 <alpine.DEB.2.00.1412011719070.3471@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:3136 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753861AbaLBCBx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Dec 2014 21:01:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1412011719070.3471@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: mnelson@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, xfs@oss.sgi.com, =?utf-8?B?6ams5bu65pyL?= <majianpeng@gmail.com>

On Mon, Dec 01, 2014 at 05:24:46PM -0800, Sage Weil wrote:
> On Tue, 2 Dec 2014, Dave Chinner wrote:
> > On Mon, Dec 01, 2014 at 04:12:03PM -0800, Sage Weil wrote:
> > > On Tue, 2 Dec 2014, Dave Chinner wrote:
> > > > What behaviour are you wanting for a journal file? it sounds like
> > > > you want it to behave like a wandering log: automatically allocating
> > > > it's next block where-ever the previous write of any kind occurred?
> > > 
> > > Precisely.  Well, as long as it is adjacent to *some* other scheduled 
> > > write, it would save us a seek.  The real question, I guess, is whether 
> > > there is an XFS allocation mode that makes no attempt to avoid 
> > > fragmentation for the file and that chooses something adjacent to other 
> > > small, newly-written data during delayed allocation.
> > 
> > Ok, so what is the most common underlying storage you need to
> > optimise for? Is it raid5/6 where a small write will trigger a
> > larger RMW cycle and so proximity rather than exact adjacency
> > matters, or is it raid 0/1/jbod where exact adjacency is the only
> > way to avoid a seek?
> 
> The common case is a single raw disk.

Ok, so it's an exact match that is really required. I'll have a
think about it.

> > > It's a circular file, usually a few GB in site, written sequentially with 
> > > a range of small to large (block-aligned) write sizes, and (for all 
> > > intents and purposes) is never read.  We periodically overwrite the first 
> > > block with recent start and end pointers and other metadata.
> > 
> > Ok, so it's just another typical WAL file. ;)
> 
> Nothing to lose sleep over if this mode doesn't already exist, but I 
> expect a fair number of applications could make use of this.
> 
> FWIW, while I am already distracting you from useful things, I suspect 
> (batched) aio_fsync would be a bigger win for us and probably a smaller 
> investment of effort.  :)

If you want to test a patch that implements a basic, simple
implementation of aio_fsync:

http://oss.sgi.com/archives/xfs/2014-06/msg00214.html

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
