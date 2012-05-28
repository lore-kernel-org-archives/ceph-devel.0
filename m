From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Mon, 28 May 2012 07:37:23 +0200 (CEST)
Message-ID: <84f4a25f-d293-4b38-a4cb-d4a49912e644@mailpro>
References: <4FC27913.7080504@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56672 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab2E1Fhp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 01:37:45 -0400
In-Reply-To: <4FC27913.7080504@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

I think filestore journal parallel works only with btrfs.
Other filesystem are writeahead.

if you write at 120MB/S, so your journal of 1GB is at 50% in 4sec.

So you got around 480MB each 4sec, does your disks can flush sequential=
ly these 480MB in less than 4sec ?
(do a small benchmark of your disk in local filesystem, without ceph)

If not, you can have spikes in your write stats if the journal.

simple schema if disks are not fast enough:

0-4sec
------
random write (first wave 480MB) --->journal

4-8sec
------
random write (second wave)---->journal---->write flush of first wave(48=
0MB) --->disks

8-12sec
-------
random write (thirst wave) blocked ---->journal---->write of second wav=
e-blocked---->write flush of first wave not yet finished(480MB) --->dis=
ks



good schema
-----------
0-4sec
------
random write (first wave 480MB) --->journal

4-8sec
------
random write (second wave)---->journal---->write flush of first wave(48=
0MB) --->disks

8-12sec
-------
random write (thirst wave)---->journal---->write of second wave(480MB) =
--->disks



So, with a bigger journal, you have more datas to write to disks, so yo=
u can write more datas sequentially in 1 flush.
4sec seem very low, you need to have 20-30sec between flush.

How many disks (7,2K) do you have by osd ?




----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>=
=20
Envoy=C3=A9: Dimanche 27 Mai 2012 20:57:23=20
Objet: Re: poor OSD performance using kernel 3.4=20

Am 27.05.2012 13:33, schrieb Alexandre DERUMIER:=20
>> how much time to flush from journal to disks ?=20
>>> I don't know how to measure this.=20
> Do an iostat, you must see timelapse of write inactivity on disk (dat=
as are written to journal) , then after a timelapse=20
> of write activity on disk.(data flushed from journal to disk)=20
No it always starts in parallel. Journal is set to 1GB. I've now moved=20
the journal to disk - so i can use iostat.=20

>>> As ceph starts to write to journal and=20
>>> disk in parallel=20
>=20
> this is strange, from doc:=20
> http://ceph.com/wiki/OSD_journal=20
>=20
> the journal mode should be write-ahead with xfs.=20
> So write to journal first then flush to disk each 30sec.=20
I'm not quite sure as:=20
http://ceph.com/wiki/Ceph.conf#filestore_journal_writeahead=20

says there are two options:=20
filestore journal writeahead=20
and=20
filestore journal parallel=20
but even=20
filestore journal writeahead =3D 1=20
filestore journal parallel =3D 0=20

results in a parallel start.=20

> maybe your tmpfs is too small, and flushs occurs at 50% of free space=
 on journal.=20
> If by exemple, your flush occurs each 1 or 2seconds, this can cause v=
ery slow write.=20
1GB? My 1Gbit/s LAN test connection can't handle more than about=20
120MB/s. So there's at least room for 8-10s.=20

;-(=20

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
