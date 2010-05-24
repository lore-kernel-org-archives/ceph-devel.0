From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Sun, 23 May 2010 19:17:13 -0700
Message-ID: <AANLkTimU_qiIdXA4Aa5al2bGzDYzeH3I4G3MxzRZVtFJ@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	 <AANLkTinvwpG_7T2L8IvFuJZRTE8HvkAF3EOqOH8duaFH@mail.gmail.com>
	 <AANLkTikizub-fzp3fahs7Sz_WtaykH8UAbI3jaKnHjoV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48294 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab0EXCRP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 May 2010 22:17:15 -0400
In-Reply-To: <AANLkTikizub-fzp3fahs7Sz_WtaykH8UAbI3jaKnHjoV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Sun, May 23, 2010 at 12:59 AM, Blue Swirl <blauwirbel@gmail.com> wro=
te:
> On Thu, May 20, 2010 at 11:02 PM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Thu, May 20, 2010 at 1:31 PM, Blue Swirl <blauwirbel@gmail.com> w=
rote:
>>> On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wro=
te:
>>>> The attached patch is a block driver for the distributed file syst=
em
>>>> Ceph (http://ceph.newdream.net/). This driver uses librados (which
>>>> is part of the Ceph server) for direct access to the Ceph object
>>>> store and is running entirely in userspace. Therefore it is
>>>> called "rbd" - rados block device.
>> ...
>>>
>>> IIRC underscores here may conflict with system header use. Please u=
se
>>> something like QEMU_BLOCK_RADOS_H.
>>
>> This header is shared between the linux kernel client and the ceph
>> userspace servers and client. We can actually get rid of it, as we
>> only need it to define CEPH_OSD_TMAP_SET. We can move this definitio=
n
>> to librados.h.
>>
>>>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>>>> new file mode 100644
>>>> index 0000000..dfd5aa0
>>>> --- /dev/null
>>>> +++ b/block/rbd_types.h
>>>> @@ -0,0 +1,48 @@
>>>> +#ifndef _FS_CEPH_RBD
>>>> +#define _FS_CEPH_RBD
>>>
>>> QEMU_BLOCK_RBD?
>>
>> This header is shared between the ceph kernel client, between the qe=
mu
>> rbd module (and between other ceph utilities). It'd be much easier
>> maintaining it without having to have a different implementation for
>> each. The same goes to the use of __le32/64 and __u32/64 within thes=
e
>> headers.
>
> This is user space, so identifiers must conform to C standards. The
> identifiers beginning with underscores are reserved.
>
> Doesn't __le32/64 also depend on some GCC extension? Or sparse magic?
It depends on gcc extension. If needed we can probably have a separate
header for the qemu block device that uses alternative types. Though
looking at the qemu code I see use of other gcc extensions so I'm not
sure this is a real issue.

>
>>
>>>
>>>> +
>>>> +#include <linux/types.h>
>>>
>>> Can you use standard includes, like <sys/types.h> or <inttypes.h>? =
Are
>>> Ceph libraries used in other systems than Linux?
>>
>> Not at the moment. I guess that we can take this include out.
>>
>>>
>>>> +
>>>> +/*
>>>> + * rbd image 'foo' consists of objects
>>>> + * =A0 foo.rbd =A0 =A0 =A0- image metadata
>>>> + * =A0 foo.00000000
>>>> + * =A0 foo.00000001
>>>> + * =A0 ... =A0 =A0 =A0 =A0 =A0- data
>>>> + */
>>>> +
>>>> +#define RBD_SUFFIX =A0 =A0 =A0 =A0 =A0 =A0 ".rbd"
>>>> +#define RBD_DIRECTORY =A0 =A0 =A0 =A0 =A0 "rbd_directory"
>>>> +
>>>> +#define RBD_DEFAULT_OBJ_ORDER =A022 =A0 /* 4MB */
>>>> +
>>>> +#define RBD_MAX_OBJ_NAME_SIZE =A096
>>>> +#define RBD_MAX_SEG_NAME_SIZE =A0128
>>>> +
>>>> +#define RBD_COMP_NONE =A0 =A0 =A0 =A0 =A00
>>>> +#define RBD_CRYPT_NONE =A0 =A0 =A0 =A0 0
>>>> +
>>>> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>=
>\n";
>>>> +static const char rbd_signature[] =3D "RBD";
>>>> +static const char rbd_version[] =3D "001.001";
>>>> +
>>>> +struct rbd_obj_snap_ondisk {
>>>> + =A0 =A0 =A0 __le64 id;
>>>> + =A0 =A0 =A0 __le64 image_size;
>>>> +} __attribute__((packed));
>>>> +
>>>> +struct rbd_obj_header_ondisk {
>>>> + =A0 =A0 =A0 char text[64];
>>>> + =A0 =A0 =A0 char signature[4];
>>>> + =A0 =A0 =A0 char version[8];
>>>> + =A0 =A0 =A0 __le64 image_size;
>>>
>>> Unaligned? Is the disk format fixed?
>>
>> This is a packed structure that represents the on disk format.
>> Operations on it are being done only to read from the disk header or
>> to write to the disk header.
>
> That's clear. But what exactly is the alignment of field 'image_size'=
?
> Could there be implicit padding to mod 8 between 'version' and
> 'image_size' with some compilers?

Obviously it's not 64 bit aligned. As it's an on-disk header, I don't
see alignment a real issue. As was said before, any operation on these
fields have to go through endianity conversion anyway, and this
structure should not be used directly. For such datastructures I'd
rather have the fields ordered in some logical order than maintaining
the alignment by ourselves. That's why we have that __attribute__
packed in the end to let the compiler deal with those issues. Other
compilers though have their own syntax for packed structures (but I do
see other uses of this packed syntax in the qemu code).

>
> If there were no other constraints, I'd either make the padding
> explicit, or rearrange/resize fields so that the field alignment is
> natural. Thus my question, can you change the disk format or are ther=
e
> already some deployments?

We can certainly make changes to the disk format at this point. I'm
not very happy with those 3 __u8 in the middle, and they can probably
be changed to a 32 bit flags field. We can get it 64 bit aligned too.

>
> Otherwise, I'd just add some warning comment so people don't try to
> use clever pointer tricks which will crash on machines with enforced
> alignment.
>
Any clever pointer tricks that'll work on one architecture will
probably be wrong on another (different word
size/alignment/endianity), so maybe crashing machines is a good
indicator to bad implementation. We shouldn't try to hide the
problems.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
