From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: strange benchmark problem : restarting osd daemon
	improve performance from 100k iops to 300k iops
Date: Fri, 24 Apr 2015 19:36:39 +0200
Message-ID: <BEEF4E3E-92BD-4E41-8E17-5BF9476A3674@profihost.ag>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
	<336199846.535234014.1429720226874.JavaMail.zimbra@oxygem.tv>
	<1806383776.554938002.1429776034371.JavaMail.zimbra@oxygem.tv>
	<1112295705.562655711.1429786696959.JavaMail.zimbra@oxygem.tv>
	<5538D86C.1090506@redhat.com>
	<1903663405.564474385.1429790186021.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD806BE@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAF-rypyB=CjjJQs_+3Q=ELCVwpg9nyWKdBu8gVyuDQa49=GHtw@mail.gmail.com>
	<1270073308.621430804.1429893511370.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============1625606596=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1270073308.621430804.1429893511370.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1625606596==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-50BD8F93-C937-43B3-80DF-70C3370A2992
Content-Transfer-Encoding: 7bit


--Apple-Mail-50BD8F93-C937-43B3-80DF-70C3370A2992
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Is jemalloc recommanded in general? Does it also work for firefly?

Stefan

Excuse my typo sent from my mobile phone.

> Am 24.04.2015 um 18:38 schrieb Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>:
>=20
> Hi,
>=20
> I have finished to rebuild ceph with jemalloc,
>=20
> all seem to working fine.
>=20
> I got a constant 300k iops for the moment, so no speed regression.
>=20
> I'll do more long benchmark next week.
>=20
> Regards,
>=20
> Alexandre
>=20
> ----- Mail original -----
> De: "Irek Fasikhov" <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> =C3=80: "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> Cc: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,=
 "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY@public.gmane.org=
nel.org>, "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> Envoy=C3=A9: Vendredi 24 Avril 2015 13:37:52
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd daemon i=
mprove performance from 100k iops to 300k iops
>=20
> Hi,Alexandre!=20
> Do not try to change the parameter vm.min_free_kbytes?=20
>=20
> 2015-04-23 19:24 GMT+03:00 Somnath Roy < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org > :=20
>=20
>=20
> Alexandre,=20
> You can configure with --with-jemalloc or ./do_autogen -J to build ceph wi=
th jemalloc.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: ceph-users [mailto: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org ] On Behalf Of=
 Alexandre DERUMIER=20
> Sent: Thursday, April 23, 2015 4:56 AM=20
> To: Mark Nelson=20
> Cc: ceph-users; ceph-devel; Milosz Tanski=20
> Subject: Re: [ceph-users] strange benchmark problem : restarting osd daemo=
n improve performance from 100k iops to 300k iops=20
>=20
>>> If you have the means to compile the same version of ceph with=20
>>> jemalloc, I would be very interested to see how it does.
>=20
> Yes, sure. (I have around 3-4 weeks to do all the benchs)=20
>=20
> But I don't know how to do it ?=20
> I'm running the cluster on centos7.1, maybe it can be easy to patch the sr=
pms to rebuild the package with jemalloc.=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >=20
> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "Srinivasula Maram" < Sriniva=
sula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >=20
> Cc: "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >, "ceph-devel" < ceph-devel@=
vger.kernel.org >, "Milosz Tanski" < milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org >=20
> Envoy=C3=A9: Jeudi 23 Avril 2015 13:33:00=20
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd daemon i=
mprove performance from 100k iops to 300k iops=20
>=20
> Thanks for the testing Alexandre!=20
>=20
> If you have the means to compile the same version of ceph with jemalloc, I=
 would be very interested to see how it does.=20
>=20
> In some ways I'm glad it turned out not to be NUMA. I still suspect we wil=
l have to deal with it at some point, but perhaps not today. ;)=20
>=20
> Mark=20
>=20
>> On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote:=20
>> Maybe it's tcmalloc related=20
>> I thinked to have patched it correctly, but perf show a lot of=20
>> tcmalloc::ThreadCache::ReleaseToCentralCache=20
>>=20
>> before osd restart (100k)=20
>> ------------------=20
>> 11.66% ceph-osd libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::ThreadCache::ReleaseToCentralCache=20
>> 8.51% ceph-osd libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::FetchFromSpans=20
>> 3.04% ceph-osd libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::ReleaseToSpans=20
>> 2.04% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.63% swapper=20
>> [kernel.kallsyms] [k] intel_idle 1.35% ceph-osd libtcmalloc.so.4.1.2=20
>> [.] tcmalloc::CentralFreeList::ReleaseListToSpans=20
>> 1.33% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete 1.07% ceph-osd=20=

>> libstdc++.so.6.0.19 [.] std::basic_string<char,=20
>> std::char_traits<char>, std::allocator<char> >::basic_string 0.91%=20
>> ceph-osd libpthread-2.17.so [.] pthread_mutex_trylock 0.88% ceph-osd=20
>> libc-2.17.so [.] __memcpy_ssse3_back 0.81% ceph-osd ceph-osd [.]=20
>> Mutex::Lock 0.79% ceph-osd [kernel.kallsyms] [k]=20
>> copy_user_enhanced_fast_string 0.74% ceph-osd libpthread-2.17.so [.]=20
>> pthread_mutex_unlock 0.67% ceph-osd [kernel.kallsyms] [k]=20
>> _raw_spin_lock 0.63% swapper [kernel.kallsyms] [k]=20
>> native_write_msr_safe 0.62% ceph-osd [kernel.kallsyms] [k]=20
>> avc_has_perm_noaudit 0.58% ceph-osd ceph-osd [.] operator< 0.57%=20
>> ceph-osd [kernel.kallsyms] [k] __schedule 0.57% ceph-osd=20
>> [kernel.kallsyms] [k] __d_lookup_rcu 0.54% swapper [kernel.kallsyms]=20
>> [k] __schedule=20
>>=20
>>=20
>> after osd restart (300k iops)=20
>> ------------------------------=20
>> 3.47% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.92% ceph-osd=20
>> libtcmalloc.so.4.1.2 [.] operator delete 1.86% swapper=20
>> [kernel.kallsyms] [k] intel_idle 1.52% ceph-osd libstdc++.so.6.0.19=20
>> [.] std::basic_string<char, std::char_traits<char>,=20
>> std::allocator<char> >::basic_string 1.34% ceph-osd=20
>> libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentralCache=20
>> 1.24% ceph-osd libc-2.17.so [.] __memcpy_ssse3_back 1.23% ceph-osd=20
>> ceph-osd [.] Mutex::Lock 1.21% ceph-osd libpthread-2.17.so [.]=20
>> pthread_mutex_trylock 1.11% ceph-osd [kernel.kallsyms] [k]=20
>> copy_user_enhanced_fast_string 0.95% ceph-osd libpthread-2.17.so [.]=20
>> pthread_mutex_unlock 0.94% ceph-osd [kernel.kallsyms] [k]=20
>> _raw_spin_lock 0.78% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu=20
>> 0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg 0.70% ceph-osd=20
>> ceph-osd [.] Message::Message 0.68% ceph-osd [kernel.kallsyms] [k]=20
>> __schedule 0.66% ceph-osd [kernel.kallsyms] [k] idle_cpu 0.65%=20
>> ceph-osd libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::FetchFromSpans=20
>> 0.64% swapper [kernel.kallsyms] [k] native_write_msr_safe 0.61%=20
>> ceph-osd ceph-osd [.]=20
>> std::tr1::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release=20
>> 0.60% swapper [kernel.kallsyms] [k] __schedule 0.60% ceph-osd=20
>> libstdc++.so.6.0.19 [.] 0x00000000000bdd2b 0.57% ceph-osd ceph-osd [.]=20=

>> operator< 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00 0.56% ceph-osd=20
>> libstdc++.so.6.0.19 [.] std::string::_Rep::_M_dispose 0.55% ceph-osd=20
>> [kernel.kallsyms] [k] __switch_to 0.54% ceph-osd libc-2.17.so [.]=20
>> vfprintf 0.52% ceph-osd [kernel.kallsyms] [k] fget_light=20
>>=20
>> ----- Mail original -----=20
>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>> =C3=80: "Srinivasula Maram" < Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >=20
>> Cc: "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >, "ceph-devel"=20
>> < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "Milosz Tanski" < milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org >=20
>> Envoy=C3=A9: Jeudi 23 Avril 2015 10:00:34=20
>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd=20
>> daemon improve performance from 100k iops to 300k iops=20
>>=20
>> Hi,=20
>> I'm hitting this bug again today.=20
>>=20
>> So don't seem to be numa related (I have try to flush linux buffer to be s=
ure).=20
>>=20
>> and tcmalloc is patched (I don't known how to verify that it's ok).=20
>>=20
>> I don't have restarted osd yet.=20
>>=20
>> Maybe some perf trace could be usefulll ?=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>> =C3=80: "Srinivasula Maram" < Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >=20
>> Cc: "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >, "ceph-devel"=20
>> < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "Milosz Tanski" < milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org >=20
>> Envoy=C3=A9: Mercredi 22 Avril 2015 18:30:26=20
>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd=20
>> daemon improve performance from 100k iops to 300k iops=20
>>=20
>> Hi,=20
>>=20
>>>> I feel it is due to tcmalloc issue
>>=20
>> Indeed, I had patched one of my node, but not the other.=20
>> So maybe I have hit this bug. (but I can't confirm, I don't have traces).=
=20
>>=20
>> But numa interleaving seem to help in my case (maybe not from 100->300k, b=
ut 250k->300k).=20
>>=20
>> I need to do more long tests to confirm that.=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "Srinivasula Maram" < Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >=20
>> =C3=80: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >, "aderumier"=20
>> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "Milosz Tanski" < milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org >=20
>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users"=20
>> < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>> Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33=20
>> Objet: RE: [ceph-users] strange benchmark problem : restarting osd=20
>> daemon improve performance from 100k iops to 300k iops=20
>>=20
>> I feel it is due to tcmalloc issue=20
>>=20
>> I have seen similar issue in my setup after 20 days.=20
>>=20
>> Thanks,=20
>> Srinivas=20
>>=20
>>=20
>>=20
>> -----Original Message-----=20
>> From: ceph-users [mailto: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org ] On Behalf=20=

