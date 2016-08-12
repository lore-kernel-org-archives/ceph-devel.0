From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bufferlist appenders
Date: Fri, 12 Aug 2016 09:37:49 -0500
Message-ID: <4498276f-35c9-88ed-44d1-db93004abede@redhat.com>
References: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35814 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbcHLOj1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 10:39:27 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C936B5C3D
	for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 14:37:52 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 08/12/2016 09:27 AM, Sage Weil wrote:
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

Yay!  This is huge.  For posterity, here's where the original behavior 
was really hurting us in bluestore:

https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view

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
>
> Anyway, thoughts on this?  Any suggestions for further improvement?

I'm surprised too that unsafe isn't much faster than safe.  Still, this 
is enough of an improvement that I think we should just run with it for 
now and get some performance tests done as we convert stuff over.

>
> I think the next step is to figure out how to change our
> WRITE_CLASS_ENCODER macros and encode function work with both bufferlists
> and appenders so that it's easy to convert stuff over (and still work with
> a mix of bufferlist-based encoders and appender-based encoders).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
