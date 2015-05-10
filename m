From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: client fio-rbd benchmark : debian wheezy vs ubuntu vivid  : big
 difference
Date: Sun, 10 May 2015 11:05:52 +0200 (CEST)
Message-ID: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59384 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbEJJF5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 05:05:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cbt@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have done some client benchmark with fio-rbd.

ubuntu vivid vs debian wheezy (kernel 3.16), and the difference is huge:

fio-rbd benchmark, with 10jobs - 4k randread - 1 rbd volume of 10GB - 1 osd:



ubuntu vivid : rbd_cache=false :  iops=201089  %Cpu(s): 21,3 us, 12,8 sy,  0,0 ni, 61,8 id,  0,0 wa,  0,0 hi,  4,1 si,  0,0 st
ubuntu vivid : rbd_cache=true :   iops=197549  %Cpu(s): 27,2 us, 15,3 sy,  0,0 ni, 53,2 id,  0,0 wa,  0,0 hi,  4,2 si,  0,0 st
debian wheezy : rbd_cache=false : iops=161272  %Cpu(s): 28.4 us, 15.4 sy,  0.0 ni, 52.8 id,  0.0 wa,  0.0 hi,  3.4 si,  0.0 st
debian wheezy : rbd_cache=true :  iops=135893  %Cpu(s): 30.0 us, 15.5 sy,  0.0 ni, 51.5 id,  0.0 wa,  0.0 hi,  3.0 si,  0.0 st



I have done perf record, and it's really different.

