From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/2] ceph_features.h kernel update
Date: Fri, 27 Dec 2013 09:51:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312270951140.670@cobra.newdream.net>
References: <1387914112-17809-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33255 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab3L0RvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Dec 2013 12:51:22 -0500
In-Reply-To: <1387914112-17809-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

both look good!

Reviewed-by: Sage Weil <sage@inktank.com>


On Tue, 24 Dec 2013, Ilya Dryomov wrote:

> Hello,
> 
> This is needed for the kernel to be able to advertise our new CRUSH_V2
> features correctly.  wip-crush-2 depends and was rebased on top of
> this.  Please make sure I got the 33rd bit work-around right.
> 
> Available from wip-ceph-features branch of ceph-client.git.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (2):
>   libceph: all features fields must be u64
>   libceph: update ceph_features.h
> 
>  fs/ceph/mds_client.c               |   14 +++---
>  fs/ceph/super.c                    |    4 +-
>  include/linux/ceph/ceph_features.h |   96 ++++++++++++++++++++++++------------
>  include/linux/ceph/libceph.h       |    8 +--
>  include/linux/ceph/messenger.h     |   10 ++--
>  net/ceph/ceph_common.c             |    4 +-
>  net/ceph/messenger.c               |    8 +--
>  7 files changed, 89 insertions(+), 55 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
