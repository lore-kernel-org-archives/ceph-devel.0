From: Sage Weil <sweil@redhat.com>
Subject: sharded collection list
Date: Tue, 2 Jun 2015 15:54:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506021533010.30975@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbFBWyl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Jun 2015 18:54:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 03416B7CF6
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2015 22:54:41 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: john.spray@redhat.com, sjust@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey John-

So the shared pgls stuff has collided a bit with the looming hobject 
sorting changes.  Sam and I just talked about it a bit and came up 
with what librados API would be most appealing:

 - the listing API would have start/end markers

 - it would be driven by a new opaque type rados_list_cursor_t, which is 
just data, no state, and internally is just an hobject_t.

 - it would be totally stateless.. kill the [N]ListContext stuff in 
Objecter (and reimplement a simple wrapper in librados.cc or even .h).  
Note that the important bits of state there now are

 epoch (needed for detecting split; this will go away with a better cursor)
 result buffer (we can drop this)
 nspace (part of the ioctx, it just tags each request)
 cookie (this basically becomes the cursor .. it's just an hobject_t typedef)

 - the list could take a start cursor, optional end cursor, and output the 
next cursor to continue from.

 - we'd lose the buffering that ListContext currently does, which means 
that the request that goes over the wire will return the same number 
of entries that the C caller asks for.  The C++ interface is an iterator 
so it'll have to do its own buffering, but that should be pretty 
trivial...

 - we should kill these calls, which were never used:

 CEPH_RADOS_API uint32_t rados_nobjects_list_get_pg_hash_position(rados_list_ctx_t ctx);

 CEPH_RADOS_API uint32_t rados_nobjects_list_seek(rados_list_ctx_t ctx,
                                                  uint32_t pos);

 - we'd add a new call that is something like 

 int rados_construct_iterator(ioctx, int n, int m, cursor *out);

so that you can get a position partway through the pg.

What do you think?  Unfortunately it is quite a departure from what you 
implemented already but I think it'll be a net simplification *and* 
let you do all the things we want, like

 - get a set of ranges to list form
 - change our mind partway through to break things into smaller shards 
without losing previous work
 - start listing from a random position in the pool

You could even list a single hash value by constructing a cursor with 
n=hash and n=hash=1 and m=2^32.

What do you think?
sage

