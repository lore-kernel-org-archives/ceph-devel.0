From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Ignoresync hack no longer applies on 3.6.5
Date: Sun, 4 Nov 2012 19:56:23 -0800
Message-ID: <CAPud5_4S0p-O5C142P3XzT+=ARk6O6Kd4YibjbgmePdkOmYxMQ@mail.gmail.com>
References: <CAPud5_5Gv7_-6cuk+ZND3hUtoqvvjq7VhTe4tQstcYqBtwrDDQ@mail.gmail.com>
	<alpine.DEB.2.00.1211040536210.30792@cobra.newdream.net>
	<CAPud5_5mxAt4JfhRudXwJvCP0HKmsjH8kGojSR0-MzqHdx1ncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44721 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab2KED4Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 22:56:24 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7405968iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 19:56:23 -0800 (PST)
In-Reply-To: <CAPud5_5mxAt4JfhRudXwJvCP0HKmsjH8kGojSR0-MzqHdx1ncg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Unfortunately I'm still seeing deadlocks.  The trace was taken after a
'sync' from the command line was hung for a couple minutes.

There was only one debug message (one fs on the system was mounted with 'mand'):

kernel: [11441.168954]  [<ffffffff8113538a>] ? sync_fs_one_sb+0x4d/0x4d

Here's the trace:

