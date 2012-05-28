From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Mon, 28 May 2012 08:52:03 +0200 (CEST)
Message-ID: <d88e7ec1-2170-44e3-b90c-1d1e3453e5fc@mailpro>
References: <4FC31A54.4020306@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49821 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2E1GwZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 02:52:25 -0400
In-Reply-To: <4FC31A54.4020306@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

> I think filestore journal parallel works only with btrfs.=20
> Other filesystem are writeahead.=20
>>... you might be right but i can't change ceph's implementation.=20

See my schema,
I think you see parallel writes, because you see flush write of first w=
ave to disk, in the same time=20
of second wave write to journal.


>>I totally aggree with you but this is just a test setup AND if you ha=
ve=20
>>a big log file to copy let's say 100GB your journal will never be big=
=20
>>enough and the speed should never drop to 0MB/s. Also i see the corre=
ct=20
>>behaviour with 3.0.X where the speed is maxed to the underlying devic=
e.=20
>>So i still see no reason that with 3.4 the speed drops to 0MB/s and i=
s=20
>>mostly 10-20MB/s instead of 130MB/s.=20

Maybe something is wrong with 3.4, then your disk write more slowly. (x=
fs bug, sata driver controller bug, ...)
on my schema:
Enough slowly to have the third wave to block on the journal. (so 0MB/S=
)

maybe some local benchmark of your ssd with 3.4 can give some tips ?

>> How many disks (7,2K) do you have by osd ?=20
>>>One intel 520 SSD per OSD.=20

I see some benchmark on internet about 150-300MB/s (depend of the block=
size).

Something must be wrong, Doing local benchmark can really help I think.
You can use sysbench-tools
https://github.com/tsuna/sysbench-tools
It make bench compare with nice graphs.



----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>=
=20
Envoy=C3=A9: Lundi 28 Mai 2012 08:25:24=20
Objet: Re: poor OSD performance using kernel 3.4=20

Am 28.05.2012 07:37, schrieb Alexandre DERUMIER:=20
> I think filestore journal parallel works only with btrfs.=20
> Other filesystem are writeahead.=20
=2E.. you might be right but i can't change ceph's implementation.=20

> if you write at 120MB/S, so your journal of 1GB is at 50% in 4sec.=20
>=20
> So you got around 480MB each 4sec, does your disks can flush sequenti=
ally these 480MB in less than 4sec ?=20
> (do a small benchmark of your disk in local filesystem, without ceph)=
=20
>=20
> If not, you can have spikes in your write stats if the journal.=20
>=20
> simple schema if disks are not fast enough:=20
I totally aggree with you but this is just a test setup AND if you have=
=20
a big log file to copy let's say 100GB your journal will never be big=20
enough and the speed should never drop to 0MB/s. Also i see the correct=
=20
behaviour with 3.0.X where the speed is maxed to the underlying device.=
=20
So i still see no reason that with 3.4 the speed drops to 0MB/s and is=20
mostly 10-20MB/s instead of 130MB/s.=20

> How many disks (7,2K) do you have by osd ?=20
One intel 520 SSD per OSD.=20

Stefan=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
