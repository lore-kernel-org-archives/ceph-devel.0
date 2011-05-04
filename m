From: ninad <ninadshaha@iitb.ac.in>
Subject: mon crash just after start
Date: Wed, 04 May 2011 16:30:07 +0530
Message-ID: <4DC131B7.2040001@iitb.ac.in>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010805040204020606000209"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:52808 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752808Ab1EDLHL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 May 2011 07:07:11 -0400
Received: from [10.100.116.95] (ninad.iitb.ac.in [10.100.116.95])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id B4A1113900
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2011 16:30:28 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010805040204020606000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All.

                 I am having a setup of 4 Machines all with fedora 13.  
mon & mds on 1 machine & 3 osd's. I am using btrfs file system. ceph 
version is 0.27 an kernel version is 2.6.37 on all machines.
                 When I start ceph service it stats normally without any 
error. but after that suddenly monitor daemon get crashed.  Monitor logs 
and ceph.conf is attached with this mail.

Please guide me to solve this problem.

Regards,
Ninad




--------------010805040204020606000209
Content-Type: text/plain;
 name="ceph.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph.conf"

[global]
    user = root
    ; where the mdses and osds keep their secret encryption keys
    keyring = /home/ceph/keyring.bin
    pid file = /var/run/ceph/$name.pid




; monitors
[mon]
    ;Directory for monitor files
    
    mon data = /home/ceph/$name
    mon lease wiggle room = 1 
    paxos observer timeout = 1
    debug mon = 15 

[mon.five]
    host = mon-mds
    mon addr = 10.200.120.65:6789



;Metadata
[mds]
    
    keyring = /home/ceph/keyring.$name
    
    debug ms = 1 
    debug mds = 10 
    debug mds balancer = 10
    debug mds log = 10
    debug mds_migrator = 10
    debug monc = 10

[mds.0]
    host = mon-mds




; OSDs
[osd]
    osd data = /export.osd$id
    osd journal = /dev/export/journal
    osd heartbeat grace = 30
    filestore journal writeahead = true
    journaler_allow_split_entries = true

    keyring = /home/ceph/keyring.$name
    
    debug osd = 10
    debug filestore = 10

[osd.0]
    host = osd1
    btrfs devs=/dev/export/osd1.p1 

[osd.1]
   host = osd2
   btrfs devs = /dev/export/osd2.p1 

[osd.2]
   host = osd3
   btrfs devs = /dev/export/osd3.p1 


--------------010805040204020606000209
Content-Type: text/plain;
 name="mon.0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mon.0.log"

