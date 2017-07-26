From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 1/2] ceph: use errseq_t for writeback error reporting
Date: Wed, 26 Jul 2017 21:09:08 +0800
Message-ID: <CAAM7YAnPvdHGWAD-ztT3__pN4VUJZOr4f-xGhqgvEEEEyRDytw@mail.gmail.com>
References: <20170725145042.26219-1-jlayton@kernel.org> <20170725145042.26219-2-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725145042.26219-2-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 25, 2017 at 10:50 PM, Jeff Layton <jlayton@kernel.org> wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> Ensure that when writeback errors are marked that we report those to all
> file descriptions that were open at the time of the error.
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 7007ae2a5ad2..13f6edf24acd 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2110,7 +2110,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>
>         dout("fsync %p%s\n", inode, datasync ? " datasync" : "");
>
> -       ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
> +       ret = file_write_and_wait_range(file, start, end);
>         if (ret < 0)
>                 goto out;
>
> --
> 2.13.3
>

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