java            S ffff88040b06ba08     0  1623      1 0x00000000
 ffff88040cb6dd08 0000000000000082 0000000000000000 ffff880405da8b30
 0000000000000000 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040cb6dfd8 0000000000012b40 0000000000012b40 ffff88040cb6dfd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff8110fe19>] ? vfs_write+0xd0/0xdf
 [<ffffffff81111059>] ? fput+0x18/0xb6
 [<ffffffff8110f5a8>] ? fput_light+0xd/0xf
 [<ffffffff8110ffd3>] ? sys_write+0x61/0x6e
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff88040ca4ba48     0  1624      1 0x00000000
 ffff88040cb0bd08 0000000000000082 ffff88040cb0bc88 ffffffff81813410
 ffff88040cb0bd28 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040cb0bfd8 0000000000012b40 0000000000012b40 ffff88040cb0bfd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81312864>] ? blkdev_issue_flush+0xc0/0xd2
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff81111059>] ? fput+0x18/0xb6
 [<ffffffff8155a841>] ? do_device_not_available+0xe/0x10
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff88040ca4b058     0  1625      1 0x00000000
 ffff880429d1fd08 0000000000000082 0000000000000400 ffffffff81813410
 ffff88040b06b4a8 0000000000012b40 0000000000012b40 0000000000012b40
 ffff880429d1ffd8 0000000000012b40 0000000000012b40 ffff880429d1ffd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff8155a841>] ? do_device_not_available+0xe/0x10
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff88040cd11a08     0  1632      1 0x00000000
 ffff88040c40fd08 0000000000000082 ffff88040c40fd68 ffff88042b17f4e0
 ffff88040c40ff38 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040c40ffd8 0000000000012b40 0000000000012b40 ffff88040c40ffd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81050e32>] ? update_rmtp+0x65/0x65
 [<ffffffff81051567>] ? hrtimer_start_range_ns+0x14/0x16
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff8110fe19>] ? vfs_write+0xd0/0xdf
 [<ffffffff8155a841>] ? do_device_not_available+0xe/0x10
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff88040cd10628     0  1633      1 0x00000000
 ffff88040cd7da88 0000000000000082 000000000cd7da18 ffffffff81813410
 ffff88040cccecc0 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040cd7dfd8 0000000000012b40 0000000000012b40 ffff88040cd7dfd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff81558067>] schedule_timeout+0x36/0xe3
 [<ffffffff810382a8>] ? _local_bh_enable_ip.clone.8+0x20/0x89
 [<ffffffff8103831f>] ? local_bh_enable_ip+0xe/0x10
 [<ffffffff81559c3b>] ? _raw_spin_unlock_bh+0x16/0x18
 [<ffffffff814679f4>] ? release_sock+0x128/0x131
 [<ffffffff81467a7f>] sk_wait_data+0x82/0xc5
 [<ffffffff8104dfd7>] ? wake_up_bit+0x2a/0x2a
 [<ffffffff8103832f>] ? local_bh_enable+0xe/0x10
 [<ffffffff814b5ffa>] tcp_recvmsg+0x4c5/0x92e
 [<ffffffff8105ef5c>] ? update_curr+0xd6/0x110
 [<ffffffff81000ef8>] ? __switch_to+0x1ac/0x33c
 [<ffffffff814d3427>] inet_recvmsg+0x5e/0x73
 [<ffffffff81463242>] __sock_recvmsg+0x75/0x84
 [<ffffffff81463343>] sock_aio_read+0xf2/0x106
 [<ffffffff8110f7e4>] do_sync_read+0x70/0xad
 [<ffffffff8110fee4>] vfs_read+0xbc/0xdc
 [<ffffffff81111059>] ? fput+0x18/0xb6
 [<ffffffff8110ff4e>] sys_read+0x4a/0x6e
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff88040ce11a88     0  1634      1 0x00000000
 ffff88040c9699f8 0000000000000082 000000000098967f ffff88042b17f4e0
 0000000000000000 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040c969fd8 0000000000012b40 0000000000012b40 ffff88040c969fd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff81558857>] schedule_hrtimeout_range_clock+0xd2/0x11b
 [<ffffffff81050e32>] ? update_rmtp+0x65/0x65
 [<ffffffff81051567>] ? hrtimer_start_range_ns+0x14/0x16
 [<ffffffff815588b3>] schedule_hrtimeout_range+0x13/0x15
 [<ffffffff8111f3b9>] poll_schedule_timeout+0x48/0x64
 [<ffffffff8111f84e>] do_poll.clone.3+0x1d0/0x1f1
 [<ffffffff8112032e>] do_sys_poll+0x146/0x1bd
 [<ffffffff8111f535>] ? __pollwait+0xcc/0xcc
 [<ffffffff81463242>] ? __sock_recvmsg+0x75/0x84
 [<ffffffff81463b9f>] ? sock_recvmsg+0x5b/0x7a
 [<ffffffff81071635>] ? get_futex_key+0x94/0x224
 [<ffffffff81559ac6>] ? _raw_spin_lock+0xe/0x10
 [<ffffffff810717f6>] ? double_lock_hb+0x31/0x36
 [<ffffffff81110e95>] ? fget_light+0x6d/0x84
 [<ffffffff81461c1b>] ? fput_light+0xd/0xf
 [<ffffffff81464afd>] ? sys_recvfrom+0x120/0x14d
 [<ffffffff8103783a>] ? timespec_add_safe+0x37/0x65
 [<ffffffff8111f8d2>] ? poll_select_set_timeout+0x63/0x81
 [<ffffffff8112044a>] sys_poll+0x53/0xbc
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
java            S ffff880429e806a8     0  1635      1 0x00000000
 ffff88040c4d7d08 0000000000000082 ffff88040c4d7d18 ffffffff81813410
 ffff88040d02cac0 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040c4d7fd8 0000000000012b40 0000000000012b40 ffff88040c4d7fd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81461c1b>] ? fput_light+0xd/0xf
 [<ffffffff8146499a>] ? sys_sendto+0x144/0x171
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88040cdac768     0  1687      1 0x00000000
 ffff88042b14dd08 0000000000000082 0000000000000200 ffff88042b17f4e0
 0000000000000200 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88042b14dfd8 0000000000012b40 0000000000012b40 ffff88042b14dfd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff8155cda6>] ? do_page_fault+0x2e5/0x324
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff81042db0>] ? sigprocmask+0x63/0x67
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88040d7c9a48     0  1688      1 0x00000000
 ffff88040cb2fd08 0000000000000082 0000000000000000 ffffffff81813410
 ffffffff8105eacb 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040cb2ffd8 0000000000012b40 0000000000012b40 ffff88040cb2ffd8
