From: Sage Weil <sage@inktank.com>
Subject: Re: thought on storing bloom (hit) info
Date: Wed, 2 Oct 2013 17:19:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310021711580.12714@cobra.newdream.net>
References: <alpine.DEB.2.00.1310021654060.12714@cobra.newdream.net> <CAPYLRzh06oKo1Ch74GU_Lx9buZDKmp7extv9g53W7FhatFwMfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34158 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3JCATo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 20:19:44 -0400
In-Reply-To: <CAPYLRzh06oKo1Ch74GU_Lx9buZDKmp7extv9g53W7FhatFwMfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 2 Oct 2013, Gregory Farnum wrote:
> On Wed, Oct 2, 2013 at 5:02 PM, Sage Weil <sage@inktank.com> wrote:
> > If we make this a special internal object we need to complicate recovery
> > and namespacing to keep is separate from user data.  We also need to
> > implement a new API for retrieving, trimming, and so forth.
> >
> > Instead, we could just store the in-progress and completed bloom filters
> > (or even explicit hit list) as regular rados objects in a separate
> > namespace.  The namespace could be '.ceph' or similar by default, but
> > configurable in case the user wants something different for some reason.
> >
> > Normal recovery should work unmodified.
> >
> > The normal rados API could be used to fetch (or even delete) old info.
> >
> > I think the main challenge is making an object_locator_t that maps cleanly
> > into a specific PG so that a particular object is always stored exactly
> > with the PG.  This should be a pretty easy change to object_locator_t.
> > In the mapping process, all we're doing is hashing the key string and
> > mixing in the pool hash; here we'd just be able to specify the resulting
> > value explicitly.
> >
> > Thoughts?
> > sage
> 
> PG splitting?

Old objects stay with the parent.  A clever user could look pg parent 
bloom filters if they are looking back in time past the split.

On merge multiple children would end up in the combined PG.  We'd 
need to include the pgid in the object name to avoid having multiple 
objects with the same name and different locators.

> That and other internal mechanisms are already going to need to treat
> it as a special object. I think recovery will as well; what happens if
> we're serving up writes during a long-running recovery but haven't
> gotten to recovering that object yet when we need to persist?

In the simplest case these objects would be created once and never 
modified, in which case nothing would prevent them from being created.  
If they are past the backfill position, backfill targets wouldn't get a 
copy, just like with normal writes.

On (librados) read, we'd recover it immediately, just as we do with normal 
objects.

In the bloom filter case, being limited to immutable objects should be 
fine.  Maybe this would work for other future features that need to store 
extra stuff with the PG, but I'm unsure what that would be right now.  
(Maybe index objects if we ever index on select xattrs?)  

In any case, this seems simpler than special casing a bunch of recovery 
and backend namespaces for special hidden objects and setting up new APIs 
to access them.  OTOH, it doesn't give users absolute reign over their 
namespaces by hiding system objects.  That is seeming less important to 
me now than it once did, though.

sage
