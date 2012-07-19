From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for 3.5
Date: Thu, 19 Jul 2012 15:33:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207191451090.24473@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2GSWdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 18:33:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull these last minute fixes for Ceph from:

 git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The important one fixes a bug in the socket failure handling behavior that 
was turned up in some recent failure injection testing.  The other two are 
minor bug fixes.

Thanks!
sage

----------------------------------------------------------------
Dan Carpenter (1):
      rbd: endian bug in rbd_req_cb()

Sage Weil (1):
      libceph: fix messenger retry

Yan, Zheng (1):
      rbd: Fix ceph_snap_context size calculation

 drivers/block/rbd.c            |    4 ++--
 include/linux/ceph/messenger.h |   12 ++----------
 net/ceph/messenger.c           |   12 ++++++------
 3 files changed, 10 insertions(+), 18 deletions(-)
