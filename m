From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Can't restart ceph-mon
Date: Tue, 25 Jun 2013 09:56:56 +0800
Message-ID: <CAJiejCT4ALLi5nTqjtyL+bzhy=qkQUk34J=y8iJB=jqTh_fXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:33767 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3FYB5R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 21:57:17 -0400
Received: by mail-qa0-f48.google.com with SMTP id cm16so250696qab.7
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 18:57:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

I can't restart mon.b using ceph_init.sh, some checks told me that its
hogging 100% CPU of one core, and appended my diag information
collection. Is it a dead lock?

c16 ~ # ps auwx | grep ceph-mon
root     20238 77.4 11.6 1622236 1437512 ?     Ssl  09:34   4:22
/usr/bin/ceph-mon -i b --pid-file /var/run/ceph/mon.b.pid -c
/etc/ceph/ceph.conf

c16 ~ # strace -p 20238 -r -f
Process 20238 attached with 12 threads
[pid 20377]      0.000000 futex(0x3c0a47c, FUTEX_WAIT_PRIVATE, 5, NULL
<unfinished ...>
[pid 20280]      0.000027 restart_syscall(<... resuming interrupted
call ...> <unfinished ...>
[pid 20246]      0.000015 restart_syscall(<... resuming interrupted
call ...> <unfinished ...>
[pid 20302]      0.000142 futex(0x3d73d7c, FUTEX_WAIT_PRIVATE, 17,
NULL <unfinished ...>
[pid 20245]      0.000012 futex(0x1df8c5c, FUTEX_WAIT_PRIVATE, 9, NULL
<unfinished ...>
[pid 20244]      0.000016 restart_syscall(<... resuming interrupted
call ...> <unfinished ...>
[pid 20243]      0.000098 futex(0x1df8f94, FUTEX_WAIT_PRIVATE, 127,
NULL <unfinished ...>
[pid 20241]      0.000009 restart_syscall(<... resuming interrupted
call ...> <unfinished ...>
[pid 20240]      0.000008 restart_syscall(<... resuming interrupted
call ...> <unfinished ...>
[pid 20242]      0.000010 select(19, [12 14 16 18], NULL, NULL, NULL
<unfinished ...>
[pid 20239]      0.000114 futex(0x1ba40ac, FUTEX_WAIT_PRIVATE, 223,
NULL <unfinished ...>
[pid 20238]      0.000018 futex(0x7fefbd6829d0, FUTEX_WAIT, 20245,
NULL <unfinished ...>
[pid 20244]      1.709230 <... restart_syscall resumed> ) = -1
ETIMEDOUT (Connection timed out)
[pid 20244]      0.447862 madvise(0x3f34000, 163840, MADV_DONTNEED) = 0
[pid 20244]      0.198014 madvise(0x2ba4000, 172032, MADV_DONTNEED) = 0
[pid 20244]      0.186014 madvise(0x564e000, 180224, MADV_DONTNEED) = 0
[pid 20244]      0.202567 madvise(0x40a8000, 196608, MADV_DONTNEED) = 0
[pid 20244]      0.243113 madvise(0x2574000, 212992, MADV_DONTNEED) = 0
[pid 20244]      0.233094 madvise(0x3776000, 221184, MADV_DONTNEED) = 0
[pid 20244]      0.245342 madvise(0x6804000, 229376, MADV_DONTNEED) = 0
[pid 20240]      0.081809 <... restart_syscall resumed> ) = -1
ETIMEDOUT (Connection timed out)
[pid 20240]      0.000132 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124225,
816551698}, ffffffff <unfinished ...>
[pid 20244]      0.181831 madvise(0x6546000, 352256, MADV_DONTNEED) = 0
[pid 20244]      0.409170 madvise(0x676c000, 409600, MADV_DONTNEED) = 0
[pid 20244]      0.465507 madvise(0x80d8000, 442368, MADV_DONTNEED) = 0
[pid 20244]      0.495426 madvise(0x6676000, 548864, MADV_DONTNEED) = 0
[pid 20244]      0.594338 madvise(0x575e000, 589824, MADV_DONTNEED) = 0
[pid 20244]      0.650322 madvise(0x5804000, 696320, MADV_DONTNEED) = 0
[pid 20244]      0.747310 madvise(0x72e6000, 13656064, MADV_DONTNEED) = 0
[pid 20244]      1.030449 futex(0x1cc0938, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 20244]      0.000306 futex(0x1cc099c,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 27, {1372124230,
390816000}, ffffffff <unfinished ...>
[pid 20240]      0.425570 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000100 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124230,
816875975}, ffffffff <unfinished ...>
[pid 20244]      4.574187 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.426002 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000123 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124235,
817202428}, ffffffff) = -1 ETIMEDOUT (Connection timed out)
[pid 20240]      5.000301 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124240,
817496849}, ffffffff <unfinished ...>
[pid 20244]      0.984974 futex(0x1cc0938, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 20244]      0.000194 futex(0x1cc099c,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 29, {1372124241,
802351000}, ffffffff <unfinished ...>
[pid 20240]      4.015092 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000333 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124245,
817938844}, ffffffff <unfinished ...>
[pid 20244]      0.984507 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20244]      2.654141 madvise(0x1e6e000, 8192, MADV_DONTNEED) = 0
[pid 20244]      0.009606 madvise(0x1c66000, 16384, MADV_DONTNEED) = 0
[pid 20244]      0.022253 madvise(0x228c000, 24576, MADV_DONTNEED) = 0
[pid 20244]      0.027772 madvise(0x3b18000, 32768, MADV_DONTNEED) = 0
[pid 20244]      0.043074 madvise(0x3a4c000, 40960, MADV_DONTNEED) = 0
[pid 20244]      0.047580 madvise(0x1c9c000, 49152, MADV_DONTNEED) = 0
[pid 20244]      0.052925 madvise(0x55a8000, 57344, MADV_DONTNEED) = 0
[pid 20244]      0.066448 madvise(0x3080000, 65536, MADV_DONTNEED) = 0
[pid 20244]      0.073119 madvise(0x3b8e000, 73728, MADV_DONTNEED) = 0
[pid 20244]      0.081828 madvise(0x5618000, 81920, MADV_DONTNEED) = 0
[pid 20244]      0.091165 madvise(0x4020000, 90112, MADV_DONTNEED) = 0
[pid 20244]      0.102409 madvise(0x4dae000, 98304, MADV_DONTNEED) = 0
[pid 20244]      0.106891 madvise(0x5510000, 106496, MADV_DONTNEED) = 0
[pid 20244]      0.116947 madvise(0x4a5e000, 114688, MADV_DONTNEED) = 0
[pid 20244]      0.125115 madvise(0x429a000, 122880, MADV_DONTNEED) = 0
[pid 20244]      0.138552 madvise(0x21b4000, 131072, MADV_DONTNEED) = 0
[pid 20244]      0.146413 madvise(0x28f4000, 147456, MADV_DONTNEED) = 0
[pid 20240]      0.109310 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000129 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124250,
818273356}, ffffffff <unfinished ...>
[pid 20244]      0.051025 madvise(0x331c000, 155648, MADV_DONTNEED) = 0
[pid 20244]      0.174178 madvise(0x3780000, 163840, MADV_DONTNEED) = 0
[pid 20244]      0.183571 madvise(0x547c000, 172032, MADV_DONTNEED) = 0
[pid 20244]      0.196637 madvise(0x53ec000, 212992, MADV_DONTNEED) = 0
[pid 20244]      0.228817 madvise(0x40e6000, 327680, MADV_DONTNEED) = 0
[pid 20244]      0.358390 madvise(0x6aec000, 335872, MADV_DONTNEED) = 0
[pid 20244]      0.371136 madvise(0x80d4000, 344064, MADV_DONTNEED) = 0
[pid 20244]      0.365002 madvise(0x6096000, 376832, MADV_DONTNEED) = 0
[pid 20244]      0.384221 madvise(0x8004000, 425984, MADV_DONTNEED) = 0
[pid 20244]      0.063275 futex(0x1cc0938, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 20244]      0.000218 futex(0x1cc099c,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 31, {1372124253,
194440000}, ffffffff <unfinished ...>
[pid 20240]      2.623772 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000292 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124255,
818701203}, ffffffff <unfinished ...>
[pid 20244]      2.375885 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20244]      0.742372 madvise(0x5ea6000, 466944, MADV_DONTNEED) = 0
[pid 20244]      0.542501 madvise(0x6520000, 524288, MADV_DONTNEED) = 0
[pid 20244]      0.576850 madvise(0x7354000, 13189120, MADV_DONTNEED) = 0
[pid 20240]      0.762466 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000132 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124260,
819011242}, ffffffff <unfinished ...>
[pid 20244]      3.896674 futex(0x1cc0938, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 20244]      0.000239 futex(0x1cc099c,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 33, {1372124256,
71213000}, ffffffff) = -1 ETIMEDOUT (Connection timed out)
[pid 20240]      1.103252 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000134 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124265,
819308696}, ffffffff <unfinished ...>
[pid 20244]      4.474449 madvise(0x2c86000, 8192, MADV_DONTNEED) = 0
[pid 20244]      0.008398 madvise(0x29d8000, 16384, MADV_DONTNEED) = 0
[pid 20244]      0.021200 madvise(0x35fa000, 24576, MADV_DONTNEED) = 0
[pid 20244]      0.026965 madvise(0x453a000, 32768, MADV_DONTNEED) = 0
[pid 20244]      0.035661 madvise(0x42b8000, 49152, MADV_DONTNEED) = 0
[pid 20244]      0.056100 madvise(0x3754000, 57344, MADV_DONTNEED) = 0
[pid 20244]      0.061088 madvise(0x6834000, 65536, MADV_DONTNEED) = 0
[pid 20244]      0.075088 madvise(0x46d6000, 73728, MADV_DONTNEED) = 0
[pid 20244]      0.082119 madvise(0x459a000, 81920, MADV_DONTNEED) = 0
[pid 20244]      0.092929 madvise(0x814c000, 90112, MADV_DONTNEED) = 0
[pid 20240]      0.066198 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000120 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124270,
819613699}, ffffffff <unfinished ...>
[pid 20244]      0.029884 madvise(0x2542000, 98304, MADV_DONTNEED) = 0
[pid 20244]      0.104581 madvise(0x68ce000, 106496, MADV_DONTNEED) = 0
[pid 20244]      0.113516 madvise(0x38d0000, 114688, MADV_DONTNEED) = 0
[pid 20244]      0.116526 madvise(0x4b0a000, 122880, MADV_DONTNEED) = 0
[pid 20244]      0.123023 madvise(0x4ae4000, 131072, MADV_DONTNEED) = 0
[pid 20244]      0.146099 madvise(0x3942000, 139264, MADV_DONTNEED) = 0
[pid 20244]      0.462245 madvise(0x808e000, 147456, MADV_DONTNEED) = 0
[pid 20244]      0.176277 madvise(0x2836000, 172032, MADV_DONTNEED) = 0
[pid 20244]      0.192589 madvise(0x59b2000, 180224, MADV_DONTNEED) = 0
[pid 20244]      0.203474 madvise(0x28a4000, 188416, MADV_DONTNEED) = 0
[pid 20244]      0.224418 madvise(0x5fcc000, 196608, MADV_DONTNEED) = 0
[pid 20244]      0.218532 madvise(0x6c12000, 237568, MADV_DONTNEED) = 0
[pid 20244]      0.258277 madvise(0x71fc000, 270336, MADV_DONTNEED) = 0
[pid 20244]      0.313276 madvise(0x6d9e000, 425984, MADV_DONTNEED) = 0
[pid 20244]      0.490869 madvise(0x57ec000, 614400, MADV_DONTNEED) = 0
[pid 20244]      0.702252 madvise(0x6e38000, 622592, MADV_DONTNEED) = 0
[pid 20244]      0.689318 madvise(0x746e000, 12042240, MADV_DONTNEED) = 0
[pid 20240]      0.435028 <... futex resumed> ) = -1 ETIMEDOUT
(Connection timed out)
[pid 20240]      0.000205 futex(0x1bc3858,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {1372124275,
819959201}, ffffffff^CProcess 20238 detached
Process 20239 detached
Process 20240 detached
 <detached ...>
Process 20241 detached
Process 20242 detached
Process 20243 detached
Process 20244 detached
Process 20245 detached
Process 20246 detached
Process 20280 detached
Process 20302 detached
Process 20377 detached


In log file /var/log/ceph/mon.b.log:
<snipped>
2013-06-25 08:35:09.774447 7fcfdaafd700  0 -- 10.205.119.16:6789/0 >>
10.205.119.15:6789/0 pipe(0x2c0bbb80 sd=22 :6789 s=2 pgs=279718 cs=1
l=0).fault with nothing to send, going to standby
2013-06-25 09:32:33.701427 7fd02b9a7700  0 -- 10.205.119.16:6789/0 >>
:/0 pipe(0x2c0bb900 sd=38 :6789 s=0 pgs=0 cs=0 l=0).accept failed to
getpeername 107 Transport endpoint is not connected
2013-06-25 09:32:49.203946 7fd0304d7700 -1 mon.b@1(synchronizing sync(
requester state chunks )) e10 *** Got Signal Terminated ***
2013-06-25 09:32:49.214867 7fd0304d7700  1 mon.b@1(synchronizing sync(
requester state chunks )) e10 shutdown
2013-06-25 09:32:51.681099 7ff013dcb780  0 ceph version 0.60
(f26f7a39021dbf440c28d6375222e21c94fe8e5c), process ceph-mon, pid
19049
2013-06-25 09:32:52.358855 7ff013dcb780  1 mon.b@-1(probing) e0
preinit fsid c006f654-8289-4cc7-b7d8-834ceeb15a76
2013-06-25 09:32:52.366602 7ff013dcb780  1 mon.b@-1(probing) e0
preinit clean up potentially inconsistent store state
2013-06-25 09:33:37.732237 7fa8d66f1780  0 ceph version 0.60
(f26f7a39021dbf440c28d6375222e21c94fe8e5c), process ceph-mon, pid
19708
2013-06-25 09:33:37.732637 7fa8d66f1780  1 unable to open monitor
store at /ceph/mon.b
2013-06-25 09:33:37.732647 7fa8d66f1780  1 check for old monitor store format
2013-06-25 09:33:37.732653 7fa8d66f1780  1 store(/ceph/mon.b) mount
2013-06-25 09:33:50.464974 7f8177316780  0 ceph version 0.60
(f26f7a39021dbf440c28d6375222e21c94fe8e5c), process ceph-mon, pid
20200
2013-06-25 09:33:50.465428 7f8177316780  1 unable to open monitor
store at /ceph/mon.b
2013-06-25 09:33:50.465438 7f8177316780  1 check for old monitor store format
2013-06-25 09:33:50.465441 7f8177316780  1 store(/ceph/mon.b) mount
2013-06-25 09:34:10.812231 7ff013dcb780  0 mon.b@-1(probing) e0  my
rank is now 1 (was -1)
2013-06-25 09:34:10.812974 7fefbbf79700  0 -- 10.205.119.16:6789/0 >>
:/0 pipe(0x26c1400 sd=27 :6789 s=0 pgs=0 cs=0 l=0).accept failed to
getpeername 107 Transport endpoint is not connected
2013-06-25 09:34:10.813612 7fefbb973700  0 -- 10.205.119.16:6789/0 >>
:/0 pipe(0x3d72a00 sd=33 :6789 s=0 pgs=0 cs=0 l=0).accept failed to
getpeername 107 Transport endpoint is not connected
<snipped>


In dmesg:
[4486846.636463] ceph-osd invoked oom-killer: gfp_mask=0x201da,
order=0, oom_score_adj=0
[4486846.636469] ceph-osd cpuset=/ mems_allowed=0-1
[4486846.636472] Pid: 48060, comm: ceph-osd Not tainted 3.8.6-gentoo #1
[4486846.636474] Call Trace:
[4486846.636482]  [<ffffffff815f5b16>] dump_header+0x79/0x1fa
[4486846.636488]  [<ffffffff812f51b3>] ? ___ratelimit+0x93/0x110
[4486846.636492]  [<ffffffff8104af49>] ? has_ns_capability_noaudit+0x29/0x50
[4486846.636498]  [<ffffffff810e6f8a>] oom_kill_process+0x1da/0x350
[4486846.636501]  [<ffffffff810e7709>] out_of_memory+0x449/0x490
[4486846.636504]  [<ffffffff810ec736>] __alloc_pages_nodemask+0x9e6/0xa60
[4486846.636510]  [<ffffffff81125a85>] alloc_pages_current+0xb5/0x170
[4486846.636513]  [<ffffffff810e365f>] __page_cache_alloc+0xaf/0xd0
[4486846.636516]  [<ffffffff810e5cb5>] filemap_fault+0x2c5/0x4c0
[4486846.636519]  [<ffffffff81108fab>] __do_fault+0x6b/0x4f0
[4486846.636523]  [<ffffffff815fced4>] ? schedule+0x24/0x70
[4486846.636527]  [<ffffffff8110bc94>] handle_pte_fault+0x94/0xac0
[4486846.636531]  [<ffffffff814b47de>] ? sock_destroy_inode+0x2e/0x40
[4486846.636535]  [<ffffffff8112ee52>] ? kmem_cache_free+0x1f2/0x200
[4486846.636537]  [<ffffffff8110c959>] handle_mm_fault+0x159/0x490
[4486846.636542]  [<ffffffff81154373>] ? __d_free+0x43/0x60
[4486846.636544]  [<ffffffff8112ee52>] ? kmem_cache_free+0x1f2/0x200
[4486846.636549]  [<ffffffff8102e89d>] __do_page_fault+0x15d/0x460
[4486846.636552]  [<ffffffff8115de81>] ? mntput+0x21/0x30
[4486846.636555]  [<ffffffff81141130>] ? __fput+0x170/0x230
[4486846.636559]  [<ffffffff81076473>] ? pick_next_task_fair+0x63/0x140
[4486846.636563]  [<ffffffff8105e7a7>] ? task_work_add+0x17/0x70
[4486846.636565]  [<ffffffff811411f9>] ? ____fput+0x9/0x10
[4486846.636567]  [<ffffffff8105e904>] ? task_work_run+0x94/0xd0
[4486846.636570]  [<ffffffff8102ebc9>] do_page_fault+0x9/0x10
[4486846.636573]  [<ffffffff815fe562>] page_fault+0x22/0x30
[4486846.636575] Mem-Info:
[4486846.636576] Node 0 DMA per-cpu:
[4486846.636579] CPU    0: hi:    0, btch:   1 usd:   0
[4486846.636581] CPU    1: hi:    0, btch:   1 usd:   0
[4486846.636582] CPU    2: hi:    0, btch:   1 usd:   0
[4486846.636584] CPU    3: hi:    0, btch:   1 usd:   0
[4486846.636585] CPU    4: hi:    0, btch:   1 usd:   0
[4486846.636587] CPU    5: hi:    0, btch:   1 usd:   0
[4486846.636588] CPU    6: hi:    0, btch:   1 usd:   0
[4486846.636590] CPU    7: hi:    0, btch:   1 usd:   0
[4486846.636591] Node 0 DMA32 per-cpu:
[4486846.636593] CPU    0: hi:  186, btch:  31 usd:  82
[4486846.636595] CPU    1: hi:  186, btch:  31 usd: 137
[4486846.636597] CPU    2: hi:  186, btch:  31 usd: 155
[4486846.636598] CPU    3: hi:  186, btch:  31 usd:  62
[4486846.636600] CPU    4: hi:  186, btch:  31 usd:  49
[4486846.636601] CPU    5: hi:  186, btch:  31 usd:  57
[4486846.636603] CPU    6: hi:  186, btch:  31 usd:  51
[4486846.636604] CPU    7: hi:  186, btch:  31 usd:  42
[4486846.636605] Node 0 Normal per-cpu:
[4486846.636607] CPU    0: hi:  186, btch:  31 usd:  33
[4486846.636609] CPU    1: hi:  186, btch:  31 usd:   0
[4486846.636610] CPU    2: hi:  186, btch:  31 usd:  31
[4486846.636612] CPU    3: hi:  186, btch:  31 usd:  31
[4486846.636613] CPU    4: hi:  186, btch:  31 usd:  30
[4486846.636615] CPU    5: hi:  186, btch:  31 usd:   0
[4486846.636616] CPU    6: hi:  186, btch:  31 usd:   0
[4486846.636618] CPU    7: hi:  186, btch:  31 usd:   0
[4486846.636619] Node 1 Normal per-cpu:
[4486846.636621] CPU    0: hi:  186, btch:  31 usd:   0
[4486846.636623] CPU    1: hi:  186, btch:  31 usd:   0
[4486846.636624] CPU    2: hi:  186, btch:  31 usd:   0
[4486846.636626] CPU    3: hi:  186, btch:  31 usd:   0
[4486846.636627] CPU    4: hi:  186, btch:  31 usd:  30
[4486846.636629] CPU    5: hi:  186, btch:  31 usd:   0
[4486846.636631] CPU    6: hi:  186, btch:  31 usd:   0
[4486846.636632] CPU    7: hi:  186, btch:  31 usd:  17
[4486846.636636] active_anon:2973374 inactive_anon:167 isolated_anon:0
 active_file:157 inactive_file:219 isolated_file:0
 unevictable:0 dirty:5 writeback:0 unstable:0
 free:10400 slab_reclaimable:16215 slab_unreclaimable:13545
 mapped:173 shmem:210 pagetables:8786 bounce:0
 free_cma:0
[4486846.636640] Node 0 DMA free:15896kB min:16kB low:20kB high:24kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15640kB
managed:15896kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? yes
[4486846.636646] lowmem_reserve[]: 0 2999 6023 6023
[4486846.636649] Node 0 DMA32 free:15440kB min:3492kB low:4364kB
high:5236kB active_anon:2933088kB inactive_anon:0kB active_file:608kB
inactive_file:1208kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:3071880kB managed:3044436kB mlocked:0kB
dirty:8kB writeback:0kB mapped:688kB shmem:0kB
slab_reclaimable:21892kB slab_unreclaimable:14388kB
kernel_stack:10440kB pagetables:7992kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:3266 all_unreclaimable?
yes
[4486846.636654] lowmem_reserve[]: 0 0 3024 3024
[4486846.636657] Node 0 Normal free:3428kB min:3520kB low:4400kB
high:5280kB active_anon:2930428kB inactive_anon:352kB active_file:8kB
inactive_file:8kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:3096576kB managed:3046764kB mlocked:0kB
dirty:8kB writeback:0kB mapped:0kB shmem:464kB
slab_reclaimable:20080kB slab_unreclaimable:15400kB
kernel_stack:11288kB pagetables:9736kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:67 all_unreclaimable? yes
[4486846.636662] lowmem_reserve[]: 0 0 0 0
[4486846.636665] Node 1 Normal free:6836kB min:7040kB low:8800kB
high:10560kB active_anon:6029980kB inactive_anon:316kB
active_file:12kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:6193152kB managed:6192172kB mlocked:0kB
dirty:4kB writeback:0kB mapped:4kB shmem:376kB
slab_reclaimable:22888kB slab_unreclaimable:24392kB
kernel_stack:7376kB pagetables:17416kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:290 all_unreclaimable?
yes
[4486846.636670] lowmem_reserve[]: 0 0 0 0
[4486846.636672] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB
(U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (R) 3*4096kB
(M) = 15896kB
[4486846.636684] Node 0 DMA32: 2599*4kB (UEM) 618*8kB (U) 0*16kB
0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
15340kB
[4486846.636692] Node 0 Normal: 745*4kB (U) 1*8kB (R) 2*16kB (R)
3*32kB (R) 1*64kB (R) 2*128kB (R) 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 3436kB
[4486846.636703] Node 1 Normal: 1713*4kB (UM) 2*8kB (M) 0*16kB 0*32kB
9*64kB (R) 1*128kB (R) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
7572kB
[4486846.636712] 792 total pagecache pages
[4486846.636714] 0 pages in swap cache
[4486846.636715] Swap cache stats: add 0, delete 0, find 0/0
[4486846.636716] Free swap  = 0kB
[4486846.636717] Total swap = 0kB
[4486846.670134] 3145712 pages RAM
[4486846.670137] 70723 pages reserved
[4486846.670138] 478361 pages shared
[4486846.670139] 3057153 pages non-shared
[4486846.670140] [ pid ]   uid  tgid total_vm      rss nr_ptes
swapents oom_score_adj name
[4486846.670155] [ 1328]     0  1328     9004      130      20
0         -1000 udevd
[4486846.670163] [ 3198]     0  3198     2719       39       9
0             0 rsync
[4486846.670166] [ 3247]     0  3247     4199       43      14
0             0 cron
[4486846.670169] [ 3264]     0  3264     4028       38      13
0             0 agetty
[4486846.670171] [46643]     0 46643   377301   210578     625
0             0 ceph-osd
[4486846.670174] [46921]     0 46921   378966   204787     636
0             0 ceph-osd
[4486846.670177] [47188]     0 47188   316029   149765     516
0             0 ceph-osd
[4486846.670180] [47498]     0 47498   511578   340066     892
0             0 ceph-osd
[4486846.670182] [47783]     0 47783   435474   259780     742
0             0 ceph-osd
[4486846.670185] [48096]     0 48096   364300   179657     613
0             0 ceph-osd
[4486846.670187] [48393]     0 48393   321795   154119     521
0             0 ceph-osd
[4486846.670190] [48719]     0 48719   383859   201123     646
0             0 ceph-osd
[4486846.670193] [49064]     0 49064   336146   154638     551
0             0 ceph-osd
[4486846.670195] [49730]     0 49730   308432   133596     496
0             0 ceph-osd
[4486846.670198] [49995]     0 49995   397546   215486     668
0             0 ceph-osd
[4486846.670200] [ 2570]     0  2570    81307     2212      33
0             0 rsyslogd
[4486846.670203] [58042]     0 58042     7980      117      18
0         -1000 sshd
[4486846.670206] [47172]     0 47172     4028       38      13
0             0 agetty
[4486846.670208] [49522]     0 49522   609551   551641    1158
0             0 ceph-mon
[4486846.670211] [61117]     0 61117   272864   200333     500
0             0 ceph-mds
[4486846.670216] [15640]     0 15640    91602      316      33
0             0 ceph
[4486846.670220] [58564]     0 58564     6334       56      18
0             0 cron
[4486846.670223] [58569]     0 58569     2929       79      11
0             0 compress_and_se
[4486846.670225] [58806]     0 58806     3703       41      13
0             0 scp
[4486846.670228] [58809]     0 58809     6951      157      19
0             0 ssh
[4486846.670230] Out of memory: Kill process 49522 (ceph-mon) score
149 or sacrifice child
[4486846.670238] Killed process 49522 (ceph-mon) total-vm:2438204kB,
anon-rss:2206564kB, file-rss:0kB
