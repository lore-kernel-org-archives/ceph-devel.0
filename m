From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.8-rc2
Date: Thu, 11 Aug 2016 15:06:48 +0200
Message-ID: <1470920808-14863-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34946 "EHLO
	mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbcHKNHB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 09:07:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.8-rc2

for you to fetch changes up to 4eacd4cb3a7c4794688ef4fad5d01f3a532a58e9:

  ceph: initialize pathbase in the !dentry case in encode_caps_cb() (2016-08-09 17:26:56 +0200)

----------------------------------------------------------------
A patch for a NULL dereference bug introduced in 4.8-rc1 and a handful
of static checker fixes.

----------------------------------------------------------------
Ilya Dryomov (3):
      rbd: destroy header_oloc in rbd_dev_release()
      rbd: nuke the 32-bit pool id check
      ceph: initialize pathbase in the !dentry case in encode_caps_cb()

Wei Yongjun (3):
      libceph: fix return value check in alloc_msg_with_page_vector()
      libceph: make cancel_generic_request() static
      libceph: using kfree_rcu() to simplify the code

Yan, Zheng (1):
      ceph: fix null pointer dereference in ceph_flush_snaps()

 drivers/block/rbd.c     | 10 +---------
 fs/ceph/caps.c          |  5 ++++-
 fs/ceph/mds_client.c    |  1 +
 net/ceph/mon_client.c   |  2 +-
 net/ceph/osd_client.c   |  2 +-
 net/ceph/string_table.c |  8 +-------
 6 files changed, 9 insertions(+), 19 deletions(-)
