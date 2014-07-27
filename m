From: Sage Weil <sage@inktank.com>
Subject: reverted ObjectCacher changes
Date: Sat, 26 Jul 2014 21:24:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407262122390.13909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36446 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaG0EY7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jul 2014 00:24:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com, haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org

I reverted the recent changes to ObjectCacher.  The problem is in 
flush_set:

  set<BufferHead*>::iterator next, it;
  next = it = dirty_or_tx_bh.begin();
  while (it != dirty_or_tx_bh.end()) {
    next++;
    BufferHead *bh = *it;
    waitfor_commit.insert(bh->ob);
    bh_write(bh);
    it = next;
  }

This resubmits IOs for writes that are already in flight.  The fs client 
in particular calls this a lot, overwhelming the OSDs with dup IOs and 
stalling out completely.  See

 /a/sage-2014-07-25_17:14:20-fs-wip-msgr-testing-basic-plana

for a bunch of sample failures.

Probably easy to fix, but simply reverting for now!

sage


