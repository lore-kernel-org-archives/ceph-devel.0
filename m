From: Ning Yao <zay11022@gmail.com>
Subject: Re: Disable fiemap lead to Data In-balance between OSD
Date: Fri, 14 Oct 2016 01:06:33 +0800
Message-ID: <CALZt5jwrLSEvjkinn_GihWhoh3RSsNgPdJYbLwf=cAP9cz5ayw@mail.gmail.com>
References: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com>
 <CACJqLyZpT=dF4LeBOpNpuCAvUsasFN-63r8BGMT5XDvTS7K4Mg@mail.gmail.com>
 <CACJqLyZnZiJkQmRYRPk23qa4KO+FHeeNFpsq9cD9fYm67aEwfw@mail.gmail.com>
 <CALZt5jwaVhpjdw22avC4kNwQ44VFtAQxCuhCqSYsmRK4SMF8Ow@mail.gmail.com>
 <57EDDA9B.5030807@easystack.cn> <CACJqLyY5i5JKjgEyM-6kbZq9U1haO=U6KCThQe31N1pO126=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35407 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754840AbcJMRcv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 13:32:51 -0400
Received: by mail-io0-f173.google.com with SMTP id i202so93028874ioi.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 10:32:51 -0700 (PDT)
In-Reply-To: <CACJqLyY5i5JKjgEyM-6kbZq9U1haO=U6KCThQe31N1pO126=Yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, "sjust@redhat.com" <sjust@redhat.com>
Cc: Jeff Liu <jeff.liu@easystack.cn>, ceph-devel <ceph-devel@vger.kernel.org>, "xfs@oss.sgi.com" <xfs@oss.sgi.com>

Thanks to Haomai's suggested solutions. What about this:
https://github.com/mslovy/ceph/commit/539b7998fea16f8af3f6cbbbd243f6996f292=
acc
https://github.com/mslovy/ceph/commit/33240080f3324a70a288c79a77846688c1f29=
db5

As Haomai described, fiemap is default disabled in previous version
and may not use in newest version.
So is it really needed or should we backport the this fix?  any suggestions=
?

Ping Sam.

Regards
Ning Yao


2016-10-12 23:02 GMT+08:00 Haomai Wang <haomai@xsky.com>:
> thanks to Ning Yao. We have found ceph's incorrect usage in xfs fiemap.
>
> Actually this reminds me when I'm looking for unaligned fiemap lookup,
> we also observe this case. Refer to
> http://www.spinics.net/lists/xfs/msg38001.html, if fiemap extents
> larger than 1364, single fiemap call will only return 1364. We need to
> check the last fiemap extent with FIEMAP_EXTENT_LAST flag. If not, we
> need to continue to call fiemap.
>
> Fortunately 1364 extents requires at least 8MB object but rbd's
> default object size is 4MB. So if we don't change object size, nothing
> happen. But I remember openstack glance's default object size is 64MB.
> So it maybe problem for that case. Since I often advertise rbd users
> to turn fiemap on, I hope no one don't hit this bug....
>
> And one way is fix fiemap usage in GenericFilesystemBackend, another
> is totally abandon fiemap in hammer. Or we don't need to do anything
> since fiemap is disable default?
>
> Anyway, thanks Ning Yao again!
>
>
> On Fri, Sep 30, 2016 at 11:23 AM, Jeff Liu <jeff.liu@easystack.cn> wrote:
>> Could you please show your test cases about the fiemap issue against XFS=
?
>> I'd like to dig into it if that is still existing in upstream code base.
>>
>> On 2016=E5=B9=B409=E6=9C=8829=E6=97=A5 21:49, Ning Yao wrote:
>>
>> XFS has #fiemap extent intervals limitted in kernel=EF=BC=8C so if we do=
 not
>> use seek_data, seek_hole. It will lead to getting a wrong fiemap
>> (absence of some extents)  from a large object. It is actually not
>> security before Jewel with enabling filestore_seek_data_hole.
>> Regards
>> Ning Yao
>>
>>
>> 2016-09-29 10:27 GMT+08:00 Haomai Wang <haomai@xsky.com>:
>>
>>> On Thu, Sep 29, 2016 at 10:25 AM, Haomai Wang <haomai@xsky.com> wrote:
>>>> On Thu, Sep 29, 2016 at 12:26 AM, Ning Yao <zay11022@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> As lots of fiemap issues in XFS, fiemap is default disabled now,
>>>>> especially in Hammer, before seek_data, seek_hole is added.
>>>>>
>>>>> But disabling fiemap feature will cause a small sparse object become =
a
>>>>> large full object during PushOps, which may lead to notably data
>>>>> in-balance between OSD, especially on the new added OSD  during data
>>>>> rebalance. With those full objects, some OSDs may simultaneously
>>>>> becomes full.
>>>> Until now, I don't know existing problem with fiemap enabled in
>>>> hammer. Although we find it maybe problem when clone to a existing
>>>> overlap data range, but it won't exists in real case.
>>> Hmm, I can't guarantee this... I only means if you want to have sparse
>>> object, you can enable this. ....
>>>
>>>>> Furthermore, currently, it is impossible to make the full objects
>>>>> sparse again if we enable the fiemap feature in the future.
>>>>>
>>>>> So I think if any solutions to make a full object back to a sparse
>>>>> object again?=E3=80=80One of the idea is to check whether the content=
 in the
>>>>> object contains consecutive zero and punch zeros for those object
>>>>> during deep-scrub,  is that possible and reasonable?
>>>> Obviously it's a complex thing more than we get.
>>>>
>>>>>
>>>>> Regards
>>>>> Ning Yao
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> Cheers,
>>
>> Jeff Liu
>>
