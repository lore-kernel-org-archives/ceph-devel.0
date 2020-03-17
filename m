From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/3] rbd: fix some issues around flushing notifies
Date: Tue, 17 Mar 2020 13:04:19 +0100
Message-ID: <20200317120422.3406-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQMEu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2020 08:04:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so4680635wru.2
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 05:04:49 -0700 (PDT)
Received: from kwango.local (ip-94-112-129-237.net.upcbroadband.cz. [94.112.129.237])
        by smtp.gmail.com with ESMTPSA id p8sm4416706wrw.19.2020.03.17.05.04.45
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 05:04:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

A recent snapshot-based mirroring experiment exposed a deadlock on
header_rwsem in the error path of rbd_dev_image_probe() (i.e. "rbd
map").

Thanks,

                Ilya


Ilya Dryomov (3):
  rbd: avoid a deadlock on header_rwsem when flushing notifies
  rbd: call rbd_dev_unprobe() after unwatching and flushing notifies
  rbd: don't test rbd_dev->opts in rbd_dev_image_release()

 drivers/block/rbd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.19.2
