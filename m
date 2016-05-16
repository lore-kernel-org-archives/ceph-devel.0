From: Sage Weil <sweil@redhat.com>
Subject: wip-bluestore-write
Date: Mon, 16 May 2016 09:20:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605160913150.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37374 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbcEPNTp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 May 2016 09:19:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ifedotov@mirantis.com
Cc: ceph-devel@vger.kernel.org

I merged your last two PRs and pushed an updated branch.  The test fails 
now due to an operation like transaction(write 0~5, write 10~5) where the 
second write wants to read the block in order to write a full block/chunk, 
but the first write's data obviously isn't off to disk yet.  The missing 
piece is a buffer cache, which we want anyway so that we can

- handle cases like this
- drop the hacky tail_cache code
- cache data in ram (when we have an fadvise hint, or for some other 
reason decide it's a good idea)

I have a really basic initial version pushed that just handles the write 
path (buffers initalling in writing state, then clean once io hits 
device).  We just need to make _do_read use it (Igor?) and add some basic 
trimming.  (And eventually decide how we want to do trimming in general.. 
presumably we want a global LRU instead of the simple per-object thing 
that's there now.)

Once that is working, I think the write path will be pretty complete, and 
we can turn our attention to the compression/checksum decisions (when to 
compress, how big should the chunks be, etc.) and performance.  See this 
PR:

	https://github.com/ceph/ceph/pull/6208

I also coded up a new _clone that'll do COW, but I haven't tested it yet.

sage

