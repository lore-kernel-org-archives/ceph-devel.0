From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] strange benchmark problem : restarting osd daemon
 improve performance from 100k iops to 300k iops
Date: Thu, 23 Apr 2015 13:56:26 +0200 (CEST)
Message-ID: <1903663405.564474385.1429790186021.JavaMail.zimbra@oxygem.tv>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv> <886679306.527978224.1429710961512.JavaMail.zimbra@oxygem.tv> <5537A9A8.10200@redhat.com> <59E25171A319194CB0889178D3F1E09A0B8916A0@SACMBXIP01.sdcorp.global.sandisk.com> <336199846.535234014.1429720226874.JavaMail.zimbra@oxygem.tv> <1806383776.554938002.1429776034371.JavaMail.zimbra@oxygem.tv> <1112295705.562655711.1429786696959.JavaMail.zimbra@oxygem.tv> <5538D86C.1090506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44240 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbbDWL43 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Apr 2015 07:56:29 -0400
In-Reply-To: <5538D86C.1090506@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Srinivasula Maram <Srinivasula.Maram@sandisk.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Milosz Tanski <milosz@adfin.com>

>>If you have the means to compile the same version of ceph with jemall=
oc,=20
>>I would be very interested to see how it does.

Yes, sure. (I have around 3-4 weeks to do all the benchs)

But I don't know how to do it ?=20
I'm running the cluster on centos7.1, maybe it can be easy to patch the=
 srpms to rebuild the package with jemalloc.



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "Srinivasula Maram" <Sriniva=
sula.Maram@sandisk.com>
Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-devel@=
vger.kernel.org>, "Milosz Tanski" <milosz@adfin.com>
Envoy=C3=A9: Jeudi 23 Avril 2015 13:33:00
Objet: Re: [ceph-users] strange benchmark problem : restarting osd daem=
on improve performance from 100k iops to 300k iops

Thanks for the testing Alexandre!=20

If you have the means to compile the same version of ceph with jemalloc=
,=20
I would be very interested to see how it does.=20

In some ways I'm glad it turned out not to be NUMA. I still suspect we=20
will have to deal with it at some point, but perhaps not today. ;)=20

Mark=20

