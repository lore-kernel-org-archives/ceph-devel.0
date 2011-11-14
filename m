From: Martin Mailand <martin@tuxadero.com>
Subject: osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
Date: Mon, 14 Nov 2011 15:04:34 +0100
Message-ID: <4EC11FF2.1030109@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:45206 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1KNOEg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 09:04:36 -0500
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAEE4YdB031507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 15:04:35 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
today one of my ods died, the log is.

sd/OSD.cc: In function 'void OSD::dequeue_op(PG*)', in thread '7faeb6139700'
osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
  1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
  2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
  3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
  4: (()+0x6d8c) [0x7faec4d12d8c]
  5: (clone()+0x6d) [0x7faec355404d]
  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
  1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
  2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
  3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
  4: (()+0x6d8c) [0x7faec4d12d8c]
  5: (clone()+0x6d) [0x7faec355404d]
*** Caught signal (Aborted) **
  in thread 7faeb6139700
  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
  1: /usr/bin/ceph-osd() [0x5b8b52]
  2: (()+0xfc60) [0x7faec4d1bc60]
  3: (gsignal()+0x35) [0x7faec34a1d05]
  4: (abort()+0x186) [0x7faec34a5ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7faec3d586dd]
  6: (()+0xb9926) [0x7faec3d56926]
  7: (()+0xb9953) [0x7faec3d56953]
  8: (()+0xb9a5e) [0x7faec3d56a5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x396) [0x5bddb6]
  10: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
  11: (ThreadPool::worker()+0x6e6) [0x5b7b16]
  12: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
  13: (()+0x6d8c) [0x7faec4d12d8c]
  14: (clone()+0x6d) [0x7faec355404d]

Anything else needed to debug this?

-martin
