From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd_cache, limiting read on high iops around 40k
Date: Fri, 12 Jun 2015 08:03:13 +0200 (CEST)
Message-ID: <961809688.968058.1434088993053.JavaMail.zimbra@oxygem.tv>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv> <1058039366.2034449.1433868447253.JavaMail.zimbra@oxygem.tv> <284297771.2095666.1433909407567.JavaMail.zimbra@oxygem.tv> <CAF-rypxjbsH3GdUG474OgSZVjdzKyf_0n8-zAkAuGhk83TXQhA@mail.gmail.com> <2010200873.2102614.1433914918985.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9E2FB@SACMBXIP01.sdcorp.global.sandisk.com> <464499571.2150222.1433921341602.JavaMail.zimbra@oxygem.tv> <CAMc8nAXjLNhHSNhTpH-WAsDUSM_dd77Bu8aoe+P4e4JcUvA8mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56823 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbFLGDP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 02:03:15 -0400
In-Reply-To: <CAMc8nAXjLNhHSNhTpH-WAsDUSM_dd77Bu8aoe+P4e4JcUvA8mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pushpesh sharma <pushpesh.eck@gmail.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Irek Fasikhov <malmyzh@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

here a libvirt xml sample from libvirt src

(you need to define <iothreads>  number, then assign then in disks).

I don't use openstack, so I really don't known how it's working with it=
=2E


<domain type=3D'qemu'>
  <name>QEMUGuest1</name>
  <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
  <memory unit=3D'KiB'>219136</memory>
  <currentMemory unit=3D'KiB'>219136</currentMemory>
  <vcpu placement=3D'static'>2</vcpu>
  <iothreads>2</iothreads>
  <os>
    <type arch=3D'i686' machine=3D'pc'>hvm</type>
    <boot dev=3D'hd'/>
  </os>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/qemu</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw' iothread=3D'1'/>
      <source file=3D'/var/lib/libvirt/images/iothrtest1.img'/>
      <target dev=3D'vdb' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04=
' function=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw' iothread=3D'2'/>
      <source file=3D'/var/lib/libvirt/images/iothrtest2.img'/>
      <target dev=3D'vdc' bus=3D'virtio'/>
    </disk>
    <controller type=3D'usb' index=3D'0'/>
    <controller type=3D'ide' index=3D'0'/>
    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
    <memballoon model=3D'none'/>
  </devices>
</domain>


----- Mail original -----
De: "pushpesh sharma" <pushpesh.eck@gmail.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Somnath Roy" <Somnath.Roy@sandisk.com>, "Irek Fasikhov" <malmyzh@g=
mail.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <cep=
h-users@lists.ceph.com>
Envoy=C3=A9: Vendredi 12 Juin 2015 07:52:41
Objet: Re: rbd_cache, limiting read on high iops around 40k

Hi Alexandre,=20

I agree with your rational, of one iothread per disk. CPU consumed in=20
IOwait is pretty high in each VM. But I am not finding a way to set=20
the same on a nova instance. I am using openstack Juno with QEMU+KVM.=20
As per libvirt documentation for setting iothreads, I can edit=20
domain.xml directly and achieve the same effect. However in as in=20
openstack env domain xml is created by nova with some additional=20
metadata, so editing the domain xml using 'virsh edit' does not seems=20
to work(I agree, it is not a very cloud way of doing things, but a=20
hack). Changes made there vanish after saving them, due to reason=20
libvirt validation fails on the same.=20

#virsh dumpxml instance-000000c5 > vm.xml=20
#virt-xml-validate vm.xml=20
Relax-NG validity error : Extra element cpu in interleave=20
vm.xml:1: element domain: Relax-NG validity error : Element domain=20
failed to validate content=20
vm.xml fails to validate=20

Second approach I took was to setting QoS in volumes types. But there=20
is no option to set iothreads per volume, there are parameter realted=20
to max_read/wrirte ops/bytes.=20

Thirdly, editing Nova flavor and proving extra specs like=20
hw:cpu_socket/thread/core, can change guest CPU topology however again=20
no way to set iothread. It does accept hw_disk_iothreads(no type check=20
in place, i believe ), but can not pass the same in domain.xml.=20

Could you suggest me a way to set the same.=20

