From: Sage Weil <sage@inktank.com>
Subject: optimizing buffers, encode/decode
Date: Wed, 29 Oct 2014 10:17:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410290957240.21856@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37606 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749AbaJ2RR3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 13:17:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 88F3F80068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 10:17:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DD95180068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 10:17:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We talked a bit about improving the performance encode/decode 
yesterday at CDS:

	http://pad.ceph.com/p/hammer-buffer_encoding

I think the main takeaways were:

1- We need some up to date profiling information to see

  - how much of it is buffer-related functions (e.g., append)
  - which data types are slowest or most frequently encoded (or otherwise 
    show up in the profile)

2- For now we should probably focus on the efficiency of the encode/decode 
paths.  Possibilities include

  - making more things inline
  - improving the past path

3- Matt and the linuxbox folks have been playing with some general 
optimizations for the buffer::list class.  These include combining 
some of the function of ptr and raw so that, for the common 
single-reference case, we chain the raw pointers together directly from 
list using the boost intrusive list type, and fall back to the current 
list -> ptr -> raw strategy when there are additional refs.


For #2, one simple thought would be to cache a pointer and remaining bytes 
or end pointer into the append_buffer directly in list so that we avoid 
the duplicate asserts and size checks in the common append (encode) path.  
Then a

  ::encode(myu64, bl);

would inline into something pretty quick, like

  remaining -= 8;
  if (remainining < 0) { // take slow path

  } else {
     *ptr = myu64;
     ptr += 8;
  }

Not sure if an end pointer would let us cut out the 2 arithmetic ops or 
not.  Or if it even matters on modern pipelining processors.

Anyway, any gains we make here will pay dividends across the entire 
code base.  And any profiling people want to do will help guide 
things...

Thanks!
sage
