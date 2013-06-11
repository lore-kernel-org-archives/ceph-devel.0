From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as
 storage-backend
Date: Tue, 11 Jun 2013 13:51:40 +0200
Message-ID: <51B70F4C.5020902@filoo.de>
References: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:39651 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3FKLvo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 07:51:44 -0400
In-Reply-To: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, "qemu@nongnu.org" <qemu-devel@nongnu.org>

Hi Alexandre, Josh,

sorry for coming back so very late, I tried the patch and though I coul=
d=20
not get it to work properly - very likely my fault - how would it be to=
=20
integrate it into the rbd-handler of qemu?

Josh? I think you are CC'd from another qemu-ticket anyway?

I could just ignore the EOPNOTSUPP or whatever it's called, but a smoot=
h=20
integration of live-snapshots would be so cool ;)

Kind regards,

Oliver.

On 05/24/2013 05:37 PM, Alexandre DERUMIER wrote:
> Hi,
>
> For Proxmox, we have made some patchs to split the savevm process,
>
> to be able to save the memory to an external volume. (and not the cur=
rent volume).
>
> For rbd, we create a new rbd volume to store the memory.
>
> qemu patch is here :
> https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dblob;f=3Ddebian/pat=
ches/internal-snapshot-async.patch;h=3Dc67a97ea497fe31ff449acb79e04dc1c=
53b25578;hb=3DHEAD
>
> ----- Mail original -----
>
> De: "Wido den Hollander" <wido@42on.com>
> =C3=80: "Oliver Francke" <Oliver.Francke@filoo.de>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Vendredi 24 Mai 2013 17:08:35
> Objet: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd=
 as storage-backend
>
> On 05/24/2013 09:46 AM, Oliver Francke wrote:
>> Hi,
>>
>> with a running VM I encounter this strange behaviour, former
>> qemu-versions don't show up such an error.
>> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination
>> with ceph-0.56.6? Therefore my
>> crosspost.
>>
>> Even if I have no real live-snapshot avail - they know of this
>> restriction -, it's more work for the customers
>> to perform a shutdown before the wonna do some changes to their VM ;=
)
>>
> Doesn't Qemu try to save the memory state to RBD here as well? That
> doesn't work and fails.
>
>> Any hints welcome,
>>
>> Oliver.
>>
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=C3=9Fe 25a
33330 G=C3=BCtersloh
HRB4355 AG G=C3=BCtersloh

Gesch=C3=A4ftsf=C3=BChrer: S.Grewing | J.Rehp=C3=B6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
