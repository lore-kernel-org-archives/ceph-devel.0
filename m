From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Cloning rados block devices
Date: Tue, 25 Jan 2011 15:41:25 -0800
Message-ID: <AANLkTinvVJUmwmbw9CwT9wNAjvQXBQLVVP1=LZF5GAGM@mail.gmail.com>
References: <20110123140750.GE30531@arachsys.com>
	<AANLkTinTr1x=mOXs9HZjynHHxYW5TuYarfGzg3h-e7Cr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65342 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab1AYXl1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 18:41:27 -0500
Received: by wyb28 with SMTP id 28so384247wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 15:41:26 -0800 (PST)
In-Reply-To: <AANLkTinTr1x=mOXs9HZjynHHxYW5TuYarfGzg3h-e7Cr@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Chris Webb <chris@arachsys.com>, ceph-devel@vger.kernel.org

On Mon, Jan 24, 2011 at 6:39 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Sun, Jan 23, 2011 at 6:07 AM, Chris Webb <chris@arachsys.com> wrote:
>> One feature I would really like to be able to export to users is an ability
>> to make copy-on-write clones of virtual hard drives, in a Ceph context
>> generating a new rbd image from an existing one, or from a snapshot of an
>> existing image if that's easier.
>> ....
>> I don't see any mention of a feature like this on the Ceph roadmap, and I'm
>> not familiar enough with the internal design yet to know whether this is an
>> easy extension given the book-keeping already in place for snapshots, or
>> whether what I'm proposing is much harder. Is anyone working on this sort of
>> thing already, or does the feature even already exist and I've failed to
>> find it? If not, I'd be very interested in any thoughts on how difficult
>> this would be to implement given the infrastructure that is already in
>> place.
> We've discussed similar things, but this isn't on the roadmap and I
> don't think anything like it is either. There are a few problems with
> simply re-using the existing snapshot mechanism. First is that it
> doesn't support branching snapshots at all, and this is a hard enough
> problem that we've talked about doing it for other reasons in the past
> and always gone with alternative solutions. (It's not impossible,
> though.) The second is that right now, all versions of an object are
> stored together, on the same OSD. Which makes it pretty likely that
> you'd get a lot of people cloning, say, your Ubuntu base image and
> modifying the same 16 blocks, and you end up with one completely full
> OSD and a fairly empty cluster. (There are mechanisms in RADOS to deal
> with overloaded OSDs, but this issue of uneven distribution is one
> that I would worry about even so.)
>
> So with that said, if I were going to implement copy-on-write RBD
> images, I'd probably do so in the RBD layer rather than via the RADOS
> commands. Yehuda would have a better idea of how to deal with this
> than I do, but I'd probably modify the header to store an index
> indicating the blocks contained in the parent image and which blocks
> in that range have been written to. Then set up the child image as its
> own image (with its own header and rados naming scheme, etc) and
> whenever one block does get written to, copy the object from the
> parent image to the child's space and mark it as written in the
> header. I'm not sure how this would impact performance, but presumably
> most writes would be in areas of the disk not contained in the parent
> image, and I don't think it would be too difficult to implement. This
> wouldn't be as space-efficient as cloning for small changes like a
> config file (since it would modify the whole block, which defaults to
> 4MB), but I bet it's better than storing 3000 installs of an Ubuntu
> LTS release.

Overlaying images is something that we've discussed and considered
implementing. The easiest way would probably go the way Greg specified
here in a block granularity. That is, when writing to the overlaying
image you'd copy the entire block data to that image. Note that it
isn't required that the overlaying image has the same block size as
the parent image, so it might make sense to have smaller block sizes
when doing that. On top of that we can have optimizations (e.g.,
bitmaps that specify which blocks exist) but that's orthogonal to the
basic requirements.

We're in the process of implementing a new userspace library to access
rbd images (librbd) and probably any new development in that area
should go through that library once it's ready. The next stages would
be modifying the qemu-rbd code to use that library, and implementing
the kernel rbd side.

Yehuda
