From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: format 2TB rbd device is too slow
Date: Wed, 26 Aug 2015 23:22:50 +0800
Message-ID: <CACJqLyY0FrJDbi4VDzBa3aUBGu30A9soxbRbiiNpAL_Mttna+w@mail.gmail.com>
References: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35098 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbHZPWv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 11:22:51 -0400
Received: by ykbi184 with SMTP id i184so190650827ykb.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2015 08:22:51 -0700 (PDT)
In-Reply-To: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 26, 2015 at 11:16 PM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,all
> we create a 2TB rbd image, after map it to local,
> then we format it to xfs with 'mkfs.xfs /dev/rbd0', it spent 318
> seconds to finish, but  local physical disk with the same size just
> need 6 seconds.
>

I think librbd have two PR related to this.

> After debug, we found there are two steps in rbd module during formating:
> a) send  233093 DELETE requests to osds(number_of_requests = 2TB / 4MB),
>    this step spent almost 92 seconds.

I guess this(https://github.com/ceph/ceph/pull/4221/files) may help

> b) send 4238 messages like this: [set-alloc-hint object_size 4194304
> write_size 4194304,write 0~512] to osds, that spent 227 seconds.

I think kernel rbd also need to use
https://github.com/ceph/ceph/pull/4983/files

>
> is there any optimations can we do?
> --
> thanks
> huangjun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
