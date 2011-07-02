From: Fyodor Ustinov <ufm@ufm.su>
Subject: MDS crash.
Date: Sun, 03 Jul 2011 00:30:37 +0300
Message-ID: <4E0F8DFD.5000601@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:39179 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab1GBVak (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2011 17:30:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id AE38C600485
	for <ceph-devel@vger.kernel.org>; Sun,  3 Jul 2011 00:30:38 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8wYUwsX4EQi for <ceph-devel@vger.kernel.org>;
	Sun,  3 Jul 2011 00:30:38 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 7E00D600484
	for <ceph-devel@vger.kernel.org>; Sun,  3 Jul 2011 00:30:38 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

mds - 0.30

I can not to reproduce, sorry.

mds/Locker.cc: In function 'void Locker::file_excl(ScatterLock*, 
bool*)', in thread '0x7fefc6c68700'
mds/Locker.cc: 3982: FAILED assert(in->get_loner() >= 0 && 
in->mds_caps_wanted.empty())
  ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)
  1: (Locker::file_excl(ScatterLock*, bool*)+0x944) [0x5baa04]
  2: (Locker::simple_sync(SimpleLock*, bool*)+0x211) [0x5bea41]
  3: (Locker::file_eval(ScatterLock*, bool*)+0x2c7) [0x5bf537]
  4: (Locker::rdlock_finish(SimpleLock*, Mutation*, bool*)+0x174) [0x5c7ec4]
  5: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x148) [0x5c8488]
  6: (MDCache::request_cleanup(MDRequest*)+0x8a) [0x54247a]
  7: (MDCache::request_finish(MDRequest*)+0xf3) [0x542b23]
  8: (Server::reply_request(MDRequest*, MClientReply*, CInode*, 
CDentry*)+0x193) [0x4e2633]
  9: (Server::handle_client_stat(MDRequest*)+0x344) [0x4ebbe4]
  10: (Server::dispatch_client_request(MDRequest*)+0x3d6) [0x50b4a6]
  11: (MDCache::dispatch_request(MDRequest*)+0x46) [0x52b056]
  12: (C_MDS_RetryRequest::finish(int)+0x11) [0x5180e1]
  13: /usr/bin/cmds() [0x5b06d2]
  14: /usr/bin/cmds() [0x5b0817]
  15: (Locker::eval_gather(SimpleLock*, bool, bool*, std::list<Context*, 
std::allocator<Context*> >*)+0x175f) [0x5c517f]
  16: (Locker::wrlock_finish(SimpleLock*, Mutation*, bool*)+0x378) 
[0x5c7998]
  17: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x208) [0x5c8548]
  18: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t, 
Capability*, MClientCaps*)+0x2c6) [0x5cc6c6]
  19: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d9b1c]
  20: (finish_contexts(std::list<Context*, std::allocator<Context*> >&, 
int)+0xc4) [0x5943b4]
  21: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20b) 
[0x6ae8ab]
  22: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa6c) [0x692b6c]
  23: (MDS::handle_core_message(Message*)+0x82f) [0x4a3e6f]
  24: (MDS::_dispatch(Message*)+0x2a9) [0x4a4189]
  25: (MDS::ms_dispatch(Message*)+0x6d) [0x4a5d7d]
  26: (SimpleMessenger::dispatch_entry()+0x8f3) [0x6e16d3]
  27: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4829bc]
  28: (()+0x6d8c) [0x7fefc969fd8c]
  29: (clone()+0x6d) [0x7fefc855204d]
  ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)
  1: (Locker::file_excl(ScatterLock*, bool*)+0x944) [0x5baa04]
  2: (Locker::simple_sync(SimpleLock*, bool*)+0x211) [0x5bea41]
  3: (Locker::file_eval(ScatterLock*, bool*)+0x2c7) [0x5bf537]
  4: (Locker::rdlock_finish(SimpleLock*, Mutation*, bool*)+0x174) [0x5c7ec4]
  5: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x148) [0x5c8488]
  6: (MDCache::request_cleanup(MDRequest*)+0x8a) [0x54247a]
  7: (MDCache::request_finish(MDRequest*)+0xf3) [0x542b23]
  8: (Server::reply_request(MDRequest*, MClientReply*, CInode*, 
CDentry*)+0x193) [0x4e2633]
  9: (Server::handle_client_stat(MDRequest*)+0x344) [0x4ebbe4]
  10: (Server::dispatch_client_request(MDRequest*)+0x3d6) [0x50b4a6]
  11: (MDCache::dispatch_request(MDRequest*)+0x46) [0x52b056]
  12: (C_MDS_RetryRequest::finish(int)+0x11) [0x5180e1]
  13: /usr/bin/cmds() [0x5b06d2]
  14: /usr/bin/cmds() [0x5b0817]
  15: (Locker::eval_gather(SimpleLock*, bool, bool*, std::list<Context*, 
std::allocator<Context*> >*)+0x175f) [0x5c517f]
  16: (Locker::wrlock_finish(SimpleLock*, Mutation*, bool*)+0x378) 
