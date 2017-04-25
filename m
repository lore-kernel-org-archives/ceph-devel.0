From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/9] rbd: support for rbd map --exclusive
Date: Tue, 25 Apr 2017 11:33:36 +0200
Message-ID: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32847 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428695AbdDYJeM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:12 -0400
Received: by mail-qk0-f182.google.com with SMTP id h123so53848090qke.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:12 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.10
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This adds support for optionally disabling automatic exclusive lock
transitions.  Patches 1-3 fix some existing error paths and can go in
independently.

Thanks,

                Ilya


Ilya Dryomov (9):
  rbd: move rbd_dev_destroy() call out of rbd_dev_image_release()
  rbd: move rbd_unregister_watch() call into rbd_dev_image_release()
  rbd: fix error handling around rbd_init_disk()
  rbd: ignore unlock errors
  rbd: store lock cookie
  rbd: support updating the lock cookie without releasing the lock
  rbd: kill rbd_is_lock_supported()
  rbd: return ResponseMessage result from rbd_handle_request_lock()
  rbd: exclusive map option

 drivers/block/rbd.c                  | 357 +++++++++++++++++++++--------------
 include/linux/ceph/cls_lock_client.h |   5 +
 net/ceph/cls_lock_client.c           |  51 +++++
 3 files changed, 270 insertions(+), 143 deletions(-)

-- 
2.4.3

