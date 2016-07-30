From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH -next] libceph: fix return value check in alloc_msg_with_page_vector()
Date: Sat, 30 Jul 2016 16:57:06 +0200
Message-ID: <CAOi1vP9kgTQ=wAQqCqPCGCoyS_BfrHqvBpmXXuPa-_6tQPG+mA@mail.gmail.com>
References: <1469839077-3607-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34021 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcG3O5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2016 10:57:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so19650898wma.1
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2016 07:57:08 -0700 (PDT)
In-Reply-To: <1469839077-3607-1-git-send-email-weiyj.lk@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jul 30, 2016 at 2:37 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> In case of error, the function ceph_alloc_page_vector() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> Fixes: 1907920324f1 ('libceph: support for sending notifies')
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  net/ceph/osd_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Thanks,

                Ilya
