From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu vivid :
 big difference
Date: Tue, 12 May 2015 10:37:38 -0400
Message-ID: <CANP1eJECvvBAEmd32hyMkObXU=XZugcwvb=_VPbyN8EOL+-G4w@mail.gmail.com>
References: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv>
	<1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv>
	<555084AB.60403@profihost.ag>
	<1740153338.188266335.1431354050272.JavaMail.zimbra@oxygem.tv>
	<CANP1eJFn-22pheWHoHj7En8aqui92EiDnKtVW8gCvH7ML59+GA@mail.gmail.com>
	<2095455190.206287571.1431390861421.JavaMail.zimbra@oxygem.tv>
	<555199B8.60003@profihost.ag>
	<921280208.220833742.1431418637988.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34663 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788AbbELOhk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 10:37:40 -0400
Received: by lbcga7 with SMTP id ga7so7564717lbc.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 07:37:38 -0700 (PDT)
In-Reply-To: <921280208.220833742.1431418637988.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 12, 2015 at 4:17 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>Sounds good. Any reason for not switching to tcmalloc by default in =
PVE?
>
> I'm currently benching it inside qemu, but I don't see too much impro=
vements
>
> I'm around 30000iops by virtio disk, glibc or tcmalloc. (don't known =
if jemmaloc works fine with qemu)

I'm going to guess that there's a whole slew of stuff that happens
between qemu and the guest that results in a lower bound for iops.

>
>
> I don't known if all this memory allocations call could be reduce in =
librbd/librados ?
>

Maybe you can use perf to find the worst offending hotspots and place t=
o start?

>
>
> ----- Mail original -----
> De: "Stefan Priebe" <s.priebe@profihost.ag>
> =C3=80: "aderumier" <aderumier@odiso.com>, "Milosz Tanski" <milosz@ad=
fin.com>
> Cc: "cbt" <cbt@ceph.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mardi 12 Mai 2015 08:12:08
> Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu v=
ivid : big difference
>
> Am 12.05.2015 um 02:34 schrieb Alexandre DERUMIER:
>>>> ou can try it and see if it'll make a difference. Set LD_PRELOAD t=
o
>>>> include the so of jemalloc / tcmalloc before starting FIO. Like th=
is:
>>>>
>>>> $ export LD_PRELOAD=3D${JEMALLOC_PATH}/lib/libjemalloc.so.1
>>>> $ ./run_test.sh
>>
>> Thanks it's working.
>>
>> Seem that jemmaloc with fio-rbd give 17% iops improvement and reduce=
 latencies and cpu usage !
>>
>> results with 1 numjob:
>>
>> glibc : iops=3D36668 usr=3D62.23%, sys=3D12.13%
>> libtcmalloc : iops=3D36105 usr=3D63.54%, sys=3D8.45%
>> jemalloc: iops=3D43181 usr=3D60.91%, sys=3D10.51%
>>
>>
>> (with 10numjobs, i'm around 240k iops with jemalloc vs 220k iops wit=
h glibc/tcmalloc)
>>
>>
>> I just found a qemu git a patch to enable tcmalloc
>> http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2847b46958ab0bd=
604e1b3fcafba0f5ba4375833
>> I'll try to test it to see if it's help
>
> Sounds good. Any reason for not switching to tcmalloc by default in P=
VE?
>
> Stefan
>
>>
>>
>>
>>
>>
>>
>> fio results
>> ------------
>>
>> glibc
>> -----
>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [123.9MB/0KB/0KB /s] [31.8K/0/=
0 iops] [eta 00m:00s]
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D7239: T=
ue May 12 02:05:46 2015
>> read : io=3D30000MB, bw=3D146675KB/s, iops=3D36668, runt=3D209443mse=
c
>> slat (usec): min=3D8, max=3D1245, avg=3D26.07, stdev=3D13.99
>> clat (usec): min=3D107, max=3D4752, avg=3D525.40, stdev=3D207.46
>> lat (usec): min=3D126, max=3D4767, avg=3D551.47, stdev=3D208.27
>> clat percentiles (usec):
>> | 1.00th=3D[ 171], 5.00th=3D[ 215], 10.00th=3D[ 253], 20.00th=3D[ 32=
2],
>> | 30.00th=3D[ 386], 40.00th=3D[ 450], 50.00th=3D[ 516], 60.00th=3D[ =
588],
>> | 70.00th=3D[ 652], 80.00th=3D[ 716], 90.00th=3D[ 796], 95.00th=3D[ =
868],
>> | 99.00th=3D[ 996], 99.50th=3D[ 1048], 99.90th=3D[ 1192], 99.95th=3D=
[ 1240],
>> | 99.99th=3D[ 1368]
>> bw (KB /s): min=3D112328, max=3D176848, per=3D100.00%, avg=3D146768.=
86, stdev=3D12974.09
>> lat (usec) : 250=3D9.61%, 500=3D37.58%, 750=3D37.25%, 1000=3D14.60%
>> lat (msec) : 2=3D0.96%, 4=3D0.01%, 10=3D0.01%
>> cpu : usr=3D62.23%, sys=3D12.13%, ctx=3D10008821, majf=3D0, minf=3D1=
348
>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D3.0%, 8=3D28.8%, 16=3D64.2%, 32=3D=
4.0%, >=3D64=3D0.0%
>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%
>> complete : 0=3D0.0%, 4=3D96.1%, 8=3D0.1%, 16=3D0.1%, 32=3D3.9%, 64=3D=
0.0%, >=3D64=3D0.0%
>> issued : total=3Dr=3D7680000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0,=
 drop=3Dr=3D0/w=3D0/d=3D0