[0x5c7998]
  17: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x208) [0x5c8548]
  18: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t, 
Capability*, MClientCaps*)+0x2c6) [0x5cc6c6]
  19: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d9b1c]
  20: (finish_contexts(std::list<Context*, std::allocator<Context*> >&, 
int)+0xc4) [0x5943b4]
  21: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20b) 
[0x6ae8ab]
  22: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa6c) [0x692b6c]
  23: (MDS::handle_core_message(Message*)+0x82f) [0x4a3e6f]
  24: (MDS::_dispatch(Message*)+0x2a9) [0x4a4189]
  25: (MDS::ms_dispatch(Message*)+0x6d) [0x4a5d7d]
  26: (SimpleMessenger::dispatch_entry()+0x8f3) [0x6e16d3]
  27: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4829bc]
  28: (()+0x6d8c) [0x7fefc969fd8c]
  29: (clone()+0x6d) [0x7fefc855204d]
*** Caught signal (Aborted) **
  in thread 0x7fefc6c68700
  ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)
  1: /usr/bin/cmds() [0x70495e]
  2: (()+0xfc60) [0x7fefc96a8c60]
  3: (gsignal()+0x35) [0x7fefc849fd05]
  4: (abort()+0x186) [0x7fefc84a3ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fefc8d566dd]
  6: (()+0xb9926) [0x7fefc8d54926]
  7: (()+0xb9953) [0x7fefc8d54953]
  8: (()+0xb9a5e) [0x7fefc8d54a5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x371) [0x6cffa1]
  10: (Locker::file_excl(ScatterLock*, bool*)+0x944) [0x5baa04]
  11: (Locker::simple_sync(SimpleLock*, bool*)+0x211) [0x5bea41]
  12: (Locker::file_eval(ScatterLock*, bool*)+0x2c7) [0x5bf537]
  13: (Locker::rdlock_finish(SimpleLock*, Mutation*, bool*)+0x174) 
[0x5c7ec4]
  14: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x148) [0x5c8488]
  15: (MDCache::request_cleanup(MDRequest*)+0x8a) [0x54247a]
  16: (MDCache::request_finish(MDRequest*)+0xf3) [0x542b23]
  17: (Server::reply_request(MDRequest*, MClientReply*, CInode*, 
CDentry*)+0x193) [0x4e2633]
  18: (Server::handle_client_stat(MDRequest*)+0x344) [0x4ebbe4]
  19: (Server::dispatch_client_request(MDRequest*)+0x3d6) [0x50b4a6]
  20: (MDCache::dispatch_request(MDRequest*)+0x46) [0x52b056]
  21: (C_MDS_RetryRequest::finish(int)+0x11) [0x5180e1]
  22: /usr/bin/cmds() [0x5b06d2]
  23: /usr/bin/cmds() [0x5b0817]
  24: (Locker::eval_gather(SimpleLock*, bool, bool*, std::list<Context*, 
std::allocator<Context*> >*)+0x175f) [0x5c517f]
  25: (Locker::wrlock_finish(SimpleLock*, Mutation*, bool*)+0x378) 
[0x5c7998]
  26: (Locker::drop_locks(Mutation*, std::set<CInode*, 
std::less<CInode*>, std::allocator<CInode*> >*)+0x208) [0x5c8548]
  27: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t, 
Capability*, MClientCaps*)+0x2c6) [0x5cc6c6]
  28: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d9b1c]
  29: (finish_contexts(std::list<Context*, std::allocator<Context*> >&, 
int)+0xc4) [0x5943b4]
  30: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20b) 
