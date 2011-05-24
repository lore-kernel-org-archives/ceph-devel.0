From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Fwd: [Qemu-devel] [PATCH] block/rbd: Remove unused local variable
Date: Tue, 24 May 2011 09:03:10 -0700
Message-ID: <2c3c177203328f9dbbb1fc1fc63f53e8@hq.newdream.net>
References: <1304799357-19281-1-git-send-email-weil@mail.berlios.de>
 <4DD8FC9D.3090200@mail.berlios.de>
 <BANLkTimP0C2Tesxwbai+8ofjdLGbN521cQ@mail.gmail.com>
 <4DDA3646.404@redhat.com>
 <BANLkTikstu9ULcreDOOqspK=1_1BcHQjXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:43233 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab1EXQDv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 12:03:51 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id BC54618436D
	for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 09:03:50 -0700 (PDT)
In-Reply-To: <BANLkTikstu9ULcreDOOqspK=1_1BcHQjXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Mon, 23 May 2011 20:57:52 +0200, Christian Brunner <chb@muc.de>
wrote:
> Hi Josh,
>=20
> I don't know if you followed this thread on the qemu list. I would
> sugest, that you resend the current patchset. I will review it and
> send an ack afterwards.
>=20
> Please feel free to add your name to the header and the copyright.
>=20
> Regards,
> Christian

Hi Christian,

Thanks for pointing this out. I'll resend later today.

Josh

> ---------- Forwarded message ----------
> From: Kevin Wolf <kwolf@redhat.com>
> Date: 2011/5/23
> Subject: Re: [Qemu-devel] [PATCH] block/rbd: Remove unused local vari=
able
> To: chb@muc.de
> Cc: QEMU Developers <qemu-devel@nongnu.org>
>=20
>=20
> Am 23.05.2011 11:01, schrieb Christian Brunner:
>> 2011/5/22 Stefan Weil <weil@mail.berlios.de>:
>>> Am 07.05.2011 22:15, schrieb Stefan Weil:
>>>>
>>>> cppcheck report:
>>>> rbd.c:246: style: Variable 'snap' is assigned a value that is neve=
r used
>>>>
>>>> Remove snap and the related code.
>>>>
>>>> Cc: Christian Brunner<chb@muc.de>
>>>> Cc: Kevin Wolf<kwolf@redhat.com>
>>>> Signed-off-by: Stefan Weil<weil@mail.berlios.de>
>>>> ---
>>>> =C2=A0block/rbd.c | =C2=A0 =C2=A04 ----
>>>> =C2=A01 files changed, 0 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/rbd.c b/block/rbd.c
>>>> index 249a590..5c7d44e 100644
>>>> --- a/block/rbd.c
>>>> +++ b/block/rbd.c
>>>> @@ -524,7 +524,6 @@ static int rbd_open(BlockDriverState *bs, cons=
t char
>>>> *filename, int flags)
>>>> =C2=A0 =C2=A0 =C2=A0RbdHeader1 *header;
>>>> =C2=A0 =C2=A0 =C2=A0char pool[RBD_MAX_SEG_NAME_SIZE];
>>>> =C2=A0 =C2=A0 =C2=A0char snap_buf[RBD_MAX_SEG_NAME_SIZE];
>>>> - =C2=A0 =C2=A0char *snap =3D NULL;
>>>> =C2=A0 =C2=A0 =C2=A0char *hbuf =3D NULL;
>>>> =C2=A0 =C2=A0 =C2=A0int r;
>>>>
>>>> @@ -533,9 +532,6 @@ static int rbd_open(BlockDriverState *bs, cons=
t char
>>>> *filename, int flags)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s->name, sizeof(s->name))< =C2=A00) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>>>> =C2=A0 =C2=A0 =C2=A0}
>>>> - =C2=A0 =C2=A0if (snap_buf[0] !=3D '\0') {
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0snap =3D snap_buf;
>>>> - =C2=A0 =C2=A0}
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0if ((r =3D rados_initialize(0, NULL))< =C2=A00=
) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report("error initializing=
");
>>>>
>>>
>>> What about this patch? Can it be applied to the block branch?
>>>
>>> Regards,
>>> Stefan W.
>>
>> No objections on my side. You can add:
>>
>> Reviewed-by: Christian Brunner <chb@muc.de>
>>
>> The questions is how we continue with the rbd driver. Recent ceph
>> versions had some changes in librados that are incompatible with the
>> current driver. We have to options now:
>>
>> 1. Change the function calls for new librados versions (I could
>> provide a patch for this).
>> 2. Use librbd (see Josh's patches).
>>
>> Using librbd simplifies the qemu driver a lot and gives us consisten=
cy
>> with the kernel driver. - I would prefer this. (Please note that the=
re
>> is a race condition in the current librbd versions, that crashes qem=
u
>> under high i/o load, but I'm fairly confident, that Josh will have
>> sorted this out by the time 0.15 is released).
>=20
> The problem with Josh's patches (or basically anything related to the
> rbd driver) is that it hasn't received any review. I'm not familiar w=
ith
> librados and librbd, so reviewing rbd is even harder than other patch=
es
> of the same size for me. Additionally, it's not a test environment th=
at
> I have set up.
>=20
> So going forward with it, I think we need a separate rbd maintainer. =
So
> Christian, I think it would be helpful if you at least reviewed any r=
bd
> patch and either comment on it or send an Acked-by, which basically
> tells me to commit it without any further checks. Or maybe we should
> consider that you send pull requests yourself if the patches touch on=
ly
> rbd code.
>=20
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