>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>>
>> Run status group 0 (all jobs):
>> READ: io=3D30000MB, aggrb=3D146674KB/s, minb=3D146674KB/s, maxb=3D14=
6674KB/s, mint=3D209443msec, maxt=3D209443msec
>>
>> Disk stats (read/write):
>> sdb: ios=3D0/22, merge=3D0/13, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%
>>
>>
>> jemmaloc
>> --------
>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [165.4MB/0KB/0KB /s] [42.3K/0/=
0 iops] [eta 00m:00s]
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D7137: T=
ue May 12 02:01:25 2015
>> read : io=3D30000MB, bw=3D172726KB/s, iops=3D43181, runt=3D177854mse=
c
>> slat (usec): min=3D6, max=3D563, avg=3D22.28, stdev=3D14.68
>> clat (usec): min=3D95, max=3D3559, avg=3D456.29, stdev=3D168.37
>> lat (usec): min=3D110, max=3D3579, avg=3D478.56, stdev=3D169.06
>> clat percentiles (usec):
>> | 1.00th=3D[ 161], 5.00th=3D[ 201], 10.00th=3D[ 233], 20.00th=3D[ 29=
0],
>> | 30.00th=3D[ 346], 40.00th=3D[ 402], 50.00th=3D[ 454], 60.00th=3D[ =
506],
>> | 70.00th=3D[ 556], 80.00th=3D[ 612], 90.00th=3D[ 676], 95.00th=3D[ =
732],
>> | 99.00th=3D[ 844], 99.50th=3D[ 900], 99.90th=3D[ 1020], 99.95th=3D[=
 1064],
>> | 99.99th=3D[ 1192]
>> bw (KB /s): min=3D129936, max=3D199712, per=3D100.00%, avg=3D172822.=
83, stdev=3D11812.99
>> lat (usec) : 100=3D0.01%, 250=3D12.77%, 500=3D45.87%, 750=3D37.60%, =
1000=3D3.62%
>> lat (msec) : 2=3D0.13%, 4=3D0.01%
>> cpu : usr=3D60.91%, sys=3D10.51%, ctx=3D9329053, majf=3D0, minf=3D16=
87
>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D1.8%, 8=3D26.4%, 16=3D67.5%, 32=3D=
4.2%, >=3D64=3D0.0%
>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%
>> complete : 0=3D0.0%, 4=3D95.9%, 8=3D0.1%, 16=3D0.1%, 32=3D4.0%, 64=3D=
0.0%, >=3D64=3D0.0%
>> issued : total=3Dr=3D7680000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0,=
 drop=3Dr=3D0/w=3D0/d=3D0
