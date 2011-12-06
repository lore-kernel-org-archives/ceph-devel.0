From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Assert failure in FileStore::_do_transaction
Date: Tue, 06 Dec 2011 13:31:24 -0800
Message-ID: <4EDE89AC.5030405@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:41128 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab1LFVbb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 16:31:31 -0500
Received: from [128.114.52.36] (kyoto.soe.ucsc.edu [128.114.52.36])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id ECCB71009C1A
	for <ceph-devel@vger.kernel.org>; Tue,  6 Dec 2011 13:31:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I got the following failure after restarting an OSD. There were no 
issues prior to this, but the cluster had been stopped/restarted many 
times. This is on ext4.

Thanks,
Noah

2011-12-06 11:58:11.552177 7ffbe5f89700 filestore(/mnt/vol1/osd)  error 
error 22: Invalid argument not handled
os/FileStore.cc: In function 'unsigned int 
FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t)', in 
thread '7ffbe5f89700'
os/FileStore.cc: 2412: FAILED assert(0 == "unexpected error")
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  3: (FileStore::_do_op(FileStore::OpSequencer*)+0x176) [0x6bb306]
  4: (ThreadPool::worker()+0xa28) [0x5bee78]
  5: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
  6: (()+0x7971) [0x7ffbf0a0e971]
  7: (clone()+0x6d) [0x7ffbef09992d]
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  3: (FileStore::_do_op(FileStore::OpSequencer*)+0x176) [0x6bb306]
  4: (ThreadPool::worker()+0xa28) [0x5bee78]
  5: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
  6: (()+0x7971) [0x7ffbf0a0e971]
  7: (clone()+0x6d) [0x7ffbef09992d]
*** Caught signal (Aborted) **
  in thread 7ffbe5f89700
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: /usr/bin/ceph-osd() [0x6b1c84]
  2: (()+0xfb40) [0x7ffbf0a16b40]
  3: (gsignal()+0x35) [0x7ffbeefe6ba5]
  4: (abort()+0x180) [0x7ffbeefea6b0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7ffbef88a6bd]
  6: (()+0xb9906) [0x7ffbef888906]
  7: (()+0xb9933) [0x7ffbef888933]
  8: (()+0xb9a3e) [0x7ffbef888a3e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x39f) [0x5ccdbf]
  10: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  11: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  12: (FileStore::_do_op(FileStore::OpSequencer*)+0x176) [0x6bb306]
  13: (ThreadPool::worker()+0xa28) [0x5bee78]
  14: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
  15: (()+0x7971) [0x7ffbf0a0e971]
  16: (clone()+0x6d) [0x7ffbef09992d]
2011-12-06 13:25:13.390151 7fc539d3f780 ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381), process ceph-osd, pid 
1314
2011-12-06 13:25:13.459719 7fc539d3f780 filestore(/mnt/vol1/osd) mount 
FIEMAP ioctl is supported
2011-12-06 13:25:13.459854 7fc539d3f780 filestore(/mnt/vol1/osd) mount 
did NOT detect btrfs
2011-12-06 13:25:13.482119 7fc539d3f780 filestore(/mnt/vol1/osd) mount 
found snaps <>
2011-12-06 13:25:13.494092 7fc539d3f780 filestore(/mnt/vol1/osd) mount: 
enabling WRITEAHEAD journal mode: btrfs not detected
2011-12-06 13:25:13.972914 7fc539d3f780 journal _open 
/mnt/vol2/osd.journal fd 14: 1048576000 bytes, block size 4096 bytes, 
directio = 1
2011-12-06 13:25:14.013331 7fc539d3f780 journal read_entry 803999744 : 
seq 54062 1002407 bytes
2011-12-06 13:25:14.014773 7fc539d3f780 journal read_entry 803999744 : 
seq 54062 1002407 bytes
2011-12-06 13:25:14.048581 7fc539d3f780 filestore(/mnt/vol1/osd)  error 
error 22: Invalid argument not handled
os/FileStore.cc: In function 'unsigned int 
FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t)', in 
thread '7fc539d3f780'
os/FileStore.cc: 2412: FAILED assert(0 == "unexpected error")
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  3: (JournalingObjectStore::journal_replay(unsigned long)+0x8e0) [0x6eab90]
  4: (FileStore::mount()+0x2a68) [0x6cc128]
  5: (OSD::convertfs(std::string const&, std::string const&)+0xc8) 
[0x525d38]
  6: (main()+0x2bed) [0x49e6ed]
  7: (__libc_start_main()+0xfe) [0x7fc537ee3d8e]
  8: /usr/bin/ceph-osd() [0x49b6d9]
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  3: (JournalingObjectStore::journal_replay(unsigned long)+0x8e0) [0x6eab90]
  4: (FileStore::mount()+0x2a68) [0x6cc128]
  5: (OSD::convertfs(std::string const&, std::string const&)+0xc8) 
[0x525d38]
  6: (main()+0x2bed) [0x49e6ed]
  7: (__libc_start_main()+0xfe) [0x7fc537ee3d8e]
  8: /usr/bin/ceph-osd() [0x49b6d9]
*** Caught signal (Aborted) **
  in thread 7fc539d3f780
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: /usr/bin/ceph-osd() [0x6b1c84]
  2: (()+0xfb40) [0x7fc539928b40]
  3: (gsignal()+0x35) [0x7fc537ef8ba5]
  4: (abort()+0x180) [0x7fc537efc6b0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc53879c6bd]
  6: (()+0xb9906) [0x7fc53879a906]
  7: (()+0xb9933) [0x7fc53879a933]
  8: (()+0xb9a3e) [0x7fc53879aa3e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x39f) [0x5ccdbf]
  10: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long)+0x56e) [0x6de19e]
  11: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x78) 
[0x6e2678]
  12: (JournalingObjectStore::journal_replay(unsigned long)+0x8e0) 
[0x6eab90]
  13: (FileStore::mount()+0x2a68) [0x6cc128]
  14: (OSD::convertfs(std::string const&, std::string const&)+0xc8) 
[0x525d38]
  15: (main()+0x2bed) [0x49e6ed]
  16: (__libc_start_main()+0xfe) [0x7fc537ee3d8e]
  17: /usr/bin/ceph-osd() [0x49b6d9]
nwatkins@piha:~$

