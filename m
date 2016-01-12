From: Sage Weil <sage@newdream.net>
Subject: Re: 7915 is not resolved
Date: Tue, 12 Jan 2016 08:24:01 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601120821210.27580@cpach.fuggernut.com>
References: <CAFUG7Cd4KQRCCYamWQNnGUphY_OCXyeuqbK6DVcWT7AKko5=VA@mail.gmail.com> <alpine.DEB.2.11.1601111224120.27580@cpach.fuggernut.com> <CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com> <20160111190619.GA22809@localhost>
 <CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com> <CAFUG7CcudK5zu0eezuTmZrsakE4s-oHyPss3cubSRL5txQmA9Q@mail.gmail.com> <20160112065305.GA16215@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934757AbcALNX7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 08:23:59 -0500
In-Reply-To: <20160112065305.GA16215@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Boris Lukashev <blukashev@sempervictus.com>, ceph-devel@vger.kernel.org

On Tue, 12 Jan 2016, Mykola Golub wrote:
> On Mon, Jan 11, 2016 at 09:00:18PM -0500, Boris Lukashev wrote:
> > In case anyone is following the mailing list later on, we spoke in IRC
> > and Sage provided a patch - http://fpaste.org/309609/52550203/
> 
> > diff --git a/src/osd/PG.cc b/src/osd/PG.cc
> > index dc18aec..f9ee23c 100644
> > --- a/src/osd/PG.cc
> > +++ b/src/osd/PG.cc
> > @@ -135,8 +135,16 @@ void PGPool::update(OSDMapRef map)
> >    name = map->get_pool_name(id);
> >    if (pi->get_snap_epoch() == map->get_epoch()) {
> >      pi->build_removed_snaps(newly_removed_snaps);
> > -    newly_removed_snaps.subtract(cached_removed_snaps);
> > -    cached_removed_snaps.union_of(newly_removed_snaps);
> > +    interval_set<snapid_t> intersection;
> > +    intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
> > +    if (!(intersection == cached_removed_snaps)) {
> > +      newly_removed_snaps.subtract(cached_removed_snaps);
> 
> Sage, won't it still violate the assert?
> "intersection != cached_removed_snaps" means that cached_removed_snaps
> contains snapshots missed in newly_removed_snaps, and we can't subtract?

Oops, yeah, just remote the !.

As you can see the problem is that the OSDMap's removed snaps shrank 
somehow.  If you crank up logging you can see what the competing sets 
are.

An alternative fix/hack would be to modify the monitor to allow the 
snapids that were previously in the set to be added back into the OSDMap.  
That's arguably a better fix, although it's a bit more work.  But, even 
then, something like the above will be needed since there are still 
OSDMaps in the history where the set is smaller.

sage

> 
> > +      cached_removed_snaps.union_of(newly_removed_snaps);
> > +    } else {
> > +      lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << " cached_removed_snaps shrank from " << cached_removed_snaps << dendl;
> > +      cached_removed_snaps = newly_removed_snaps;
> > +      newly_removed_snaps.clear();
> > +    }
> >      snapc = pi->get_snap_context();
> >    } else {
> >      newly_removed_snaps.clear();
> 
> -- 
> Mykola Golub
>  
> 
> 
