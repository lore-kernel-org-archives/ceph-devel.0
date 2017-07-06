From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 09:43:11 -0400
Message-ID: <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com> <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:32926 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdGFNnN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 09:43:13 -0400
Received: by mail-yw0-f171.google.com with SMTP id x125so1197199ywa.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 06:43:12 -0700 (PDT)
In-Reply-To: <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

The correct (POSIX-style) program behavior should treat the buffer as
immutable until the IO operation completes. It is never safe to assume
the buffer can be re-used while the IO is in-flight. You should not
add any logic to assume the buffer is safely copied prior to the
completion of the IO.

On Thu, Jul 6, 2017 at 9:33 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> On 17-07-06 03:03 PM, Jason Dillaman wrote:
>>
>> On Thu, Jul 6, 2017 at 8:26 AM, Piotr Dałek <piotr.dalek@corp.ovh.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> If you're using "rbd_aio_write()" in your code, be aware of the fact that
>>> before Luminous release, this function expects buffer to remain unchanged
>>> until write op ends, and on Luminous and later this function internally
>>> copies the buffer, allocating memory where needed, freeing it once write
>>> is
>>> done.
>
>
>> Pre-Luminous also copies the provided buffer when using the C API --
>> it just copies it at a later point and not immediately. The eventual
>> goal is to eliminate the copy completely, but that requires some
>> additional plumbing work deep down within the librados messenger
>> layer.
>
>
> I've learned the hard way that pre-luminous, even if it copies the buffer,
> it does so too late. In my specific case, my FUSE module does enter the
> write call and issues rbd_aio_write there, then exits the write - expecting
> the buffer provided by FUSE to be copied by librbd (as it happens now in
> Luminous). I didn't expect that it's a new behavior and once my code was
> deployed to use Jewel librbd, it started to consistently corrupt data during
> write.
>
>
> --
> Piotr Dałek
> piotr.dalek@corp.ovh.com
> https://www.ovh.com/us/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
