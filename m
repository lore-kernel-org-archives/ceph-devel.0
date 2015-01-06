From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: 10 times higher disk load with btrfs
Date: Tue, 6 Jan 2015 04:44:27 +0100 (CET)
Message-ID: <912779433.3244878.1420515867862.JavaMail.zimbra@oxygem.tv>
References: <54AAD9B5.5080207@profihost.ag> <54AAE3BF.9080908@profihost.ag> <alpine.DEB.2.00.1501051124430.5967@cobra.newdream.net> <54AAF1FA.9040709@profihost.ag> <54AAF40C.3060608@redhat.com> <54AAF512.10106@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33671 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbbAFDoa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 22:44:30 -0500
In-Reply-To: <713980925.3244877.1420515858378.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Stefan,

Do you see a difference if you force filestore journal writeahead for b=
trfs instead parrallel ?

filestore journal writeahead =3D 1
filestore journal parallel =3D 0

----- Mail original -----
De: "Stefan Priebe" <s.priebe@profihost.ag>
=C3=80: "Mark Nelson" <mnelson@redhat.com>, "Sage Weil" <sage@newdream.=
net>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 5 Janvier 2015 21:33:22
Objet: Re: 10 times higher disk load with btrfs

Am 05.01.2015 um 21:29 schrieb Mark Nelson:=20
>=20
>=20
> On 01/05/2015 02:20 PM, Stefan Priebe wrote:=20
>> Hi Sage,=20
>>=20
>> Am 05.01.2015 um 20:25 schrieb Sage Weil:=20
>>> On Mon, 5 Jan 2015, Stefan Priebe wrote:=20
>>>>=20
>>>> Am 05.01.2015 um 19:36 schrieb Stefan Priebe:=20
>>>>> Hi devs,=20
>>>>>=20
>>>>> while btrfs is now declared as stable ;-) i wanted to retest btrf=
s on=20
>>>>> our production cluster on 2 out of 54 osds. So if they crash it=20
>>>>> doesn't=20
>>>>> hurt.=20
>>>>>=20
>>>>> While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The=
 same=20
>>>>> OSDs after formatting them with btrfs have spikes of 190MB/s ever=
y=20
>>>>> 4-7s.=20
>>>>>=20
>>>>> Why does just another filesystem raises the disk load by a factor=
 of=20
>>>>> 10?=20
>>>>=20
>>>> OK this seems to happen cause ceph is creating every 5s a new=20
>>>> subvolume /=20
>>>> snap. Is this really expected / needed?=20
>>>=20
>>> You can disable it with=20
>>>=20
>>> filestore btrfs snap =3D false=20
>>>=20
>>> I'm curious how much this drops the load down; originally the=20
>>> snaps were no more expensive than a regular sync but perhaps this=20
>>> has changed...=20
>>=20
>> - with XFS the average write is at 9Mb/s=20
>> - with btrfs (filestore_btrfs_snap=3Dtrue) write is at 40Mb/s=20
>> - with btrfs (filestore_btrfs_snap=3Dfalse) write is at 20Mb/s=20
>=20
> Is that the average and not the spikes? It looks like before the spik=
es=20
> were 20MB/s and 190MB/s?=20

Yes these are average values.=20

Spikes:=20
- with XFS the spike write is at 20Mb/s=20
- with btrfs (filestore_btrfs_snap=3Dtrue) spike write is 200Mb/s=20
- with btrfs (filestore_btrfs_snap=3Dfalse) spike is still 185Mb/s but =
avg=20
is 1/2 (20Mb/s) see above=20


>=20
>>=20
>> Stefan=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
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
