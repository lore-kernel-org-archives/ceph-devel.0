From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: Check that the new inode size is within limits in ceph_fallocate()
Date: Mon, 8 May 2017 10:11:38 +0800
Message-ID: <CAAM7YA=2KT6wpD-u6mftYPaanz63uWNbwrBoPCAso_QzDrkVpQ@mail.gmail.com>
References: <20170505172844.18374-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505172844.18374-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, May 6, 2017 at 1:28 AM, Luis Henriques <lhenriques@suse.com> wrote:
> Currently the ceph client doesn't respect the rlimit in fallocate.  This
> means that a user can allocate a file with size > RLIMIT_FSIZE.  This
> patch adds the call to inode_newsize_ok() to verify filesystem limits and
> ulimits.  This should make ceph successfully run xfstest generic/228.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 26cc95421cca..bc5809d4d2d4 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1636,8 +1636,12 @@ static long ceph_fallocate(struct file *file, int mode,
>         }
>
>         size = i_size_read(inode);
> -       if (!(mode & FALLOC_FL_KEEP_SIZE))
> +       if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>                 endoff = offset + length;
> +               ret = inode_newsize_ok(inode, endoff);
> +               if (ret)
> +                       goto unlock;
> +       }
>
>         if (fi->fmode & CEPH_FILE_MODE_LAZY)
>                 want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> --

Applied, thanks

Yan, Zheng

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