Call Trace:
 [<ffffffff8105eacb>] ? wake_affine+0x189/0x1b9
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81071e81>] ? futex_wake+0x100/0x112
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88040ceba628     0  1689      1 0x00000000
 ffff88040cf35d08 0000000000000082 0000000000000293 ffffffff81813410
 0000000000000018 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040cf35fd8 0000000000012b40 0000000000012b40 ffff88040cf35fd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81050e32>] ? update_rmtp+0x65/0x65
 [<ffffffff81051567>] ? hrtimer_start_range_ns+0x14/0x16
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff81059a9e>] ? finish_task_switch+0x8e/0xad
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88042b14a628     0  1690      1 0x00000000
 ffff880429de79f8 0000000000000082 ffff88043fc159d8 ffff88042b17eaf0
 ffff880429de7a88 0000000000012b40 0000000000012b40 0000000000012b40
 ffff880429de7fd8 0000000000012b40 0000000000012b40 ffff880429de7fd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff815587d7>] schedule_hrtimeout_range_clock+0x52/0x11b
 [<ffffffff81559ce9>] ? _raw_spin_lock_irqsave+0x12/0x2f
 [<ffffffff81559ce9>] ? _raw_spin_lock_irqsave+0x12/0x2f
 [<ffffffff815588b3>] schedule_hrtimeout_range+0x13/0x15
 [<ffffffff8111f3b9>] poll_schedule_timeout+0x48/0x64
 [<ffffffff8111f84e>] do_poll.clone.3+0x1d0/0x1f1
 [<ffffffff8112032e>] do_sys_poll+0x146/0x1bd
 [<ffffffff8111f535>] ? __pollwait+0xcc/0xcc
 [<ffffffff8111f535>] ? __pollwait+0xcc/0xcc
 [<ffffffff810c7461>] ? filemap_fault+0x1f0/0x34e
 [<ffffffff810c5b85>] ? unlock_page+0x27/0x2c
 [<ffffffff810e415a>] ? __do_fault+0x35d/0x397
 [<ffffffff810e6b3a>] ? handle_pte_fault+0xd3/0x195
 [<ffffffff810e6f05>] ? handle_mm_fault+0x1a7/0x1c1
 [<ffffffff8155cda6>] ? do_page_fault+0x2e5/0x324
 [<ffffffff81059886>] ? mmdrop+0x15/0x25
 [<ffffffff81059a9e>] ? finish_task_switch+0x8e/0xad
 [<ffffffff8112044a>] sys_poll+0x53/0xbc
 [<ffffffff8155a02f>] ? page_fault+0x1f/0x30
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88040c5bfb08     0  1691      1 0x00000000
 ffff88040b25f9f8 0000000000000082 ffff88043fc959d8 ffff88042b17eaf0
 ffff88040b25fa88 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040b25ffd8 0000000000012b40 0000000000012b40 ffff88040b25ffd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff815587d7>] schedule_hrtimeout_range_clock+0x52/0x11b
 [<ffffffff81559ce9>] ? _raw_spin_lock_irqsave+0x12/0x2f
 [<ffffffff8104e322>] ? add_wait_queue+0x44/0x4a
 [<ffffffff815588b3>] schedule_hrtimeout_range+0x13/0x15
 [<ffffffff8111f3b9>] poll_schedule_timeout+0x48/0x64
 [<ffffffff8111f84e>] do_poll.clone.3+0x1d0/0x1f1
 [<ffffffff810cb23f>] ? __rmqueue+0xb7/0x2a5
 [<ffffffff8112032e>] do_sys_poll+0x146/0x1bd
 [<ffffffff8111f535>] ? __pollwait+0xcc/0xcc
 [<ffffffff814679f4>] ? release_sock+0x128/0x131
 [<ffffffff810ccd38>] ? __alloc_pages_nodemask+0x16f/0x704
 [<ffffffff812e2d0e>] ? kzalloc+0xf/0x11
 [<ffffffff8105a969>] ? set_task_cpu+0xd1/0xe7
 [<ffffffff8105f3be>] ? cpumask_next+0x1a/0x1c
 [<ffffffff8105f796>] ? find_idlest_group+0xa2/0x121
 [<ffffffff8105a969>] ? set_task_cpu+0xd1/0xe7
 [<ffffffff81060c0d>] ? enqueue_entity+0x16d/0x214
 [<ffffffff8106027e>] ? hrtick_update+0x1b/0x4d
 [<ffffffff81060d34>] ? enqueue_task_fair+0x80/0x88
 [<ffffffff81059fd6>] ? resched_task+0x4b/0x74
 [<ffffffff81057c9e>] ? task_rq_unlock+0x17/0x19
 [<ffffffff8105cb67>] ? wake_up_new_task+0xc3/0xce
 [<ffffffff8146457f>] ? sys_accept4+0x183/0x1c8
 [<ffffffff81040698>] ? recalc_sigpending+0x44/0x48
 [<ffffffff8103099d>] ? do_fork+0x19b/0x252
 [<ffffffff81040e0a>] ? __set_task_blocked+0x66/0x6e
 [<ffffffff81042d48>] ? __set_current_blocked+0x49/0x4e
 [<ffffffff8112044a>] sys_poll+0x53/0xbc
 [<ffffffff815605d2>] ? system_call_fastpath+0x16/0x1b
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff88040ca1fb08     0  1692      1 0x00000000
 ffff88040b0b9d08 0000000000000082 ffff88043f035e00 ffff88042b17e100
 ffff88040b0b9cc8 0000000000012b40 0000000000012b40 0000000000012b40
 ffff88040b0b9fd8 0000000000012b40 0000000000012b40 ffff88040b0b9fd8
