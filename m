From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 2.6.39-rc7
Date: Wed, 4 May 2011 13:18:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105041316490.748@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42656 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1EDUSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 16:18:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are some error paths that weren't handling ENOMEM properly, and a 
few more locking fixes that are fallout from Dave's inode_lock->i_lock 
changes.

Thanks!
sage


Henry C Chang (2):
      libceph: fix ceph_msg_new error path
      ceph: handle ceph_osdc_new_request failure in ceph_writepages_start

Sage Weil (3):
      ceph: use ihold() when i_lock is held
      libceph: fix ceph_osdc_alloc_request error checks
      ceph: do not call __mark_dirty_inode under i_lock

 drivers/block/rbd.c   |    4 ++--
 fs/ceph/addr.c        |    7 +++++++
 fs/ceph/caps.c        |   14 +++++++-------
 fs/ceph/file.c        |    5 ++++-
 fs/ceph/inode.c       |    6 +++++-
 fs/ceph/super.h       |    2 +-
 fs/ceph/xattr.c       |   12 ++++++++----
 net/ceph/messenger.c  |   26 +++++++++++++-------------
 net/ceph/osd_client.c |    4 ++--
 9 files changed, 49 insertions(+), 31 deletions(-)