On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote:=20
> Maybe it's tcmalloc related=20
> I thinked to have patched it correctly, but perf show a lot of tcmall=
oc::ThreadCache::ReleaseToCentralCache=20
>=20
> before osd restart (100k)=20
> ------------------=20
> 11.66% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::Relea=
seToCentralCache=20
> 8.51% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::Fe=
tchFromSpans=20
> 3.04% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::Re=
leaseToSpans=20
> 2.04% ceph-osd libtcmalloc.so.4.1.2 [.] operator new=20
> 1.63% swapper [kernel.kallsyms] [k] intel_idle=20
> 1.35% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::Re=
leaseListToSpans=20
> 1.33% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete=20
> 1.07% ceph-osd libstdc++.so.6.0.19 [.] std::basic_string<char, std::c=
har_traits<char>, std::allocator<char> >::basic_string=20
> 0.91% ceph-osd libpthread-2.17.so [.] pthread_mutex_trylock=20
> 0.88% ceph-osd libc-2.17.so [.] __memcpy_ssse3_back=20
> 0.81% ceph-osd ceph-osd [.] Mutex::Lock=20
> 0.79% ceph-osd [kernel.kallsyms] [k] copy_user_enhanced_fast_string=20
> 0.74% ceph-osd libpthread-2.17.so [.] pthread_mutex_unlock=20
> 0.67% ceph-osd [kernel.kallsyms] [k] _raw_spin_lock=20
> 0.63% swapper [kernel.kallsyms] [k] native_write_msr_safe=20
> 0.62% ceph-osd [kernel.kallsyms] [k] avc_has_perm_noaudit=20
> 0.58% ceph-osd ceph-osd [.] operator<=20
> 0.57% ceph-osd [kernel.kallsyms] [k] __schedule=20
> 0.57% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu=20
> 0.54% swapper [kernel.kallsyms] [k] __schedule=20
>=20
>=20
> after osd restart (300k iops)=20
> ------------------------------=20
> 3.47% ceph-osd libtcmalloc.so.4.1.2 [.] operator new=20
> 1.92% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete=20
> 1.86% swapper [kernel.kallsyms] [k] intel_idle=20
> 1.52% ceph-osd libstdc++.so.6.0.19 [.] std::basic_string<char, std::c=
har_traits<char>, std::allocator<char> >::basic_string=20
> 1.34% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::Releas=
eToCentralCache=20
> 1.24% ceph-osd libc-2.17.so [.] __memcpy_ssse3_back=20
> 1.23% ceph-osd ceph-osd [.] Mutex::Lock=20
> 1.21% ceph-osd libpthread-2.17.so [.] pthread_mutex_trylock=20
> 1.11% ceph-osd [kernel.kallsyms] [k] copy_user_enhanced_fast_string=20
> 0.95% ceph-osd libpthread-2.17.so [.] pthread_mutex_unlock=20
> 0.94% ceph-osd [kernel.kallsyms] [k] _raw_spin_lock=20
> 0.78% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu=20
> 0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg=20
> 0.70% ceph-osd ceph-osd [.] Message::Message=20
> 0.68% ceph-osd [kernel.kallsyms] [k] __schedule=20
> 0.66% ceph-osd [kernel.kallsyms] [k] idle_cpu=20
> 0.65% ceph-osd libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::Fe=
tchFromSpans=20
> 0.64% swapper [kernel.kallsyms] [k] native_write_msr_safe=20
> 0.61% ceph-osd ceph-osd [.] std::tr1::_Sp_counted_base<(__gnu_cxx::_L=
ock_policy)2>::_M_release=20
> 0.60% swapper [kernel.kallsyms] [k] __schedule=20
> 0.60% ceph-osd libstdc++.so.6.0.19 [.] 0x00000000000bdd2b=20
> 0.57% ceph-osd ceph-osd [.] operator<=20
> 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00=20
> 0.56% ceph-osd libstdc++.so.6.0.19 [.] std::string::_Rep::_M_dispose=20
> 0.55% ceph-osd [kernel.kallsyms] [k] __switch_to=20
> 0.54% ceph-osd libc-2.17.so [.] vfprintf=20
> 0.52% ceph-osd [kernel.kallsyms] [k] fget_light=20
>=20
> ----- Mail original -----=20
> De: "aderumier" <aderumier@odiso.com>=20
> =C3=80: "Srinivasula Maram" <Srinivasula.Maram@sandisk.com>=20
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Milosz Tanski" <milosz@adfin.com>=20
> Envoy=C3=A9: Jeudi 23 Avril 2015 10:00:34=20
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops=20
>=20
> Hi,=20
> I'm hitting this bug again today.=20
>=20
> So don't seem to be numa related (I have try to flush linux buffer to=
 be sure).=20
>=20
> and tcmalloc is patched (I don't known how to verify that it's ok).=20
>=20
> I don't have restarted osd yet.=20
>=20
> Maybe some perf trace could be usefulll ?=20
>=20
>=20
> ----- Mail original -----=20
> De: "aderumier" <aderumier@odiso.com>=20
> =C3=80: "Srinivasula Maram" <Srinivasula.Maram@sandisk.com>=20
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Milosz Tanski" <milosz@adfin.com>=20
> Envoy=C3=A9: Mercredi 22 Avril 2015 18:30:26=20
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops=20
>=20
> Hi,=20
>=20
>>> I feel it is due to tcmalloc issue=20
>=20
> Indeed, I had patched one of my node, but not the other.=20
> So maybe I have hit this bug. (but I can't confirm, I don't have trac=
es).=20
>=20
> But numa interleaving seem to help in my case (maybe not from 100->30=
0k, but 250k->300k).=20
>=20
> I need to do more long tests to confirm that.=20
>=20
>=20
> ----- Mail original -----=20
> De: "Srinivasula Maram" <Srinivasula.Maram@sandisk.com>=20
> =C3=80: "Mark Nelson" <mnelson@redhat.com>, "aderumier" <aderumier@od=
iso.com>, "Milosz Tanski" <milosz@adfin.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>=20
> Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33=20
> Objet: RE: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops=20
>=20
> I feel it is due to tcmalloc issue=20
>=20
> I have seen similar issue in my setup after 20 days.=20
>=20
> Thanks,=20
> Srinivas=20
>=20
>=20
>=20
> -----Original Message-----=20
> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf=
 Of Mark Nelson=20
