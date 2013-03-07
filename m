From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: librbd bug?
Date: Thu, 7 Mar 2013 11:16:50 +0100
Message-ID: <51386912.3020507@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:35103 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3CGKQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 05:16:52 -0500
Received: from ro.risc.uni.linz.ac.at (ro.risc.uni-linz.ac.at [193.170.32.23])
	by email.uni-linz.ac.at (Postfix) with ESMTP id 477C81E8C13
	for <ceph-devel@vger.kernel.org>; Thu,  7 Mar 2013 11:16:50 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've a libvirt-VM that gets format 2 rbd-childs 'fed' by the superhost.
It crashed recently with this in the logs:

osdc/ObjectCacher.cc: In function 'void
ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
tid_t, int)' thread 7f0cab5fd700 time 2013-03-01 22:02:37.374410
osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
 ceph version 0.56.3 (6eb7e15a4783b122e9b0c85ea9ba064145958aa5)
 1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned long,
unsigned long, int)+0xd68) [0x7f0d087cda28]
 2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f0d087d460b]
 3: (Context::complete(int)+0xa) [0x7f0d0878c9fa]
 4: (librbd::C_Request::finish(int)+0x85) [0x7f0d087bc325]
 5: (Context::complete(int)+0xa) [0x7f0d0878c9fa]
 6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f0d087a1387]
 7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f0d07b5834d]
 8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f0d07bc20d0]
 9: (()+0x7e9a) [0x7f0d0546be9a]
 10: (clone()+0x6d) [0x7f0d05198cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'

Any clue why that happened?

-- 
DI (FH) Wolfgang Hennerbichler
Software Development
Unit Advanced Computing Technologies
RISC Software GmbH
A company of the Johannes Kepler University Linz

IT-Center
Softwarepark 35
4232 Hagenberg
Austria

Phone: +43 7236 3343 245
Fax: +43 7236 3343 250
wolfgang.hennerbichler@risc-software.at
http://www.risc-software.at
