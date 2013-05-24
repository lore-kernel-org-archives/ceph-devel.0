From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-backend
Date: Fri, 24 May 2013 17:37:53 +0200 (CEST)
Message-ID: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro>
References: <519F8273.1000307@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55909 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab3EXPiG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 11:38:06 -0400
In-Reply-To: <519F8273.1000307@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org, Oliver Francke <Oliver.Francke@filoo.de>

Hi,

=46or Proxmox, we have made some patchs to split the savevm process,

to be able to save the memory to an external volume. (and not the curre=
nt volume).

=46or rbd, we create a new rbd volume to store the memory.

qemu patch is here :=20
https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dblob;f=3Ddebian/patch=
es/internal-snapshot-async.patch;h=3Dc67a97ea497fe31ff449acb79e04dc1c53=
b25578;hb=3DHEAD

----- Mail original -----=20

De: "Wido den Hollander" <wido@42on.com>=20
=C3=80: "Oliver Francke" <Oliver.Francke@filoo.de>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 24 Mai 2013 17:08:35=20
Objet: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd a=
s storage-backend=20

On 05/24/2013 09:46 AM, Oliver Francke wrote:=20
> Hi,=20
>=20
> with a running VM I encounter this strange behaviour, former=20
> qemu-versions don't show up such an error.=20
> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination=20
> with ceph-0.56.6? Therefore my=20
> crosspost.=20
>=20
> Even if I have no real live-snapshot avail - they know of this=20
> restriction -, it's more work for the customers=20
> to perform a shutdown before the wonna do some changes to their VM ;)=
=20
>=20

Doesn't Qemu try to save the memory state to RBD here as well? That=20
doesn't work and fails.=20

> Any hints welcome,=20
>=20
> Oliver.=20
>=20


--=20
Wido den Hollander=20
42on B.V.=20

Phone: +31 (0)20 700 9902=20
Skype: contact42on=20
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
