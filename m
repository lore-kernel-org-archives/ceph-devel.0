From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: Using file->f_flags rather than flags check O_CREAT.
Date: Thu, 13 Aug 2015 17:59:47 +0800
Message-ID: <CAAM7YA=FTWLfm0j=M-tw8hKTtL=ifzAdgJH3Ojf2v_vJRJskqw@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C1D19E799@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35813 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbbHMJ7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Aug 2015 05:59:48 -0400
Received: by lbcbn3 with SMTP id bn3so23962287lbc.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2015 02:59:47 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C1D19E799@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "zyan@redhat.com" <zyan@redhat.com>

On Thu, Aug 13, 2015 at 5:01 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> Because flags removed the O_CREAT, so we should use file->f_flags.
>
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> ---
>  fs/ceph/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8b79d87..e1347cf 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -210,7 +210,7 @@ int ceph_open(struct inode *inode, struct file *file)
>         ihold(inode);
>
>         req->r_num_caps = 1;
> -       if (flags & O_CREAT)
> +       if (file->f_flags & O_CREAT)
>                 parent_inode = ceph_get_dentry_parent_inode(file->f_path.dentry);
>         err = ceph_mdsc_do_request(mdsc, parent_inode, req);
>         iput(parent_inode);

In this case, we do not need parent_inode because file already exists.
I'd like to remove the code that finds parent inode.


Regards
Yan, Zheng

> --
> 2.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
