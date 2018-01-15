From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Mon, 15 Jan 2018 14:30:36 -0500
Message-ID: <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:41947 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeAOTah (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 14:30:37 -0500
Received: by mail-it0-f47.google.com with SMTP id b77so2108958itd.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 11:30:37 -0800 (PST)
In-Reply-To: <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

It's the buffer::raw class that abstracts foreign buffer
representations now, is it now? A mechanism to allow seastar to
single-allocate a composite buffer::raw and temporary_buffer<char>
seems possible to imagine.

Matt

On Mon, Jan 15, 2018 at 12:19 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Hi Kefu, thanks for your feedback on this!
>
> To add some context for the list, I had commented on Kefu's denc pr at
> https://github.com/ceph/ceph/pull/19662#issuecomment-355602713 about
> integrating ceph encode/decode with buffer types from other frameworks,
> using the seastar types as an example (seastar::temporary_buffer is a buffer
> segment with ownership semantics, so shares a lot in common with
> ceph::bufferptr).
>
> My approach in the seastar messenger added buffer conversions either by
> wrapping the seastar::temporary_buffer inside of a raw buffer type, or by
> wrapping our ceph::bufferptr inside a seastar::temporary_buffer's deleter
> object. So the conversions in both directions cost an allocation.
>
> On 01/15/2018 10:49 AM, kefu chai wrote:
>>
>> hey Casey,
>>
>>
>> i've been thinking about how to better integrate
>> seastar::temporary_buffer and seastar::packet into our denc and
>> messenger subsystems based on your wip-seastar-msg branch.
>>
>> as you pointed out to me that
>>
>>> the conversions between ceph::buffer::ptr and seastar::temporary_buffer
>>> in https://github.com/cbodley/ceph/tree/wip-seastar-msg/ work, but they cost
>>> an allocation in both directions (seastar::make_object_deleter() has to
>>> allocate for type erasure).
>>
>> and just like ceph::buffer::ptr, seastar::temporary_buffer also
>> manages the life cycle of the underlying memory chunk using refcount.
>> it's a waste to do the refcounting for the same mem chunk twice in the
>> same application.
>>
>> if we want to avoid the overhead of duplicated refcounting and
>> allocation in the conversion to and from ceph::buffer::ptr, i think,
>> we need to allocate the temporary_buffer along with buffer::ptr. in
>> other words, to include seastar::temporary_buffer as a member variable
>> in ceph::buffer:ptr.
>>
>> i am preparing a change to prototype this approach. the downside of it is:
>>
>> - we need to include a placeholder structure in buffer.h for
>> seastar::tempoary_buffer<char>. and cast it to
>> seastar::tempoary_buffer<char> in buffer.cc . otherwise we need to
>> include seastar headers in librados.
>>
>> cheers,
>>
>>
>
> Interesting, I hadn't thought about adding it as a member of bufferptr. That
> would be add some size overhead for non-seastar buffers though, unless we
> were able to reuse that for all raw buffer types. I agree that we want to be
> careful about dependencies, though, so I was really hoping to avoid this
> kind of coupling. I'd really prefer not to have any of our common libraries
> depend on seastar, and only link it directly to the targets that need it.
>
> My initial idea was that, if we were able to refactor denc in terms of some
> generic buffer concept, we'd be able to use ceph's encode/decode on external
> buffer types without the need to convert to/from bufferlist in the first
> place. That would allow us to support seastar's buffer types, and also
> extend support to other types like boost::asio's buffer concepts as well.
>
> So my comment on your pr was asking more about specific features that denc
> requires from bufferlist, so that we could start to generalize them in a way
> that doesn't have bufferlist baked in.
>
> Thanks,
> Casey
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
