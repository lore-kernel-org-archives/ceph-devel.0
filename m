From: Sage Weil <sweil@redhat.com>
Subject: RE: bufferlist appenders
Date: Sat, 13 Aug 2016 21:31:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608132120570.17762@piezo.us.to>
References: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to> <BLUPR0201MB1524DC4450553A8874C316E3E81F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbcHNJSc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Aug 2016 05:18:32 -0400
In-Reply-To: <BLUPR0201MB1524DC4450553A8874C316E3E81F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 12 Aug 2016, Allen Samuels wrote:
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Friday, August 12, 2016 7:27 AM
> > To: ceph-devel@vger.kernel.org
> > Subject: bufferlist appenders
> > 
> > A ton of time is the encoding/marshalling is spent doing bufferlist appends.
> > This is partly because the buffer code is doing lots of sanity range checks, and
> > party because there are multiple layers that get range checks and length
> > updates (bufferlist _len changes, and bufferlist::append_buffer (a ptr) gets
> > it's length updated, at the very least).
> > 
> > To simplify and speed this up, I propose an 'appender' concept/type that is
> > used for doing appends in a more efficient way.  It would be used like so:
> > 
> >  bufferlist bl;
> >  {
> >    bufferlist::safe_appender a = bl.get_safe_appender();
> >    ::encode(foo, a);
> >  }
> > 
> > or
> > 
> >  {
> >    bufferlist::unsafe_appender a = bl.get_unsafe_appender(1024);
> >    ::encode(foo, a);
> >  }
> > 
> > The appender keeps its own bufferptr that it copies data into.  The bufferptr
> > isn't given to the bufferlist until the appender is destroyed (or flush() is called
> > explicitly).  This means that appends are generally just a memcpy and a
> > position pointer addition.  In the safe_appender case, we also do a range
> > change and allocate a new buffer if necessary.  In the unsafe_appender case,
> > it is the callers responsibility to say how big a buffer is preallocated.
> > 
> > I have a simple prototype here:
> > 
> > 	https://github.com/ceph/ceph/pull/10700
> > 
> > It appears to be almost 10x faster when encoding a uint64_t in a loop!
> > 
> > [ RUN      ] BufferList.appender_bench
> > appending 1073741824 bytes
> > buffer::list::append 20.285963
> > buffer::list encode 19.719120
> > buffer::list::safe_appender::append 2.588926
> > buffer::list::safe_appender::append_v 2.837026 buffer::list::safe_appender
> > encode 3.000614 buffer::list::unsafe_appender::append 2.452116
> > buffer::list::unsafe_appender::append_v 2.553745
> > buffer::list::unsafe_appender encode 2.200110
> > [       OK ] BufferList.appender_bench (55637 ms)
> > 
> > Interesting, unsafe isn't much faster than safe.  I suspect the CPU's branch
> > prediction is just working really well there?
> 
> Yes it looks like it is. But this is a bit of a contrived case because 
> you're timing this code which is 100% in the L1 cache, which might not 
> be a good model. How bad does it get if the loop is unrolled enough 
> times to fall out of the L1 cache but still in the L2 cache (which might 
> be as pessimistic a simulation as the original code is optimistic).

I updated the test to pick a random point in a big array and then encode 
16 items inline/unrolled in the hopes that this would avoid just hammering 
L1.  It does mean that the 16 contiguous items will probably all get 
fetched together (or have the fetch pipelined), but I think that's 
probably pretty realistic.

The test also went through several other revisions and refinements 
yesterday with Igor's review.  Here's the result now:

[ RUN      ] BufferList.appender_bench
appending 268435456 uint64_t's
buffer::list::append 7.142146
buffer::list encode 7.968760
buffer::list::safe_appender::append 3.506399
buffer::list::safe_appender::append (reserve 16) 2.291478
buffer::list::safe_appender::append_v 3.673429
buffer::list::safe_appender::append_v (reserve 16) 2.291800
buffer::list::safe_appender encode 3.673988
buffer::list::unsafe_appender::append 1.766341
buffer::list::unsafe_appender::append_v 1.748361
buffer::list::unsafe_appender encode 1.746126
[       OK ] BufferList.appender_bench (36340 ms)

which looks much more like what I would expect to see.  The 'reserve 16' 
cases are doing a single bounds check and then doing 16 unsafe appends.  
Bottom line is that doing the limited bounds checks gets you most of the 
way to totally unguarded, but not all the way.  And no guards is 
definitely faster (roughly 2x faster than a guard for every word).

Anyway, I think the next step is to look and the enc_dec and see if 
this can complement the approach...

sage
