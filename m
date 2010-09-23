From: Stefan Majer <stefan.majer@gmail.com>
Subject: osd stops working with cep-0.21.3
Date: Thu, 23 Sep 2010 09:06:59 +0200
Message-ID: <AANLkTikzFomxEJNGjxpG+JDZtL-ZMpwh0OnyEa4VXRTf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46206 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0IWHHA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 03:07:00 -0400
Received: by qyk33 with SMTP id 33so1920376qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Sep 2010 00:07:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we saw on one of our OSDs (16 in total) the followin assert.

osd/OSD.cc: In function 'void OSD::start_recovery_op(PG*, const sobject_t&)':
osd/OSD.cc:4250: FAILED assert(recovery_oids.count(soid) == 0)
 1: (PG::start_recovery_op(sobject_t const&)+0x127) [0x525627]
 2: (ReplicatedPG::recover_object_replicas(sobject_t const&)+0x191) [0x482881]
 3: (ReplicatedPG::recover_replicas(int)+0x2db) [0x482ddb]
 4: (ReplicatedPG::start_recovery_ops(int)+0x92) [0x4832f2]
 5: (OSD::do_recovery(PG*)+0x1e3) [0x4b8cf3]
 6: (ThreadPool::worker()+0x291) [0x5ac5d1]
 7: (ThreadPool::WorkThread::entry()+0xd) [0x4ec93d]
 8: (Thread::_entry_func(void*)+0x7) [0x46eee7]
 9: (()+0x77e1) [0x7f952e6917e1]
 10: (clone()+0x6d) [0x7f952d8b551d]

Any hints to further nail down this problem.

Greetings

-- 
Stefan Majer
