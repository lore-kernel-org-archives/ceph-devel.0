From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 19:02:43 -0400
Message-ID: <CANP1eJH52JbioreUo8Bg0Yydw_gsWRf68rhT4QZB3xuJRrnynA@mail.gmail.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
	<CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603301856470.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33841 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcCaXCp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 19:02:45 -0400
Received: by mail-lb0-f182.google.com with SMTP id vo2so61424287lbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 16:02:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603301856470.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 30, 2016 at 6:57 PM, Sage Weil <sage@newdream.net> wrote:
>
> On Wed, 30 Mar 2016, Allen Samuels wrote:
> > One thing to also factor in is that if you increase the span of a
> > checksum, you degrade the quality of the checksum. So if you go with
> > 128K chunks of data you'll likely want to increase the checksum itself
> > from something beyond a CRC-32. Maybe somebody out there has a good way
> > of describing this quanitatively.
>
> Good point.  FWIW, I think we should default to xxhash over crc32c:
>
>         https://github.com/Cyan4973/xxHash
>
> Note that there is a 64-bit version that's faster on 64-bit procs.

A side not from the author about the 64bit version, from here:
http://fastcompression.blogspot.com/2014/07/xxhash-wider-64-bits.html

"Since I was still not totally convinced, I also measured each 32-bits
part of the 64-bits hash (high and low) as individual 32-bits hashes.
The theory is : if the 64-bits hash is perfect, any 32-bits part of it
must also be perfect. And the good thing is : with 32-bits, collision
can be properly measured. The results are also excellent, each 32-bits
part scoring perfect scores in all possible metric."

So it's possible to use the xxHash64 but only store one of the parts
of the hash. You still get 2x the speed of xxHash32 on 64bit hardware
but without double the overhead (if you're going to be checksumming
over small block sizes).

>
>
> sage
>
> >
> >
> > Allen Samuels
> > Software Architect, Fellow, Systems and Software Solutions
> >
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416
> > allen.samuels@SanDisk.com
> >
> >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@newdream.net]
> > > Sent: Wednesday, March 30, 2016 3:16 PM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > Cc: Igor Fedotov <ifedotov@mirantis.com>; ceph-devel <ceph-
> > > devel@vger.kernel.org>
> > > Subject: Re: Adding compression/checksum support for bluestore.
> > >
> > > On Wed, 30 Mar 2016, Allen Samuels wrote:
> > > > [snip]
> > > >
> > > > Time to talk about checksums.
> > > >
> > > > First let's divide the world into checksums for data and checksums for
> > > > metadata -- and defer the discussion about checksums for metadata
> > > > (important, but one at a time...)
> > > >
> > > > I believe it's a requirement that when checksums are enabled that 100%
> > > > of data reads must be validated against their corresponding checksum.
> > > > This leads you to conclude that you must store a checksum for each
> > > > independently readable piece of data.
> > >
> > > +1
> > >
> > > > When compression is disabled, it's relatively straightforward --
> > > > there's a checksum for each 4K readable block of data. Presumably this
> > > > is a simple vector stored in the pextent structure with one entry for
> > > > each 4K block of data.
> > >
> > > Maybe.  If the object is known to be sequentail write and sequential read, or
> > > even sequential write and random read but on a HDD-like medium, then we
> > > can checksum on something like 128K (since it doesn't cost any more to read
> > > 128k than 4k).  I think the checksum block size should be a per-object
> > > property.  *Maybe* a pextent property, given that compression is also
> > > entering the picture.
> > >
> > > > Things get more complicated when compression is enabled. At a minimum,
> > > > you'll need a checksum for each blob of compressed data (I'm using
> > > > blob here as unit of data put into the compressor, but what I really
> > > > mean is the minimum amount of *decompressable* data). As I've pointed
> > > > out before, many of the compression algorithms do their own checksum
> > > > validation. For algorithms that don't do their own checksum we'll want
> > > > one checksum to protect the block -- however, there's no reason that
> > > > we can't implement this as one checksum for each 4K physical blob, the
> > > > runtime cost is nearly equivalent and it will considerably simplify
> > > > the code.
> > >
> > > I'm just worried about the size of metadata if we have 4k checksums but
> > > have to read big extents anyway; cheaper to store a 4 byte checksum for
> > > each compressed blob.
> > >
> > > > Thus I think we really end up with a single, simple design. The
> > > > pextent structure contains a vector of checksums. Either that vector
> > > > is empty (checksum disabled) OR there is a checksum for each 4K block
> > > > of data (not this is NOT min_allocation size, it's minimum_read_size
> > > > [if that's even a parameter or does the code assume 4K readable
> > > > blocks? [or worse,
> > > > 512 readable blocks?? -- if so, we'll need to cripple this]).
> > > >
> > > > When compressing with a compression algorithm that does checksuming
> > > we
> > > > can automatically suppress checksum generation. There should also be
> > > > an administrative switch for this.
> > > >
> > > > This allows the checksuming to be pretty much independent of
> > > > compression
> > > > -- which is nice :)
> > >
> > >
> > >
> > > > This got me thinking, we have another issue to discuss and resolve.
> > > >
> > > > The scenario is when compression is enabled. Assume that we've taken a
> > > > big blob of data and compressed it into a smaller blob. We then call
> > > > the allocator for that blob. What do we do if the allocator can't find
> > > > a CONTIGUOUS block of storage of that size??? In the non-compressed
> > > > case, it's relatively easy to simply break it up into smaller chunks
> > > > -- but that doesn't work well with compression.
> > > >
> > > > This isn't that unlikely a case, worse it could happen with shockingly
> > > > high amounts of freespace (>>75%) with some pathological access
> > > > patterns.
> > > >
> > > > There's really only two choices. You either fracture the logical data
> > > > and recompress OR you modify the pextent data structure to handle this
> > > > case. The later isn't terribly difficult to do, you just make the
> > > > size/address values into a vector of pairs. The former scheme could be
> > > > quite expensive CPU wise as you may end up fracturing and
> > > > recompressing multiple times (granted, in a pathological case). The
> > > > latter case adds space to each onode for a rare case. The space is
> > > > recoverable with an optimized serialize/deserializer (in essence you
> > > > could burn a flag to indicate when a vector of physical chunks/sizes
> > > > is needed instead of the usual scalar pair).
> > > >
> > > > IMO, we should pursue the later scenario as it avoids the variable
> > > > latency problem. I see the code/testing complexity of either choice as
> > > > about the same.
> > >
> > > Hrm, I hadn't thought about this one.  :(
> > >
> > > What about a third option: we ask the allocator for the uncompressed size,
> > > and *then* compress.  If it gives us something small, we will know then to
> > > compress a smaller piece.  It just means that we'll be returning space back to
> > > the allocator in the general case after we compress, which will burn a bit of
> > > CPU, and may screw things up when lots of threads are allocating in parallel
> > > and we hope to lay them out sequentially.
> > >
> > > Or, maybe we flip into this sort of pessimistic allocation mode only when the
> > > amount of space above a certain size threshold is low.  With the current
> > > binned allocator design this is trivial; it probably is pretty easy with your
> > > bitmap-based approach as well with some minimal accounting.
> > >
> > > I really don't like the idea of making pextent's able to store fractions of a
> > > compressed blob; it'll complicate the structures and code paths significantly,
> > > and they'll be complex enough as it is. :(
> > >
> > > sage
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
