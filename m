From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD crash
Date: Sat, 16 Jun 2012 15:34:14 +0200
Message-ID: <4FDC8B56.7080507@profihost.ag>
References: <4FDC82BA.5030102@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40977 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab2FPNeO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 09:34:14 -0400
In-Reply-To: <4FDC82BA.5030102@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

and another crash again ;-(


      0> 2012-06-16 15:31:32.524369 7fd8935c4700 -1 ./common/Mutex.h: In 
function 'void Mutex::Lock(bool)' thread 7fd8935c4700 time 2012-06-16 
15:31:32.522446
./common/Mutex.h: 110: FAILED assert(r == 0)

  ceph version  (commit:)
  1: /usr/bin/ceph-osd() [0x51a07d]
  2: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c5a]
  3: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2e4) [0x684374]
  4: (ThreadPool::worker()+0xbb7) [0x7bc087]
  5: (ThreadPool::WorkThread::entry()+0xd) [0x5f144d]
  6: (()+0x68ca) [0x7fd89db3a8ca]
  7: (clone()+0x6d) [0x7fd89c1bec0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- end dump of recent events ---
2012-06-16 15:31:32.531567 7fd8935c4700 -1 *** Caught signal (Aborted) **
  in thread 7fd8935c4700

  ceph version  (commit:)
  1: /usr/bin/ceph-osd() [0x70e4b9]
  2: (()+0xeff0) [0x7fd89db42ff0]
  3: (gsignal()+0x35) [0x7fd89c121225]
  4: (abort()+0x180) [0x7fd89c124030]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd89c9b5dc5]
  6: (()+0xcb166) [0x7fd89c9b4166]
  7: (()+0xcb193) [0x7fd89c9b4193]
  8: (()+0xcb28e) [0x7fd89c9b428e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x940) [0x78af20]
  10: /usr/bin/ceph-osd() [0x51a07d]
  11: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c5a]
  12: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2e4) [0x684374]
  13: (ThreadPool::worker()+0xbb7) [0x7bc087]
  14: (ThreadPool::WorkThread::entry()+0xd) [0x5f144d]
  15: (()+0x68ca) [0x7fd89db3a8ca]
  16: (clone()+0x6d) [0x7fd89c1bec0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
      0> 2012-06-16 15:31:32.531567 7fd8935c4700 -1 *** Caught signal 
(Aborted) **
  in thread 7fd8935c4700

  ceph version  (commit:)
  1: /usr/bin/ceph-osd() [0x70e4b9]
  2: (()+0xeff0) [0x7fd89db42ff0]
  3: (gsignal()+0x35) [0x7fd89c121225]
  4: (abort()+0x180) [0x7fd89c124030]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd89c9b5dc5]
  6: (()+0xcb166) [0x7fd89c9b4166]
  7: (()+0xcb193) [0x7fd89c9b4193]
  8: (()+0xcb28e) [0x7fd89c9b428e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x940) [0x78af20]
  10: /usr/bin/ceph-osd() [0x51a07d]
  11: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c5a]
  12: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2e4) [0x684374]
  13: (ThreadPool::worker()+0xbb7) [0x7bc087]
  14: (ThreadPool::WorkThread::entry()+0xd) [0x5f144d]
  15: (()+0x68ca) [0x7fd89db3a8ca]
  16: (clone()+0x6d) [0x7fd89c1bec0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- end dump of recent events ---

Am 16.06.2012 14:57, schrieb Stefan Priebe:
> Hi,
>
> today i got another osd crash ;-( Strangely the osd logs are all empty.
> It seems the logrotate hasn't reloaded the daemons but i still have the
> core dump file? What's next?
>
> Stefan
>

