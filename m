From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 3/5] ceph: optimize flock encoding during reconnect
Date: Tue, 12 Sep 2017 09:03:24 -0400
Message-ID: <1505221404.28831.2.camel@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
         <20170912025351.42147-4-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35140 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILND1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 09:03:27 -0400
Received: by mail-yw0-f174.google.com with SMTP id q80so27996824ywg.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 06:03:27 -0700 (PDT)
In-Reply-To: <20170912025351.42147-4-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com

On Tue, 2017-09-12 at 10:53 +0800, Yan, Zheng wrote:
> don't malloc if there is no flock
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/locks.c      | 17 ++++++++++-------
>  fs/ceph/mds_client.c | 34 ++++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 33e091e6e8d3..4addd18ac6f9 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -430,19 +430,22 @@ int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
>  	if (err)
>  		goto out_fail;
>  
> -	err = ceph_pagelist_append(pagelist, flocks,
> -				   num_fcntl_locks * sizeof(*flocks));
> -	if (err)
> -		goto out_fail;
> +	if (num_fcntl_locks > 0) {
> +		err = ceph_pagelist_append(pagelist, flocks,
> +					   num_fcntl_locks * sizeof(*flocks));
> +		if (err)
> +			goto out_fail;
> +	}

Maybe it would be cleaner to just have ceph_pagelist_append immediately
return 0 when len == 0? Looks like it's basically a no-op otherwise.
>  
>  	nlocks = cpu_to_le32(num_flock_locks);
>  	err = ceph_pagelist_append(pagelist, &nlocks, sizeof(nlocks));
>  	if (err)
>  		goto out_fail;
>  
> -	err = ceph_pagelist_append(pagelist,
> -				   &flocks[num_fcntl_locks],
> -				   num_flock_locks * sizeof(*flocks));
> +	if (num_flock_locks > 0) {
> +		err = ceph_pagelist_append(pagelist, &flocks[num_fcntl_locks],
> +					   num_flock_locks * sizeof(*flocks));
> +	}
>  out_fail:
>  	return err;
>  }
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 6146af4ed03c..817ea438aa19 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2895,26 +2895,32 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
>  
>  	if (recon_state->msg_version >= 2) {
>  		int num_fcntl_locks, num_flock_locks;
> -		struct ceph_filelock *flocks;
> +		struct ceph_filelock *flocks = NULL;
>  		size_t struct_len, total_len = 0;
>  		u8 struct_v = 0;
>  
>  encode_again:
>  		ceph_count_locks(inode, &num_fcntl_locks, &num_flock_locks);
> -		flocks = kmalloc((num_fcntl_locks+num_flock_locks) *
> -				 sizeof(struct ceph_filelock), GFP_NOFS);
> -		if (!flocks) {
> -			err = -ENOMEM;
> -			goto out_free;
> -		}
> -		err = ceph_encode_locks_to_buffer(inode, flocks,
> -						  num_fcntl_locks,
> -						  num_flock_locks);
> -		if (err) {
> +		if (num_fcntl_locks + num_flock_locks > 0) {
> +			flocks = kmalloc((num_fcntl_locks + num_flock_locks) *
> +					 sizeof(struct ceph_filelock), GFP_NOFS);
> +			if (!flocks) {
> +				err = -ENOMEM;
> +				goto out_free;
> +			}
> +			err = ceph_encode_locks_to_buffer(inode, flocks,
> +							  num_fcntl_locks,
> +							  num_flock_locks);
> +			if (err) {
> +				kfree(flocks);
> +				flocks = NULL;
> +				if (err == -ENOSPC)
> +					goto encode_again;
> +				goto out_free;
> +			}
> +		} else {
>  			kfree(flocks);
> -			if (err == -ENOSPC)
> -				goto encode_again;
> -			goto out_free;
> +			flocks = NULL;
>  		}
>  
>  		if (recon_state->msg_version >= 3) {

Looks fine other than the nit above:

Reviewed-by: Jeff Layton <jlayton@redhat.com>
