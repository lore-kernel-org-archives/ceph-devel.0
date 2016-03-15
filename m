From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Tue, 15 Mar 2016 15:52:46 +0200
Message-ID: <20160315135246.GA26802@redhat.com>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934119AbcCONwv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Mar 2016 09:52:51 -0400
Content-Disposition: inline
In-Reply-To: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: gkurz@linux.vnet.ibm.com, berrange@redhat.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

On Tue, Mar 15, 2016 at 12:02:48AM +0800, Jevon Qiao wrote:
> diff --git a/hw/9pfs/9p-cephfs.c b/hw/9pfs/9p-cephfs.c
> new file mode 100644
> index 0000000..e2d659d
> --- /dev/null
> +++ b/hw/9pfs/9p-cephfs.c
> @@ -0,0 +1,836 @@
> +/*
> + * 9p cephfs callback
> + *
> + * Copyright UnitedStack, Corp. 2016
> + *
> + * Authors:
> + *    Jevon Qiao <scaleqiao@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.

We generally prefer v2 or later.

> + *
> + */
> +
