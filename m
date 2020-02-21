From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/4] ceph: don't request caps for idle open files
Date: Fri, 21 Feb 2020 09:08:05 -0500
Message-ID: <32d80496ed9aa08bcda5a64dca59b3f1139b4331.camel@kernel.org>
References: <20200221131659.87777-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbgBUOIH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:08:07 -0500
In-Reply-To: <20200221131659.87777-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

On Fri, 2020-02-21 at 21:16 +0800, Yan, Zheng wrote:
> This series make cephfs client not request caps for open files that
> idle for a long time. For the case that one active client and multiple
> standby clients open the same file, this increase the possibility that
> mds issues exclusive caps to the active client.
> 
> Yan, Zheng (4):
>   ceph: always renew caps if mds_wanted is insufficient
>   ceph: consider inode's last read/write when calculating wanted caps
>   ceph: simplify calling of ceph_get_fmode()
>   ceph: remove delay check logic from ceph_check_caps()
> 
>  fs/ceph/caps.c               | 324 +++++++++++++++--------------------
>  fs/ceph/file.c               |  39 ++---
>  fs/ceph/inode.c              |  19 +-
>  fs/ceph/ioctl.c              |   2 +
>  fs/ceph/mds_client.c         |   5 -
>  fs/ceph/super.h              |  35 ++--
>  include/linux/ceph/ceph_fs.h |   1 +
>  7 files changed, 188 insertions(+), 237 deletions(-)
> 

This looks really good -- nice work, Zheng!

I had a minor nit with patch #2, but I'm not too concerned about it and
it can be fixed up after merge if necessary.

The async dirops set has some conflicts, and Xiubo's stats work may
also. I'm going to go ahead and merge this into testing so we can base
further work on top of it.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
