From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v3 0/4] rbd improvements
Date: Tue, 12 Apr 2011 17:45:22 -0700
Message-ID: <cover.1302653035.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49685 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab1DMAqf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 20:46:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>

This patchset moves the complexity of the rbd format into librbd and
adds truncation support. This passes qemu-iotests when 016 is
skipped. A patch for this is in a separate email.

Changes since v2:
 * return values are checked in rbd_aio_rw_vector
 * bdrv_truncate added

Josh Durgin (4):
  rbd: use the higher level librbd instead of just librados
  rbd: allow configuration of rados from the rbd filename
  rbd: check return values when scheduling aio
  rbd: Add bdrv_truncate implementation

 block/rbd.c       |  889 +++++++++++++++++++----------------------------------
 block/rbd_types.h |   71 -----
 configure         |   33 +--
 3 files changed, 331 insertions(+), 662 deletions(-)
 delete mode 100644 block/rbd_types.h

-- 
1.7.2.3

