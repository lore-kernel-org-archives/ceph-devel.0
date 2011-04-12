From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: osd stops
Date: Tue, 12 Apr 2011 18:26:51 +0200 (CEST)
Message-ID: <2040040255.14467.1302625611658.JavaMail.root@mail.linserv.se>
References: <1608788961.14465.1302625479260.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:42300 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab1DLQdv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 12:33:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 58A151204E8
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 18:26:52 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIOovNDsnzPF for <ceph-devel@vger.kernel.org>;
	Tue, 12 Apr 2011 18:26:51 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id BAD5B12002A
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 18:26:51 +0200 (CEST)
In-Reply-To: <1608788961.14465.1302625479260.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have been done some tests and it seems as I always get the same problem.
I have been transfering data and suddenly I get I/O error and superblock problem.
This occurs when the filesystem is filled to aprox 80%

ceph health reports no error. I restart the system -a stop -a start
after that the system is degraded and the osd stopes.

The log shows of the fist failing osd

2011-04-12 17:51:07.716513 7f02365b8700 -- 0.0.0.0:6802/20180 >> 10.0.6.12:6802/13633 pipe(0x2e1da00 sd=22 pgs=0 cs=0 l=0).fault first fault
2011-04-12 17:51:07.716868 7f02365b8700 -- 0.0.0.0:6802/20180 >> 10.0.6.12:6802/13633 pipe(0x2e1da00 sd=22 pgs=0 cs=0 l=0).connect claims to be 0.0.0.0:6802/15976 not 10.0.6.12:6802/13633 - wrong node!
os/FileStore.cc: In function 'void FileStore::sync_entry()', in thread '0x7f023f9ce700'
os/FileStore.cc: 2674: FAILED assert(r == 0)
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (FileStore::sync_entry()+0x1975) [0x59f165]
 2: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]
 3: (()+0x68ba) [0x7f024602b8ba]
 4: (clone()+0x6d) [0x7f0244cc002d]
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (FileStore::sync_entry()+0x1975) [0x59f165]
 2: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]
 3: (()+0x68ba) [0x7f024602b8ba]
 4: (clone()+0x6d) [0x7f0244cc002d]
*** Caught signal (Aborted) **
 in thread 0x7f023f9ce700
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: /usr/bin/cosd() [0x61e42c]
 2: (()+0xef60) [0x7f0246033f60]
 3: (gsignal()+0x35) [0x7f0244c23165]
 4: (abort()+0x180) [0x7f0244c25f70]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f02454b6dc5]
 6: (()+0xcb166) [0x7f02454b5166]
 7: (()+0xcb193) [0x7f02454b5193]
 8: (()+0xcb28e) [0x7f02454b528e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x373) [0x6061e3]
 10: (FileStore::sync_entry()+0x1975) [0x59f165]
 11: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]
 12: (()+0x68ba) [0x7f024602b8ba]
 13: (clone()+0x6d) [0x7f0244cc002d]

the second failing osd

2011-04-12 18:03:36.036420 7f39c6ce7700 FileStore: sync_entry timed out after 600 seconds.
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
2011-04-12 18:03:36.036494 1: (SafeTimer::timer_thread()+0x36b) [0x601afb]
2011-04-12 18:03:36.036509 2: (SafeTimerThread::entry()+0xd) [0x6042cd]
2011-04-12 18:03:36.036528 3: (()+0x68ba) [0x7f39d034a8ba]
2011-04-12 18:03:36.036541 4: (clone()+0x6d) [0x7f39cefdf02d]
2011-04-12 18:03:36.036551 os/FileStore.cc: In function 'virtual void SyncEntryTimeout::finish(int)', in thread '0x7f39c6ce7700'
os/FileStore.cc: 2573: FAILED assert(0)
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]
 2: (SafeTimer::timer_thread()+0x36b) [0x601afb]
 3: (SafeTimerThread::entry()+0xd) [0x6042cd]
 4: (()+0x68ba) [0x7f39d034a8ba]
 5: (clone()+0x6d) [0x7f39cefdf02d]
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]
 2: (SafeTimer::timer_thread()+0x36b) [0x601afb]
 3: (SafeTimerThread::entry()+0xd) [0x6042cd]
 4: (()+0x68ba) [0x7f39d034a8ba]
 5: (clone()+0x6d) [0x7f39cefdf02d]
*** Caught signal (Aborted) **
 in thread 0x7f39c6ce7700
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: /usr/bin/cosd() [0x61e42c]
 2: (()+0xef60) [0x7f39d0352f60]
 3: (gsignal()+0x35) [0x7f39cef42165]
 4: (abort()+0x180) [0x7f39cef44f70]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f39cf7d5dc5]
 6: (()+0xcb166) [0x7f39cf7d4166]
 7: (()+0xcb193) [0x7f39cf7d4193]
 8: (()+0xcb28e) [0x7f39cf7d428e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x373) [0x6061e3]
 10: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]
 11: (SafeTimer::timer_thread()+0x36b) [0x601afb]
 12: (SafeTimerThread::entry()+0xd) [0x6042cd]
 13: (()+0x68ba) [0x7f39d034a8ba]
 14: (clone()+0x6d) [0x7f39cefdf02d]

regards Martin
