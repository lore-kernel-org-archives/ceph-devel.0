From: Sage Weil <sage@inktank.com>
Subject: [PATCH 0/4] fixes for 3.6-rc3
Date: Tue, 21 Aug 2012 12:19:28 -0700
Message-ID: <1345576772-3284-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42588 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566Ab2HUTHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 15:07:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

These fixes are queued for 3.6-rc3.  Please take a look before I send them
to Linus.

Thanks!
sage



Jim Schutt (1):
  libceph: avoid truncation due to racing banners

Sage Weil (3):
  libceph: delay debugfs initialization until we learn global_id
  ceph: tolerate (and warn on) extraneous dentry from mds
  ceph: avoid divide by zero in __validate_layout()

 fs/ceph/debugfs.c      |    1 +
 fs/ceph/inode.c        |   15 +++++++++----
 fs/ceph/ioctl.c        |    3 +-
 net/ceph/ceph_common.c |    1 -
 net/ceph/debugfs.c     |    4 +++
 net/ceph/messenger.c   |   11 ++++++++-
 net/ceph/mon_client.c  |   51 +++++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 72 insertions(+), 14 deletions(-)

-- 
1.7.9

