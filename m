From: pushpesh sharma <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 12:51:04 +0530
Message-ID: <CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1619197756=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1684793881.1564583.1433829106394.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1619197756==
Content-Type: multipart/related; boundary=001a1140289cf56ba305181099da

--001a1140289cf56ba305181099da
Content-Type: multipart/alternative; boundary=001a1140289cf56ba005181099d9

--001a1140289cf56ba005181099d9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

We have also seen something very similar on Hammer(0.94-1). We were doing
some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openstack-juno).
Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additional storage. For
some strange reason it was not able to scale 4K- RR iops on each VM beyond
35-40k. We tried adding more RBDs to single VM, but no luck. However
increasing number of VMs to 4 on a single hypervisor did scale to some
extent. After this there was no much benefit we got from adding more VMs.

Here is the trend we have seen, x-axis is number of hypervisor, each
hypervisor has 4 VM, each VM has 1 RBD:-



=E2=80=8B
 VDbench is used as benchmarking tool. We were not saturating network and
CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors, and
that is where we were suspecting of some throttling effect. However  we
haven't setted any such limits from nova or kvm end. We tried some CPU
pinning and other KVM related tuning as well, but no luck.

We tried the same experiment on a bare metal. It was 4K RR IOPs were
scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than scaling
beyond that point the numbers were actually degrading. (Single pipe more
congestion effect)

We never suspected that rbd cache enable could be detrimental to
performance. It would nice to route cause the problem if that is the case.