-Pushpesh=20

On Wed, Jun 10, 2015 at 12:59 PM, Alexandre DERUMIER=20
<aderumier@odiso.com> wrote:=20
>>>I need to try out the performance on qemu soon and may come back to =
you if I need some qemu setting trick :-)=20
>=20
> Sure no problem.=20
>=20
> (BTW, I can reach around 200k iops in 1 qemu vm with 5 virtio disks w=
ith 1 iothread by disk)=20
>=20
>=20
> ----- Mail original -----=20
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>, "Irek Fasikhov" <malmyzh@g=
mail.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "pushpesh sharma" <pus=
hpesh.eck@gmail.com>, "ceph-users" <ceph-users@lists.ceph.com>=20
> Envoy=C3=A9: Mercredi 10 Juin 2015 09:06:32=20
> Objet: RE: rbd_cache, limiting read on high iops around 40k=20
>=20
> Hi Alexandre,=20
> Thanks for sharing the data.=20
> I need to try out the performance on qemu soon and may come back to y=
ou if I need some qemu setting trick :-)=20
>=20
> Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf=
 Of Alexandre DERUMIER=20
> Sent: Tuesday, June 09, 2015 10:42 PM=20
> To: Irek Fasikhov=20
> Cc: ceph-devel; pushpesh sharma; ceph-users=20
> Subject: Re: [ceph-users] rbd_cache, limiting read on high iops aroun=
d 40k=20
>=20
>>>Very good work!=20
>>>Do you have a rpm-file?=20
>>>Thanks.=20
> no sorry, I'm have compiled it manually (and I'm using debian jessie =
as client)=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Irek Fasikhov" <malmyzh@gmail.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>=20
> Cc: "Robert LeBlanc" <robert@leblancnet.us>, "ceph-devel" <ceph-devel=
@vger.kernel.org>, "pushpesh sharma" <pushpesh.eck@gmail.com>, "ceph-us=
ers" <ceph-users@lists.ceph.com>=20
> Envoy=C3=A9: Mercredi 10 Juin 2015 07:21:42=20
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around =
40k=20
>=20
> Hi, Alexandre.=20
>=20
> Very good work!=20
> Do you have a rpm-file?=20
> Thanks.=20
>=20
> 2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER < aderumier@odiso.com > =
:=20
>=20
>=20
> Hi,=20
>=20
> I have tested qemu with last tcmalloc 2.4, and the improvement is hug=
e with iothread: 50k iops (+45%) !=20
>=20
>=20
>=20
> qemu : no iothread : glibc : iops=3D33395 qemu : no-iothread : tcmall=
oc (2.2.1) : iops=3D34516 (+3%) qemu : no-iothread : jemmaloc : iops=3D=
42226 (+26%) qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%)=20
>=20
>=20
> qemu : iothread : glibc : iops=3D34516=20
> qemu : iothread : tcmalloc : iops=3D38676 (+12%) qemu : iothread : je=
mmaloc : iops=3D28023 (-19%) qemu : iothread : tcmalloc (2.4) : iops=3D=
50276 (+45%)=20
>=20
>=20
>=20
>=20
>=20
> qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)=20
> ------------------------------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s] [54.1K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: Wed=
 Jun 10 05:54:24 2015 read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D502=
76, runt=3D 26070msec slat (usec): min=3D1, max=3D1136, avg=3D 3.54, st=
dev=3D 3.58 clat (usec): min=3D128, max=3D6262, avg=3D631.41, stdev=3D1=
97.71 lat (usec): min=3D149, max=3D6265, avg=3D635.27, stdev=3D197.40 c=
lat percentiles (usec):=20
> | 1.00th=3D[ 318], 5.00th=3D[ 378], 10.00th=3D[ 418], 20.00th=3D[ 474=
],=20
> | 30.00th=3D[ 516], 40.00th=3D[ 564], 50.00th=3D[ 612], 60.00th=3D[ 6=
52],=20
> | 70.00th=3D[ 700], 80.00th=3D[ 756], 90.00th=3D[ 860], 95.00th=3D[ 9=
80],=20
> | 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 1688], 99.95th=3D=
[ 1896],=20
> | 99.99th=3D[ 3760]=20
> bw (KB /s): min=3D145608, max=3D249688, per=3D100.00%, avg=3D201108.0=
0, stdev=3D21718.87 lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=3D53.00=
%, 1000=3D16.63% lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01% cpu : us=
r=3D9.73%, sys=3D24.93%, ctx=3D66417, majf=3D0, minf=3D38 IO depths : 1=
=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, >=3D64=3D=
0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0=
%, 32=3D0.1%, 64=3D0.0%, >=3D64=3D0.0% issued : total=3Dr=3D1310720/w=3D=
0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, pe=
rcentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107KB/s, maxb=3D20=
1107KB/s, mint=3D26070msec, maxt=3D26070msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_queue=3D71484=
0, util=3D99.73%=20
>=20
>=20
>=20
>=20
>=20
>=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D889: Wed=
 Jun 10 06:05:06 2015 read : io=3D5120.0MB, bw=3D143897KB/s, iops=3D359=
