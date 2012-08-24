From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: mon crash on debian wheezy
Date: Fri, 24 Aug 2012 16:12:31 +0800
Message-ID: <5037376F.4080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57149 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2HXIMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 04:12:25 -0400
Received: by pbbrr13 with SMTP id rr13so3012034pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 01:12:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I've been running the 0.48argonaut on production for over a month
without any issue. and today, I suddenly lost one mon. Taking a look
into the syslog file, I see the following trace log. I just couldn't
see what's wrong from the trace log. However, this event created
a gigantic core file. Here's the size of the core file:

-rw------- 1 root root 16085647360 Aug 24 14:53 core

This happened while we were migrating data from our old storage
to the ceph. We are running about 20 processes, migrating data
into ceph, while there are about 30 more application processes
reading from and writing new data to it.

The following is from syslog:

Aug 24 14:50:15 s100001 kernel: [3076872.019074] INFO: task 
ceph-mon:1686 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019092] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019109] ceph-mon        D 
ffff88082f253740     0  1686      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019113]  ffff88080b977710 
0000000000000086 ffff880800000001 ffff88080c328ee0
Aug 24 14:50:38 s100001 kernel: [3076872.019118]  0000000000013740 
ffff88080d4dbfd8 ffff88080d4dbfd8 ffff88080b977710
Aug 24 14:50:38 s100001 kernel: [3076872.019122]  0000000000000246 
0000000100000246 ffff88080bfa7400 ffff88080b977710
Aug 24 14:50:38 s100001 kernel: [3076872.019126] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019133]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019136]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019139]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019144]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019149]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019152]  [<ffffffff810151c5>] ? 
init_fpu+0x84/0x91
Aug 24 14:50:38 s100001 kernel: [3076872.019155]  [<ffffffff81015d2e>] ? 
restore_i387_xstate+0x113/0x15d
Aug 24 14:50:38 s100001 kernel: [3076872.019158]  [<ffffffff8105676b>] ? 
do_sigaltstack+0xaa/0x13e
Aug 24 14:50:38 s100001 kernel: [3076872.019162]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:38 s100001 kernel: [3076872.019166]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:38 s100001 kernel: [3076872.019170]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:38 s100001 kernel: [3076872.019173] INFO: task 
ceph-mon:1687 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019188] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019205] ceph-mon        D 
ffff88080cb8a400     0  1687      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019208]  ffff88080cb8a400 
0000000000000086 ffff88080cba0860 ffff88080b92b6d0
Aug 24 14:50:38 s100001 kernel: [3076872.019212]  0000000000013740 
ffff88080d869fd8 ffff88080d869fd8 ffff88080cb8a400
Aug 24 14:50:38 s100001 kernel: [3076872.019216]  0000000000000246 
0000000000000246 ffff88080bfa7400 ffff88080cb8a400
Aug 24 14:50:38 s100001 kernel: [3076872.019220] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019223]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019226]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019229]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019232]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019235]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019238]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:38 s100001 kernel: [3076872.019241]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:38 s100001 kernel: [3076872.019246]  [<ffffffff810f96a2>] ? 
sys_write+0x5f/0x6b
Aug 24 14:50:38 s100001 kernel: [3076872.019248]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:38 s100001 kernel: [3076872.019251] INFO: task 
ceph-mon:1727 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019266] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019283] ceph-mon        D 
ffff88080dff7710     0  1727      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019286]  ffff88080dff7710 
0000000000000086 ffff88080cba0860 ffff88080c39e340
Aug 24 14:50:38 s100001 kernel: [3076872.019290]  0000000000013740 
ffff88080e241fd8 ffff88080e241fd8 ffff88080dff7710
Aug 24 14:50:38 s100001 kernel: [3076872.019294]  0000000000000246 
0000000000000246 ffff88080bfa7400 ffff88080dff7710
Aug 24 14:50:38 s100001 kernel: [3076872.019297] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019300]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019303]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019307]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019310]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019313]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019316]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:38 s100001 kernel: [3076872.019319]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:38 s100001 kernel: [3076872.019322]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:38 s100001 kernel: [3076872.019324] INFO: task 
ceph-mon:1737 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019339] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019356] ceph-mon        D 
ffff88082f213740     0  1737      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019359]  ffff88080b976930 
0000000000000086 ffff880000000000 ffffffff8160d020
Aug 24 14:50:38 s100001 kernel: [3076872.019363]  0000000000013740 
ffff88080dde1fd8 ffff88080dde1fd8 ffff88080b976930
Aug 24 14:50:38 s100001 kernel: [3076872.019367]  0000000000000202 
000000010519fcf0 ffff88080cba0860 ffff88080b976930
Aug 24 14:50:38 s100001 kernel: [3076872.019370] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019373]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019376]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019379]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019382]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019385]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019389]  [<ffffffff81036457>] ? 
should_resched+0x5/0x23
Aug 24 14:50:38 s100001 kernel: [3076872.019392]  [<ffffffff81049ff4>] ? 
do_exit+0x6fa/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019395]  [<ffffffff8100d755>] ? 
__switch_to+0x1e5/0x258
Aug 24 14:50:38 s100001 kernel: [3076872.019398]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:38 s100001 kernel: [3076872.019400]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:38 s100001 kernel: [3076872.019403] INFO: task 
ceph-mon:1738 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019418] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019435] ceph-mon        D 
ffff88080e39cab0     0  1738      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019438]  ffff88080e39cab0 
0000000000000086 ffff88080cba0860 ffff8807fb06a0c0
Aug 24 14:50:38 s100001 kernel: [3076872.019442]  0000000000013740 
ffff88080c929fd8 ffff88080c929fd8 ffff88080e39cab0
Aug 24 14:50:38 s100001 kernel: [3076872.019446]  0000000000000293 
0000000000000293 ffff88080bfa7400 ffff88080e39cab0
Aug 24 14:50:38 s100001 kernel: [3076872.019449] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019452]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019455]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019459]  [<ffffffff81035a19>] ? 
set_task_rq+0x23/0x35
Aug 24 14:50:38 s100001 kernel: [3076872.019463]  [<ffffffff8103eb0d>] ? 
set_task_cpu+0xc1/0xd4
Aug 24 14:50:38 s100001 kernel: [3076872.019466]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019469]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019473]  [<ffffffff811a90ec>] ? 
cpumask_next_and+0x28/0x34
Aug 24 14:50:38 s100001 kernel: [3076872.019476]  [<ffffffff81035a19>] ? 
set_task_rq+0x23/0x35
Aug 24 14:50:38 s100001 kernel: [3076872.019479]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019482]  [<ffffffff8103ac16>] ? 
enqueue_task_fair+0x7f/0x185
Aug 24 14:50:38 s100001 kernel: [3076872.019485]  [<ffffffff8103703b>] ? 
test_tsk_need_resched+0xa/0x13
Aug 24 14:50:38 s100001 kernel: [3076872.019488]  [<ffffffff8103a303>] ? 
resched_task+0x39/0x65
Aug 24 14:50:38 s100001 kernel: [3076872.019490]  [<ffffffff8103ad52>] ? 
check_preempt_curr+0x36/0x5f
Aug 24 14:50:38 s100001 kernel: [3076872.019493]  [<ffffffff8103f836>] ? 
wake_up_new_task+0xb9/0xc2
Aug 24 14:50:38 s100001 kernel: [3076872.019496]  [<ffffffff8104605f>] ? 
do_fork+0x196/0x219
Aug 24 14:50:38 s100001 kernel: [3076872.019499]  [<ffffffff81053bd8>] ? 
recalc_sigpending+0x23/0x3c
Aug 24 14:50:38 s100001 kernel: [3076872.019502]  [<ffffffff81054271>] ? 
__set_task_blocked+0x5e/0x65
Aug 24 14:50:38 s100001 kernel: [3076872.019505]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:38 s100001 kernel: [3076872.019508]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:38 s100001 kernel: [3076872.019511]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:38 s100001 kernel: [3076872.019513] INFO: task 
ceph-mon:1739 blocked for more than 120 seconds.
Aug 24 14:50:38 s100001 kernel: [3076872.019528] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:38 s100001 kernel: [3076872.019545] ceph-mon        D 
ffff88080be943c0     0  1739      1 0x00000000
Aug 24 14:50:38 s100001 kernel: [3076872.019549]  ffff88080be943c0 
0000000000000086 ffff880800000001 ffff88080b6027b0
Aug 24 14:50:38 s100001 kernel: [3076872.019552]  0000000000013740 
ffff88080db47fd8 ffff88080db47fd8 ffff88080be943c0
Aug 24 14:50:38 s100001 kernel: [3076872.019556]  0000000000000246 
0000000100000246 ffff88080bfa7400 ffff88080be943c0
Aug 24 14:50:38 s100001 kernel: [3076872.019560] Call Trace:
Aug 24 14:50:38 s100001 kernel: [3076872.019563]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:38 s100001 kernel: [3076872.019566]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:38 s100001 kernel: [3076872.019569]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:38 s100001 kernel: [3076872.019572]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:38 s100001 kernel: [3076872.019575]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:38 s100001 kernel: [3076872.019579]  [<ffffffff810ea0cb>] ? 
kmem_cache_free+0x2d/0x69
Aug 24 14:50:38 s100001 kernel: [3076872.019582]  [<ffffffff811091f8>] ? 
dentry_kill+0x120/0x12b
Aug 24 14:50:38 s100001 kernel: [3076872.019585]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:39 s100001 kernel: [3076872.019588]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:47 s100001 kernel: [3076872.019591]  [<ffffffff810f7fde>] ? 
filp_close+0x62/0x6a
Aug 24 14:50:47 s100001 kernel: [3076872.019594]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:47 s100001 kernel: [3076872.019597] INFO: task 
ceph-mon:1740 blocked for more than 120 seconds.
Aug 24 14:50:47 s100001 kernel: [3076872.019612] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:47 s100001 kernel: [3076872.019643] ceph-mon        D 
ffff88080bc29710     0  1740      1 0x00000000
Aug 24 14:50:47 s100001 kernel: [3076872.019646]  ffff88080bc29710 
0000000000000086 ffff88080cba0860 ffff880145a9d510
Aug 24 14:50:47 s100001 kernel: [3076872.019650]  0000000000013740 
ffff88080c921fd8 ffff88080c921fd8 ffff88080bc29710
Aug 24 14:50:47 s100001 kernel: [3076872.019654]  0000000000000293 
0000000000000293 ffff88080bfa7400 ffff88080bc29710
Aug 24 14:50:47 s100001 kernel: [3076872.019657] Call Trace:
Aug 24 14:50:47 s100001 kernel: [3076872.019660]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:47 s100001 kernel: [3076872.019663]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:47 s100001 kernel: [3076872.019669]  [<ffffffff81024afa>] ? 
default_send_IPI_mask_sequence_phys+0x4b/0x6a
Aug 24 14:50:47 s100001 kernel: [3076872.019673]  [<ffffffff813498bf>] ? 
_cond_resched+0x7/0x1c
Aug 24 14:50:47 s100001 kernel: [3076872.019677]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:47 s100001 kernel: [3076872.019679]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:47 s100001 kernel: [3076872.019683]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:47 s100001 kernel: [3076872.019686]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:47 s100001 kernel: [3076872.019688]  [<ffffffff810f9637>] ? 
sys_read+0x5f/0x6b
Aug 24 14:50:47 s100001 kernel: [3076872.019691]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:47 s100001 kernel: [3076872.019694] INFO: task 
ceph-mon:1818 blocked for more than 120 seconds.
Aug 24 14:50:47 s100001 kernel: [3076872.019722] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:47 s100001 kernel: [3076872.019767] ceph-mon        D 
ffff88082f2b3740     0  1818      1 0x00000000
Aug 24 14:50:47 s100001 kernel: [3076872.019770]  ffff88080b92b6d0 
0000000000000086 ffff880800000000 ffff88082bb9e200
Aug 24 14:50:47 s100001 kernel: [3076872.019774]  0000000000013740 
ffff88080da6ffd8 ffff88080da6ffd8 ffff88080b92b6d0
Aug 24 14:50:47 s100001 kernel: [3076872.019777]  ffff88080b92b6d0 
000000010b92b6d0 0000000000000293 ffff88080b92b6d0
Aug 24 14:50:47 s100001 kernel: [3076872.019781] Call Trace:
Aug 24 14:50:47 s100001 kernel: [3076872.019784]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:47 s100001 kernel: [3076872.019787]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:47 s100001 kernel: [3076872.019792]  [<ffffffff810b5155>] ? 
generic_file_aio_write+0xa7/0xb5
Aug 24 14:50:47 s100001 kernel: [3076872.019795]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:47 s100001 kernel: [3076872.019798]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:47 s100001 kernel: [3076872.019801]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:47 s100001 kernel: [3076872.019805]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:47 s100001 kernel: [3076872.019807]  [<ffffffff810f96a2>] ? 
sys_write+0x5f/0x6b
Aug 24 14:50:47 s100001 kernel: [3076872.019810]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:47 s100001 kernel: [3076872.019812] INFO: task 
ceph-mon:1819 blocked for more than 120 seconds.
Aug 24 14:50:47 s100001 kernel: [3076872.019841] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:47 s100001 kernel: [3076872.019885] ceph-mon        D 
ffff88080bf7e400     0  1819      1 0x00000000
Aug 24 14:50:47 s100001 kernel: [3076872.019888]  ffff88080bf7e400 
0000000000000086 0000000000000000 ffff8807fa200180
Aug 24 14:50:47 s100001 kernel: [3076872.019892]  0000000000013740 
ffff88080db2bfd8 ffff88080db2bfd8 ffff88080bf7e400
Aug 24 14:50:47 s100001 kernel: [3076872.019896]  ffff88080bf7e400 
ffff88080cba0800 ffff88080bf7e400 ffff88080bf7e400
Aug 24 14:50:47 s100001 kernel: [3076872.019900] Call Trace:
Aug 24 14:50:47 s100001 kernel: [3076872.019903]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:47 s100001 kernel: [3076872.019906]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:47 s100001 kernel: [3076872.019909]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:47 s100001 kernel: [3076872.019912]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:47 s100001 kernel: [3076872.019915]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:47 s100001 kernel: [3076872.019919]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:47 s100001 kernel: [3076872.019922]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:47 s100001 kernel: [3076872.019925]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 14:50:47 s100001 kernel: [3076872.019927] INFO: task 
ceph-mon:1820 blocked for more than 120 seconds.
Aug 24 14:50:47 s100001 kernel: [3076872.019956] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 24 14:50:47 s100001 kernel: [3076872.020000] ceph-mon        D 
ffff88080bcd49b0     0  1820      1 0x00000000
Aug 24 14:50:47 s100001 kernel: [3076872.020003]  ffff88080bcd49b0 
0000000000000086 0000000000000246 ffff88080b977710
Aug 24 14:50:47 s100001 kernel: [3076872.020007]  0000000000013740 
ffff88080ae6dfd8 ffff88080ae6dfd8 ffff88080bcd49b0
Aug 24 14:50:47 s100001 kernel: [3076872.020010]  ffff88080bcd49b0 
ffff88080cba0800 ffff88080bcd49b0 ffff88080bcd49b0
Aug 24 14:50:47 s100001 kernel: [3076872.020014] Call Trace:
Aug 24 14:50:47 s100001 kernel: [3076872.020017]  [<ffffffff8104986f>] ? 
exit_mm+0x97/0x122
Aug 24 14:50:47 s100001 kernel: [3076872.020020]  [<ffffffff81049b40>] ? 
do_exit+0x246/0x6fc
Aug 24 14:50:47 s100001 kernel: [3076872.020023]  [<ffffffff8104a276>] ? 
do_group_exit+0x74/0x9e
Aug 24 14:50:47 s100001 kernel: [3076872.020026]  [<ffffffff81055bb8>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 24 14:50:47 s100001 kernel: [3076872.020030]  [<ffffffff8100de33>] ? 
do_signal+0x38/0x610
Aug 24 14:50:47 s100001 kernel: [3076872.020033]  [<ffffffff8106f2f9>] ? 
sys_futex+0x138/0x147
Aug 24 14:50:47 s100001 kernel: [3076872.020036]  [<ffffffff8100e441>] ? 
do_notify_resume+0x25/0x68
Aug 24 14:50:47 s100001 kernel: [3076872.020039]  [<ffffffff8134fe60>] ? 
int_signal+0x12/0x17
Aug 24 15:17:01 s100001 /USR/SBIN/CRON[19946]: (root) CMD (   cd / && 
run-parts --report /etc/cron.hourly)

By looking at this log, could we tell what was going on? I restarted mon
and everything is back to normal.

Please let me if I can provide other information.

Thanks

Xiaopong