>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>>
>> Run status group 0 (all jobs):
>> READ: io=3D30000MB, aggrb=3D172725KB/s, minb=3D172725KB/s, maxb=3D17=
2725KB/s, mint=3D177854msec, maxt=3D177854msec
>>
>> Disk stats (read/write):
>> sdb: ios=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%
>>
>>
>> libtcmalloc
>> ------------
>> rbd engine: RBD version: 0.1.10
>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [140.1MB/0KB/0KB /s] [35.9K/0/=
0 iops] [eta 00m:00s]
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D7039: T=
ue May 12 01:57:41 2015
>> read : io=3D30000MB, bw=3D144423KB/s, iops=3D36105, runt=3D212708mse=
c
>> slat (usec): min=3D10, max=3D803, avg=3D26.65, stdev=3D17.68
>> clat (usec): min=3D54, max=3D5052, avg=3D530.82, stdev=3D216.05
>> lat (usec): min=3D114, max=3D5531, avg=3D557.46, stdev=3D217.22
>> clat percentiles (usec):
>> | 1.00th=3D[ 169], 5.00th=3D[ 213], 10.00th=3D[ 251], 20.00th=3D[ 32=
2],
>> | 30.00th=3D[ 386], 40.00th=3D[ 454], 50.00th=3D[ 524], 60.00th=3D[ =
596],
>> | 70.00th=3D[ 660], 80.00th=3D[ 724], 90.00th=3D[ 804], 95.00th=3D[ =
876],
>> | 99.00th=3D[ 1048], 99.50th=3D[ 1128], 99.90th=3D[ 1336], 99.95th=3D=
[ 1464],
>> | 99.99th=3D[ 2256]
>> bw (KB /s): min=3D60416, max=3D161496, per=3D100.00%, avg=3D144529.5=
0, stdev=3D10827.54
>> lat (usec) : 100=3D0.01%, 250=3D9.88%, 500=3D36.69%, 750=3D36.97%, 1=
000=3D14.88%
>> lat (msec) : 2=3D1.57%, 4=3D0.01%, 10=3D0.01%
>> cpu : usr=3D63.54%, sys=3D8.45%, ctx=3D9209514, majf=3D0, minf=3D212=
0
>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D3.0%, 8=3D28.9%, 16=3D64.0%, 32=3D=
4.0%, >=3D64=3D0.0%
>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%
>> complete : 0=3D0.0%, 4=3D96.1%, 8=3D0.1%, 16=3D0.1%, 32=3D3.8%, 64=3D=
0.0%, >=3D64=3D0.0%
>> issued : total=3Dr=3D7680000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0,=
 drop=3Dr=3D0/w=3D0/d=3D0
>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>>
>>
>>
>>
>>
>> ----- Mail original -----
>> De: "Milosz Tanski" <milosz@adfin.com>
>> =C3=80: "aderumier" <aderumier@odiso.com>
>> Cc: "Stefan Priebe" <s.priebe@profihost.ag>, "cbt" <cbt@ceph.com>, "=
ceph-devel" <ceph-devel@vger.kernel.org>
>> Envoy=C3=A9: Lundi 11 Mai 2015 23:38:51
>> Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu =
vivid : big difference
>>
>> On Mon, May 11, 2015 at 10:20 AM, Alexandre DERUMIER
>> <aderumier@odiso.com> wrote:
>>>>> That's pretty interesting. I wasn't aware that there were perform=
ance
>>>>> optimisations in glibc.
>>>>>
>>>>> As you have a test setup. Is it possible to install jessie libc o=
n wheezy?
>>>
>>> mmm, I can try that. Not sure it'll work.
>>>
>>>
>>> BTW, librbd cpu usage is always 3x-4x more than KRBD.
>>> a lot of cpu is used from malloc/free. It could be great to optimis=
e that.
>>>
>>> I don't known if jemmaloc or tcmalloc could be used, like for osd d=
aemons ?
>>
>> You can try it and see if it'll make a difference. Set LD_PRELOAD to
>> include the so of jemalloc / tcmalloc before starting FIO. Like this=
:
>>
>> $ export LD_PRELOAD=3D${JEMALLOC_PATH}/lib/libjemalloc.so.1
>> $ ./run_test.sh
>>
>> As a matter of policy, libraries shouldn't force a particular malloc
>> implementation on the users of a particular library. It might go
>> against the user's wishes, not to mention what conflicts would happe=
n
>> if one library wanted / needed jamalloc while another one wanted /
>> needed tcmalloc.
>>
>>>
>>>
>>> Reducing cpu usage could improve a lot qemu performance, as qemu us=
e only 1 thread by disk.
>>>
>>>
>>>
>>> ----- Mail original -----
>>> De: "Stefan Priebe" <s.priebe@profihost.ag>
>>> =C3=80: "aderumier" <aderumier@odiso.com>, "cbt" <cbt@ceph.com>, "c=
eph-devel" <ceph-devel@vger.kernel.org>
>>> Envoy=C3=A9: Lundi 11 Mai 2015 12:30:03
>>> Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu=
 vivid : big difference
