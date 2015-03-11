From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: match wait_for_completion_timeout return type
Date: Wed, 11 Mar 2015 18:17:18 +0800
Message-ID: <CAAM7YAkBFn06EziJcwf-Fg4K7PNK1KdVdE5p_4r4ToBfvtwBug@mail.gmail.com>
References: <1426000695-348-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35318 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbCKKRU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Mar 2015 06:17:20 -0400
In-Reply-To: <1426000695-348-1-git-send-email-hofrat@osadl.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 11:18 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> This was only compile tested for x86_64_defconfig + CONFIG_CEPH_FS=m
>
> Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)
>
>  fs/ceph/dir.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 83e9976..4bee6b7 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1218,6 +1218,7 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
>         struct ceph_mds_request *req;
>         u64 last_tid;
>         int ret = 0;
> +       unsigned long time_left;
>
>         dout("dir_fsync %p\n", inode);
>         ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
> @@ -1240,11 +1241,11 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
>                 dout("dir_fsync %p wait on tid %llu (until %llu)\n",
>                      inode, req->r_tid, last_tid);
>                 if (req->r_timeout) {
> -                       ret = wait_for_completion_timeout(
> +                       time_left = wait_for_completion_timeout(
>                                 &req->r_safe_completion, req->r_timeout);
> -                       if (ret > 0)
> +                       if (time_left > 0)
>                                 ret = 0;
> -                       else if (ret == 0)
> +                       else if (!time_left)
>                                 ret = -EIO;  /* timed out */
>                 } else {
>                         wait_for_completion(&req->r_safe_completion);

There are lots of similar codes in kernel. I don't think this code
causes problem in reality

> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