On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi,
>
> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D32,
> and rbd_cache=3Dtrue seem to limit the iops around 40k
>
>
> no cache
> --------
> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops
> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops
> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops
>
>
> cache
> -----
> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops
> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops
> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops
>
>
>
> Is it expected ?
>
>
>
> fio result rbd_cache=3Dfalse 3 osd
> --------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> rbd engine: RBD version: 0.1.9
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: Tue =
Jun  9
> 07:48:42 2015
>   read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698msec
>     slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77
>     clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82
>      lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49
>     clat percentiles (usec):
>      |  1.00th=3D[  173],  5.00th=3D[  209], 10.00th=3D[  231], 20.00th=
=3D[  262],
>      | 30.00th=3D[  282], 40.00th=3D[  302], 50.00th=3D[  322], 60.00th=
=3D[  346],
>      | 70.00th=3D[  370], 80.00th=3D[  402], 90.00th=3D[  454], 95.00th=
=3D[  506],
>      | 99.00th=3D[  628], 99.50th=3D[  692], 99.90th=3D[  860], 99.95th=
=3D[  948],
>      | 99.99th=3D[ 1176]
>     bw (KB  /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.=
34,
> stdev=3D25196.21
>     lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 10=
00=3D0.23%
>     lat (msec) : 2=3D0.03%, 4=3D0.01%
>   cpu          : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=
=3D12452
>   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=
=3D12.1%,
> >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      issued    : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
>    READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D3131=
69KB/s,
> mint=3D32698msec, maxt=3D32698msec
>
> Disk stats (read/write):
>     dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00=
%,
> aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, aggr=
util=3D0.00%
>   sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.00%
>
>
>
>
> fio result rbd_cache=3Dtrue 3osd
> ------------------------------
>
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> rbd engine: RBD version: 0.1.9
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: Tue =
Jun  9
> 07:47:30 2015
>   read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866msec
>     slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84
>     clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73
>      lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03
>     clat percentiles (usec):
>      |  1.00th=3D[  227],  5.00th=3D[  274], 10.00th=3D[  306], 20.00th=
=3D[  350],
>      | 30.00th=3D[  390], 40.00th=3D[  430], 50.00th=3D[  470], 60.00th=
=3D[  506],
>      | 70.00th=3D[  548], 80.00th=3D[  596], 90.00th=3D[  660], 95.00th=
=3D[  724],
>      | 99.00th=3D[  844], 99.50th=3D[  908], 99.90th=3D[ 1112], 99.95th=
=3D[ 1288],
>      | 99.99th=3D[ 2192]
>     bw (KB  /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.=
10,
> stdev=3D15079.93
>     lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%
>     lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%
>   cpu          : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, min=
f=3D14100
>   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=
=3D5.3%,
> >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      issued    : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
>    READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D1832=
95KB/s,
> mint=3D55866msec, maxt=3D55866msec
>
> Disk stats (read/write):
>     dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.01=
%,
> aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, aggr=
util=3D0.01%
>   sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.01%
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
-Pushpesh

--001a1140289cf56ba005181099d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alexandre,<br><br>We have also seen something very simi=
lar on Hammer(0.94-1). We were doing some benchmarking for VMs hosted on hy=
pervisor (QEMU-KVM, openstack-juno). Each Ubuntu-VM has a RBD as root disk,=
 and 1 RBD as additional storage. For some strange reason it was not able t=
o scale 4K- RR iops on each VM beyond 35-40k. We tried adding more RBDs to =
single VM, but no luck. However increasing number of VMs to 4 on a single h=
ypervisor did scale to some extent. After this there was no much benefit we=
 got from adding more VMs. =C2=A0<br><br>Here is the trend we have seen, x-=
axis is number of hypervisor, each hypervisor has 4 VM, each VM has 1 RBD:-=
<br><br>=C2=A0 =C2=A0<br><img src=3D"cid:ii_iaoyxhet0_14dd715b9d525b42" wid=
th=3D"562" height=3D"320"><br>=E2=80=8B<div>=C2=A0VDbench is used as benchm=
arking tool. We were not saturating network and CPUs at OSD nodes. We were =
not able to saturate CPUs at hypervisors, and that is where we were suspect=
ing of some throttling effect. However =C2=A0we haven&#39;t setted any such=
 limits from nova or kvm end. We tried some CPU pinning and other KVM relat=
ed tuning as well, but no luck. =C2=A0</div><div><br></div><div>We tried th=
e same experiment on a bare metal. It was 4K RR IOPs were scaling from 40K(=
1 RBD) to 180K(4 RBDs). But after that rather than scaling beyond that poin=
t the numbers were actually degrading. (Single pipe more congestion effect)=
=C2=A0</div><div><br></div><div>We never suspected that rbd cache enable co=
uld be detrimental to performance. It would nice to route cause the problem=
 if that is the case.=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jun 9, 2015 at=
 11:21 AM, Alexandre DERUMIER <span dir=3D"ltr">&lt;<a href=3D"mailto:aderu=
mier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org" target=3D"_blank">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
I&#39;m doing benchmark (ceph master branch), with randread 4k qdepth=3D32,=
<br>
and rbd_cache=3Dtrue seem to limit the iops around 40k<br>
<br>
<br>
no cache<br>
--------<br>
1 client - rbd_cache=3Dfalse - 1osd : 38300 iops<br>
1 client - rbd_cache=3Dfalse - 2osd : 69073 iops<br>
1 client - rbd_cache=3Dfalse - 3osd : 78292 iops<br>
<br>
<br>
cache<br>
-----<br>
1 client - rbd_cache=3Dtrue - 1osd : 38100 iops<br>
1 client - rbd_cache=3Dtrue - 2osd : 42457 iops<br>
1 client - rbd_cache=3Dtrue - 3osd : 45823 iops<br>
<br>
<br>
<br>
Is it expected ?<br>
<br>
<br>
<br>
fio result rbd_cache=3Dfalse 3 osd<br>
--------------------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
rbd engine: RBD version: 0.1.9<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: Tue Ju=
n=C2=A0 9 07:48:42 2015<br>
=C2=A0 read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698mse=
c<br>
=C2=A0 =C2=A0 slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77<b=
r>
=C2=A0 =C2=A0 clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.8=
2<br>
=C2=A0 =C2=A0 =C2=A0lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=
=3D95.49<br>
=C2=A0 =C2=A0 clat percentiles (usec):<br>
=C2=A0 =C2=A0 =C2=A0|=C2=A0 1.00th=3D[=C2=A0 173],=C2=A0 5.00th=3D[=C2=A0 2=
09], 10.00th=3D[=C2=A0 231], 20.00th=3D[=C2=A0 262],<br>
=C2=A0 =C2=A0 =C2=A0| 30.00th=3D[=C2=A0 282], 40.00th=3D[=C2=A0 302], 50.00=
th=3D[=C2=A0 322], 60.00th=3D[=C2=A0 346],<br>
=C2=A0 =C2=A0 =C2=A0| 70.00th=3D[=C2=A0 370], 80.00th=3D[=C2=A0 402], 90.00=
th=3D[=C2=A0 454], 95.00th=3D[=C2=A0 506],<br>
=C2=A0 =C2=A0 =C2=A0| 99.00th=3D[=C2=A0 628], 99.50th=3D[=C2=A0 692], 99.90=
th=3D[=C2=A0 860], 99.95th=3D[=C2=A0 948],<br>
=C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ 1176]<br>
=C2=A0 =C2=A0 bw (KB=C2=A0 /s): min=3D238856, max=3D360448, per=3D100.00%, =
avg=3D313402.34, stdev=3D25196.21<br>
=C2=A0 =C2=A0 lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5=
.19%, 1000=3D0.23%<br>
=C2=A0 =C2=A0 lat (msec) : 2=3D0.03%, 4=3D0.01%<br>
=C2=A0 cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : usr=3D74.48%, sys=3D13.25%, =
ctx=3D703225, majf=3D0, minf=3D12452<br>
=C2=A0 IO depths=C2=A0 =C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=
=3D87.0%, 32=3D12.1%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0submit=C2=A0 =C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 1=
6=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0complete=C2=A0 : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.=
5%, 32=3D0.4%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0issued=C2=A0 =C2=A0 : total=3Dr=3D2560000/w=3D0/d=3D0, =
short=3Dr=3D0/w=3D0/d=3D0<br>
=C2=A0 =C2=A0 =C2=A0latency=C2=A0 =C2=A0: target=3D0, window=3D0, percentil=
e=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
=C2=A0 =C2=A0READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, max=
b=3D313169KB/s, mint=3D32698msec, maxt=3D32698msec<br>
<br>
Disk stats (read/write):<br>
=C2=A0 =C2=A0 dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, uti=
l=3D0.00%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=
=3D0, aggrutil=3D0.00%<br>
=C2=A0 sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%<br>
<br>
<br>
<br>
<br>
fio result rbd_cache=3Dtrue 3osd<br>
------------------------------<br>
<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
rbd engine: RBD version: 0.1.9<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: Tue Ju=
n=C2=A0 9 07:47:30 2015<br>
=C2=A0 read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866mse=
c<br>
=C2=A0 =C2=A0 slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84<b=
r>
=C2=A0 =C2=A0 clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143=
.73<br>
=C2=A0 =C2=A0 =C2=A0lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=
=3D146.03<br>
=C2=A0 =C2=A0 clat percentiles (usec):<br>
=C2=A0 =C2=A0 =C2=A0|=C2=A0 1.00th=3D[=C2=A0 227],=C2=A0 5.00th=3D[=C2=A0 2=
74], 10.00th=3D[=C2=A0 306], 20.00th=3D[=C2=A0 350],<br>
=C2=A0 =C2=A0 =C2=A0| 30.00th=3D[=C2=A0 390], 40.00th=3D[=C2=A0 430], 50.00=
th=3D[=C2=A0 470], 60.00th=3D[=C2=A0 506],<br>
=C2=A0 =C2=A0 =C2=A0| 70.00th=3D[=C2=A0 548], 80.00th=3D[=C2=A0 596], 90.00=
th=3D[=C2=A0 660], 95.00th=3D[=C2=A0 724],<br>
=C2=A0 =C2=A0 =C2=A0| 99.00th=3D[=C2=A0 844], 99.50th=3D[=C2=A0 908], 99.90=
th=3D[ 1112], 99.95th=3D[ 1288],<br>
=C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ 2192]<br>
=C2=A0 =C2=A0 bw (KB=C2=A0 /s): min=3D115280, max=3D204416, per=3D100.00%, =
avg=3D183315.10, stdev=3D15079.93<br>
=C2=A0 =C2=A0 lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D=
3.28%<br>
=C2=A0 =C2=A0 lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%<br>
=C2=A0 cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : usr=3D60.27%, sys=3D12.01%, =
ctx=3D2995393, majf=3D0, minf=3D14100<br>
=C2=A0 IO depths=C2=A0 =C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=
=3D81.0%, 32=3D5.3%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0submit=C2=A0 =C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 1=
6=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0complete=C2=A0 : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.=
0%, 32=3D4.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0issued=C2=A0 =C2=A0 : total=3Dr=3D2560000/w=3D0/d=3D0, =
short=3Dr=3D0/w=3D0/d=3D0<br>
=C2=A0 =C2=A0 =C2=A0latency=C2=A0 =C2=A0: target=3D0, window=3D0, percentil=
e=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
=C2=A0 =C2=A0READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, max=
b=3D183295KB/s, mint=3D55866msec, maxt=3D55866msec<br>
<br>
Disk stats (read/write):<br>
=C2=A0 =C2=A0 dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, uti=
l=3D0.01%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=
=3D8, aggrutil=3D0.01%<br>
=C2=A0 sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.0=
1%<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">-Pushpesh<br><br></div></div>
</div>

