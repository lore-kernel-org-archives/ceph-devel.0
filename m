From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: Check memory allocation result
Date: Mon, 29 Jan 2018 17:42:41 +0100
Message-ID: <CAOi1vP_b_1Um6gwo+Zz+YF8jmBbJY79Gndx8ie0caWrcGwStuA@mail.gmail.com>
References: <1516949683-127606-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35517 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeA2Qmm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 11:42:42 -0500
In-Reply-To: <1516949683-127606-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>

On Fri, Jan 26, 2018 at 7:54 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Should check result of kstrndup() in case of memory allocation failure.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  net/ceph/ceph_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 5c036d2..1e492ef 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -421,6 +421,10 @@ struct ceph_options *
>                         opt->name = kstrndup(argstr[0].from,
>                                               argstr[0].to-argstr[0].from,
>                                               GFP_KERNEL);
> +                       if (!opt->name) {
> +                               err = -ENOMEM;
> +                               goto out;
> +                       }
>                         break;
>                 case Opt_secret:
>                         opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);

Applied.

Thanks,

                Ilya
