From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 20:13:35 +0000
Message-ID: <AANLkTimI4lCSRQP_nqiok1zJtMSd2mNBHRZzvsPncnR4@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	<AANLkTinvwpG_7T2L8IvFuJZRTE8HvkAF3EOqOH8duaFH@mail.gmail.com>
	<AANLkTikizub-fzp3fahs7Sz_WtaykH8UAbI3jaKnHjoV@mail.gmail.com>
	<AANLkTimU_qiIdXA4Aa5al2bGzDYzeH3I4G3MxzRZVtFJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <AANLkTimU_qiIdXA4Aa5al2bGzDYzeH3I4G3MxzRZVtFJ@mail.gmail.com>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On Mon, May 24, 2010 at 2:17 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Sun, May 23, 2010 at 12:59 AM, Blue Swirl <blauwirbel@gmail.com> wrote=
:
>> On Thu, May 20, 2010 at 11:02 PM, Yehuda Sadeh Weinraub
>> <yehudasa@gmail.com> wrote:
>>> On Thu, May 20, 2010 at 1:31 PM, Blue Swirl <blauwirbel@gmail.com> wrot=
e:
>>>> On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wrote:
>>>>> The attached patch is a block driver for the distributed file system
>>>>> Ceph (http://ceph.newdream.net/). This driver uses librados (which
>>>>> is part of the Ceph server) for direct access to the Ceph object
>>>>> store and is running entirely in userspace. Therefore it is
>>>>> called "rbd" - rados block device.
>>> ...
>>>>
>>>> IIRC underscores here may conflict with system header use. Please use
>>>> something like QEMU_BLOCK_RADOS_H.
>>>
>>> This header is shared between the linux kernel client and the ceph
>>> userspace servers and client. We can actually get rid of it, as we
>>> only need it to define CEPH_OSD_TMAP_SET. We can move this definition
>>> to librados.h.
>>>
>>>>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>>>>> new file mode 100644
>>>>> index 0000000..dfd5aa0
>>>>> --- /dev/null
>>>>> +++ b/block/rbd_types.h
>>>>> @@ -0,0 +1,48 @@
>>>>> +#ifndef _FS_CEPH_RBD
>>>>> +#define _FS_CEPH_RBD
>>>>
>>>> QEMU_BLOCK_RBD?
>>>
>>> This header is shared between the ceph kernel client, between the qemu
>>> rbd module (and between other ceph utilities). It'd be much easier
>>> maintaining it without having to have a different implementation for
>>> each. The same goes to the use of __le32/64 and __u32/64 within these
>>> headers.
>>
>> This is user space, so identifiers must conform to C standards. The
>> identifiers beginning with underscores are reserved.
>>
>> Doesn't __le32/64 also depend on some GCC extension? Or sparse magic?
> It depends on gcc extension. If needed we can probably have a separate
> header for the qemu block device that uses alternative types. Though
> looking at the qemu code I see use of other gcc extensions so I'm not
> sure this is a real issue.

We use some (contained with for example macros if possible), but in
earlier discussions, __le32 etc. were considered problematic. IIRC
it's hard to provide alternate versions for other compilers (or older
versions of gcc).

>
>>
>>>
>>>>
>>>>> +
>>>>> +#include <linux/types.h>
>>>>
>>>> Can you use standard includes, like <sys/types.h> or <inttypes.h>? Are
>>>> Ceph libraries used in other systems than Linux?
>>>
>>> Not at the moment. I guess that we can take this include out.
>>>
>>>>
>>>>> +
>>>>> +/*
>>>>> + * rbd image 'foo' consists of objects
>>>>> + * =C2=A0 foo.rbd =C2=A0 =C2=A0 =C2=A0- image metadata
>>>>> + * =C2=A0 foo.00000000
>>>>> + * =C2=A0 foo.00000001
>>>>> + * =C2=A0 ... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- data
>>>>> + */
>>>>> +
>>>>> +#define RBD_SUFFIX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ".rbd"
>>>>> +#define RBD_DIRECTORY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "rbd_direct=
ory"
>>>>> +
>>>>> +#define RBD_DEFAULT_OBJ_ORDER =C2=A022 =C2=A0 /* 4MB */
>>>>> +
>>>>> +#define RBD_MAX_OBJ_NAME_SIZE =C2=A096
>>>>> +#define RBD_MAX_SEG_NAME_SIZE =C2=A0128
>>>>> +
>>>>> +#define RBD_COMP_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>>>> +#define RBD_CRYPT_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
>>>>> +
>>>>> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>>\n=
";
>>>>> +static const char rbd_signature[] =3D "RBD";
>>>>> +static const char rbd_version[] =3D "001.001";
>>>>> +
>>>>> +struct rbd_obj_snap_ondisk {
>>>>> + =C2=A0 =C2=A0 =C2=A0 __le64 id;
>>>>> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;
>>>>> +} __attribute__((packed));
>>>>> +
>>>>> +struct rbd_obj_header_ondisk {
>>>>> + =C2=A0 =C2=A0 =C2=A0 char text[64];
>>>>> + =C2=A0 =C2=A0 =C2=A0 char signature[4];
>>>>> + =C2=A0 =C2=A0 =C2=A0 char version[8];
>>>>> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;
>>>>
>>>> Unaligned? Is the disk format fixed?
>>>
>>> This is a packed structure that represents the on disk format.
>>> Operations on it are being done only to read from the disk header or
>>> to write to the disk header.
>>
>> That's clear. But what exactly is the alignment of field 'image_size'?
>> Could there be implicit padding to mod 8 between 'version' and
>> 'image_size' with some compilers?
>
> Obviously it's not 64 bit aligned. As it's an on-disk header, I don't
> see alignment a real issue. As was said before, any operation on these
> fields have to go through endianity conversion anyway, and this
> structure should not be used directly. For such datastructures I'd
> rather have the fields ordered in some logical order than maintaining
> the alignment by ourselves. That's why we have that __attribute__
> packed in the end to let the compiler deal with those issues. Other
> compilers though have their own syntax for packed structures (but I do
> see other uses of this packed syntax in the qemu code).

Packed structures are OK, but the padding should be explicit to avoid
compiler problems.

Eventually the disk format is read into memory buffer and then aligned
fields should be also faster on all architectures, even on x86.

>>
>> If there were no other constraints, I'd either make the padding
>> explicit, or rearrange/resize fields so that the field alignment is
>> natural. Thus my question, can you change the disk format or are there
>> already some deployments?
>
> We can certainly make changes to the disk format at this point. I'm
> not very happy with those 3 __u8 in the middle, and they can probably
> be changed to a 32 bit flags field. We can get it 64 bit aligned too.

I hope my comments helped you to avoid possible problems in the
future. From purely QEMU code base point of view, any architecture
goes. Some architectures are faster to emulate, others are slower.

>>
>> Otherwise, I'd just add some warning comment so people don't try to
>> use clever pointer tricks which will crash on machines with enforced
>> alignment.
>>
> Any clever pointer tricks that'll work on one architecture will
> probably be wrong on another (different word
> size/alignment/endianity), so maybe crashing machines is a good
> indicator to bad implementation. We shouldn't try to hide the
> problems.
>
> Thanks,
> Yehuda
>
