From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Wed, 17 Jan 2018 08:13:09 -0500
Message-ID: <CAKOnarkAqHY2bz5nmQbkf3=-sKpuNqbmd9MDgtV7KN1KTN=7jA@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com> <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
 <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com> <CAJE9aOPuguVg4hDkV8vL0GNffRJw0zSbH0aLy4Tb2oVopCy8bg@mail.gmail.com>
 <1559cb3f-5e78-eed0-1a97-cfca8b1aad19@redhat.com> <CAJE9aOMsghaR_Q5odM3ETNx=w4_hG9a_WAuiQX1AFuAwgaQdfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35252 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeAQNNK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 08:13:10 -0500
Received: by mail-io0-f171.google.com with SMTP id m11so11401956iob.2
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 05:13:10 -0800 (PST)
In-Reply-To: <CAJE9aOMsghaR_Q5odM3ETNx=w4_hG9a_WAuiQX1AFuAwgaQdfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Jan 17, 2018 at 7:53 AM, kefu chai <tchaikov@gmail.com> wrote:
>
>  i think it could be feasible to come up with some generic adapter to
> use these concepts, but we might need to focus on some typical use
> cases. for example, to encode and write a MOSDOpReply:
>
> assuming that we want to encode it into multiple temporary buffers and
> send them using a seastar::packet. the MOSDOpReply struct has a field
> of vector<OSDOp>, and OSDOp in turn has "bufferlist outdata;" in it.
> for a read op, apparently, we want to avoid memcpy. if the underlying
> read(store) returns a bufferlist, the encoder should be able to
> shallow copy the bufferlist and encapsulate it in a fragment with a
> customized deleter or just a temporary_buffer. if we want to avoid the
> conversion from buffer::list to seastar::packet, probably we should
> generalize the appender so it

Yes, we'd like to avoid such copies.

>
> - is able to manage the life cycle of the buffers in bufferlist being
> encoded. i.e. should flush current temporary_buffer, and translate all
> buffer::ptr to seastar::temporary_buffer, then append them to the
> output seastar::packet
> - just writes to the local temporary_buffer directly when encoding
> other kinds of objects.
>
> so, i don't think we can have a very generic appender if we want to be
> efficient. but we can define one which works for certain output type.
> in this example, it's seastar::packet.

That sounds right to me.

>
>>
>> DynamicBuffer::prepare() looks like a natural way to do the append part on
>> encode, but it returns a MutableBufferSequence so is not guaranteed to be
>> contiguous. Can you remind me where we really depend on contiguous buffers?
>
> IIRC, we don't really depend on contiguous buffers. but we do expect
> that the buffer we are manipulating is continuous, so we can have the
> opportunity to optimize the dencoder:
>
> - encoding: it's a noticeable overhead to check the underlying buffer
> boundary when writing to a buffer. that's why we introduced the
> appender to facilitate the encoding. see [1]

This is kind of surprising.

> - decoding: for the similar reason, it's more performant to just read
> a contiguous buffer than reading from a segmented one. in other words,
> if we can ensure a the bufferlist being decoded has only a single raw
> buffer, why bother checking the boundary?

Is that likely?  If the decoding case is from seastar, isn't the
incoming data likely to be in the form of several mbufs?

>
> if we want to encode object into the mutable buffers returned
> DynamicBuffer::prepare(), we need to check x.size() when writing to
> x.data() and move on to the next one if current buffer chunk is too
> small.
>
> --
> [1] https://www.spinics.net/lists/ceph-devel/msg32608.html
>
>
>> Is it just that some types set need_contiguous=false because we haven't yet
>> implemented logic for segmented buffers, or are there cases where
>> implementing that logic is actually intractable?
>
> "need_contiguous" trait was added to the denc for the case where the
> buffer being decoded are large objects and they could be segmented.
> these objects are read from bluestore. but i think we would expand the
> case to the large message if we rebuild/flatten the segmented buffer,
> the overhead of reallocating the buffer and memcpy calls offsets the
> performance improvement we achieve by avoiding the bound check and
> simpler logic. before that, we always do the rebuild before decoding a
> buffer::list::iterator.

That's what I would have expected.

>
>>
>> Thanks,
>> Casey
>
>
>
> --
> Regards
> Kefu Chai



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
