From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: FIXED:  11/5/2014 Weekly Ceph Performance Meeting IS ON!
Date: Wed, 05 Nov 2014 16:49:31 +0100 (CET)
Message-ID: <cd5658cf-5ec8-4a63-a119-9ae768a2bd34@mailpro>
References: <5458F57B.5070208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57798 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbaKEPti convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 10:49:38 -0500
In-Reply-To: <5458F57B.5070208@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark,

I'm not available for today (Next week I'll finally have a microphone ;=
)

But Here my progress about client side performance


qemu scaling
------------

I'm finally able to scale inside 1 guest vm with iothreads + krbd + vir=
tio disks
I can reach now 90000iops in 1 guest vm (30000 iops by iothread)


-object iothread,id=3Diothread0 -object iothread,id=3Diothread1 -object=
 iothread,id=3Diothread2
-device virtio-blk-pci,....,iothread=3Diothread0 -drive file=3D/dev/rbd=
/test/test
-device virtio-blk-pci,....,iothread=3Diothread1 -drive file=3D/dev/rbd=
/test/test
-device virtio-blk-pci,....,iothread=3Diothread2 -drive file=3D/dev/rbd=
/test/test

Currently It's not possible to bind multiple iothread on 1 virtio disk,
but you can define multiple virtio disk with same rbd volume,
and do some multipathing inside the guest vm.

I think qemu plan to implement multiqueue + multi iothread for same dis=
k next year


krbd vs lirbd cpu usage
------------------------
Not to much progress,

but fio-librbd or qemu-librbd, I see around 3-4x more cpu usage with li=
brbd.
That's really a bottleneck in qemu, I can't reach more than 25000iops w=
ith same iothread config.

I have some perf reports for analysis if someone would help.



Regards,

Alexandre




----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 4 Novembre 2014 16:49:15=20
Objet: FIXED: 11/5/2014 Weekly Ceph Performance Meeting IS ON!=20

Hi All,=20

Got the date wrong the first time. 11/5/2014 is correct! 8AM PST as=20
usual. We are going to try a little experiment and leave the Agenda=20
blank for you guys to fill in. If you are planning on attending and hav=
e=20
something you want to discuss, please add it!=20

We've also added a projects and backlog section at the top of the=20
etherpad for on-going efforts and the folks that are working on them.=20
=46or any projects or names of people we've missed, please update!=20

Here's the links:=20

Etherpad URL:=20
http://pad.ceph.com/p/performance_weekly=20

To join the Meeting:=20
https://bluejeans.com/268261044=20

To join via Browser:=20
https://bluejeans.com/268261044/browser=20

To join with Lync:=20
https://bluejeans.com/268261044/lync=20


To join via Room System:=20
Video Conferencing System: bjn.vc -or- 199.48.152.152=20
Meeting ID: 268261044=20

To join via Phone:=20
1) Dial:=20
+1 408 740 7256=20
+1 888 240 2560(US Toll Free)=20
+1 408 317 9253(Alternate Number)=20
(see all numbers - http://bluejeans.com/numbers)=20
2) Enter Conference ID: 268261044=20

Mark=20
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
