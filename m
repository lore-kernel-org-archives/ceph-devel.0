From: Sage Weil <sage@inktank.com>
Subject: Re: Refactor DBObjectMap Proposal
Date: Thu, 12 Dec 2013 09:01:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312120858020.26867@cobra.newdream.net>
References: <CACJqLyaxvRF8R51i0atG_GgFvWcWDZMjrzbBwJG0SPiziSKp1g@mail.gmail.com> <alpine.DEB.2.00.1312112117020.4714@cobra.newdream.net> <CACJqLybbLiqv+Z5HZtwVAdYQLe-db2vsb=eO6oXT9qGZ6UNQnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49687 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab3LLRBQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Dec 2013 12:01:16 -0500
In-Reply-To: <CACJqLybbLiqv+Z5HZtwVAdYQLe-db2vsb=eO6oXT9qGZ6UNQnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 12 Dec 2013, Haomai Wang wrote:
> On Thu, Dec 12, 2013 at 1:26 PM, Sage Weil <sage@inktank.com> wrote:
> > [adding cc ceph-devel]

[attempt 2]

> >
> > On Wed, 11 Dec 2013, Haomai Wang wrote:
> >> Hi Sage,
> >>
> >> Since last CDS, you have pointed jobs see below:
> >>
> >> ============================
> >> 2. DBObjectMap: refactor interface
> >>     1. expose underlying KeyValueDB transactions to caller, so they
> >> can bundle several DBObjectMap ops together and capture an entire
> >> ObjectStore::Transaction's worth of work)
> >>     2.expose the user prefixes in a generic way, instead of
> >> hard-coding in the omap, xattr, and various internal namespaces
> >>
> >> 3. stripe file data over keys
> >>     1. Build a class that will implement a file data interface (read
> >> extent, write extent, truncate, zero, etc.) on top of DBObjectMap
> >>     2. stripe data over keys of size X (e.g., 1MB, which seems to be
> >> the limit people are converging around)
> >>     3. store file size information in a metadata key.  maybe this can
> >> be DBObjectMap::Header; maybe not
> >>     4. contemplate future optimizations that put small objects
> >> "inline" in the Header (or equivalent) key
> >> ============================
> >>
> >> I'm interested to implement it and I don't know whether you or others
> >> started to do it. Now I want to describe my idea.
> >
> > Nobody is working on this just yet, although there is a lot of interest in
> > this area so your timing is very good!
> >
> >> According to your comments, I think about implementing strip file data
> >> over keys in KeyValueStore class. Add a field called "userdata" to
> >> DBObjectMap::Header which is explained by caller such as
> >> KeyValueStore. Of course, we need to add CRUD operation interfaces for
> >> "userdata" field. So KeyValueStore will make use of "userdata" to
> >> manage stripped layer. Maybe a metadata table to map offset->key_name.
> >
> > Yes.  My original thought is to make the DBObjectMap type fields a bit
> > more general (instead of the hard-coded #defines), but I don't think it
> > matters too much.
> >
> > For the metadata table, yes eventually.. but I would keep it simple for
> > the first pass and iterate from there.
> >
> >> Although DBObjectMap already implement clone operation on
> >> "USER_PREFIX" keys, I really don't like operations like lookup_parent
> >> which will cause dependent lookup chain resulting to performance
> >> degrade just like librbd. And I suspect that if using the current
> >> DBObjectMap methods to manage cloned objects, it may occur performance
> >> problems.  So DBObjectMap need to expose pure KeyValueDB interfaces
> >> called by KeyValueStore to store stripped keys which is controlled by
> >> a metadata table mentioned above. Others such as xattr and omap
> >> namespace won't be destroyed. Clone operation will be implemented via
> >> DBObjectMap::clone, actual object data won't be changed and only
> >> metadata table referenced to "userdata" will be copied. Any write
> >> operation will be redirected to new key. In other word, it may looks
> >> like librbd did, but here we implement it in ROW not COW.
> >>
> >> The reason to design like above contains:
> >> 1. Export more works to KeyValueStore not DBObjectMap, DBObjectMap is
> >> used by FileStore which will limit big changes
> >
> > Yes; we need to be a bit careful here.  I'm hoping the main changes though
> > are really just moving the transaction create and submit boilerplate in
> > each method into the FileStore callers?
> 
> In my mind, I don't want to change the caller codes such as FileStore.
> It works well now. ;-)

True.  We can also just make a second layer of methods (_foo() instead of 
foo() or someting) that take the transaction as an argument.

Or just fork DBObjectMap entirely so that we don't need to worry about 
breaking FileStore ondisk compatibility; we will likely want/need to do 
something like that eventually anyway!

sage

> >
> >> 2. Read/Write object is a more frequenter operation which different
> >> from OMap or xattr operations, we need more special handler now or
> >> future to optimize.
> >> 3. Different kv backend may have different features just like
> >> FileSystemBackend, we would like to deal with these at KeyValueStore
> >> not DBObjectMap or upper class.
> >> 4. DBObjectMap is a little replicated and maybe not suitable to do more things.
> >
> > I'm not fully following this description, but it sounds like you're
> > thinking about the right issues.  A few comments:
> >
> > - In the ideal case, we'd like to minimize the number of lookups/keys we
> > query to access an object.  This is a bit less important for objects that
> > are cloned (they tend to be snapshots... mostly).
> >
> > - I think it makes sense to make the main header key for an object be able
> > to embed various bits of useful data, like
> >
> >  - all of the xattrs, if there aren't many of them
> >  - the file size
> >  - the file content, if it is small
> >
> > No need for this in the initial implementation, but we should design
> > something that can accomodate it.
> >
> > - It would be nice to capture the striping CRUD stuff in a separate class;
> > a child of DBObjectMap or something similar.  This will make it easy to
> > swap out and/or experiment with different approaches.
> >
> >> So in this proposal, DBObjectMap will serve as a bridge in the front
> >> of KeyValueDB. KeyValueStore mainly use DBObjectMap API to store
> >> stripped object and DBObjectMap::Header to store metadata. If so, my
> >> previous implementation could be fully make use of. :-)
> >
> > That's great news!  Let me know if there is anything we can do to help
> > here.
> >
> > sage
> 
> Thanks for your comments!
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> 
> 
