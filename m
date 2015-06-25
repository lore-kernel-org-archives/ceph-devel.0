From: Pete Zaitcev <zaitcev@redhat.com>
Subject: What is omap
Date: Wed, 24 Jun 2015 23:47:28 -0600
Message-ID: <20150624234728.79c29b49@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbbFYFra (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Jun 2015 01:47:30 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 2812A373BDE
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 05:47:30 +0000 (UTC)
Received: from guren.zaitcev.lan (vpn-58-189.rdu2.redhat.com [10.10.58.189])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5P5lTTl009941
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 01:47:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear All:

I am a complete beginner in Ceph and due to various circumstances I became
curious about omap. I made some quick web searches and read some random
writings about it, but I still have basic questions.

 - If I had to refer to omap in a doc/foo.rst, is there a canonical
   web-page, blog post, mailing list thread, or a (white)paper that
   serves to explain what it is?

   So far the best explanation I found was in ceph-devel archives
   by Gregory Farnum.

 - Every casual explanation I found presumes that "an omap" (a set
   of K/V) is associated with an object. But it is not physically in
   the object. So, is there a free-standing omap (set of keys)?
   Or an omap associated with something else, like a pool?

 - Greg says " The on-disk layout for these is more complicated
   (read about leveldb if you're interested)". Fair enough... But would
   someone be willing to shortcut this for me by explaining how this
   works in concert with OSD. In particular, does OSD replicate
   the files that LevelDB uses (like, for instance, Swift replicates
   SQLite files), or does it rely on LevelDB's own replication?
   Or perhaps OSD replicates upper level view of K/V provided by
   LevelDB in a node and ignores its actual on-disk layout?

Thanks in advance,
-- Pete
