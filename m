From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: remove unused and redundant variable dropping
Date: Wed, 18 Oct 2017 14:50:20 +0200
Message-ID: <CAOi1vP_vZNPs9cT1WPHHrLLtB0MDj9FdLxHHZDocZTAhs0WMHw@mail.gmail.com>
References: <20171018113425.28658-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018113425.28658-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 18, 2017 at 1:34 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable dropping is set but never read and hence is redundant
> and can be removed. Cleans up clang warning:
>
> fs/ceph/caps.c:1170:2: warning: Value stored to 'dropping' is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ceph/caps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 157fe59fbabe..14df41e3751c 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1159,7 +1159,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
>         struct ceph_inode_info *ci = cap->ci;
>         struct inode *inode = &ci->vfs_inode;
>         struct cap_msg_args arg;
> -       int held, revoking, dropping;
> +       int held, revoking;
>         int wake = 0;
>         int delayed = 0;
>         int ret;
> @@ -1167,7 +1167,6 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
>         held = cap->issued | cap->implemented;
>         revoking = cap->implemented & ~cap->issued;
>         retain &= ~revoking;
> -       dropping = cap->issued & ~retain;
>
>         dout("__send_cap %p cap %p session %p %s -> %s (revoking %s)\n",
>              inode, cap, cap->session,

Applied.

Thanks,

                Ilya
