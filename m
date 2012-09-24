From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for 3.6
Date: Sun, 23 Sep 2012 19:58:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209231956000.11925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36970 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2IXC6c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Sep 2012 22:58:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following fixes for Ceph from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The first fixes a leak in the rbd setup error path, and the second fixes a 
more serious problem with mismatched kmap/kunmap that surfaced after the 
recent refactoring work.

Thanks!
sage


----------------------------------------------------------------
Alex Elder (2):
      rbd: drop dev reference on error in rbd_open()
      libceph: only kunmap kmapped pages

 drivers/block/rbd.c  |    7 +++----
 net/ceph/messenger.c |    5 +----
 2 files changed, 4 insertions(+), 8 deletions(-)
