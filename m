From: Ning Yao <zay11022@gmail.com>
Subject: Re: Disable fiemap lead to Data In-balance between OSD
Date: Thu, 29 Sep 2016 21:49:00 +0800
Message-ID: <CALZt5jwaVhpjdw22avC4kNwQ44VFtAQxCuhCqSYsmRK4SMF8Ow@mail.gmail.com>
References: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com>
 <CACJqLyZpT=dF4LeBOpNpuCAvUsasFN-63r8BGMT5XDvTS7K4Mg@mail.gmail.com> <CACJqLyZnZiJkQmRYRPk23qa4KO+FHeeNFpsq9cD9fYm67aEwfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33985 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbcI2NtC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 09:49:02 -0400
Received: by mail-qk0-f176.google.com with SMTP id j129so69591340qkd.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 06:49:01 -0700 (PDT)
In-Reply-To: <CACJqLyZnZiJkQmRYRPk23qa4KO+FHeeNFpsq9cD9fYm67aEwfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

XFS has #fiemap extent intervals limitted in kernel=EF=BC=8C so if we do no=
t
use seek_data, seek_hole. It will lead to getting a wrong fiemap
(absence of some extents)  from a large object. It is actually not
security before Jewel with enabling filestore_seek_data_hole.
Regards
Ning Yao


2016-09-29 10:27 GMT+08:00 Haomai Wang <haomai@xsky.com>:
> On Thu, Sep 29, 2016 at 10:25 AM, Haomai Wang <haomai@xsky.com> wrote:
>> On Thu, Sep 29, 2016 at 12:26 AM, Ning Yao <zay11022@gmail.com> wrote:
>>> Hi,
>>>
>>> As lots of fiemap issues in XFS, fiemap is default disabled now,
>>> especially in Hammer, before seek_data, seek_hole is added.
>>>
>>> But disabling fiemap feature will cause a small sparse object become a
>>> large full object during PushOps, which may lead to notably data
>>> in-balance between OSD, especially on the new added OSD  during data
>>> rebalance. With those full objects, some OSDs may simultaneously
>>> becomes full.
>>
>> Until now, I don't know existing problem with fiemap enabled in
>> hammer. Although we find it maybe problem when clone to a existing
>> overlap data range, but it won't exists in real case.
>
> Hmm, I can't guarantee this... I only means if you want to have sparse
> object, you can enable this. ....
>
>>
>>>
>>> Furthermore, currently, it is impossible to make the full objects
>>> sparse again if we enable the fiemap feature in the future.
>>>
>>> So I think if any solutions to make a full object back to a sparse
>>> object again?=E3=80=80One of the idea is to check whether the content i=
n the
>>> object contains consecutive zero and punch zeros for those object
>>> during deep-scrub,  is that possible and reasonable?
>>
>> Obviously it's a complex thing more than we get.
>>
>>>
>>>
>>>
>>> Regards
>>> Ning Yao
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
