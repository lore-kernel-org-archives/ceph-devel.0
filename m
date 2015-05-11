From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu vivid
 : big difference
Date: Mon, 11 May 2015 16:20:50 +0200 (CEST)
Message-ID: <1740153338.188266335.1431354050272.JavaMail.zimbra@oxygem.tv>
References: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv> <1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv> <555084AB.60403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:40610 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbEKOUx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 10:20:53 -0400
In-Reply-To: <555084AB.60403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>That's pretty interesting. I wasn't aware that there were performance=
=20
>>optimisations in glibc.=20
>>
>>As you have a test setup. Is it possible to install jessie libc on wh=
eezy?=20

mmm, I can try that. Not sure it'll work.


BTW, librbd cpu usage is always 3x-4x more than KRBD.=20
a lot of cpu is used from malloc/free. It could be great to optimise th=
at.

I don't known if jemmaloc or tcmalloc could be used, like for osd daemo=
ns ?


Reducing cpu usage could improve a lot qemu performance, as qemu use on=
ly 1 thread by disk.



----- Mail original -----
De: "Stefan Priebe" <s.priebe@profihost.ag>
=C3=80: "aderumier" <aderumier@odiso.com>, "cbt" <cbt@ceph.com>, "ceph-=
devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 11 Mai 2015 12:30:03
Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu viv=
id : big difference

Am 11.05.2015 um 07:53 schrieb Alexandre DERUMIER:=20
> Seem that's is ok too on debian jessie (with an extra boost with rbd_=
cache true)=20
>=20
> Maybe is it related to old glibc on debian wheezy ?=20

That's pretty interesting. I wasn't aware that there were performance=20
optimisations in glibc.=20

As you have a test setup. Is it possible to install jessie libc on whee=
zy?=20

Stefan=20


