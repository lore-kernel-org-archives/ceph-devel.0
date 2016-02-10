From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/4] wip-alloc-request
Date: Wed, 10 Feb 2016 12:24:03 +0100
Message-ID: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36465 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbcBJLYj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:24:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id 128so3515224wmz.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 03:24:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Hello,

This is to replace

40ca9b2c9bbb libceph: enlarge max number of operations in OSD request
d0c2fddbf154 libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op
7c6ad0dab79d libceph: allow reserving operations in OSD request

The current solution is clunky: for larger than usual requests, it does
two memory allocations instead of one and wastes 3 ops (~500 bytes) of
memory for each request.  This series fixes both of those.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: rename ceph_osd_req_op::payload_len to indata_len
  libceph: osdc->req_mempool should be backed by a slab pool
  libceph: enable large, variable-sized OSD requests

Yan, Zheng (1):
  libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op

 drivers/block/rbd.c             |  4 +---
 include/linux/ceph/osd_client.h | 13 +++++++----
 net/ceph/osd_client.c           | 52 +++++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 31 deletions(-)

-- 
2.4.3

