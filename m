From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/8] rbd: layering (mostly) error path fixes
Date: Mon, 19 Sep 2016 19:03:20 +0200
Message-ID: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33973 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbcISRDn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:43 -0400
Received: by mail-yb0-f180.google.com with SMTP id x93so92823180ybh.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Hello,

This is what came out of looking at David's rbd_img_obj_exists_submit()
patches.  Alex, I'd appreciate it if you could take look, at patch 4 in
particular.

Thanks,

                Ilya


Ilya Dryomov (8):
  rbd: change rbd_obj_request_submit() signature
  rbd: clean up asserts in rbd_img_obj_request_submit() helpers
  rbd: mark the original request as done if stat request fails
  rbd: move bumping img_request refcount into rbd_obj_request_submit()
  rbd: don't crash or leak on errors in
    rbd_img_obj_parent_read_full_callback()
  rbd: rework rbd_img_obj_exists_submit() error paths
  rbd: don't call rbd_osd_req_format_read() for !img_data requests
  rbd: img_data requests don't own their page array

 drivers/block/rbd.c | 199 ++++++++++++++++++++++------------------------------
 1 file changed, 82 insertions(+), 117 deletions(-)

-- 
2.4.3

