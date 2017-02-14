From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 00/15] rbd: support for data-pool + obj_request->object_no
Date: Tue, 14 Feb 2017 21:11:49 +0100
Message-ID: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35855 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbdBNUM3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:29 -0500
Received: by mail-qt0-f193.google.com with SMTP id h53so18733332qth.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Hello,

There are two pieces here: support for RBD_FEATURE_DATA_POOL (patches
1-10) and a couple of cleanups / minor optimizations that build on it
and allow us to get rid of rbd_segment_name_cache (patches 11 - 15).

Thanks,

                Ilya


Ilya Dryomov (15):
  rbd: use kstrndup() in rbd_header_from_disk()
  rbd: kill rbd_image_header::{crypt_type,comp_type}
  rbd: initialize rbd_dev->header_oloc early
  rbd: do away with obj_request in rbd_obj_read_sync()
  libceph: pass reply buffer length through ceph_osdc_call()
  rbd: switch rbd_obj_method_sync() to ceph_osdc_call()
  rbd: remove now unused rbd_obj_request_wait() and helpers
  rbd: use rbd_obj_bytes() more
  rbd: introduce rbd_init_layout()
  rbd: support for data-pool feature
  rbd: set offset and length outside of rbd_obj_request_create()
  rbd: factor out __rbd_osd_req_create()
  rbd: RBD_V{1,2}_DATA_FORMAT macros
  rbd: store and use obj_request->object_no
  rbd: kill obj_request->object_name and rbd_segment_name_cache

 drivers/block/rbd.c         | 601 +++++++++++++++++---------------------------
 drivers/block/rbd_types.h   |  10 +-
 include/linux/ceph/osdmap.h |   7 -
 net/ceph/cls_lock_client.c  |   2 +-
 net/ceph/osd_client.c       |   7 +-
 5 files changed, 238 insertions(+), 389 deletions(-)

-- 
2.4.3

