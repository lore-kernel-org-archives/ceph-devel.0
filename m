From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] libceph: add a compatibility check interface
Date: Wed, 30 Jan 2013 16:29:46 -0800
Message-ID: <5109BAFA.40006@inktank.com>
References: <510986E4.7050901@inktank.com> <51098740.2000200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:59874 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3AaAaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 19:30:00 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1019849dal.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 16:29:59 -0800 (PST)
In-Reply-To: <51098740.2000200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/30/2013 12:49 PM, Alex Elder wrote:
> An upcoming change implements semantic change that could lead to
> a crash if an old version of the libceph kernel module is used with
> a new version of the rbd kernel module.
>
> In order to preclude that possibility, this adds a compatibilty
> check interface.  If this interface doesn't exist, the modules are
> obviously not compatible.  But if it does exist, this provides a way
> of letting the caller know whether it will operate properly with
> this libceph module.
>
> Perhaps confusingly, it returns false right now.  The semantic
> change mentioned above will make it return true.
>
> This resolves:
>      http://tracker.ceph.com/issues/3800
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/libceph.h |    2 ++
>   net/ceph/ceph_common.c       |   16 ++++++++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 084d3c6..c44275a 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -193,6 +193,8 @@ static inline int calc_pages_for(u64 off, u64 len)
>   }
>
>   /* ceph_common.c */
> +extern bool libceph_compatible(void *data);
> +
>   extern const char *ceph_msg_type_name(int type);
>   extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid
> *fsid);
>   extern struct kmem_cache *ceph_inode_cachep;
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index ee71ea2..a98c03f 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -26,6 +26,22 @@
>   #include "crypto.h"
>
>
> +/*
> + * Module compatibility interface.  For now it doesn't do anything,
> + * but its existence signals a certain level of functionality.
> + *
> + * The data buffer is used to pass information both to and from
> + * libceph.  The return value indicates whether libceph determines
> + * it is compatible with the caller (from another kernel module),
> + * given the provided data.
> + *
> + * The data pointer can be null.
> + */
> +bool libceph_compatible(void *data)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL(libceph_compatible);
>
>   /*
>    * find filename portion of a path (/foo/bar/baz -> baz)
>

