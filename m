From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for v2.6.36-rc6
Date: Tue, 21 Sep 2010 11:18:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009211109280.17668@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46026 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758120Ab0IUSQg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Sep 2010 14:16:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes for v2.6.36-rc6 from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are a few fixes for bugs introduced in -rc1 (mds reconnect, bad 
kunmap), a corruption fix for 32 bit archs (wrap at 4GB), a crash 
triggered with multiple mounts (e.g., both server:/foo and server:/), a 
Kconfig fixup, and a cap logic fix.  The balance are more fixes for 
snapped metadata writeback to the MDS.

Thanks!
sage


Sage Weil (10):
      ceph: fix null pointer deref on anon root dentry release
      ceph: fix reconnect encoding for old servers
      ceph: fix file offset wrapping at 4GB on 32-bit archs
      ceph: fix dn offset during readdir_prepopulate
      ceph: correctly set 'follows' in flushsnap messages
      ceph: stop sending FLUSHSNAPs when we hit a dirty capsnap
      ceph: fix cap_snap and realm split
      ceph: only send one flushsnap per cap_snap per mds session
      ceph: check mapping to determine if FILE_CACHE cap is used
      ceph: select CRYPTO

Yehuda Sadeh (1):
      ceph: fix pagelist kunmap tail

 fs/ceph/Kconfig      |    1 +
 fs/ceph/addr.c       |    7 ++--
 fs/ceph/caps.c       |   27 ++++++++++----
 fs/ceph/dir.c        |   10 ++++--
 fs/ceph/inode.c      |   11 +++---
 fs/ceph/mds_client.c |    2 +
 fs/ceph/pagelist.c   |   12 +++++-
 fs/ceph/snap.c       |   92 +++++++++++++++++---------------------------------
 fs/ceph/super.h      |    5 ++-
 9 files changed, 84 insertions(+), 83 deletions(-)
