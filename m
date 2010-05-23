From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Sun, 23 May 2010 07:59:32 +0000
Message-ID: <AANLkTikizub-fzp3fahs7Sz_WtaykH8UAbI3jaKnHjoV@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de> <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	<AANLkTinvwpG_7T2L8IvFuJZRTE8HvkAF3EOqOH8duaFH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46078 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab0EWH7x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 May 2010 03:59:53 -0400
In-Reply-To: <AANLkTinvwpG_7T2L8IvFuJZRTE8HvkAF3EOqOH8duaFH@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Thu, May 20, 2010 at 11:02 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Thu, May 20, 2010 at 1:31 PM, Blue Swirl <blauwirbel@gmail.com> wr=
ote:
>> On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wrot=
e:
>>> The attached patch is a block driver for the distributed file syste=
m
>>> Ceph (http://ceph.newdream.net/). This driver uses librados (which
>>> is part of the Ceph server) for direct access to the Ceph object
>>> store and is running entirely in userspace. Therefore it is
>>> called "rbd" - rados block device.
> ...
>>
>> IIRC underscores here may conflict with system header use. Please us=
e
>> something like QEMU_BLOCK_RADOS_H.
>
> This header is shared between the linux kernel client and the ceph
> userspace servers and client. We can actually get rid of it, as we
> only need it to define CEPH_OSD_TMAP_SET. We can move this definition
> to librados.h.
>
>>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>>> new file mode 100644
>>> index 0000000..dfd5aa0
>>> --- /dev/null
>>> +++ b/block/rbd_types.h
>>> @@ -0,0 +1,48 @@
>>> +#ifndef _FS_CEPH_RBD
>>> +#define _FS_CEPH_RBD
>>
>> QEMU_BLOCK_RBD?
>
> This header is shared between the ceph kernel client, between the qem=
u
> rbd module (and between other ceph utilities). It'd be much easier
> maintaining it without having to have a different implementation for
> each. The same goes to the use of __le32/64 and __u32/64 within these
> headers.

This is user space, so identifiers must conform to C standards. The
identifiers beginning with underscores are reserved.

Doesn't __le32/64 also depend on some GCC extension? Or sparse magic?

>
>>
>>> +
>>> +#include <linux/types.h>
>>
>> Can you use standard includes, like <sys/types.h> or <inttypes.h>? A=
re
>> Ceph libraries used in other systems than Linux?
>
> Not at the moment. I guess that we can take this include out.
>
>>
>>> +
>>> +/*
>>> + * rbd image 'foo' consists of objects
>>> + * =C2=A0 foo.rbd =C2=A0 =C2=A0 =C2=A0- image metadata
>>> + * =C2=A0 foo.00000000
>>> + * =C2=A0 foo.00000001
>>> + * =C2=A0 ... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- data
>>> + */
>>> +
>>> +#define RBD_SUFFIX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ".rbd=
"
>>> +#define RBD_DIRECTORY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "rbd_dire=
ctory"
>>> +
>>> +#define RBD_DEFAULT_OBJ_ORDER =C2=A022 =C2=A0 /* 4MB */
>>> +
>>> +#define RBD_MAX_OBJ_NAME_SIZE =C2=A096
>>> +#define RBD_MAX_SEG_NAME_SIZE =C2=A0128
>>> +
>>> +#define RBD_COMP_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> +#define RBD_CRYPT_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
>>> +
>>> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>>=
\n";
>>> +static const char rbd_signature[] =3D "RBD";
>>> +static const char rbd_version[] =3D "001.001";
>>> +
>>> +struct rbd_obj_snap_ondisk {
>>> + =C2=A0 =C2=A0 =C2=A0 __le64 id;
>>> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;
>>> +} __attribute__((packed));
>>> +
>>> +struct rbd_obj_header_ondisk {
>>> + =C2=A0 =C2=A0 =C2=A0 char text[64];
>>> + =C2=A0 =C2=A0 =C2=A0 char signature[4];
>>> + =C2=A0 =C2=A0 =C2=A0 char version[8];
>>> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;
>>
>> Unaligned? Is the disk format fixed?
>
> This is a packed structure that represents the on disk format.
> Operations on it are being done only to read from the disk header or
> to write to the disk header.

That's clear. But what exactly is the alignment of field 'image_size'?
Could there be implicit padding to mod 8 between 'version' and
'image_size' with some compilers?

If there were no other constraints, I'd either make the padding
explicit, or rearrange/resize fields so that the field alignment is
natural. Thus my question, can you change the disk format or are there
already some deployments?

Otherwise, I'd just add some warning comment so people don't try to
use clever pointer tricks which will crash on machines with enforced
alignment.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
