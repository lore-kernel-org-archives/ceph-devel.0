From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph updates for -rc7
Date: Fri, 23 Oct 2015 10:05:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510231003290.3943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following two patches from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

One is a stopgap to prevent a stack blowout when users have a deep chain 
of image clones.  (We'll rewrite this code to be non-recursive for the 
next window, but in the meantime this is a simple fix that avoids a 
crash.)  The second fixes a refcount underflow.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: don't leak parent_spec in rbd_dev_probe_parent()
      rbd: prevent kernel stack blow up on rbd map

 drivers/block/rbd.c | 69 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 30 deletions(-)
