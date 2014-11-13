From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: client cpu usage : kbrd vs librbd perf report
Date: Thu, 13 Nov 2014 12:15:17 +0100 (CET)
Message-ID: <c600b836-9e9e-4a24-9331-dbf6fc8664af@mailpro>
References: <f0773eb4-248a-4933-9b95-38885992b938@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46586 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364AbaKMLP3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 06:15:29 -0500
In-Reply-To: <f0773eb4-248a-4933-9b95-38885992b938@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>
Cc: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sweil@redhat.com>, Somnath Roy <somnath.roy@sandisk.com>

Hi,

I have redone perf with dwarf

perf record -g --call-graph dwarf -a -F 99  -- sleep 60

I have put perf reports, ceph conf, fio config here:

http://odisoweb1.odiso.net/cephperf/

test setup
-----------
client cpu config :  8 x Intel(R) Xeon(R) CPU E5-2603 v2 @ 1.80GHz
ceph cluster : 3 nodes (same cpu than client) with 2 osd each (intel ssd s3500), test pool with replication x1
rbd volume size : 10G (almost all reads are done in osd buffer cache)

benchmark with fio 4k randread, with 1 rbd volume. (also tested with 20 rbd volumes, results are equals).
debian wheezy - kernel 3.17 - and ceph packages from master on gitbuilder

(BTW, I have installed librbd/rados dbg packages but I have missing symbols ?)



Global results:
---------------
librbd : 60000iops : 98% cpu 
krbd : 90000iops : 32% cpu  
    

So, librbd usage is 4,5x more than krbd for same ios throughput

The difference seem to be quite huge, is it expected ?




librbd perf report:
-------------------------
top cpu usage
--------------
25.71%              fio  libc-2.13.so 
17.69%              fio  librados.so.2.0.0  
12.38%              fio  librbd.so.1.0.0
27.99%              fio  [kernel.kallsyms] 
4.19%               fio  libpthread-2.13.so


libc-2.13.so (seem that malloc/free use a lot of cpu here)
------------
    21.05%-- _int_malloc
    14.36%-- free
    13.66%-- malloc
    9.89%-- __lll_unlock_wake_private
    5.35%-- __clone
    4.38%-- __poll
    3.77%-- __memcpy_ssse3
    1.64%-- vfprintf
    1.02%-- arena_get2

fio  [kernel.kallsyms]  : seem to have a lot of futex functions here
-----------------------
     5.27%-- _raw_spin_lock
     3.88%-- futex_wake
     2.88%-- __switch_to
     2.74%-- system_call
     2.70%-- __schedule
     2.52%-- tcp_sendmsg
     2.47%-- futex_wait_setup
     2.28%-- _raw_spin_lock_irqsave
     2.16%-- idle_cpu
     1.66%-- enqueue_task_fair
     1.57%-- native_write_msr_safe
     1.49%-- hash_futex
     1.46%-- futex_wait
     1.40%-- reschedule_interrupt
     1.37%-- try_to_wake_up
     1.28%-- account_entity_enqueue
     1.25%-- copy_user_enhanced_fast_string
     1.25%-- futex_requeue
     1.24%-- __fget
     1.24%-- update_curr
     1.20%-- tcp_write_xmit
     1.14%-- wake_futex
     1.08%-- scheduler_ipi
     1.05%-- select_task_rq_fair
     1.01%-- dequeue_task_fair
     0.97%-- do_futex
     0.97%-- futex_wait_queue_me
     0.83%-- cpuacct_charge
     0.82%-- tcp_transmit_skb
     ...


Regards,

Alexandre




