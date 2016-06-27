From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] mds/mdstypes.h: drop the unnecessary format string of snprintf
Date: Mon, 27 Jun 2016 14:38:27 +0800
Message-ID: <CAAM7YAnCTyccFSVRDTh=mUAZ=5sA6ZSfma4UvE62W9Py2LzK+Q@mail.gmail.com>
References: <5770C700.1020202@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34747 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbcF0Gi3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 02:38:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id v6so1761465vkb.1
        for <ceph-devel@vger.kernel.org>; Sun, 26 Jun 2016 23:38:29 -0700 (PDT)
In-Reply-To: <5770C700.1020202@easystack.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Liu <jeff.liu@easystack.cn>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Please open a pull request at https://github.com/ceph/ceph

Regards
Yan, Zheng

On Mon, Jun 27, 2016 at 2:26 PM, Jeff Liu <jeff.liu@easystack.cn> wrote:
> Drop the unnecessary format string of snprintf
>
> Signed-off-by: Jie Liu <jeff.liu@easystack.cn>
> ---
>  src/mds/mdstypes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
> index c69a655..3414ecd 100644
> --- a/src/mds/mdstypes.h
> +++ b/src/mds/mdstypes.h
> @@ -741,7 +741,7 @@ struct dentry_key_t {
>        uint64_t val(snapid);
>        snprintf(b, sizeof(b), "%" PRIx64, val);
>      } else {
> -      snprintf(b, sizeof(b), "%s", "head");
> +      snprintf(b, sizeof(b), "head");
>      }
>      ostringstream oss;
>      oss << name << "_" << b;
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
