From: Sage Weil <sweil@redhat.com>
Subject: RE: bufferlist allocation optimization ideas
Date: Mon, 10 Aug 2015 12:39:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508101239290.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net> <90559C83A9C7FA45B5846C975DFA612DDB53476107@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1705781605-1439235597=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbbHJTj6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Aug 2015 15:39:58 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB53476107@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1705781605-1439235597=:22099
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Mon, 10 Aug 2015, Da?ek, Piotr wrote:
> This is pretty much low-level approach, what I was actually wondering is 
> whether we can reduce amount of memory (de)allocations on higher level, 
> like improving the message lifecycle logic (from receiving to performing 
> actual operation and finishing it), so it wouldn't involve so many 
> allocations and deallocations. Reducing memory allocation on low level 
> will help, no doubts about this, but we can probably improve on higher 
> level and don't risk breaking more than we need.

Yes, definitely!  I think we should pursue both...

sage


> 
> 
> With best regards / Pozdrawiam
> Piotr Da?ek
> 
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Monday, August 10, 2015 9:20 PM
> > To: ceph-devel@vger.kernel.org
> > Subject: bufferlist allocation optimization ideas
> > 
> > Currently putting something in a bufferlist invovles 3 allocations:
> > 
> >  1. raw buffer (posix_memalign, or new char[])  Â  2. buffer::rawÂ(this holds
> > the refcount.Â  lifecycle matches the
> >     raw buffer exactly)
> >  Â  3. bufferlist's STL list<> node, which embeds buffer::ptr
> > 
> > --- combine buffer and buffer::raw ---
> > 
> > This should be a pretty simple patch, and turns 2 allocations into one.  Most
> > buffers are constructed/allocated via buffer::create_*() methods.  Those
> > each look something like
> > 
> >   buffer::raw* buffer::create(unsigned len) {
> >     return new raw_char(len);
> >   }
> > 
> > where raw_char::raw_char() allocates the actual buffer.  Instead, allocate
> > sizeof(raw_char_combined) + len, and use the right magic C++ syntax to call
> > the constructor on that memory.  Something like
> > 
> >   raw_char_combined *foo = new (ptr) raw_char_combined(ptr);
> > 
> > where the raw_char_combined constructor is smart enough to figure out
> > that data goes at ptr + sizeof(*this).
> > 
> > That takes us from 3 -> 2 allocations.
> > 
> > An open question is whether this is always a good idea, or whether there are
> > cases where 2 allocates are better, e.g. when len is exactly one page, and
> > we're better off with a mempool allocation for raw and page separately.  Or
> > maybe for very large buffers?  I'm really not sure what would be better...
> > 
> > 
> > --- make bufferlist use boost::intrusive::list ---
> > 
> > Most buffers exist in only one list, so the indirection through the ptr is mostly
> > wasted.
> > 
> > 1. embed a boost::intrustive::list node into buffer::ptr.  (Note that doing just
> > this buys us nothing... we are just allocating ptr's and using the intrusive node
> > instead the list<> node with an embedded ptr.)
> > 
> > 2. embed a ptr in buffer::raw (or raw_char_combined)
> > 
> > When adding a buffer to the bufferlist, we use the raw_char_combined's
> > embedded ptr if it is available.  Otherwise, we allocate one as before.
> > 
> > This would need some careful adjustment of hte common append() paths,
> > since they currently are all ptr-based.  One way to make this work well might
> > be to embed N ptr's in raw_char_combined, on the assumption that the
> > refcount for a buffer is never more than 2 or 3.  Only in extreme cases will we
> > need to explicitly allocate ptr's.
> > 
> > 
> > Thoughts?
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--557981400-1705781605-1439235597=:22099--
