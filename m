From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V3] fs/ceph:fix double unlock in handle_cap_export()
Date: Thu, 30 Apr 2020 08:08:11 -0400
Message-ID: <c6e346d75a29d05057bdabd0007b71b55b7b3bb3.camel@kernel.org>
References: <1588227169-83237-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588227169-83237-1-git-send-email-wubo40@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wu Bo <wubo40@huawei.com>, ukernel@gmail.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com, linfeilong@huawei.com
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-04-30 at 14:12 +0800, Wu Bo wrote:
> If the ceph_mdsc_open_export_target_session() return fails,
> we should add mutex_lock(&session->s_mutex) on IS_ERR(tsession) block 
> to avoid twice unlocking. because the session->s_mutex will be unlock
> at the out_unlock lable.
> 
> --
> v2 -> v3:
>   - Rewrite solution, adding a mutex_lock(&session->s_mutex) 
>     to the IS_ERR(tsession) block.
>   - Modify the comment more clearly.
> v1 -> v2:
>   - add spin_lock(&ci->i_ceph_lock) before goto out_unlock lable
> 

For future reference, notes like this should go a little lower...

>      
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  fs/ceph/caps.c | 1 +
>  1 file changed, 1 insertion(+)
> 

If you put the patch version notes here, they'll be stripped out when we
go to merge the patch with git-am.

> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 185db76..d27d778 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3746,6 +3746,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>  		WARN_ON(1);
>  		tsession = NULL;
>  		target = -1;
> +		mutex_lock(&session->s_mutex);
>  	}
>  	goto retry;
>  

Looks good. Merged, but I did clean up the verbiage in the changelog a
bit.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
