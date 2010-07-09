From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: mds assert failed when stopping
Date: Fri, 9 Jul 2010 18:17:21 +0800
Message-ID: <AANLkTikxaP8dxopxUfloO6B4xSZ5AIspge_LXQugHzww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61520 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab0GIKRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 06:17:22 -0400
Received: by qyk38 with SMTP id 38so3144495qyk.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 03:17:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I got the following error while stopping an mds.

Steps:
1. Create the ceph cluster (with 2 mds; both active)
2. Mount the ceph cluster on /mnt/ceph and "tar zxvf
/path/to/ceph-0.19.1.tar.gz -C /mnt/ceph"
3. Check MDS logs and make sure that mds1 is auth for /mnt/ceph/ceph-0.19.1
4. ceph mds set_max_mds 1
5. ceph mds stop 1

mds1 assert failed while stopping. see below:

==========================================
mds/journal.cc: In function 'C_Gather* LogSegment::try_to_expire(MDS*)':
mds/journal.cc:160: FAILED assert(ls != this)
 1: (LogSegment::try_to_expire(MDS*)+0x11c1) [0x90a1df]
 2: (MDLog::try_expire(LogSegment*)+0x2d) [0x902c25]
 3: (MDLog::trim(int)+0x55b) [0x902b0b]
 4: (MDCache::shutdown_pass()+0xeb) [0x7d6aab]
 5: (MDS::_dispatch(Message*)+0x2dc1) [0x71597f]
 6: (MDS::ms_dispatch(Message*)+0x38) [0x712a44]
 7: (Messenger::ms_deliver_dispatch(Message*)+0x63) [0x6fe07b]
 8: (SimpleMessenger::dispatch_entry()+0x5fd) [0x6ef7e7]
 9: (SimpleMessenger::DispatchThread::entry()+0x2c) [0x6e44b8]
 10: (Thread::_entry_func(void*)+0x23) [0x6fd075]
 11: /lib64/libpthread.so.0() [0x3552e06a3a]
 12: (clone()+0x6d) [0x35526ddf3d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
============================================

Henry
