From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fix for -rc3
Date: Thu, 7 Apr 2016 10:14:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604071012330.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbcDGOOO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 10:14:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvals@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph RBD patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This just fixes a few remaining memory allocations in RBD to use GFP_NOIO 
instead of GFP_ATOMIC.

Thanks!
sage

----------------------------------------------------------------
David Disseldorp (1):
      rbd: use GFP_NOIO consistently for request allocations

 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
