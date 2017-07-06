From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 16:22:52 +0200
Message-ID: <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
 <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo302.mail-out.ovh.net ([137.74.110.75]:35635 "EHLO
        2.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbdGFOW4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 10:22:56 -0400
In-Reply-To: <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 17-07-06 03:43 PM, Jason Dillaman wrote:
>> I've learned the hard way that pre-luminous, even if it copies the buffer,
>> it does so too late. In my specific case, my FUSE module does enter the
>> write call and issues rbd_aio_write there, then exits the write - expecting
>> the buffer provided by FUSE to be copied by librbd (as it happens now in
>> Luminous). I didn't expect that it's a new behavior and once my code was
>> deployed to use Jewel librbd, it started to consistently corrupt data during
>> write.
> The correct (POSIX-style) program behavior should treat the buffer as
> immutable until the IO operation completes. It is never safe to assume
> the buffer can be re-used while the IO is in-flight. You should not
> add any logic to assume the buffer is safely copied prior to the
> completion of the IO.

Indeed, most systems - not only POSIX ones - supporting asynchronous writes 
expect that buffer remain unchanged until the write is done. I wasn't sure 
how rbd_aio_write operates and consulted the source, as there's no docs for 
the api itself. That intermediate copy in librbd deceived me -- because if 
librbd copies the data, why should I do the same before calling 
rbd_aio_write? To stress-test memory bus? So I really see two problems here: 
lack of API docs and backwards-incompatible change in API behavior.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
