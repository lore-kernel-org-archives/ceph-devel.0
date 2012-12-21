From: <Eric_YH_Chen@wiwynn.com>
Subject: Monitor crash
Date: Fri, 21 Dec 2012 05:38:29 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA111AA9@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:55427 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2LUFnh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Dec 2012 00:43:37 -0500
Received: from GDC-CLDCAS-P03.whq.wistron (unverified [10.37.38.64]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta8ca1afcc8c0a81672144c@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Fri, 21 Dec 2012 13:41:12 +0800
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kelvin_Huang@wiwynn.com

Hi All:

I met this crash once. You can download the full log here.
https://dl.dropbox.com/u/35107741/ceph-mon.log

ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
 1: /usr/bin/ceph-mon() [0x52569a]
 2: (()+0xfcb0) [0x7ffad0949cb0]
 3: (gsignal()+0x35) [0x7ffacf725425]
 4: (abort()+0x17b) [0x7ffacf728b8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7ffad007769d]
 6: (()+0xb5846) [0x7ffad0075846]
 7: (()+0xb5873) [0x7ffad0075873]
 8: (()+0xb596e) [0x7ffad007596e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x5deb9e]
 10: (PaxosService::propose_pending()+0x2e1) [0x4965b1]
 11: (SafeTimer::timer_thread()+0x407) [0x5d6897]
 12: (SafeTimerThread::entry()+0xd) [0x5d740d]
 13: (()+0x7e9a) [0x7ffad0941e9a]
 14: (clone()+0x6d) [0x7ffacf7e2cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
