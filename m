From: Sage Weil <sage@inktank.com>
Subject: emperor, firefly
Date: Thu, 31 Oct 2013 16:02:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310311254570.20027@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36565 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3JaXCa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 19:02:30 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id F30B080060
	for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 16:02:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CDA8080068
	for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 16:02:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just wanted to take a moment to call out some of the great work that went 
into emperor or is in progress for firely.  From the last CDS, completed 
blueprints include:

 - ceph osd zfs (Yan, Zheng).  This uses zfs snapshots the same way we use 
   btrfs snapshots, allowing more efficient journaling.  ZFS doesn't have 
   a 'clone' operation, so this doesn't get all of the efficiency advantages 
   from btrfs.

 - radosgw bucket level quota (Yehuda Sadeh).  User-level quotas are up 
   next!

 - teuthology bits (Zack Cerza et al).  Lots of the rough edges 
   in teuthology have been filed down over this past cycle and Loic 
   continues to organize weekly meetings to improve community usability.  
   Queuing improvements, and perhaps most exciting is a whole new 
   reporting framework from Alfredo and Zack that gathers results in a 
   database and builds a dashboard on top of that.

 - ceph-deploy (Alfredo Deza).  Huge steps forward here on packaging 
   (PyPi!), reliability/robustness (no more pushy), and the usability of 
   the interface (simplified cluster/monitor creation, etc.).

In progress blueprints:

 - erasure coding for rados (Loic Dachary, Samuel Just).  This is a huge 
   piece of work but most of the erasure coding math is in place and the 
   OSD refactoring work is on track for firefly!

 - mds inline data zupport (Li Wang).  These patches are pending review 
   and a few revisions (and testing!)

 - increasing ceph portability (Noah Watkins).  Noah, along with Alan 
   Somers, has been knocking down lots of the build and runtime issues on 
   *BSD and OS X.  Most are sitting in wip-port or have already trickled 
   into master.

 - cache pool overlay (Sage Weil, Greg Farnum): This work is also 
   partially completed but on track for firefly.

 - librados/objecter, smarter localized reads: This is pending review but 
   will make firefly.

 - leveldb osd backend (Hoamai Wang).  Last I hear this is in progress!

These is just the items that were on the Emperor CDS agenda that have made 
their way into my field of vision.  I'm looking forward to the firefly 
summit in a couple weeks!  There will be several sessions to cover the 
balance of the erasure coding and tiering work in detail (now that we're 
in the thick of it and more clearly see the path forward), and naturally 
some new blueprints as well.  If there are features or improvements you 
have in mind, feel free to float them on the list for some pre-discussion 
if you're not ready to write up a blueprint just yet.

sage
