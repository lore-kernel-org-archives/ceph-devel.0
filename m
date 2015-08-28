From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: format 2TB rbd device is too slow
Date: Fri, 28 Aug 2015 12:16:39 +0300
Message-ID: <CAOi1vP-+ODN=88C8T-Kc-3VC_g=_-3skfHN0CPrSH598LG4_cg@mail.gmail.com>
References: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
	<CACJqLyY0FrJDbi4VDzBa3aUBGu30A9soxbRbiiNpAL_Mttna+w@mail.gmail.com>
	<CAOi1vP__WA0+Q1xfRwcvNfs6_7T3OeA7Wdsw58taZt1arNR+bg@mail.gmail.com>
	<CABAwU-YnEw2mzpF-EwMoWLrTmDdSt+XPQ0dgawigkbH7rGMtuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35804 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbH1JQn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 05:16:43 -0400
Received: by lbcbn3 with SMTP id bn3so26482419lbc.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2015 02:16:39 -0700 (PDT)
In-Reply-To: <CABAwU-YnEw2mzpF-EwMoWLrTmDdSt+XPQ0dgawigkbH7rGMtuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 27, 2015 at 3:43 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,llya
>
> 2015-08-26 23:56 GMT+08:00 Ilya Dryomov <idryomov@gmail.com>:
>> On Wed, Aug 26, 2015 at 6:22 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>> On Wed, Aug 26, 2015 at 11:16 PM, huang jun <hjwsm1989@gmail.com> wrote:
>>>> hi,all
>>>> we create a 2TB rbd image, after map it to local,
>>>> then we format it to xfs with 'mkfs.xfs /dev/rbd0', it spent 318
>>>> seconds to finish, but  local physical disk with the same size just
>>>> need 6 seconds.
>>>>
>>>
>>> I think librbd have two PR related to this.
>>>
>>>> After debug, we found there are two steps in rbd module during formating:
>>>> a) send  233093 DELETE requests to osds(number_of_requests = 2TB / 4MB),
>>>>    this step spent almost 92 seconds.
>>>
>>> I guess this(https://github.com/ceph/ceph/pull/4221/files) may help
>>
>> It's submitting deletes for non-existent objects, not zeroing.  The
>> only thing that will really help here is the addition of rbd object map
>> support to the kernel client.  That could happen in 4.4, but 4.5 is
>> a safer bet.
>>
>>>
>>>> b) send 4238 messages like this: [set-alloc-hint object_size 4194304
>>>> write_size 4194304,write 0~512] to osds, that spent 227 seconds.
>>>
>>> I think kernel rbd also need to use
>>> https://github.com/ceph/ceph/pull/4983/files
>>
>> set-alloc-hint may be a problem, but I think a bigger problem is the
>> size of the write.  Are all those writes 512 bytes long?
>>
> In another test to format 2TB rbd device,
> there are :
> 2 messages,each write 131072 bytes
> 4000 messages, each write 262144 bytes
> 112 messages, each write 4096 bytes
> 194 messages, each write 512 bytes

So the majority of writes is not 512 bytes long.  I don't think
disabling set-alloc-hint (and, as of now at least, you can't disable it
anyway) would drastically change the numbers.  If you are doing mkfs
right after creating and mapping an image for the first time, you can
add -K option to mkfs, which will tell it to not try to discard.  As
for the write phase, I can't suggest anything off hand.

Thanks,

                Ilya
