From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/2] ceph: use kmem_cache_zalloc
Date: Tue, 22 Mar 2016 17:56:06 +0100
Message-ID: <CAOi1vP-5yJVb9gdeg1emjZ-KPAeC2vNdyAO0ks5tiKGoWsmCZA@mail.gmail.com>
References: <7073df70fbbebb7c1f658b8d2d616ef84a86ff92.1457853860.git.geliangtang@163.com>
	<49f3c78fbd6b746048e16a7bc5aa2c4cb5722f8c.1457853860.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35032 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbcCVQ4I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 12:56:08 -0400
In-Reply-To: <49f3c78fbd6b746048e16a7bc5aa2c4cb5722f8c.1457853860.git.geliangtang@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Geliang Tang <geliangtang@163.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Mar 13, 2016 at 8:26 AM, Geliang Tang <geliangtang@163.com> wrote:
> Use kmem_cache_zalloc() instead of kmem_cache_alloc() with flag GFP_ZERO.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  fs/ceph/dir.c  | 2 +-
>  fs/ceph/file.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index fd11fb2..ba01851 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -38,7 +38,7 @@ int ceph_init_dentry(struct dentry *dentry)
>         if (dentry->d_fsdata)
>                 return 0;
>
> -       di = kmem_cache_alloc(ceph_dentry_cachep, GFP_KERNEL | __GFP_ZERO);
> +       di = kmem_cache_zalloc(ceph_dentry_cachep, GFP_KERNEL);
>         if (!di)
>                 return -ENOMEM;          /* oh well */
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index eb9028e..bb4950a 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -157,7 +157,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
>         case S_IFDIR:
>                 dout("init_file %p %p 0%o (regular)\n", inode, file,
>                      inode->i_mode);
> -               cf = kmem_cache_alloc(ceph_file_cachep, GFP_KERNEL | __GFP_ZERO);
> +               cf = kmem_cache_zalloc(ceph_file_cachep, GFP_KERNEL);
>                 if (cf == NULL) {
>                         ceph_put_fmode(ceph_inode(inode), fmode); /* clean up */
>                         return -ENOMEM;

Applied.

Thanks,

                Ilya
