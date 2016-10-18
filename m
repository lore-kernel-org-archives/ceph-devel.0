From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH -next] ceph: fix non static symbol warning
Date: Tue, 18 Oct 2016 12:33:14 +0200
Message-ID: <CAOi1vP9k61eiwDMt833+Dz=RVgFOsa5yySQd0TOLArYHBNJcRQ@mail.gmail.com>
References: <1476717089-10359-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36378 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbcJRKdR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Oct 2016 06:33:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id b75so31566320lfg.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2016 03:33:16 -0700 (PDT)
In-Reply-To: <1476717089-10359-1-git-send-email-weiyj.lk@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 17, 2016 at 5:11 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warning:
>
> fs/ceph/xattr.c:19:28: warning:
>  symbol 'ceph_other_xattr_handler' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  fs/ceph/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 40b7032..febc28f 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -16,7 +16,7 @@
>  static int __remove_xattr(struct ceph_inode_info *ci,
>                           struct ceph_inode_xattr *xattr);
>
> -const struct xattr_handler ceph_other_xattr_handler;
> +static const struct xattr_handler ceph_other_xattr_handler;
>
>  /*
>   * List of handlers for synthetic system.* attributes. Other
> @@ -1086,7 +1086,7 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
>         return __ceph_setxattr(inode, name, value, size, flags);
>  }
>
> -const struct xattr_handler ceph_other_xattr_handler = {
> +static const struct xattr_handler ceph_other_xattr_handler = {
>         .prefix = "",  /* match any name => handlers called with full name */
>         .get = ceph_get_xattr_handler,
>         .set = ceph_set_xattr_handler,

Applied.

Thanks,

                Ilya
