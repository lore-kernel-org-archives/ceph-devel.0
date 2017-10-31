From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: remove the bump of i_version
Date: Tue, 31 Oct 2017 15:12:55 +0800
Message-ID: <6CFECEEA-F354-4B60-82DA-3D400E646A0F@redhat.com>
References: <20171030145423.32159-1-jlayton@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdJaHND (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Oct 2017 03:13:03 -0400
In-Reply-To: <20171030145423.32159-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



> On 30 Oct 2017, at 22:54, Jeff Layton <jlayton@kernel.org> wrote:
> 
> From: Jeff Layton <jlayton@redhat.com>
> 
> Eventually, we'll want to wire cephfs up to use the change attribute
> that the cluster tracks instead, but for now this is unneeded.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/inode.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 373dab5173ca..8aae7200a425 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -785,7 +785,6 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
> 
> 	/* update inode */
> 	ci->i_version = le64_to_cpu(info->version);
> -	inode->i_version++;
> 	inode->i_rdev = le32_to_cpu(info->rdev);
> 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
> 

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> -- 
> 2.13.6
> 

