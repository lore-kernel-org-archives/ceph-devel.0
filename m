From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: qemu-1.7.0 and internal snapshot, Was: qemu-1.5.0 savevm error -95
 while writing vm with ceph-rbd as storage-backend
Date: Tue, 17 Dec 2013 17:07:46 +0100
Message-ID: <52B076D2.5090303@filoo.de>
References: <59e8e229-4b48-4272-993a-3040c5d5c76b@mailpro> <38D2560F-4164-47DE-973F-2C1BD97EAD3A@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:40233 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3LQQHs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 11:07:48 -0500
In-Reply-To: <38D2560F-4164-47DE-973F-2C1BD97EAD3A@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

Hi Alexandre and Wido ;)

well, I know this is a pretty old question... but saw some comments fro=
m=20
you Wido as well as a most current patch for qemu-1.7.0 in the=20
git.proxmox ( internal snapshot async port to qemu 1.7 v5)
What I currently did is: apply modify-query-machines.patch and=20
internal-snapshot-async.patch to qemu-1.7.0 sources, all hunks succeed.

Now after talking to the QMP with:

     { "execute" : "savevm-start", "arguments": { "statefile":=20
"rbd:123/905.save1" }}

or a local file, it spits out:

     qemu-system-x86_64: block.c:4430: bdrv_set_in_use: Assertion=20
`bs->in_use !=3D in_use' failed

*sigh*

qemu is started with "some" parameters... and finally drive-specific on=
es:

-device virtio-blk-pci,drive=3Dvirtio0 -drive=20
format=3Draw,file=3Drbd:123/vm-905-disk-.rbd:rbd_cache=3Dtrue:rbd_cache=
_size=3D33554432:rbd_cache_max_dirty=3D16777216:rbd_cache_target_dirty=3D=
8388608,cache=3Dwriteback,if=3Dnone,id=3Dvirtio0,media=3Ddisk,index=3D0

Did I miss a relevant point?
What would be the correct strategy?

Thnx in advance and kind regards,

Oliver.

P.S.: I don't use libvirt nor proxmox as a complete system.

On 05/24/2013 10:57 PM, Oliver Francke wrote:
> Hi Alexandre,
>
> Am 24.05.2013 um 17:37 schrieb Alexandre DERUMIER <aderumier@odiso.co=
m>:
>
>> Hi,
>>
>> For Proxmox, we have made some patchs to split the savevm process,
>>
>> to be able to save the memory to an external volume. (and not the cu=
rrent volume).
>>
>> For rbd, we create a new rbd volume to store the memory.
>>
>> qemu patch is here :
>> https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dblob;f=3Ddebian/pa=
tches/internal-snapshot-async.patch;h=3Dc67a97ea497fe31ff449acb79e04dc1=
c53b25578;hb=3DHEAD
>>
>> ----- Mail original -----
>>
> wow, sounds very interesting, being on the road for the next 3 days I=
 will have a closer look next week.
>
> Thnx n regards,
>
> Oliver.
>
>> De: "Wido den Hollander" <wido@42on.com>
>> =C0: "Oliver Francke" <Oliver.Francke@filoo.de>
>> Cc: ceph-devel@vger.kernel.org
>> Envoy=E9: Vendredi 24 Mai 2013 17:08:35
>> Objet: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rb=
d as storage-backend
>>
>> On 05/24/2013 09:46 AM, Oliver Francke wrote:
>>> Hi,
>>>
>>> with a running VM I encounter this strange behaviour, former
>>> qemu-versions don't show up such an error.
>>> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combinatio=
n
>>> with ceph-0.56.6? Therefore my
>>> crosspost.
>>>
>>> Even if I have no real live-snapshot avail - they know of this
>>> restriction -, it's more work for the customers
>>> to perform a shutdown before the wonna do some changes to their VM =
;)
>>>
>> Doesn't Qemu try to save the memory state to RBD here as well? That
>> doesn't work and fails.
>>
>>> Any hints welcome,
>>>
>>> Oliver.
>>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