> Sent: Wednesday, April 22, 2015 7:31 PM=20
> To: Alexandre DERUMIER; Milosz Tanski=20
> Cc: ceph-devel; ceph-users=20
> Subject: Re: [ceph-users] strange benchmark problem : restarting osd =
daemon improve performance from 100k iops to 300k iops=20
>=20
> Hi Alexandre,=20
>=20
> We should discuss this at the perf meeting today. We knew NUMA node a=
ffinity issues were going to crop up sooner or later (and indeed alread=
y have in some cases), but this is pretty major. It's probably time to =
really dig in and figure out how to deal with this.=20
>=20
> Note: this is one of the reasons I like small nodes with single socke=
ts and fewer OSDs.=20
>=20
> Mark=20
>=20
> On 04/22/2015 08:56 AM, Alexandre DERUMIER wrote:=20
>> Hi,=20
>>=20
>> I have done a lot of test today, and it seem indeed numa related.=20
>>=20
>> My numastat was=20
>>=20
>> # numastat=20
>> node0 node1=20
>> numa_hit 99075422 153976877=20
>> numa_miss 167490965 1493663=20
>> numa_foreign 1493663 167491417=20
>> interleave_hit 157745 167015=20
>> local_node 99049179 153830554=20
>> other_node 167517697 1639986=20
>>=20
>> So, a lot of miss.=20
>>=20
>> In this case , I can reproduce ios going from 85k to 300k iops, up a=
nd down.=20
>>=20
>> now setting=20
>> echo 0 > /proc/sys/kernel/numa_balancing=20
>>=20
>> and starting osd daemons with=20
>>=20
>> numactl --interleave=3Dall /usr/bin/ceph-osd=20
>>=20
>>=20
>> I have a constant 300k iops !=20
>>=20
>>=20
>> I wonder if it could be improve by binding osd daemons to specific n=
uma node.=20
>> I have 2 numanode of 10 cores with 6 osd, but I think it also requir=
e ceph.conf osd threads tunning.=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "Milosz Tanski" <milosz@adfin.com>=20
>> =C3=80: "aderumier" <aderumier@odiso.com>=20
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users"=20
>> <ceph-users@lists.ceph.com>=20
>> Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23=20
>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd=20
>> daemon improve performance from 100k iops to 300k iops=20
>>=20
>>=20
>>=20
>> On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER < aderumier@odis=
o.com > wrote:=20
>>=20
>>=20
>> I wonder if it could be numa related,=20
>>=20
>> I'm using centos 7.1,=20
>> and auto numa balacning is enabled=20
>>=20
>> cat /proc/sys/kernel/numa_balancing =3D 1=20
>>=20
>> Maybe osd daemon access to buffer on wrong numa node.=20
>>=20
>> I'll try to reproduce the problem=20
>>=20
>>=20
>>=20
>> Can you force the degenerate case using numactl? To either affirm or=
 deny your suspicion.=20
>>=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "aderumier" < aderumier@odiso.com >=20
>> =C3=80: "ceph-devel" < ceph-devel@vger.kernel.org >, "ceph-users" <=20
>> ceph-users@lists.ceph.com >=20
>> Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05=20
>> Objet: [ceph-users] strange benchmark problem : restarting osd daemo=
n=20
>> improve performance from 100k iops to 300k iops=20
>>=20
>> Hi,=20
>>=20
>> I was doing some benchmarks,=20
>> I have found an strange behaviour.=20
>>=20
>> Using fio with rbd engine, I was able to reach around 100k iops.=20
>> (osd datas in linux buffer, iostat show 0% disk access)=20
>>=20
>> then after restarting all osd daemons,=20
>>=20
>> the same fio benchmark show now around 300k iops.=20
>> (osd datas in linux buffer, iostat show 0% disk access)=20
>>=20
>>=20
>> any ideas?=20
>>=20
>>=20
>>=20
>>=20
>> before restarting osd=20
>> ---------------------=20
>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>> ioengine=3Drbd, iodepth=3D32 ...=20
>> fio-2.2.7-10-g51e9=20
>> Starting 10 processes=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0=
/0=20
>> iops] [eta 14m:45s]=20
>> fio: terminating on signal 2=20
>>=20
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075:=
 Wed Apr=20
