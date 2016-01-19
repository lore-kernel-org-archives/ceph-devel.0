From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 0/6] scattered page writeback
Date: Tue, 19 Jan 2016 16:08:05 +0800
Message-ID: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbcASII3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:29 -0500
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
 fs/ceph/addr.c                  | 221 +++++++++++++++++++++++++---------------
 include/linux/ceph/osd_client.h |  17 +++-
 net/ceph/osd_client.c           | 134 ++++++++++++++++++++----
 4 files changed, 268 insertions(+), 106 deletions(-)

Changes since V1
 . Estimate number of discontiguous dirty pages in ceph_writepages_start()
 . Use kzalloc() to allocate r_ops array
 . Calculate reply message size according to max_ops

-- 
2.5.0

