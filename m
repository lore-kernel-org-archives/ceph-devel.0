Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F2C43334
	for <ceph-devel@archiver.kernel.org>; Tue, 26 Jul 2022 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiGZH5w (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiGZH5s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2022 03:57:48 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8552C659;
        Tue, 26 Jul 2022 00:57:47 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id y12so4317792uad.10;
        Tue, 26 Jul 2022 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Dg6UJcvd66rBSsY0O4X/XZCDYuJxPThGG/8mH4rxkQ=;
        b=PMM6SQJ7HFwUqcdDCaTU3eg7RdF+Iz2I8gmPHti8FTJGe6d837yQdMo3/B2p3a3on1
         v0l+u5zo4S3WcHtMBzErp5iyPM93jqMe1g/yNzg5b7WLzkfV640aKw/7Y2b8IYVcDhw/
         eQ8VgMF0j4b5hTT6xPvuEDh0RZhBWce36kFn4o0r5+Cabo3Rul+YzY3Gy7xs5waf7BOY
         a/EsdckWK09qr3h1+xvUcGbJPZqmyJQyYrBblhfB4CVtsuLwa7tNokxNoCdmg/ISvJHj
         Mxu7ZhJlAh0o7FcWfWEdeRf86G26fwaFa2EJZo3LbdQheEkMKkyzpE9ZBUYbPUmJnWJX
         0law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Dg6UJcvd66rBSsY0O4X/XZCDYuJxPThGG/8mH4rxkQ=;
        b=7iHxUiqqqOioHzDN2UNqhVZqE+kPfLMhsKKg9ZhQmrHDAwj0ijtI4+9t3N1Y2Y4HFH
         kKPyB3D2Vp1m3YiGb26eHNHCNQIcQ7ZSFY5ZvQMH8n7TrMjWArwRTLsKkf6Ngn10BzBb
         utRYhMCiiAeNT11iK+gW7OpF+Qy3j72kKnA9GoTCWp7b5dksJ9t+9AHMtw8owERRgpfj
         lEFiAneZHVp+qdjN0HLVgJeQzF7gQLMJ8o5qTyzZRkE6w8SlUbnGlBDLnT1NcnOFhtCz
         J62LbhxlzGTIKHVFt+B2pbfOhu343zoboTvueT+padCqQy6gDCrwZiSFYSPSQi6tcsbx
         dJFg==
X-Gm-Message-State: AJIora/RPjOfBBwfpUVITv+d0UmUdJkZK2sC7l5SMEOVE+Yk8yl4Wt13
        /FbfESGSjm6dpCP9D1xGVlHCvvr+mnjHmAs/fNg=
X-Google-Smtp-Source: AGRyM1sGwxjnpoy6Z5a+80AXE90/uTyqypaSTzvEXBAxSMoC7QnHj7QeQ80IUwoLiT/OheA8xLfIAlIN1Lua4eLwyok=
X-Received: by 2002:ab0:661a:0:b0:384:d0d7:7383 with SMTP id
 r26-20020ab0661a000000b00384d0d77383mr448uam.24.1658822266663; Tue, 26 Jul
 2022 00:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220724201131.3381-1-wangborong@cdjrlc.com>
In-Reply-To: <20220724201131.3381-1-wangborong@cdjrlc.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 26 Jul 2022 09:57:18 +0200
Message-ID: <CAOi1vP_bepwLrWwV3pvigF19_QQp75DejcQsDKDwBtV+svUhbQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Eric Dumazet <edumazet@google.com>, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Sun, Jul 24, 2022 at 2:20 PM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `without' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  net/ceph/pagelist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
> index 65e34f78b05d..74622b278d57 100644
> --- a/net/ceph/pagelist.c
> +++ b/net/ceph/pagelist.c
> @@ -96,7 +96,7 @@ int ceph_pagelist_append(struct ceph_pagelist *pl, const void *buf, size_t len)
>  EXPORT_SYMBOL(ceph_pagelist_append);
>
>  /* Allocate enough pages for a pagelist to append the given amount
> - * of data without without allocating.
> + * of data without allocating.
>   * Returns: 0 on success, -ENOMEM on error.
>   */
>  int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space)
> --
> 2.35.1
>

Applied.

Thanks,

                Ilya
