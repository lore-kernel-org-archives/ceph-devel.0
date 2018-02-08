From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Translating raw capacity to real data capacity in statfs
Date: Thu, 8 Feb 2018 13:20:00 +0800
Message-ID: <CAAM7YA=41Zx2PT=_Rc2UY61NSUZUEp_cgP3abLuHFBioPMu-fg@mail.gmail.com>
References: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:40590 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeBHFUB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 00:20:01 -0500
Received: by mail-ot0-f180.google.com with SMTP id s4so3070487oth.7
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 21:20:01 -0800 (PST)
In-Reply-To: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

On Thu, Feb 8, 2018 at 10:47 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Hi Cepher,
>
> Current statfs(2) in ceph kernel client provides raw capacity information of total/used/avail,
> but in the point of view of filesystem I think we actually more willing to see real data capacity instead of raw.
>
> So I have a suggestion to translate raw capacity to real data capacity, it can be simply implemented by
> taking advantage of num.object_copies, the result may be not very accurate but still having reference significance.
>

It's not that simple when there are multiple data pools.

> What do you think and any suggestion?
>
> Thanks,
> Chengguang.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
