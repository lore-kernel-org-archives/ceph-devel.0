From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph updates part 2
Date: Sun, 6 Nov 2011 15:05:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111061502001.22861@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1KFXFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Nov 2011 18:05:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull this second set of Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two sparse cleanup patches I missed before, and a second set of 
patches that reenable some of Ceph usage of the dcache that build on the 
d_prune dentry_operation that was merged this week.

I also finally got the tree back on kernel.org.  (You'll find the same 
commits on github, where most of the development work will remain.)

Thanks!
sage


H Hartley Sweeten (2):
      ceph/mds_client.c: quiet sparse noise
      ceph/super.c: quiet sparse noise

Sage Weil (2):
      ceph: clear parent D_COMPLETE flag when on dentry prune
      ceph: use new D_COMPLETE dentry flag

 fs/ceph/caps.c       |    8 ++---
 fs/ceph/dir.c        |   87 ++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/inode.c      |    8 ++--
 fs/ceph/mds_client.c |   10 +++---
 fs/ceph/super.c      |    4 +-
 fs/ceph/super.h      |   23 ++++++++++++-
 6 files changed, 113 insertions(+), 27 deletions(-)
