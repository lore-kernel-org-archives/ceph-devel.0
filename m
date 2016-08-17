From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Sequential write performance on cloning images
Date: Wed, 17 Aug 2016 12:29:47 -0400
Message-ID: <CA+aFP1BMSuWqRQQnq_9YS5_ad1UfqD4jfGFLTBLyvHg-hyxnaw@mail.gmail.com>
References: <CAOb-7EzSpjYp9dZB4j2UoTgB6H0WZM5SeC2rJ=EYMc9R9a6x3Q@mail.gmail.com>
 <CA+aFP1D+gBbTK=JiJSG=nevZoxxTAq=OgU6GGFQ=uO0smLsCKw@mail.gmail.com>
 <CAOb-7EwU_sE_T5geNU6OHHO_x5XZG3E3ZqfOxOqbDi8Ss6p5fg@mail.gmail.com>
 <CA+aFP1B=KAwu6Er1Zhun+eNUNJ_N_y-9CZipazqNFd==QEJiPA@mail.gmail.com> <CAOb-7EzHd7wcoCcFWx-Cr2PT+BDGchdupQV5hT12SnXV56O=aQ@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34313 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcHQQ3s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2016 12:29:48 -0400
Received: by mail-pf0-f171.google.com with SMTP id p64so39017635pfb.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 09:29:48 -0700 (PDT)
In-Reply-To: <CAOb-7EzHd7wcoCcFWx-Cr2PT+BDGchdupQV5hT12SnXV56O=aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ridge Chen <ridge.chen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

How and when did you compare the IOPS from the clone against the IOPS
from the parent?

On Mon, Aug 15, 2016 at 11:58 PM, Ridge Chen <ridge.chen@gmail.com> wrote:
> Hi
>
> The parent image of "clone-vol1", which is "ori-vol1", is not touched
> during the test.
>
> Regards
> Ridge
>
> 2016-08-16 10:22 GMT+08:00 Jason Dillaman <jdillama@redhat.com>:
>> The "assert object exists" check is just a "stat" op inserted before
>> the write op in the same transaction.  If the object doesn't exist
>> (i.e. a clone copy-on-write is required), the transaction will fail
>> within the OSD and librbd will know it needs to perform a copy-up.
>> However, in your case, this stat op should be essentially a no-op so I
>> would expect zero performance penalty.
>>
>> Do you rebuild your images after every test run? I ask because one big
>> difference is that when you are writing to the parent image, it has a
>> snapshot so the first write to a backing object would require a
>> copy-on-write operation within the OSD.
>>
>>
>>
>> On Mon, Aug 15, 2016 at 10:05 PM, Ridge Chen <ridge.chen@gmail.com> wrote:
>>> Hi
>>>
>>> Thanks for your quick response.
>>>
>>> Yes, the result is similar with object-map disabled. And in all my
>>> tests the librbd cache is disabled.
>>>
>>> Could you explain more about the additional "assert object exists"
>>> operation? what it does in osd side?
>>>
>>> And can we bypass the operation in this very common case based on the
>>> object-map feature?
>>>
>>> Regards,
>>> Ridge
>>>
>>> 2016-08-15 20:16 GMT+08:00 Jason Dillaman <jdillama@redhat.com>:
>>>> On Sun, Aug 14, 2016 at 10:41 PM, Ridge Chen <ridge.chen@gmail.com> wrote:
>>>>> I have tested on hammer and jewel, the results are similar. Is it expected?
>>>>
>>>> In this case, there actually would not be an extra copy-up since you
>>>> already performed the necessary copy-ups during the "dd" against
>>>> "clone-vol1". The only difference, on the librbd side, is that the
>>>> write operation would have an additional "assert object exists"
>>>> operation before the write operation.
>>>>
>>>> Do you see similar differences with the librbd cache disabled and the
>>>> object map disabled?
>>>>
>>>>
>>>>
>>>> --
>>>> Jason
>>
>>
>>
>> --
>> Jason



-- 
Jason
