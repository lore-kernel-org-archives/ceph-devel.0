From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] net: ceph: osd_client: change osd_req_op_data() macro
Date: Thu, 29 Oct 2015 15:34:27 +0100
Message-ID: <CAOi1vP98sCWJQSf=x7E5o6pPEet8kz+hXKe7nRkwRaUFVkEjhg@mail.gmail.com>
References: <1445526367-8258-1-git-send-email-ciorneiioana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f193.google.com ([209.85.212.193]:35636 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbJ2OmX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 10:42:23 -0400
Received: by wicuv6 with SMTP id uv6so8172896wic.2
        for <ceph-devel@vger.kernel.org>; Thu, 29 Oct 2015 07:42:22 -0700 (PDT)
In-Reply-To: <1445526367-8258-1-git-send-email-ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ioana Ciornei <ciorneiioana@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 22, 2015 at 5:06 PM, Ioana Ciornei <ciorneiioana@gmail.com> wrote:
> This patch changes the osd_req_op_data() macro to not evaluate
> parameters more than once in order to follow the kernel coding style.
>
> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> Reviewed-by: Alex Elder <elder@linaro.org>
> ---
>  net/ceph/osd_client.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a362d7e..856e8f8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -120,10 +120,12 @@ static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
>  }
>  #endif /* CONFIG_BLOCK */
>
> -#define osd_req_op_data(oreq, whch, typ, fld)  \
> -       ({                                              \
> -               BUG_ON(whch >= (oreq)->r_num_ops);      \
> -               &(oreq)->r_ops[whch].typ.fld;           \
> +#define osd_req_op_data(oreq, whch, typ, fld)            \
> +       ({                                                \
> +               struct ceph_osd_request *__oreq = (oreq); \
> +               unsigned int __whch = (whch);               \
> +               BUG_ON(__whch >= __oreq->r_num_ops);      \
> +               &__oreq->r_ops[__whch].typ.fld;           \
>         })
>
>  static struct ceph_osd_data *

For some reason this ended up in Spam - you should CC subsystem
maintainer(s) on any patch, as noted in Documentation/SubmittingPatches.

Applied with minor changes, see
https://github.com/ceph/ceph-client/commit/51dcb83f3d1143819fe0791c112e1b1f830e457d.

Thanks,

                Ilya
