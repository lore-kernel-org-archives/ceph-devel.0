From: Fyodor Ustinov <ufm@ufm.su>
Subject: OSD crash
Date: Fri, 27 May 2011 03:12:44 +0300
Message-ID: <4DDEEC7C.8060800@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:46635 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023Ab1E0AMr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 20:12:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 2257060048A
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 03:12:45 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pb0AFz9MUljh for <ceph-devel@vger.kernel.org>;
	Fri, 27 May 2011 03:12:45 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id B05C1600484
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 03:12:44 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

2011-05-27 02:35:22.046798 7fa8ff058700 journal check_for_full at 
837623808 : JOURNAL FULL 837623808 >= 147455 (max_size 996147200 start 
837771264)
2011-05-27 02:35:23.479379 7fa8f7f49700 journal throttle: waited for bytes
2011-05-27 02:35:34.730418 7fa8ff058700 journal check_for_full at 
836984832 : JOURNAL FULL 836984832 >= 638975 (max_size 996147200 start 
837623808)
2011-05-27 02:35:36.050384 7fa8f7f49700 journal throttle: waited for bytes
2011-05-27 02:35:47.226789 7fa8ff058700 journal check_for_full at 
836882432 : JOURNAL FULL 836882432 >= 102399 (max_size 996147200 start 
836984832)
2011-05-27 02:35:48.937259 7fa8f874a700 journal throttle: waited for bytes
2011-05-27 02:35:59.985040 7fa8ff058700 journal check_for_full at 
836685824 : JOURNAL FULL 836685824 >= 196607 (max_size 996147200 start 
836882432)
2011-05-27 02:36:01.654955 7fa8f874a700 journal throttle: waited for bytes
2011-05-27 02:36:12.362896 7fa8ff058700 journal check_for_full at 
835723264 : JOURNAL FULL 835723264 >= 962559 (max_size 996147200 start 
836685824)
2011-05-27 02:36:14.375435 7fa8f7f49700 journal throttle: waited for bytes
./include/xlist.h: In function 'void xlist<T>::remove(xlist<T>::item*) 
[with T = PG*]', in thread '0x7fa8f7748700'
./include/xlist.h: 107: FAILED assert(i->_list == this)
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  2: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  3: (ThreadPool::worker()+0x10a) [0x65799a]
  4: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  5: (()+0x6d8c) [0x7fa904294d8c]
  6: (clone()+0x6d) [0x7fa90314704d]
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  2: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  3: (ThreadPool::worker()+0x10a) [0x65799a]
  4: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  5: (()+0x6d8c) [0x7fa904294d8c]
  6: (clone()+0x6d) [0x7fa90314704d]
*** Caught signal (Aborted) **
  in thread 0x7fa8f7748700
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: /usr/bin/cosd() [0x6729f9]
  2: (()+0xfc60) [0x7fa90429dc60]
  3: (gsignal()+0x35) [0x7fa903094d05]
  4: (abort()+0x186) [0x7fa903098ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fa90394b6dd]
  6: (()+0xb9926) [0x7fa903949926]
  7: (()+0xb9953) [0x7fa903949953]
  8: (()+0xb9a5e) [0x7fa903949a5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x362) [0x655e32]
  10: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  11: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  12: (ThreadPool::worker()+0x10a) [0x65799a]
  13: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  14: (()+0x6d8c) [0x7fa904294d8c]
  15: (clone()+0x6d) [0x7fa90314704d]

WBR,
     Fyodor.
