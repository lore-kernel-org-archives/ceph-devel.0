From: Martin Mailand <martin@tuxadero.com>
Subject: ./include/interval_set.h: 295: FAILED assert(!empty())
Date: Tue, 06 Dec 2011 21:16:02 +0100
Message-ID: <4EDE7802.4030406@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:47289 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab1LFUQF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 15:16:05 -0500
Received: from [192.168.1.106] (e178240056.adsl.alicedsl.de [85.178.240.56])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pB6KG2gt017839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 6 Dec 2011 21:16:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
shortly after changing the crushmap I got this assertion.

./include/interval_set.h: In function 'T interval_set<T>::range_end() 
const [with T = long unsigned int]', in thread '7fd31e3f1700'
./include/interval_set.h: 295: FAILED assert(!empty())
  ceph version 0.39-37-g54758ab 
(commit:54758abccf429122c1bc3bce6d01bc33f1cfe238)
  1: /usr/bin/ceph-osd() [0x515203]
  2: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x2a16) [0x4f92f6]
  3: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x1ab) [0x4fa06b]
  4: (OSD::dequeue_op(PG*)+0x38d) [0x56334d]
  5: (ThreadPool::worker()+0x6e6) [0x5d0016]
  6: (ThreadPool::WorkThread::entry()+0xd) [0x5821dd]
  7: (()+0x6d8c) [0x7fd32d1cfd8c]
  8: (clone()+0x6d) [0x7fd32b80c04d]
  ceph version 0.39-37-g54758ab 
(commit:54758abccf429122c1bc3bce6d01bc33f1cfe238)
  1: /usr/bin/ceph-osd() [0x515203]
  2: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x2a16) [0x4f92f6]
  3: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x1ab) [0x4fa06b]
  4: (OSD::dequeue_op(PG*)+0x38d) [0x56334d]
  5: (ThreadPool::worker()+0x6e6) [0x5d0016]
  6: (ThreadPool::WorkThread::entry()+0xd) [0x5821dd]
  7: (()+0x6d8c) [0x7fd32d1cfd8c]
  8: (clone()+0x6d) [0x7fd32b80c04d]
*** Caught signal (Aborted) **
  in thread 7fd31e3f1700
  ceph version 0.39-37-g54758ab 
(commit:54758abccf429122c1bc3bce6d01bc33f1cfe238)
  1: /usr/bin/ceph-osd() [0x5a7e92]
  2: (()+0xfc60) [0x7fd32d1d8c60]
  3: (gsignal()+0x35) [0x7fd32b759d05]
  4: (abort()+0x186) [0x7fd32b75dab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fd32c0106dd]
  6: (()+0xb9926) [0x7fd32c00e926]
  7: (()+0xb9953) [0x7fd32c00e953]
  8: (()+0xb9a5e) [0x7fd32c00ea5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x396) [0x5cdcd6]
  10: /usr/bin/ceph-osd() [0x515203]
  11: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x2a16) [0x4f92f6]
  12: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x1ab) [0x4fa06b]
  13: (OSD::dequeue_op(PG*)+0x38d) [0x56334d]
  14: (ThreadPool::worker()+0x6e6) [0x5d0016]
  15: (ThreadPool::WorkThread::entry()+0xd) [0x5821dd]
  16: (()+0x6d8c) [0x7fd32d1cfd8c]
  17: (clone()+0x6d) [0x7fd32b80c04d]

-martin
