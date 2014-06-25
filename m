From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 00/14] rbd: #6628 fixes (wip-remove-osd-6628)
Date: Wed, 25 Jun 2014 21:16:33 +0400
Message-ID: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49138 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRQv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:16:51 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so2088770lbj.31
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:16:50 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id j13sm1807121lab.39.2014.06.25.10.16.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:16:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

This series is the result of hunting down and fixing #6628.  The core
patches are:

 7/14 libceph: unregister only registered linger requests
10/14 rbd: rbd_obj_request_wait() should cancel the request if interrupted
12/14 rbd: use rbd_obj_watch_request_helper() helper
14/14 libceph: drop osd ref when canceling con work

The rest are cleanups and miscellaneous fixes.  wip-remove-osd-6628 has
been force-pushed.

Thanks,

                Ilya


Ilya Dryomov (14):
  libceph: rename ceph_osd_request::r_linger_osd to r_linger_osd_item
  libceph: add maybe_move_osd_to_lru() and switch to it
  libceph: move and add dout()s to ceph_msg_{get,put}()
  libceph: move and add dout()s to ceph_osdc_request_{get,put}()
  libceph: harden ceph_osdc_request_release() a bit
  libceph: assert both regular and lingering lists in __remove_osd()
  libceph: unregister only registered linger requests
  libceph: fix linger request check in __unregister_request()
  libceph: introduce ceph_osdc_cancel_request()
  rbd: rbd_obj_request_wait() should cancel the request if interrupted
  rbd: add rbd_obj_watch_request_helper() helper
  rbd: use rbd_obj_watch_request_helper() helper
  libceph: nuke ceph_osdc_unregister_linger_request()
  libceph: drop osd ref when canceling con work

 drivers/block/rbd.c             |  191 ++++++++++++++++++---------------------
 include/linux/ceph/messenger.h  |   14 +--
 include/linux/ceph/osd_client.h |   18 +---
 net/ceph/messenger.c            |   45 ++++++---
 net/ceph/osd_client.c           |  129 +++++++++++++++++---------
 5 files changed, 217 insertions(+), 180 deletions(-)

-- 
1.7.10.4

