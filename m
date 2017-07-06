From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 17:46:04 +0200
Message-ID: <e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
 <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
 <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
 <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo302.mail-out.ovh.net ([137.74.110.75]:33272 "EHLO
        2.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGFPqH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 11:46:07 -0400
In-Reply-To: <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 17-07-06 04:40 PM, Jason Dillaman wrote:
> On Thu, Jul 6, 2017 at 10:22 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
>> So I really see two problems here: lack of API docs and
>> backwards-incompatible change in API behavior.
> 
> Docs are always in need of update, so any pull requests would be
> greatly appreciated.
> 
> However, I disagree that the behavior has substantively changed -- it
> was always possible for pre-Luminous to (sometimes) copy the buffer
> before the "rbd_aio_write" method completed.

But that copy was buried somewhere deep in the librbd internals and - 
looking at Jewel version - most would assume that it's not really copied and 
user is responsible for keeping buffer intact until write is complete. API 
user doesn't really care about what's going on internally and is beyond 
their control.

> With Luminous, this
> behavior is more consistent -- but in a future release memory may be
> zero-copied. If your application can properly conform to the
> (unwritten) contract that the buffers should remain unchanged, there
> would be no need for the application to pre-copy the buffers.

So far I am forced to do a copy anyway (see below). The question is whether 
it's me doing it, or librbd. It doesn't make sense to have it both do the 
same -- especially if it's going to handle tens of terabytes of data, which 
could mean for 10TB of data at least 83 886 080 memory allocations, releases 
and copies plus 2 684 354 560 page faults (assuming 4KB pages) -- and these 
are the best case scenario numbers assuming 128KB I/O size. What I 
understand that you expect from me, is to have at least number of memory 
copies doubled and push not "just" 20TB over the memory bus (reading 10TB 
from one buffer and writing these 10TB to another), but 40.
In other words, if I'd write my code considering how Jewel librbd works, 
there would be no real issue, apart from the fact that suddenly my program 
would consume more memory and would burn more CPU cycles once librbd is 
upgraded to Luminous which, considering the amount of data, would be 
noticeable change.

> If the libfuse implementation requires that the memory is not-in-use
> by the time you return control to it (i.e. it's a synchronous API and
> you are using async methods), you will always need to copy it.
Yes, libfuse expects that once I leave entrypoint, it is free to do anything 
it wishes with previously provided buffers -- and that's what it actually does.

 > The C++
 > API allows you to control the copying since you need to pass
 > "bufferlist"s to the API methods and since they utilize a reference
 > counter, there is no internal copying within librbd / librados.

How about a hybrid solution? Keep the old rbd_aio_write contract (don't copy 
the buffer with the assumption that it won't change) and instead of 
constructing bufferlist containing bufferptr to copied data, construct a 
bufferlist containing bufferptr made with create_static(user_buffer)?


-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