ceph version 0.27.commit: 793034c62c8e9ffab4af675ca97135fd1b193c9c. process: cmon. pid: 3669
2011-05-04 16:11:25.287155 7f1573dc0720 store(/home/ceph/mon.five) mount
2011-05-04 16:11:25.287311 7f1573dc0720 store(/home/ceph/mon.five) get_bl magic = 21 bytes
2011-05-04 16:11:25.287574 7f1573dc0720 store(/home/ceph/mon.five) get_bl feature_set = 75 bytes
2011-05-04 16:11:25.287639 7f1573dc0720 store(/home/ceph/mon.five) get_bl monmap/latest = 198 bytes
2011-05-04 16:11:25.288910 7f1573dc0720 mon.five@0(starting) e1 init fsid 8a0373e7-aa3d-51b6-664d-b03d857a1b0c
2011-05-04 16:11:25.289057 7f1573dc0720 store(/home/ceph/mon.five) get_int pgmap/last_committed = 24
2011-05-04 16:11:25.289133 7f1573dc0720 store(/home/ceph/mon.five) get_int mdsmap/last_committed = 4
2011-05-04 16:11:25.289205 7f1573dc0720 store(/home/ceph/mon.five) get_int osdmap/last_committed = 6
2011-05-04 16:11:25.289280 7f1573dc0720 store(/home/ceph/mon.five) get_int logm/last_committed = 41
2011-05-04 16:11:25.289377 7f1573dc0720 store(/home/ceph/mon.five) get_int class/last_committed = 1
2011-05-04 16:11:25.289446 7f1573dc0720 store(/home/ceph/mon.five) get_int monmap/last_committed = 1
2011-05-04 16:11:25.289518 7f1573dc0720 store(/home/ceph/mon.five) get_int auth/last_committed = 3
2011-05-04 16:11:25.289580 7f1573dc0720 mon.five@0(starting).auth v3 AuthMonitor::init() paxosv=3
2011-05-04 16:11:25.289647 7f1573dc0720 store(/home/ceph/mon.five) get_bl auth/latest = 1225 bytes
2011-05-04 16:11:25.289685 7f1573dc0720 mon.five@0(starting).auth v3 AuthMonitor::init() startup: loading summary e3
2011-05-04 16:11:25.289809 7f1573dc0720 mon.five@0(starting).auth v3 AuthMonitor::update_from_paxos()
2011-05-04 16:11:25.289947 7f1573dc0720 mon.five@0(starting) e1 win_standalone_election
2011-05-04 16:11:25.289990 7f1573dc0720 mon.five@0(leader) e1 win_election, epoch 1 quorum is 0
2011-05-04 16:11:25.290050 7f1573dc0720 log [INF] : mon.five@0 won leader election with quorum 0
2011-05-04 16:11:25.290520 7f1573dc0720 store(/home/ceph/mon.five) get_bl pgmap/latest = 184756 bytes
2011-05-04 16:11:25.290566 7f1573dc0720 mon.five@0(leader).pg v0 update_from_paxos startup: got latest latest full pgmap v23
2011-05-04 16:11:25.293604 7f1573dc0720 store(/home/ceph/mon.five) get_bl pgmap/24 = 560 bytes
2011-05-04 16:11:25.293686 7f1573dc0720 mon.five@0(leader).pg v23 update_from_paxos  applying incremental 24
2011-05-04 16:11:25.293793 7f1573dc0720 mon.five@0(leader).pg v24 v24: 792 pgs: 792 active+clean; 24 KB data, 8984 KB used, 347 GB / 353 GB avail
2011-05-04 16:11:25.295277 7f1573dc0720 store(/home/ceph/mon.five) put_bl pgmap/latest = 184756 bytes
mon/MonitorStore.cc: In function 'int MonitorStore::write_bl_ss(ceph::bufferlist&, const char*, const char*, bool, bool)', in thread '0x7f1573dc0720'
mon/MonitorStore.cc: 349: FAILED assert(!err)
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (MonitorStore::write_bl_ss(ceph::buffer::list&, char const*, char const*, bool, bool)+0x309) [0x4f8589]
 2: (Paxos::stash_latest(unsigned long, ceph::buffer::list&)+0x158) [0x484fb8]
 3: (PGMonitor::update_from_paxos()+0x10a4) [0x4d0484]
 4: (PaxosService::_active()+0x36) [0x48e166]
 5: (Monitor::win_election(unsigned int, std::set<int, std::less<int>, std::allocator<int> >&)+0x2dc) [0x47278c]
 6: (Monitor::win_standalone_election()+0xef) [0x47290f]
 7: (Monitor::init()+0x310) [0x472c90]
 8: (main()+0x1fe7) [0x450fc7]
 9: (__libc_start_main()+0xfd) [0x39b8c1ec5d]
 10: /usr/bin/cmon() [0x44e5e9]
 ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c)
 1: (MonitorStore::write_bl_ss(ceph::buffer::list&, char const*, char const*, bool, bool)+0x309) [0x4f8589]
 2: (Paxos::stash_latest(unsigned long, ceph::buffer::list&)+0x158) [0x484fb8]
 3: (PGMonitor::update_from_paxos()+0x10a4) [0x4d0484]
 4: (PaxosService::_active()+0x36) [0x48e166]
 5: (Monitor::win_election(unsigned int, std::set<int, std::less<int>, std::allocator<int> >&)+0x2dc) [0x47278c]
 6: (Monitor::win_standalone_election()+0xef) [0x47290f]
 7: (Monitor::init()+0x310) [0x472c90]
 8: (main()+0x1fe7) [0x450fc7]
 9: (__libc_start_main()+0xfd) [0x39b8c1ec5d]
 10: /usr/bin/cmon() [0x44e5e9]
*** Caught signal (Aborted) **
 in thread 0x7f1573dc0720
*** Caught signal (Segmentation fault) **
 in thread 0x7f1573dc0720



--------------010805040204020606000209--
