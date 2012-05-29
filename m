From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 11:46:58 +0200
Message-ID: <4FC49B12.8020004@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46354 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab2E2JrA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 05:47:00 -0400
In-Reply-To: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

It would be really nice if somebody from inktank can comment this whole
sitation.

Thanks!

Stefan

Am 29.05.2012 05:54, schrieb Alexandre DERUMIER:
>>> This happens with ext4 or btrfs too.=20
>=20
> maybe this is related to io scheduler ?
>=20
> did you have compared cfq,deadline,noop scheduler ?
>=20
> noop should be fast with ssd.
>=20
>=20
> also what's is your sas/sata controller  ?
>=20
> ----- Mail original -----=20
>=20
> De: "Stefan Priebe" <s.priebe@profihost.ag>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.co=
m>=20
> Envoy=C3=A9: Lundi 28 Mai 2012 21:48:34=20
> Objet: Re: poor OSD performance using kernel 3.4=20
>=20
> Am 28.05.2012 08:52, schrieb Alexandre DERUMIER:=20
>>> I think filestore journal parallel works only with btrfs.=20
>>> Other filesystem are writeahead.=20
>>>> ... you might be right but i can't change ceph's implementation.=20
>>
>> See my schema,=20
>> I think you see parallel writes, because you see flush write of firs=
t wave to disk, in the same time=20
>> of second wave write to journal.=20
> Yes i fulll=C3=BD understand and agree - but still this should at lea=
st=20
> result in a constant bandwidth near max of underlying disk.=20
>=20
>>>> I totally aggree with you but this is just a test setup AND if you=
 have=20
>>>> a big log file to copy let's say 100GB your journal will never be =
big=20
>>>> enough and the speed should never drop to 0MB/s. Also i see the co=
rrect=20
>>>> behaviour with 3.0.X where the speed is maxed to the underlying de=
vice.=20
>>>> So i still see no reason that with 3.4 the speed drops to 0MB/s an=
d is=20
>>>> mostly 10-20MB/s instead of 130MB/s.=20
>>
>> Maybe something is wrong with 3.4, then your disk write more slowly.=
 (xfs bug, sata driver controller bug, ...)=20
>=20
> This happens with ext4 or btrfs too.=20
>=20
> Squential write speed to FS is exactly the same under 3.0 and 3.4 usi=
ng=20
> oflag=3Ddirect.=20
>=20
> 3.4:=20
> 10000+0 records in=20
> 10000+0 records out=20
> 10485760000 bytes (10 GB) copied, 41,4899 s, 253 MB/s=20
>=20
> 3.0:=20
> 10000+0 records in=20
> 10000+0 records out=20
> 10485760000 bytes (10 GB) copied, 40,861 s, 257 MB/s=20
>=20
>> maybe some local benchmark of your ssd with 3.4 can give some tips ?=
=20
>=20
>>>> How many disks (7,2K) do you have by osd ?=20
>>>>> One intel 520 SSD per OSD.=20
>>
>> I see some benchmark on internet about 150-300MB/s (depend of the bl=
ocksize).=20
> bench OSD shows around 260MB/s=20
>=20
> ceph osd tell X bench shows me a speed of 260MB/s under both kernels=20
> which corresponds to the dd from above.=20
>=20
>> Something must be wrong, Doing local benchmark can really help I thi=
nk.=20
>> You can use sysbench-tools=20
>> https://github.com/tsuna/sysbench-tools=20
>> It make bench compare with nice graphs.=20
> Thx hopefully i'll find something.=20
>=20
> Stefan=20
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