--001a1140289cf56ba005181099d9--

--001a1140289cf56ba305181099da
Content-Type: image/png; name="Scale.png"
Content-Disposition: inline; filename="Scale.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_iaoyxhet0_14dd715b9d525b42>
X-Attachment-Id: ii_iaoyxhet0_14dd715b9d525b42

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
HABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABY
idwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwF
DRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRih
NwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJl
MgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJl
cg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8d
HABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABY
idwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwF
HRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRih
NwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJl
MgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJl
cg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4d
HABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABY
idwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwF
DRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRih
NwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJl
MgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJl
cg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8d
HABYidwFHRihNwJlMgJlcg4dHABYidwFDRihNwJlMgJlcg8dHABYidwFHRihNwJlMgJlcg4dHABY
idwFDRihNwJlMgJlcg8dHABYKQW5q6O5KW/Z1hHZWA7dUroxQm8EymQEyuQcOjgAsFLDc5dIXfm0
NbJ1WcXJi24p1RihNwJlMgJlcg8dHABYqdG5S8Su5g65HglhZdAtpRsj9EagTEagTM6hgwMAKzU4
d3mPuJTcJV6WyF27d+8WX61v06ZNcg0A3NDS0sLzLheIWss1AIBFTMpdKrqldJMj9KJMjNCnGGUy
Qvi8y/t/jzI5gA4OAKyUrtzF5wxtEd7Qf/f1DHeKaUWZjEDucg4dHABYqdHf3+UFr3zUUtfLoVtK
t9yd4rfZ8Ib+2yx3iulDmYwgyxTmLspkOzo4ALBSo3OXoMwjrzz6KmPbtm1yDWn03fffeXeK2372
M+/bUb7J3SmKFu4U04UyGUGWSRTIqxRlcgC5CwCslILcBQuJO8WF77/95vv5ue+/uef9KtZFC3eK
6UKZjECZnEO/DABWIndBD3Ff6H046htvbF78Kta9O0WkDGUyAmVyDP0yAFiJ3AVNcoP04gbRX7zb
RIbnU4gyGYEyuYV+GQCsRO6CPuJmMb9wm5helMkIlMkh9MsAYCVyFwAAKUK/DABWIncBAJAi9MsA
YCVyFwAAKUK/DABWIncBAJAi9MsAYCVyFwAAKUK/DABWMjN3dTQ3NTU1d8hXSKNcjTzLto7IJqTR
yNZlslKUKvX8YvFfn/XIXQBgJfNyl3c/39whfuXmI8U6muU9vHejyO18igWVypWKiyrNRIWWbd3K
f30OIHcBgJVM/ZwhucsUuXtFcpcBxDVFpVJMXkn81+cCchcAWIncBa14iJJ2XoV81CnFgvEL/utz
AbkLAKxE7oJGpC6DeMXigVc6KRcS//W5gNwFAFYid0EX7uNNI64qCpZKojJR1Mlu5C4AsBK5C1p4
N4pUKP3UC4mamYD/+lxA7gIAK5mXu7ybwxDDvqnkPepScaOYWmqpKJMByF0uIHcBgJVMfd4FAICV
6JcBwErkLgAAUoR+GQCsRO4CACBF6JcBwErkLgAAUoR+GQCsRO4CACBF6JcBwErkLgAAUoR+GQCs
RO4CACBF6JcBwErkLgAAUoR+GQCsRO4CACBF6JcBwErkLgAAUoR+GQCsRO4CACBF6JcBwErkLgAA
UoR+GQCs1NTa2ir+iwcAAGkg+mXZRQMArPH99/8/0D6RNhGmgdEAAAAASUVORK5CYII=
--001a1140289cf56ba305181099da--

--===============1619197756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1619197756==--
