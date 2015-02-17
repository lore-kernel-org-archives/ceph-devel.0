From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 17 Feb 2015 10:31:47 +0100 (CET)
Message-ID: <653250303.1036574.1424165507421.JavaMail.zimbra@oxygem.tv>
References: <54DA541E.9000608@profihost.ag> <54DAEBBD.30409@profihost.ag> <54E0E82D.20007@profihost.ag> <54E25F79.8030009@profihost.ag> <2047240648.1005007.1424124138866.JavaMail.zimbra@oxygem.tv> <9D75B238-1574-4D3C-870E-E584B24D956B@profihost.ag> <459099286.1005550.1424125118983.JavaMail.zimbra@oxygem.tv> <54E3069D.90109@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36664 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486AbbBQJbt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 04:31:49 -0500
In-Reply-To: <1999473015.1036573.1424165503094.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>Not that easy as you can't downgrade from firefly to dumpling. Here i=
s=20
>>perf output of firefly vs giant. While they have a difference of abou=
t=20
>>6k iops i do not see any differences in the perf output.=20
>>
>>This is the perf output of the osd side with firefly (27k iops):=20

I don't known for osd side (because they are a lot of optimisations in =
giant for ssd).

I'll try to redone big client side benchmark next month when my new ssd=
 cluster will be ready.
(I'll try dumpling,firefly,giant,hammer , fio-krbd,fio-librbd, qemu, vi=
rtio,virtio-scsi,iothreads,....)

I have planned to take 1month for benchmark, so I hope I'll help.



----- Mail original -----
De: "Stefan Priebe" <s.priebe@profihost.ag>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>
Envoy=C3=A9: Mardi 17 F=C3=A9vrier 2015 10:15:09
Objet: Re: speed decrease since firefly,giant,hammer the 2nd try

Am 16.02.2015 um 23:18 schrieb Alexandre DERUMIER:=20
>>> Just tested write. This might be the result of higher CPU load of t=
he ceph-osd processes under firefly.=20
>>>=20
>>> Dumpling 180% per process vs. firefly 220%=20
>=20
> Oh yes, indeed, that's what I think too. (and more cpu -> less ios in=
 qemu because of single iothread)=20
>=20
>=20
> I think that perf report should show the difference, this is strange =
that you have almost same result in your perf reports.=20

Not that easy as you can't downgrade from firefly to dumpling. Here is=20
perf output of firefly vs giant. While they have a difference of about=20
6k iops i do not see any differences in the perf output.=20

This is the perf output of the osd side with firefly (27k iops):=20

