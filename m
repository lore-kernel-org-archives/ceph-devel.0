From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for -rc7
Date: Wed, 19 Jun 2013 08:42:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306190840170.27425@cobra.newdream.net>
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

This fixes a problem preventing the kernel and userland librbd libraries 
from sharing data with the new format 2 images.

Thanks!
sage


----------------------------------------------------------------
Josh Durgin (1):
      rbd: use the correct length for format 2 object names

 drivers/block/rbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
