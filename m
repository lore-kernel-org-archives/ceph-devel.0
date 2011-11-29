From: Martin Mailand <martin@tuxadero.com>
Subject: os/FileJournal.cc: 1011: FAILED assert(seq >= last_committed_seq)
Date: Tue, 29 Nov 2011 12:48:26 +0100
Message-ID: <4ED4C68A.9060606@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:37355 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1K2Lse (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2011 06:48:34 -0500
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pATBmQ6b031437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 29 Nov 2011 12:48:31 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I hit this assertion a few times. I use ext4 as the osd fs, so I think 
we have to replay the whole journal, maybe that triggers it.


-martin

2011-11-29 11:37:55.393296 7fab45dbc7a0 FileStore is up to date.
os/FileJournal.cc: In function 'virtual void 
FileJournal::committed_thru(uint64_t)', in thread '7fab434cf700'
os/FileJournal.cc: 1011: FAILED assert(seq >= last_committed_seq)
  ceph version 0.38-244-g30def38 
(commit:30def38d21b217f244db74e6c469598d794fa8a1)
  1: (FileJournal::committed_thru(unsigned long)+0xcd) [0x72e7cd]
  2: (JournalingObjectStore::commit_finish()+0xb9) [0x714d79]
  3: (FileStore::sync_entry()+0xec7) [0x70aae7]
  4: (FileStore::SyncThread::entry()+0xd) [0x7139bd]
  5: (()+0x6d8c) [0x7fab45993d8c]
  6: (clone()+0x6d) [0x7fab43fd004d]
  ceph version 0.38-244-g30def38 
(commit:30def38d21b217f244db74e6c469598d794fa8a1)
  1: (FileJournal::committed_thru(unsigned long)+0xcd) [0x72e7cd]
  2: (JournalingObjectStore::commit_finish()+0xb9) [0x714d79]
  3: (FileStore::sync_entry()+0xec7) [0x70aae7]
  4: (FileStore::SyncThread::entry()+0xd) [0x7139bd]
  5: (()+0x6d8c) [0x7fab45993d8c]
  6: (clone()+0x6d) [0x7fab43fd004d]
*** Caught signal (Aborted) **
  in thread 7fab434cf700
  ceph version 0.38-244-g30def38 
(commit:30def38d21b217f244db74e6c469598d794fa8a1)
  1: /usr/bin/ceph-osd() [0x5a7ba2]
  2: (()+0xfc60) [0x7fab4599cc60]
  3: (gsignal()+0x35) [0x7fab43f1dd05]
  4: (abort()+0x186) [0x7fab43f21ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fab447d46dd]
  6: (()+0xb9926) [0x7fab447d2926]
  7: (()+0xb9953) [0x7fab447d2953]
  8: (()+0xb9a5e) [0x7fab447d2a5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x396) [0x5cd9e6]
  10: (FileJournal::committed_thru(unsigned long)+0xcd) [0x72e7cd]
  11: (JournalingObjectStore::commit_finish()+0xb9) [0x714d79]
  12: (FileStore::sync_entry()+0xec7) [0x70aae7]
  13: (FileStore::SyncThread::entry()+0xd) [0x7139bd]
  14: (()+0x6d8c) [0x7fab45993d8c]
  15: (clone()+0x6d) [0x7fab43fd004d]


Thread 1 (Thread 2491):
#0  0x00007fab4599cb3b in raise () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00000000005a77f2 in reraise_fatal (signum=6) at 
global/signal_handler.cc:59
#2  0x00000000005a7dea in handle_fatal_signal (signum=6) at 
global/signal_handler.cc:106
#3  <signal handler called>
#4  0x00007fab43f1dd05 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#5  0x00007fab43f21ab6 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#6  0x00007fab447d46dd in __gnu_cxx::__verbose_terminate_handler() () 
from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#7  0x00007fab447d2926 in ?? () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
---Type <return> to continue, or q <return> to quit---
#8  0x00007fab447d2953 in std::terminate() () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007fab447d2a5e in __cxa_throw () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#10 0x00000000005cd9e6 in ceph::__ceph_assert_fail (assertion=<value 
optimized out>, file=<value optimized out>, line=<value optimized out>, 
func=<value optimized out>)
     at common/assert.cc:70
#11 0x000000000072e7cd in FileJournal::committed_thru (this=0x1410000, 
seq=4145693) at os/FileJournal.cc:1011
#12 0x0000000000714d79 in JournalingObjectStore::commit_finish 
(this=0x1401000) at os/JournalingObjectStore.cc:260
#13 0x000000000070aae7 in FileStore::sync_entry (this=0x1401000) at 
os/FileStore.cc:3079
#14 0x00000000007139bd in FileStore::SyncThread::entry (this=<value 
optimized out>) at os/FileStore.h:101
#15 0x00007fab45993d8c in start_thread () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#16 0x00007fab43fd004d in clone () from /lib/x86_64-linux-gnu/libc.so.6
#17 0x0000000000000000 in ?? ()
(gdb)
(gdb) thread 1
[Switching to thread 1 (Thread 2491)]#0  0x00007fab4599cb3b in raise () 
from /lib/x86_64-linux-gnu/libpthread.so.0
(gdb) thread 11
Thread ID 11 not known.
(gdb) frame 11
#11 0x000000000072e7cd in FileJournal::committed_thru (this=0x1410000, 
seq=4145693) at os/FileJournal.cc:1011
1011    os/FileJournal.cc: No such file or directory.
         in os/FileJournal.cc
(gdb) p seq
$1 = 4145693
(gdb) p last_committed_seq
$2 = 4145768
(gdb)

