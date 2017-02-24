From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] libceph, ceph: get rid of ack vs commit
Date: Fri, 24 Feb 2017 14:52:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702241451390.7782@piezo.novalocal>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49770 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdBXOwY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 09:52:24 -0500
In-Reply-To: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Zheng Yan <zyan@redhat.com>

On Thu, 23 Feb 2017, Ilya Dryomov wrote:
> Hello,
> 
> This is all straightforward and passes tests, but I'd greatly
> appreciate an extra set of eyes on the fs/ceph bits.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (3):
>   ceph: remove special ack vs commit behavior
>   libceph: get rid of ack vs commit
>   libceph, rbd, ceph: WRITE | ONDISK -> WRITE
> 
>  drivers/block/rbd.c             |   6 +-
>  fs/ceph/addr.c                  |  14 ++---
>  fs/ceph/caps.c                  |   2 -
>  fs/ceph/file.c                  | 101 ++-------------------------------
>  fs/ceph/inode.c                 |   9 ---
>  fs/ceph/super.c                 |   1 -
>  fs/ceph/super.h                 |   4 +-
>  include/linux/ceph/osd_client.h |   6 +-
>  net/ceph/cls_lock_client.c      |  12 ++--
>  net/ceph/osd_client.c           | 120 ++++++++++------------------------------
>  10 files changed, 48 insertions(+), 227 deletions(-)

Reviewed-by: Sage Weil <sage@redhat.com>

...with the minor nit that the r_completion comment could be clarified!

sage
