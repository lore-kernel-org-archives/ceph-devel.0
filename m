From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for 3.10
Date: Fri, 28 Jun 2013 17:31:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306281726140.1830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This is a recently spotted regression in the snapshot behavior.... it 
turns out several tests weren't being run in the nightlies so this took a 
while to spot.

Thanks!
sage


----------------------------------------------------------------
Josh Durgin (1):
      rbd: send snapshot context with writes

 drivers/block/rbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