Call Trace:
 [<ffffffff81559311>] schedule+0x64/0x66
 [<ffffffff810719f2>] futex_wait_queue_me+0xc2/0xe1
 [<ffffffff81071b7e>] futex_wait+0x120/0x275
 [<ffffffff81071e81>] ? futex_wake+0x100/0x112
 [<ffffffff81073db3>] do_futex+0x96/0x122
 [<ffffffff8105800b>] ? should_resched+0x9/0x29
 [<ffffffff81073f4f>] sys_futex+0x110/0x141
 [<ffffffff8104b1a3>] ? task_work_run+0x2b/0x78
 [<ffffffff81001f79>] ? do_notify_resume+0x85/0x98
 [<ffffffff815605d2>] system_call_fastpath+0x16/0x1b
ceph-mon        S ffff880429cd7a08     0  1693      1 0x00000000
 ffff88040cead918 0000000000000082 ffff88040cead8a8 ffff88042b17eaf0
 ffff88040cc39c70 0000000000012b40 0000000000012b40 0000000000012b40


On Sun, Nov 4, 2012 at 1:23 PM, Nick Bartos <nick@pistoncloud.com> wrote:
> Awesome, thanks!  I'll let you know how it goes.
>
> On Sun, Nov 4, 2012 at 5:50 AM, Sage Weil <sage@inktank.com> wrote:
>> On Fri, 2 Nov 2012, Nick Bartos wrote:
>>> Sage,
>>>
>>> A while back you gave us a small kernel hack which allowed us to mount
>>> the underlying OSD xfs filesystems in a way that they would ignore
>>> system wide syncs (kernel hack + mounting with the reused "mand"
>>> option), to workaround a deadlock problem when mounting an rbd on the
>>> same node that holds osds and monitors.  Somewhere between 3.5.6 and
>>> 3.6.5, things changed enough that the patch no longer applies.
>>>
>>> Looking into it a bit more, sync_one_sb and sync_supers no longer
>>> exist.  In commit f0cd2dbb6cf387c11f87265462e370bb5469299e which
>>> removes sync_supers:
>>>
>>>     vfs: kill write_super and sync_supers
>>>
>>>     Finally we can kill the 'sync_supers' kernel thread along with the
>>>     '->write_super()' superblock operation because all the users are gone.
>>>     Now every file-system is supposed to self-manage own superblock and
>>>     its dirty state.
>>>
>>>     The nice thing about killing this thread is that it improves power
>>> management.
>>>     Indeed, 'sync_supers' is a source of monotonic system wake-ups - it woke up
>>>     every 5 seconds no matter what - even if there were no dirty superblocks and
>>>     even if there were no file-systems using this service (e.g., btrfs and
>>>     journalled ext4 do not need it). So it was wasting power most of
>>> the time. And
>>>     because the thread was in the core of the kernel, all systems had
>>> to have it.
>>>     So I am quite happy to make it go away.
>>>
>>>     Interestingly, this thread is a left-over from the pdflush kernel
>>> thread which
>>>     was a self-forking kernel thread responsible for all the write-back in old
>>>     Linux kernels. It was turned into per-block device BDI threads, and
>>>     'sync_supers' was a left-over. Thus, R.I.P, pdflush as well.
>>>
>>> Also commit b3de653105180b57af90ef2f5b8441f085f4ff56 renames
>>> sync_inodes_one_sb to sync_inodes_one_sb along with some other
>>> changes.
>>>
>>> Assuming that the deadlock problem is still present in 3.6.5, could we
>>> trouble you for an updated patch?  Here's the original patch you gave
>>> us for reference:
>>
>> Below.  Compile-tested only!
>>
>> However, looking over the code, I'm not sure that the deadlock potential
>> still exists.  Looking over the stack traces you sent way back when, I'm
>> not sure exactly which lock it was blocked on.  If this was easily
>> reproducible before, you might try running without the patch to see if
>> this is still a problem for your configuration.  And if it does happen,
>> capture a fresh dump (echo t > /proc/sysrq-trigger).
>>
>> Thanks!
>> sage
>>
>>
>>
>> From 6cbfe169ece1943fee1159dd78c202e613098715 Mon Sep 17 00:00:00 2001
>> From: Sage Weil <sage@inktank.com>
>> Date: Sun, 4 Nov 2012 05:34:40 -0800
>> Subject: [PATCH] vfs hack: make sync skip supers with MS_MANDLOCK
>>
>> This is an ugly hack to skip certain mounts when there is a sync(2) system
>> call.
>>
>> A less ugly version would create a new mount flag for this, but it would
>> require modifying mount(8) too, and that's too much work.
>>
>> A curious person would ask WTF this is for.  It is a kludge to avoid a
>> deadlock induced when an RBD or Ceph mount is backed by a local ceph-osd
>> on a local fs.  An ill-timed sync(2) call by whoever can leave a
>> ceph-dependent mount waiting on writeback, while something would prevent
>> the ceph-osd from doing its own sync(2) on its backing fs.
>>
>> ---
>>  fs/sync.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/sync.c b/fs/sync.c
>> index eb8722d..ab474a0 100644
>> --- a/fs/sync.c
>> +++ b/fs/sync.c
>> @@ -75,8 +75,12 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
>>
>>  static void sync_fs_one_sb(struct super_block *sb, void *arg)
>>  {
>> -       if (!(sb->s_flags & MS_RDONLY) && sb->s_op->sync_fs)
>> -               sb->s_op->sync_fs(sb, *(int *)arg);
>> +       if (!(sb->s_flags & MS_RDONLY) && sb->s_op->sync_fs) {
>> +               if (sb->s_flags & MS_MANDLOCK)
>> +                       pr_debug("sync_fs_one_sb skipping %p\n", sb);
>> +               else
>> +                       sb->s_op->sync_fs(sb, *(int *)arg);
>> +       }
>>  }
>>
>>  static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
>> --
>> 1.7.9.5
>>
