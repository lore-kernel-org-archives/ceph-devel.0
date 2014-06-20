From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/4] rbd: #6628 fix (wip-remove-osd-6628)
Date: Fri, 20 Jun 2014 13:09:39 +0400
Message-ID: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34742 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbaFTJJs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 05:09:48 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so2125177lbi.25
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 02:09:46 -0700 (PDT)
Received: from localhost ([109.110.66.173])
        by mx.google.com with ESMTPSA id go4sm6142692lbc.35.2014.06.20.02.09.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 02:09:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This fixes #6628 ("krbd: BUG during ceph_osdc_stop() sometimes when
rbd_add() fails").

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: assert both regular and lingering lists in __remove_osd()
  libceph: introduce ceph_osdc_cancel_request()
  rbd: rbd_obj_request_wait() should cancel the request if interrupted
  rbd: add rbd_obj_watch_request_helper() helper

 drivers/block/rbd.c             |  154 ++++++++++++++++++---------------------
 include/linux/ceph/osd_client.h |    1 +
 net/ceph/osd_client.c           |   28 +++++--
 3 files changed, 93 insertions(+), 90 deletions(-)

-- 
1.7.10.4

