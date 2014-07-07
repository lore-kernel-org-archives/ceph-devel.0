From: Sage Weil <sweil@redhat.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 7 Jul 2014 12:43:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407071242050.24973@cobra.newdream.net>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net> <53BAF752.3080005@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48138 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbaGGTnU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 15:43:20 -0400
In-Reply-To: <53BAF752.3080005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Luis Pabon <lpabon@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 7 Jul 2014, Mark Nelson wrote:
> On 07/07/2014 02:29 PM, Sage Weil wrote:
> > On Mon, 7 Jul 2014, Luis Pabon wrote:
> > > Hi all,
> > >      I am working on OSDMonitor.cc:5325 and wanted to confirm the
> > > following
> > > read_forward cache tier transition:
> > > 
> > >      readforward -> forward || writeback || (any && num_objects_dirty ==
> > > 0)
> > >      forward -> writeback || readforward || (any && num_objects_dirty ==
> > > 0)
> > >      writeback -> readforward || forward
> > > 
> > > Is this the correct cache tier state transition?
> > 
> > That looks right to me.
> > 
> > By the way, I had a thought after we spoke that we probably want something
> > that is somewhere inbetween the current writeback behavior (promote on
> > first read) and the read_forward behavior (never promote on read).  I
> > suspect a good all-around policy is something like promote on second read?
> > This should probably be rolled into the writeback mode as a tunable...
> 
> That would be a good start I think.  What about some kind of scheme that also
> favours promoting small objects over larger ones?  It could be as simple as
> increasing the number of reads necessary to do a promotion based on the object
> size.
> 
> ie something like:
> 
> <= 64k object = 1 read
> <= 512k object = 2 read
> else 3 read
> 
> That would make the behaviour for default RBD object sizes always 3 read, but
> could keep big objects out of the cache tier for RGW.

We don't have enough information to do that right now, since on a miss we 
redirect the client instead of proxying them and never learn what the 
actual object size is.

If/after we start doing proxying for the reads, then lots of other stuff 
becomes possible... but I think we'll need to be careful about choosing 
where to add complexity.

sage
