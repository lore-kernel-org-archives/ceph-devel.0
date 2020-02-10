From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fix posix acl couldn't be settable
Date: Mon, 10 Feb 2020 22:52:10 +0800
Message-ID: <e2614ef4-7dc1-d9ac-752a-d48b806dd561@redhat.com>
References: <20200210135841.21177-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727810AbgBJOw3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:52:29 -0500
In-Reply-To: <20200210135841.21177-1-xiubli@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, dhowells@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/10 21:58, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> For the old mount API, the module parameters parseing function will
> be called in ceph_mount() and also just after the default posix acl
> flag set, so we can control to enable/disable it via the mount option.
>
> But for the new mount API, it will call the module parameters
> parseing function before ceph_get_tree(), so the posix acl will always
> be enabled.
>
> Fixes: 82995cc6c5ae ("libceph, rbd, ceph: convert to use the new mount API")
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/ceph/super.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 5fef4f59e13e..69fa498391dc 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -341,6 +341,10 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>   	unsigned int mode;
>   	int token, ret;
>   
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	fc->sb_flags |= SB_POSIXACL;
> +#endif
> +

Maybe we should move this to ceph_init_fs_context().

>   	ret = ceph_parse_param(param, pctx->copts, fc);
>   	if (ret != -ENOPARAM)
>   		return ret;
> @@ -1089,10 +1093,6 @@ static int ceph_get_tree(struct fs_context *fc)
>   	if (!fc->source)
>   		return invalf(fc, "ceph: No source");
>   
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -	fc->sb_flags |= SB_POSIXACL;
> -#endif
> -
>   	/* create client (which we may/may not use) */
>   	fsc = create_fs_client(pctx->opts, pctx->copts);
>   	pctx->opts = NULL;
