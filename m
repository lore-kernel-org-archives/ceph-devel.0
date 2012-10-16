From: Sage Weil <sage@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Tue, 16 Oct 2012 14:35:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210161430130.5342@cobra.newdream.net>
References: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net> <CAPYLRzh2edEpdBEd0zX-UtVV6h6NgYnA7X=1pCrkEyUxyQVGEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60443 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab2JPVfT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:35:19 -0400
In-Reply-To: <CAPYLRzh2edEpdBEd0zX-UtVV6h6NgYnA7X=1pCrkEyUxyQVGEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 16 Oct 2012, Gregory Farnum wrote:
> On Tue, Oct 16, 2012 at 2:17 PM, Sage Weil <sage@inktank.com> wrote:
> > Hey-
> >
> > One of the design goals of the ceph fs was to keep metadata separate from
> > data.  This means, among other things, that when a client is creating a
> > bunch of files, it creates the inode via the mds and writes the file data
> > to the OSD, but no mds->osd interaction is necessary.
> >
> > One of the challenges we currently have is that it is difficult to lookup
> > an inode by ino.  Normally clients traverse the hierarchy to get there, so
> > things are fine for native ceph clients, but when reexporting via NFS we
> > can get ESTALE because we an ancient nfs file handle can be presented and
> > the ceph MDS won't know where to find it.  We have a similar problem with
> > the fsck design in that it is not always possible to discover orphaned
> > children of directory that was somehow lost.
> >
> > One option is to put an ancestor xattr on the first object for each file,
> > similar to what we do for directories.  This basically means that each
> > file creation will be followed (eventually) by a setxattr osd operation.
> > This used to scare me, but now it's seeming like a pretty small price to
> > pay for robust NFS reexport and additional information for fsck to
> > utilize.
> 
> Can you talk about this in a bit more detail? Do you expect the
> clients or the MDS to be doing the setxattr? What about doing it used
> to scare you?

For untarring small files, it doubles the number of osd operations, and 
means we have to think about the setxattr timing wrt warm caches, etc.  

> > It's also nice because it means we could get rid of the anchor table (used
> > for locating files with multiple hard links) entirely and use the
> > ancestore xattrs instead.  That means one less thing to fsck, and avoids
> > having to invest any time in making the anchor table effectively scale (it
> > currently doesn't).
> 
> Hurray! I'm not sure how this directly lets us get rid of the anchor
> table, though. Is your plan to just stick the inode in every directory
> and then mark it so everything that does a stat on that inode goes to
> the inode, grabs its primary location out of the inode, and then do a
> lookup there? That seems a bit circuitous for a lot of operations...

We would build a generic lookup_by_ino framework based on these xattrs 
(first try local mds, then try object xattrs, then try other mds caches, 
then try object xattr again.. something like that).  Like the anchor 
lookups, this would iteratively look for parents so that we can 
traverse to the given file.  

Given that functionality, the anchor table is no longer needed--it 
performs exactly the same function by explicitly tracking parents for only 
the linked file.  This approach may be somewhat slower (the file xattr may 
be stale beyond the immediate parent, whereas the anchor table is always 
up to date for the full ancestor chain), but we can mitigate that by 
lazily updating out-of-date file object xattrs when we see them.  I 
suspect the end result will be only slightly more complicated than the 
anchor table (if at all) and provide a much more generic and useful 
service (for hard links, NFS reexport, and fsck alike).

> > Anyone feel like we shouldn't go ahead and do this?
>
> I'm certainly for it with this broad outline. ;)
> -Greg

sage
