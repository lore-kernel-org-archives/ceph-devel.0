From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH -next] libceph: using kfree_rcu() to simplify the code
Date: Sat, 30 Jul 2016 16:58:23 +0200
Message-ID: <CAOi1vP8Lki_ZNOu4NKkdQhopO_NrM0Z4RrZ1=srRdoApNChJwg@mail.gmail.com>
References: <1469839106-3692-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35277 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbcG3O7K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2016 10:59:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so19641614wmg.2
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2016 07:58:24 -0700 (PDT)
In-Reply-To: <1469839106-3692-1-git-send-email-weiyj.lk@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jul 30, 2016 at 2:38 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> The callback function of call_rcu() just calls a kfree(), so we
> can use kfree_rcu() instead of call_rcu() + callback function.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  net/ceph/string_table.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied.

Thanks,

                Ilya
