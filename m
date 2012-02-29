From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] rbd: fix module sysfs setup/teardown code
Date: Wed, 29 Feb 2012 12:25:47 -0800
Message-ID: <CAC-hyiHuEMghboE2adbfeFja3c3ffYAJ2UBiDG_GPagW-GKOhw@mail.gmail.com>
References: <4F4DA2DC.8010202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56651 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab2B2UZs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 15:25:48 -0500
Received: by bkcik5 with SMTP id ik5so2721950bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 12:25:47 -0800 (PST)
In-Reply-To: <4F4DA2DC.8010202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 8:00 PM, Alex Elder <elder@dreamhost.com> wrote=
:
>
> Once rbd_bus_type is registered, it allows an "add" operation via
> the /sys/bus/rbd/add bus attribute, and adding a new rbd device that
> way establishes a connection between the device and rbd_root_dev.
> But rbd_root_dev is not registered until after the rbd_bus_type
> registration is complete. =A0This could (in principle anyway) result
> in an invalid state.
>
> Since rbd_root_dev has no tie to rbd_bus_type we can reorder these
> two initializations and never be faced with this scenario.
>
> In addition, unregister the device in the event the bus registration
> fails at module init time.
>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 =A08 +++++---
> =A01 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bc539cd..b7c9af5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2560,19 +2560,21 @@ static int rbd_sysfs_init(void)
> =A0{
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 ret =3D bus_register(&rbd_bus_type);
> + =A0 =A0 =A0 ret =3D device_register(&rbd_root_dev);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> - =A0 =A0 =A0 ret =3D device_register(&rbd_root_dev);
> + =A0 =A0 =A0 ret =3D bus_register(&rbd_bus_type);
> + =A0 =A0 =A0 if (ret)

=46or consistency if (ret < 0) or change the previous one.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_unregister(&rbd_root_dev);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> =A0static void rbd_sysfs_cleanup(void)
> =A0{
> - =A0 =A0 =A0 device_unregister(&rbd_root_dev);
> =A0 =A0 =A0 =A0bus_unregister(&rbd_bus_type);
> + =A0 =A0 =A0 device_unregister(&rbd_root_dev);
> =A0}
>
> =A0int __init rbd_init(void)
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
