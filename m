From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu vivid :
 big difference
Date: Mon, 11 May 2015 17:38:51 -0400
Message-ID: <CANP1eJFn-22pheWHoHj7En8aqui92EiDnKtVW8gCvH7ML59+GA@mail.gmail.com>
References: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv>
	<1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv>
	<555084AB.60403@profihost.ag>
	<1740153338.188266335.1431354050272.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34007 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbEKVix convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 17:38:53 -0400
Received: by lbcga7 with SMTP id ga7so103794703lbc.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 14:38:51 -0700 (PDT)
In-Reply-To: <1740153338.188266335.1431354050272.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 10:20 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
>>>That's pretty interesting. I wasn't aware that there were performanc=
e
>>>optimisations in glibc.
>>>
>>>As you have a test setup. Is it possible to install jessie libc on w=
heezy?
>
> mmm, I can try that. Not sure it'll work.
>
>
> BTW, librbd cpu usage is always 3x-4x more than KRBD.
> a lot of cpu is used from malloc/free. It could be great to optimise =
that.
>
> I don't known if jemmaloc or tcmalloc could be used, like for osd dae=
mons ?

You can try it and see if it'll make a difference. Set LD_PRELOAD to
include the so of jemalloc / tcmalloc before starting FIO. Like this:

$ export LD_PRELOAD=3D${JEMALLOC_PATH}/lib/libjemalloc.so.1
$ ./run_test.sh

As a matter of policy, libraries shouldn't force a particular malloc
implementation on the users of a particular library. It might go
against the user's wishes, not to mention what conflicts would happen
if one library wanted / needed jamalloc while another one wanted /
needed tcmalloc.

>
>
> Reducing cpu usage could improve a lot qemu performance, as qemu use =
only 1 thread by disk.
>
>
>
> ----- Mail original -----
> De: "Stefan Priebe" <s.priebe@profihost.ag>
> =C3=80: "aderumier" <aderumier@odiso.com>, "cbt" <cbt@ceph.com>, "cep=
h-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Lundi 11 Mai 2015 12:30:03
> Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu v=
ivid : big difference
>
> Am 11.05.2015 um 07:53 schrieb Alexandre DERUMIER:
>> Seem that's is ok too on debian jessie (with an extra boost with rbd=
_cache true)
>>
>> Maybe is it related to old glibc on debian wheezy ?
>
> That's pretty interesting. I wasn't aware that there were performance
> optimisations in glibc.
>
> As you have a test setup. Is it possible to install jessie libc on wh=
eezy?
>
> Stefan
>
>
>>
>> debian jessie: rbd_cache=3Dfalse : iops=3D202985 : %Cpu(s): 21,9 us,=
 9,5 sy, 0,0 ni, 66,1 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st
