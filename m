From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-backend
Date: Fri, 24 May 2013 22:57:24 +0200
Message-ID: <38D2560F-4164-47DE-973F-2C1BD97EAD3A@filoo.de>
References: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:42413 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab3EXU5a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 16:57:30 -0400
In-Reply-To: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

Hi Alexandre,

Am 24.05.2013 um 17:37 schrieb Alexandre DERUMIER <aderumier@odiso.com>=
:

> Hi,
>=20
> For Proxmox, we have made some patchs to split the savevm process,
>=20
> to be able to save the memory to an external volume. (and not the cur=
rent volume).
>=20
> For rbd, we create a new rbd volume to store the memory.
>=20
> qemu patch is here :
> https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dblob;f=3Ddebian/pat=
ches/internal-snapshot-async.patch;h=3Dc67a97ea497fe31ff449acb79e04dc1c=
53b25578;hb=3DHEAD
>=20
> ----- Mail original -----
>=20

wow, sounds very interesting, being on the road for the next 3 days I w=
ill have a closer look next week.

Thnx n regards,

Oliver.

> De: "Wido den Hollander" <wido@42on.com>
> =C0: "Oliver Francke" <Oliver.Francke@filoo.de>
> Cc: ceph-devel@vger.kernel.org
> Envoy=E9: Vendredi 24 Mai 2013 17:08:35
> Objet: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd=
 as storage-backend
>=20
> On 05/24/2013 09:46 AM, Oliver Francke wrote:
>> Hi,
>>=20
>> with a running VM I encounter this strange behaviour, former
>> qemu-versions don't show up such an error.
>> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination
>> with ceph-0.56.6? Therefore my
>> crosspost.
>>=20
>> Even if I have no real live-snapshot avail - they know of this
>> restriction -, it's more work for the customers
>> to perform a shutdown before the wonna do some changes to their VM ;=
)
>>=20
>=20
> Doesn't Qemu try to save the memory state to RBD here as well? That
> doesn't work and fails.
>=20
>> Any hints welcome,
>>=20
>> Oliver.
>>=20
>=20
>=20
> --
> Wido den Hollander
> 42on B.V.
>=20
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
