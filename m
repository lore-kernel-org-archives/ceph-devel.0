From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 7 Oct 2010 11:41:26 -0700
Message-ID: <AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>
References: <20100802194631.GA4923@chb-desktop>
	<alpine.LNX.2.00.1008030033550.2664@linmac>
	<20100803201407.GD1475@chb-desktop>
	<4CADD567.9010606@codemonkey.ws>
	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>
	<4CAE13BA.70707@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58800 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0JGSl2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 14:41:28 -0400
In-Reply-To: <4CAE13BA.70707@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, malc <av1474@comtv.ru>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

On Thu, Oct 7, 2010 at 11:38 AM, Anthony Liguori <anthony@codemonkey.ws=
> wrote:
> On 10/07/2010 01:08 PM, Yehuda Sadeh Weinraub wrote:
>>
>> On Thu, Oct 7, 2010 at 7:12 AM, Anthony Liguori<anthony@codemonkey.w=
s>
>> =A0wrote:
>>
>>>
>>> On 08/03/2010 03:14 PM, Christian Brunner wrote:
>>>
>>>>
>>>> +#include "qemu-common.h"
>>>> +#include "qemu-error.h"
>>>> +#include<sys/types.h>
>>>> +#include<stdbool.h>
>>>> +
>>>> +#include<qemu-common.h>
>>>>
>>>>
>>>
>>> This looks to be unnecessary. =A0Generally, system includes shouldn=
't be
>>> required so all of these should go away except rado/librados.h
>>>
>>
>> Removed.
>>
>>
>>>
>>>
>>>>
>>>> +
>>>> +#include "rbd_types.h"
>>>> +#include "module.h"
>>>> +#include "block_int.h"
>>>> +
>>>> +#include<stdio.h>
>>>> +#include<stdlib.h>
>>>> +#include<rados/librados.h>
>>>> +
>>>> +#include<signal.h>
>>>> +
>>>> +
>>>> +int eventfd(unsigned int initval, int flags);
>>>>
>>>>
>>>
>>> This is not quite right. =A0Depending on eventfd is curious but in =
the very
>>> least, you need to detect the presence of eventfd in configure and
>>> provide a
>>> wrapper that redefines it as necessary.
>>>
>>
>> Can fix that, though please see my later remarks.
>>
>>>>
>>>> +static int create_tmap_op(uint8_t op, const char *name, char
>>>> **tmap_desc)
>>>> +{
>>>> + =A0 =A0uint32_t len =3D strlen(name);
>>>> + =A0 =A0/* total_len =3D encoding op + name + empty buffer */
>>>> + =A0 =A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) +
>>>> sizeof(uint32_t);
>>>> + =A0 =A0char *desc =3D NULL;
>>>>
>>>>
>>>
>>> char is the wrong type to use here as it may be signed or unsigned.=
 =A0That
