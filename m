From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Fri, 16 May 2014 12:59:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405161252410.5149@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The first patch fixes a problem when we have a page count of 0 for 
sendpage which is triggered by zfs.  The second fixes a bug in CRUSH that 
was resolved in the userland code a while back but fell through the cracks 
on the kernel side.

Thanks!
sage


----------------------------------------------------------------
Chunwei Chen (1):
      libceph: fix corruption when using page_count 0 page in rbd

Ilya Dryomov (1):
      crush: decode and initialize chooseleaf_vary_r

 net/ceph/messenger.c | 20 +++++++++++++++++++-
 net/ceph/osdmap.c    |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)
