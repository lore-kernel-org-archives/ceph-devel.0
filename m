From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fix for 4.3
Date: Fri, 30 Oct 2015 11:52:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510301148560.23556@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following RBD fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This sets the stable pages flag on the RBD block device when we have CRCs 
enabled.  (This is necessary since the default assumption for block 
devices changed in 3.9.)

Thanks!
sage


----------------------------------------------------------------
Ronny Hegewald (1):
      rbd: require stable pages if message data CRCs are enabled

 drivers/block/rbd.c | 3 +++
 1 file changed, 3 insertions(+)
