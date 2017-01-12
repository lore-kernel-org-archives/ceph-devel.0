From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] Any librados C API users out there?
Date: Thu, 12 Jan 2017 10:19:00 +0100
Message-ID: <e0e85f8a-5f78-e652-9838-5aae2ef97d14@corp.ovh.com>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
 <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
 <alpine.DEB.2.11.1701111755260.5745@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 3.mo301.mail-out.ovh.net ([137.74.110.66]:37765 "EHLO
        3.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdALJTF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 04:19:05 -0500
In-Reply-To: <alpine.DEB.2.11.1701111755260.5745@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, dillaman@redhat.com
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/11/2017 07:01 PM, Sage Weil wrote:
> On Wed, 11 Jan 2017, Jason Dillaman wrote:
>> On Wed, Jan 11, 2017 at 11:44 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
>>> As the subject says - are here any users/consumers of librados C API? I'm
>>> asking because we're researching if this PR:
>>> https://github.com/ceph/ceph/pull/12216 will be actually beneficial for
>>> larger group of users. This PR adds a bunch of new APIs that perform object
>>> writes without intermediate data copy, which will reduce cpu and memory load
>>> on clients. If you're using librados C API for object writes, feel free to
>>> comment here or in the pull request.
>> +1
>>
>> I'd be happy to tweak the internals of librbd to support pass-through
>> of C buffers all the way to librados. librbd clients like QEMU use the
>> C API and this currently results in several extra copies (in librbd
>> and librados).
>
> +1 from me too.
>
> The caveat is that we have to be very careful with buffers that are
> provided by users.  Currently the userspace messenger code doesn't provide
> a way to manage the provenance of references to the buffer::raw_static
> buffers, which means that even if the write has completed, there may be
> ways for an MOSDOp to still be alive that references that memory.
>
> Either (1) we have to audit the code to be sure that by the time the
> Objecter request completes we know that all messages and their bufferlists
> are cleared (tricky/fragile), or (2) introduce some buffer management
> interface in librados so that the buffer lifecycle is independent of the
> request.  I would prefer (2), but it means the interfaces would be
> something like
>
>  rados_buffer_create(...)
>  copy your data into that buffer
>  rados_write(...) or whatever
>  rados_buffer_release(...)
>
> and then rados can do the proper refcounting and only deallocate the
> memory when all refs have gone away.  Unfortunately, I suspect that there
> is a largish category of users where this isn't sufficient... e.g., if
> some existing C user has its own buffer and it isn't practical to
> allocate/release via rados_buffer_* calls instead of malloc/free (or
> whatever).

Personally I vote for (1). That way is time consuming, but may help us find other ways to optimize resource consumption of API itself. In 
particular, if librbd, as you all wrote, does several copies of user buffers, then maybe it's worth spending some time on figuring out the 
actual lifetime of buffers? Maybe, for example, buffers in MOSDOp are actually copies of already copied buffers, so the extra copy done by 
librados is unnecessary?
Regardless, the idea behind my PR wasn't to make librados/librbd/libwhatever 100% optimal right away, but to make one step towards it being 
efficient - recduce cpu and memory usage a bit, have it go through testing, if nothing breaks, try harder until we're close to perfection.
even if few percent decrease in memory consumption doesn't look interesting on single-client level, few percents in large scale deployments may 
mean hundreds of gigabytes of memory that could be put to better use.

(2), and particularly the requirement for API changes, along with need to put user data into specific RADOS structure doesn't look good because
- that requires way more changes to user code, and I don't expect any of current user to be interested in that (unless we force it with API change)
- most of devs are simply lazy and instead of using "rados_buffer_create" to put their data directly into them, they'll keep using their own 
buffers and *then* copy them into RADOS buffers, just like we're doing it right now (even if behind the scenes).

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
