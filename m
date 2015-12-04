From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph update for -rc4
Date: Fri, 4 Dec 2015 12:32:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512041230240.25130@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468AbbLDUcc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 15:32:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This addresses a refcounting bug that leads to a use-after-free.

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: don't put snap_context twice in rbd_queue_workfn()

 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)
