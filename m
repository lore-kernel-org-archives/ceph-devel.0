From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.8-rc2
Date: Fri, 19 Jun 2020 14:35:47 +0200
Message-ID: <20200619123547.14353-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbgFSMfj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2020 08:35:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.8-rc2

for you to fetch changes up to 7ed286f3e061ee394782bd9fb4ed96bff0b5a021:

  libceph: don't omit used_replica in target_copy() (2020-06-16 16:02:08 +0200)

----------------------------------------------------------------
An important follow-up for replica reads support that went into -rc1
and two target_copy() fixups.

----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: move away from global osd_req_flags
      libceph: don't omit recovery_deletes in target_copy()
      libceph: don't omit used_replica in target_copy()

 drivers/block/rbd.c          |  4 +++-
 include/linux/ceph/libceph.h |  4 ++--
 net/ceph/ceph_common.c       | 14 ++++++--------
 net/ceph/osd_client.c        |  9 ++++-----
 4 files changed, 15 insertions(+), 16 deletions(-)
