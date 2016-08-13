From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: bufferlist appenders
Date: Sat, 13 Aug 2016 10:50:56 +0200
Message-ID: <20160813085056.GB22353@predictor>
References: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:50336 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcHMI6L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 13 Aug 2016 04:58:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 12, 2016 at 02:27:26PM +0000, Sage Weil wrote:
> A ton of time is the encoding/marshalling is spent doing bufferlist 
> appends.  This is partly because the buffer code is doing lots of sanity 
> range checks, and party because there are multiple layers that get range 
> checks and length updates (bufferlist _len changes, 
> and bufferlist::append_buffer (a ptr) gets it's length updated, at the 
> very least).
> 
> To simplify and speed this up, I propose an 'appender' concept/type that 
> is used for doing appends in a more efficient way.  It would be used 
> like so:
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
> The appender keeps its own bufferptr that it copies data into.  The 
> bufferptr isn't given to the bufferlist until the appender is destroyed 
> (or flush() is called explicitly).  This means that appends are generally 
> just a memcpy and a position pointer addition.  In the safe_appender case, 
> we also do a range change and allocate a new buffer if necessary.  In the 
> unsafe_appender case, it is the callers responsibility to say how big a 
> buffer is preallocated.
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
> buffer::list::safe_appender::append_v 2.837026
> buffer::list::safe_appender encode 3.000614
> buffer::list::unsafe_appender::append 2.452116
> buffer::list::unsafe_appender::append_v 2.553745
> buffer::list::unsafe_appender encode 2.200110
> [       OK ] BufferList.appender_bench (55637 ms)
> 
> Interesting, unsafe isn't much faster than safe.  I suspect the CPU's 
> branch prediction is just working really well there?

That may be the case, as there's only one branch in safe appender, contrary
to four in buffer::ptr::append. Also, appenders don't return values.

> Anyway, thoughts on this?  Any suggestions for further improvement?

As I wrote on github - replace memcpy with maybe_inline_memcpy for even more
performance.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
