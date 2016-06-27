From: Jeff Liu <jeff.liu@easystack.cn>
Subject: Re: [PATCH] mds/mdstypes.h: drop the unnecessary format string of
 snprintf
Date: Mon, 27 Jun 2016 14:45:58 +0800
Message-ID: <5770CBA6.1050304@easystack.cn>
References: <5770C700.1020202@easystack.cn> <CAAM7YAnCTyccFSVRDTh=mUAZ=5sA6ZSfma4UvE62W9Py2LzK+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:21113 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbcF0GqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 02:46:04 -0400
In-Reply-To: <CAAM7YAnCTyccFSVRDTh=mUAZ=5sA6ZSfma4UvE62W9Py2LzK+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Got it, thanks Zheng.

On 2016=E5=B9=B406=E6=9C=8827=E6=97=A5 14:38, Yan, Zheng wrote:

Please open a pull request at https://github.com/ceph/ceph

Regards
Yan, Zheng

On Mon, Jun 27, 2016 at 2:26 PM, Jeff Liu <jeff.liu@easystack.cn> wrote=
:

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
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Cheers,

Jeff Liu

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
