From: Casey Bodley <cbodley@redhat.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Tue, 16 Jan 2018 17:15:33 -0500
Message-ID: <1559cb3f-5e78-eed0-1a97-cfca8b1aad19@redhat.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com>
 <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
 <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com>
 <CAJE9aOPuguVg4hDkV8vL0GNffRJw0zSbH0aLy4Tb2oVopCy8bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:40704 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPWPg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 17:15:36 -0500
Received: by mail-qk0-f173.google.com with SMTP id d18so22894456qke.7
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 14:15:36 -0800 (PST)
In-Reply-To: <CAJE9aOPuguVg4hDkV8vL0GNffRJw0zSbH0aLy4Tb2oVopCy8bg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Matt Benjamin <mbenjami@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 01/16/2018 06:26 AM, kefu chai wrote:
> On Tue, Jan 16, 2018 at 4:48 AM, Casey Bodley <cbodley@redhat.com> wrote:
>> On 01/15/2018 02:30 PM, Matt Benjamin wrote:
>>> It's the buffer::raw class that abstracts foreign buffer
>>> representations now, is it now? A mechanism to allow seastar to
>>> single-allocate a composite buffer::raw and temporary_buffer<char>
>>> seems possible to imagine.
>>>
>>> Matt
>>
>> Thanks Matt. I think that's effectively what I did with
>> https://github.com/cbodley/ceph/commit/67ae06e488c50a6102c66d34b942ff207493ffd6.
>> It allocates a buffer::raw subclass that stores temporary_buffer<char> as a
>> member. The raw allocation here is the same one we'd see with any other
>> buffer type, so I was mistaken in thinking of this as extra overhead. The
>> allocation in the other direction is effectively seastar's version of this
>> same abstraction. So I think these conversions are fine as they are.
>>
>> I do still think there are wins in generalizing denc to avoid these
>> conversions, but we'll have to explore whether it's worth the extra
>> complexity.
> i see. is https://github.com/tchaikov/ceph/tree/wip-seastar-msg
> something more close to what you are thinking about?
>

Dear Kefu, you are a wizard. That looks like a great start!

I'm guessing that segmented buffers will be the hard part - we might 
look to the boost::asio buffer concepts for some ideas there?

they have const and non-const sequences:
http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/ConstBufferSequence.html
http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/MutableBufferSequence.html

and a dynamic/resizable sequence:
http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/DynamicBuffer.htm

Boost has lots of built-in adapters for array/vector/string types:
http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/buffer.html

If we could find a way to use those concepts directly, we'd get those 
built-in types for free, and it should be easy to adapt other types like 
those from seastar.

DynamicBuffer::prepare() looks like a natural way to do the append part 
on encode, but it returns a MutableBufferSequence so is not guaranteed 
to be contiguous. Can you remind me where we really depend on contiguous 
buffers? Is it just that some types set need_contiguous=false because we 
haven't yet implemented logic for segmented buffers, or are there cases 
where implementing that logic is actually intractable?

Thanks,
Casey
