From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc7
Date: Wed, 28 Jan 2015 10:55:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501281052170.19195@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbbA1U5y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Jan 2015 15:57:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following two patches from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

These paches from Ilya finally squash a race condition with layered images 
that he's been chasing for a while.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: fix rbd_dev_parent_get() when parent_overlap == 0
      rbd: drop parent_ref in rbd_dev_unprobe() unconditionally

 drivers/block/rbd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)
