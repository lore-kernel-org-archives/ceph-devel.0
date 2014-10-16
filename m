From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting
Date: Thu, 16 Oct 2014 08:25:25 +0200 (CEST)
Message-ID: <811a14ba-31af-49d2-bd37-841ebadbca23@mailpro>
References: <6F3FA899187F0043BA1827A69DA2F7CC020C8323@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50512 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaJPGZf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 02:25:35 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC020C8323@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <xiaoxi.chen@intel.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

>>We also find this before, seems it's because QEMU use single thread f=
or IO, I tried to enable the debug log of in librbd, find that the thre=
aded is always the same. Assuming the backend is power enough, so how >=
>many IOs can be sent out by qemu =3D=3D how many IOPS can we get.
>>
>>The upper bound may varies depends on how fast QEMU can send out a re=
quest,  I remember we have tried different CPU model and get best with =
an very old NHM CPU(with high frequency to 2.93Ghz, take ~0.03 to send =
>>out a request and we get 22K read IOPS bound), better than new SNB CP=
U. Frequency do play important part since it's single thread.

Hi, indeed qemu use a single thread per queue.
I think it's not a problem with common storage (nfs,scsi,..) because th=
ey use less cpu ressource than librbd, so you can reach easily > 100000=
iops with 1thread.


Now, the good new, virtio-scsi support multiqueue , with num_queues opt=
ion.
I have done bench with num_queues, and now I can finally reach 50000iop=
s with a single qemu disk-> rbd volume  :)

If you use libvirt, here the config:
http://www.redhat.com/archives/libvir-list/2013-April/msg00021.html






Now, about fio-rbd cpu usage, something is really strange,

fio (rbd engine) on qemu host : 40000iops - 8 cores 100%
fio (aio) inside qemu with virtio-scsi + num_queues : 50000 iops - arou=
nd 4 cores 100%

So, maybe something is bad in fio-rbd implementation ?

I need to bench again to be sure about this, I'll send results in some =
days.



----- Mail original -----=20

De: "Xiaoxi Chen" <xiaoxi.chen@intel.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Mark Nelson" <mark=
=2Enelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 16 Octobre 2014 05:27:13=20
Objet: RE: 10/14/2014 Weekly Ceph Performance Meeting=20

We also find this before, seems it's because QEMU use single thread for=
 IO, I tried to enable the debug log of in librbd, find that the thread=
ed is always the same. Assuming the backend is power enough, so how man=
y IOs can be sent out by qemu =3D=3D how many IOPS can we get.=20

The upper bound may varies depends on how fast QEMU can send out a requ=
est, I remember we have tried different CPU model and get best with an =
very old NHM CPU(with high frequency to 2.93Ghz, take ~0.03 to send out=
 a request and we get 22K read IOPS bound), better than new SNB CPU. Fr=
equency do play important part since it's single thread.=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Wednesday, October 15, 2014 11:55 PM=20
To: Mark Nelson=20
Cc: ceph-devel@vger.kernel.org=20
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting=20

> 2) in qemu, it's impossible to reach more than around 7000iops with 1=
 disk. (maybe is it also related to cpu or threads number).=20
> I have also try with the new qemu iothread/dataplane feature, but it =
doesn't help.=20
>>If its 1 volume, does adding another volume on the same VM help?=20

>>>As far I remember, yes . I'll test again to confirm.=20

I have done test, It's scaling with multiple virtio disk on multiple rb=
d volume.=20

(Not sure, but maybe it's related to iodepth bug showed in this meeting=
 in intel slides ?)=20


----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 15 Octobre 2014 16:42:04=20
Objet: Re: 10/14/2014 Weekly Ceph Performance Meeting=20

>>Sure! Please feel free to add this or other topics that are=20
>>useful/interesting to the etherpad. Please include your name though s=
o=20
>>we know who's brought it up. Even if we don't get to everything it=20
>>will provide useful topics for the subsequent weeks.=20

Ok,great,I'll do it.=20

>=20
> Currently I see 2 performance problems with librbd:=20
>=20
> 1) The cpu usage is quite huge. (I'm cpu bound with 8cores CPU E5-260=
3=20
> v2 @ 1.80GHz, with 40000iops 4k read using fio-rbd)=20

>>Interesting. Have you taken a look with perf or other tools to see=20
>>where time is being spent?=20

Not yet, but I can try to do it, I'll have time next week.=20



>=20
> 2) in qemu, it's impossible to reach more than around 7000iops with 1=
 disk. (maybe is it also related to cpu or threads number).=20
> I have also try with the new qemu iothread/dataplane feature, but it =
doesn't help.=20

>>1 disk meaning 1 OSD, or 1 disk meaning 1 volume on a VM?=20
yes, 1 disk =3D 1 volume on VM=20

>>If its 1 volume, does adding another volume on the same VM help?=20

As far I remember, yes . I'll test again to confirm.=20

Note that when benching with fio-rbd, I need to increase the client num=
ber too.=20

(1client - queue depth 32: +- 8000iops=20
2clients - queue depth 32: +- 16000iops ....=20
)=20
So maybe it's related=20



>>I'm not familiar with the new qemu options, so that would be good to=20
>>discuss at=20
the meeting too!=20

The dataplane/iothread feature allow virtio disk to reach around 1.000.=
000 iops vs 100.000 iops without dataplane http://www.linux-kvm.org/wik=
i/images/1/17/Kvm-forum-2013-Effective-multithreading-in-QEMU.pdf=20

Syntax to enable it:=20
qemu -object iothread,id=3Diothread0 -device virtio-blk-pci,iothread=3D=
iothread0,....=20



Regards,=20

Alexandre=20

----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Mark Nelson" <mark=
=2Enelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 15 Octobre 2014 15:26:20=20
Objet: Re: 10/14/2014 Weekly Ceph Performance Meeting=20

On 10/15/2014 01:22 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> about performance, maybe could it be great to also include client sid=
e performance ?=20

Sure! Please feel free to add this or other topics that are useful/inte=
resting to the etherpad. Please include your name though so we know who=
's brought it up. Even if we don't get to everything it will provide us=
eful topics for the subsequent weeks.=20

>=20
> Currently I see 2 performance problems with librbd:=20
>=20
> 1) The cpu usage is quite huge. (I'm cpu bound with 8cores CPU E5-260=
3 v2 @ 1.80GHz, with 40000iops 4k read using fio-rbd)=20

Interesting. Have you taken a look with perf or other tools to see=20
where time is being spent?=20

>=20
> 2) in qemu, it's impossible to reach more than around 7000iops with 1=
 disk. (maybe is it also related to cpu or threads number).=20
> I have also try with the new qemu iothread/dataplane feature, but it =
doesn't help.=20

1 disk meaning 1 OSD, or 1 disk meaning 1 volume on a VM? If its 1=20
volume, does adding another volume on the same VM help? I'm not=20
familiar with the new qemu options, so that would be good to discuss at=
=20
the meeting too!=20

>=20
>=20
>=20
>=20
>=20
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
