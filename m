From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/6] libceph: add support for CEPH_OSD_OP_SETALLOCHINT
 osd op
Date: Tue, 25 Feb 2014 07:05:40 -0600
Message-ID: <530C9524.6070201@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>	<1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com>	<530B5E36.4030200@ieee.org> <CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38008 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaBYNFi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 08:05:38 -0500
Received: by mail-ig0-f169.google.com with SMTP id h18so7420448igc.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 05:05:37 -0800 (PST)
In-Reply-To: <CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/25/2014 06:52 AM, Ilya Dryomov wrote:
> On Mon, Feb 24, 2014 at 4:59 PM, Alex Elder <elder@ieee.org> wrote:
>> On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
>>> This is primarily for rbd's benefit and is supposed to combat
>>> fragmentation:
>>>
>>> "... knowing that rbd images have a 4m size, librbd can pass a hint
>>> that will let the osd do the xfs allocation size ioctl on new files so
>>> that they are allocated in 1m or 4m chunks.  We've seen cases where
>>> users with rbd workloads have very high levels of fragmentation in xfs
>>> and this would mitigate that and probably have a pretty nice
>>> performance benefit."
>>>
>>> SETALLOCHINT is considered advisory, so our backwards compatibility
>>> mechanism here is to set FAILOK flag for all SETALLOCHINT ops.
>>>
>>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>>
>> I have a few small comments for you to consider but this
>> looks good to me.
>>
>> Reviewed-by: Alex Elder <elder@linaro.org>

. . .

>> The other thing is that the expected size is limited by
>> rbd_image_header->obj_order, which is a single byte.  I
>> think you should encode this the same way.  Even if the
>> hint were for more than RBD, this level of granularity
>> may be sufficient.
>>
>>> +                     u64 expected_write_size;
>>
>> Probably the same thing here, a byte might be enough
>> to encode this by using log2(expected_write_size).
>>
>>> +                     __u8 expected_size_probability;
> 
> I think in the interest of genericity expected_object_size should be an
> arbitrary, not limited to a power-of-2 value.  Now, given the current
> 90M object size limit 64 bits might seem a lot, but extent offset and
> length are 64 bit values and to be future-proof I followed that here.

I have no objection to the 64-bit size but I still think
a byte representing log2(size) is sufficient.  Power-of-2
granularity is most likely fine (and might even be what
such a hint gets converted to anyway) for file systems
or other backing store.  But again, you can do that with
a 64 bit value as well.

> expected_size_probability is currently unused.  It was supposed to be
> a 0-100 value, indicating whether we expect the object to be smaller
> than expected_object_size or not and how strong that expectation is.
> 
> I'm not sure if you've seen it, but this (both userspace and kernel
> sides) were implemented according to the design laid out by Sage in the
> "rados io hints" thread on ceph-devel about a month ago.  There wasn't
> any discussion that I'm aware of in the interim, that is until the
> recent "wip-hint" thread, which was triggered by my PR.

I'm aware of it---I saw the discussion go by and skimmed
through it but did not look at it very closely.  I can't
keep up with all the traffic but I do try to pay attention
to code for review.

>> I'm not sure why these single-byte values use __u8 while the
>> multi-byte values use (e.g.) u32.  The leading underscores
>> are supposed to be used for values exposed to user space (or
>> something like that).  Anyway, not a problem with your change,
>> but something maybe you could check into.
> 
> I'm not sure either.  I vaguely assumed it's related to the fact that
> single-byte ceph_osd_req_op fields are directly assigned to the
> corresponding ceph_osd_op fields which are exported to userspace,
> whereas the multi-byte values go through the endianness conversion
> macros, which change the type to __le*.

Not a big deal regardless.

>>> +             } hint;
>>>       };
>>>  };

. . .

>>> +     /*
>>> +      * CEPH_OSD_OP_SETALLOCHINT op is advisory and therefore deemed
>>> +      * not worth a feature bit.  Set FAILOK per-op flag to make
>>> +      * sure older osds don't trip over an unsupported opcode.
>>> +      */
>>> +     op->flags |= CEPH_OSD_OP_FLAG_FAILOK;
>>
>> I think this is reasonable.  The only thing I wonder about is
>> whether there could be any other failure that could occur on
>> an OSD server that actually supports the op that we would care
>> about.  It's still advisory though, so functionally it won't
>> matter.
> 
> Currently there isn't any such failure.  In fact, the only thing that
> this FAILOK hides is the EOPNOTSUPP from an OSD that doesn't support
> the new op.  Everything else is done on the backend, and there all
> errors are explicitly ignored because this is an advisory op and it
> would bring down the OSD otherwise.

Sounds good.  Thanks for the explanations.

					-Alex

