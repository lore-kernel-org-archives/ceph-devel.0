From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 2/6] libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 15:38:26 +0200
Message-ID: <CALFYKtAo9KXtnHBQcFqb0yPj3k-r7Eb5cHxhfKSEindQ=_rk+Q@mail.gmail.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
	<1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com>
	<530B5E36.4030200@ieee.org>
	<CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
	<530C9524.6070201@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35171 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbaBYNi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 08:38:27 -0500
Received: by mail-qg0-f48.google.com with SMTP id a108so1059015qge.7
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 05:38:27 -0800 (PST)
In-Reply-To: <530C9524.6070201@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 25, 2014 at 3:05 PM, Alex Elder <elder@ieee.org> wrote:
>>> The other thing is that the expected size is limited by
>>> rbd_image_header->obj_order, which is a single byte.  I
>>> think you should encode this the same way.  Even if the
>>> hint were for more than RBD, this level of granularity
>>> may be sufficient.
>>>
>>>> +                     u64 expected_write_size;
>>>
>>> Probably the same thing here, a byte might be enough
>>> to encode this by using log2(expected_write_size).
>>>
>>>> +                     __u8 expected_size_probability;
>>
>> I think in the interest of genericity expected_object_size should be an
>> arbitrary, not limited to a power-of-2 value.  Now, given the current
>> 90M object size limit 64 bits might seem a lot, but extent offset and
>> length are 64 bit values and to be future-proof I followed that here.
>
> I have no objection to the 64-bit size but I still think
> a byte representing log2(size) is sufficient.  Power-of-2
> granularity is most likely fine (and might even be what
> such a hint gets converted to anyway) for file systems
> or other backing store.  But again, you can do that with
> a 64 bit value as well.

Filesystems of course round it, but probably not to a power-of-2.
I guess it's adjusted to a multiple of block size and then capped with
some value that the allocator can cope with.  xfs for example would
happily take on say 5M.  power-of-2 is sufficient for rbd, but
_probably_ not in general.

Thanks,

                Ilya
