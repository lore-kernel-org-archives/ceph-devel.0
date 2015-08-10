From: Sage Weil <sweil@redhat.com>
Subject: bufferlist allocation optimization ideas
Date: Mon, 10 Aug 2015 12:19:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1332105851-1439234383=:26854"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbbHJTTo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Aug 2015 15:19:44 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id E6FC88E4E5
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 19:19:43 +0000 (UTC)
Received: from redhat.com (ovpn-112-37.phx2.redhat.com [10.3.112.37])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7AJJgpe009480
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 15:19:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1332105851-1439234383=:26854
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Currently putting something in a bufferlist invovles 3 allocations:

 1. raw buffer (posix_memalign, or new char[])
 Â  2. buffer::rawÂ(this holds the refcount.Â  lifecycle matches the 
    raw buffer exactly)
 Â  3. bufferlist's STL list<> node, which embeds buffer::ptr

--- combine buffer and buffer::raw ---

This should be a pretty simple patch, and turns 2 allocations into 
one.  Most buffers are constructed/allocated via buffer::create_*() 
methods.  Those each look something like

  buffer::raw* buffer::create(unsigned len) {
    return new raw_char(len);
  }

where raw_char::raw_char() allocates the actual buffer.  Instead, allocate 
sizeof(raw_char_combined) + len, and use the right magic C++ syntax to 
call the constructor on that memory.  Something like

  raw_char_combined *foo = new (ptr) raw_char_combined(ptr);

where the raw_char_combined constructor is smart enough to figure out 
that data goes at ptr + sizeof(*this).

That takes us from 3 -> 2 allocations.

An open question is whether this is always a good idea, or whether there 
are cases where 2 allocates are better, e.g. when len is exactly one page, 
and we're better off with a mempool allocation for raw and page 
separately.  Or maybe for very large buffers?  I'm really not sure what 
would be better...


--- make bufferlist use boost::intrusive::list ---

Most buffers exist in only one list, so the indirection through the ptr 
is mostly wasted.

1. embed a boost::intrustive::list node into buffer::ptr.  (Note that 
doing just this buys us nothing... we are just allocating ptr's and using 
the intrusive node instead the list<> node with an embedded ptr.)

2. embed a ptr in buffer::raw (or raw_char_combined)

When adding a buffer to the bufferlist, we use the raw_char_combined's 
embedded ptr if it is available.  Otherwise, we allocate one as before.

This would need some careful adjustment of hte common append() paths, 
since they currently are all ptr-based.  One way to make this work 
well might be to embed N ptr's in raw_char_combined, on the assumption 
that the refcount for a buffer is never more than 2 or 3.  Only in extreme 
cases will we need to explicitly allocate ptr's.


Thoughts?
sage

--557981400-1332105851-1439234383=:26854--
