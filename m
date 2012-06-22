From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: filestore flusher = false  , correct my problem of constant write (need info on this parameter)
Date: Fri, 22 Jun 2012 08:14:26 +0200 (CEST)
Message-ID: <1fa246cc-38d3-486d-bd55-1f809d229074@mailpro>
References: <Pine.LNX.4.64.1206210858400.17996@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52362 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2FVGOt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 02:14:49 -0400
In-Reply-To: <Pine.LNX.4.64.1206210858400.17996@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

Hi Sage,
thanks for your response.

>>If you turn off the journal compeletely, you will see bursty write co=
mmits=20
>>from the perspective of the client, because the OSD is periodically d=
oing=20
>>a sync or snapshot and only acking the writes then.=20
>>If you enable the journal, the OSD will reply with a commit as soon a=
s the=20
>>write is stable in the journal. That's one reason why it is there--fi=
le=20
>>system commits of heavyweight and slow.=20

Yes of course, I don't wan't to desactivate journal, using a journal on=
 a fast ssd or nvram is the right way.

>>If we left the file system to its own devices and did a sync every 10=
=20
>>seconds, the disk would sit idle while a bunch of dirty data accumula=
ted=20
>>in cache, and then the sync/snapshot would take a really long time. T=
his=20
>>is horribly inefficient (the disk is idle half the time), and useless=
 (the=20
>>delayed write behavior makes sense for local workloads, but not serve=
rs=20
>>where there is a client on the other end batching its writes). To pre=
vent=20
>>this, 'filestore flusher' will prod the kernel to flush out any writt=
en=20
>>data to the disk quickly. Then, when we get around to doing the=20
>>sync/snapshot it is pretty quick, because only fs metadata and=20
>>just-written data needs to be flushed.=20

mmm, I disagree.

If you flush quickly, it's works fine with sequential write workload.

But if you have a lot of random write with 4k block by exemple, you are=
 going to have a lot of disk seeks.
The way zfs works or netapp san storage works, they take random writes =
in a fast journal then flush them sequentially each 20s to slow storage=
=2E

To compare with zfs or netapp, I can achieve around 20000io/s on random=
 write 4K with 4GB nvram and 10 x 7200 disk.

with ceph, i'm around 2000io/s with same config. (3 nodes with 10x7200d=
isk, 2x replication), so around real disk io limit without any write ca=
che.


So for now, i'm think i'm going to use ssd for my osds,I have 80% rando=
m write workload. (no seeks, so no problem to constant random write)



NTW: maybe wiki is wrong
http://ceph.com/wiki/OSD_journal
section Motivation
"Enterprise products like NetApp filers "cheat" by journaling all write=
s to NVRAM and then taking their time to flush things out to disk effic=
iently. This gives you very low-latency writes _and_ efficient disk IO =
at the expense of hardware."

This why I thinked ceph worked like this.


Thanks again,

-Alexandre







----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>=
, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Jeudi 21 Juin 2012 18:03:45=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

Hi Alexandre,=20

[Sorry I didn't follow up earlier; I didn't understand your question.]=20

If you turn off the journal compeletely, you will see bursty write comm=
its=20
from the perspective of the client, because the OSD is periodically doi=
ng=20
a sync or snapshot and only acking the writes then.=20

If you enable the journal, the OSD will reply with a commit as soon as =
the=20
write is stable in the journal. That's one reason why it is there--file=
=20
system commits of heavyweight and slow.=20

If we left the file system to its own devices and did a sync every 10=20
seconds, the disk would sit idle while a bunch of dirty data accumulate=
d=20
in cache, and then the sync/snapshot would take a really long time. Thi=
s=20
is horribly inefficient (the disk is idle half the time), and useless (=
the=20
delayed write behavior makes sense for local workloads, but not servers=
=20
where there is a client on the other end batching its writes). To preve=
nt=20
this, 'filestore flusher' will prod the kernel to flush out any written=
=20
data to the disk quickly. Then, when we get around to doing the=20
sync/snapshot it is pretty quick, because only fs metadata and=20
just-written data needs to be flushed.=20

So: the behavior you're seeing is normal, and good.=20

Did I understand your confusion correctly?=20

Thanks!=20
sage=20


On Wed, 20 Jun 2012, Alexandre DERUMIER wrote:=20

> Hi,=20
> I have tried to disabe filestore flusher=20
>=20
> filestore flusher =3D false=20
> filestore max sync interval =3D 30=20
> filestore min sync interval =3D 29=20
>=20
>=20
> in osd config.=20
>=20
>=20
> now, I see correct sync each 30s when doing rados bench=20
>=20
> rados -p pool3 bench 60 write -t 16=20
>=20
>=20
> seekwatcher movie:=20
>=20
>=20
> before=20
> ------=20
> http://odisoweb1.odiso.net/seqwrite-radosbench-flusherenable.mpg=20
>=20
> after=20
> -----=20
> http://odisoweb1.odiso.net/seqwrite-radosbench-flusherdisable.mpg=20
>=20
>=20
> Shouldn't it be the normal behaviour ? What's exactly is filestore fl=
usher vs syncfs ?=20
>=20
>=20
>=20
> This seem to works fine with rados bench,=20
> But when I launch benchmark with fio from my guest vm, I see again co=
nstant write.=20
> (I'll try to debug that today)=20
>=20
>=20
> My target is to be able to handle small random write and write them e=
ach 30s.=20
>=20
> Regards,=20
>=20
> Alexandre=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



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