5,44% libc-2.13.so [.] 0x1370b0=20
4,02% libtcmalloc.so.4.1.0 [.] operator new(unsigned long)=20
2,84% libtcmalloc.so.4.1.0 [.] operator delete(void*)=20
2,50% ceph-osd [.] 0x5aed30=20
1,40% libstdc++.so.6.0.17 [.] 0xbeacc=20
1,39% [kernel] [k] intel_idle=20
1,34% libleveldb.so.1.12 [.] 0x24673=20
1,30% libc-2.13.so [.] vfprintf=20
1,20% [kernel] [k] __schedule=20
1,00% [kernel] [k] __switch_to=20
0,99% libleveldb.so.1.12 [.] leveldb::SkipList<char const*,=20
leveldb::MemTable::KeyComparator>::FindGreaterOrEqual(char const*=20
0,96% libpthread-2.13.so [.] pthread_mutex_trylock=20
0,86% [kernel] [k] _raw_spin_lock=20
0,83% libstdc++.so.6.0.17 [.] std::basic_string<char,=20
std::char_traits<char>, std::allocator<char> >::basic_string(std::strin=
g=20
0,82% ceph-osd [.] ceph::buffer::list::append(char=20
const*, unsigned int)=20
0,81% libsnappy.so.1.1.3 [.]=20
snappy::internal::CompressFragment(char const*, unsigned long, char*,=20
unsigned short*, int)=20
0,74% libpthread-2.13.so [.] __pthread_mutex_unlock_usercnt=20
0,73% ceph-osd [.] Mutex::Lock(bool)=20
0,72% [kernel] [k] __d_lookup_rcu=20
0,65% libtcmalloc.so.4.1.0 [.]=20
tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::Fre=
eList*,=20
unsigned long, int=20
0,65% ceph-osd [.] ceph::buffer::ptr::release()=20
0,64% libleveldb.so.1.12 [.] leveldb::crc32c::Extend(unsigned int,=20
char const*, unsigned long)=20
0,62% [kernel] [k] page_fault=20
0,58% ceph-osd [.]=20
ceph::buffer::list::iterator::copy(unsigned int, char*)=20
0,55% [kernel] [k] link_path_walk=20
0,53% libstdc++.so.6.0.17 [.] std::string::append(char const*,=20
unsigned long)=20
0,51% ceph-osd [.]=20
ceph::buffer::list::iterator::advance(int)=20
0,46% ceph-osd [.] ceph::buffer::ptr::append(char=20
const*, unsigned int)=20
0,45% libpthread-2.13.so [.] pthread_cond_wait@@GLIBC_2.3.2=20
0,43% libsnappy.so.1.1.3 [.]=20
snappy::RawUncompress(snappy::Source*, char*)=20
0,43% libstdc++.so.6.0.17 [.] std::string::_M_mutate(unsigned long,=20
unsigned long, unsigned long)=20
0,43% ceph-osd [.]=20
ceph::buffer::list::append(ceph::buffer::ptr const&, unsigned int,=20
unsigned int)=20
0,42% [kernel] [k] copy_user_enhanced_fast_string=20

and this is giant having (33k iops):=20

5,65% libc-2.13.so [.] 0x1376a4=20
4,36% libtcmalloc.so.4.1.0 [.] operator new(unsigned long)=20
2,74% ceph-osd [.] 0x48011d=20
2,49% libtcmalloc.so.4.1.0 [.] operator delete(void*)=20
1,42% libleveldb.so.1.12 [.] 0x24673=20
1,27% libleveldb.so.1.12 [.] leveldb::SkipList<char const*,=20
leveldb::MemTable::KeyComparator>::FindGreaterOrEqual(char cons=20
1,19% libstdc++.so.6.0.17 [.] 0xbfacb=20
0,99% libc-2.13.so [.] vfprintf=20
0,91% libsnappy.so.1.1.3 [.]=20
snappy::internal::CompressFragment(char const*, unsigned long, char*,=20
unsigned short*, int)=20
0,88% [kernel] [k] __schedule=20
0,88% libpthread-2.13.so [.] pthread_mutex_trylock=20
0,81% ceph-osd [.] ceph::buffer::list::append(char=20
const*, unsigned int)=20
0,76% [kernel] [k] __d_lookup_rcu=20
0,76% [kernel] [k] __switch_to=20
0,74% ceph-osd [.] Mutex::Lock(bool)=20
0,74% libtcmalloc.so.4.1.0 [.]=20
tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::Fre=
eList*,=20
unsigned long,=20
0,72% [kernel] [k] intel_idle=20
0,72% ceph-osd [.] ceph::buffer::ptr::release()=20
0,70% [kernel] [k] _raw_spin_lock=20
0,66% libleveldb.so.1.12 [.] leveldb::crc32c::Extend(unsigned=20
int, char const*, unsigned long)=20
0,66% ceph-osd [.]=20
ceph::buffer::list::iterator::copy(unsigned int, char*)=20
0,64% libstdc++.so.6.0.17 [.] std::basic_string<char,=20
std::char_traits<char>, std::allocator<char> >::basic_string(std::stri=20
0,64% [kernel] [k] page_fault=20
0,59% [kernel] [k] link_path_walk=20
0,58% libstdc++.so.6.0.17 [.] std::string::append(char const*,=20
unsigned long)=20
0,57% libpthread-2.13.so [.] __pthread_mutex_unlock_usercnt=20
0,56% ceph-osd [.]=20
ceph::buffer::list::iterator::advance(int)=20
0,44% ceph-osd [.] ceph::buffer::ptr::append(char=20
const*, unsigned int)=20

Stefan=20


>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Stefan Priebe" <s.priebe@profihost.ag>=20
> =C3=80: "aderumier" <aderumier@odiso.com>=20
> Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger=
=2Ekernel.org>=20
> Envoy=C3=A9: Lundi 16 F=C3=A9vrier 2015 23:08:37=20
> Objet: Re: speed decrease since firefly,giant,hammer the 2nd try=20
>=20
> Am 16.02.2015 um 23:02 schrieb Alexandre DERUMIER <aderumier@odiso.co=
m>:=20
>=20
>>>> This results in fio-rbd showing avg 26000 iop/s instead of 30500 i=
op/s=20
>>>> while running dumpling...=20
>>=20
>> Is it for write only ?=20
>> or do you see same decrease for read too=20
>=20
> Just tested write. This might be the result of higher CPU load of the=
 ceph-osd processes under firefly.=20
>=20
> Dumpling 180% per process vs. firefly 220%=20
>=20
> Stefan=20
>=20
>> ?=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "Stefan Priebe" <s.priebe@profihost.ag>=20
>> =C3=80: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel=
@vger.kernel.org>=20
>> Envoy=C3=A9: Lundi 16 F=C3=A9vrier 2015 22:22:01=20
>> Objet: Re: speed decrease since firefly,giant,hammer the 2nd try=20
>>=20
>> I've now upgraded server side and client side to latest upstream/fir=
efly.=20
>>=20
>> This results in fio-rbd showing avg 26000 iop/s instead of 30500 iop=
/s=20
>> while running dumpling...=20
>>=20
>> Greets,=20
>> Stefan=20
>>> Am 15.02.2015 um 19:40 schrieb Stefan Priebe:=20
>>> Hi Mark,=20
>>>=20
>>> what's next?=20
>>>=20
>>> I've this test cluster only for 2 more days.=20
>>>=20
>>> Here some perf Details:=20
>>>=20
>>> dumpling:=20
>>> 12,65% libc-2.13.so [.] 0x79000=20
>>> 2,86% libc-2.13.so [.] malloc=20
>>> 2,80% kvm [.] 0xb59c5=20
>>> 2,59% libc-2.13.so [.] free=20
>>> 2,35% [kernel] [k] __schedule=20
>>> 2,16% [kernel] [k] _raw_spin_lock=20
>>> 1,92% [kernel] [k] __switch_to=20
>>> 1,58% [kernel] [k] lapic_next_deadline=20
>>> 1,09% [kernel] [k] update_sd_lb_stats=20
>>> 1,08% [kernel] [k] _raw_spin_lock_irqsave=20
>>> 0,91% librados.so.2.0.0 [.] ceph_crc32c_le_intel=20
>>> 0,91% libpthread-2.13.so [.] pthread_mutex_trylock=20
>>> 0,87% [kernel] [k] resched_task=20
>>> 0,72% [kernel] [k] cpu_startup_entry=20
>>> 0,71% librados.so.2.0.0 [.] crush_hash32_3=20
>>> 0,66% [kernel] [k] leave_mm=20
>>> 0,65% librados.so.2.0.0 [.] Mutex::Lock(bool)=20
>>> 0,64% [kernel] [k] idle_cpu=20
>>> 0,62% libpthread-2.13.so [.] __pthread_mutex_unlock_usercnt=20
>>> 0,59% [kernel] [k] try_to_wake_up=20
>>> 0,56% [kernel] [k] wake_futex=20
>>> 0,50% librados.so.2.0.0 [.] ceph::buffer::ptr::release()=20
>>>=20
>>> firefly:=20
>>> 12,56% libc-2.13.so [.] 0x7905d=20
>>> 2,82% libc-2.13.so [.] malloc=20
>>> 2,64% libc-2.13.so [.] free=20
>>> 2,61% kvm [.] 0x34322f=20
>>> 2,33% [kernel] [k] __schedule=20
>>> 2,14% [kernel] [k] _raw_spin_lock=20
>>> 1,83% [kernel] [k] __switch_to=20
>>> 1,62% [kernel] [k] lapic_next_deadline=20
>>> 1,17% [kernel] [k] _raw_spin_lock_irqsave=20
>>> 1,09% [kernel] [k] update_sd_lb_stats=20
>>> 1,08% libpthread-2.13.so [.] pthread_mutex_trylock=20
>>> 0,85% libpthread-2.13.so [.] __pthread_mutex_unlock_usercnt=20
>>> 0,77% [kernel] [k] resched_task=20
>>> 0,74% librbd.so.1.0.0 [.] 0x71b73=20
>>> 0,72% librados.so.2.0.0 [.] Mutex::Lock(bool)=20
>>> 0,68% librados.so.2.0.0 [.] crush_hash32_3=20
>>> 0,67% [kernel] [k] idle_cpu=20
>>> 0,65% [kernel] [k] leave_mm=20
>>> 0,65% [kernel] [k] cpu_startup_entry=20
>>> 0,59% [kernel] [k] try_to_wake_up=20
>>> 0,51% librados.so.2.0.0 [.] ceph::buffer::ptr::release()=20
>>> 0,51% [kernel] [k] wake_futex=20
>>>=20
>>> Stefan=20
>>>=20
>>>> Am 11.02.2015 um 06:42 schrieb Stefan Priebe:=20
>>>>=20
>>>>> Am 11.02.2015 um 05:45 schrieb Mark Nelson:=20
>>>>>> On 02/10/2015 04:18 PM, Stefan Priebe wrote:=20
>>>>>>=20
>>>>>>> Am 10.02.2015 um 22:38 schrieb Mark Nelson:=20
>>>>>>>> On 02/10/2015 03:11 PM, Stefan Priebe wrote:=20
>>>>>>>>=20
>>>>>>>> mhm i installed librbd1-dbg and librados2-dbg - but the output=
 still=20
>>>>>>>> looks useless to me. Should i upload it somewhere?=20
>>>>>>>=20
>>>>>>> Meh, if it's all just symbols it's probably not that helpful.=20
>>>>>>>=20
>>>>>>> I've summarized your results here:=20
>>>>>>>=20
>>>>>>> 1 concurrent 4k write (libaio, direct=3D1, iodepth=3D1)=20
>>>>>>>=20
>>>>>>> IOPS Latency=20
>>>>>>> wb on wb off wb on wb off=20
>>>>>>> dumpling 10870 536 ~100us ~2ms=20
>>>>>>> firefly 10350 525 ~100us ~2ms=20
>>>>>>>=20
>>>>>>> So in single op tests dumpling and firefly are far closer. Now =
let's=20
>>>>>>> see each of these cases with iodepth=3D32 (still 1 thread for n=
ow).=20
>>>>>>=20
>>>>>>=20
>>>>>> dumpling:=20
>>>>>>=20
>>>>>> file1: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlib=
aio, iodepth=3D32=20
>>>>>> 2.0.8=20
>>>>>> Starting 1 thread=20
>>>>>> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/72812K /s] [0 /18.3K iops=
] [eta=20
>>>>>> 00m:00s]=20
>>>>>> file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D3011=20
>>>>>> write: io=3D2060.6MB, bw=3D70329KB/s, iops=3D17582 , runt=3D 300=
01msec=20
>>>>>> slat (usec): min=3D1 , max=3D3517 , avg=3D 3.42, stdev=3D 7.30=20
>>>>>> clat (usec): min=3D93 , max=3D7475 , avg=3D1815.72, stdev=3D233.=
43=20
>>>>>> lat (usec): min=3D219 , max=3D7477 , avg=3D1819.27, stdev=3D233.=
52=20
>>>>>> clat percentiles (usec):=20
>>>>>> | 1.00th=3D[ 1480], 5.00th=3D[ 1576], 10.00th=3D[ 1608], 20.00th=
=3D[=20
>>>>>> 1672],=20
>>>>>> | 30.00th=3D[ 1704], 40.00th=3D[ 1752], 50.00th=3D[ 1800], 60.00=
th=3D[=20
>>>>>> 1832],=20
>>>>>> | 70.00th=3D[ 1896], 80.00th=3D[ 1960], 90.00th=3D[ 2064], 95.00=
th=3D[=20
>>>>>> 2128],=20
>>>>>> | 99.00th=3D[ 2352], 99.50th=3D[ 2448], 99.90th=3D[ 4704], 99.95=
th=3D[=20
>>>>>> 5344],=20
>>>>>> | 99.99th=3D[ 7072]=20
>>>>>> bw (KB/s) : min=3D59696, max=3D77840, per=3D100.00%, avg=3D70351=
=2E27,=20
>>>>>> stdev=3D4783.25=20
>>>>>> lat (usec) : 100=3D0.01%, 250=3D0.01%, 500=3D0.01%, 750=3D0.01%,=
=20
>>>>>> 1000=3D0.53%=20
>>>>>> lat (msec) : 2=3D85.02%, 4=3D14.31%, 10=3D0.13%=20
>>>>>> cpu : usr=3D1.96%, sys=3D6.71%, ctx=3D22791, majf=3D0, minf=3D13=
3=20
>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 3=
2=3D100.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%,=
 64=3D0.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> issued : total=3Dr=3D0/w=3D527487/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0=20
>>>>>>=20
>>>>>> Run status group 0 (all jobs):=20
>>>>>> WRITE: io=3D2060.6MB, aggrb=3D70329KB/s, minb=3D70329KB/s, maxb=3D=
70329KB/s,=20
>>>>>> mint=3D30001msec, maxt=3D30001msec=20
>>>>>>=20
>>>>>> Disk stats (read/write):=20
>>>>>> sdb: ios=3D166/526079, merge=3D0/0, ticks=3D24/890120, in_queue=3D=
890064,=20
>>>>>> util=3D98.73%=20
>>>>>>=20
>>>>>> firefly:=20
>>>>>>=20
>>>>>> file1: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlib=
aio, iodepth=3D32=20
>>>>>> 2.0.8=20
>>>>>> Starting 1 thread=20
>>>>>> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/69096K /s] [0 /17.3K iops=
] [eta=20
>>>>>> 00m:00s]=20
>>>>>> file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2982=20
>>>>>> write: io=3D1784.9MB, bw=3D60918KB/s, iops=3D15229 , runt=3D 300=
02msec=20
>>>>>> slat (usec): min=3D1 , max=3D1389 , avg=3D 3.43, stdev=3D 5.32=20
>>>>>> clat (usec): min=3D117 , max=3D8235 , avg=3D2096.88, stdev=3D396=
=2E30=20
>>>>>> lat (usec): min=3D540 , max=3D8258 , avg=3D2100.43, stdev=3D396.=
61=20
>>>>>> clat percentiles (usec):=20
>>>>>> | 1.00th=3D[ 1608], 5.00th=3D[ 1720], 10.00th=3D[ 1768], 20.00th=
=3D[=20
>>>>>> 1832],=20
>>>>>> | 30.00th=3D[ 1896], 40.00th=3D[ 1944], 50.00th=3D[ 2008], 60.00=
th=3D[=20
>>>>>> 2064],=20
>>>>>> | 70.00th=3D[ 2160], 80.00th=3D[ 2256], 90.00th=3D[ 2512], 95.00=
th=3D[=20
>>>>>> 2896],=20
>>>>>> | 99.00th=3D[ 3600], 99.50th=3D[ 3792], 99.90th=3D[ 5088], 99.95=
th=3D[=20
>>>>>> 6304],=20
>>>>>> | 99.99th=3D[ 6752]=20
>>>>>> bw (KB/s) : min=3D36717, max=3D73712, per=3D99.94%, avg=3D60879.=
92,=20
>>>>>> stdev=3D8302.27=20
>>>>>> lat (usec) : 250=3D0.01%, 750=3D0.01%=20
>>>>>> lat (msec) : 2=3D48.56%, 4=3D51.18%, 10=3D0.26%=20
>>>>>> cpu : usr=3D2.03%, sys=3D5.48%, ctx=3D20440, majf=3D0, minf=3D13=
3=20
>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 3=
2=3D100.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%,=
 64=3D0.0%,=20
>>>>>>> =3D64=3D0.0%=20
>>>>>> issued : total=3Dr=3D0/w=3D456918/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0=20
>>>>>>=20
>>>>>> Run status group 0 (all jobs):=20
>>>>>> WRITE: io=3D1784.9MB, aggrb=3D60918KB/s, minb=3D60918KB/s, maxb=3D=
60918KB/s,=20
>>>>>> mint=3D30002msec, maxt=3D30002msec=20
>>>>>>=20
>>>>>> Disk stats (read/write):=20
>>>>>> sdb: ios=3D166/455574, merge=3D0/0, ticks=3D12/897748, in_queue=3D=
897696,=20
>>>>>> util=3D98.96%=20
>>>>>=20
>>>>> Ok, so it looks like as you increase concurrency the effect incre=
ases=20
>>>>> (ie contention?). Does the same thing happen without cache enable=
d?=20
>>>>=20
>>>> here again without rbd cache:=20
>>>>=20
>>>> dumpling:=20
>>>> file1: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D32=20
>>>> 2.0.8=20
>>>> Starting 1 thread=20
>>>> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/83488K /s] [0 /20.9K iops] =
[eta=20
>>>> 00m:00s]=20
>>>> file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D3000=20
>>>> write: io=3D2449.2MB, bw=3D83583KB/s, iops=3D20895 , runt=3D 30005=
msec=20
>>>> slat (usec): min=3D1 , max=3D975 , avg=3D 4.50, stdev=3D 5.25=20
>>>> clat (usec): min=3D364 , max=3D80566 , avg=3D1525.87, stdev=3D1194=
=2E57=20
>>>> lat (usec): min=3D519 , max=3D80568 , avg=3D1530.51, stdev=3D1194.=
44=20
>>>> clat percentiles (usec):=20
>>>> | 1.00th=3D[ 660], 5.00th=3D[ 780], 10.00th=3D[ 876], 20.00th=3D[=20
>>>> 1032],=20
>>>> | 30.00th=3D[ 1144], 40.00th=3D[ 1240], 50.00th=3D[ 1304], 60.00th=
=3D[=20
>>>> 1384],=20
>>>> | 70.00th=3D[ 1480], 80.00th=3D[ 1640], 90.00th=3D[ 2096], 95.00th=
=3D[=20
>>>> 2960],=20
>>>> | 99.00th=3D[ 6816], 99.50th=3D[ 7840], 99.90th=3D[11712],=20
>>>> 99.95th=3D[13888],=20
>>>> | 99.99th=3D[18816]=20
>>>> bw (KB/s) : min=3D47184, max=3D95432, per=3D100.00%, avg=3D83639.1=
9,=20
>>>> stdev=3D7973.92=20
>>>> lat (usec) : 500=3D0.01%, 750=3D3.82%, 1000=3D14.40%=20
>>>> lat (msec) : 2=3D70.57%, 4=3D7.91%, 10=3D3.11%, 20=3D0.17%, 50=3D0=
=2E01%=20
>>>> lat (msec) : 100=3D0.01%=20
>>>> cpu : usr=3D3.12%, sys=3D11.49%, ctx=3D74951, majf=3D0, minf=3D133=
=20
>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 6=
4=3D0.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> issued : total=3Dr=3D0/w=3D626979/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=
=20
>>>>=20
>>>> Run status group 0 (all jobs):=20
>>>> WRITE: io=3D2449.2MB, aggrb=3D83583KB/s, minb=3D83583KB/s, maxb=3D=
83583KB/s,=20
>>>> mint=3D30005msec, maxt=3D30005msec=20
>>>>=20
>>>> Disk stats (read/write):=20
>>>> sdb: ios=3D168/625292, merge=3D0/0, ticks=3D144/916096, in_queue=3D=
916128,=20
>>>> util=3D99.93%=20
>>>>=20
>>>>=20
>>>> firefly:=20
>>>>=20
>>>> fio --filename=3D/dev/sdb --direct=3D1 --rw=3Drandwrite --bs=3D4k =
--numjobs=3D1=20
>>>> --thread --iodepth=3D32 --ioengine=3Dlibaio --runtime=3D30 --group=
_reporting=20
>>>> --name=3Dfile1=20
>>>> file1: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D32=20
>>>> 2.0.8=20
>>>> Starting 1 thread=20
>>>> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/90044K /s] [0 /22.6K iops] =
[eta=20
>>>> 00m:00s]=20
>>>> file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2970=20
>>>> write: io=3D2372.9MB, bw=3D80976KB/s, iops=3D20244 , runt=3D 30006=
msec=20
>>>> slat (usec): min=3D1 , max=3D4047 , avg=3D 4.36, stdev=3D 7.17=20
>>>> clat (usec): min=3D197 , max=3D76656 , avg=3D1575.29, stdev=3D1165=
=2E74=20
>>>> lat (usec): min=3D523 , max=3D76660 , avg=3D1579.79, stdev=3D1165.=
59=20
>>>> clat percentiles (usec):=20
>>>> | 1.00th=3D[ 676], 5.00th=3D[ 804], 10.00th=3D[ 916], 20.00th=3D[=20
>>>> 1096],=20
>>>> | 30.00th=3D[ 1224], 40.00th=3D[ 1304], 50.00th=3D[ 1384], 60.00th=
=3D[=20
>>>> 1448],=20
>>>> | 70.00th=3D[ 1544], 80.00th=3D[ 1704], 90.00th=3D[ 2128], 95.00th=
=3D[=20
>>>> 2736],=20
>>>> | 99.00th=3D[ 6752], 99.50th=3D[ 7904], 99.90th=3D[12096],=20
>>>> 99.95th=3D[14656],=20
>>>> | 99.99th=3D[18560]=20
>>>> bw (KB/s) : min=3D47800, max=3D91952, per=3D99.91%, avg=3D80900.88=
,=20
>>>> stdev=3D7234.98=20
>>>> lat (usec) : 250=3D0.01%, 500=3D0.01%, 750=3D2.95%, 1000=3D11.38%=20
>>>> lat (msec) : 2=3D73.81%, 4=3D8.81%, 10=3D2.85%, 20=3D0.19%, 50=3D0=
=2E01%=20
>>>> lat (msec) : 100=3D0.01%=20
>>>> cpu : usr=3D2.99%, sys=3D10.60%, ctx=3D66549, majf=3D0, minf=3D133=
=20
>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 6=
4=3D0.0%,=20
>>>>> =3D64=3D0.0%=20
>>>> issued : total=3Dr=3D0/w=3D607445/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=
=20
>>>>=20
>>>> Run status group 0 (all jobs):=20
>>>> WRITE: io=3D2372.9MB, aggrb=3D80976KB/s, minb=3D80976KB/s, maxb=3D=
80976KB/s,=20
>>>> mint=3D30006msec, maxt=3D30006msec=20
>>>>=20
>>>> Disk stats (read/write):=20
>>>> sdb: ios=3D170/605440, merge=3D0/0, ticks=3D156/916492, in_queue=3D=
916560,=20
>>>> util=3D99.93%=20
>>>>=20
>>>> Stefan=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
