From: Sage Weil <sage@inktank.com>
Subject: Re: mds: first stab at lookup-by-ino problem/soln description
Date: Wed, 16 Jan 2013 17:17:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301161715090.17435@cobra.newdream.net>
References: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net> <CAPYLRzg8j02fgMBC1cgUnot4XH4y--BR=PnbLo+J-RUkPBVpGQ@mail.gmail.com> <CAKMAVE9Y4C4VvGzXL3kS5nCpqzFMOO43m2XRgwre7OLXz+nvRQ@mail.gmail.com>
 <CAPYLRzhoWNj1gyjxDiasF6gCJvLUMkdLAQ8m0_EY+02+cTFT1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52672 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab3AQBRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 20:17:52 -0500
In-Reply-To: <CAPYLRzhoWNj1gyjxDiasF6gCJvLUMkdLAQ8m0_EY+02+cTFT1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 16 Jan 2013, Gregory Farnum wrote:
> On Wed, Jan 16, 2013 at 3:54 PM, Sam Lang <sam.lang@inktank.com> wrote:
> >
> > On Wed, Jan 16, 2013 at 3:52 PM, Gregory Farnum <greg@inktank.com> wrote:
> >>
> >> My biggest concern with this was how it worked on cluster with
> >> multiple data pools, and Sage's initial response was to either
> >> 1) create an object for each inode that lives in the metadata pool,
> >> and holds the backtraces (rather than putting them as attributes on
> >> the first object in the file), or
> >> 2) use a more sophisticated data structure, perhaps built on Eleanor's
> >> b-tree project from last summer
> >> (http://ceph.com/community/summer-adventures-with-ceph-building-a-b-tree/)
> >>
> >> I had thought that we could just query each data pool for the object,
> >> but Sage points out that 100-pool clusters aren't exactly unreasonable
> >> and that would take quite a lot of query time. And having the
> >> backtraces in the data pools significantly complicates things with our
> >> rules about setting layouts on new files.
> >>
> >> So this is going to need some kind of revision, please suggest
> >> alternatives!
> >
> >
> > Correct me if I'm wrong, but this seems like its only an issue in the NFS
> > reexport case, as fsck can walk through the data objects in each pool (in
> > parallel?) and verify back/forward consistency, so we won't have to guess
> > which pool an ino is in.
> >
> > Given that, if we could stuff the pool id in the ino for the file returned
> > through the client interfaces, then we wouldn't have to guess.
> >
> > -sam
> 
> I'm not familiar with the interfaces at work there. Do we have a free
> 32 bits we can steal in order to do that stuffing? (I *think* it would
> go in the NFS filehandle structure rather than the ino, right?)

Right, there is at least 8 more bytes in a standard fh (16 bytes iirc) to 
stuff whatever we want into.

> We would need to also store that information in order to eventually
> replace the anchor table, but of course that's much easier to deal
> with. If we can just do it this way, that still leaves handling files
> which don't have any data written yet ? under our current system,
> users can apply a data layout to any inode which has not had data
> written to it yet. Unfortunately that gets hard to deal with if a user
> touches a bunch of files and then comes back to place them the next
> day. :/ I suppose un-touched files could have the special property
> that their lookup data is stored in the metadata pool and it gets
> moved as soon as they have data ? in the typical case files are
> written right away and so this wouldn't be any more writes, just a bit
> more logic.

We can also change the semantics, here.  It could be that you have to 
specify the file's layout on create, and can't after it was created.  
Otherwise you get the directory/subtree's layout.  We could store the pool 
with the remote dentry link, for instance, and we could stick it in the 
fh.  So the <ino, pool> is really the "locator" that you would need.

That could work...

sage
