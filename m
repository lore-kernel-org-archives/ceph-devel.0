From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH V3] fs/ceph:fix double unlock in handle_cap_export()
Date: Thu, 30 Apr 2020 15:55:49 +0800
Message-ID: <CAAM7YA=BDutG7sOxHDYDcg141vsTRqQCr5pXOxqmOo9JdXjwsw@mail.gmail.com>
References: <1588227169-83237-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588227169-83237-1-git-send-email-wubo40@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wu Bo <wubo40@huawei.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, liuzhiqiang26@huawei.com, linfeilong@huawei.com
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 30, 2020 at 2:13 PM Wu Bo <wubo40@huawei.com> wrote:
>
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
>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  fs/ceph/caps.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 185db76..d27d778 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3746,6 +3746,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>                 WARN_ON(1);
>                 tsession = NULL;
>                 target = -1;
> +               mutex_lock(&session->s_mutex);
>         }
>         goto retry;
>
> --
> 1.8.3.1
>

 Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
