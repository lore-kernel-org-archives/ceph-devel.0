From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 2/6] libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 14:52:48 +0200
Message-ID: <CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
	<1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com>
	<530B5E36.4030200@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55304 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaBYMwt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 07:52:49 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so298207qac.8
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 04:52:49 -0800 (PST)
In-Reply-To: <530B5E36.4030200@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 24, 2014 at 4:59 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
>> This is primarily for rbd's benefit and is supposed to combat
>> fragmentation:
>>
>> "... knowing that rbd images have a 4m size, librbd can pass a hint
>> that will let the osd do the xfs allocation size ioctl on new files so
>> that they are allocated in 1m or 4m chunks.  We've seen cases where
>> users with rbd workloads have very high levels of fragmentation in xfs
>> and this would mitigate that and probably have a pretty nice
>> performance benefit."
>>
>> SETALLOCHINT is considered advisory, so our backwards compatibility
>> mechanism here is to set FAILOK flag for all SETALLOCHINT ops.
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>
> I have a few small comments for you to consider but this
> looks good to me.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> ---
>>  include/linux/ceph/osd_client.h |    9 +++++++++
>>  include/linux/ceph/rados.h      |    8 ++++++++
>>  net/ceph/osd_client.c           |   30 ++++++++++++++++++++++++++++++
>>  3 files changed, 47 insertions(+)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index e94f5da251d6..6bfcb0eca8ab 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -103,6 +103,11 @@ struct ceph_osd_req_op {
>>                       u32 timeout;
>>                       __u8 flag;
>>               } watch;
>> +             struct {
>> +                     u64 expected_size;
>
> Maybe "expected_object_size"?  I wasn't sure until I read some
> of the e-mail discussion what size this was referring to, and
> wondered whether it was for reads or something.  This should
> be done on the over-the-wire and server side structure
> definitions too (if it's done at all).

Done, on both sides.

>
> The other thing is that the expected size is limited by
> rbd_image_header->obj_order, which is a single byte.  I
> think you should encode this the same way.  Even if the
> hint were for more than RBD, this level of granularity
> may be sufficient.
>
>> +                     u64 expected_write_size;
>
> Probably the same thing here, a byte might be enough
> to encode this by using log2(expected_write_size).
>
>> +                     __u8 expected_size_probability;

I think in the interest of genericity expected_object_size should be an
arbitrary, not limited to a power-of-2 value.  Now, given the current
90M object size limit 64 bits might seem a lot, but extent offset and
length are 64 bit values and to be future-proof I followed that here.

expected_size_probability is currently unused.  It was supposed to be
a 0-100 value, indicating whether we expect the object to be smaller
than expected_object_size or not and how strong that expectation is.

I'm not sure if you've seen it, but this (both userspace and kernel
sides) were implemented according to the design laid out by Sage in the
"rados io hints" thread on ceph-devel about a month ago.  There wasn't
any discussion that I'm aware of in the interim, that is until the
recent "wip-hint" thread, which was triggered by my PR.

>
> I'm not sure why these single-byte values use __u8 while the
> multi-byte values use (e.g.) u32.  The leading underscores
> are supposed to be used for values exposed to user space (or
> something like that).  Anyway, not a problem with your change,
> but something maybe you could check into.

I'm not sure either.  I vaguely assumed it's related to the fact that
single-byte ceph_osd_req_op fields are directly assigned to the
corresponding ceph_osd_op fields which are exported to userspace,
whereas the multi-byte values go through the endianness conversion
macros, which change the type to __le*.

>
>> +             } hint;
>>       };
>>  };
>>
>> @@ -294,6 +299,10 @@ extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>>  extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>>                                       unsigned int which, u16 opcode,
>>                                       u64 cookie, u64 version, int flag);
>> +extern void osd_req_op_hint_init(struct ceph_osd_request *osd_req,
>> +                              unsigned int which, u16 opcode,
>> +                              u64 expected_size, u64 expected_write_size,
>> +                              u8 expected_size_probability);
>>
>>  extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>>                                              struct ceph_snap_context *snapc,
>> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
>> index 8f9bf4570215..b8e2dd11f186 100644
>> --- a/include/linux/ceph/rados.h
>> +++ b/include/linux/ceph/rados.h
>> @@ -227,6 +227,9 @@ enum {
>>       CEPH_OSD_OP_OMAPRMKEYS    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 24,
>>       CEPH_OSD_OP_OMAP_CMP      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 25,
>>
>> +     /* hints */
>> +     CEPH_OSD_OP_SETALLOCHINT = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 35,
>> +
>>       /** multi **/
>>       CEPH_OSD_OP_CLONERANGE = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_MULTI | 1,
>>       CEPH_OSD_OP_ASSERT_SRC_VERSION = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_MULTI | 2,
>> @@ -416,6 +419,11 @@ struct ceph_osd_op {
>>                       __le64 offset, length;
>>                       __le64 src_offset;
>>               } __attribute__ ((packed)) clonerange;
>> +             struct {
>> +                     __le64 expected_size;
>> +                     __le64 expected_write_size;
>> +                     __u8 expected_size_probability;
>> +             } __attribute__ ((packed)) hint;
>>       };
>>       __le32 payload_len;
>>  } __attribute__ ((packed));
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 5d7fd0b8c1c8..4090f6e8db3a 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -436,6 +436,7 @@ static bool osd_req_opcode_valid(u16 opcode)
>>       case CEPH_OSD_OP_OMAPCLEAR:
>>       case CEPH_OSD_OP_OMAPRMKEYS:
>>       case CEPH_OSD_OP_OMAP_CMP:
>> +     case CEPH_OSD_OP_SETALLOCHINT:
>>       case CEPH_OSD_OP_CLONERANGE:
>>       case CEPH_OSD_OP_ASSERT_SRC_VERSION:
>>       case CEPH_OSD_OP_SRC_CMPXATTR:
>> @@ -591,6 +592,28 @@ void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>>  }
>>  EXPORT_SYMBOL(osd_req_op_watch_init);
>>
>> +void osd_req_op_hint_init(struct ceph_osd_request *osd_req,
>> +                       unsigned int which, u16 opcode,
>> +                       u64 expected_size, u64 expected_write_size,
>> +                       u8 expected_size_probability)
>> +{
>> +     struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
>> +
>> +     BUG_ON(opcode != CEPH_OSD_OP_SETALLOCHINT);
>> +
>> +     op->hint.expected_size = expected_size;
>> +     op->hint.expected_write_size = expected_write_size;
>> +     op->hint.expected_size_probability = expected_size_probability;
>> +
>> +     /*
>> +      * CEPH_OSD_OP_SETALLOCHINT op is advisory and therefore deemed
>> +      * not worth a feature bit.  Set FAILOK per-op flag to make
>> +      * sure older osds don't trip over an unsupported opcode.
>> +      */
>> +     op->flags |= CEPH_OSD_OP_FLAG_FAILOK;
>
> I think this is reasonable.  The only thing I wonder about is
> whether there could be any other failure that could occur on
> an OSD server that actually supports the op that we would care
> about.  It's still advisory though, so functionally it won't
> matter.

Currently there isn't any such failure.  In fact, the only thing that
this FAILOK hides is the EOPNOTSUPP from an OSD that doesn't support
the new op.  Everything else is done on the backend, and there all
errors are explicitly ignored because this is an advisory op and it
would bring down the OSD otherwise.

Thanks,

                Ilya
