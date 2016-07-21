From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC 1/2] ceph: introduce 'ceph.all' virtual xattr
Date: Thu, 21 Jul 2016 15:30:43 +0800
Message-ID: <CAAM7YA=i_WjYDPdHfg0X0wwdOkut-AVYuOm2w423y27z65rLug@mail.gmail.com>
References: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33584 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcGUHao (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 03:30:44 -0400
Received: by mail-vk0-f67.google.com with SMTP id s189so6137658vkh.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 00:30:44 -0700 (PDT)
In-Reply-To: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venky Shankar <vshankar@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Thu, Jul 21, 2016 at 2:49 PM, Venky Shankar <vshankar@redhat.com> wrote:
> As of now listing extended attributes result in ceph dump all of
> it's internal xattrs thereby confusing tools such as rsync and the
> likes. This functionality would be removed in the subsequent patch,
> but there needs to be a way to examine ceph's internal xattr.
>
> Remembering all internal xattrs is cumbersome and error prone, so,
> we provide a virtual xattr to fetch a list of ceph's internal xattr,
> obviously excluding itself.
>
> Signed-off-by: Venky Shankar <vshankar@redhat.com>
> ---
>  fs/ceph/xattr.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 4870b29..d0f59cb 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -204,7 +204,45 @@ static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
>                         (long)ci->i_rctime.tv_nsec);
>  }
>
> +static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode);
> +static size_t ceph_vxattrs_name_size(struct ceph_vxattr *vxattrs);
>
> +/* list all ceph internal xattrs */
> +static size_t ceph_vxattrcb_list_all(struct ceph_inode_info *ci, char *val,
> +                                     size_t size)
> +{
> +        struct inode *inode = &ci->vfs_inode;
> +        struct ceph_vxattr *vxattr;
> +        struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
> +        u32 len, namelen;
> +        int err = 0;
> +
> +        if (!vxattrs)
> +                goto out;
> +
> +        namelen = ceph_vxattrs_name_size(vxattrs);
> +
> +        err = -ERANGE;
> +        if (size && (namelen > size))
> +                goto out;
> +        err = namelen;
> +        if (size == 0)
> +                goto out;
> +
> +        /* fill up buffer with virtual xattrs */
> +        for (err = 0, vxattr = vxattrs; vxattr->name; vxattr++) {
> +                if (!vxattr->hidden && !(vxattr->exists_cb
> +                                         && !vxattr->exists_cb(ci))) {
> +                        len = snprintf(val + err, size - err, "%s", vxattr->name);
> +                        err += len + 1;
> +                }
> +        }
> +
> + out:
> +        return err;
> +}
> +
> +#define CEPH_XATTR_LIST_INTERNAL  XATTR_CEPH_PREFIX"all"

I prefer name ceph.list

>  #define CEPH_XATTR_NAME(_type, _name)  XATTR_CEPH_PREFIX #_type "." #_name
>  #define CEPH_XATTR_NAME2(_type, _name, _name2) \
>         XATTR_CEPH_PREFIX #_type "." #_name "." #_name2
> @@ -237,6 +275,14 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
>                 .hidden = true,
>                 .exists_cb = ceph_vxattrcb_layout_exists,
>         },
> +        {
> +                .name = CEPH_XATTR_LIST_INTERNAL,
> +                .name_size = sizeof(CEPH_XATTR_LIST_INTERNAL),
> +                .getxattr_cb = ceph_vxattrcb_list_all,
> +                .readonly = true,
> +                .hidden = true,
> +                .exists_cb = NULL,
> +        },
>         XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),
>         XATTR_LAYOUT_FIELD(dir, layout, stripe_count),
>         XATTR_LAYOUT_FIELD(dir, layout, object_size),
> @@ -264,6 +310,14 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
>                 .hidden = true,
>                 .exists_cb = ceph_vxattrcb_layout_exists,
>         },
> +        {
> +                .name = CEPH_XATTR_LIST_INTERNAL,
> +                .name_size = sizeof(CEPH_XATTR_LIST_INTERNAL),
> +                .getxattr_cb = ceph_vxattrcb_list_all,
> +                .readonly = true,
> +                .hidden = true,
> +                .exists_cb = NULL,
> +        },
>         XATTR_LAYOUT_FIELD(file, layout, stripe_unit),
>         XATTR_LAYOUT_FIELD(file, layout, stripe_count),
>         XATTR_LAYOUT_FIELD(file, layout, object_size),


Need to change the 'hidden' attribute of all other vxattrs to false.

Regards
Yan, Zheng


> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
