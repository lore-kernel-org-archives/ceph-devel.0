From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: remove useless ACL check
Date: Thu, 10 Apr 2014 16:16:05 +0800
Message-ID: <CAAM7YAkeUZUM7MtwN+Z5YLd79AvQG_9+qa6yp4JAJBK+J8-GEg@mail.gmail.com>
References: <1397107160-20844-1-git-send-email-zhenzhang.zhang@huawei.com>
	<53462C2D.1030803@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43021 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965506AbaDJIQH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Apr 2014 04:16:07 -0400
Received: by mail-lb0-f181.google.com with SMTP id c11so1996739lbj.40
        for <ceph-devel@vger.kernel.org>; Thu, 10 Apr 2014 01:16:05 -0700 (PDT)
In-Reply-To: <53462C2D.1030803@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhen <zhenzhang.zhang@huawei.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 10, 2014 at 1:29 PM, Zhang Zhen <zhenzhang.zhang@huawei.com> wrote:
> posix_acl_xattr_set() already does the check, and it's the only
> way to feed in an ACL from userspace.
> So the check here is useless, remove it.
>
> Signed-off-by: zhang zhen <zhenzhang.zhang@huawei.com>
> ---
>  fs/ceph/acl.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 21887d6..469f2e8 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -104,12 +104,6 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>         umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
>         struct dentry *dentry;
>
> -       if (acl) {
> -               ret = posix_acl_valid(acl);
> -               if (ret < 0)
> -                       goto out;
> -       }
> -
>         switch (type) {
>         case ACL_TYPE_ACCESS:
>                 name = POSIX_ACL_XATTR_ACCESS;
> --
> 1.8.5.5
>

aded to our testing branch. Thanks.

Yan, Zheng
