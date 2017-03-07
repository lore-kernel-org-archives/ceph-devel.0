From: Jan Kara <jack@suse.cz>
Subject: Re: [bug report] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 7 Mar 2017 11:44:40 +0100
Message-ID: <20170307104440.GC2578@quack2.suse.cz>
References: <20170307001322.GA28752@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754662AbdCGLEE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 06:04:04 -0500
Content-Disposition: inline
In-Reply-To: <20170307001322.GA28752@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jack@suse.cz, ceph-devel@vger.kernel.org

Hi,

thanks for report! So don't see a way how rbd could pass gendisk with NULL
disk->queue to del_gendisk(). Also blk_unregister_queue() just after the
dereference I've added does WARN_ON(!disk->queue) so we would know about
such case if it could happen for whatever caller of del_gendisk(). However
for future safety, I could add a check for disk->queue being non-NULL to
del_gendisk().

								Honza

On Tue 07-03-17 03:13:22, Dan Carpenter wrote:
> Hello Jan Kara,
> 
> The patch 165a5e22fafb: "block: Move bdi_unregister() to
> del_gendisk()" from Feb 8, 2017, leads to the following static
> checker warning:
> 
> 	drivers/block/rbd.c:4117 rbd_free_disk()
> 	warn: variable dereferenced before check 'disk->queue' (see line 4116)
> 
> drivers/block/rbd.c
>   4107  static void rbd_free_disk(struct rbd_device *rbd_dev)
>   4108  {
>   4109          struct gendisk *disk = rbd_dev->disk;
>   4110  
>   4111          if (!disk)
>   4112                  return;
>   4113  
>   4114          rbd_dev->disk = NULL;
>   4115          if (disk->flags & GENHD_FL_UP) {
>   4116                  del_gendisk(disk);
>                         ^^^^^^^^^^^^^^^^^
> The patch introduces a new dereference inside this function call.
> 
>   4117                  if (disk->queue)
>                             ^^^^^^^^^^^
> Check is too late.
> 
>   4118                          blk_cleanup_queue(disk->queue);
>   4119                  blk_mq_free_tag_set(&rbd_dev->tag_set);
>   4120          }
>   4121          put_disk(disk);
>   4122  }
> 
> regards,
> dan carpenter
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
