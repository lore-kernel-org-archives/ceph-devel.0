From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH -next] libceph: fix non static symbol warning
Date: Sat, 30 Jul 2016 16:57:34 +0200
Message-ID: <CAOi1vP93m0myyaTw7RP7DWA-efx_DRH_H+04urDHohy9rZSfkQ@mail.gmail.com>
References: <1469839051-3525-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34168 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcG3O5g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2016 10:57:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so19652225wma.1
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2016 07:57:36 -0700 (PDT)
In-Reply-To: <1469839051-3525-1-git-send-email-weiyj.lk@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jul 30, 2016 at 2:37 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> Fixes the following sparse warning:
>
> net/ceph/mon_client.c:577:6: warning:
>  symbol 'cancel_generic_request' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  net/ceph/mon_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Thanks,

                Ilya
