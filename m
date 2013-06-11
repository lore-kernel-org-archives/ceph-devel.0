From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Tue, 11 Jun 2013 13:24:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306111320070.28283@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following fixes for Ceph from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is a pair of fixes for double-frees in the recent bundle for 3.10, a 
couple of fixes for long-standing bugs (sleep while atomic and an 
endianness fix), and a locking fix that can be triggered when osds are 
going down.

Thanks!
sage

----------------------------------------------------------------
Alex Elder (3):
      libceph: must hold mutex for reset_changed_osds()
      rbd: don't destroy ceph_opts in rbd_add()
      rbd: fix cleanup in rbd_add()

Jim Schutt (2):
      ceph: add cpu_to_le32() calls when encoding a reconnect capability
      ceph: ceph_pagelist_append might sleep while atomic

 drivers/block/rbd.c   | 33 ++++++++++++-----------
 fs/ceph/locks.c       | 73 +++++++++++++++++++++++++++++++++------------------
 fs/ceph/mds_client.c  | 65 ++++++++++++++++++++++++---------------------
 fs/ceph/super.h       |  9 +++++--
 net/ceph/osd_client.c |  2 +-
 5 files changed, 108 insertions(+), 74 deletions(-)
