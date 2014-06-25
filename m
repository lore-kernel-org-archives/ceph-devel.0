From: Sage Weil <sage@redhat.com>
Subject: [GIT PULL] Ceph fix for -rc4
Date: Wed, 25 Jun 2014 10:25:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406251019260.12946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following patch for Ceph from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This fixes a corner case for cloned RBD images.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: handle parent_overlap on writes correctly

 drivers/block/rbd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