>> 22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871=
, runt=3D=20
>> 26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D17.=
38 clat=20
>> (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23 lat (us=
ec):=20
>> min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42 clat percenti=
les=20
>> (usec):=20
>> | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ 24=
7],=20
>> | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D[ =
660],=20
>> | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D=
[14656],=20
>> | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D=
[41728],=20
>> | 99.99th=3D[47360]=20
>> bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.82,=
=20
>> stdev=3D28809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 10=
0=3D0.01%,=20
>> 250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03% la=
t (msec) :=20
>> 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37% lat (msec) =
: 100=3D0.01%=20
>> cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710=
 IO depths :=20
>> 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, >=3D=
64=3D0.0% submit :=20
>> 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D=
64=3D0.0%=20
>> complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D=
0.0%,=20
>>> =3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=3D=
0/w=3D0/d=3D0,=20
>> drop=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentil=
e=3D100.00%,=20
>> depth=3D32=20
>>=20
>> Run status group 0 (all jobs):=20
>> READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D45=
1487KB/s,=20
>> mint=3D26215msec, maxt=3D26215msec=20
>>=20
>> Disk stats (read/write):=20
>> sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0.0=
1%=20
>> [root@ceph1-3 fiorbd]# ./fio fiorbd=20
>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>> ioengine=3Drbd, iodepth=3D32=20
>>=20
>>=20
>>=20
>>=20
>> AFTER RESTARTING OSDS=20
>> ----------------------=20
>> [root@ceph1-3 fiorbd]# ./fio fiorbd=20
>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>> ioengine=3Drbd, iodepth=3D32 ...=20
>> fio-2.2.7-10-g51e9=20
>> Starting 10 processes=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> rbd engine: RBD version: 0.1.9=20
>> ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0=
=20
>> iops] [eta 01h:09m:27s]=20
>> fio: terminating on signal 2=20
>>=20
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252:=
 Wed Apr=20
