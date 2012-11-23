From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 11:47:12 +0100 (CET)
Message-ID: <c164551e-fb3d-4d4d-a750-33c032328fdb@mailpro>
References: <50AF5073.8070006@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47306 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab2KWKro convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 05:47:44 -0500
In-Reply-To: <50AF5073.8070006@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>

>>when i switch the journal to the OSD Disk seperate partiton on each d=
isk=20
>>(/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from 23.0=
00=20
>>iops to 200 iops random 4k.=20
O_o , that's seem crazy...
Are you sure that your partitions are correctly aligned ? (starting fir=
st partition at sector 2048 is best for ssd)


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER" <ader=
umier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Mark Kamp=
e" <mark.kampe@inktank.com>=20
Envoy=C3=A9: Vendredi 23 Novembre 2012 11:31:15=20
Objet: Re: RBD fio Performance concerns=20

Hi,=20

when i switch the journal to the OSD Disk seperate partiton on each dis=
k=20
(/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from 23.000=
=20
iops to 200 iops random 4k.=20

Greets,=20
Stefan=20
Am 22.11.2012 13:50, schrieb S=C3=A9bastien Han:=20
>> journal is running on tmpfs to me but that changes nothing.=20
>=20
> I don't think it works then. According to the doc: Enables using=20
> libaio for asynchronous writes to the journal. Requires journal dio=20
> set to true.=20
>=20
>=20
> On Thu, Nov 22, 2012 at 12:48 PM, Stefan Priebe - Profihost AG=20
> <s.priebe@profihost.ag> wrote:=20
>> Am 22.11.2012 11:49, schrieb S=C3=A9bastien Han:=20
>>=20
>>> @Alexandre: cool!=20
>>>=20
>>> @ Stefan: Full SSD cluster and 10G switches?=20
>>=20
>> Yes=20
>>=20
>>=20
>>> Couple of weeks ago I saw=20
>>> that you use journal aio, did you notice performance improvement wi=
th it?=20
>>=20
>> journal is running on tmpfs to me but that changes nothing.=20
>>=20
>> Stefan=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
