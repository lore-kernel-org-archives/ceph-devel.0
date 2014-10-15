From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting
Date: Wed, 15 Oct 2014 16:42:04 +0200 (CEST)
Message-ID: <ebe5a51e-2219-41ef-b918-6307b9ff3549@mailpro>
References: <543E75FC.7010509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:34858 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaJOOmR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 10:42:17 -0400
In-Reply-To: <543E75FC.7010509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

>>Sure! Please feel free to add this or other topics that are=20
>>useful/interesting to the etherpad. Please include your name though s=
o=20
>>we know who's brought it up. Even if we don't get to everything it wi=
ll=20
>>provide useful topics for the subsequent weeks.=20

Ok,great,I'll do it.

>=20
> Currently I see 2 performance problems with librbd:=20
>=20
> 1) The cpu usage is quite huge. (I'm cpu bound with 8cores CPU E5-260=
3 v2 @ 1.80GHz, with 40000iops 4k read using fio-rbd)=20

>>Interesting. Have you taken a look with perf or other tools to see=20
>>where time is being spent?=20

Not yet, but I can try to do it, I'll have time next week.



>=20
> 2) in qemu, it's impossible to reach more than around 7000iops with 1=
 disk. (maybe is it also related to cpu or threads number).=20
> I have also try with the new qemu iothread/dataplane feature, but it =
doesn't help.=20

>>1 disk meaning 1 OSD, or 1 disk meaning 1 volume on a VM?=20
yes, 1 disk =3D 1 volume on VM

>>If its 1 volume, does adding another volume on the same VM help?=20

As far I remember, yes . I'll test again to confirm.

Note that when benching with fio-rbd, I need to increase the client num=
ber too.

(1client - queue depth 32: +- 8000iops
 2clients - queue depth 32: +- 16000iops=20
  ....
)
So maybe it's related



>>I'm not familiar with the new qemu options, so that would be good to =
discuss at=20
the meeting too!=20

The dataplane/iothread feature allow virtio disk to reach around 1.000.=
000 iops vs 100.000 iops without dataplane
http://www.linux-kvm.org/wiki/images/1/17/Kvm-forum-2013-Effective-mult=
ithreading-in-QEMU.pdf

Syntax to enable it:
   qemu -object iothread,id=3Diothread0 -device virtio-blk-pci,iothread=
=3Diothread0,....



Regards,

Alexandre

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

Sure! Please feel free to add this or other topics that are=20
useful/interesting to the etherpad. Please include your name though so=20
we know who's brought it up. Even if we don't get to everything it will=
=20
provide useful topics for the subsequent weeks.=20

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
