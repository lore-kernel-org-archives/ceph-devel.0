From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 10:02:23 +0100
Message-ID: <509B751F.8000900@profihost.ag>
References: <97ae038a-a5ae-4df4-acf6-c87cb80020aa@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41964 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab2KHJCb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 04:02:31 -0500
In-Reply-To: <97ae038a-a5ae-4df4-acf6-c87cb80020aa@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 08.11.2012 09:58, schrieb Alexandre DERUMIER:
>>> What do you mean by that? I'm talking about the KVM guest not about=
 the
>>> ceph nodes.
>
> Do you have tried to compare virtio-blk and virtio-scsi ?
How to change? Right now i'm using the PVE defaults =3D> scsi-hd.

> Do you have tried directly from the host with the rbd kernel module ?
No don't know how to use ;-)

Stefan


> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>
> Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kern=
el.org
> Envoy=C3=A9: Jeudi 8 Novembre 2012 09:45:17
> Objet: Re: less cores more iops / speed
>
> Am 08.11.2012 01:59, schrieb Mark Nelson:
>> There's also the context switching overhead. It'd be interesting to
>> know how much the writer processes were shifting around on cores.
> What do you mean by that? I'm talking about the KVM guest not about t=
he
> ceph nodes.
>
>> Stefan, what tool were you using to do writes?
> as always: fio ;-)
>
> Stefan
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