74, runt=3D 36435msec slat (usec): min=3D1, max=3D710, avg=3D 3.31, std=
ev=3D 3.35 clat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=3D31=
5.65 lat (usec): min=3D289, max=3D4743, avg=3D888.31, stdev=3D315.51 cl=
at percentiles (usec):=20
> | 1.00th=3D[ 462], 5.00th=3D[ 516], 10.00th=3D[ 548], 20.00th=3D[ 596=
],=20
> | 30.00th=3D[ 652], 40.00th=3D[ 764], 50.00th=3D[ 868], 60.00th=3D[ 9=
40],=20
> | 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256], 95.00th=3D=
[ 1416],=20
> | 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D=
[ 2640],=20
> | 99.99th=3D[ 3632]=20
> bw (KB /s): min=3D98352, max=3D177328, per=3D99.91%, avg=3D143772.11,=
 stdev=3D21782.39 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%, =
1000=3D30.01% lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01% cpu : usr=3D=
7.10%, sys=3D16.90%, ctx=3D54855, majf=3D0, minf=3D38 IO depths : 1=3D0=
=2E1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, >=3D64=3D0=
=2E0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D=
0.0%, 32=3D0.1%, 64=3D0.0%, >=3D64=3D0.0% issued : total=3Dr=3D1310720/=
w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0=
, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/s, maxb=3D14=
3896KB/s, mint=3D36435msec, maxt=3D36435msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D1032=
716, util=3D99.85%=20
>=20
>=20
> ----- Mail original -----=20
> De: "aderumier" < aderumier@odiso.com >=20
> =C3=80: "Robert LeBlanc" < robert@leblancnet.us >=20
> Cc: "Mark Nelson" < mnelson@redhat.com >, "ceph-devel" < ceph-devel@v=
ger.kernel.org >, "pushpesh sharma" < pushpesh.eck@gmail.com >, "ceph-u=
sers" < ceph-users@lists.ceph.com >=20
> Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27=20
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around =
40k=20
>=20
> Hi Robert,=20
>=20
>>>What I found was that Ceph OSDs performed well with either tcmalloc =
or=20
>>>jemalloc (except when RocksDB was built with jemalloc instead of=20
>>>tcmalloc, I'm still working to dig into why that might be the case).=
=20
> yes,from my test, for osd tcmalloc is a little faster (but very littl=
e) than jemalloc.=20
>=20
>=20
>=20
>>>However, I found that tcmalloc with QEMU/KVM was very detrimental to=
=20
>>>small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=
=20
>>>better for QEMU/KVM in the tests that we ran. [1]=20
>=20
>=20
> Just have done qemu test (4k randread - rbd_cache=3Doff), I don't see=
 speed regression with tcmalloc.=20
> with qemu iothread, tcmalloc have a speed increase over glib=20
> with qemu iothread, jemalloc have a speed decrease=20
>=20
> without iothread, jemalloc have a big speed increase=20
>=20
> this is with=20
> -qemu 2.3=20
> -tcmalloc 2.2.1=20
> -jemmaloc 3.6=20
> -libc6 2.19=20
>=20
>=20
> qemu : no iothread : glibc : iops=3D33395=20
> qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)=20
> qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)=20
>=20
> qemu : iothread : glibc : iops=3D34516=20
> qemu : iothread : tcmalloc : iops=3D38676 (+12%)=20
> qemu : iothread : jemmaloc : iops=3D28023 (-19%)=20
>=20
>=20
> (The benefit of iothreads is that we can scale with more disks in 1vm=
)=20
>=20
>=20
> fio results:=20
> ------------=20
>=20
> qemu : iothread : tcmalloc : iops=3D38676=20
> -----------------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tu=
e Jun 9 18:16:53 2015=20
> read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889mse=
c=20
> slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42=20
> clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34=20
> lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.00th=3D[ 572=
],=20
> | 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ 8=
52],=20
> | 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D[=
 1352],=20
> | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=3D=
[ 2448],=20
> | 99.99th=3D[ 3888]=20
> bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D154824.4=
0, stdev=3D16978.03=20
> lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%=20
> lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%=20
> cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=3D39=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s, maxb=3D15=
4707KB/s, mint=3D33889msec, maxt=3D33889msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D93409=
6, util=3D99.77%=20
>=20
>=20
>=20
> qemu : no-iothread : tcmalloc : iops=3D34516=20
> ---------------------------------------------=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tue=
 Jun 9 18:19:08 2015=20
> read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974mse=
c=20
> slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57=20
> clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61=20
> lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 652=
],=20
> | 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60.00th=3D[ 9=
40],=20
> | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=3D=
[ 1576],=20
> | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=3D=
[ 3248],=20
> | 99.99th=3D[ 4320]=20
> bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.88,=
 stdev=3D16883.77=20
> lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%=20
> lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%=20
> cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D38=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D13=
8064KB/s, mint=3D37974msec, maxt=3D37974msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D1068=
396, util=3D99.86%=20
>=20
>=20
>=20
> qemu : iothread : glibc : iops=3D34516=20
> -------------------------------------=20
>=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue=
 Jun 9 18:24:01 2015=20
> read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051mse=
c=20
> slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66=20
> clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28=20
> lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652=
],=20
> | 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60.00th=3D[ 9=
64],=20
> | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=3D=
[ 1448],=20
> | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=3D=
[ 2640],=20
> | 99.99th=3D[ 3984]=20
> bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.7=
8, stdev=3D15521.30=20
> lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%=20
> lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%=20
> cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D38=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D13=
7785KB/s, mint=3D38051msec, maxt=3D38051msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D1050=
972, util=3D99.85%=20
>=20
>=20
>=20
> qemu : no iothread : glibc : iops=3D33395=20
> -----------------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tue=
 Jun 9 18:27:18 2015=20
> read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248mse=
c=20
> slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29=20
> clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51=20
> lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652=
],=20
> | 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60.00th=3D[ 9=
96],=20
> | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=3D=
[ 1528],=20
> | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=3D=
[ 2928],=20
> | 99.99th=3D[ 4832]=20
> bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682.64=
, stdev=3D19121.91=20
> lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%=20
> lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%=20
> cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=3D38=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D13=
3583KB/s, mint=3D39248msec, maxt=3D39248msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D1074=
536, util=3D99.84%=20
>=20
>=20
>=20
> qemu : iothread : jemmaloc : iops=3D28023=20
> ----------------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0 =
iops] [eta 00m:01s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tue=
 Jun 9 18:30:26 2015=20
> read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772mse=
c=20
> slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77=20
> clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55=20
> lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D[ 820=
],=20
> | 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=3D[=
 1224],=20
> | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=3D=
[ 1688],=20
> | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D=
[ 2832],=20
> | 99.99th=3D[ 3760]=20
> bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.27,=
 stdev=3D17381.70=20
> lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%=20
> lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%=20
> cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D38=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D11=
2094KB/s, mint=3D46772msec, maxt=3D46772msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D1305=
376, util=3D98.68%=20
>=20
>=20
>=20
> qemu : non-iothread : jemmaloc : iops=3D42226=20
> --------------------------------------------=20
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Dlibaio, iodepth=3D32=20
> fio-2.1.11=20
> Starting 1 process=20
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/0=
 iops] [eta 00m:00s]=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue=
 Jun 9 18:34:11 2015=20
