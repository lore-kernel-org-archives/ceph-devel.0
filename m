From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: puzzled with the design pattern of ceph journal, really ruining performance
Date: Wed, 17 Sep 2014 16:20:44 +0200 (CEST)
Message-ID: <872acc52-387a-4ca1-bd43-a3825a2746cc@mailpro>
References: <6F3FA899187F0043BA1827A69DA2F7CC020BCBAE@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45812 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbaIQOUx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 10:20:53 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC020BCBAE@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <xiaoxi.chen@intel.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ?? <zay11022@gmail.com>, ceph-devel@vger.kernel.org

>>2. Have you got any data to prove the O_DSYNC or fdatasync  kill the =
performance of journal?   In our previous test, the journal SSD (use a =
partition of a SSD as a journal for a particular OSD, and 4 OSD share a=
 >>same SSD) could reach its peak performance (300-400MB/s)

Hi,

I have done some bench here:

http://www.mail-archive.com/ceph-users@lists.ceph.com/msg12950.html

Some ssd models have really bad performance with O_DSYNC (crucial m550 =
- 312 iops on 4k block).
Benching 1 osd,I can see big latencies for some seconds when O_DSYNC oc=
cur



crucial m550
------------
#fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --numjob=
s=3D2=20
--group_reporting --invalidate=3D0 --name=3Dab --sync=3D1
bw=3D1249.9KB/s, iops=3D312

intel s3500
-----------
fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --numjobs=
=3D2=20
--group_reporting --invalidate=3D0 --name=3Dab --sync=3D1
#bw=3D41794KB/s, iops=3D10448

----- Mail original -----=20

De: "Xiaoxi Chen" <xiaoxi.chen@intel.com>=20
=C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>, "??" <zay11022@gmail.c=
om>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 17 Septembre 2014 09:59:37=20
Objet: RE: puzzled with the design pattern of ceph journal, really ruin=
ing performance=20

Hi Nicheal,=20

1. The main purpose of journal is provide transaction semantics (preven=
t partially update). Peer is not enough for this need because ceph writ=
es all replica at the same time, so when crush, you have no idea about =
which replica has right data. For example, say if we have 2 replica, us=
er update a 4M object and the primary OSD crush when the first 2M was w=
ritten , secondary OSD may also failed when the first 3MB was written. =
So both versions in primary/secondary are neither the new value, nor th=
e old value, and have no way to recover. So share the same idea as data=
base, we need to have a journal to support transaction and prevent this=
 happen. For some backend support transaction, BTRFS as an instance, we=
 don't need a journal, we can write the journal and data disk at the sa=
me time, the journal here is just try to help performance, since it onl=
y do sequential write and we suspect it should be faster than backend O=
SD.=20

2. Have you got any data to prove the O_DSYNC or fdatasync kill the per=
formance of journal? In our previous test, the journal SSD (use a parti=
tion of a SSD as a journal for a particular OSD, and 4 OSD share a same=
 SSD) could reach its peak performance (300-400MB/s)=20

Xiaoxi=20



-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Somnath Roy=20
Sent: Wednesday, September 17, 2014 3:30 PM=20
To: =E5=A7=9A=E5=AE=81; ceph-devel@vger.kernel.org=20
Subject: RE: puzzled with the design pattern of ceph journal, really ru=
ining performance=20

Hi Nicheal,=20
Not only recovery , IMHO the main purpose of ceph journal is to support=
 transaction semantics since XFS doesn't have that. I guess it can't be=
 achieved with pg_log/pg_info.=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of ??=20
Sent: Tuesday, September 16, 2014 11:29 PM=20
To: ceph-devel@vger.kernel.org=20
Subject: puzzled with the design pattern of ceph journal, really ruinin=
g performance=20

Hi, guys=20

I analyze the architecture of the ceph souce code.=20

I know that, in order to keep journal atomic and consistent, the journa=
l write mode should be set with O_DSYNC or called fdatasync() system ca=
ll after every write operation. However, this kind of operation is real=
ly killing the performance as well as achieving high committing latency=
, even if SSD is used as journal disk. If the SSD has capacitor to keep=
 the data safe when the system crashes, we can set the mount option nob=
arrier or SSD itself will ignore the FLUSH REQUEST. So the performance =
would be better.=20

So can it be instead by other strategies?=20
As far as I am concerned, I think the most important part is pg_log and=
 pg_info. It will guides the crashed osd recovery its objects from the =
peers. Therefore, if we can keep pg_log at a consistent point, we can r=
ecovery data without journal. So can we just use an "undo"=20
strategy on pg_log and neglect ceph journal? It will save lots of bandw=
idth, and also based on the consistent pg_log epoch, we can always reco=
very data from its peering osd, right? But this will lead to recovery m=
ore objects if the osd crash.=20

Nicheal=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

N r y b X =C7=A7v ^ )=DE=BA{.n + z ]z {ay =CA=87=DA=99 ,j f h z w j:+v =
w j m zZ+ =DD=A2j" ! i=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
