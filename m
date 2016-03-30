From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 18:30:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603301825240.22014@cpach.fuggernut.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com> <CAJ4mKGbP1u_Z6zdC1FGm0PDj44L1=pJct2r-vuj3NCf2SS=8yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60574 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbcC3WaW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 18:30:22 -0400
In-Reply-To: <CAJ4mKGbP1u_Z6zdC1FGm0PDj44L1=pJct2r-vuj3NCf2SS=8yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Mar 2016, Gregory Farnum wrote:
> On Wed, Mar 30, 2016 at 3:15 PM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 30 Mar 2016, Allen Samuels wrote:
> >> [snip]
> >>
> >> Time to talk about checksums.
> >>
> >> First let's divide the world into checksums for data and checksums for
> >> metadata -- and defer the discussion about checksums for metadata
> >> (important, but one at a time...)
> >>
> >> I believe it's a requirement that when checksums are enabled that 100%
> >> of data reads must be validated against their corresponding checksum.
> >> This leads you to conclude that you must store a checksum for each
> >> independently readable piece of data.
> >
> > +1
> >
> >> When compression is disabled, it's relatively straightforward -- there's
> >> a checksum for each 4K readable block of data. Presumably this is a
> >> simple vector stored in the pextent structure with one entry for each 4K
> >> block of data.
> >
> > Maybe.  If the object is known to be sequentail write and sequential read,
> > or even sequential write and random read but on a HDD-like medium, then we
> > can checksum on something like 128K (since it doesn't cost any more to
> > read 128k than 4k).  I think the checksum block size should be a
> > per-object property.  *Maybe* a pextent property, given that compression
> > is also entering the picture.
> >
> >> Things get more complicated when compression is enabled. At a minimum,
> >> you'll need a checksum for each blob of compressed data (I'm using blob
> >> here as unit of data put into the compressor, but what I really mean is
> >> the minimum amount of *decompressable* data). As I've pointed out
> >> before, many of the compression algorithms do their own checksum
> >> validation. For algorithms that don't do their own checksum we'll want
> >> one checksum to protect the block -- however, there's no reason that we
> >> can't implement this as one checksum for each 4K physical blob, the
> >> runtime cost is nearly equivalent and it will considerably simplify the
> >> code.
> >
> > I'm just worried about the size of metadata if we have 4k checksums but
> > have to read big extents anyway; cheaper to store a 4 byte checksum for
> > each compressed blob.
> 
> I haven't followed the BlueStore discussion closely, but doesn't it
> still allow for data overwrites if they're small and the object block
> is large? I presume the goal of 4K instead of per-chunk checksums is
> to prevent turning those overwrites into a read-modify-write. (Is that
> sufficient?)

You can overwrite small things (< min_alloc_size, and thus not written to 
a newly allocated location), although it has to happen as a logged WAL 
event to make it atomic.  It's true that small checksums make that r/m/w 
small, but the difference in cost on an HDD between 4K and 64K or 128K is 
almost unnoticeable.  On flash the calculus is probably different--and the 
cost of a larger onode is probably less of an issue.

4K checksums for a 4MB objects 1024 * 32 bits -> 4K of metadata.  That 
takes an onode from ~300 bytes currently to say 4400 bytes... about an 
order of magnitude.  That will significantly reduce the amount of metadata 
we are able to cache in RAM.

My gut tells me 4K or 16K checksums for SSD (4400 - 1300 byte onodes), 
128K for HDD (~430 bytes, only 128 bytes of csums, less than double)...

sage
