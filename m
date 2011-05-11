From: Mark Nigh <mnigh@netelligent.com>
Subject: RE: OSD Crash
Date: Wed, 11 May 2011 15:47:24 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C67886112B1F@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:36008 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754829Ab1EKUr3 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2011 16:47:29 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Some additional testing shows that the underlying filesystem btrfs does fail thus the daemon appropriately fails.

The way I am simulating a failed HDD is by removing the HDD. The failure is working, but the problem is when I reinsert the HDD. I think I see the BTRFS filesystem recovery (btrfs filesystem show) and I can start the correct osd daemon that corresponds to the mount point but I do not see the osd come up and in (ceph -s). The log is limited to

 ceph version 0.27.commit: 793034c62c8e9ffab4af675ca97135fd1b193c9c. process: cosd. pid: 2702
2011-05-11 15:13:58.650515 7fc6a349d760 filestore(/mnt/osd2) mount FIEMAP ioctl is NOT supported
2011-05-11 15:13:58.650754 7fc6a349d760 filestore(/mnt/osd2) mount detected btrfs
2011-05-11 15:13:58.650768 7fc6a349d760 filestore(/mnt/osd2) mount btrfs CLONE_RANGE ioctl is supported

If I try to restart the osd daemon, it is unable to kill the process and repeats trying to kill it.

Is the underlying file system not recovery like I think? I guess removing and inserting the HDD isn't the correct way to simulate a dead HDD.? Show I following the process of removing the osd, initializing the osd data dir and then restart the osd daemon?

Thanks.

Mark Nigh
Systems Architect
Netelligent Corporation
mnigh@netelligent.com



-----Original Message-----
From: Mark Nigh
Sent: Wednesday, May 11, 2011 8:12 AM
To: 'ceph-devel@vger.kernel.org'
Subject: OSD Crash

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
