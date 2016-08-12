From: Sage Weil <sweil@redhat.com>
Subject: bufferlist appenders
Date: Fri, 12 Aug 2016 14:27:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608121418090.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbcHLO13 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 10:27:29 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EF904E343
	for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 14:27:29 +0000 (UTC)
Received: from ovpn-112-26.phx2.redhat.com (ovpn-112-26.phx2.redhat.com [10.3.112.26])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7CERRx5002372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 10:27:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A ton of time is the encoding/marshalling is spent doing bufferlist 
appends.  This is partly because the buffer code is doing lots of sanity 
range checks, and party because there are multiple layers that get range 
checks and length updates (bufferlist _len changes, 
and bufferlist::append_buffer (a ptr) gets it's length updated, at the 
very least).

To simplify and speed this up, I propose an 'appender' concept/type that 
is used for doing appends in a more efficient way.  It would be used 
like so:

 bufferlist bl;
 {
   bufferlist::safe_appender a = bl.get_safe_appender();
   ::encode(foo, a);
 }

or

 {
   bufferlist::unsafe_appender a = bl.get_unsafe_appender(1024);
   ::encode(foo, a);
 }

The appender keeps its own bufferptr that it copies data into.  The 
bufferptr isn't given to the bufferlist until the appender is destroyed 
(or flush() is called explicitly).  This means that appends are generally 
just a memcpy and a position pointer addition.  In the safe_appender case, 
we also do a range change and allocate a new buffer if necessary.  In the 
unsafe_appender case, it is the callers responsibility to say how big a 
buffer is preallocated.

I have a simple prototype here:

	https://github.com/ceph/ceph/pull/10700

It appears to be almost 10x faster when encoding a uint64_t in a loop!

[ RUN      ] BufferList.appender_bench
appending 1073741824 bytes
buffer::list::append 20.285963
buffer::list encode 19.719120
buffer::list::safe_appender::append 2.588926
buffer::list::safe_appender::append_v 2.837026
buffer::list::safe_appender encode 3.000614
buffer::list::unsafe_appender::append 2.452116
buffer::list::unsafe_appender::append_v 2.553745
buffer::list::unsafe_appender encode 2.200110
[       OK ] BufferList.appender_bench (55637 ms)

Interesting, unsafe isn't much faster than safe.  I suspect the CPU's 
branch prediction is just working really well there?

Anyway, thoughts on this?  Any suggestions for further improvement?

I think the next step is to figure out how to change our 
WRITE_CLASS_ENCODER macros and encode function work with both bufferlists 
and appenders so that it's easy to convert stuff over (and still work with 
a mix of bufferlist-based encoders and appender-based encoders).

sage