> read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599mse=
c=20
> slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74=20
> clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53=20
> lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D[ 516=
],=20
> | 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60.00th=3D[ 7=
40],=20
> | 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 95.00th=3D[ =
1128],=20
> | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=3D=
[ 2064],=20
> | 99.99th=3D[ 2608]=20
> bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D177192.1=
4, stdev=3D23440.79=20
> lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%=20
> lat (msec) : 2=3D10.30%, 4=3D0.07%=20
> cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39=20
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D1=
00.0%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D17=
7130KB/s, mint=3D29599msec, maxt=3D29599msec=20
>=20
> Disk stats (read/write):=20
> vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D79763=
6, util=3D99.80%=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Robert LeBlanc" < robert@leblancnet.us >=20
> =C3=80: "aderumier" < aderumier@odiso.com >=20
> Cc: "Mark Nelson" < mnelson@redhat.com >, "ceph-devel" < ceph-devel@v=
ger.kernel.org >, "pushpesh sharma" < pushpesh.eck@gmail.com >, "ceph-u=
sers" < ceph-users@lists.ceph.com >=20
> Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29=20
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around =
40k=20
>=20
> -----BEGIN PGP SIGNED MESSAGE-----=20
> Hash: SHA256=20
>=20
> I also saw a similar performance increase by using alternative memory=
=20
> allocators. What I found was that Ceph OSDs performed well with eithe=
r=20
> tcmalloc or jemalloc (except when RocksDB was built with jemalloc=20
> instead of tcmalloc, I'm still working to dig into why that might be=20
> the case).=20
>=20
> However, I found that tcmalloc with QEMU/KVM was very detrimental to=20
> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=20
> better for QEMU/KVM in the tests that we ran. [1]=20
>=20
> I'm currently looking into I/O bottlenecks around the 16KB range and=20
> I'm seeing a lot of time in thread creation and destruction, the=20
> memory allocators are quite a bit down the list (both fio with=20
> ioengine rbd and on the OSDs). I wonder what the difference can be.=20
> I've tried using the async messenger but there wasn't a huge=20
> difference. [2]=20
>=20
> Further down the rabbit hole....=20
>=20
> [1] https://www.mail-archive.com/ceph-users@lists.ceph.com/msg20197.h=
tml=20
> [2] https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg23982.=
html=20
> -----BEGIN PGP SIGNATURE-----=20
> Version: Mailvelope v0.13.1=20
> Comment: https://www.mailvelope.com=20
>=20
> wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8=20
> unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU=20
> YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87=20
> afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2=20
> S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3=20
> vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51=20
> 9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO=20
> qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3=20
> Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b=20
> 6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13=20
> R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ=20
> 1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4=20
> oSJX=20
> =3Dk281=20
> -----END PGP SIGNATURE-----=20
> ----------------=20
> Robert LeBlanc=20
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1=20
>=20
>=20
> On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER < aderumier@odiso.=
com > wrote:=20
>>>>Frankly, I'm a little impressed that without RBD cache we can hit 8=
0K=20
>>>>IOPS from 1 VM!=20
>>=20
>> Note that theses result are not in a vm (fio-rbd on host), so in a v=
m we'll have overhead.=20
>> (I'm planning to send results in qemu soon)=20
>>=20
>>>>How fast are the SSDs in those 3 OSDs?=20
>>=20
>> Theses results are with datas in buffer memory of osd nodes.=20
>>=20
>> When reading fulling on ssd (intel s3500),=20
>>=20
>> For 1 client,=20
>>=20
>> I'm around 33k iops without cache and 32k iops with cache, with 1 os=
d.=20
>> I'm around 55k iops without cache and 38k iops with cache, with 3 os=
d.=20
>>=20
>> with multiple clients jobs, I can reach around 70kiops by osd , and =
250k iops by osd when datas are in buffer.=20
>>=20
>> (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)=20
>>=20
>>=20
>>=20
>> small tip :=20
>> I'm using tcmalloc for fio-rbd or rados bench to improve latencies b=
y around 20%=20
>>=20
>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...=20
>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...=20
>>=20
>> as a lot of time is spent in malloc/free=20
>>=20
>>=20
>> (qemu support also tcmalloc since some months , I'll bench it too=20
>> https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html =
)=20
>>=20
>>=20
>>=20
>> I'll try to send full bench results soon, from 1 to 18 ssd osd.=20
>>=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "Mark Nelson" < mnelson@redhat.com >=20
>> =C3=80: "aderumier" < aderumier@odiso.com >, "pushpesh sharma" < pus=
hpesh.eck@gmail.com >=20
>> Cc: "ceph-devel" < ceph-devel@vger.kernel.org >, "ceph-users" < ceph=
-users@lists.ceph.com >=20
>> Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31=20
>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around=
 40k=20
>>=20
>> Hi All,=20
>>=20
>> In the past we've hit some performance issues with RBD cache that we=
've=20
>> fixed, but we've never really tried pushing a single VM beyond 40+K =
read=20
>> IOPS in testing (or at least I never have). I suspect there's a coup=
le=20
>> of possibilities as to why it might be slower, but perhaps joshd can=
=20
>> chime in as he's more familiar with what that code looks like.=20
>>=20
>> Frankly, I'm a little impressed that without RBD cache we can hit 80=
K=20
>> IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?=20
>>=20
>> Mark=20
>>=20
>> On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:=20
>>> It's seem that the limit is mainly going in high queue depth (+- > =
16)=20
>>>=20
>>> Here the result in iops with 1client- 4krandread- 3osd - with diffe=
rents queue depth size.=20
>>> rbd_cache is almost the same than without cache with queue depth <1=
6=20
>>>=20
>>>=20
>>> cache=20
>>> -----=20
>>> qd1: 1651=20
>>> qd2: 3482=20
>>> qd4: 7958=20
>>> qd8: 17912=20
>>> qd16: 36020=20
>>> qd32: 42765=20
>>> qd64: 46169=20
>>>=20
>>> no cache=20
>>> --------=20
>>> qd1: 1748=20
>>> qd2: 3570=20
>>> qd4: 8356=20
>>> qd8: 17732=20
>>> qd16: 41396=20
>>> qd32: 78633=20
>>> qd64: 79063=20
>>> qd128: 79550=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "aderumier" < aderumier@odiso.com >=20
>>> =C3=80: "pushpesh sharma" < pushpesh.eck@gmail.com >=20
>>> Cc: "ceph-devel" < ceph-devel@vger.kernel.org >, "ceph-users" < cep=
h-users@lists.ceph.com >=20
>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21=20
>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops aroun=
d 40k=20
>>>=20
>>> Hi,=20
>>>=20
>>>>> We tried adding more RBDs to single VM, but no luck.=20
>>>=20
>>> If you want to scale with more disks in a single qemu vm, you need =
to use iothread feature from qemu and assign 1 iothread by disk (works =
with virtio-blk).=20
>>> It's working for me, I can scale with adding more disks.=20
>>>=20
>>>=20
>>> My bench here are done with fio-rbd on host.=20
>>> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a sin=
gle host and around 250kiops 10clients-rbdcache=3Don.=20
>>>=20
>>>=20
>>> I just wonder why I don't have performance decrease around 30k iops=
 with 1osd.=20
