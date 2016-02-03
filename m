From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by ktime_get_real_ts()
Date: Wed, 3 Feb 2016 22:34:00 +0800
Message-ID: <CAAM7YAm6enhGMJd+BMDAuAzXCMxVwb24Ch951A3_ygGUhXivxQ@mail.gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
	<1454479670-8204-10-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454479670-8204-10-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Feb 3, 2016 at 2:07 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> This is in preparation for the series that transitions
> filesystem timestamps to use 64 bit time and hence make
> them y2038 safe.
>
> CURRENT_TIME macro will be deleted before merging the
> aforementioned series.
>
> Filesystems will use current_fs_time() instead of
> CURRENT_TIME.
> Use ktime_get_real_ts() here as this is not filesystem time.
> ktime_get_real_ts() returns the timestamp in ns which can
> be used to calculate MDS request timestamp.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: "Yan, Zheng" <zyan@redhat.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> ---
>  fs/ceph/mds_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index e7b130a..348b22e 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1721,7 +1721,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>         init_completion(&req->r_safe_completion);
>         INIT_LIST_HEAD(&req->r_unsafe_item);
>
> -       req->r_stamp = CURRENT_TIME;
> +       ktime_get_real_ts(&req->r_stamp);

I think we should use current_fs_time() here. I have squash the change
into another patch

>
>         req->r_op = op;
>         req->r_direct_mode = mode;
> --
> 1.9.1
>
