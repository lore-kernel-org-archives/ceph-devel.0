From: Mark Nigh <mnigh@netelligent.com>
Subject: OSD Crash
Date: Wed, 11 May 2011 08:12:01 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C67886112A0F@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:35267 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751892Ab1EKPhG convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2011 11:37:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I was performing a few failure test with the osd by removing a HDD from one of the osd host. All was well, the cluster noticed the failure and re-balanced data but when I replace the HDD into the host, the cosd crashed.

Here is my setup. 6 osd host with 4 HDDs each (4 cosd daemons running for each host). 1 mon and 2 mds (separate host).

Here is the log from the osd0

2011-05-10 16:25:02.776151 7f9e16d36700 -- 10.6.1.92:6800/15566 >> 10.6.1.63:0/2322371038 pipe(0x4315a00 sd=14 pgs=0 cs=0 l=0).accept peer addr is really 10.6.1.63:0/2322371038 (socket is 10.6.1.63:42299/0)
os/FileStore.cc: In function 'unsigned int FileStore::_do_transaction(ObjectStore::Transaction&)', in thread '0x7f9e22577700'
os/FileStore.cc: 2120: FAILED assert(0 == "EIO handling not implemented")
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [0x5a0c84]
 2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [0x5a3536]
 3: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
 4: (ThreadPool::worker()+0x2a2) [0x626fa2]
 5: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
 6: (()+0x6d8c) [0x7f9e29434d8c]
 7: (clone()+0x6d) [0x7f9e2808204d]
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [0x5a0c84]
 2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [0x5a3536]
 3: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
 4: (ThreadPool::worker()+0x2a2) [0x626fa2]
 5: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
 6: (()+0x6d8c) [0x7f9e29434d8c]
 7: (clone()+0x6d) [0x7f9e2808204d]
os/FileStore.cc: In function 'unsigned int FileStore::_do_transaction(ObjectStore::Transaction&)', in thread '0x7f9e21d76700'
os/FileStore.cc: 2120: FAILED assert(0 == "EIO handling not implemented")
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [0x5a0c84]
 2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [0x5a3536]
 3: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
 4: (ThreadPool::worker()+0x2a2) [0x626fa2]
 5: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
 6: (()+0x6d8c) [0x7f9e29434d8c]
 7: (clone()+0x6d) [0x7f9e2808204d]
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [0x5a0c84]
 2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [0x5a3536]
 3: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
 4: (ThreadPool::worker()+0x2a2) [0x626fa2]
 5: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
 6: (()+0x6d8c) [0x7f9e29434d8c]
 7: (clone()+0x6d) [0x7f9e2808204d]
*** Caught signal (Aborted) **
 in thread 0x7f9e22577700
ceph version 0.27.commit: 793034c62c8e9ffab4af675ca97135fd1b193c9c. process: cosd. pid: 1414
2011-05-10 22:01:13.762083 7f0620492760 filestore(/mnt/osd0) mount FIEMAP ioctl is NOT supported
2011-05-10 22:01:13.762276 7f0620492760 filestore(/mnt/osd0) mount detected btrfs
2011-05-10 22:01:13.762288 7f0620492760 filestore(/mnt/osd0) mount btrfs CLONE_RANGE ioctl is supported
*** Caught signal (Terminated) **
 in thread 0x7f061e7b4700. Shutting down.

As you can see with the attached log, I try to restart the cosd at 22:01. The service is started but ceph -s doesn't include the osd.

Thanks for your help.

Mark Nigh
Systems Architect
Netelligent Corporation
mnigh@netelligent.com



This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
