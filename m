From: Sage Weil <sage@inktank.com>
Subject: ceph-mon vs leveldb status
Date: Wed, 19 Jun 2013 13:09:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306191304230.7089@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54669 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934978Ab3FSUJn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 16:09:43 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC0A6803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:09:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AA15E803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:09:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Things have stabilized here.  In the end there were a few different 
issues:

 - We have a bug in teh paxos code that wasn't trimming old keys, causing 
the store to grow indefinitely.
 - leveldb does very poorly with "rolling key ranges", where regions of 
the keyspace are deleted and never touched again.  This fails to trigger 
the automatic compaction causing disk space to grow.  We've resolved this 
by triggering compaction explicitly every so often over the ranges of keys 
we've used, and doing that compaction in an async thread.  This is 
controlled by the 'mon compact on trim' option, which defaults to true.
 - Over the course of debugging this issue we added several similar 
options to compact at various other times, but they should not be 
neceessary for any normal users.

At this point we are in a pretty good position.  There are still some hard 
to hit mon bugs present, but they are not dangerous (ceph-mon restart will 
do the trick).  They are largely fixed in the master branch but we want to 
test further before risking any backports.

Meanwhile, the next development release will be changing the way all the 
pg metadata in the monitor is stored to be much more efficient and to take 
advantage of leveldb's capabilities; this will be present in 0.66 
(dumpling - 1).

sage
