From: Sage Weil <sage@inktank.com>
Subject: xfs tuning
Date: Fri, 14 Sep 2012 11:46:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209141138320.16552@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab2INSqv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 14:46:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: hch@infradead.org

When I talked to Christoph at Linuxcon a couple weeks back he suggested 
several things that may improve performance on XFS.  These are things taht 
helped with Sheepdog workloads, which are somewhat similar.

* mount -o inode64 will keep inodes closer to file data for larger disks.

* mount -o filestreams will enable an alternative allocator that works 
better for fixed sized files, but it should probably used in conjuntion 
with something that explicitly fallocates rbd objects to 4mb.  I have a 
preliminary branch wip-osd-alloc that puts some of the osd-side bits in 
place, but it needs some work, including the rbd bit that adds the 
PREALLOC op to the requests.

* mount -o noatime, of course.

I forget what else.  :)

sage