>>> can have weird effects with binary data when you're directly manipu=
lating
>>> it.
>>>
>>
>> Well, I can change it to uint8_t, so that it matches the op type, bu=
t
>> that'll require adding some other castings. In any case, you usually
>> get such a weird behavior when you cast to types of different sizes
>> and have the sign bit padded which is not the case in here.
>>
>>
>>>
>>>
>>>>
>>>> +
>>>> + =A0 =A0desc =3D qemu_malloc(total_len);
>>>> +
>>>> + =A0 =A0*tmap_desc =3D desc;
>>>> +
>>>> + =A0 =A0*desc =3D op;
>>>> + =A0 =A0desc++;
>>>> + =A0 =A0memcpy(desc,&len, sizeof(len));
>>>> + =A0 =A0desc +=3D sizeof(len);
>>>> + =A0 =A0memcpy(desc, name, len);
>>>> + =A0 =A0desc +=3D len;
>>>> + =A0 =A0len =3D 0;
>>>> + =A0 =A0memcpy(desc,&len, sizeof(len));
>>>> + =A0 =A0desc +=3D sizeof(len);
>>>>
>>>>
>>>
>>> Shouldn't endianness be a concern?
>>>
>>
>> Right. Fixed that.
>>
>>
>>>
>>>
>>>>
>>>> +
>>>> + =A0 =A0return desc - *tmap_desc;
>>>> +}
>>>> +
>>>> +static void free_tmap_op(char *tmap_desc)
>>>> +{
>>>> + =A0 =A0qemu_free(tmap_desc);
>>>> +}
>>>> +
>>>> +static int rbd_register_image(rados_pool_t pool, const char *name=
)
>>>> +{
>>>> + =A0 =A0char *tmap_desc;
>>>> + =A0 =A0const char *dir =3D RBD_DIRECTORY;
>>>> + =A0 =A0int ret;
>>>> +
>>>> + =A0 =A0ret =3D create_tmap_op(CEPH_OSD_TMAP_SET, name,&tmap_desc=
);
>>>> + =A0 =A0if (ret< =A0 =A00) {
>>>> + =A0 =A0 =A0 =A0return ret;
>>>> + =A0 =A0}
>>>> +
>>>> + =A0 =A0ret =3D rados_tmap_update(pool, dir, tmap_desc, ret);
>>>> + =A0 =A0free_tmap_op(tmap_desc);
>>>> +
>>>> + =A0 =A0return ret;
>>>> +}
>>>>
>>>>
>>>
>>> This ops are all synchronous? =A0IOW, rados_tmap_update() call bloc=
ks until
>>> the operation is completed?
>>>
>>
>> Yeah. And this is only called from the rbd_create() callback.
>>
>>
>>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0header_snap +=3D strlen(header_snap) + 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0if (header_snap> =A0 =A0end)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("bad header, snapsho=
t list broken");
>>>>
>>>>
>>>
>>> Missing curly braces here.
>>>
>>
>> Fixed.
>>
>>
>>>>
>>>> + =A0 =A0if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
>>>> + =A0 =A0 =A0 =A0error_report("Unknown image version %s", hbuf + 6=
8);
>>>> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
>>>> + =A0 =A0 =A0 =A0goto failed;
>>>> + =A0 =A0}
>>>> +
>>>> + =A0 =A0RbdHeader1 *header;
>>>>
>>>>
>>>>
>>>
>>> Don't mix variable definitions with code.
>>>
>>
>> Fixed.
>>
>>
>>>>
>>>> + =A0 =A0s->efd =3D eventfd(0, 0);
>>>> + =A0 =A0if (s->efd< =A0 =A00) {
>>>> + =A0 =A0 =A0 =A0error_report("error opening eventfd");
>>>> + =A0 =A0 =A0 =A0goto failed;
>>>> + =A0 =A0}
>>>> + =A0 =A0fcntl(s->efd, F_SETFL, O_NONBLOCK);
>>>> + =A0 =A0qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NU=
LL,
>>>> + =A0 =A0 =A0 =A0rbd_aio_flush_cb, NULL, s);
>>>>
>>>>
>>>
>>> It looks like you just use the eventfd to signal aio completion
>>> callbacks.
>>> =A0A better way to do this would be to schedule a bottom half. =A0e=
ventfds
>>> are
>>> Linux specific and specific to recent kernels.
>>>
>>
>> Digging back why we introduced the eventfd, it was due to some issue=
s
>> seen with do_savevm() hangs on qemu_aio_flush(). The reason seemed
>> that we had no fd associated with the block device, which seemed to
>> not work well with the qemu aio model. If that assumption is wrong,
>> we'd be happy to change it. In any case, there are other more portab=
le
>> ways to generate fds, so if it's needed we can do that.
>>
>
> There's no fd at all? =A0 How do you get notifications about an async=
hronous
> event completion?
>
> Regards,
>
> Anthony Liguori
>
(resending to list, sorry)

The fd is hidden deep under in librados. We get callback notifications
for events completion.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
