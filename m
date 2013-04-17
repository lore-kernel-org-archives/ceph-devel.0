From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for 3.9
Date: Wed, 17 Apr 2013 12:33:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304171231520.30041@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull this final ceph fix for 3.9 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

It's a simple fix for a hard to hit race, but low-risk and clearly 
correct.

Thanks!
sage

----------------------------------------------------------------
Alex Elder (1):
      rbd: do a safe list traversal in rbd_img_request_submit()

 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
