From: Christian Brunner <chb@muc.de>
Subject: Fwd: [Qemu-devel] [PATCH] block/rbd: Remove unused local variable
Date: Mon, 23 May 2011 20:57:52 +0200
Message-ID: <BANLkTikstu9ULcreDOOqspK=1_1BcHQjXw@mail.gmail.com>
References: <1304799357-19281-1-git-send-email-weil@mail.berlios.de>
	<4DD8FC9D.3090200@mail.berlios.de>
	<BANLkTimP0C2Tesxwbai+8ofjdLGbN521cQ@mail.gmail.com>
	<4DDA3646.404@redhat.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38828 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab1EWS5x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 14:57:53 -0400
Received: by vxi39 with SMTP id 39so4332686vxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 11:57:52 -0700 (PDT)
In-Reply-To: <4DDA3646.404@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Josh,

I don't know if you followed this thread on the qemu list. I would
sugest, that you resend the current patchset. I will review it and
send an ack afterwards.

Please feel free to add your name to the header and the copyright.

Regards,
Christian

---------- Forwarded message ----------
=46rom: Kevin Wolf <kwolf@redhat.com>
Date: 2011/5/23
Subject: Re: [Qemu-devel] [PATCH] block/rbd: Remove unused local variab=
le
To: chb@muc.de
Cc: QEMU Developers <qemu-devel@nongnu.org>


Am 23.05.2011 11:01, schrieb Christian Brunner:
> 2011/5/22 Stefan Weil <weil@mail.berlios.de>:
>> Am 07.05.2011 22:15, schrieb Stefan Weil:
>>>
>>> cppcheck report:
>>> rbd.c:246: style: Variable 'snap' is assigned a value that is never=
 used
>>>
>>> Remove snap and the related code.
>>>
>>> Cc: Christian Brunner<chb@muc.de>
>>> Cc: Kevin Wolf<kwolf@redhat.com>
>>> Signed-off-by: Stefan Weil<weil@mail.berlios.de>
>>> ---
>>> =A0block/rbd.c | =A0 =A04 ----
>>> =A01 files changed, 0 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/rbd.c b/block/rbd.c
>>> index 249a590..5c7d44e 100644
>>> --- a/block/rbd.c
>>> +++ b/block/rbd.c
>>> @@ -524,7 +524,6 @@ static int rbd_open(BlockDriverState *bs, const=
 char
>>> *filename, int flags)
>>> =A0 =A0 =A0RbdHeader1 *header;
>>> =A0 =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
>>> =A0 =A0 =A0char snap_buf[RBD_MAX_SEG_NAME_SIZE];
>>> - =A0 =A0char *snap =3D NULL;
>>> =A0 =A0 =A0char *hbuf =3D NULL;
>>> =A0 =A0 =A0int r;
>>>
>>> @@ -533,9 +532,6 @@ static int rbd_open(BlockDriverState *bs, const=
 char
>>> *filename, int flags)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->name, sizeof(s->n=
ame))< =A00) {
>>> =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> =A0 =A0 =A0}
>>> - =A0 =A0if (snap_buf[0] !=3D '\0') {
>>> - =A0 =A0 =A0 =A0snap =3D snap_buf;
>>> - =A0 =A0}
>>>
>>> =A0 =A0 =A0if ((r =3D rados_initialize(0, NULL))< =A00) {
>>> =A0 =A0 =A0 =A0 =A0error_report("error initializing");
>>>
>>
>> What about this patch? Can it be applied to the block branch?
>>
>> Regards,
>> Stefan W.
>
> No objections on my side. You can add:
>
> Reviewed-by: Christian Brunner <chb@muc.de>
>
> The questions is how we continue with the rbd driver. Recent ceph
> versions had some changes in librados that are incompatible with the
> current driver. We have to options now:
>
> 1. Change the function calls for new librados versions (I could
> provide a patch for this).
> 2. Use librbd (see Josh's patches).
>
> Using librbd simplifies the qemu driver a lot and gives us consistenc=
y
> with the kernel driver. - I would prefer this. (Please note that ther=
e
> is a race condition in the current librbd versions, that crashes qemu
> under high i/o load, but I'm fairly confident, that Josh will have
> sorted this out by the time 0.15 is released).

The problem with Josh's patches (or basically anything related to the
rbd driver) is that it hasn't received any review. I'm not familiar wit=
h
librados and librbd, so reviewing rbd is even harder than other patches
of the same size for me. Additionally, it's not a test environment that
I have set up.

So going forward with it, I think we need a separate rbd maintainer. So
Christian, I think it would be helpful if you at least reviewed any rbd
patch and either comment on it or send an Acked-by, which basically
tells me to commit it without any further checks. Or maybe we should
consider that you send pull requests yourself if the patches touch only
rbd code.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
