From: Haomai Wang <haomai@xsky.com>
Subject: Re: Disable fiemap lead to Data In-balance between OSD
Date: Thu, 29 Sep 2016 10:25:50 +0800
Message-ID: <CACJqLyZpT=dF4LeBOpNpuCAvUsasFN-63r8BGMT5XDvTS7K4Mg@mail.gmail.com>
References: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0119.outbound.protection.outlook.com ([104.47.93.119]:10378
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750719AbcI2CkK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 22:40:10 -0400
Received: by mail-vk0-f49.google.com with SMTP id z126so62109101vkd.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2016 19:25:57 -0700 (PDT)
In-Reply-To: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 29, 2016 at 12:26 AM, Ning Yao <zay11022@gmail.com> wrote:
> Hi,
>
> As lots of fiemap issues in XFS, fiemap is default disabled now,
> especially in Hammer, before seek_data, seek_hole is added.
>
> But disabling fiemap feature will cause a small sparse object become a
> large full object during PushOps, which may lead to notably data
> in-balance between OSD, especially on the new added OSD  during data
> rebalance. With those full objects, some OSDs may simultaneously
> becomes full.

Until now, I don't know existing problem with fiemap enabled in
hammer. Although we find it maybe problem when clone to a existing
overlap data range, but it won't exists in real case.

>
> Furthermore, currently, it is impossible to make the full objects
> sparse again if we enable the fiemap feature in the future.
>
> So I think if any solutions to make a full object back to a sparse
> object again?=E3=80=80One of the idea is to check whether the content in =
the
> object contains consecutive zero and punch zeros for those object
> during deep-scrub,  is that possible and reasonable?

Obviously it's a complex thing more than we get.

>
>
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
