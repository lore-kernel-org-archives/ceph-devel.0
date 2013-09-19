From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for 3.12-rc2
Date: Thu, 19 Sep 2013 05:58:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309190551380.23507@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes for

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

These fix several bugs with RBD from 3.11 that didn't get tested in time 
for the merge window: some error handling, a use-after-free, and a 
sequencing issue when unmapping and image races with a notify operation.

There is also a patch fixing a problem with the new ceph + fscache code 
that just went in.

Thanks!
sage


----------------------------------------------------------------
Josh Durgin (6):
      libceph: add function to ensure notifies are complete
      rbd: complete notifies before cleaning up osd_client and rbd_dev
      rbd: make rbd_obj_notify_ack() synchronous
      rbd: fix use-after free of rbd_dev->disk
      rbd: ignore unmapped snapshots that no longer exist
      rbd: fix error handling from rbd_snap_name()

Milosz Tanski (1):
      fscache: check consistency does not decrement refcount

 drivers/block/rbd.c             | 77 +++++++++++++++++++++++++++++++----------
 fs/fscache/cookie.c             |  3 +-
 include/linux/ceph/osd_client.h |  2 ++
 net/ceph/osd_client.c           | 11 ++++++
 4 files changed, 74 insertions(+), 19 deletions(-)
