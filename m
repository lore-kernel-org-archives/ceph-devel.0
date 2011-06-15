From: Sam Lang <samlang@gmail.com>
Subject: syslog problems
Date: Wed, 15 Jun 2011 09:26:42 -0500
Message-ID: <4DF8C122.5050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64603 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1FOO0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2011 10:26:45 -0400
Received: by vws1 with SMTP id 1so354135vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2011 07:26:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


In my ceph setup, I had logs being written to the default location 
(/var/log/ceph/) and eventually would get monitor or osd crashes because 
the disk would fill up with logs.  So I started writing the logs to 
syslog, and now the local disk doesn't fill up, but I still get similar 
errors to those of before.  For example:

Jun 15 08:58:24 lut-ceph02 mon.beta[6739]: *** Caught signal (Aborted) 
**#012 in thread 0x7f79b1b62700
Jun 15 08:58:24 lut-ceph02 mon.beta[6739]:  ceph version  (commit:)#012 
1: /usr/ceph/bin/cmon() [0x5a1d69]#012 2: (()+0xfc60) 
[0x7f79b461bc60]#012 3: (gsignal()+0x35) [0x7f79b3b0ad05]#012 4: 
(abort()+0x186) [0x7f79b3b0eab6]#012 5: 
(__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f79b43c16dd]#012 6: 
(()+0xb9926) [0x7f79b43bf926]#012 7: (()+0xb9953) [0x7f79b43bf953]#012 
8: (()+0xb9a5e) [0x7f79b43bfa5e]#012 9: (ceph::__ceph_assert_fail(char 
const*, char const*, int, char const*)+0x362) [0x57d252]#012 10: 
(MonitorStore::write_bl_ss(ceph::buffer::list&, char const*, char 
const*, bool, bool)+0x2bd) [0x510dcd]#012 11: 
(LogMonitor::update_from_paxos()+0x2547) [0x4f26f7]#012 12: 
(Monitor::_ms_dispatch(Message*)+0xd8c) [0x480afc]#012 13: 
(Monitor::ms_dispatch(Message*)+0x79) [0x48a2f9]#012 14: 
(SimpleMessenger::dispatch_entry()+0x667) [0x46b157]#012 15: 
(SimpleMessenger::DispatchThread::entry()+0x1c) [0x456c5c]#012 16: 
(()+0x6d8c) [0x7f79b4612d8c]#012 17: (clone()+0x6d) [0x7f79b3bbd04d]

Also, I've seen a monitor process get killed by the OOM killer (see 
below).  Are these known issues?  In practice, do folks just disable all 
logging right now and hope for the best?

Thanks,
-sam

OOM killer messages:

[364540.080818] Node 0 DMA free:7992kB min:348kB low:432kB high:520kB 
active_anon:3632kB inactive
_anon:3744kB active_file:0kB inactive_file:0kB unevictable:0kB 
isolated(anon):0kB isolated(file):
0kB present:15664kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB 
shmem:0kB slab_reclaimable:56k
B slab_unreclaimable:384kB kernel_stack:64kB pagetables:16kB 
unstable:0kB bounce:0kB writeback_tm
p:0kB pages_scanned:0 all_unreclaimable? yes
[364540.080831] lowmem_reserve[]: 0 1963 1963 1963
[364540.080837] Node 0 DMA32 free:44672kB min:44704kB low:55880kB 
high:67056kB active_anon:138704
4kB inactive_anon:462364kB active_file:520kB inactive_file:2780kB 
unevictable:0kB isolated(anon):
0kB isolated(file):0kB present:2010592kB mlocked:0kB dirty:4kB 
writeback:8kB mapped:396kB shmem:5
920kB slab_reclaimable:7928kB slab_unreclaimable:18600kB 
kernel_stack:7560kB pagetables:11992kB u
nstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:2860 
all_unreclaimable? yes
[364540.080850] lowmem_reserve[]: 0 0 0 0
[364540.080856] Node 0 DMA: 14*4kB 14*8kB 7*16kB 3*32kB 3*64kB 2*128kB 
4*256kB 4*512kB 2*1024kB 1
*2048kB 0*4096kB = 7992kB
[364540.080869] Node 0 DMA32: 9632*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024k
B 1*2048kB 1*4096kB = 44672kB
[364540.080882] 4870 total pagecache pages
[364540.080884] 2596 pages in swap cache
[364540.080887] Swap cache stats: add 501808, delete 499212, find 6734/8216
[364540.080889] Free swap  = 0kB
[364540.080891] Total swap = 1953040kB
[364540.087324] 513696 pages RAM
[364540.087327] 10085 pages reserved
[364540.087329] 1907 pages shared
[364540.087330] 487503 pages non-shared
...
[364540.087475] [ 5998]     0  5975   851179   444043   0       
0             0 cmon
[364540.087480] [ 6188]     0  6188    49938      145   1       
0             0 cmds
[364540.087484] [ 6396]     0  6396   150647     1359   1       
0             0 cosd
[364540.087489] [ 6485]     0  6485   176420     7324   0       
0             0 cosd
[364540.087494] [ 7076]     0  7076   168333     1561   1       
0             0 cosd
[364540.087499] [ 7660]     0  7660   167456     1571   1       
0             0 cosd
[364540.087503] [ 7747]     0  7747   149214     1497   0       
0             0 cosd
[364540.087515] Out of memory: Kill process 5998 (cmon) score 776 or 
sacrifice child
[364540.087570] Killed process 5998 (cmon) total-vm:3404716kB, 
anon-rss:1776172kB, file-rss:0kB