>>>=20
>>> I'm going to see if this tracker=20
>>> http://tracker.ceph.com/issues/11056=20
>>>=20
>>> could be the cause.=20
>>>=20
>>> (My master build was done some week ago)=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "pushpesh sharma" < pushpesh.eck@gmail.com >=20
>>> =C3=80: "aderumier" < aderumier@odiso.com >=20
>>> Cc: "ceph-devel" < ceph-devel@vger.kernel.org >, "ceph-users" < cep=
h-users@lists.ceph.com >=20
>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04=20
>>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>>=20
>>> Hi Alexandre,=20
>>>=20
>>> We have also seen something very similar on Hammer(0.94-1). We were=
 doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openst=
ack-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as addition=
al storage. For some strange reason it was not able to scale 4K- RR iop=
s on each VM beyond 35-40k. We tried adding more RBDs to single VM, but=
 no luck. However increasing number of VMs to 4 on a single hypervisor =
did scale to some extent. After this there was no much benefit we got f=
rom adding more VMs.=20
>>>=20
>>> Here is the trend we have seen, x-axis is number of hypervisor, eac=
h hypervisor has 4 VM, each VM has 1 RBD:-=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> VDbench is used as benchmarking tool. We were not saturating networ=
k and CPUs at OSD nodes. We were not able to saturate CPUs at hyperviso=
rs, and that is where we were suspecting of some throttling effect. How=
ever we haven't setted any such limits from nova or kvm end. We tried s=
ome CPU pinning and other KVM related tuning as well, but no luck.=20
>>>=20
>>> We tried the same experiment on a bare metal. It was 4K RR IOPs wer=
e scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than s=
caling beyond that point the numbers were actually degrading. (Single p=
ipe more congestion effect)=20
>>>=20
>>> We never suspected that rbd cache enable could be detrimental to pe=
rformance. It would nice to route cause the problem if that is the case=
=2E=20
>>>=20
>>> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER < aderumier@odi=
so.com > wrote:=20
>>>=20
>>>=20
>>> Hi,=20
>>>=20
>>> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D=
32,=20
>>> and rbd_cache=3Dtrue seem to limit the iops around 40k=20
>>>=20
>>>=20
>>> no cache=20
>>> --------=20
>>> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops=20
>>> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops=20
>>> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops=20
>>>=20
>>>=20
>>> cache=20
>>> -----=20
>>> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops=20
>>> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops=20
>>> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops=20
>>>=20
>>>=20
>>>=20
>>> Is it expected ?=20
>>>=20
>>>=20
>>>=20
>>> fio result rbd_cache=3Dfalse 3 osd=20
>>> --------------------------------=20
>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=
 ioengine=3Drbd, iodepth=3D32=20
