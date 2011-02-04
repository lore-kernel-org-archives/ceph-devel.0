From: Chris Webb <chris@arachsys.com>
Subject: Re: Cloning rados block devices
Date: Fri, 4 Feb 2011 14:31:41 +0000
Message-ID: <20110204143140.GG30390@arachsys.com>
References: <20110123140750.GE30531@arachsys.com>
 <AANLkTinTr1x=mOXs9HZjynHHxYW5TuYarfGzg3h-e7Cr@mail.gmail.com>
 <AANLkTinvVJUmwmbw9CwT9wNAjvQXBQLVVP1=LZF5GAGM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:54097 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab1BDOcI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Feb 2011 09:32:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinvVJUmwmbw9CwT9wNAjvQXBQLVVP1=LZF5GAGM@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Yehuda Sadeh Weinraub <yehudasa@gmail.com> writes:

> On Mon, Jan 24, 2011 at 6:39 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
>
> > So with that said, if I were going to implement copy-on-write RBD
> > images, I'd probably do so in the RBD layer rather than via the RADOS
> > commands. Yehuda would have a better idea of how to deal with this
> > than I do, but I'd probably modify the header to store an index
> > indicating the blocks contained in the parent image and which blocks
> > in that range have been written to. Then set up the child image as its
> > own image (with its own header and rados naming scheme, etc) and
> > whenever one block does get written to, copy the object from the
> > parent image to the child's space and mark it as written in the
> > header. I'm not sure how this would impact performance, but presumably
> > most writes would be in areas of the disk not contained in the parent
> > image, and I don't think it would be too difficult to implement. This
> > wouldn't be as space-efficient as cloning for small changes like a
> > config file (since it would modify the whole block, which defaults to
> > 4MB), but I bet it's better than storing 3000 installs of an Ubuntu
> > LTS release.
> 
> Overlaying images is something that we've discussed and considered
> implementing. The easiest way would probably go the way Greg specified
> here in a block granularity. That is, when writing to the overlaying
> image you'd copy the entire block data to that image. Note that it
> isn't required that the overlaying image has the same block size as
> the parent image, so it might make sense to have smaller block sizes
> when doing that. On top of that we can have optimizations (e.g.,
> bitmaps that specify which blocks exist) but that's orthogonal to the
> basic requirements.
> 
> We're in the process of implementing a new userspace library to access
> rbd images (librbd) and probably any new development in that area
> should go through that library once it's ready. The next stages would
> be modifying the qemu-rbd code to use that library, and implementing
> the kernel rbd side.

Thanks Greg and Yehuda for the prompt, detailed and helpful feedback on what
would be needed to implement this feature, and apologies for the slow
follow-up.

When I wrote my original email, I hadn't dug into the underlying structure
of Ceph very much, and didn't realise the implications of implementing this
sort of thing at the RADOS layer, but given the hotspot issues you
highlight, it does sound like implementing in the RBD layer makes much more
sense than trying to use RADOS versioning, as you say.

I suspect that for realistic loads, a 4MB copy-on-write chunk size isn't
going to be particularly evil, especially after the machine has been 'run
in'. I may be able to get a better handle on how block modifications are
distributed with a bit of instrumentation on the block layer on some of our
existing virtual machine images, though... I'll have a play!

Cheers,

Chris.
