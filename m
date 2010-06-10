From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] ceph fixes for 2.6.35-rc3
Date: Thu, 10 Jun 2010 14:09:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006101351070.1777@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59554 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab0FJVIr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jun 2010 17:08:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following ceph fixes from

 git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

Most of these are one- or few-liners, including an IA64 build error, a 
caching issue, a statfs memory leak, a bad statfs result, a lease 
revocation fix, and misleading console output.  The last two patches fix 
an mds interaction problem (deadlock with the mds) but need to move some 
code into a helper function to do it.

Thanks!
sage


Henry C Chang (1):
      ceph: fix d_subdirs ordering problem

Jeff Mahoney (1):
      ceph: fix atomic64_t initialization on ia64

Sage Weil (5):
      ceph: fix f_namelen reported by statfs
      ceph: fix lease revocation when seq doesn't match
      ceph: fix misleading/incorrect debug message
      ceph: release cap on import if we don't have the inode
      ceph: try to send partial cap release on cap message on missing inode

Yehuda Sadeh (1):
      ceph: fix memory leak in statfs

 fs/ceph/caps.c       |   93 ++++++++++++++++++++++++++++++-------------------
 fs/ceph/inode.c      |    2 +-
 fs/ceph/mds_client.c |   28 ++++++++------
 fs/ceph/mds_client.h |    6 +++
 fs/ceph/mon_client.c |    2 +
 fs/ceph/super.c      |    4 +-
 6 files changed, 84 insertions(+), 51 deletions(-)
