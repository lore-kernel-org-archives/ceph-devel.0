From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 0/2] clean up read only mode
Date: Tue, 8 Oct 2013 11:40:54 +0800
Message-ID: <20131008034054.GA2763@x230>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
 <1380604559-5331-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39886 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab3JHDk7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 23:40:59 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so8173830pad.30
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 20:40:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380604559-5331-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 30, 2013 at 10:15:57PM -0700, Josh Durgin wrote:
> Running with lockdep showed that there were problems holding
> rbd_dev->lock while doing in the BLKROSET ioctl patch. Fix this, and
> clean up the initial read-only setting to occur during device
> initialization instead of every time the device is opened.
> 
> These are also available in the wip-rbd-ro branch of ceph-client.git.
> 
> Josh Durgin (2):
>   rbd: move calls that may sleep out of spin lock range
>   rbd: only set disk to read-only once

Both look good.

> 
>  drivers/block/rbd.c |   38 ++++++++++++++++++++++++--------------
>  1 files changed, 24 insertions(+), 14 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best regards,
Guangliang