>> Of Mark Nelson=20
>> Sent: Wednesday, April 22, 2015 7:31 PM=20
>> To: Alexandre DERUMIER; Milosz Tanski=20
>> Cc: ceph-devel; ceph-users=20
>> Subject: Re: [ceph-users] strange benchmark problem : restarting osd=20
>> daemon improve performance from 100k iops to 300k iops=20
>>=20
>> Hi Alexandre,=20
>>=20
>> We should discuss this at the perf meeting today. We knew NUMA node affin=
ity issues were going to crop up sooner or later (and indeed already have in=
 some cases), but this is pretty major. It's probably time to really dig in a=
nd figure out how to deal with this.=20
>>=20
>> Note: this is one of the reasons I like small nodes with single sockets a=
nd fewer OSDs.=20
>>=20
>> Mark=20
>>=20
>>> On 04/22/2015 08:56 AM, Alexandre DERUMIER wrote:=20
>>> Hi,=20
>>>=20
>>> I have done a lot of test today, and it seem indeed numa related.=20
>>>=20
>>> My numastat was=20
>>>=20
>>> # numastat=20
>>> node0 node1=20
>>> numa_hit 99075422 153976877=20
>>> numa_miss 167490965 1493663=20
>>> numa_foreign 1493663 167491417=20
>>> interleave_hit 157745 167015=20
>>> local_node 99049179 153830554=20
>>> other_node 167517697 1639986=20
>>>=20
>>> So, a lot of miss.=20
>>>=20
>>> In this case , I can reproduce ios going from 85k to 300k iops, up and d=
own.=20
>>>=20
>>> now setting=20
>>> echo 0 > /proc/sys/kernel/numa_balancing=20
>>>=20
>>> and starting osd daemons with=20
>>>=20
>>> numactl --interleave=3Dall /usr/bin/ceph-osd=20
>>>=20
>>>=20
>>> I have a constant 300k iops !=20
>>>=20
>>>=20
>>> I wonder if it could be improve by binding osd daemons to specific numa n=
ode.=20
>>> I have 2 numanode of 10 cores with 6 osd, but I think it also require ce=
ph.conf osd threads tunning.=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "Milosz Tanski" < milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org >=20
>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users"=20
>>> < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>> Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23=20
>>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd=20
>>> daemon improve performance from 100k iops to 300k iops=20
>>>=20
>>>=20
>>>=20
>>> On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER < aderumier-U/x3PoR4x10@public.gmane.org=
m > wrote:=20
>>>=20
>>>=20
>>> I wonder if it could be numa related,=20
>>>=20
>>> I'm using centos 7.1,=20
>>> and auto numa balacning is enabled=20
>>>=20
>>> cat /proc/sys/kernel/numa_balancing =3D 1=20
>>>=20
>>> Maybe osd daemon access to buffer on wrong numa node.=20
>>>=20
>>> I'll try to reproduce the problem=20
>>>=20
>>>=20
>>>=20
>>> Can you force the degenerate case using numactl? To either affirm or den=
y your suspicion.=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>> =C3=80: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" <=20
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>> Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05=20
>>> Objet: [ceph-users] strange benchmark problem : restarting osd daemon=20=

>>> improve performance from 100k iops to 300k iops=20
>>>=20
>>> Hi,=20
>>>=20
>>> I was doing some benchmarks,=20
>>> I have found an strange behaviour.=20
>>>=20
>>> Using fio with rbd engine, I was able to reach around 100k iops.=20
>>> (osd datas in linux buffer, iostat show 0% disk access)=20
>>>=20
>>> then after restarting all osd daemons,=20
>>>=20
>>> the same fio benchmark show now around 300k iops.=20
>>> (osd datas in linux buffer, iostat show 0% disk access)=20
>>>=20
>>>=20
>>> any ideas?=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> before restarting osd=20
>>> ---------------------=20
>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>>> ioengine=3Drbd, iodepth=3D32 ...=20
>>> fio-2.2.7-10-g51e9=20
>>> Starting 10 processes=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0/0=20=

>>> iops] [eta 14m:45s]=20
>>> fio: terminating on signal 2=20
>>>=20
>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075: Wed=
 Apr=20
>>> 22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871, ru=
nt=3D=20
>>> 26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D17.38 c=
lat=20
>>> (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23 lat (usec):=
=20
>>> min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42 clat percentiles=20=

>>> (usec):=20
>>> | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ 247],=20=

>>> | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D[ 660]=
,=20
>>> | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D[14=
656],=20
>>> | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D[41=
728],=20
>>> | 99.99th=3D[47360]=20
>>> bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.82,=20
>>> stdev=3D28809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D=
0.01%,=20
>>> 250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03% lat (m=
sec) :=20
>>> 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37% lat (msec) : 10=
0=3D0.01%=20
>>> cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710 IO d=
epths :=20
>>> 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, >=3D64=3D=
0.0% submit :=20
>>> 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D=
0.0%=20
>>> complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D0.0=
%,=20
>>>> =3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=3D0/w=3D=
0/d=3D0,
>>> drop=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=3D=
100.00%,=20
>>> depth=3D32=20
>>>=20
>>> Run status group 0 (all jobs):=20
>>> READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D451487=
KB/s,=20
>>> mint=3D26215msec, maxt=3D26215msec=20
>>>=20
>>> Disk stats (read/write):=20
>>> sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0.01%=20=

>>> [root@ceph1-3 fiorbd]# ./fio fiorbd=20
>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>>> ioengine=3Drbd, iodepth=3D32=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> AFTER RESTARTING OSDS=20
>>> ----------------------=20
>>> [root@ceph1-3 fiorbd]# ./fio fiorbd=20
>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,=20
>>> ioengine=3Drbd, iodepth=3D32 ...=20
>>> fio-2.2.7-10-g51e9=20
>>> Starting 10 processes=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> rbd engine: RBD version: 0.1.9=20
>>> ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0=20
>>> iops] [eta 01h:09m:27s]=20
>>> fio: terminating on signal 2=20
>>>=20
>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252: Wed=
 Apr=20
>>> 22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265218,=20=

>>> runt=3D 7389msec slat (usec): min=3D5, max=3D3406, avg=3D26.59, stdev=3D=
40.35=20
>>> clat=20
>>> (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat (usec):=
=20
>>> min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat percentiles=20=

>>> (usec):=20
>>> | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ 450],=20=

>>> | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ 796]=
,=20
>>> | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D[ 17=
20],=20
>>> | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=3D[ 9=
792],=20
>>> | 99.99th=3D[436224]=20
>>> bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46,=20=

>>> stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D=
0.01%,=20
>>> 250=3D1.23% lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84% lat (=
msec)=20
>>> : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (msec) :=
=20
>>> 250=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D11.26%,=20=

>>> ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0.5%, 4=3D=
2.0%,=20
>>> 8=3D11.5%, 16=3D77.8%, 32=3D8.1%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=3D1=
00.0%,=20
>>> 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : 0=3D=
0.0%,=20
>>> 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, >=3D64=3D0.0% issu=
ed :=20
>>> total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=3Dr=3D0=
/w=3D0/d=3D0 latency :=20
>>> target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>=20
>>> Run status group 0 (all jobs):=20
>>> READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s,=20
>>> maxb=3D1036.8MB/s, mint=3D7389msec, maxt=3D7389msec=20
>>>=20
>>> Disk stats (read/write):=20
>>> sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0.03%=20=

