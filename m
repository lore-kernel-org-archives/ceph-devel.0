From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fix for 3.10
Date: Tue, 25 Jun 2013 13:08:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306251253590.1091@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46408 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab3FYUIF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 16:08:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Plesae pull the following patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This fixes another problem with using v2 images on 3.10 due to the order 
in which fields are read from the image header.  Hopefully this is the 
last one.

Thanks!
sage


----------------------------------------------------------------
Josh Durgin (1):
      rbd: fetch object order before using it

 drivers/block/rbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
