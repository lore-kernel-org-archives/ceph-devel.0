From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 10:36:29 +0200 (CEST)
Message-ID: <1897614581.1694878.1433838989184.JavaMail.zimbra@oxygem.tv>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv> <CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com> <959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33611 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbFIIgb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 04:36:31 -0400
In-Reply-To: <959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pushpesh sharma <pushpesh.eck@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

It's seem that the limit is mainly going in high queue depth (+- > 16)

Here the result in iops with 1client- 4krandread- 3osd - with different=
s queue depth size.
rbd_cache is almost the same than without cache with queue depth <16


cache
-----
qd1: 1651
qd2: 3482
qd4: 7958
qd8: 17912
qd16: 36020
qd32: 42765
qd64: 46169

no cache
--------
qd1: 1748
qd2: 3570
qd4: 8356
qd8: 17732
qd16: 41396
qd32: 78633
qd64: 79063
qd128: 79550


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "pushpesh sharma" <pushpesh.eck@gmail.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@lists.ceph.com>
Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21
Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40=
k

Hi,=20

>> We tried adding more RBDs to single VM, but no luck.=20

If you want to scale with more disks in a single qemu vm, you need to u=
se iothread feature from qemu and assign 1 iothread by disk (works with=
 virtio-blk).=20
It's working for me, I can scale with adding more disks.=20


My bench here are done with fio-rbd on host.=20
I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a single =
host and around 250kiops 10clients-rbdcache=3Don.=20


I just wonder why I don't have performance decrease around 30k iops wit=
h 1osd.=20

I'm going to see if this tracker=20
http://tracker.ceph.com/issues/11056=20

could be the cause.=20

(My master build was done some week ago)=20



----- Mail original -----=20
De: "pushpesh sharma" <pushpesh.eck@gmail.com>=20
=C3=80: "aderumier" <aderumier@odiso.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@lists.ceph.com>=20
Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04=20
Objet: Re: rbd_cache, limiting read on high iops around 40k=20

Hi Alexandre,=20

We have also seen something very similar on Hammer(0.94-1). We were doi=
ng some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openstack-=
juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additional s=
torage. For some strange reason it was not able to scale 4K- RR iops on=
 each VM beyond 35-40k. We tried adding more RBDs to single VM, but no =
luck. However increasing number of VMs to 4 on a single hypervisor did =
scale to some extent. After this there was no much benefit we got from =
adding more VMs.=20

Here is the trend we have seen, x-axis is number of hypervisor, each hy=
pervisor has 4 VM, each VM has 1 RBD:-=20




VDbench is used as benchmarking tool. We were not saturating network an=
d CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors, =
and that is where we were suspecting of some throttling effect. However=
 we haven't setted any such limits from nova or kvm end. We tried some =
CPU pinning and other KVM related tuning as well, but no luck.=20

We tried the same experiment on a bare metal. It was 4K RR IOPs were sc=
aling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than scali=
ng beyond that point the numbers were actually degrading. (Single pipe =
more congestion effect)=20

We never suspected that rbd cache enable could be detrimental to perfor=
mance. It would nice to route cause the problem if that is the case.=20

On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER < aderumier@odiso.c=
om > wrote:=20


Hi,=20

I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D32,=
=20
and rbd_cache=3Dtrue seem to limit the iops around 40k=20


no cache=20
--------=20
1 client - rbd_cache=3Dfalse - 1osd : 38300 iops=20
1 client - rbd_cache=3Dfalse - 2osd : 69073 iops=20
1 client - rbd_cache=3Dfalse - 3osd : 78292 iops=20


cache=20
-----=20
1 client - rbd_cache=3Dtrue - 1osd : 38100 iops=20
1 client - rbd_cache=3Dtrue - 2osd : 42457 iops=20
1 client - rbd_cache=3Dtrue - 3osd : 45823 iops=20



Is it expected ?=20



fio result rbd_cache=3Dfalse 3 osd=20
--------------------------------=20
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Drbd, iodepth=3D32=20
fio-2.1.11=20
Starting 1 process=20
rbd engine: RBD version: 0.1.9=20
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0 i=
ops] [eta 00m:00s]=20
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: Tu=
e Jun 9 07:48:42 2015=20
read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698msec=20
slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77=20
clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82=20
lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49=20
clat percentiles (usec):=20
| 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 262],=
=20
| 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ 346=
],=20
| 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[ 506=
],=20
| 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[ 948=
],=20
| 99.99th=3D[ 1176]=20
bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.34,=
 stdev=3D25196.21=20
lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 1000=
=3D0.23%=20
lat (msec) : 2=3D0.03%, 4=3D0.01%=20
cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D12452=20
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D12=
=2E1%, >=3D64=3D0.0%=20
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0=
%, >=3D64=3D0.0%=20
complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D0.=
0%, >=3D64=3D0.0%=20
issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20

Run status group 0 (all jobs):=20
READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D31316=
9KB/s, mint=3D32698msec, maxt=3D32698msec=20

Disk stats (read/write):=20
dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%,=
 aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, a=
ggrutil=3D0.00%=20
sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.00%=20




fio result rbd_cache=3Dtrue 3osd=20
------------------------------=20

rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Drbd, iodepth=3D32=20
fio-2.1.11=20
Starting 1 process=20
rbd engine: RBD version: 0.1.9=20
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0 i=
ops] [eta 00m:00s]=20
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: Tu=
e Jun 9 07:47:30 2015=20
read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866msec=20
slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84=20
clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73=20
lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03=20
clat percentiles (usec):=20
| 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 350],=
=20
| 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ 506=
],=20
| 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[ 724=
],=20
| 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D[ 12=
88],=20
| 99.99th=3D[ 2192]=20
bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.10,=
 stdev=3D15079.93=20
lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=20
lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%=20
cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D14100=
=20
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D5=
=2E3%, >=3D64=3D0.0%=20
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0=
%, >=3D64=3D0.0%=20
complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20

Run status group 0 (all jobs):=20
READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D18329=
5KB/s, mint=3D55866msec, maxt=3D55866msec=20

Disk stats (read/write):=20
dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.01%,=
 aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, a=
ggrutil=3D0.01%=20
sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.01%=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20






--=20
-Pushpesh=20


_______________________________________________=20
ceph-users mailing list=20
ceph-users@lists.ceph.com=20
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
