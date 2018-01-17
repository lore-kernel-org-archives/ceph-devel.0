From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Wed, 17 Jan 2018 20:53:08 +0800
Message-ID: <CAJE9aOMsghaR_Q5odM3ETNx=w4_hG9a_WAuiQX1AFuAwgaQdfA@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com> <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
 <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com> <CAJE9aOPuguVg4hDkV8vL0GNffRJw0zSbH0aLy4Tb2oVopCy8bg@mail.gmail.com>
 <1559cb3f-5e78-eed0-1a97-cfca8b1aad19@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:40125 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeAQMxK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 07:53:10 -0500
Received: by mail-qt0-f174.google.com with SMTP id s39so5226512qth.7
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 04:53:09 -0800 (PST)
In-Reply-To: <1559cb3f-5e78-eed0-1a97-cfca8b1aad19@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Matt Benjamin <mbenjami@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Jan 17, 2018 at 6:15 AM, Casey Bodley <cbodley@redhat.com> wrote:
>
> On 01/16/2018 06:26 AM, kefu chai wrote:
>>
>> On Tue, Jan 16, 2018 at 4:48 AM, Casey Bodley <cbodley@redhat.com> wrote:
>>>
>>> On 01/15/2018 02:30 PM, Matt Benjamin wrote:
>>>>
>>>> It's the buffer::raw class that abstracts foreign buffer
>>>> representations now, is it now? A mechanism to allow seastar to
>>>> single-allocate a composite buffer::raw and temporary_buffer<char>
>>>> seems possible to imagine.
>>>>
>>>> Matt
>>>
>>>
>>> Thanks Matt. I think that's effectively what I did with
>>>
>>> https://github.com/cbodley/ceph/commit/67ae06e488c50a6102c66d34b942ff207493ffd6.
>>> It allocates a buffer::raw subclass that stores temporary_buffer<char> as
>>> a
>>> member. The raw allocation here is the same one we'd see with any other
>>> buffer type, so I was mistaken in thinking of this as extra overhead. The
>>> allocation in the other direction is effectively seastar's version of
>>> this
>>> same abstraction. So I think these conversions are fine as they are.
>>>
>>> I do still think there are wins in generalizing denc to avoid these
>>> conversions, but we'll have to explore whether it's worth the extra
>>> complexity.
>>
>> i see. is https://github.com/tchaikov/ceph/tree/wip-seastar-msg
>> something more close to what you are thinking about?
>>
>
> Dear Kefu, you are a wizard. That looks like a great start!
>
> I'm guessing that segmented buffers will be the hard part - we might look to
> the boost::asio buffer concepts for some ideas there?
>
> they have const and non-const sequences:
> http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/ConstBufferSequence.html
> http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/MutableBufferSequence.html
>
> and a dynamic/resizable sequence:
> http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/DynamicBuffer.htm
>
> Boost has lots of built-in adapters for array/vector/string types:
> http://www.boost.org/doc/libs/1_66_0/doc/html/boost_asio/reference/buffer.html
>
> If we could find a way to use those concepts directly, we'd get those
> built-in types for free, and it should be easy to adapt other types like
> those from seastar.

 i think it could be feasible to come up with some generic adapter to
use these concepts, but we might need to focus on some typical use
cases. for example, to encode and write a MOSDOpReply:

assuming that we want to encode it into multiple temporary buffers and
send them using a seastar::packet. the MOSDOpReply struct has a field
of vector<OSDOp>, and OSDOp in turn has "bufferlist outdata;" in it.
for a read op, apparently, we want to avoid memcpy. if the underlying
read(store) returns a bufferlist, the encoder should be able to
shallow copy the bufferlist and encapsulate it in a fragment with a
customized deleter or just a temporary_buffer. if we want to avoid the
conversion from buffer::list to seastar::packet, probably we should
generalize the appender so it

- is able to manage the life cycle of the buffers in bufferlist being
encoded. i.e. should flush current temporary_buffer, and translate all
buffer::ptr to seastar::temporary_buffer, then append them to the
output seastar::packet
- just writes to the local temporary_buffer directly when encoding
other kinds of objects.

so, i don't think we can have a very generic appender if we want to be
efficient. but we can define one which works for certain output type.
in this example, it's seastar::packet.

>
> DynamicBuffer::prepare() looks like a natural way to do the append part on
> encode, but it returns a MutableBufferSequence so is not guaranteed to be
> contiguous. Can you remind me where we really depend on contiguous buffers?

IIRC, we don't really depend on contiguous buffers. but we do expect
that the buffer we are manipulating is continuous, so we can have the
opportunity to optimize the dencoder:

- encoding: it's a noticeable overhead to check the underlying buffer
boundary when writing to a buffer. that's why we introduced the
appender to facilitate the encoding. see [1]
- decoding: for the similar reason, it's more performant to just read
a contiguous buffer than reading from a segmented one. in other words,
if we can ensure a the bufferlist being decoded has only a single raw
buffer, why bother checking the boundary?

if we want to encode object into the mutable buffers returned
DynamicBuffer::prepare(), we need to check x.size() when writing to
x.data() and move on to the next one if current buffer chunk is too
small.

--
[1] https://www.spinics.net/lists/ceph-devel/msg32608.html


> Is it just that some types set need_contiguous=false because we haven't yet
> implemented logic for segmented buffers, or are there cases where
> implementing that logic is actually intractable?

"need_contiguous" trait was added to the denc for the case where the
buffer being decoded are large objects and they could be segmented.
these objects are read from bluestore. but i think we would expand the
case to the large message if we rebuild/flatten the segmented buffer,
the overhead of reallocating the buffer and memcpy calls offsets the
performance improvement we achieve by avoiding the bound check and
simpler logic. before that, we always do the rebuild before decoding a
buffer::list::iterator.

>
> Thanks,
> Casey



-- 
Regards
Kefu Chai
