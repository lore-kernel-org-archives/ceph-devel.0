From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 14:02:48 +0200 (CEST)
Message-ID: <1208111516.1790161.1433851367996.JavaMail.zimbra@oxygem.tv>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv> <CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com> <959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv> <1897614581.1694878.1433838989184.JavaMail.zimbra@oxygem.tv> <5576CFBF.1070405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56843 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbFIMCu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 08:02:50 -0400
In-Reply-To: <5576CFBF.1070405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: pushpesh sharma <pushpesh.eck@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

>>Frankly, I'm a little impressed that without RBD cache we can hit 80K=
=20
>>IOPS from 1 VM!

Note that theses result are not in a vm (fio-rbd on host), so in a vm w=
e'll have overhead.
(I'm planning to send results in qemu soon)

>>How fast are the SSDs in those 3 OSDs?=20

Theses results are with datas in buffer memory of osd nodes.

When reading fulling on ssd (intel s3500),

=46or 1 client,=20

I'm around 33k iops without cache and 32k iops with cache, with 1 osd.
I'm around 55k iops without cache and 38k iops with cache, with 3 osd.

with multiple clients jobs, I can reach around 70kiops by osd , and 250=
k iops by osd when datas are in buffer.

(cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)



small tip :=20
I'm using tcmalloc for fio-rbd or rados bench to improve latencies by a=
round 20%

LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...
LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...

as a lot of time is spent in malloc/free=20


(qemu support also tcmalloc since some months , I'll bench it too
  https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html)



I'll try to send full bench results soon, from 1 to 18 ssd osd.




----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "pushpesh sharma" <pushpesh.=
eck@gmail.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@lists.ceph.com>
Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31
Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40=
k

Hi All,=20

In the past we've hit some performance issues with RBD cache that we've=
=20
fixed, but we've never really tried pushing a single VM beyond 40+K rea=
d=20
IOPS in testing (or at least I never have). I suspect there's a couple=20
of possibilities as to why it might be slower, but perhaps joshd can=20
chime in as he's more familiar with what that code looks like.=20

=46rankly, I'm a little impressed that without RBD cache we can hit 80K=
=20
IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?=20

Mark=20

On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:=20
> It's seem that the limit is mainly going in high queue depth (+- > 16=
)=20
>=20
> Here the result in iops with 1client- 4krandread- 3osd - with differe=
nts queue depth size.=20
> rbd_cache is almost the same than without cache with queue depth <16=20
>=20
>=20
> cache=20
> -----=20
> qd1: 1651=20
> qd2: 3482=20
> qd4: 7958=20
> qd8: 17912=20
> qd16: 36020=20
> qd32: 42765=20
> qd64: 46169=20
>=20
> no cache=20
> --------=20
> qd1: 1748=20
> qd2: 3570=20
> qd4: 8356=20
> qd8: 17732=20
> qd16: 41396=20
> qd32: 78633=20
> qd64: 79063=20
> qd128: 79550=20
>=20
>=20
> ----- Mail original -----=20
> De: "aderumier" <aderumier@odiso.com>=20
> =C3=80: "pushpesh sharma" <pushpesh.eck@gmail.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>=20
> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21=20
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around =
40k=20
>=20
> Hi,=20
>=20
>>> We tried adding more RBDs to single VM, but no luck.=20
>=20
> If you want to scale with more disks in a single qemu vm, you need to=
 use iothread feature from qemu and assign 1 iothread by disk (works wi=
th virtio-blk).=20
> It's working for me, I can scale with adding more disks.=20
>=20
>=20
> My bench here are done with fio-rbd on host.=20
> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a singl=
e host and around 250kiops 10clients-rbdcache=3Don.=20
>=20
>=20
> I just wonder why I don't have performance decrease around 30k iops w=
ith 1osd.=20
>=20
> I'm going to see if this tracker=20
> http://tracker.ceph.com/issues/11056=20
>=20
> could be the cause.=20
>=20
> (My master build was done some week ago)=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "pushpesh sharma" <pushpesh.eck@gmail.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>=20
> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04=20
> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>=20
> Hi Alexandre,=20
>=20
> We have also seen something very similar on Hammer(0.94-1). We were d=
oing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openstac=
k-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additional=
 storage. For some strange reason it was not able to scale 4K- RR iops =
on each VM beyond 35-40k. We tried adding more RBDs to single VM, but n=
o luck. However increasing number of VMs to 4 on a single hypervisor di=
d scale to some extent. After this there was no much benefit we got fro=
m adding more VMs.=20
>=20
> Here is the trend we have seen, x-axis is number of hypervisor, each =
hypervisor has 4 VM, each VM has 1 RBD:-=20
>=20
>=20
>=20
>=20
> VDbench is used as benchmarking tool. We were not saturating network =
and CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors=
, and that is where we were suspecting of some throttling effect. Howev=
er we haven't setted any such limits from nova or kvm end. We tried som=
e CPU pinning and other KVM related tuning as well, but no luck.=20
>=20
> We tried the same experiment on a bare metal. It was 4K RR IOPs were =
scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than sca=
ling beyond that point the numbers were actually degrading. (Single pip=
e more congestion effect)=20
>=20
> We never suspected that rbd cache enable could be detrimental to perf=
ormance. It would nice to route cause the problem if that is the case.=20
>=20
> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER < aderumier@odiso=
=2Ecom > wrote:=20
>=20
>=20
> Hi,=20
>=20
> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D3=
2,=20
> and rbd_cache=3Dtrue seem to limit the iops around 40k=20
>=20
>=20
> no cache=20
> --------=20
> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops=20
> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops=20
> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops=20
>=20
>=20
> cache=20
> -----=20
> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops=20
> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops=20
> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops=20
>=20
>=20
>=20
> Is it expected ?=20
>=20
>=20
>=20
> fio result rbd_cache=3Dfalse 3 osd=20
> --------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Drbd, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> rbd engine: RBD version: 0.1.9=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: =
Tue Jun 9 07:48:42 2015=20
> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698msec=
=20
> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77=20
> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82=20
> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 262=
],=20
> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ 3=
46],=20
> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[ 5=
06],=20
> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[ 9=
48],=20
> | 99.99th=3D[ 1176]=20
> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.3=
4, stdev=3D25196.21=20
> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 10=
00=3D0.23%=20
> lat (msec) : 2=3D0.03%, 4=3D0.01%=20
> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D1245=
2=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D=
12.1%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D313=
169KB/s, mint=3D32698msec, maxt=3D32698msec=20
>=20
> Disk stats (read/write):=20
> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00=
%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0,=
 aggrutil=3D0.00%=20
> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.00=
%=20
>=20
>=20
>=20
>=20
> fio result rbd_cache=3Dtrue 3osd=20
> ------------------------------=20
>=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Drbd, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> rbd engine: RBD version: 0.1.9=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: =
Tue Jun 9 07:47:30 2015=20
> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866msec=
=20
> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84=20
> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73=20
> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 350=
],=20
> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ 5=
06],=20
> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[ 7=
24],=20
> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D[ =
1288],=20
> | 99.99th=3D[ 2192]=20
> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.1=
0, stdev=3D15079.93=20
> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=20
> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%=20
> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D141=
00=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D=
5.3%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D183=
295KB/s, mint=3D55866msec, maxt=3D55866msec=20
>=20
> Disk stats (read/write):=20
> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.01=
%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8,=
 aggrutil=3D0.01%=20
> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.01=
%=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