>>>
>>> Am 11.05.2015 um 07:53 schrieb Alexandre DERUMIER:
>>>> Seem that's is ok too on debian jessie (with an extra boost with r=
bd_cache true)
>>>>
>>>> Maybe is it related to old glibc on debian wheezy ?
>>>
>>> That's pretty interesting. I wasn't aware that there were performan=
ce
>>> optimisations in glibc.
>>>
>>> As you have a test setup. Is it possible to install jessie libc on =
wheezy?
>>>
>>> Stefan
>>>
>>>
>>>>
>>>> debian jessie: rbd_cache=3Dfalse : iops=3D202985 : %Cpu(s): 21,9 u=
s, 9,5 sy, 0,0 ni, 66,1 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st
>>>> debian jessie: rbd_cache=3Dtrue : iops=3D215290 : %Cpu(s): 27,9 us=
, 10,8 sy, 0,0 ni, 58,8 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st
>>>>
>>>>
>>>> ubuntu vivid : rbd_cache=3Dfalse : iops=3D201089 %Cpu(s): 21,3 us,=
 12,8 sy, 0,0 ni, 61,8 id, 0,0 wa, 0,0 hi, 4,1 si, 0,0 st
>>>> ubuntu vivid : rbd_cache=3Dtrue : iops=3D197549 %Cpu(s): 27,2 us, =
15,3 sy, 0,0 ni, 53,2 id, 0,0 wa, 0,0 hi, 4,2 si, 0,0 st
>>>> debian wheezy : rbd_cache=3Dfalse: iops=3D161272 %Cpu(s): 28.4 us,=
 15.4 sy, 0.0 ni, 52.8 id, 0.0 wa, 0.0 hi, 3.4 si, 0.0 st
>>>> debian wheezy : rbd_cache=3Dtrue : iops=3D135893 %Cpu(s): 30.0 us,=
 15.5 sy, 0.0 ni, 51.5 id, 0.0 wa, 0.0 hi, 3.0 si, 0.0 st