>=20
> debian jessie: rbd_cache=3Dfalse : iops=3D202985 : %Cpu(s): 21,9 us, =
9,5 sy, 0,0 ni, 66,1 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st=20
> debian jessie: rbd_cache=3Dtrue : iops=3D215290 : %Cpu(s): 27,9 us, 1=
0,8 sy, 0,0 ni, 58,8 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st=20
>=20
>=20
> ubuntu vivid : rbd_cache=3Dfalse : iops=3D201089 %Cpu(s): 21,3 us, 12=
,8 sy, 0,0 ni, 61,8 id, 0,0 wa, 0,0 hi, 4,1 si, 0,0 st=20
> ubuntu vivid : rbd_cache=3Dtrue : iops=3D197549 %Cpu(s): 27,2 us, 15,=
3 sy, 0,0 ni, 53,2 id, 0,0 wa, 0,0 hi, 4,2 si, 0,0 st=20
> debian wheezy : rbd_cache=3Dfalse: iops=3D161272 %Cpu(s): 28.4 us, 15=
=2E4 sy, 0.0 ni, 52.8 id, 0.0 wa, 0.0 hi, 3.4 si, 0.0 st=20
> debian wheezy : rbd_cache=3Dtrue : iops=3D135893 %Cpu(s): 30.0 us, 15=
=2E5 sy, 0.0 ni, 51.5 id, 0.0 wa, 0.0 hi, 3.0 si, 0.0 st=20
>=20
>=20
>=20
> jessie perf report=20
> ------------------=20
> + 9,18% 3,75% fio libc-2.19.so [.] malloc=20
> + 6,76% 5,70% fio libc-2.19.so [.] _int_malloc=20
> + 5,83% 5,64% fio libc-2.19.so [.] _int_free=20
> + 5,11% 0,15% fio libpthread-2.19.so [.] __libc_recv=20
> + 4,81% 4,81% swapper [kernel.kallsyms] [k] intel_idle=20
> + 3,72% 0,37% fio libpthread-2.19.so [.] pthread_cond_broadcast@@GLIB=
C_2.3.2=20
> + 3,41% 0,04% fio libpthread-2.19.so [.] 0x000000000000efad=20
> + 3,31% 0,54% fio libpthread-2.19.so [.] pthread_cond_wait@@GLIBC_2.3=
=2E2=20
> + 3,19% 0,09% fio libpthread-2.19.so [.] __lll_unlock_wake=20
> + 2,52% 0,00% fio librados.so.2.0.0 [.] ceph::buffer::create_aligned(=
unsigned int, unsigned int)=20
> + 2,09% 0,08% fio libc-2.19.so [.] __posix_memalign=20
> + 2,04% 0,26% fio libpthread-2.19.so [.] __lll_lock_wait=20
> + 2,02% 0,13% fio libc-2.19.so [.] _mid_memalign=20
> + 1,95% 1,91% fio libc-2.19.so [.] __memcpy_sse2_unaligned=20
> + 1,88% 0,08% fio libc-2.19.so [.] _int_memalign=20
> + 1,88% 0,00% fio libc-2.19.so [.] __clone=20
> + 1,88% 0,00% fio libpthread-2.19.so [.] start_thread=20
> + 1,88% 0,12% fio fio [.] thread_main=20
> + 1,37% 1,37% swapper [kernel.kallsyms] [k] native_write_msr_safe=20
> + 1,29% 0,05% fio libc-2.19.so [.] __lll_unlock_wake_private=20
> + 1,24% 1,24% fio libpthread-2.19.so [.] pthread_mutex_trylock=20
> + 1,24% 0,29% fio libc-2.19.so [.] __lll_lock_wait_private=20
> + 1,19% 0,21% fio librbd.so.1.0.0 [.] std::_List_base<ceph::buffer::p=
tr, std::allocator<ceph::buffer::ptr> >::_M_clear()=20
> + 1,19% 1,19% fio libc-2.19.so [.] free=20
> + 1,18% 1,18% fio libc-2.19.so [.] malloc_consolidate=20
> + 1,14% 1,14% fio [kernel.kallsyms] [k] get_futex_key_refs.isra.13=20
> + 1,10% 1,10% fio [kernel.kallsyms] [k] __schedule=20
> + 1,00% 0,28% fio librados.so.2.0.0 [.] ceph::buffer::list::append(ch=
ar const*, unsigned int)=20
> + 0,96% 0,00% fio librbd.so.1.0.0 [.] 0x000000000005b2e7=20
> + 0,96% 0,96% fio [kernel.kallsyms] [k] _raw_spin_lock=20
> + 0,92% 0,21% fio librados.so.2.0.0 [.] ceph::buffer::list::append(ce=
ph::buffer::ptr const&, unsigned int, unsigned int)=20
> + 0,91% 0,00% fio librados.so.2.0.0 [.] 0x000000000006e6c0=20
> + 0,90% 0,90% swapper [kernel.kallsyms] [k] __switch_to=20
> + 0,89% 0,01% fio librbd.so.1.0.0 [.] 0x00000000000ce1f1=20
> + 0,89% 0,89% swapper [kernel.kallsyms] [k] cpu_startup_entry=20
> + 0,87% 0,01% fio librados.so.2.0.0 [.] 0x00000000002e3ff1=20
> + 0,86% 0,00% fio libc-2.19.so [.] 0x00000000000dd50d=20
> + 0,85% 0,85% fio [kernel.kallsyms] [k] try_to_wake_up=20
> + 0,83% 0,83% swapper [kernel.kallsyms] [k] __schedule=20
> + 0,82% 0,82% fio [kernel.kallsyms] [k] copy_user_enhanced_fast_strin=
g=20
> + 0,81% 0,00% fio librados.so.2.0.0 [.] 0x0000000000137abc=20
> + 0,80% 0,80% swapper [kernel.kallsyms] [k] menu_select=20
> + 0,75% 0,75% fio [kernel.kallsyms] [k] _raw_spin_lock_bh=20
> + 0,75% 0,75% fio [kernel.kallsyms] [k] futex_wake=20
> + 0,75% 0,75% fio libpthread-2.19.so [.] __pthread_mutex_unlock_userc=
nt=20
> + 0,73% 0,73% fio [kernel.kallsyms] [k] __switch_to=20
> + 0,70% 0,70% fio libstdc++.so.6.0.20 [.] std::basic_string<char, std=
::char_traits<char>, std::allocator<char> >::basic_string(std::string c=
onst&)=20
> + 0,70% 0,36% fio librados.so.2.0.0 [.] ceph::buffer::list::iterator:=
:copy(unsigned int, char*)=20
> + 0,70% 0,23% fio fio [.] get_io_u=20
> + 0,67% 0,67% fio [kernel.kallsyms] [k] finish_task_switch=20
> + 0,67% 0,32% fio libpthread-2.19.so [.] pthread_rwlock_unlock=20
> + 0,67% 0,00% fio librados.so.2.0.0 [.] 0x00000000000cea98=20
> + 0,64% 0,00% fio librados.so.2.0.0 [.] 0x00000000002e3f87=20
> + 0,63% 0,63% fio [kernel.kallsyms] [k] futex_wait_setup=20
> + 0,62% 0,62% swapper [kernel.kallsyms] [k] enqueue_task_fair=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
