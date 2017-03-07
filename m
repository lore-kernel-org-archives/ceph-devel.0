From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 7 Mar 2017 03:13:22 +0300
Message-ID: <20170307001322.GA28752@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:43030 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbdCGElp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 23:41:45 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v270EhO3014770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Tue, 7 Mar 2017 00:14:44 GMT
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jack@suse.cz
Cc: ceph-devel@vger.kernel.org

Hello Jan Kara,

The patch 165a5e22fafb: "block: Move bdi_unregister() to
del_gendisk()" from Feb 8, 2017, leads to the following static
checker warning:

	drivers/block/rbd.c:4117 rbd_free_disk()
	warn: variable dereferenced before check 'disk->queue' (see line 4116)

drivers/block/rbd.c
  4107  static void rbd_free_disk(struct rbd_device *rbd_dev)
  4108  {
  4109          struct gendisk *disk = rbd_dev->disk;
  4110  
  4111          if (!disk)
  4112                  return;
  4113  
  4114          rbd_dev->disk = NULL;
  4115          if (disk->flags & GENHD_FL_UP) {
  4116                  del_gendisk(disk);
                        ^^^^^^^^^^^^^^^^^
The patch introduces a new dereference inside this function call.

  4117                  if (disk->queue)
                            ^^^^^^^^^^^
Check is too late.

  4118                          blk_cleanup_queue(disk->queue);
  4119                  blk_mq_free_tag_set(&rbd_dev->tag_set);
  4120          }
  4121          put_disk(disk);
  4122  }

regards,
dan carpenter
