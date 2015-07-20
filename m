From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 20 Jul 2015 07:03:16 +0200 (CEST)
Message-ID: <948271260.15531885.1437368596773.JavaMail.zimbra@oxygem.tv>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com> <758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com> <CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com> <1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com> <CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com> <694208947.37724099.1436812751415.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1507131140480.8878@cobra.newdream.net> <55A4184D.8020505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51742 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbbGTFDT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 01:03:19 -0400
In-Reply-To: <55A4184D.8020505@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Jason Dillaman <dillaman@redhat.com>, Milosz Tanski <milosz@adfin.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,=20
>>This was fixed a little while back when qemu was converted to using
>>coroutines and more than one thread, but it would make usage in other
>>applications with simpler threading models easier

AFAIK, currently qemu can use 1 thread by disk, with qemu iothread feat=
ure.
But this work with virtio-blk driver only (virtio-scsi not yet stable).
Can help to scale with multiple disk, but still limited with a single d=
isk workload.


(So, if the eventfd implementation could help to scale with a single di=
sk, it could a big speed up for qemu)


Alexandre



----- Mail original -----
De: "Josh Durgin" <jdurgin@redhat.com>
=C3=80: "Sage Weil" <sage@newdream.net>, "Jason Dillaman" <dillaman@red=
hat.com>
Cc: "Milosz Tanski" <milosz@adfin.com>, "Haomai Wang" <haomaiwang@gmail=
=2Ecom>, "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 13 Juillet 2015 21:58:05
Objet: Re: About Adding eventfd support for LibRBD

On 07/13/2015 11:42 AM, Sage Weil wrote:=20
> On Mon, 13 Jul 2015, Jason Dillaman wrote:=20
>>> But it doesn't provide an easily compassable way=20
>>> of integrating waiting on other events in the application. eventfd =
is=20
>>> easy to embed in your (e)pool loop or any kind of event library=20
>>> (libev).=20
>>=20
>> Agreed -- which is why I asked about the proposed design since it=20
>> appears (to me) that everything is hidden behind the librbd API and =
thus=20
>> not embeddable within a generic app event loop. It might just be a=20
>> misunderstanding on my part, which is why I asked for an example=20
>> integration.=20
>=20
> Bonus points if this helps out the qemu librbd usage, which (if memor=
y=20
> serves) does some annoying stuff with a pipe in the callback to notif=
y=20
> qemu of IO completion. Perhaps qemu can work with an eventfd more=20
> directly?=20

This was fixed a little while back when qemu was converted to using=20
coroutines and more than one thread, but it would make usage in other=20
applications with simpler threading models easier.=20

IIRC the xen blktap driver for rbd used the same pipe workaround to=20
deal with librbd's current callback api.=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
