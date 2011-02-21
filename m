From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 2.6.38-rc6
Date: Mon, 21 Feb 2011 12:52:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102202115490.4468@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The main item here is a workaround for a regression caused by the dcache 
RCU stuff.  d_kill now clears d_parent prior to the release dentry op, 
which causes a NULL pointer dereference in the ceph code.  Nick said this 
should be easy enough to fix[1], but he's offline and it seems a bit late 
to futz with the core dcache code.  This patch basically just makes a copy 
of d_parent in the private d_fsdata struct.  We can revert it once the 
d_kill/d_parent thing gets fixed up, presumably during the next merge 
window.

There are also some error handling fixes and a fix for an possible 
infinite loop in the snapshot notification handler.

Thanks-
sage

[1] http://marc.info/?l=linux-fsdevel&m=129610552517424&w=2


Sage Weil (3):
      libceph: fix socket read error handling
      libceph: fix socket write error handling
      ceph: queue cap_snaps once per realm

Yehuda Sadeh (1):
      ceph: keep reference to parent inode on ceph_dentry

 fs/ceph/dir.c        |    5 +++-
 fs/ceph/snap.c       |   14 ++++++++---
 fs/ceph/super.h      |    1 +
 net/ceph/messenger.c |   62 +++++++++++++++++++++++++-------------------------
 4 files changed, 46 insertions(+), 36 deletions(-)
