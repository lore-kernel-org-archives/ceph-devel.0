From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for 3.13-rc5
Date: Sun, 15 Dec 2013 21:31:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312130916510.14857@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following pair of Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

One of these is fixing a regression from the d_flags file type patch that 
went into -rc1 that broke instantiation of inodes and dentries (we were 
doing dentries first).  The other is just an off-by-one corner case.

Thanks!
sage

----------------------------------------------------------------
Li Wang (1):
      ceph: Avoid data inconsistency due to d-cache aliasing in readpage()

Yan, Zheng (1):
      ceph: initialize inode before instantiating dentry

 fs/ceph/addr.c  |   8 +++-
 fs/ceph/inode.c | 136 ++++++++++++++++++++++++--------------------------------
 2 files changed, 64 insertions(+), 80 deletions(-)
