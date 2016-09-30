From: Jeff Liu <jeff.liu@easystack.cn>
Subject: Re: Disable fiemap lead to Data In-balance between OSD
Date: Fri, 30 Sep 2016 11:23:07 +0800
Message-ID: <57EDDA9B.5030807@easystack.cn>
References: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com> <CACJqLyZpT=dF4LeBOpNpuCAvUsasFN-63r8BGMT5XDvTS7K4Mg@mail.gmail.com> <CACJqLyZnZiJkQmRYRPk23qa4KO+FHeeNFpsq9cD9fYm67aEwfw@mail.gmail.com> <CALZt5jwaVhpjdw22avC4kNwQ44VFtAQxCuhCqSYsmRK4SMF8Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:2697 "EHLO
        mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbcI3DX0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 23:23:26 -0400
In-Reply-To: <CALZt5jwaVhpjdw22avC4kNwQ44VFtAQxCuhCqSYsmRK4SMF8Ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>, Haomai Wang <haomai@xsky.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "xfs@oss.sgi.com" <xfs@oss.sgi.com>

Could you please show your test cases about the fiemap issue against XFS?
I'd like to dig into it if that is still existing in upstream code base.

On 2016年09月29日 21:49, Ning Yao wrote:

XFS has #fiemap extent intervals limitted in kernel， so if we do not
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
>> Until now, I don't know existing problem with fiemap enabled in
>> hammer. Although we find it maybe problem when clone to a existing
>> overlap data range, but it won't exists in real case.
> Hmm, I can't guarantee this... I only means if you want to have sparse
> object, you can enable this. ....
>
>>> Furthermore, currently, it is impossible to make the full objects
>>> sparse again if we enable the fiemap feature in the future.
>>>
>>> So I think if any solutions to make a full object back to a sparse
>>> object again?　One of the idea is to check whether the content in the
>>> object contains consecutive zero and punch zeros for those object
>>> during deep-scrub,  is that possible and reasonable?
>> Obviously it's a complex thing more than we get.
>>
>>>
>>> Regards
>>> Ning Yao
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Cheers,

Jeff Liu

