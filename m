From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for -rc5
Date: Fri, 29 Mar 2013 11:38:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303291114300.15836@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This fixes a regression introduced during the last merge window when 
mapping non-existent images.

Thanks!
sage


----------------------------------------------------------------
Alex Elder (1):
      rbd: don't zero-fill non-image object requests

 drivers/block/rbd.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)
