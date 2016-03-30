From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 22:32:06 +0000
Message-ID: <CY1PR0201MB18978866EEBA1410E3883ABDE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0077.outbound.protection.outlook.com ([207.46.100.77]:65248
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752883AbcC3WcI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 18:32:08 -0400
In-Reply-To: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Wednesday, March 30, 2016 3:16 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Igor Fedotov <ifedotov@mirantis.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> On Wed, 30 Mar 2016, Allen Samuels wrote:
> > [snip]
> >
> > Time to talk about checksums.
> >
> > First let's divide the world into checksums for data and checksums for
> > metadata -- and defer the discussion about checksums for metadata
> > (important, but one at a time...)
> >
> > I believe it's a requirement that when checksums are enabled that 100%
> > of data reads must be validated against their corresponding checksum.
> > This leads you to conclude that you must store a checksum for each
> > independently readable piece of data.
> 
> +1
> 
> > When compression is disabled, it's relatively straightforward --
> > there's a checksum for each 4K readable block of data. Presumably this
> > is a simple vector stored in the pextent structure with one entry for
> > each 4K block of data.
> 
> Maybe.  If the object is known to be sequentail write and sequential read, or
> even sequential write and random read but on a HDD-like medium, then we
> can checksum on something like 128K (since it doesn't cost any more to read
> 128k than 4k).  I think the checksum block size should be a per-object
> property.  *Maybe* a pextent property, given that compression is also
> entering the picture.

In my book, there's nothing magical about 4K. I agree that there's no particular reason why 1 checksum == 4K of physical data. No reason that this can't be variable -- details of variability are TBD.
 
> 
> > Things get more complicated when compression is enabled. At a minimum,
> > you'll need a checksum for each blob of compressed data (I'm using
> > blob here as unit of data put into the compressor, but what I really
> > mean is the minimum amount of *decompressable* data). As I've pointed
> > out before, many of the compression algorithms do their own checksum
> > validation. For algorithms that don't do their own checksum we'll want
> > one checksum to protect the block -- however, there's no reason that
> > we can't implement this as one checksum for each 4K physical blob, the
> > runtime cost is nearly equivalent and it will considerably simplify
> > the code.
> 
> I'm just worried about the size of metadata if we have 4k checksums but
> have to read big extents anyway; cheaper to store a 4 byte checksum for
> each compressed blob.
> 
> > Thus I think we really end up with a single, simple design. The
> > pextent structure contains a vector of checksums. Either that vector
> > is empty (checksum disabled) OR there is a checksum for each 4K block
> > of data (not this is NOT min_allocation size, it's minimum_read_size
> > [if that's even a parameter or does the code assume 4K readable
> > blocks? [or worse,
> > 512 readable blocks?? -- if so, we'll need to cripple this]).
> >
> > When compressing with a compression algorithm that does checksuming
> we
> > can automatically suppress checksum generation. There should also be
> > an administrative switch for this.
> >
> > This allows the checksuming to be pretty much independent of
> > compression
> > -- which is nice :)
> 
> 
> 
> > This got me thinking, we have another issue to discuss and resolve.
> >
> > The scenario is when compression is enabled. Assume that we've taken a
> > big blob of data and compressed it into a smaller blob. We then call
> > the allocator for that blob. What do we do if the allocator can't find
> > a CONTIGUOUS block of storage of that size??? In the non-compressed
> > case, it's relatively easy to simply break it up into smaller chunks
> > -- but that doesn't work well with compression.
> >
> > This isn't that unlikely a case, worse it could happen with shockingly
> > high amounts of freespace (>>75%) with some pathological access
> > patterns.
> >
> > There's really only two choices. You either fracture the logical data
> > and recompress OR you modify the pextent data structure to handle this
> > case. The later isn't terribly difficult to do, you just make the
> > size/address values into a vector of pairs. The former scheme could be
> > quite expensive CPU wise as you may end up fracturing and
> > recompressing multiple times (granted, in a pathological case). The
> > latter case adds space to each onode for a rare case. The space is
> > recoverable with an optimized serialize/deserializer (in essence you
> > could burn a flag to indicate when a vector of physical chunks/sizes
> > is needed instead of the usual scalar pair).
> >
> > IMO, we should pursue the later scenario as it avoids the variable
> > latency problem. I see the code/testing complexity of either choice as
> > about the same.
> 
> Hrm, I hadn't thought about this one.  :(
> 
> What about a third option: we ask the allocator for the uncompressed size,
> and *then* compress.  If it gives us something small, we will know then to
> compress a smaller piece.  It just means that we'll be returning space back to
> the allocator in the general case after we compress, which will burn a bit of
> CPU, and may screw things up when lots of threads are allocating in parallel
> and we hope to lay them out sequentially.

I'll need some convincing that this doesn't maximum fragmentation -- as well as all of the issues you cite.

> 
> Or, maybe we flip into this sort of pessimistic allocation mode only when the
> amount of space above a certain size threshold is low.  With the current
> binned allocator design this is trivial; it probably is pretty easy with your
> bitmap-based approach as well with some minimal accounting.

Yes, but I'm not ready to give up on a single algorithm with one operating mode -- easier to code and test. 

> 
> I really don't like the idea of making pextent's able to store fractions of a
> compressed blob; it'll complicate the structures and code paths significantly,
> and they'll be complex enough as it is. :(

I agree about the fractional thing -- and I don't think that's a fair description of what I proposed.

Here's a more evolved way to describe what I was proposing (refactoring some stuff).

There are really THREE types of extents: lextent, cextent and pextent. 

Lextent is as described above, a range of logical address that maps into a portion of a cextent.
Pextent is a range of contiguous physical storage (address/size).
Cextent is a blob of compressed data.

A cextent contains some number of pextents. 

When compression is disabled, there will only be a single cextent and you'll want a checksum per pextent.
When compression is enabled, there will be one checksum per cextent and a vector of pextents (w/o checksums).

I suspect that on the implementation level, you'll combined the serializer for cextent/pextent into a single blob -> this ends up with what I proposed earlier...
 
> 
> sage
