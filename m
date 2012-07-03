From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Tue, 03 Jul 2012 06:42:39 +0200 (CEST)
Message-ID: <3529047d-a3f7-442a-a384-5829686ff385@mailpro>
References: <4FF204DB.80709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:34132 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2GCEnD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 00:43:03 -0400
In-Reply-To: <4FF204DB.80709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

Stefan,

As fio benchmark use directio (--direct) , maybe the writeback cache is=
 not working ?

perfcounters should give us the answer.

----- Mail original -----=20

De: "Josh Durgin" <josh.durgin@inktank.com>=20
=C3=80: "Stefan Priebe" <s.priebe@profihost.ag>=20
Cc: "Gregory Farnum" <greg@inktank.com>, "Alexandre DERUMIER" <aderumie=
r@odiso.com>, "Sage Weil" <sage@inktank.com>, ceph-devel@vger.kernel.or=
g, "Mark Nelson" <mark.nelson@inktank.com>=20
Envoy=C3=A9: Lundi 2 Juillet 2012 22:30:19=20
Objet: Re: speedup ceph / scaling / find the bottleneck=20

On 07/02/2012 12:22 PM, Stefan Priebe wrote:=20
> Am 02.07.2012 18:51, schrieb Gregory Farnum:=20
>> On Sun, Jul 1, 2012 at 11:12 PM, Stefan Priebe - Profihost AG=20
>> <s.priebe@profihost.ag> wrote:=20
>>> @sage / mark=20
>>> How does the aggregation work? Does it work 4MB blockwise or target=
 node=20
>>> based?=20
>> Aggregation is based on the 4MB blocks, and if you've got caching=20
>> enabled then it's also not going to flush them out to disk very ofte=
n=20
>> if you're continuously updating the block =E2=80=94 I don't remember=
 all the=20
>> conditions, but essentially, you'll run into dirty limits and it wil=
l=20
>> asynchronously flush out the data based on a combination of how old =
it=20
>> is, and how long it's been since some version of it was stable on=20
>> disk.=20
> Is there any way to check if rbd caching works correctly? For me the =
I/O=20
> values do not change if i switch writeback on or of and it also doesn=
't=20
> matter how large i set the cache size.=20
>=20
> ...=20

If you add admin_socket=3D/path/to/admin_socket for your client running=
=20
qemu (in that client's ceph.conf section or manually in the qemu=20
command line) you can check that caching is enabled:=20

ceph --admin-daemon /path/to/admin_socket show config | grep rbd_cache=20

And see statistics it generates (look for cache) with:=20

ceph --admin-daemon /path/to/admin_socket perfcounters_dump=20

Josh=20

>>> Ceph:=20
>>> 2 VMs:=20
>>> write: io=3D2234MB, bw=3D25405KB/s, iops=3D6351, runt=3D 90041msec=20
>>> read : io=3D4760MB, bw=3D54156KB/s, iops=3D13538, runt=3D 90007msec=
=20
>>> write: io=3D56372MB, bw=3D638402KB/s, iops=3D155, runt=3D 90421msec=
=20
>>> read : io=3D86572MB, bw=3D981225KB/s, iops=3D239, runt=3D 90346msec=
=20
>>>=20
>>> write: io=3D2222MB, bw=3D25275KB/s, iops=3D6318, runt=3D 90011msec=20
>>> read : io=3D4747MB, bw=3D54000KB/s, iops=3D13500, runt=3D 90008msec=
=20
>>> write: io=3D55300MB, bw=3D626733KB/s, iops=3D153, runt=3D 90353msec=
=20
>>> read : io=3D84992MB, bw=3D965283KB/s, iops=3D235, runt=3D 90162msec=
=20
>>=20
>> I can't quite tell what's going on here, can you describe the test i=
n=20
>> more detail?=20
>=20
> I've network booted my VM and then run the following command:=20
> export DISK=3D/dev/vda; (fio --filename=3D$DISK --direct=3D1 --rw=3Dr=
andwrite=20
> --bs=3D4k --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporti=
ng=20
> --name=3Dfile1;fio --filename=3D$DISK --direct=3D1 --rw=3Drandread --=
bs=3D4k=20
> --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3D=
file1;fio=20
> --filename=3D$DISK --direct=3D1 --rw=3Dwrite --bs=3D4M --size=3D200G =
--numjobs=3D50=20
> --runtime=3D90 --group_reporting --name=3Dfile1;fio --filename=3D$DIS=
K=20
> --direct=3D1 --rw=3Dread --bs=3D4M --size=3D200G --numjobs=3D50 --run=
time=3D90=20
> --group_reporting --name=3Dfile1 )|egrep " read| write"=20
>=20
> - write random 4k I/O=20
> - read random 4k I/O=20
> - write seq 4M I/O=20
> - read seq 4M I/O=20
>=20
> Stefan=20




--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
