From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 3.18
Date: Mon, 3 Nov 2014 02:47:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411030242480.13332@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following fixes for RBD from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is a GFP flag fix from Mike Christie, an error code fix from Jan, 
and fixes for two unnecessary allocations (kmalloc and workqueue) from 
Ilya. All are well tested.

Ilya has one other fix on the way but it didn't get tested in time.

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: use a single workqueue for all devices
      libceph: eliminate unnecessary allocation in process_one_ticket()

Jan Kara (1):
      rbd: Fix error recovery in rbd_obj_read_sync()

Mike Christie (1):
      libceph: use memalloc flags for net IO

 drivers/block/rbd.c  | 35 +++++++++++++++++++----------------
 net/ceph/auth_x.c    | 25 ++++++++++---------------
 net/ceph/messenger.c | 10 +++++++++-
 3 files changed, 38 insertions(+), 32 deletions(-)
