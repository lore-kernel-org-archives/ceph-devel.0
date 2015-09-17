From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc2
Date: Thu, 17 Sep 2015 11:52:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509171151020.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbbIQSwT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Sep 2015 14:52:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

for you to fetch changes up to 335c25858218e76ef47f92ecb9d22e919d36140d:

  libceph: advertise support for keepalive2 (2015-09-17 20:14:27 +0300)

These are both fixes to the new and improved keepalive2 behavior.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (2):
      libceph: don't access invalid memory in keepalive2 path
      libceph: advertise support for keepalive2

 include/linux/ceph/ceph_features.h | 1 +
 include/linux/ceph/messenger.h     | 4 +++-
 net/ceph/messenger.c               | 9 +++++----
 3 files changed, 9 insertions(+), 5 deletions(-)
