From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Mon, 3 Aug 2015 07:39:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508030732330.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbbHCOj0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Aug 2015 10:39:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two critical regression fixes for CephFS from Zheng, and an RBD 
completion fix for layered images from Ilya.

(Note: git request-pull is complaining that the for-linus branch isn't 
referencing the right commit even though it is... hopefully I'm not doing 
something stupid.  The right commit is 
2761713d35e370fd640b5781109f753066b746c4.)

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: fix copyup completion race

Yan, Zheng (2):
      ceph: fix ceph_encode_locks_to_buffer()
      ceph: always re-send cap flushes when MDS recovers

 drivers/block/rbd.c | 22 +++++++++++++++++-----
 fs/ceph/caps.c      | 22 +++++-----------------
 fs/ceph/locks.c     |  2 +-
 fs/ceph/super.h     |  1 -
 4 files changed, 23 insertions(+), 24 deletions(-)
