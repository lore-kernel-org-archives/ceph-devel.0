From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: bufferlist appenders
Date: Fri, 12 Aug 2016 22:49:59 +0000
Message-ID: <BLUPR0201MB1524DC4450553A8874C316E3E81F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:28331
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751953AbcHLWuD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 18:50:03 -0400
In-Reply-To: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, August 12, 2016 7:27 AM
> To: ceph-devel@vger.kernel.org
> Subject: bufferlist appenders
> 
> A ton of time is the encoding/marshalling is spent doing bufferlist appends.
> This is partly because the buffer code is doing lots of sanity range checks, and
> party because there are multiple layers that get range checks and length
> updates (bufferlist _len changes, and bufferlist::append_buffer (a ptr) gets
> it's length updated, at the very least).
> 
> To simplify and speed this up, I propose an 'appender' concept/type that is
> used for doing appends in a more efficient way.  It would be used like so:
> 
>  bufferlist bl;
>  {
>    bufferlist::safe_appender a = bl.get_safe_appender();
>    ::encode(foo, a);
>  }
> 
> or
> 
>  {
>    bufferlist::unsafe_appender a = bl.get_unsafe_appender(1024);
>    ::encode(foo, a);
>  }
> 
> The appender keeps its own bufferptr that it copies data into.  The bufferptr
> isn't given to the bufferlist until the appender is destroyed (or flush() is called
> explicitly).  This means that appends are generally just a memcpy and a
> position pointer addition.  In the safe_appender case, we also do a range
> change and allocate a new buffer if necessary.  In the unsafe_appender case,
> it is the callers responsibility to say how big a buffer is preallocated.
> 
> I have a simple prototype here:
> 
> 	https://github.com/ceph/ceph/pull/10700
> 
> It appears to be almost 10x faster when encoding a uint64_t in a loop!
> 
> [ RUN      ] BufferList.appender_bench
> appending 1073741824 bytes
> buffer::list::append 20.285963
> buffer::list encode 19.719120
> buffer::list::safe_appender::append 2.588926
> buffer::list::safe_appender::append_v 2.837026 buffer::list::safe_appender
> encode 3.000614 buffer::list::unsafe_appender::append 2.452116
> buffer::list::unsafe_appender::append_v 2.553745
> buffer::list::unsafe_appender encode 2.200110
> [       OK ] BufferList.appender_bench (55637 ms)
> 
> Interesting, unsafe isn't much faster than safe.  I suspect the CPU's branch
> prediction is just working really well there?

Yes it looks like it is. But this is a bit of a contrived case because you're timing this code which is 100% in the L1 cache, which might not be a good model. How bad does it get if the loop is unrolled enough times to fall out of the L1 cache but still in the L2 cache (which might be as pessimistic a simulation as the original code is optimistic). 
> 
> Anyway, thoughts on this?  Any suggestions for further improvement?
> 
> I think the next step is to figure out how to change our
> WRITE_CLASS_ENCODER macros and encode function work with both
> bufferlists and appenders so that it's easy to convert stuff over (and still work
> with a mix of bufferlist-based encoders and appender-based encoders).
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