>> 22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D26521=
8, runt=3D=20
>> 7389msec slat (usec): min=3D5, max=3D3406, avg=3D26.59, stdev=3D40.3=
5 clat=20
>> (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat (us=
ec):=20
>> min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat percenti=
les=20
>> (usec):=20
>> | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ 45=
0],=20
>> | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ =
796],=20
>> | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D=
[ 1720],=20
>> | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=3D=
[ 9792],=20
>> | 99.99th=3D[436224]=20
>> bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46=
,=20
>> stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 10=
0=3D0.01%,=20
>> 250=3D1.23% lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84% l=
at (msec)=20
>> : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (mse=
c) :=20
>> 250=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D11.2=
6%,=20
>> ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0.5%, =
4=3D2.0%,=20
>> 8=3D11.5%, 16=3D77.8%, 32=3D8.1%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=
=3D100.0%,=20
>> 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : =
0=3D0.0%,=20
>> 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, >=3D64=3D0.0% =
issued :=20
>> total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=3Dr=
=3D0/w=3D0/d=3D0 latency :=20
>> target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>=20
>> Run status group 0 (all jobs):=20
>> READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s, maxb=3D1=
036.8MB/s,=20
>> mint=3D7389msec, maxt=3D7389msec=20
>>=20
>> Disk stats (read/write):=20
>> sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0.0=
3%=20
>>=20
>>=20
>>=20
>>=20
>> CEPH LOG=20
>> --------=20
>>=20
>> before restarting osd=20
>> ----------------------=20
>>=20
>> 2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster=20
>> [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 298 MB/s rd, 76465 op/s=20
>> 2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster=20
>> [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 333 MB/s rd, 85355 op/s=20
>> 2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster=20
>> [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 343 MB/s rd, 87932 op/s=20
>> 2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster=20
>> [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 328 MB/s rd, 84151 op/s=20
>> 2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster=20
>> [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 237 MB/s rd, 60855 op/s=20
>> 2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster=20
>> [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 144 MB/s rd, 36935 op/s=20
>> 2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster=20
>> [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 321 MB/s rd, 82334 op/s=20
>> 2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster=20
>> [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 368 MB/s rd, 94211 op/s=20
>> 2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster=20
>> [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 244 MB/s rd, 62644 op/s=20
>> 2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster=20
>> [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 175 MB/s rd, 44997 op/s=20
>> 2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster=20
>> [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 122 MB/s rd, 31259 op/s=20
>> 2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster=20
>> [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 229 MB/s rd, 58674 op/s=20
>> 2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster=20
>> [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 271 MB/s rd, 69501 op/s=20
>> 2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster=20
>> [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 211 MB/s rd, 54020 op/s=20
>> 2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster=20
>> [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 164 MB/s rd, 42001 op/s=20
>> 2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster=20
>> [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 134 MB/s rd, 34380 op/s=20
>> 2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster=20
>> [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 293 MB/s rd, 75213 op/s=20
>> 2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster=20
>> [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 337 MB/s rd, 86353 op/s=20
>> 2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster=20
>> [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 229 MB/s rd, 58839 op/s=20
>> 2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster=20
>> [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB =
/=20
>> 1295 GB avail; 152 MB/s rd, 39117 op/s=20
>>=20
>>=20
>> restarting osd=20
>> ---------------=20
>>=20
>> 2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster=20
>> [INF] osd.0 marked itself down=20
>> 2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster=20
>> [INF] osdmap e849: 9 osds: 8 up, 9 in=20
>> 2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster=20
>> [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8=20
>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 7=
94=20
>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 516=20
>> kB/s rd, 130 op/s=20
>> 2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster=20
>> [INF] osdmap e850: 9 osds: 8 up, 9 in=20
>> 2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster=20
>> [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8=20
>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 7=
94=20
>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster=20
>> [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8=20
>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 7=
94=20
>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster=20
>> [INF] osd.1 marked itself down=20
>> 2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster=20
>> [INF] osdmap e851: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster=20
>> [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13=20
>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 6=
84=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster=20
>> [INF] osdmap e852: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster=20
>> [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13=20
>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 6=
84=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster=20
>> [INF] osd.2 marked itself down=20
>> 2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster=20
>> [INF] osdmap e853: 9 osds: 6 up, 9 in=20
>> 2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster=20
>> [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22=20
>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 6=
00=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster=20
>> [INF] osdmap e854: 9 osds: 6 up, 9 in=20
>> 2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster=20
>> [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22=20
>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 6=
00=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster=20
>> [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck=20
>> degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs=20
>> undersized; 3/9 in osds are down; clock skew detected on mon.ceph1-2=
=20
>> 2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster=20
>> [INF] osd.1 10.7.0.152:6800/14848 boot=20
>> 2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster=20
>> [INF] osdmap e855: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster=20
>> [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22=20
>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 6=
00=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster=20
>> [INF] osd.3 marked itself down=20
>> 2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster=20
>> [INF] osdmap e856: 9 osds: 6 up, 9 in=20
>> 2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster=20
>> [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25=20
>> stale+active+remapped, 394 stale+active+clean, 37 active+remapped, 5=
06=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster=20
>> [INF] osd.6 marked itself down=20
>> 2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster=20
>> [INF] osd.2 10.7.0.152:6812/15410 boot=20
>> 2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster=20
>> [INF] osdmap e857: 9 osds: 6 up, 9 in=20
>> 2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster=20
>> [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30=20
>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 3=
98=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster=20
>> [INF] osdmap e858: 9 osds: 6 up, 9 in=20
>> 2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster=20
>> [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30=20
>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 3=
98=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster=20
>> [INF] osd.3 10.7.0.152:6816/15971 boot=20
>> 2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster=20
>> [INF] osdmap e859: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster=20
>> [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30=20
>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 3=
98=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster=20
>> [INF] osd.7 marked itself down=20
>> 2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster=20
>> [INF] osd.0 10.7.0.152:6804/14481 boot=20
>> 2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster=20
>> [INF] osdmap e860: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster=20
>> [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35=20
>> stale+active+remapped, 608 stale+active+clean, 27 active+remapped, 2=
92=20
>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 G=
B=20
>> used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster=20
>> [INF] osd.6 10.7.0.153:6808/21955 boot=20
>> 2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster=20
>> [INF] osdmap e861: 9 osds: 8 up, 9 in=20
>> 2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster=20
>> [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27=20
>> stale+active+remapped, 498 stale+active+clean, 2 peering, 28=20
>> active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data,=20
>> 420 GB used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster=20
>> [INF] osd.8 marked itself down=20
>> 2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster=20
>> [INF] osdmap e862: 9 osds: 7 up, 9 in=20
>> 2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster=20
>> [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44=20
>> stale+active+remapped, 587 stale+active+clean, 2 peering, 11=20
>> active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data,=20
>> 420 GB used, 874 GB / 1295 GB avail=20
>> 2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster=20
>> [INF] osd.7 10.7.0.153:6804/22536 boot=20
>> 2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster=20
>> [INF] osdmap e863: 9 osds: 8 up, 9 in=20
>> 2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster=20
>> [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31=20
>> stale+active+remapped, 503 stale+active+clean, 4=20
>> active+undersized+degraded+remapped, 5 peering, 13 active+remapped,=20
>> 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874 =
GB=20
>> / 1295 GB avail=20
>> 2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster=20
>> [INF] osdmap e864: 9 osds: 8 up, 9 in=20
>> 2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster=20
>> [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31=20
>> stale+active+remapped, 503 stale+active+clean, 4=20
>> active+undersized+degraded+remapped, 5 peering, 13 active=20
>>=20
>>=20
>> AFTER OSD RESTART=20
>> ------------------=20
>>=20
>>=20
>> 2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster=20
>> [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 786 MB/s rd, 196 kop/s=20
>> 2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster=20
>> [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 1578 MB/s rd, 394 kop/s=20
>> 2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster=20
>> [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 932 MB/s rd, 233 kop/s=20
>> 2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster=20
>> [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 627 MB/s rd, 156 kop/s=20
>> 2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster=20
>> [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 1034 MB/s rd, 258 kop/s=20
>> 2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster=20
>> [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 529 MB/s rd, 132 kop/s=20
>> 2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster=20
>> [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 770 MB/s rd, 192 kop/s=20
>> 2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster=20
>> [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 1358 MB/s rd, 339 kop/s=20
>> 2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster=20
>> [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 649 MB/s rd, 162 kop/s=20
>> 2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster=20
>> [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 580 MB/s rd, 145 kop/s=20
>> 2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster=20
>> [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 962 MB/s rd, 240 kop/s=20
>> 2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster=20
>> [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 506 MB/s rd, 126 kop/s=20
>> 2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster=20
>> [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 774 MB/s rd, 193 kop/s=20
>> 2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster=20
>> [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 1363 MB/s rd, 340 kop/s=20
>> 2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster=20
>> [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 662 MB/s rd, 165 kop/s=20
>> 2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster=20
>> [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 593 MB/s rd, 148 kop/s=20
>> 2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster=20
>> [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62=20
>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB =
/=20
>> 1295 GB avail; 938 MB/s rd, 234 kop/s=20
>>=20
>> _______________________________________________=20
>> ceph-users mailing list=20
>> ceph-users@lists.ceph.com=20
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>=20
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
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
