From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ceph: attempt to do async create when possible
Date: Wed, 8 Apr 2020 16:27:41 +0300
Message-ID: <20200408132741.GO2066@kadam>
References: <20200408111734.GA252918@mwanda>
 <20200408112201.GN2066@kadam>
 <7114ea60738d083e618ac35beb840afeea74fce1.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:34804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDHN1x (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2020 09:27:53 -0400
Content-Disposition: inline
In-Reply-To: <7114ea60738d083e618ac35beb840afeea74fce1.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <ukernel@gmail.com>

On Wed, Apr 08, 2020 at 08:48:05AM -0400, Jeff Layton wrote:
>
> Sound ok?

Sounds good.

>  fs/ceph/mds_client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 1b40f30e0a8e..754e0682398e 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -531,7 +531,7 @@ extern void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc);
>  
>  static inline void ceph_mdsc_free_path(char *path, int len)
>  {
> -	if (path)
> +	if (path && !IS_ERR(path))

if (!IS_ERR_OR_NULL(path)

>  		__putname(path - (PATH_MAX - 1 - len));
>  }
>  
> -- 
> 2.25.2
> 

regards,
dan carpenter
