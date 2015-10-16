From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Fri, 16 Oct 2015 08:20:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510160816380.16836@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

for you to fetch changes up to e30b7577bf1d338ca8a273bd2f881de5a41572b7:

  rbd: use writefull op for object size writes (2015-10-16 16:49:01 +0200)

Just two small items from Ilya:

The first patch fixes the RBD readahead to grab full objects.  The second 
fixes the write ops to prevent undue promotion when a cache tier is 
configured on the server side.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: set max_sectors explicitly
      rbd: use writefull op for object size writes

 drivers/block/rbd.c   | 10 ++++++++--
 net/ceph/osd_client.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)
