From: Christian Brunner <chb@muc.de>
Subject: FAILED assert(!missing.is_missing(soid))
Date: Thu, 9 Dec 2010 20:49:06 +0100
Message-ID: <AANLkTin3eipR98c4B+g=bsGmTn4p3ncWpQ=N8y1uEx-W@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:53517 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0LITtH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Dec 2010 14:49:07 -0500
Received: by iwn40 with SMTP id 40so3961105iwn.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Dec 2010 11:49:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

while doing further stress testing one of our osds died with an assert:

osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_modify(MOSDSubOp*)':
osd/ReplicatedPG.cc:2528: FAILED assert(!missing.is_missing(soid))
ceph version 0.24~rc (commit:)
 1: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0xd08) [0x488358]
 2: (OSD::dequeue_op(PG*)+0x374) [0x4cc284]
 3: (ThreadPool::worker()+0x28f) [0x5bd04f]
 4: (ThreadPool::WorkThread::entry()+0xd) [0x4f4a1d]
 5: (Thread::_entry_func(void*)+0x7) [0x4723c7]
 6: (()+0x77e1) [0x7fb5e37327e1]
 7: (clone()+0x6d) [0x7fb5e275253d]

The rc-version we are using is from Dec 3rd (approximately).

I'm not sure if we can reproduce this, but if you need further debug
output we will try to.

Regards,
Christian