>>>>
>>>>
>>>>
>>>> jessie perf report
>>>> ------------------
>>>> + 9,18% 3,75% fio libc-2.19.so [.] malloc
>>>> + 6,76% 5,70% fio libc-2.19.so [.] _int_malloc
>>>> + 5,83% 5,64% fio libc-2.19.so [.] _int_free
>>>> + 5,11% 0,15% fio libpthread-2.19.so [.] __libc_recv
>>>> + 4,81% 4,81% swapper [kernel.kallsyms] [k] intel_idle
>>>> + 3,72% 0,37% fio libpthread-2.19.so [.] pthread_cond_broadcast@@G=
LIBC_2.3.2
>>>> + 3,41% 0,04% fio libpthread-2.19.so [.] 0x000000000000efad
>>>> + 3,31% 0,54% fio libpthread-2.19.so [.] pthread_cond_wait@@GLIBC_=
2.3.2
>>>> + 3,19% 0,09% fio libpthread-2.19.so [.] __lll_unlock_wake
>>>> + 2,52% 0,00% fio librados.so.2.0.0 [.] ceph::buffer::create_align=
ed(unsigned int, unsigned int)
>>>> + 2,09% 0,08% fio libc-2.19.so [.] __posix_memalign
>>>> + 2,04% 0,26% fio libpthread-2.19.so [.] __lll_lock_wait
>>>> + 2,02% 0,13% fio libc-2.19.so [.] _mid_memalign
>>>> + 1,95% 1,91% fio libc-2.19.so [.] __memcpy_sse2_unaligned
>>>> + 1,88% 0,08% fio libc-2.19.so [.] _int_memalign
>>>> + 1,88% 0,00% fio libc-2.19.so [.] __clone
>>>> + 1,88% 0,00% fio libpthread-2.19.so [.] start_thread
>>>> + 1,88% 0,12% fio fio [.] thread_main
>>>> + 1,37% 1,37% swapper [kernel.kallsyms] [k] native_write_msr_safe
>>>> + 1,29% 0,05% fio libc-2.19.so [.] __lll_unlock_wake_private
>>>> + 1,24% 1,24% fio libpthread-2.19.so [.] pthread_mutex_trylock
>>>> + 1,24% 0,29% fio libc-2.19.so [.] __lll_lock_wait_private
>>>> + 1,19% 0,21% fio librbd.so.1.0.0 [.] std::_List_base<ceph::buffer=
::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear()
>>>> + 1,19% 1,19% fio libc-2.19.so [.] free
>>>> + 1,18% 1,18% fio libc-2.19.so [.] malloc_consolidate
>>>> + 1,14% 1,14% fio [kernel.kallsyms] [k] get_futex_key_refs.isra.13
>>>> + 1,10% 1,10% fio [kernel.kallsyms] [k] __schedule
>>>> + 1,00% 0,28% fio librados.so.2.0.0 [.] ceph::buffer::list::append=
(char const*, unsigned int)
>>>> + 0,96% 0,00% fio librbd.so.1.0.0 [.] 0x000000000005b2e7
>>>> + 0,96% 0,96% fio [kernel.kallsyms] [k] _raw_spin_lock
>>>> + 0,92% 0,21% fio librados.so.2.0.0 [.] ceph::buffer::list::append=
(ceph::buffer::ptr const&, unsigned int, unsigned int)
>>>> + 0,91% 0,00% fio librados.so.2.0.0 [.] 0x000000000006e6c0
>>>> + 0,90% 0,90% swapper [kernel.kallsyms] [k] __switch_to
>>>> + 0,89% 0,01% fio librbd.so.1.0.0 [.] 0x00000000000ce1f1
>>>> + 0,89% 0,89% swapper [kernel.kallsyms] [k] cpu_startup_entry
>>>> + 0,87% 0,01% fio librados.so.2.0.0 [.] 0x00000000002e3ff1
>>>> + 0,86% 0,00% fio libc-2.19.so [.] 0x00000000000dd50d
>>>> + 0,85% 0,85% fio [kernel.kallsyms] [k] try_to_wake_up
>>>> + 0,83% 0,83% swapper [kernel.kallsyms] [k] __schedule
>>>> + 0,82% 0,82% fio [kernel.kallsyms] [k] copy_user_enhanced_fast_st=
ring
>>>> + 0,81% 0,00% fio librados.so.2.0.0 [.] 0x0000000000137abc
>>>> + 0,80% 0,80% swapper [kernel.kallsyms] [k] menu_select
>>>> + 0,75% 0,75% fio [kernel.kallsyms] [k] _raw_spin_lock_bh
>>>> + 0,75% 0,75% fio [kernel.kallsyms] [k] futex_wake
>>>> + 0,75% 0,75% fio libpthread-2.19.so [.] __pthread_mutex_unlock_us=
ercnt
>>>> + 0,73% 0,73% fio [kernel.kallsyms] [k] __switch_to
>>>> + 0,70% 0,70% fio libstdc++.so.6.0.20 [.] std::basic_string<char, =
std::char_traits<char>, std::allocator<char> >::basic_string(std::strin=
g const&)
>>>> + 0,70% 0,36% fio librados.so.2.0.0 [.] ceph::buffer::list::iterat=
or::copy(unsigned int, char*)
>>>> + 0,70% 0,23% fio fio [.] get_io_u
>>>> + 0,67% 0,67% fio [kernel.kallsyms] [k] finish_task_switch
>>>> + 0,67% 0,32% fio libpthread-2.19.so [.] pthread_rwlock_unlock
>>>> + 0,67% 0,00% fio librados.so.2.0.0 [.] 0x00000000000cea98
>>>> + 0,64% 0,00% fio librados.so.2.0.0 [.] 0x00000000002e3f87
>>>> + 0,63% 0,63% fio [kernel.kallsyms] [k] futex_wait_setup
>>>> + 0,62% 0,62% swapper [kernel.kallsyms] [k] enqueue_task_fair
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
