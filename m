From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v3 0/5] fix shutdown races and snapshot error handling
Date: Mon,  9 Sep 2013 00:16:57 -0700
Message-ID: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50653 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3IIH2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 03:28:19 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CE92C2646F
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:53 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BABE326469
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Patches 1-3 fix races between device removal and notify processing.

Patch 2 has an improved summary, fixes reference counting, and
renames the function as suggested by Alex.

Patch 3 is a reworked and simplified version that uses the existing
rbd_dev->flags and lock instead of adding new ones. It also restricts
where it holds the lock to avoid an inversion with bdev->lock.

Patch 4 is the same.

Patch 5 fixes an inconsistency noticed by Alex in his review of patch 4.

Josh Durgin (5):
  rbd: complete notifies before cleaning up osd_client and rbd_dev
  rbd: make rbd_obj_notify_ack() synchronous
  rbd: fix use-after free of rbd_dev->disk
  rbd: ignore unmapped snapshots that no longer exist
  rbd: fix error handling from rbd_snap_name()

 drivers/block/rbd.c |   71 ++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 53 insertions(+), 18 deletions(-)

-- 
1.7.2.5

