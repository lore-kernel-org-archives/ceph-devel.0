From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: fix sync read eof check deadlock
Date: Tue, 24 Sep 2013 09:32:12 +0800
Message-ID: <CAAM7YA=bg=T0s3kagEquXfSdnxWT2-4Yv6863dhVhuTW0MNQjg@mail.gmail.com>
References: <201309230939212660680@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:61176 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3IXBcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 21:32:14 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so3377324lbh.9
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 18:32:12 -0700 (PDT)
In-Reply-To: <201309230939212660680@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 9:39 AM, majianpeng <majianpeng@gmail.com> wrote:
> As Yan,Zheng said, commit 0913444208db intruoduce a bug:"getattr need to
> "read lock" inode's filelock. But the lock can be in unstable state.
> the getattr request waits for lock's state to become stable, the lock
> waits for client to release Fr cap."
>
> Commit 6a026589ba333185c466c90 resolved the same bug also.
> Before doing getattr, it must put the caps which already hold avoid
> deadlock.
>
> Reported-by: Yan, Zheng <zheng.z.yan@intel.com>
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/file.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 7da35c7..bc00ace 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -839,7 +839,15 @@ again:
>                 ret = ceph_sync_read(iocb, &i, &checkeof);
>
>                 if (checkeof && ret >= 0) {
> -                       int statret = ceph_do_getattr(inode,
> +                       int statret;
> +                       /*
> +                        *Before getattr,it should put caps avoid
> +                        *deadlock.
> +                        */
> +                       ceph_put_cap_refs(ci, got);
> +                       got = 0;
> +
> +                       statret = ceph_do_getattr(inode,
>                                                       CEPH_STAT_CAP_SIZE);
>
>                         /* hit EOF or hole? */
> @@ -851,16 +859,23 @@ again:
>
>                                 read += ret;
>                                 checkeof = 0;
> -                               goto again;
> +                               ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD,
> +                                                       want, &got, -1);
> +                               if (ret < 0)
> +                                       ret = 0;
> +                               else
> +                                       goto again;

I think we should try getting Frc caps here, because mds may issue Fc
cap to the client while requesting the size.

Your previous patch moved the getattr code to here. please revert the
code to its original shape. I think it does the right thing.


Regards
Yan, Zheng


>                         }
>                 }
>
>         } else
>                 ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
>
> -       dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
> -            inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
> -       ceph_put_cap_refs(ci, got);
> +       if (got) {
> +               dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
> +                    inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
> +               ceph_put_cap_refs(ci, got);
> +       }




>
>         if (ret >= 0)
>                 ret += read;
> --
> 1.8.4-rc0