[0x6ae8ab]
  31: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa6c) [0x692b6c]
  32: (MDS::handle_core_message(Message*)+0x82f) [0x4a3e6f]
  33: (MDS::_dispatch(Message*)+0x2a9) [0x4a4189]
  34: (MDS::ms_dispatch(Message*)+0x6d) [0x4a5d7d]
  35: (SimpleMessenger::dispatch_entry()+0x8f3) [0x6e16d3]
  36: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4829bc]
  37: (()+0x6d8c) [0x7fefc969fd8c]
  38: (clone()+0x6d) [0x7fefc855204d]

core bt:
(gdb) bt
#0  0x00007fefc96a8b3b in raise (sig=<value optimized out>) at 
../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
#1  0x0000000000703a53 in ?? ()
#2  0x0000000000704b7b in ?? ()
#3 <signal handler called>
#4  0x00007fefc849fd05 in raise (sig=6) at 
../nptl/sysdeps/unix/sysv/linux/raise.c:64
#5  0x00007fefc84a3ab6 in abort () at abort.c:92
#6  0x00007fefc8d566dd in __gnu_cxx::__verbose_terminate_handler() () 
from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#7  0x00007fefc8d54926 in ?? () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#8  0x00007fefc8d54953 in std::terminate() () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007fefc8d54a5e in __cxa_throw () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#10 0x00000000006cffa1 in ceph::__ceph_assert_fail(char const*, char 
const*, int, char const*) ()
#11 0x00000000005baa04 in Locker::file_excl(ScatterLock*, bool*) ()
#12 0x00000000005bea41 in Locker::simple_sync(SimpleLock*, bool*) ()
#13 0x00000000005bf537 in Locker::file_eval(ScatterLock*, bool*) ()
#14 0x00000000005c7ec4 in Locker::rdlock_finish(SimpleLock*, Mutation*, 
bool*) ()
#15 0x00000000005c8488 in Locker::drop_locks(Mutation*, 
std::set<CInode*, std::less<CInode*>, std::allocator<CInode*> >*) ()
#16 0x000000000054247a in MDCache::request_cleanup(MDRequest*) ()
#17 0x0000000000542b23 in MDCache::request_finish(MDRequest*) ()
#18 0x00000000004e2633 in Server::reply_request(MDRequest*, 
MClientReply*, CInode*, CDentry*) ()
#19 0x00000000004ebbe4 in Server::handle_client_stat(MDRequest*) ()
#20 0x000000000050b4a6 in Server::dispatch_client_request(MDRequest*) ()
#21 0x000000000052b056 in MDCache::dispatch_request(MDRequest*) ()
#22 0x00000000005180e1 in C_MDS_RetryRequest::finish(int) ()
#23 0x00000000005b06d2 in ?? ()
#24 0x00000000005b0817 in ?? ()
#25 0x00000000005c517f in Locker::eval_gather(SimpleLock*, bool, bool*, 
std::list<Context*, std::allocator<Context*> >*) ()
#26 0x00000000005c7998 in Locker::wrlock_finish(SimpleLock*, Mutation*, 
bool*) ()
#27 0x00000000005c8548 in Locker::drop_locks(Mutation*, 
std::set<CInode*, std::less<CInode*>, std::allocator<CInode*> >*) ()
#28 0x00000000005cc6c6 in Locker::file_update_finish(CInode*, Mutation*, 
bool, client_t, Capability*, MClientCaps*) ()
#29 0x00000000005d9b1c in C_Locker_FileUpdate_finish::finish(int) ()
#30 0x00000000005943b4 in finish_contexts(std::list<Context*, 
std::allocator<Context*> >&, int) ()
#31 0x00000000006ae8ab in Journaler::_finish_flush(int, unsigned long, 
utime_t) ()
#32 0x0000000000692b6c in Objecter::handle_osd_op_reply(MOSDOpReply*) ()
#33 0x00000000004a3e6f in MDS::handle_core_message(Message*) ()
#34 0x00000000004a4189 in MDS::_dispatch(Message*) ()
#35 0x00000000004a5d7d in MDS::ms_dispatch(Message*) ()
#36 0x00000000006e16d3 in SimpleMessenger::dispatch_entry() ()
#37 0x00000000004829bc in SimpleMessenger::DispatchThread::entry() ()
#38 0x00007fefc969fd8c in start_thread (arg=0x7fefc6c68700) at 
pthread_create.c:304
#39 0x00007fefc855204d in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:112
#40 0x0000000000000000 in ?? ()

WBR,
     Fyodor.
