From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph RBD fix for -rc2
Date: Fri, 1 May 2015 16:47:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505011646290.7995@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbEAXr4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 May 2015 19:47:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following RBD fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: end I/O the entire obj_request on error

 drivers/block/rbd.c |    5 +++++
 1 file changed, 5 insertions(+)