>>>=20
>>>=20
>>>=20
>>>=20
>>> CEPH LOG=20
>>> --------=20
>>>=20
>>> before restarting osd=20
>>> ----------------------=20
>>>=20
>>> 2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster=20
>>> [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 298 MB/s rd, 76465 op/s=20
>>> 2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster=20
>>> [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 333 MB/s rd, 85355 op/s=20
>>> 2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster=20
>>> [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 343 MB/s rd, 87932 op/s=20
>>> 2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster=20
>>> [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 328 MB/s rd, 84151 op/s=20
>>> 2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster=20
>>> [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 237 MB/s rd, 60855 op/s=20
>>> 2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster=20
>>> [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 144 MB/s rd, 36935 op/s=20
>>> 2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster=20
>>> [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 321 MB/s rd, 82334 op/s=20
>>> 2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster=20
>>> [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 368 MB/s rd, 94211 op/s=20
>>> 2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster=20
>>> [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 244 MB/s rd, 62644 op/s=20
>>> 2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster=20
>>> [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 175 MB/s rd, 44997 op/s=20
>>> 2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster=20
>>> [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 122 MB/s rd, 31259 op/s=20
>>> 2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster=20
>>> [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 229 MB/s rd, 58674 op/s=20
>>> 2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster=20
>>> [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 271 MB/s rd, 69501 op/s=20
>>> 2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster=20
>>> [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 211 MB/s rd, 54020 op/s=20
>>> 2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster=20
>>> [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 164 MB/s rd, 42001 op/s=20
>>> 2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster=20
>>> [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 134 MB/s rd, 34380 op/s=20
>>> 2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster=20
>>> [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 293 MB/s rd, 75213 op/s=20
>>> 2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster=20
>>> [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 337 MB/s rd, 86353 op/s=20
>>> 2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster=20
>>> [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 229 MB/s rd, 58839 op/s=20
>>> 2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster=20
>>> [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=20=

>>> 1295 GB avail; 152 MB/s rd, 39117 op/s=20
>>>=20
>>>=20
>>> restarting osd=20
>>> ---------------=20
>>>=20
>>> 2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster=20
>>> [INF] osd.0 marked itself down=20
>>> 2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster=20
>>> [INF] osdmap e849: 9 osds: 8 up, 9 in=20
>>> 2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster=20
>>> [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8=20
>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=20
>>> stale+active+794=20
>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 516=20
>>> kB/s rd, 130 op/s=20
>>> 2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster=20
>>> [INF] osdmap e850: 9 osds: 8 up, 9 in=20
>>> 2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster=20
>>> [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8=20
>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=20
>>> stale+active+794=20
>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster=20
>>> [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8=20
>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=20
>>> stale+active+794=20
>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster=20
>>> [INF] osd.1 marked itself down=20
>>> 2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster=20
>>> [INF] osdmap e851: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster=20
>>> [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13=20
>>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped,=20
>>> stale+active+684=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster=20
>>> [INF] osdmap e852: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster=20
>>> [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13=20
>>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped,=20
>>> stale+active+684=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster=20
>>> [INF] osd.2 marked itself down=20
>>> 2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster=20
>>> [INF] osdmap e853: 9 osds: 6 up, 9 in=20
>>> 2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster=20
>>> [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22=20
>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=20
>>> stale+active+600=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster=20
>>> [INF] osdmap e854: 9 osds: 6 up, 9 in=20
>>> 2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster=20
>>> [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22=20
>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=20
>>> stale+active+600=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster=20
>>> [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck=20
>>> degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs=20
>>> undersized; 3/9 in osds are down; clock skew detected on mon.ceph1-2=20
>>> 2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster=20
>>> [INF] osd.1 10.7.0.152:6800/14848 boot=20
>>> 2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster=20
>>> [INF] osdmap e855: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster=20
>>> [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22=20
>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=20
>>> stale+active+600=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster=20
>>> [INF] osd.3 marked itself down=20
>>> 2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster=20
>>> [INF] osdmap e856: 9 osds: 6 up, 9 in=20
>>> 2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster=20
>>> [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25=20
>>> stale+active+remapped, 394 stale+active+clean, 37 active+remapped,=20
>>> stale+active+506=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster=20
>>> [INF] osd.6 marked itself down=20
>>> 2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster=20
>>> [INF] osd.2 10.7.0.152:6812/15410 boot=20
>>> 2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster=20
>>> [INF] osdmap e857: 9 osds: 6 up, 9 in=20
>>> 2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster=20
>>> [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30=20
>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=20
>>> stale+active+398=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster=20
>>> [INF] osdmap e858: 9 osds: 6 up, 9 in=20
>>> 2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster=20
>>> [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30=20
>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=20
>>> stale+active+398=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster=20
>>> [INF] osd.3 10.7.0.152:6816/15971 boot=20
>>> 2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster=20
>>> [INF] osdmap e859: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster=20
>>> [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30=20
>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=20
>>> stale+active+398=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster=20
>>> [INF] osd.7 marked itself down=20
>>> 2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster=20
>>> [INF] osd.0 10.7.0.152:6804/14481 boot=20
>>> 2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster=20
>>> [INF] osdmap e860: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster=20
>>> [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35=20
>>> stale+active+remapped, 608 stale+active+clean, 27 active+remapped,=20
>>> stale+active+292=20
>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB=20=

>>> used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster=20
>>> [INF] osd.6 10.7.0.153:6808/21955 boot=20
>>> 2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster=20
>>> [INF] osdmap e861: 9 osds: 8 up, 9 in=20
>>> 2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster=20
>>> [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27=20
>>> stale+active+remapped, 498 stale+active+clean, 2 peering, 28=20
>>> active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data,=20
>>> 420 GB used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster=20
>>> [INF] osd.8 marked itself down=20
>>> 2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster=20
>>> [INF] osdmap e862: 9 osds: 7 up, 9 in=20
>>> 2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster=20
>>> [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44=20
>>> stale+active+remapped, 587 stale+active+clean, 2 peering, 11=20
>>> active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data,=20
>>> 420 GB used, 874 GB / 1295 GB avail=20
>>> 2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster=20
>>> [INF] osd.7 10.7.0.153:6804/22536 boot=20
>>> 2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster=20
>>> [INF] osdmap e863: 9 osds: 8 up, 9 in=20
>>> 2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster=20
>>> [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31=20
>>> stale+active+remapped, 503 stale+active+clean, 4=20
>>> active+undersized+degraded+remapped, 5 peering, 13 active+remapped,=20
>>> 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874=20
>>> GB / 1295 GB avail=20
>>> 2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster=20
>>> [INF] osdmap e864: 9 osds: 8 up, 9 in=20
>>> 2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster=20
>>> [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31=20
>>> stale+active+remapped, 503 stale+active+clean, 4=20
>>> active+undersized+degraded+remapped, 5 peering, 13 active=20
>>>=20
>>>=20
>>> AFTER OSD RESTART=20
>>> ------------------=20
>>>=20
>>>=20
>>> 2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster=20
>>> [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 786 MB/s rd, 196 kop/s=20
>>> 2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster=20
>>> [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 1578 MB/s rd, 394 kop/s=20
>>> 2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster=20
>>> [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 932 MB/s rd, 233 kop/s=20
>>> 2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster=20
>>> [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 627 MB/s rd, 156 kop/s=20
>>> 2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster=20
>>> [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 1034 MB/s rd, 258 kop/s=20
>>> 2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster=20
>>> [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 529 MB/s rd, 132 kop/s=20
>>> 2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster=20
>>> [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 770 MB/s rd, 192 kop/s=20
>>> 2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster=20
>>> [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 1358 MB/s rd, 339 kop/s=20
>>> 2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster=20
>>> [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 649 MB/s rd, 162 kop/s=20
>>> 2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster=20
>>> [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 580 MB/s rd, 145 kop/s=20
>>> 2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster=20
>>> [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 962 MB/s rd, 240 kop/s=20
>>> 2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster=20
>>> [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 506 MB/s rd, 126 kop/s=20
>>> 2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster=20
>>> [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 774 MB/s rd, 193 kop/s=20
>>> 2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster=20
>>> [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 1363 MB/s rd, 340 kop/s=20
>>> 2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster=20
>>> [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 662 MB/s rd, 165 kop/s=20
>>> 2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster=20
>>> [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 593 MB/s rd, 148 kop/s=20
>>> 2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster=20
>>> [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62=20
>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /=20=

>>> 1295 GB avail; 938 MB/s rd, 234 kop/s=20
>>>=20
>>> _______________________________________________=20
>>> ceph-users mailing list=20
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________=20
>> ceph-users mailing list=20
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>=20
>> ________________________________=20
>>=20
>> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If th=
e reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, dissem=
ination, distribution, or copying of this message is strictly prohibited. If=
 you have received this communication in error, please notify the sender by t=
elephone or e-mail (as shown above) immediately and destroy any and all copi=
es of this message in your possession (whether hard copies or electronically=
 stored copies).=20
>>=20
>> _______________________________________________=20
>> ceph-users mailing list=20
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>=20
>> _______________________________________________=20
>> ceph-users mailing list=20
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=
=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87=20
> =D0=9C=D0=BE=D0=B1.: +79229045757=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Apple-Mail-50BD8F93-C937-43B3-80DF-70C3370A2992
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Is jemalloc recommanded in general? Do=
es it also work for firefly?<br><br>Stefan<div><br></div><div>Excuse my typo=
 s<span style=3D"font-size: 13pt;">ent from my mobile phone.</span></div></d=
iv><div><br>Am 24.04.2015 um 18:38 schrieb Alexandre DERUMIER &lt;<a href=3D=
"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;:<br><br></div><bloc=
kquote type=3D"cite"><div><span>Hi,</span><br><span></span><br><span>I have f=
inished to rebuild ceph with jemalloc,</span><br><span></span><br><span>all s=
eem to working fine.</span><br><span></span><br><span>I got a constant 300k i=
ops for the moment, so no speed regression.</span><br><span></span><br><span=
>I'll do more long benchmark next week.</span><br><span></span><br><span>Reg=
ards,</span><br><span></span><br><span>Alexandre</span><br><span></span><br>=
<span>----- Mail original -----</span><br><span>De: "Irek Fasikhov" &lt;<a h=
ref=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span><br><span>=C3=
=80: "Somnath Roy" &lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Ro=
y@sandisk.com</a>&gt;</span><br><span>Cc: "aderumier" &lt;<a href=3D"mailto:=
aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;, "Mark Nelson" &lt;<a href=3D=
"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, "ceph-users" &lt;<a h=
ref=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, "=
ceph-devel" &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@vge=
r.kernel.org</a>&gt;, "Milosz Tanski" &lt;<a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org=
">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a>&gt;</span><br><span>Envoy=C3=A9: Vendredi 24 Avril 20=
15 13:37:52</span><br><span>Objet: Re: [ceph-users] strange benchmark proble=
m : restarting osd daemon improve performance from 100k iops to 300k iops</s=
pan><br><span></span><br><span>Hi,Alexandre! </span><br><span>Do not try to c=
hange the parameter vm.min_free_kbytes? </span><br><span></span><br><span>20=
15-04-23 19:24 GMT+03:00 Somnath Roy &lt; <a href=3D"mailto:Somnath.Roy@sand=
isk.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt; : </span><br><span></span><br><spa=
n></span><br><span>Alexandre, </span><br><span>You can configure with --with=
-jemalloc or ./do_autogen -J to build ceph with jemalloc. </span><br><span><=
/span><br><span>Thanks &amp; Regards </span><br><span>Somnath </span><br><sp=
an></span><br><span>-----Original Message----- </span><br><span>From: ceph-u=
sers [mailto: <a href=3D"mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-user=
s-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> ] On Behalf Of Alexandre DERUMIER </span><br><s=
pan>Sent: Thursday, April 23, 2015 4:56 AM </span><br><span>To: Mark Nelson <=
/span><br><span>Cc: ceph-users; ceph-devel; Milosz Tanski </span><br><span>S=
ubject: Re: [ceph-users] strange benchmark problem : restarting osd daemon i=
mprove performance from 100k iops to 300k iops </span><br><span></span><br><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>If you have the mea=
ns to compile the same version of ceph with </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>jemalloc, I w=
ould be very interested to see how it does. </span><br></blockquote></blockq=
uote><span></span><br><span>Yes, sure. (I have around 3-4 weeks to do all th=
e benchs) </span><br><span></span><br><span>But I don't know how to do it ? <=
/span><br><span>I'm running the cluster on centos7.1, maybe it can be easy t=
o patch the srpms to rebuild the package with jemalloc. </span><br><span></s=
pan><br><span></span><br><span></span><br><span>----- Mail original ----- </=
span><br><span>De: "Mark Nelson" &lt; <a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt; </span><br><span>=C3=80: "aderumier" &lt; <a hre=
f=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;, "Srinivasula M=
aram" &lt; <a href=3D"mailto:Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Mara=
m@sandisk.com</a> &gt; </span><br><span>Cc: "ceph-users" &lt; <a href=3D"mai=
lto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;, "ceph-dev=
el" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org</a> &gt;, "Milosz Tanski" &lt; <a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">mil=
osz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a> &gt; </span><br><span>Envoy=C3=A9: Jeudi 23 Avril 2015 13:=
33:00 </span><br><span>Objet: Re: [ceph-users] strange benchmark problem : r=
estarting osd daemon improve performance from 100k iops to 300k iops </span>=
<br><span></span><br><span>Thanks for the testing Alexandre! </span><br><spa=
n></span><br><span>If you have the means to compile the same version of ceph=
 with jemalloc, I would be very interested to see how it does. </span><br><s=
pan></span><br><span>In some ways I'm glad it turned out not to be NUMA. I s=
till suspect we will have to deal with it at some point, but perhaps not tod=
ay. ;) </span><br><span></span><br><span>Mark </span><br><span></span><br><s=
pan>On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote: </span><br><blockquote=
 type=3D"cite"><span>Maybe it's tcmalloc related </span><br></blockquote><bl=
ockquote type=3D"cite"><span>I thinked to have patched it correctly, but per=
f show a lot of </span><br></blockquote><blockquote type=3D"cite"><span>tcma=
lloc::ThreadCache::ReleaseToCentralCache </span><br></blockquote><blockquote=
 type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span=
>before osd restart (100k) </span><br></blockquote><blockquote type=3D"cite"=
><span>------------------ </span><br></blockquote><blockquote type=3D"cite">=
<span>11.66% ceph-osd libtcmalloc.so.4.1.2 [.] </span><br></blockquote><bloc=
kquote type=3D"cite"><span>tcmalloc::ThreadCache::ReleaseToCentralCache </sp=
an><br></blockquote><blockquote type=3D"cite"><span>8.51% ceph-osd libtcmall=
oc.so.4.1.2 [.] </span><br></blockquote><blockquote type=3D"cite"><span>tcma=
lloc::CentralFreeList::FetchFromSpans </span><br></blockquote><blockquote ty=
pe=3D"cite"><span>3.04% ceph-osd libtcmalloc.so.4.1.2 [.] </span><br></block=
quote><blockquote type=3D"cite"><span>tcmalloc::CentralFreeList::ReleaseToSp=
ans </span><br></blockquote><blockquote type=3D"cite"><span>2.04% ceph-osd l=
ibtcmalloc.so.4.1.2 [.] operator new 1.63% swapper </span><br></blockquote><=
blockquote type=3D"cite"><span>[kernel.kallsyms] [k] intel_idle 1.35% ceph-o=
sd libtcmalloc.so.4.1.2 </span><br></blockquote><blockquote type=3D"cite"><s=
pan>[.] tcmalloc::CentralFreeList::ReleaseListToSpans </span><br></blockquot=
e><blockquote type=3D"cite"><span>1.33% ceph-osd libtcmalloc.so.4.1.2 [.] op=
erator delete 1.07% ceph-osd </span><br></blockquote><blockquote type=3D"cit=
e"><span>libstdc++.so.6.0.19 [.] std::basic_string&lt;char, </span><br></blo=
ckquote><blockquote type=3D"cite"><span>std::char_traits&lt;char&gt;, std::a=
llocator&lt;char&gt; &gt;::basic_string 0.91% </span><br></blockquote><block=
quote type=3D"cite"><span>ceph-osd libpthread-2.17.so [.] pthread_mutex_tryl=
ock 0.88% ceph-osd </span><br></blockquote><blockquote type=3D"cite"><span>l=
ibc-2.17.so [.] __memcpy_ssse3_back 0.81% ceph-osd ceph-osd [.] </span><br><=
/blockquote><blockquote type=3D"cite"><span>Mutex::Lock 0.79% ceph-osd [kern=
el.kallsyms] [k] </span><br></blockquote><blockquote type=3D"cite"><span>cop=
y_user_enhanced_fast_string 0.74% ceph-osd libpthread-2.17.so [.] </span><br=
></blockquote><blockquote type=3D"cite"><span>pthread_mutex_unlock 0.67% cep=
h-osd [kernel.kallsyms] [k] </span><br></blockquote><blockquote type=3D"cite=
"><span>_raw_spin_lock 0.63% swapper [kernel.kallsyms] [k] </span><br></bloc=
kquote><blockquote type=3D"cite"><span>native_write_msr_safe 0.62% ceph-osd [=
kernel.kallsyms] [k] </span><br></blockquote><blockquote type=3D"cite"><span=
>avc_has_perm_noaudit 0.58% ceph-osd ceph-osd [.] operator&lt; 0.57% </span>=
<br></blockquote><blockquote type=3D"cite"><span>ceph-osd [kernel.kallsyms] [=
k] __schedule 0.57% ceph-osd </span><br></blockquote><blockquote type=3D"cit=
e"><span>[kernel.kallsyms] [k] __d_lookup_rcu 0.54% swapper [kernel.kallsyms=
] </span><br></blockquote><blockquote type=3D"cite"><span>[k] __schedule </s=
pan><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote=
><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>after osd restart (300k iops) </span><br></blockquote><blockquo=
te type=3D"cite"><span>------------------------------ </span><br></blockquot=
e><blockquote type=3D"cite"><span>3.47% ceph-osd libtcmalloc.so.4.1.2 [.] op=
erator new 1.92% ceph-osd </span><br></blockquote><blockquote type=3D"cite">=
<span>libtcmalloc.so.4.1.2 [.] operator delete 1.86% swapper </span><br></bl=
ockquote><blockquote type=3D"cite"><span>[kernel.kallsyms] [k] intel_idle 1.=
52% ceph-osd libstdc++.so.6.0.19 </span><br></blockquote><blockquote type=3D=
"cite"><span>[.] std::basic_string&lt;char, std::char_traits&lt;char&gt;, </=
span><br></blockquote><blockquote type=3D"cite"><span>std::allocator&lt;char=
&gt; &gt;::basic_string 1.34% ceph-osd </span><br></blockquote><blockquote t=
ype=3D"cite"><span>libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseTo=
CentralCache </span><br></blockquote><blockquote type=3D"cite"><span>1.24% c=
eph-osd libc-2.17.so [.] __memcpy_ssse3_back 1.23% ceph-osd </span><br></blo=
ckquote><blockquote type=3D"cite"><span>ceph-osd [.] Mutex::Lock 1.21% ceph-=
osd libpthread-2.17.so [.] </span><br></blockquote><blockquote type=3D"cite"=
><span>pthread_mutex_trylock 1.11% ceph-osd [kernel.kallsyms] [k] </span><br=
></blockquote><blockquote type=3D"cite"><span>copy_user_enhanced_fast_string=
 0.95% ceph-osd libpthread-2.17.so [.] </span><br></blockquote><blockquote t=
ype=3D"cite"><span>pthread_mutex_unlock 0.94% ceph-osd [kernel.kallsyms] [k]=
 </span><br></blockquote><blockquote type=3D"cite"><span>_raw_spin_lock 0.78=
% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu </span><br></blockquote><blo=
ckquote type=3D"cite"><span>0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg=
 0.70% ceph-osd </span><br></blockquote><blockquote type=3D"cite"><span>ceph=
-osd [.] Message::Message 0.68% ceph-osd [kernel.kallsyms] [k] </span><br></=
blockquote><blockquote type=3D"cite"><span>__schedule 0.66% ceph-osd [kernel=
.kallsyms] [k] idle_cpu 0.65% </span><br></blockquote><blockquote type=3D"ci=
te"><span>ceph-osd libtcmalloc.so.4.1.2 [.] </span><br></blockquote><blockqu=
ote type=3D"cite"><span>tcmalloc::CentralFreeList::FetchFromSpans </span><br=
></blockquote><blockquote type=3D"cite"><span>0.64% swapper [kernel.kallsyms=
] [k] native_write_msr_safe 0.61% </span><br></blockquote><blockquote type=3D=
"cite"><span>ceph-osd ceph-osd [.] </span><br></blockquote><blockquote type=3D=
"cite"><span>std::tr1::_Sp_counted_base&lt;(__gnu_cxx::_Lock_policy)2&gt;::_=
M_release </span><br></blockquote><blockquote type=3D"cite"><span>0.60% swap=
per [kernel.kallsyms] [k] __schedule 0.60% ceph-osd </span><br></blockquote>=
<blockquote type=3D"cite"><span>libstdc++.so.6.0.19 [.] 0x00000000000bdd2b 0=
.57% ceph-osd ceph-osd [.] </span><br></blockquote><blockquote type=3D"cite"=
><span>operator&lt; 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00 0.56% ceph-os=
d </span><br></blockquote><blockquote type=3D"cite"><span>libstdc++.so.6.0.1=
9 [.] std::string::_Rep::_M_dispose 0.55% ceph-osd </span><br></blockquote><=
blockquote type=3D"cite"><span>[kernel.kallsyms] [k] __switch_to 0.54% ceph-=
osd libc-2.17.so [.] </span><br></blockquote><blockquote type=3D"cite"><span=
>vfprintf 0.52% ceph-osd [kernel.kallsyms] [k] fget_light </span><br></block=
quote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote ty=
pe=3D"cite"><span>----- Mail original ----- </span><br></blockquote><blockqu=
ote type=3D"cite"><span>De: "aderumier" &lt; <a href=3D"mailto:aderumier@odi=
so.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote><blockquote typ=
e=3D"cite"><span>=C3=80: "Srinivasula Maram" &lt; <a href=3D"mailto:Srinivas=
ula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt; </span><br></b=
lockquote><blockquote type=3D"cite"><span>Cc: "ceph-users" &lt; <a href=3D"m=
ailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;, "ceph-d=
evel" </span><br></blockquote><blockquote type=3D"cite"><span>&lt; <a href=3D=
"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "Mi=
losz Tanski" &lt; <a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a> &=
gt; </span><br></blockquote><blockquote type=3D"cite"><span>Envoy=C3=A9: Jeu=
di 23 Avril 2015 10:00:34 </span><br></blockquote><blockquote type=3D"cite">=
<span>Objet: Re: [ceph-users] strange benchmark problem : restarting osd </s=
pan><br></blockquote><blockquote type=3D"cite"><span>daemon improve performa=
nce from 100k iops to 300k iops </span><br></blockquote><blockquote type=3D"=
cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>Hi, </sp=
an><br></blockquote><blockquote type=3D"cite"><span>I'm hitting this bug aga=
in today. </span><br></blockquote><blockquote type=3D"cite"><span></span><br=
></blockquote><blockquote type=3D"cite"><span>So don't seem to be numa relat=
ed (I have try to flush linux buffer to be sure). </span><br></blockquote><b=
lockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"ci=
te"><span>and tcmalloc is patched (I don't known how to verify that it's ok)=
. </span><br></blockquote><blockquote type=3D"cite"><span></span><br></block=
quote><blockquote type=3D"cite"><span>I don't have restarted osd yet. </span=
><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><b=
lockquote type=3D"cite"><span>Maybe some perf trace could be usefulll ? </sp=
an><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote>=
<blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"=
cite"><span>----- Mail original ----- </span><br></blockquote><blockquote ty=
pe=3D"cite"><span>De: "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org=
">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote><blockquote type=3D"c=
ite"><span>=C3=80: "Srinivasula Maram" &lt; <a href=3D"mailto:Srinivasula.Ma=
ram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt; </span><br></blockqu=
ote><blockquote type=3D"cite"><span>Cc: "ceph-users" &lt; <a href=3D"mailto:=
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;, "ceph-devel" <=
/span><br></blockquote><blockquote type=3D"cite"><span>&lt; <a href=3D"mailt=
o:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "Milosz T=
anski" &lt; <a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a> &gt; </=
span><br></blockquote><blockquote type=3D"cite"><span>Envoy=C3=A9: Mercredi 2=
2 Avril 2015 18:30:26 </span><br></blockquote><blockquote type=3D"cite"><spa=
n>Objet: Re: [ceph-users] strange benchmark problem : restarting osd </span>=
<br></blockquote><blockquote type=3D"cite"><span>daemon improve performance f=
rom 100k iops to 300k iops </span><br></blockquote><blockquote type=3D"cite"=
><span></span><br></blockquote><blockquote type=3D"cite"><span>Hi, </span><b=
r></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>I feel it is due to tcmalloc issue </span><br></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockqu=
ote type=3D"cite"><span>Indeed, I had patched one of my node, but not the ot=
her. </span><br></blockquote><blockquote type=3D"cite"><span>So maybe I have=
 hit this bug. (but I can't confirm, I don't have traces). </span><br></bloc=
kquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote t=
ype=3D"cite"><span>But numa interleaving seem to help in my case (maybe not f=
rom 100-&gt;300k, but 250k-&gt;300k). </span><br></blockquote><blockquote ty=
pe=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>I n=
eed to do more long tests to confirm that. </span><br></blockquote><blockquo=
te type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><sp=
an></span><br></blockquote><blockquote type=3D"cite"><span>----- Mail origin=
al ----- </span><br></blockquote><blockquote type=3D"cite"><span>De: "Sriniv=
asula Maram" &lt; <a href=3D"mailto:Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasu=
la.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt; </span><br></blockquote><blockquote type=3D"ci=
te"><span>=C3=80: "Mark Nelson" &lt; <a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">m=
nelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;, "aderumier" </span><br></blockquote><blockquote t=
ype=3D"cite"><span>&lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier@odi=
so.com</a> &gt;, "Milosz Tanski" &lt; <a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">mi=
losz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote><blockquote type=3D"cite"><s=
pan>Cc: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph=
-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" </span><br></blockquote><block=
quote type=3D"cite"><span>&lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">=
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br></blockquote><blockquote type=3D=
"cite"><span>Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33 </span><br></block=
quote><blockquote type=3D"cite"><span>Objet: RE: [ceph-users] strange benchm=
ark problem : restarting osd </span><br></blockquote><blockquote type=3D"cit=
e"><span>daemon improve performance from 100k iops to 300k iops </span><br><=
/blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockqu=
ote type=3D"cite"><span>I feel it is due to tcmalloc issue </span><br></bloc=
kquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote t=
ype=3D"cite"><span>I have seen similar issue in my setup after 20 days. </sp=
an><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote>=
<blockquote type=3D"cite"><span>Thanks, </span><br></blockquote><blockquote t=
ype=3D"cite"><span>Srinivas </span><br></blockquote><blockquote type=3D"cite=
"><span></span><br></blockquote><blockquote type=3D"cite"><span></span><br><=
/blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockqu=
ote type=3D"cite"><span>-----Original Message----- </span><br></blockquote><=
blockquote type=3D"cite"><span>From: ceph-users [mailto: <a href=3D"mailto:c=
eph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> ] On=
 Behalf </span><br></blockquote><blockquote type=3D"cite"><span>Of Mark Nels=
on </span><br></blockquote><blockquote type=3D"cite"><span>Sent: Wednesday, A=
pril 22, 2015 7:31 PM </span><br></blockquote><blockquote type=3D"cite"><spa=
n>To: Alexandre DERUMIER; Milosz Tanski </span><br></blockquote><blockquote t=
ype=3D"cite"><span>Cc: ceph-devel; ceph-users </span><br></blockquote><block=
quote type=3D"cite"><span>Subject: Re: [ceph-users] strange benchmark proble=
m : restarting osd </span><br></blockquote><blockquote type=3D"cite"><span>d=
aemon improve performance from 100k iops to 300k iops </span><br></blockquot=
e><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>Hi Alexandre, </span><br></blockquote><blockquote type=3D"cite"=
><span></span><br></blockquote><blockquote type=3D"cite"><span>We should dis=
cuss this at the perf meeting today. We knew NUMA node affinity issues were g=
oing to crop up sooner or later (and indeed already have in some cases), but=
 this is pretty major. It's probably time to really dig in and figure out ho=
w to deal with this. </span><br></blockquote><blockquote type=3D"cite"><span=
></span><br></blockquote><blockquote type=3D"cite"><span>Note: this is one o=
f the reasons I like small nodes with single sockets and fewer OSDs. </span>=
<br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><bl=
ockquote type=3D"cite"><span>Mark </span><br></blockquote><blockquote type=3D=
"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>On 04/2=
2/2015 08:56 AM, Alexandre DERUMIER wrote: </span><br></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>Hi, </span><br></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>I have done a lot of test today, and it seem indeed numa relate=
d. </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>My numastat was </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span># numastat </span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>node0 node1 </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>numa_hit 99075422 153976877 </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>numa_miss 167490965 1493663=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>numa_foreign 1493663 167491417 </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>interle=
ave_hit 157745 167015 </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>local_node 99049179 153830554 </span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>other_node 167517697 1639986 </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>So, a lot of miss. </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>In this case , I c=
an reproduce ios going from 85k to 300k iops, up and down. </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n></span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>now setting </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>echo 0 &gt; /proc/sys/ke=
rnel/numa_balancing </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>and starting osd d=
aemons with </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>numactl --interleave=3Dall=
 /usr/bin/ceph-osd </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
I have a constant 300k iops ! </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>I wonder if it could be improve by binding osd daemons to specifi=
c numa node. </span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>I have 2 numanode of 10 cores with 6 osd, bu=
t I think it also require ceph.conf osd threads tunning. </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>----- Mail original=
 ----- </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>De: "Milosz Tanski" &lt; <a href=3D"mailto:milosz@=
adfin.com">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "aderumier" &=
lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Cc: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&l=
t; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a=
> &gt; </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23 </spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Objet: Re: [ceph-users] strange benchmark problem : restarting o=
sd </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>daemon improve performance from 100k iops to 300k iops=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER &lt; <a href=3D"mailto:a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote: </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span><=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>I wonder if it could be numa related, <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>I'm using centos 7.1, </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>and auto numa balacning is enabled </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>c=
at /proc/sys/kernel/numa_balancing =3D 1 </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>Maybe osd daemon access to buffer on wrong numa node. </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>I'll try to reproduce the problem </span><br></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>Can you force the degener=
ate case using numactl? To either affirm or deny your suspicion. </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span></span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>----- Mail original ----- </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>De: "aderumier" &lt; <a h=
ref=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>=C3=80: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &=
gt; </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05 </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>Objet: [ceph-users] strange benchmark problem : restarting osd da=
emon </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>improve performance from 100k iops to 300k iops </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>Hi, </span><br></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I w=
as doing some benchmarks, </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>I have found an strange behavio=
ur. </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>Using fio with rbd engine, I was a=
ble to reach around 100k iops. </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>(osd datas in linux buffer=
, iostat show 0% disk access) </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>then aft=
er restarting all osd daemons, </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>the sam=
e fio benchmark show now around 300k iops. </span><br></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(osd datas in l=
inux buffer, iostat show 0% disk access) </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>any ideas? </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>before restarting osd </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>--------------------- </span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test:=
 (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ioengine=
=3Drbd, iodepth=3D32 ... </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>fio-2.2.7-10-g51e9 </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>Starting 10 processes </span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.=
9 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd e=
ngine: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd engi=
ne: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd engine=
: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96=
.6K/0/0 </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>iops] [eta 14m:45s] </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>fio: termi=
nating on signal 2 </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test:=
 (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075: Wed Apr </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871, runt=3D=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, s=
tdev=3D17.38 clat </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>(usec): min=3D5, max=3D62584, avg=3D269=
5.80, stdev=3D5351.23 lat (usec): </span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>min=3D109, max=3D62598,=
 avg=3D2712.68, stdev=3D5350.42 clat percentiles </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(usec): <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>| 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.0=
0th=3D[ 247], </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>| 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00=
th=3D[ 446], 60.00th=3D[ 660], </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 1176], 80.00=
th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D[14656], </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.=
00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D[41728], </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>| 99.99th=3D[47360] </span><br></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D239=
28, max=3D154416, per=3D10.07%, avg=3D45462.82, </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stdev=3D2=
8809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.0=
3% lat (msec) : </span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.=
60%, 50=3D2.37% lat (msec) : 100=3D0.01% </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>cpu : usr=3D15.9=
0%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710 IO depths : </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, &gt;=
=3D64=3D0.0% submit : </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D=
0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>complete : 0=
=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D0.0%, </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>=3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D=
0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, </span><br></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>drop=3Dr=
=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=3D100.00%, </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>depth=3D32 </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Run status g=
roup 0 (all jobs): </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>READ: io=3D11558MB, aggrb=3D451487KB/s=
, minb=3D451487KB/s, maxb=3D451487KB/s, </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>mint=3D26215msec,=
 maxt=3D26215msec </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>Disk stats (read/wri=
te): </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=
=3D3, util=3D0.01% </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>[root@ceph1-3 fiorbd]# ./fio fiorbd </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4=
K/4K-4K, </span><br></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>ioengine=3Drbd, iodepth=3D32 </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
AFTER RESTARTING OSDS </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>---------------------- </span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>[root@ceph1-3 fiorbd]# ./fio fiorbd </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-te=
st: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ioeng=
ine=3Drbd, iodepth=3D32 ... </span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>fio-2.2.7-10-g51e9 </span><br=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>Starting 10 processes </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0=
.1.9 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rb=
d engine: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1=
.9 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd e=
ngine: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>rbd engine: RBD version: 0.1.9 </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd engi=
ne: RBD version: 0.1.9 </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD version: 0.1.9 </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [=
296K/0/0 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>iops] [eta 01h:09m:27s] </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>fio: t=
erminating on signal 2 </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-t=
est: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252: Wed Apr </span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265218, <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>runt=3D 7389msec slat (usec): min=3D5, max=3D3406, avg=3D2=
6.59, stdev=3D40.35 </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>clat </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(usec): min=3D=
8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat (usec): </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat percentiles </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>(usec): </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>| 1.00th=3D[ 243], 5.00th=3D[ 31=
4], 10.00th=3D[ 366], 20.00th=3D[ 450], </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 30.00th=3D[ 524=
], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ 796], </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
| 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D[ 1720],=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>| 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920]=
, 99.95th=3D[ 9792], </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>| 99.99th=3D[436224] </span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46, </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0=
.01%, 100=3D0.01%, </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>250=3D1.23% lat (usec) : 500=3D25.64%,=
 750=3D29.15%, 1000=3D18.84% lat (msec) </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>: 2=3D22.19%, 4=3D=
2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (msec) : </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>25=
0=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D11.26%, </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0=
.5%, 4=3D2.0%, </span><br></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>8=3D11.5%, 16=3D77.8%, 32=3D8.1%, &gt;=3D6=
4=3D0.0% submit : 0=3D0.0%, 4=3D100.0%, </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>8=3D0.0%, 16=3D0.=
0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% complete : 0=3D0.0%, </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, &gt;=3D64=3D0.0=
% issued : </span><br></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0=
/w=3D0/d=3D0, drop=3Dr=3D0/w=3D0/d=3D0 latency : </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>target=3D=
0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>Run status group 0 (all jobs): </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>READ: io=3D7655.=
7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s, </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>maxb=3D1036.8=
MB/s, mint=3D7389msec, maxt=3D7389msec </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>Disk stats (read/write): </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>sdg: ios=3D0/21, merge=3D0/10, t=
icks=3D0/2, in_queue=3D2, util=3D0.03% </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>CEPH LOG </span><br=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>-------- </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>before restarting os=
d </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>---------------------- </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>[INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62 <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>active+remapped, 900 active+clean; 390 GB data, 391 GB use=
d, 904 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>1295 GB avail; 298 MB/s rd, 76465 op/s </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : clust=
er </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>[INF] pgmap v11331: 964 pgs: 2 active+undersized+degra=
ded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>active+remapped, 900 active+clean; 390 GB data, 3=
91 GB used, 904 GB / </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>1295 GB avail; 333 MB/s rd, 85355 op/=
s </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146=
 : cluster </span><br></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>[INF] pgmap v11332: 964 pgs: 2 active+undersiz=
ed+degraded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>active+remapped, 900 active+clean; 390 GB=
 data, 391 GB used, 904 GB / </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 343 MB/s rd, 8=
7932 op/s </span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>2015-04-22 09:53:20.591586 mon.0 10.7.0.152:678=
9/0 2147 : cluster </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>[INF] pgmap v11333: 964 pgs: 2 active+=
undersized+degraded, 62 </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 active+clean=
; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 328 M=
B/s rd, 84151 op/s </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:21.600650 mon.0 10.7.=
0.152:6789/0 2148 : cluster </span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11334: 964 pgs: 2=
 active+undersized+degraded, 62 </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 acti=
ve+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avai=
l; 237 MB/s rd, 60855 op/s </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:22.607966 mon.=
0 10.7.0.152:6789/0 2149 : cluster </span><br></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11335: 96=
4 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 9=
00 active+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 G=
B avail; 144 MB/s rd, 36935 op/s </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:23.6177=
80 mon.0 10.7.0.152:6789/0 2150 : cluster </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11=
336: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+rem=
apped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>1295 GB avail; 321 MB/s rd, 82334 op/s </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:5=
3:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster </span><br></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] p=
gmap v11337: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ac=
tive+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>1295 GB avail; 368 MB/s rd, 94211 op/s </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04=
-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>[INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62 </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>1295 GB avail; 244 MB/s rd, 62644 op/s </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster </span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>[INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62 </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>active+remapped, 900 active+clean; 390 GB data, 391 GB used, 90=
4 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>1295 GB avail; 175 MB/s rd, 44997 op/s </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>[INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 6=
2 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>active+remapped, 900 active+clean; 390 GB data, 391 GB u=
sed, 904 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>1295 GB avail; 122 MB/s rd, 31259 op/s </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : clust=
er </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>[INF] pgmap v11341: 964 pgs: 2 active+undersized+degra=
ded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>active+remapped, 900 active+clean; 390 GB data, 3=
91 GB used, 904 GB / </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>1295 GB avail; 229 MB/s rd, 58674 op/=
s </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156=
 : cluster </span><br></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>[INF] pgmap v11342: 964 pgs: 2 active+undersiz=
ed+degraded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>active+remapped, 900 active+clean; 390 GB=
 data, 391 GB used, 904 GB / </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 271 MB/s rd, 6=
9501 op/s </span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>2015-04-22 09:53:30.662796 mon.0 10.7.0.152:678=
9/0 2157 : cluster </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>[INF] pgmap v11343: 964 pgs: 2 active+=
undersized+degraded, 62 </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 active+clean=
; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 211 M=
B/s rd, 54020 op/s </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:31.666421 mon.0 10.7.=
0.152:6789/0 2158 : cluster </span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11344: 964 pgs: 2=
 active+undersized+degraded, 62 </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 acti=
ve+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avai=
l; 164 MB/s rd, 42001 op/s </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:32.670842 mon.=
0 10.7.0.152:6789/0 2159 : cluster </span><br></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11345: 96=
4 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 9=
00 active+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 G=
B avail; 134 MB/s rd, 34380 op/s </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:53:33.6813=
57 mon.0 10.7.0.152:6789/0 2160 : cluster </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11=
346: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+rem=
apped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / </span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>1295 GB avail; 293 MB/s rd, 75213 op/s </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 09:5=
3:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster </span><br></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] p=
gmap v11347: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ac=
tive+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>1295 GB avail; 337 MB/s rd, 86353 op/s </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04=
-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>[INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62 </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>1295 GB avail; 229 MB/s rd, 58839 op/s </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster </span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>[INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62 </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>active+remapped, 900 active+clean; 390 GB data, 391 GB used, 90=
4 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>1295 GB avail; 152 MB/s rd, 39117 op/s </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span></span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>restarting osd </span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>--------------- </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:09=
.766906 mon.0 10.7.0.152:6789/0 2255 : cluster </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osd.=
0 marked itself down </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:09.790212 mon.0 10.7=
.0.152:6789/0 2256 : cluster </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>[INF] osdmap e849: 9 osds: 8=
 up, 9 in </span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>2015-04-22 10:00:09.793050 mon.0 10.7.0.152:678=
9/0 2257 : cluster </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>[INF] pgmap v11439: 964 pgs: 2 active+=
undersized+degraded, 8 </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>stale+active+remapped, 106 stale+a=
ctive+clean, 54 active+remapped, </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+794 </span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 5=
16 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>kB/s rd, 130 op/s </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:=
10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] os=
dmap e850: 9 osds: 8 up, 9 in </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:10.796675 m=
on.0 10.7.0.152:6789/0 2259 : cluster </span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11440:=
 964 pgs: 2 active+undersized+degraded, 8 </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+re=
mapped, 106 stale+active+clean, 54 active+remapped, </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale=
+active+794 </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>active+clean; 419 GB data, 420 GB used, 874 G=
B / 1295 GB avail </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>2015-04-22 10:00:11.798257 mon.0 10.7.0=
.152:6789/0 2260 : cluster </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11441: 964 pgs: 2 a=
ctive+undersized+degraded, 8 </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>stale+active+remapped, 106 s=
tale+active+clean, 54 active+remapped, </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+794 <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB a=
vail </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2=
262 : cluster </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>[INF] osd.1 marked itself down </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>[INF] osdmap e851: 9 osds: 7 up, 9 in </span><br></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>201=
5-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>[INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13 </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>stale+active+remapped, 216 stale+active+clean, 49 active+remapped=
, </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>stale+active+684 </span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+clean, 1 sta=
le+active+undersized+degraded; 419 GB data, 420 GB </span><br></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>used, 8=
74 GB / 1295 GB avail </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:13.804186 mon.0 10.7=
.0.152:6789/0 2265 : cluster </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>[INF] osdmap e852: 9 osds: 7=
 up, 9 in </span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>2015-04-22 10:00:13.805216 mon.0 10.7.0.152:678=
9/0 2266 : cluster </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>[INF] pgmap v11444: 964 pgs: 1 active+=
undersized+degraded, 13 </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>stale+active+remapped, 216 stale+=
active+clean, 49 active+remapped, </span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+684 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>active+clean, 1 stale+active+undersized+degraded; 419 GB data, 4=
20 GB </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>used, 874 GB / 1295 GB avail </span><br></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>201=
5-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>[INF] osd.2 marked itself down </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:14.=
810571 mon.0 10.7.0.152:6789/0 2269 : cluster </span><br></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osdma=
p e853: 9 osds: 6 up, 9 in </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:14.813871 mon.=
0 10.7.0.152:6789/0 2270 : cluster </span><br></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11445: 96=
4 pgs: 1 active+undersized+degraded, 22 </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+rema=
pped, 300 stale+active+clean, 40 active+remapped, </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+a=
ctive+600 </span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>active+clean, 1 stale+active+undersized+degrade=
d; 419 GB data, 420 GB </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>used, 874 GB / 1295 GB avail </spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : clust=
er </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>[INF] osdmap e854: 9 osds: 6 up, 9 in </span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster </span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>[INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22 </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>stale+active+remapped, 300 stale+active+clean, 40 active+re=
mapped, </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>stale+active+600 </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+clean,=
 1 stale+active+undersized+degraded; 419 GB data, 420 GB </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
used, 874 GB / 1295 GB avail </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:16.395105 m=
on.0 10.7.0.152:6789/0 2273 : cluster </span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] HEALTH_WARN; 2=
 pgs degraded; 323 pgs stale; 2 pgs stuck </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>degraded; 64 pg=
s stuck unclean; 2 pgs stuck undersized; 2 pgs </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>undersized=
; 3/9 in osds are down; clock skew detected on mon.ceph1-2 </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>[INF] osd.1 10.7.0.152:6800/14848 boot </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04=
-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>[INF] osdmap e855: 9 osds: 7 up, 9 in </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:=
16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pg=
map v11447: 964 pgs: 1 active+undersized+degraded, 22 </span><br></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>sta=
le+active+remapped, 300 stale+active+clean, 40 active+remapped, </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>stale+active+600 </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>active+clean, 1 stale+active+unde=
rsized+degraded; 419 GB data, 420 GB </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>used, 874 GB / 1295 G=
B avail </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/=
0 2278 : cluster </span><br></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>[INF] osd.3 marked itself down </span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>[INF] osdmap e856: 9 osds: 6 up, 9 in </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2=
015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>[INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>stale+active+remapped, 394 stale+active+clean, 37 active+remapp=
ed, </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>stale+active+506 </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+clean, 1 s=
tale+active+undersized+degraded; 419 GB data, 420 GB </span><br></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>used=
, 874 GB / 1295 GB avail </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:18.551068 mon.0=
 10.7.0.152:6789/0 2282 : cluster </span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osd.6 marked itse=
lf down </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/=
0 2283 : cluster </span><br></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>[INF] osd.2 10.7.0.152:6812/15410 boot <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : c=
luster </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>[INF] osdmap e857: 9 osds: 6 up, 9 in </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>[INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 3=
0 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>stale+active+remapped, 502 stale+active+clean, 32 activ=
e+remapped, </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>stale+active+398 </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+cl=
ean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB </span><br></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>used, 874 GB / 1295 GB avail </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:19.8209=
47 mon.0 10.7.0.152:6789/0 2287 : cluster </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osdmap e8=
58: 9 osds: 6 up, 9 in </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:19.821853 mon.0 1=
0.7.0.152:6789/0 2288 : cluster </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11450: 964 p=
gs: 1 active+undersized+degraded, 30 </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+remappe=
d, 502 stale+active+clean, 32 active+remapped, </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>stale+acti=
ve+398 </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>active+clean, 1 stale+active+undersized+degraded; 4=
19 GB data, 420 GB </span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>used, 874 GB / 1295 GB avail </span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>[INF] osd.3 10.7.0.152:6816/15971 boot </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster </span><br=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>[INF] osdmap e859: 9 osds: 7 up, 9 in </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22=
 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[=
INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30 </span><br></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>stale+active+remapped, 502 stale+active+clean, 32 active+remapped, </spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>stale+active+398 </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>active+clean, 1 stale+activ=
e+undersized+degraded; 419 GB data, 420 GB </span><br></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>used, 874 GB /=
 1295 GB avail </span><br></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>2015-04-22 10:00:20.991343 mon.0 10.7.0.15=
2:6789/0 2294 : cluster </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>[INF] osd.7 marked itself down </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : c=
luster </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>[INF] osd.0 10.7.0.152:6804/14481 boot </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>[INF] osdmap e860: 9 osds: 7 up, 9 in </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>20=
15-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>[INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35 </span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>stale+active+remapped, 608 stale+active+clean, 27 active+remappe=
d, </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>stale+active+292 </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+clean, 1 st=
ale+active+undersized+degraded; 419 GB data, 420 GB </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>used,=
 874 GB / 1295 GB avail </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:22.830456 mon.0 1=
0.7.0.152:6789/0 2298 : cluster </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osd.6 10.7.0.153:68=
08/21955 boot </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>2015-04-22 10:00:22.832171 mon.0 10.7.0.152=
:6789/0 2299 : cluster </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>[INF] osdmap e861: 9 osds: 8 up, 9=
 in </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 23=
00 : cluster </span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>[INF] pgmap v11453: 964 pgs: 3 active+unders=
ized+degraded, 27 </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>stale+active+remapped, 498 stale+active=
+clean, 2 peering, 28 </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>active+remapped, 402 active+clean, 4 r=
emapped+peering; 419 GB data, </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>420 GB used, 874 GB / 1295 G=
B avail </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/=
0 2302 : cluster </span><br></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>[INF] osd.8 marked itself down </span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>[INF] osdmap e862: 9 osds: 7 up, 9 in </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2=
015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>[INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>stale+active+remapped, 587 stale+active+clean, 2 peering, 11 </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>active+remapped, 313 active+clean, 4 remapped+peering; 419 G=
B data, </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>420 GB used, 874 GB / 1295 GB avail </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster </sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>[INF] osd.7 10.7.0.153:6804/22536 boot </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-=
04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster </span><br></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>[INF] osdmap e863: 9 osds: 8 up, 9 in </span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:0=
0:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster </span><br></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] p=
gmap v11455: 964 pgs: 3 active+undersized+degraded, 31 </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>st=
ale+active+remapped, 503 stale+active+clean, 4 </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+und=
ersized+degraded+remapped, 5 peering, 13 active+remapped, </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874 </span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>GB / 1295 GB avail </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:25.834459=
 mon.0 10.7.0.152:6789/0 2309 : cluster </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] osdmap e864=
: 9 osds: 8 up, 9 in </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>2015-04-22 10:00:25.835727 mon.0 10.7=
.0.152:6789/0 2310 : cluster </span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11456: 964 pgs:=
 3 active+undersized+degraded, 31 </span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>stale+active+remapped, 5=
03 stale+active+clean, 4 </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>active+undersized+degraded+remap=
ped, 5 peering, 13 active </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>AFTER OSD RESTART </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>------------------ </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span></span><br></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span></span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09:27.609052 mon.0=
 10.7.0.152:6789/0 2339 : cluster </span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11478: 964=
 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 9=
00 active+clean; 419 GB data, 421 GB used, 874 GB / </span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 G=
B avail; 786 MB/s rd, 196 kop/s </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09:28.61808=
2 mon.0 10.7.0.152:6789/0 2340 : cluster </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v114=
79: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+rema=
pped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / </span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>1295 GB avail; 1578 MB/s rd, 394 kop/s </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09=
:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] p=
gmap v11480: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ac=
tive+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / </span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>1295 GB avail; 932 MB/s rd, 233 kop/s </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-=
22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>[INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62 </span><br></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>1295 GB avail; 627 MB/s rd, 156 kop/s </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2=
015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>[INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>active+remapped, 900 active+clean; 419 GB data, 421 GB used, 87=
4 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>1295 GB avail; 1034 MB/s rd, 258 kop/s </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster </=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>[INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 6=
2 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>active+remapped, 900 active+clean; 419 GB data, 421 GB u=
sed, 874 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>1295 GB avail; 529 MB/s rd, 132 kop/s </spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : clust=
er </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>[INF] pgmap v11484: 964 pgs: 2 active+undersized+degra=
ded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>active+remapped, 900 active+clean; 419 GB data, 4=
21 GB used, 874 GB / </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>1295 GB avail; 770 MB/s rd, 192 kop/s=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 :=
 cluster </span><br></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>[INF] pgmap v11485: 964 pgs: 2 active+undersized=
+degraded, 62 </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>active+remapped, 900 active+clean; 419 GB d=
ata, 421 GB used, 874 GB / </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 1358 MB/s rd, 33=
9 kop/s </span><br></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/=
0 2347 : cluster </span><br></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>[INF] pgmap v11486: 964 pgs: 2 active+un=
dersized+degraded, 62 </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>active+remapped, 900 active+clean; 41=
9 GB data, 421 GB used, 874 GB / </span><br></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 649 MB/s r=
d, 162 kop/s </span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>2015-04-22 10:09:42.707164 mon.0 10.7.0.152:=
6789/0 2348 : cluster </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11487: 964 pgs: 2 active=
+undersized+degraded, 62 </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 active+clea=
n; 419 GB data, 421 GB used, 874 GB / </span><br></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail; 580 M=
B/s rd, 145 kop/s </span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>2015-04-22 10:09:43.713736 mon.0 10.7.0=
.152:6789/0 2349 : cluster </span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11488: 964 pgs: 2 a=
ctive+undersized+degraded, 62 </span><br></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900 active=
+clean; 419 GB data, 421 GB used, 874 GB / </span><br></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB avail;=
 962 MB/s rd, 240 kop/s </span><br></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09:45.718658 mon.0 1=
0.7.0.152:6789/0 2350 : cluster </span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v11489: 964 p=
gs: 2 active+undersized+degraded, 62 </span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>active+remapped, 900=
 active+clean; 419 GB data, 421 GB used, 874 GB / </span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1295 GB=
 avail; 506 MB/s rd, 126 kop/s </span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09:47.737358=
 mon.0 10.7.0.152:6789/0 2351 : cluster </span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgmap v1149=
0: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>active+remap=
ped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>1295 GB avail; 774 MB/s rd, 193 kop/s </span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-22 10:09:4=
8.743338 mon.0 10.7.0.152:6789/0 2352 : cluster </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[INF] pgm=
ap v11491: 964 pgs: 2 active+undersized+degraded, 62 </span><br></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>acti=
ve+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / </span><br=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>1295 GB avail; 1363 MB/s rd, 340 kop/s </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2015-04-2=
2 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster </span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
[INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62 </span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / <=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>1295 GB avail; 662 MB/s rd, 165 kop/s </span><br></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>2=
015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>[INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62 </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>active+remapped, 900 active+clean; 419 GB data, 421 GB used, 87=
4 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>1295 GB avail; 593 MB/s rd, 148 kop/s </span><br><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>[INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 6=
2 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>active+remapped, 900 active+clean; 419 GB data, 421 GB u=
sed, 874 GB / </span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>1295 GB avail; 938 MB/s rd, 234 kop/s </spa=
n><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>____________________________________________=
___ </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>ceph-users mailing list </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span><a href=3D=
"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">h=
ttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote><blockquote type=3D"cite"><span>______=
_________________________________________ </span><br></blockquote><blockquot=
e type=3D"cite"><span>ceph-users mailing list </span><br></blockquote><block=
quote type=3D"cite"><span><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-=
users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br></blockquote><blockquote type=3D"cite"><=
span><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http=
://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></blockquo=
te><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>________________________________ </span><br></blockquote><block=
quote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite">=
<span>PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited.=
 If you have received this communication in error, please notify the sender b=
y telephone or e-mail (as shown above) immediately and destroy any and all c=
opies of this message in your possession (whether hard copies or electronica=
lly stored copies). </span><br></blockquote><blockquote type=3D"cite"><span>=
</span><br></blockquote><blockquote type=3D"cite"><span>____________________=
___________________________ </span><br></blockquote><blockquote type=3D"cite=
"><span>ceph-users mailing list </span><br></blockquote><blockquote type=3D"=
cite"><span><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com</a> </span><br></blockquote><blockquote type=3D"cite"><span><a href=3D=
"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.c=
om/listinfo.cgi/ceph-users-ceph.com</a> </span><br></blockquote><blockquote t=
ype=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>_=
______________________________________________ </span><br></blockquote><bloc=
kquote type=3D"cite"><span>ceph-users mailing list </span><br></blockquote><=
blockquote type=3D"cite"><span><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">=
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br></blockquote><blockquote type=3D"ci=
te"><span><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></blo=
ckquote><blockquote type=3D"cite"><span></span><br></blockquote><span>______=
_________________________________________ </span><br><span>ceph-users mailin=
g list </span><br><span><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br><span><a href=3D"http://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com</a> </span><br><span>_____________________________________________=
__ </span><br><span>ceph-users mailing list </span><br><span><a href=3D"mail=
to:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br><span=
><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br><span></span><=
br><span></span><br><span></span><br><span></span><br><span></span><br><span=
></span><br><span>-- </span><br><span>=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=
=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=
=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=
=87 </span><br><span>=D0=9C=D0=BE=D0=B1.: +79229045757 </span><br><span></sp=
an><br><span></span><br><span></span><br><span>--</span><br><span>To unsubsc=
ribe from this list: send the line "unsubscribe ceph-devel" in</span><br><sp=
an>the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">maj=
ordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a></span><br><span>More majordomo info at &nbsp;<a h=
ref=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/ma=
jordomo-info.html</a></span><br></div></blockquote></body></html>=

--Apple-Mail-50BD8F93-C937-43B3-80DF-70C3370A2992--

--===============1625606596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1625606596==--
