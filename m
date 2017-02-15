From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH 13/15] rbd: RBD_V{1,2}_DATA_FORMAT macros
Date: Wed, 15 Feb 2017 09:47:24 -0500
Message-ID: <CA+aFP1DPCgERzjKhneL_qdxYO3tRd_Jo_nHJzVjf9L8GEEjYJw@mail.gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com> <1487103124-2974-14-git-send-email-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36275 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdBOOr0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 09:47:26 -0500
Received: by mail-lf0-f43.google.com with SMTP id z134so82091757lff.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 06:47:25 -0800 (PST)
In-Reply-To: <1487103124-2974-14-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

Nit: only since you are correcting the v1 name format, it should also
include 32bits of "extra" randomness (i.e.
rb.<idhi>.<idlo>.<extra>.000000000000). Looks like it's documented
incorrectly in librbd as well.

On Tue, Feb 14, 2017 at 3:12 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> ... and also fix up the comment -- format 1 data objects have always
> been 12 hex digits long.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c       | 6 ++----
>  drivers/block/rbd_types.h | 7 ++++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 47cfd5d89e69..3bc84afe5b50 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1257,18 +1257,16 @@ static void rbd_segment_name_free(const char *name)
>
>  static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
>  {
> +       const char *name_format = rbd_dev->image_format == 1 ?
> +                                     RBD_V1_DATA_FORMAT : RBD_V2_DATA_FORMAT;
>         char *name;
>         u64 segment;
>         int ret;
> -       char *name_format;
>
>         name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
>         if (!name)
>                 return NULL;
>         segment = offset >> rbd_dev->header.obj_order;
> -       name_format = "%s.%012llx";
> -       if (rbd_dev->image_format == 2)
> -               name_format = "%s.%016llx";
>         ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
>                         rbd_dev->header.object_prefix, segment);
>         if (ret < 0 || ret > CEPH_MAX_OID_NAME_LEN) {
> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
> index be9c76d292f5..0a15ca3aa0f1 100644
> --- a/drivers/block/rbd_types.h
> +++ b/drivers/block/rbd_types.h
> @@ -25,8 +25,8 @@
>   */
>
>  #define RBD_HEADER_PREFIX      "rbd_header."
> -#define RBD_DATA_PREFIX        "rbd_data."
>  #define RBD_ID_PREFIX          "rbd_id."
> +#define RBD_V2_DATA_FORMAT     "%s.%016llx"
>
>  #define RBD_LOCK_NAME          "rbd_lock"
>  #define RBD_LOCK_TAG           "internal"
> @@ -42,13 +42,14 @@ enum rbd_notify_op {
>  /*
>   * For format version 1, rbd image 'foo' consists of objects
>   *   foo.rbd           - image metadata
> - *   rb.<idhi>.<idlo>.00000000
> - *   rb.<idhi>.<idlo>.00000001
> + *   rb.<idhi>.<idlo>.000000000000
> + *   rb.<idhi>.<idlo>.000000000001
>   *   ...               - data
>   * There is no notion of a persistent image id in rbd format 1.
>   */
>
>  #define RBD_SUFFIX             ".rbd"
> +#define RBD_V1_DATA_FORMAT     "%s.%012llx"
>
>  #define RBD_DIRECTORY           "rbd_directory"
>  #define RBD_INFO                "rbd_info"
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
