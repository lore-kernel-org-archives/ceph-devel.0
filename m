From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and
 vm_stop is hanging forever
Date: Mon, 9 Nov 2015 14:43:26 +0100
Message-ID: <5640A2FE.6070402@profihost.ag>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
 <5640490B.5030700@parallels.com> <564049BA.1090805@parallels.com>
 <253899541.6094258.1447066125770.JavaMail.zimbra@oxygem.tv>
 <1119051619.7201094.1447076562035.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:28916 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbKINna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 08:43:30 -0500
In-Reply-To: <1119051619.7201094.1447076562035.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, jdurgin@redhat.com


> ----- Original Message -----
>> From: "Alexandre DERUMIER" <aderumier@odiso.com>
>> To: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Cc: "qemu-devel" <qemu-devel@nongnu.org>, jdurgin@redhat.com
>> Sent: Monday, November 9, 2015 5:48:45 AM
>> Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot =
and vm_stop is hanging forever
>>
>> adding to ceph.conf
>>
>> [client]
>>         rbd_non_blocking_aio =3D false
>>
>>
>> fix the problem for me (with rbd_cache=3Dfalse)
>>
>>
>> (@cc jdurgin@redhat.com)

+1 same to me.

Stefan

>>
>>
>>
>> ----- Mail original -----
>> De: "Denis V. Lunev" <den-lists@parallels.com>
>> =C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel"
>> <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel@nongnu.org>
>> Envoy=C3=A9: Lundi 9 Novembre 2015 08:22:34
>> Objet: Re: [Qemu-devel] qemu : rbd block driver internal snapshot an=
d vm_stop
>> is hanging forever
>>
>> On 11/09/2015 10:19 AM, Denis V. Lunev wrote:
>>> On 11/09/2015 06:10 AM, Alexandre DERUMIER wrote:
>>>> Hi,
>>>>
>>>> with qemu (2.4.1), if I do an internal snapshot of an rbd device,
>>>> then I pause the vm with vm_stop,
>>>>
>>>> the qemu process is hanging forever
>>>>
>>>>
>>>> monitor commands to reproduce:
>>>>
>>>>
>>>> # snapshot_blkdev_internal drive-virtio0 yoursnapname
>>>> # stop
>>>>
>>>>
>>>>
>>>>
>>>> I don't see this with qcow2 or sheepdog block driver for example.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Alexandre
>>>>
>>> this could look like the problem I have recenty trying to
>>> fix with dataplane enabled. Patch series is named as
>>>
>>> [PATCH for 2.5 v6 0/10] dataplane snapshot fixes
>>>
>>> Den
>>
>> anyway, even if above will not help, can you collect gdb
>> traces from all threads in QEMU process. May be I'll be
>> able to give a hit.
>>
>> Den
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
