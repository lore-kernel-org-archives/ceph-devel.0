From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/1 RESEND] fs/ceph/inode.c: Remove get/set acl on
 symlinks
Date: Fri, 21 Mar 2014 10:38:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403211037400.5823@cobra.newdream.net>
References: <20140321174001.3a2c665e84aed66f387ca4fc@skynet.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140321174001.3a2c665e84aed66f387ca4fc@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

We've pulled this into the Ceph tree.

Thanks, Fabian!
sage


On Fri, 21 Mar 2014, Fabian Frederick wrote:

> Remove unsupported symlink operations.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  fs/ceph/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 32d519d..704d714 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1616,8 +1616,6 @@ static const struct inode_operations ceph_symlink_iops = {
>  	.getxattr = ceph_getxattr,
>  	.listxattr = ceph_listxattr,
>  	.removexattr = ceph_removexattr,
> -	.get_acl = ceph_get_acl,
> -	.set_acl = ceph_set_acl,
>  };
>  
>  /*
> -- 
> 1.8.4.5
> 
> 
