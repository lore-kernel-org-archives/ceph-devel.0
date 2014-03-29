From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for 3.14
Date: Sat, 29 Mar 2014 11:28:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403291125140.2734@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please full a Ceph RBD fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This drops a bad assert that a few users have been hitting but we've only 
recently been able to track down.

Thanks!
sage



----------------------------------------------------------------
Alex Elder (1):
      rbd: drop an unsafe assertion

 drivers/block/rbd.c |    1 -
 1 file changed, 1 deletion(-)
