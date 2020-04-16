From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.7-rc2
Date: Thu, 16 Apr 2020 19:23:21 +0200
Message-ID: <20200416172321.20778-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388338AbgDPRXj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:23:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.7-rc2

for you to fetch changes up to 2a575f138d003fff0f4930b5cfae4a1c46343b8f:

  ceph: fix potential bad pointer deref in async dirops cb's (2020-04-13 19:33:47 +0200)

----------------------------------------------------------------
A set of patches for a deadlock on "rbd map" error path and a fix
for invalid pointer dereference and uninitialized variable use on
asynchronous create and unlink error paths.

----------------------------------------------------------------
Ilya Dryomov (4):
      rbd: avoid a deadlock on header_rwsem when flushing notifies
      rbd: call rbd_dev_unprobe() after unwatching and flushing notifies
      rbd: don't test rbd_dev->opts in rbd_dev_image_release()
      rbd: don't mess with a page vector in rbd_notify_op_lock()

Jeff Layton (1):
      ceph: fix potential bad pointer deref in async dirops cb's

 drivers/block/rbd.c  | 33 +++++++++++++++++++--------------
 fs/ceph/dir.c        |  4 ++--
 fs/ceph/file.c       |  4 ++--
 fs/ceph/mds_client.h |  2 +-
 4 files changed, 24 insertions(+), 19 deletions(-)
