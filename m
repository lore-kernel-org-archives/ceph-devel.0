From: Sage Weil <sage@inktank.com>
Subject: [PATCH 0/9] messenger fixups, batch #1
Date: Fri, 20 Jul 2012 17:41:39 -0700
Message-ID: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab2GUAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

This is the series I elbowed into testing today.  There is the CRUSH
support, and some incremental cleanups and fixes to the messenger that my
testing with socket failure injection turned up.  The basic strategy here
is to move more things under the con->mutex and drop useless checks/calls
where possible.

Sage Weil (8):
  libceph: move feature bits to separate header
  libceph: report socket read/write error message
  libceph: fix mutex coverage for ceph_con_close
  libceph: resubmit linger ops when pg mapping changes
  libceph: (re)initialize bio_iter on start of message receive
  ceph: close old con before reopening on mds reconnect
  libceph: protect ceph_con_open() with mutex
  libceph: reset connection retry on successfully negotiation

caleb miles (1):
  libceph: support crush tunables

 fs/ceph/mds_client.c               |    2 +
 fs/ceph/super.c                    |    1 +
 include/linux/ceph/ceph_features.h |   26 ++++++++++++++++++++++++
 include/linux/ceph/ceph_fs.h       |   14 ------------
 include/linux/ceph/libceph.h       |    6 -----
 include/linux/crush/crush.h        |    8 +++++++
 net/ceph/ceph_common.c             |    5 ++-
 net/ceph/crush/mapper.c            |   13 ++++++-----
 net/ceph/messenger.c               |   31 +++++++++++++++++++++-------
 net/ceph/osd_client.c              |   26 +++++++++++++++++++----
 net/ceph/osdmap.c                  |   39 ++++++++++++++++++++++++++++++++++++
 11 files changed, 130 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/ceph/ceph_features.h

-- 
1.7.9