>> debian jessie: rbd_cache=3Dtrue : iops=3D215290 : %Cpu(s): 27,9 us, =
10,8 sy, 0,0 ni, 58,8 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st
>>
>>
>> ubuntu vivid : rbd_cache=3Dfalse : iops=3D201089 %Cpu(s): 21,3 us, 1=
2,8 sy, 0,0 ni, 61,8 id, 0,0 wa, 0,0 hi, 4,1 si, 0,0 st
>> ubuntu vivid : rbd_cache=3Dtrue : iops=3D197549 %Cpu(s): 27,2 us, 15=
,3 sy, 0,0 ni, 53,2 id, 0,0 wa, 0,0 hi, 4,2 si, 0,0 st
>> debian wheezy : rbd_cache=3Dfalse: iops=3D161272 %Cpu(s): 28.4 us, 1=
5.4 sy, 0.0 ni, 52.8 id, 0.0 wa, 0.0 hi, 3.4 si, 0.0 st
>> debian wheezy : rbd_cache=3Dtrue : iops=3D135893 %Cpu(s): 30.0 us, 1=
5.5 sy, 0.0 ni, 51.5 id, 0.0 wa, 0.0 hi, 3.0 si, 0.0 st
>>
>>
>>
>> jessie perf report
>> ------------------
>> + 9,18% 3,75% fio libc-2.19.so [.] malloc
>> + 6,76% 5,70% fio libc-2.19.so [.] _int_malloc
>> + 5,83% 5,64% fio libc-2.19.so [.] _int_free
>> + 5,11% 0,15% fio libpthread-2.19.so [.] __libc_recv
>> + 4,81% 4,81% swapper [kernel.kallsyms] [k] intel_idle
>> + 3,72% 0,37% fio libpthread-2.19.so [.] pthread_cond_broadcast@@GLI=
BC_2.3.2
>> + 3,41% 0,04% fio libpthread-2.19.so [.] 0x000000000000efad
>> + 3,31% 0,54% fio libpthread-2.19.so [.] pthread_cond_wait@@GLIBC_2.=
3.2
>> + 3,19% 0,09% fio libpthread-2.19.so [.] __lll_unlock_wake
>> + 2,52% 0,00% fio librados.so.2.0.0 [.] ceph::buffer::create_aligned=
(unsigned int, unsigned int)
>> + 2,09% 0,08% fio libc-2.19.so [.] __posix_memalign
>> + 2,04% 0,26% fio libpthread-2.19.so [.] __lll_lock_wait
>> + 2,02% 0,13% fio libc-2.19.so [.] _mid_memalign
>> + 1,95% 1,91% fio libc-2.19.so [.] __memcpy_sse2_unaligned
>> + 1,88% 0,08% fio libc-2.19.so [.] _int_memalign
>> + 1,88% 0,00% fio libc-2.19.so [.] __clone
>> + 1,88% 0,00% fio libpthread-2.19.so [.] start_thread
>> + 1,88% 0,12% fio fio [.] thread_main
>> + 1,37% 1,37% swapper [kernel.kallsyms] [k] native_write_msr_safe
>> + 1,29% 0,05% fio libc-2.19.so [.] __lll_unlock_wake_private
>> + 1,24% 1,24% fio libpthread-2.19.so [.] pthread_mutex_trylock
>> + 1,24% 0,29% fio libc-2.19.so [.] __lll_lock_wait_private
>> + 1,19% 0,21% fio librbd.so.1.0.0 [.] std::_List_base<ceph::buffer::=
ptr, std::allocator<ceph::buffer::ptr> >::_M_clear()
>> + 1,19% 1,19% fio libc-2.19.so [.] free
>> + 1,18% 1,18% fio libc-2.19.so [.] malloc_consolidate
>> + 1,14% 1,14% fio [kernel.kallsyms] [k] get_futex_key_refs.isra.13
>> + 1,10% 1,10% fio [kernel.kallsyms] [k] __schedule
>> + 1,00% 0,28% fio librados.so.2.0.0 [.] ceph::buffer::list::append(c=
har const*, unsigned int)
>> + 0,96% 0,00% fio librbd.so.1.0.0 [.] 0x000000000005b2e7
>> + 0,96% 0,96% fio [kernel.kallsyms] [k] _raw_spin_lock
>> + 0,92% 0,21% fio librados.so.2.0.0 [.] ceph::buffer::list::append(c=
eph::buffer::ptr const&, unsigned int, unsigned int)
>> + 0,91% 0,00% fio librados.so.2.0.0 [.] 0x000000000006e6c0
>> + 0,90% 0,90% swapper [kernel.kallsyms] [k] __switch_to
>> + 0,89% 0,01% fio librbd.so.1.0.0 [.] 0x00000000000ce1f1
>> + 0,89% 0,89% swapper [kernel.kallsyms] [k] cpu_startup_entry
>> + 0,87% 0,01% fio librados.so.2.0.0 [.] 0x00000000002e3ff1
>> + 0,86% 0,00% fio libc-2.19.so [.] 0x00000000000dd50d
>> + 0,85% 0,85% fio [kernel.kallsyms] [k] try_to_wake_up
>> + 0,83% 0,83% swapper [kernel.kallsyms] [k] __schedule
>> + 0,82% 0,82% fio [kernel.kallsyms] [k] copy_user_enhanced_fast_stri=
ng
>> + 0,81% 0,00% fio librados.so.2.0.0 [.] 0x0000000000137abc
>> + 0,80% 0,80% swapper [kernel.kallsyms] [k] menu_select
>> + 0,75% 0,75% fio [kernel.kallsyms] [k] _raw_spin_lock_bh
>> + 0,75% 0,75% fio [kernel.kallsyms] [k] futex_wake
>> + 0,75% 0,75% fio libpthread-2.19.so [.] __pthread_mutex_unlock_user=
cnt
>> + 0,73% 0,73% fio [kernel.kallsyms] [k] __switch_to
>> + 0,70% 0,70% fio libstdc++.so.6.0.20 [.] std::basic_string<char, st=
d::char_traits<char>, std::allocator<char> >::basic_string(std::string =
const&)
>> + 0,70% 0,36% fio librados.so.2.0.0 [.] ceph::buffer::list::iterator=
::copy(unsigned int, char*)
>> + 0,70% 0,23% fio fio [.] get_io_u
>> + 0,67% 0,67% fio [kernel.kallsyms] [k] finish_task_switch
>> + 0,67% 0,32% fio libpthread-2.19.so [.] pthread_rwlock_unlock
>> + 0,67% 0,00% fio librados.so.2.0.0 [.] 0x00000000000cea98
>> + 0,64% 0,00% fio librados.so.2.0.0 [.] 0x00000000002e3f87
>> + 0,63% 0,63% fio [kernel.kallsyms] [k] futex_wait_setup
>> + 0,62% 0,62% swapper [kernel.kallsyms] [k] enqueue_task_fair
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



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
