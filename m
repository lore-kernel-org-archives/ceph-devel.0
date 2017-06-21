From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGW: Implement S3 storage class feature
Date: Wed, 21 Jun 2017 09:37:59 -0700
Message-ID: <CADRKj5Sxy3e94aaMs-8+Am=5Pxgp+a8H=-c1aNN1qE7K=aYwLg@mail.gmail.com>
References: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
 <2035535832.26037779.1498053843582.JavaMail.zimbra@redhat.com>
 <b2db655b-eec8-aeb3-3428-1f12d1c28796@redhat.com> <CADRKj5Q4YZaYoPEABhjnNRNoN-vC1T=49knL9npHQpsSzWUr=w@mail.gmail.com>
 <092f8bc6-8222-b3b0-1b74-7133ae1c320d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33898 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFUQiB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 12:38:01 -0400
Received: by mail-qk0-f176.google.com with SMTP id d14so86974997qkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 09:38:01 -0700 (PDT)
In-Reply-To: <092f8bc6-8222-b3b0-1b74-7133ae1c320d@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Jiaying Ren <mikulely@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 21, 2017 at 8:50 AM, Daniel Gryniewicz <dang@redhat.com> wrote:
> On 06/21/2017 11:14 AM, Yehuda Sadeh-Weinraub wrote:
>>
>> On Wed, Jun 21, 2017 at 7:46 AM, Daniel Gryniewicz <dang@redhat.com>
>> wrote:
>>>
>>> On 06/21/2017 10:04 AM, Matt Benjamin wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> Looks very coherent.
>>>>
>>>> My main question is about...
>>>>
>>>> ----- Original Message -----
>>>>>
>>>>>
>>>>> From: "Jiaying Ren" <mikulely@gmail.com>
>>>>> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
>>>>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>>>>> Sent: Wednesday, June 21, 2017 7:39:24 AM
>>>>> Subject: RGW: Implement S3 storage class feature
>>>>>
>>>>
>>>>>
>>>>> * Todo List
>>>>>
>>>>> + the head of rgw-object should only contains the metadata of
>>>>>   rgw-object,the first chunk of rgw-object data should be stored in
>>>>>   the same pool as the tail of rgw-object
>>>>
>>>>
>>>>
>>>> Is this always desirable?
>>>>
>>>
>>> Well, unless the head pool happens to have the correct storage class,
>>> it's
>>> necessary.  And I'd guess that verification of this is complicated,
>>> although
>>> maybe not.
>>>
>>> Maybe we can use the head pool if it has >= the correct storage class?
>>>
>> My original thinking was that when we reassign an object to a new
>> placement, we only touch its tail which is incompatible with that.
>> However, thinking about it some more I don't see why we need to have
>> this limitation, so it's probably possible to keep the data in the
>> head in one case, and modify the object and have the data in the tail
>> (object's head will need to be rewritten anyway because we modify the
>> manifest).
>> I think that the decision whether we keep data in the head could be a
>> property of the zone. In any case, once an object is created changing
>> this property will only affect newly created objects, and old objects
>> could still be read correctly. Having data in the head is an
>> optimization that supposedly reduces small objects latency, and I
>> still think it's useful in a mixed pools situation. The thought is
>> that the bulk of the data will be at the tail anyway. However, we
>> recently changed the default head size from 512k to 4M, so this might
>> not be true any more. Anyhow, I favour having this as a configurable
>> (which should be simple to add).
>>
>> Yehuda
>>
>
>
> I would be strongly against keeping data in the head when the head is in a
> lower-level storage class.  That means that the entire object is violating
> the constraints of the storage class.
>
> Of course, having the head in a lower storage class (data or not) is
> probably a violation.  Maybe we'd have to require that all heads go in the
> highest storage class.
>

I'd keep it simple. Note that all objects' heads in a bucket need to
reside in the same pool, otherwise we won't be able to locate them
(unless we start searching).

Yehuda
