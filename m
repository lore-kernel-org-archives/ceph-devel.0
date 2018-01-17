From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 10:06:53 +0800
Message-ID: <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34120 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeAQCGy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 21:06:54 -0500
Received: by mail-oi0-f49.google.com with SMTP id a70so12065045oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 18:06:54 -0800 (PST)
In-Reply-To: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 16, 2018 at 5:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everyone.
>
> In our online cephfs, we occasionally encounter the error "Client.
> isn't responding to mclientcaps", the client kernel we are using is
> centos's "3.10.0-514".

Is the error persistent and just temporary ?

> Due to the massive deployment of our clients,
> it's difficult to update kernels, which means we can not confirm
> whether the error is the result of a relative older kernel or some
> kind of unresolved bug. Is there any way that we can find all the
> related bugs issued before? If we can, we believe it should be helpful
> for us to locate the cause of the problem
>

> Thanks:-)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
