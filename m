From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2] fs/ceph:fix double unlock in handle_cap_export()
Date: Tue, 28 Apr 2020 10:48:10 -0400
Message-ID: <e89bd817c69422c85f1945041dd83fbe8d534805.camel@kernel.org>
References: <1588079622-423774-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588079622-423774-1-git-send-email-wubo40@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wu Bo <wubo40@huawei.com>, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com, linfeilong@huawei.com
List-Id: ceph-devel.vger.kernel.org

On Tue, 2020-04-28 at 21:13 +0800, Wu Bo wrote:
> if the ceph_mdsc_open_export_target_session() return fails,
> should add a lock to avoid twice unlocking.
> Because the lock will be released at the retry or out_unlock tag.
> 

The problem looks real, but...

> --
> v1 -> v2:
> add spin_lock(&ci->i_ceph_lock) before goto out_unlock tag. 
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  fs/ceph/caps.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 185db76..414c0e2 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3731,22 +3731,25 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>  
>  	/* open target session */
>  	tsession = ceph_mdsc_open_export_target_session(mdsc, target);
> -	if (!IS_ERR(tsession)) {
> -		if (mds > target) {
> -			mutex_lock(&session->s_mutex);
> -			mutex_lock_nested(&tsession->s_mutex,
> -					  SINGLE_DEPTH_NESTING);
> -		} else {
> -			mutex_lock(&tsession->s_mutex);
> -			mutex_lock_nested(&session->s_mutex,
> -					  SINGLE_DEPTH_NESTING);
> -		}
> -		new_cap = ceph_get_cap(mdsc, NULL);
> -	} else {
> +	if (IS_ERR(tsession)) {
>  		WARN_ON(1);
>  		tsession = NULL;
>  		target = -1;
> +		mutex_lock(&session->s_mutex);
> +		spin_lock(&ci->i_ceph_lock);
> +		goto out_unlock;

Why did you make this case goto out_unlock instead of retrying as it did
before?

> +	}
> +
> +	if (mds > target) {
> +		mutex_lock(&session->s_mutex);
> +		mutex_lock_nested(&tsession->s_mutex,
> +					SINGLE_DEPTH_NESTING);
> +	} else {
> +		mutex_lock(&tsession->s_mutex);
> +		mutex_lock_nested(&session->s_mutex,
> +					SINGLE_DEPTH_NESTING);
>  	}
> +	new_cap = ceph_get_cap(mdsc, NULL);
>  	goto retry;
>  
>  out_unlock:

-- 
Jeff Layton <jlayton@kernel.org>
