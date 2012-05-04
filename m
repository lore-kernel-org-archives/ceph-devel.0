From: Sage Weil <sage@newdream.net>
Subject: [PATCH 00/11] crush kernel updates
Date: Fri,  4 May 2012 15:53:57 -0700
Message-ID: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37636 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760560Ab2EDWyL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We ripped out support for preferred osd placement in ceph since it was a
broken misfeature that nobody used.  When I went to mirror those changes on
the kernel side I found that a whole bunch of old stuff had never been moved
over, including a number of cleanups and an actual bug fix.  Everything is
now in the wip-crush tree on github.com/ceph/ceph-client.

This code is well tested in the sense that it has been this way on the 
userland side for ages (with the exception of the first preferred_osds 
patch).  That said, I've only done very basic testing of the kernel code,
so it's the crush callers that need attention.

I'd like to get this into the testing branch soon so we can see if it 
sorts out #2022.  A few of these should probably also go to Linus before 
the next window, too.

sage


Sage Weil (11):
  ceph: drop support for preferred_osd pgs
  ceph: refactor SETLAYOUT and SETDIRLAYOUT ioctl checks into common
    helper
  crush: clean up types, const-ness
  crush: adjust local retry threshold
  crush: be more tolerant of nonsensical crush maps
  crush: use a temporary variable to simplify crush_do_rule
  crush: remove forcefeed functionality
  crush: remove parent maps
  crush: fix tree node weight lookup
  crush: fix memory leak when destroying tree buckets
  crush: warn on do_rule failure

 drivers/block/rbd.c          |    1 -
 fs/ceph/file.c               |    1 -
 fs/ceph/ioctl.c              |   89 ++++++++++-------------
 fs/ceph/xattr.c              |    9 ---
 include/linux/ceph/ceph_fs.h |    4 +-
 include/linux/ceph/osdmap.h  |    2 -
 include/linux/crush/crush.h  |   18 ++---
 include/linux/crush/mapper.h |    7 +-
 net/ceph/crush/crush.c       |   45 +++---------
 net/ceph/crush/mapper.c      |  162 +++++++++++++++++------------------------
 net/ceph/osdmap.c            |   67 +++++------------
 11 files changed, 147 insertions(+), 258 deletions(-)

-- 
1.7.9

