From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 0/6] scattered page writeback
Date: Thu,  7 Jan 2016 22:05:22 +0800
Message-ID: <1452175528-20751-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40893 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbcAGOFn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jan 2016 09:05:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This series adds scattered page writeback, which uses one OSD request
to writeback nonconsecutive dirty page within single strip. Scattered
page writeback can increase performance of buffered random writes.

Yan, Zheng (6):
  libceph: enlarge max number of operations in OSD request
  libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op
  libceph: allow reserving operations in OSD request
  libceph: add helper that extends numner of operations in OSD request
  libceph: add helper that duplicates last extent operation
  ceph: scattered page writeback

 drivers/block/rbd.c             |   2 +-
 fs/ceph/addr.c                  | 209 ++++++++++++++++++++++++----------------
 include/linux/ceph/osd_client.h |  17 +++-
 net/ceph/osd_client.c           | 138 ++++++++++++++++++++++----
 4 files changed, 260 insertions(+), 106 deletions(-)

-- 
2.5.0

