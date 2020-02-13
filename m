From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/5] rbd: enable multiple blk-mq queues
Date: Thu, 13 Feb 2020 20:26:01 +0100
Message-ID: <20200213192606.31194-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44802 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgBMTZn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 14:25:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so8084214wrx.11
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 11:25:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>

Hi Hannes,

Here is what I intend to queue for 5.7.  I didn't hear from you on
the need to protect the object request list, the impact of image
request state_mutex on performance or the problem with queue_rq(),
so I concentrated on the tail of your series and reworked the payload
patch to avoid acquiring header_rwsem at least twice for each I/O.

I observed the same ~25-30% improvement in some rough synthetic tests
on a laptop (random 4k reads with very high queue depth in particular).
I assume you did your testing on real hardware -- it would be great if
you could share some details.

Thanks,

                Ilya


Hannes Reinecke (2):
  rbd: kill img_request kref
  rbd: enable multiple blk-mq queues

Ilya Dryomov (3):
  rbd: get rid of img_request_layered_clear()
  rbd: acquire header_rwsem just once in rbd_queue_workfn()
  rbd: embed image request in blk-mq pdu

 drivers/block/rbd.c | 212 +++++++++++++++++---------------------------
 1 file changed, 79 insertions(+), 133 deletions(-)

-- 
2.19.2