>>> fio-2.1.11=20
>>> Starting 1 process=20
>>> rbd engine: RBD version: 0.1.9=20
>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0=
/0 iops] [eta 00m:00s]=20
>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548=
: Tue Jun 9 07:48:42 2015=20
>>> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698ms=
ec=20
>>> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77=20
>>> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82=20
>>> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49=20
>>> clat percentiles (usec):=20
>>> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 2=
62],=20
>>> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[=
 346],=20
>>> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[=
 506],=20
>>> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[=
 948],=20
>>> | 99.99th=3D[ 1176]=20
>>> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402=
=2E34, stdev=3D25196.21=20
>>> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, =
1000=3D0.23%=20
>>> lat (msec) : 2=3D0.03%, 4=3D0.01%=20
>>> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D12=
452=20
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D=
12.1%, >=3D64=3D0.0%=20
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=
=20
>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>=20
>>> Run status group 0 (all jobs):=20
>>> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D3=
13169KB/s, mint=3D32698msec, maxt=3D32698msec=20
>>>=20
>>> Disk stats (read/write):=20
>>> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.=
00%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D=
0, aggrutil=3D0.00%=20
>>> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.=
00%=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> fio result rbd_cache=3Dtrue 3osd=20
>>> ------------------------------=20
>>>=20
>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=
 ioengine=3Drbd, iodepth=3D32=20
>>> fio-2.1.11=20
>>> Starting 1 process=20
>>> rbd engine: RBD version: 0.1.9=20
>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0=
/0 iops] [eta 00m:00s]=20
>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389=
: Tue Jun 9 07:47:30 2015=20
>>> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866ms=
ec=20
>>> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84=20
>>> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73=20
>>> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03=20
>>> clat percentiles (usec):=20
>>> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 3=
50],=20
>>> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[=
 506],=20
>>> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[=
 724],=20
>>> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D=
[ 1288],=20
>>> | 99.99th=3D[ 2192]=20
>>> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315=
=2E10, stdev=3D15079.93=20
>>> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=20
>>> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%=20
>>> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D1=
4100=20
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=
=3D5.3%, >=3D64=3D0.0%=20
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=
=20
>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>=20
>>> Run status group 0 (all jobs):=20
>>> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D1=
83295KB/s, mint=3D55866msec, maxt=3D55866msec=20
>>>=20
>>> Disk stats (read/write):=20
>>> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.=
01%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D=
8, aggrutil=3D0.01%=20
>>> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.=
01%=20
>>>=20
>> _______________________________________________=20
>> ceph-users mailing list=20
>> ceph-users@lists.ceph.com=20
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=
=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=
=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87=20
> =D0=9C=D0=BE=D0=B1.: +79229045757=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
> ________________________________=20
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20
>=20



--=20
-Pushpesh=20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
