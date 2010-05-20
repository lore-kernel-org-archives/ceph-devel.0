From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Thu, 20 May 2010 16:02:20 -0700
Message-ID: <AANLkTinvwpG_7T2L8IvFuJZRTE8HvkAF3EOqOH8duaFH@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47137 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0ETXCV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 19:02:21 -0400
In-Reply-To: <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Thu, May 20, 2010 at 1:31 PM, Blue Swirl <blauwirbel@gmail.com> wrot=
e:
> On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wrote=
:
>> The attached patch is a block driver for the distributed file system
>> Ceph (http://ceph.newdream.net/). This driver uses librados (which
>> is part of the Ceph server) for direct access to the Ceph object
>> store and is running entirely in userspace. Therefore it is
>> called "rbd" - rados block device.
=2E..
>
> IIRC underscores here may conflict with system header use. Please use
> something like QEMU_BLOCK_RADOS_H.

This header is shared between the linux kernel client and the ceph
userspace servers and client. We can actually get rid of it, as we
only need it to define CEPH_OSD_TMAP_SET. We can move this definition
to librados.h.

>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>> new file mode 100644
>> index 0000000..dfd5aa0
>> --- /dev/null
>> +++ b/block/rbd_types.h
>> @@ -0,0 +1,48 @@
>> +#ifndef _FS_CEPH_RBD
>> +#define _FS_CEPH_RBD
>
> QEMU_BLOCK_RBD?

This header is shared between the ceph kernel client, between the qemu
rbd module (and between other ceph utilities). It'd be much easier
maintaining it without having to have a different implementation for
each. The same goes to the use of __le32/64 and __u32/64 within these
headers.

>
>> +
>> +#include <linux/types.h>
>
> Can you use standard includes, like <sys/types.h> or <inttypes.h>? Ar=
e
> Ceph libraries used in other systems than Linux?

Not at the moment. I guess that we can take this include out.

>
>> +
>> +/*
>> + * rbd image 'foo' consists of objects
>> + * =A0 foo.rbd =A0 =A0 =A0- image metadata
>> + * =A0 foo.00000000
>> + * =A0 foo.00000001
>> + * =A0 ... =A0 =A0 =A0 =A0 =A0- data
>> + */
>> +
>> +#define RBD_SUFFIX =A0 =A0 =A0 =A0 =A0 =A0 ".rbd"
>> +#define RBD_DIRECTORY =A0 =A0 =A0 =A0 =A0 "rbd_directory"
>> +
>> +#define RBD_DEFAULT_OBJ_ORDER =A022 =A0 /* 4MB */
>> +
>> +#define RBD_MAX_OBJ_NAME_SIZE =A096
>> +#define RBD_MAX_SEG_NAME_SIZE =A0128
>> +
>> +#define RBD_COMP_NONE =A0 =A0 =A0 =A0 =A00
>> +#define RBD_CRYPT_NONE =A0 =A0 =A0 =A0 0
>> +
>> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>>\=
n";
>> +static const char rbd_signature[] =3D "RBD";
>> +static const char rbd_version[] =3D "001.001";
>> +
>> +struct rbd_obj_snap_ondisk {
>> + =A0 =A0 =A0 __le64 id;
>> + =A0 =A0 =A0 __le64 image_size;
>> +} __attribute__((packed));
>> +
>> +struct rbd_obj_header_ondisk {
>> + =A0 =A0 =A0 char text[64];
>> + =A0 =A0 =A0 char signature[4];
>> + =A0 =A0 =A0 char version[8];
>> + =A0 =A0 =A0 __le64 image_size;
>
> Unaligned? Is the disk format fixed?

This is a packed structure that represents the on disk format.
Operations on it are being done only to read from the disk header or
to write to the disk header.


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
