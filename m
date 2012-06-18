From: Sage Weil <sage@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 11:01:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206181059040.11790@cobra.newdream.net>
References: <4FDB9FBB.9000807@inktank.com>
 <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
 <4FDF620E.7030704@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2FRSBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:01:54 -0400
In-Reply-To: <4FDF620E.7030704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 18 Jun 2012, Josh Durgin wrote:
> > >     $ rbd copyup pool2/child1
> > 
> > Does "copyup" make sense to everyone? Every time you say it, my brain
> > needs to flip the image inside the other way around -- I naturally
> > imagine a tree with the parent at the top, and children and
> > grandchildren down from it, but then I can't call that operation
> > "copyup" without wrecking my mental image.
> > 
> > I also can't seem to google good evidence that the term would be in
> > widespread use in the enterprisey block storage world, outside of the
> > unionfs world.. What do people call the un-dedupping, un-thinning of
> > copy-on-write thin provisioning?
> > 
> > "unshare"?
> 
> I'm not sure what best term is, but there's probably something better than
> copyup.

"flatten"?  My mental model is stuck on the "layering" analogy, where the 
child is a copy-on-write layer on top of a read-only parent.

Someday we may want to support the ability to add a parent to an existing 
image and do a sort of "dedup", so having an opposite for whatever term we 
pick would be a bonus.

sage
