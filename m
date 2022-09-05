Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE59ECAAD3
	for <ceph-devel@archiver.kernel.org>; Mon,  5 Sep 2022 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiIELhO (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIELhN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Sep 2022 07:37:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C55C34D;
        Mon,  5 Sep 2022 04:37:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so10943314edd.13;
        Mon, 05 Sep 2022 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6yE/u9qfu0XEjAgeN3XgYZq4VzPJwMp6A+Ku/AIYFYc=;
        b=WGdE/mMel/PGiISQlELlCCIhWBf6GNl3zz8Sf46Lkl0Deraa08pjR1YOTrC9SvLunX
         zTs8EVjtG8Dx9w+KE1V0T/DvLuTFFkt8iNHLCo04WxWNncMwl40kWZC70tp9Z1uGH2xw
         nvcCF/ABxbyetnbV4eoDA6kCJW6Uqk9uA4loxMTbAbBJK77Jm+3sJ84Stvxk+BbMc1zO
         rmHWh2c5OOi0WRH6KslyWB53KG6nJLwVWh9QUXaqjRSHzO4pL2GHYOU+f5up07fncM4E
         EGg4Gy4t2apbZKXomswnzWYF0b5IZ++VDxQ44ZkgQLafC02xJ1MvLxHp5PCc3OFHbWXW
         bkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6yE/u9qfu0XEjAgeN3XgYZq4VzPJwMp6A+Ku/AIYFYc=;
        b=hs5KP1o/FGKSC8a5F+rl/9fTjCSe+Vknmy/IDoUAUHCin8TBh23v2C0uV3N5ydwJVn
         T7pCH+56KKK87fwkLK0r5Mab3VK8sdytae/YgtVxy/XnoptuTOn3J1dWX3V1adZ4LvUY
         QlYGTfoIieTc+/j1BJQJA5R4xvjh2dGvuoqkNcaaPD7woMhzK25c5WohO1NQUPYcXUXD
         xyPzCJyfDzpbnEH1ae2+otoFtJxbXToCAyKXOyxDkKNTMjMQ+XEP2oKo6wcQRtoefp6p
         2gxK9enSP7IcTlMQTxicjVGdh8Q5DerRnHpkk0EREU31prGHyx1wSbfyc8mKt9kTXGY8
         gh+A==
X-Gm-Message-State: ACgBeo01sRuWLSmNv2M2/lQooKeQ7hCMlgBF570AF5KB0IM3kticauEE
        Uwj1+VIBUSrYR20M6Vhy5YDsECu9u7/bMAKoYp8=
X-Google-Smtp-Source: AA6agR4AKzHEe7F4JA3ksdfS9O1tMcT9KK59Hn6iqpDKJL2FsOYdDBtpum23Sx8xalYNdPuZU49pOHkpKS4np91Q8Rs=
X-Received: by 2002:aa7:d759:0:b0:447:b08b:6d00 with SMTP id
 a25-20020aa7d759000000b00447b08b6d00mr42192045eds.413.1662377830599; Mon, 05
 Sep 2022 04:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <1662359735-18320-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1662359735-18320-1-git-send-email-yangtiezhu@loongson.cn>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 5 Sep 2022 13:36:57 +0200
Message-ID: <CAOi1vP-F1wgwY-j9ov6s+Rbc21budTGqh_39x_E+8-wQ7AZ8zw@mail.gmail.com>
Subject: Re: [PATCH] ceph, docs: Remove Sage's git tree
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, ceph-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, Sep 5, 2022 at 8:35 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Sage's git tree has not been pushed to in years, and it was removed in
> commit 3a5ccecd9af7 ("MAINTAINERS: remove myself as ceph co-maintainer"),
> so it is better to remove it in the documentation too.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/filesystems/ceph.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
> index 4942e01..76ce938 100644
> --- a/Documentation/filesystems/ceph.rst
> +++ b/Documentation/filesystems/ceph.rst
> @@ -203,7 +203,6 @@ For more information on Ceph, see the home page at
>
>  The Linux kernel client source tree is available at
>         - https://github.com/ceph/ceph-client.git
> -       - git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
>
>  and the source for the full system is at
>         https://github.com/ceph/ceph.git
> --
> 2.1.0
>

Applied.

Thanks,

                Ilya