(I'll try to test with debian jessie and centos7 to compare)


debian wheezy:
---------------
+   12.39%     0.19%           fio  libstdc++.so.6.0.17      [.] operator new(unsigned long)
+   12.07%     5.28%           fio  libc-2.13.so             [.] malloc
+    9.41%     0.20%           fio  libc-2.13.so             [.] __lll_unlock_wake_private
+    8.76%     5.78%           fio  libc-2.13.so             [.] free
+    8.01%     5.96%           fio  libc-2.13.so             [.] _int_malloc
+    7.55%     1.08%           fio  libc-2.13.so             [.] __lll_lock_wait_private
+    4.67%     4.67%           fio  [kernel.kallsyms]        [k] _raw_spin_lock
+    4.51%     4.51%       swapper  [kernel.kallsyms]        [k] intel_idle
+    3.47%     0.02%           fio  libpthread-2.13.so       [.] 0x000000000000e72d
+    3.31%     0.02%           fio  librados.so.2.0.0        [.] ceph::buffer::create_aligned(unsigned int, unsigned int)
+    3.29%     0.01%           fio  libc-2.13.so             [.] __posix_memalign
+    3.28%     0.27%           fio  libc-2.13.so             [.] __libc_memalign
+    2.95%     0.07%           fio  libc-2.13.so             [.] _int_memalign
+    2.87%     0.25%           fio  libpthread-2.13.so       [.] pthread_cond_broadcast@@GLIBC_2.3.2
+    2.81%     2.50%           fio  libc-2.13.so             [.] _int_free
+    2.42%     0.18%           fio  librbd.so.1.0.0          [.] std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear()
+    2.29%     0.25%           fio  libpthread-2.13.so       [.] pthread_cond_wait@@GLIBC_2.3.2
+    1.83%     1.71%           fio  libc-2.13.so             [.] malloc_consolidate
+    1.79%     0.05%           fio  libpthread-2.13.so       [.] __libc_recv
+    1.79%     1.79%           fio  [kernel.kallsyms]        [k] futex_wake
+    1.61%     0.06%           fio  libpthread-2.13.so       [.] __lll_unlock_wake
+    1.50%     1.50%           fio  [kernel.kallsyms]        [k] futex_wait_setup
+    1.47%     0.00%           fio  libc-2.13.so             [.] __clone
+    1.47%     0.00%           fio  libpthread-2.13.so       [.] start_thread
+    1.47%     0.09%           fio  fio                      [.] thread_main
+    1.44%     1.29%           fio  libc-2.13.so             [.] __memcpy_ssse3
+    1.39%     1.39%       swapper  [kernel.kallsyms]        [k] native_write_msr_safe
+    1.38%     0.09%           fio  libpthread-2.13.so       [.] __lll_lock_wait
+    1.26%     0.07%           fio  libc-2.13.so             [.] _L_lock_9676
+    1.20%     1.20%           fio  [kernel.kallsyms]        [k] try_to_wake_up
+    1.17%     1.17%           fio  [kernel.kallsyms]        [k] __schedule
+    1.12%     1.03%           fio  libc-2.13.so             [.] arena_get2
+    1.08%     1.08%           fio  [kernel.kallsyms]        [k] get_futex_key_refs
+    0.96%     0.96%       swapper  [kernel.kallsyms]        [k] cpu_startup_entry
+    0.93%     0.93%       swapper  [kernel.kallsyms]        [k] enqueue_task_fair
+    0.87%     0.87%       swapper  [kernel.kallsyms]        [k] __schedule
+    0.87%     0.80%           fio  libpthread-2.13.so       [.] pthread_mutex_trylock
+    0.81%     0.01%           fio  librados.so.2.0.0        [.] 0x0000000000292030
+    0.75%     0.75%       swapper  [kernel.kallsyms]        [k] __switch_to
+    0.74%     0.74%           fio  [kernel.kallsyms]        [k] futex_wait
+    0.72%     0.01%           fio  fio                      [.] wait_for_completions
+    0.71%     0.71%           fio  [kernel.kallsyms]        [k] __switch_to
+    0.71%     0.01%           fio  fio                      [.] io_u_queued_complete
+    0.70%     0.70%       swapper  [kernel.kallsyms]        [k] _raw_spin_lock_irqsave
+    0.68%     0.68%           fio  [kernel.kallsyms]        [k] finish_task_switch
+    0.68%     0.00%           fio  librados.so.2.0.0        [.] 0x0000000000050ad0
+    0.65%     0.61%           fio  libpthread-2.13.so       [.] __pthread_mutex_unlock_usercnt
+    0.64%     0.64%           fio  [kernel.kallsyms]        [k] wake_futex
+    0.64%     0.00%           fio  librbd.so.1.0.0          [.] 0x0000000000045f9b
+    0.63%     0.10%           fio  librados.so.2.0.0        [.] ceph::buffer::ptr::append(char const*, unsigned int)
+    0.63%     0.00%           fio  [unknown]                [.] 0x0000000000000030
+    0.63%     0.63%           fio  [kernel.kallsyms]        [k] _raw_spin_lock_irqsave
+    0.60%     0.00%           fio  librados.so.2.0.0        [.] 0x0000000000103fec
+    0.59%     0.00%           fio  librbd.so.1.0.0          [.] 0x000000000033a9ae
+    0.58%     0.00%           fio  librbd.so.1.0.0          [.] 0x0000000000044962
+    0.57%     0.00%           fio  fio                      [.] td_io_getevents
+    0.56%     0.02%           fio  fio                      [.] fio_rbd_getevents
+    0.55%     0.00%           fio  librbd.so.1.0.0          [.] 0x000000000033b23e


ubuntu vivid
------------
+   28,37%     0,03%  fio              [kernel.kallsyms]    [k] system_call_fastpath
+   20,78%     0,67%  swapper          [kernel.kallsyms]    [k] cpu_startup_entry
+   20,60%     0,00%  swapper          [kernel.kallsyms]    [k] start_secondary
+   18,85%     0,09%  fio              [kernel.kallsyms]    [k] sys_futex
+   18,71%     0,08%  fio              [kernel.kallsyms]    [k] do_futex
+    8,39%     0,45%  fio              [kernel.kallsyms]    [k] wake_futex
+    8,31%     0,42%  fio              [kernel.kallsyms]    [k] try_to_wake_up
+    7,78%     0,00%  fio              [kernel.kallsyms]    [k] wake_up_state
+    7,67%     0,04%  fio              [kernel.kallsyms]    [k] ret_from_intr
+    7,62%     0,04%  fio              [kernel.kallsyms]    [k] do_IRQ
+    7,41%     0,34%  fio              [kernel.kallsyms]    [k] futex_wait
+    7,10%     0,00%  swapper          [kernel.kallsyms]    [k] cpuidle_enter
+    6,97%     0,05%  fio              [kernel.kallsyms]    [k] __do_softirq
+    6,88%     0,02%  fio              [kernel.kallsyms]    [k] irq_exit
+    6,71%     0,34%  fio              libpthread-2.21.so   [.] pthread_cond_broadcast@@GLIBC_2.3.2
+    5,93%     0,57%  fio              [kernel.kallsyms]    [k] futex_requeue
+    5,77%     0,04%  fio              [kernel.kallsyms]    [k] net_rx_action
+    5,57%     0,14%  fio              [kernel.kallsyms]    [k] schedule
+    5,49%     0,96%  fio              [kernel.kallsyms]    [k] __sched_text_start
+    5,38%     0,00%  fio              [unknown]            [.] 0x0000000000000001
+    5,20%     0,20%  fio              [kernel.kallsyms]    [k] futex_wait_queue_me
+    5,09%     0,00%  fio              [kernel.kallsyms]    [k] mlx4_en_poll_rx_cq
+    4,99%     0,00%  fio              [unknown]            [.] 0000000000000000
+    4,99%     0,06%  fio              libpthread-2.21.so   [.] __libc_sendmsg
+    4,87%     0,57%  fio              [kernel.kallsyms]    [k] futex_wake
+    4,78%     0,36%  fio              libpthread-2.21.so   [.] pthread_cond_wait@@GLIBC_2.3.2
+    4,75%     0,00%  fio              [kernel.kallsyms]    [k] sys_sendmsg
+    4,73%     0,13%  swapper          [kernel.kallsyms]    [k] cpuidle_enter_state
+    4,69%     0,02%  fio              [kernel.kallsyms]    [k] __sys_sendmsg
+    4,69%     0,00%  fio              [unknown]            [.] 0x00401f0f00000000
+    4,69%     0,00%  fio              librados.so.2.0.0    [.] 0xffff8099ead6f590
+    4,54%     0,00%  fio              [unknown]            [.] 0x0000000100000002
+    4,45%     4,45%  swapper          [kernel.kallsyms]    [k] intel_idle
+    4,37%     0,11%  fio              [kernel.kallsyms]    [k] ___sys_sendmsg
+    4,06%     0,04%  fio              [kernel.kallsyms]    [k] do_sock_sendmsg
+    3,98%     0,08%  fio              libpthread-2.21.so   [.] __libc_recv
+    3,89%     0,14%  fio              [kernel.kallsyms]    [k] inet_sendmsg
+    3,82%     3,41%  fio              libc-2.21.so         [.] malloc
+    3,78%     0,01%  fio              [kernel.kallsyms]    [k] sys_recvfrom
+    3,77%     0,01%  fio              [kernel.kallsyms]    [k] netif_receive_skb_internal
+    3,75%     0,01%  fio              [kernel.kallsyms]    [k] __netif_receive_skb
+    3,74%     0,09%  fio              [kernel.kallsyms]    [k] __netif_receive_skb_core
+    3,73%     0,08%  fio              [kernel.kallsyms]    [k] SYSC_recvfrom
+    3,70%     0,18%  fio              [kernel.kallsyms]    [k] mlx4_en_process_rx_cq
+    3,65%     0,29%  fio              [kernel.kallsyms]    [k] tcp_sendmsg
+    3,52%     0,00%  fio              [kernel.kallsyms]    [k] tcp_v4_do_rcv
+    3,49%     0,10%  fio              [kernel.kallsyms]    [k] tcp_rcv_established
+    3,48%     0,05%  fio              [kernel.kallsyms]    [k] ip_rcv
+    3,44%     0,01%  fio              [kernel.kallsyms]    [k] ip_rcv_finish
+    3,41%     0,02%  fio              [kernel.kallsyms]    [k] sock_recvmsg
+    3,31%     0,01%  fio              [kernel.kallsyms]    [k] ip_local_deliver
+    3,30%     0,00%  fio              [kernel.kallsyms]    [k] ip_local_deliver_finish
+    3,30%     0,02%  fio              [kernel.kallsyms]    [k] inet_recvmsg
+    3,28%     0,07%  fio              [kernel.kallsyms]    [k] dequeue_task
+    3,27%     0,00%  fio              [kernel.kallsyms]    [k] deactivate_task
+    3,27%     0,09%  fio              [kernel.kallsyms]    [k] tcp_v4_rcv
+    3,17%     0,16%  fio              [kernel.kallsyms]    [k] tcp_recvmsg
+    3,08%     0,29%  fio              [kernel.kallsyms]    [k] dequeue_task_fair
+    3,07%     0,09%  fio              libpthread-2.21.so   [.] __lll_unlock_wake



