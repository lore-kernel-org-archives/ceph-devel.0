From: Josh West <jsw@one.com>
Subject: Repeatable OSD crash on 0.61.1
Date: Mon, 13 May 2013 10:24:40 +0200
Message-ID: <5190A348.4030509@one.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010204070709050800000901"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kontorsmtp2.one.com ([195.47.247.17]:34777 "EHLO
	kontorsmtp2.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab3EMIcq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 04:32:46 -0400
Received: from [172.16.16.106] (unknown [46.30.211.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by kontorsmtp2.one.com (Postfix) with ESMTP id E266027C3B
	for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 10:24:40 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204070709050800000901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

I'm experiencing a crash of an OSD daemon, using Ceph 0.61.1 on Debian 
Wheezy.  It repeatably occurs ~7-10 seconds after OSD daemon startup.  I 
have the core dump available to anybody upon request; just tell me where 
to send it.

Attached is the osd daemon log.

If you need any more information please let me know.

Thanks.

-- 
Josh West
Lead Systems Administrator
One.com, jsw@one.com


--------------010204070709050800000901
Content-Type: text/plain; charset=UTF-8;
 name="ceph-20130513-osd45crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-20130513-osd45crash.txt"

2013-05-13 07:49:07.233047 7f6125946780  0 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-osd, pid 6424
2013-05-13 07:49:07.239371 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is supported and appears to work
2013-05-13 07:49:07.239391 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2013-05-13 07:49:07.239821 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount did NOT detect btrfs
2013-05-13 07:49:07.240822 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount syscall(SYS_syncfs, fd) fully supported
2013-05-13 07:49:07.240919 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount found snaps <>
2013-05-13 07:49:07.252946 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2013-05-13 07:49:07.286576 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
2013-05-13 07:49:07.286626 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 18: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
2013-05-13 07:49:08.009260 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (2) No such file or directory
2013-05-13 07:49:08.009294 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 18: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
2013-05-13 07:49:08.011071 7f6125946780  1 journal close /var/lib/ceph/osd/ceph-45/journal
2013-05-13 07:49:08.014964 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is supported and appears to work
2013-05-13 07:49:08.014972 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2013-05-13 07:49:08.015378 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount did NOT detect btrfs
2013-05-13 07:49:08.016282 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount syscall(SYS_syncfs, fd) fully supported
2013-05-13 07:49:08.016323 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount found snaps <>
2013-05-13 07:49:08.026707 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2013-05-13 07:49:08.049621 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
2013-05-13 07:49:08.049668 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 26: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
2013-05-13 07:49:08.067961 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
2013-05-13 07:49:08.067996 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 26: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
2013-05-13 07:49:14.959361 7f609d96d700 -1 osd/OSD.cc: In function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f609d96d700 time 2013-05-13 07:49:14.957770
osd/OSD.cc: 4838: FAILED assert(_get_map_bl(epoch, bl))

 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
 1: (OSDService::get_map(unsigned int)+0x44b) [0x6f4d9b]
 2: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x3c8) [0x6f6da8]
 3: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x31f) [0x6f75bf]
 4: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x14) [0x7382d4]
 5: (ThreadPool::worker(ThreadPool::WorkThread*)+0x68a) [0x8f52ea]
 6: (ThreadPool::WorkThread::entry()+0x10) [0x8f6590]
 7: (()+0x6b50) [0x7f612530eb50]
 8: (clone()+0x6d) [0x7f612384aa7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
  -262> 2013-05-13 07:49:07.231254 7f6125946780  5 asok(0x2090000) register_command perfcounters_dump hook 0x207c010
  -261> 2013-05-13 07:49:07.231288 7f6125946780  5 asok(0x2090000) register_command 1 hook 0x207c010
  -260> 2013-05-13 07:49:07.231296 7f6125946780  5 asok(0x2090000) register_command perf dump hook 0x207c010
  -259> 2013-05-13 07:49:07.231307 7f6125946780  5 asok(0x2090000) register_command perfcounters_schema hook 0x207c010
  -258> 2013-05-13 07:49:07.231312 7f6125946780  5 asok(0x2090000) register_command 2 hook 0x207c010
  -257> 2013-05-13 07:49:07.231315 7f6125946780  5 asok(0x2090000) register_command perf schema hook 0x207c010
  -256> 2013-05-13 07:49:07.231323 7f6125946780  5 asok(0x2090000) register_command config show hook 0x207c010
  -255> 2013-05-13 07:49:07.231328 7f6125946780  5 asok(0x2090000) register_command config set hook 0x207c010
  -254> 2013-05-13 07:49:07.231334 7f6125946780  5 asok(0x2090000) register_command log flush hook 0x207c010
  -253> 2013-05-13 07:49:07.231339 7f6125946780  5 asok(0x2090000) register_command log dump hook 0x207c010
  -252> 2013-05-13 07:49:07.231344 7f6125946780  5 asok(0x2090000) register_command log reopen hook 0x207c010
  -251> 2013-05-13 07:49:07.233047 7f6125946780  0 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-osd, pid 6424
  -250> 2013-05-13 07:49:07.233415 7f6125946780  1 -- 10.81.30.104:0/0 learned my addr 10.81.30.104:0/0
  -249> 2013-05-13 07:49:07.233427 7f6125946780  1 accepter.accepter.bind my_inst.addr is 10.81.30.104:6810/6424 need_addr=0
  -248> 2013-05-13 07:49:07.233443 7f6125946780  1 -- 10.81.158.104:0/0 learned my addr 10.81.158.104:0/0
  -247> 2013-05-13 07:49:07.233450 7f6125946780  1 accepter.accepter.bind my_inst.addr is 10.81.158.104:6808/6424 need_addr=0
  -246> 2013-05-13 07:49:07.233465 7f6125946780  1 -- 10.81.158.104:0/0 learned my addr 10.81.158.104:0/0
  -245> 2013-05-13 07:49:07.233472 7f6125946780  1 accepter.accepter.bind my_inst.addr is 10.81.158.104:6809/6424 need_addr=0
  -244> 2013-05-13 07:49:07.233841 7f6125946780  1 finished global_init_daemonize
  -243> 2013-05-13 07:49:07.236435 7f6125946780  5 asok(0x2090000) init /var/run/ceph/ceph-osd.45.asok
  -242> 2013-05-13 07:49:07.236457 7f6125946780  5 asok(0x2090000) bind_and_listen /var/run/ceph/ceph-osd.45.asok
  -241> 2013-05-13 07:49:07.236485 7f6125946780  5 asok(0x2090000) register_command 0 hook 0x207a0b8
  -240> 2013-05-13 07:49:07.236493 7f6125946780  5 asok(0x2090000) register_command version hook 0x207a0b8
  -239> 2013-05-13 07:49:07.236502 7f6125946780  5 asok(0x2090000) register_command git_version hook 0x207a0b8
  -238> 2013-05-13 07:49:07.236507 7f6125946780  5 asok(0x2090000) register_command help hook 0x207c0d0
  -237> 2013-05-13 07:49:07.236534 7f612158e700  5 asok(0x2090000) entry start
  -236> 2013-05-13 07:49:07.239371 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is supported and appears to work
  -235> 2013-05-13 07:49:07.239391 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
  -234> 2013-05-13 07:49:07.239821 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount did NOT detect btrfs
  -233> 2013-05-13 07:49:07.240822 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount syscall(SYS_syncfs, fd) fully supported
  -232> 2013-05-13 07:49:07.240919 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount found snaps <>
  -231> 2013-05-13 07:49:07.252946 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount: enabling WRITEAHEAD journal mode: btrfs not detected
  -230> 2013-05-13 07:49:07.285201 7f6125946780  2 journal open /var/lib/ceph/osd/ceph-45/journal fsid 73f8e233-53b3-45a5-86d1-3de8d8cba825 fs_op_seq 16765409
  -229> 2013-05-13 07:49:07.286576 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
  -228> 2013-05-13 07:49:07.286626 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 18: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
  -227> 2013-05-13 07:49:07.968817 7f6125946780  2 journal read_entry 7052476416 : seq 16765345 260 bytes
  -226> 2013-05-13 07:49:08.002394 7f6125946780  2 journal read_entry 7052480512 : seq 16765346 260 bytes
  -225> 2013-05-13 07:49:08.002453 7f6125946780  2 journal read_entry 7052484608 : seq 16765347 260 bytes
  -224> 2013-05-13 07:49:08.002463 7f6125946780  2 journal read_entry 7052488704 : seq 16765348 260 bytes
  -223> 2013-05-13 07:49:08.002472 7f6125946780  2 journal read_entry 7052492800 : seq 16765349 254 bytes
  -222> 2013-05-13 07:49:08.002572 7f6125946780  2 journal read_entry 7052496896 : seq 16765350 260 bytes
  -221> 2013-05-13 07:49:08.002581 7f6125946780  2 journal read_entry 7052500992 : seq 16765351 254 bytes
  -220> 2013-05-13 07:49:08.002590 7f6125946780  2 journal read_entry 7052505088 : seq 16765352 260 bytes
  -219> 2013-05-13 07:49:08.002615 7f6125946780  2 journal read_entry 7052509184 : seq 16765353 3777 bytes
  -218> 2013-05-13 07:49:08.002625 7f6125946780  2 journal read_entry 7052513280 : seq 16765354 260 bytes
  -217> 2013-05-13 07:49:08.002633 7f6125946780  2 journal read_entry 7052517376 : seq 16765355 260 bytes
  -216> 2013-05-13 07:49:08.002642 7f6125946780  2 journal read_entry 7052521472 : seq 16765356 260 bytes
  -215> 2013-05-13 07:49:08.002650 7f6125946780  2 journal read_entry 7052525568 : seq 16765357 260 bytes
  -214> 2013-05-13 07:49:08.002799 7f6125946780  2 journal read_entry 7052529664 : seq 16765358 260 bytes
  -213> 2013-05-13 07:49:08.002809 7f6125946780  2 journal read_entry 7052533760 : seq 16765359 254 bytes
  -212> 2013-05-13 07:49:08.002817 7f6125946780  2 journal read_entry 7052537856 : seq 16765360 260 bytes
  -211> 2013-05-13 07:49:08.002826 7f6125946780  2 journal read_entry 7052541952 : seq 16765361 260 bytes
  -210> 2013-05-13 07:49:08.002835 7f6125946780  2 journal read_entry 7052546048 : seq 16765362 254 bytes
  -209> 2013-05-13 07:49:08.002846 7f6125946780  2 journal read_entry 7052550144 : seq 16765363 260 bytes
  -208> 2013-05-13 07:49:08.002854 7f6125946780  2 journal read_entry 7052554240 : seq 16765364 260 bytes
  -207> 2013-05-13 07:49:08.002863 7f6125946780  2 journal read_entry 7052558336 : seq 16765365 260 bytes
  -206> 2013-05-13 07:49:08.002872 7f6125946780  2 journal read_entry 7052562432 : seq 16765366 260 bytes
  -205> 2013-05-13 07:49:08.002880 7f6125946780  2 journal read_entry 7052566528 : seq 16765367 260 bytes
  -204> 2013-05-13 07:49:08.002892 7f6125946780  2 journal read_entry 7052570624 : seq 16765368 260 bytes
  -203> 2013-05-13 07:49:08.002901 7f6125946780  2 journal read_entry 7052574720 : seq 16765369 260 bytes
  -202> 2013-05-13 07:49:08.002909 7f6125946780  2 journal read_entry 7052578816 : seq 16765370 254 bytes
  -201> 2013-05-13 07:49:08.002918 7f6125946780  2 journal read_entry 7052582912 : seq 16765371 260 bytes
  -200> 2013-05-13 07:49:08.002975 7f6125946780  2 journal read_entry 7052587008 : seq 16765372 260 bytes
  -199> 2013-05-13 07:49:08.002984 7f6125946780  2 journal read_entry 7052591104 : seq 16765373 260 bytes
  -198> 2013-05-13 07:49:08.003121 7f6125946780  2 journal read_entry 7052595200 : seq 16765374 260 bytes
  -197> 2013-05-13 07:49:08.003130 7f6125946780  2 journal read_entry 7052599296 : seq 16765375 260 bytes
  -196> 2013-05-13 07:49:08.003153 7f6125946780  2 journal read_entry 7052603392 : seq 16765376 260 bytes
  -195> 2013-05-13 07:49:08.003167 7f6125946780  2 journal read_entry 7052607488 : seq 16765377 254 bytes
  -194> 2013-05-13 07:49:08.003176 7f6125946780  2 journal read_entry 7052611584 : seq 16765378 260 bytes
  -193> 2013-05-13 07:49:08.003185 7f6125946780  2 journal read_entry 7052615680 : seq 16765379 254 bytes
  -192> 2013-05-13 07:49:08.003194 7f6125946780  2 journal read_entry 7052619776 : seq 16765380 260 bytes
  -191> 2013-05-13 07:49:08.003202 7f6125946780  2 journal read_entry 7052623872 : seq 16765381 260 bytes
  -190> 2013-05-13 07:49:08.003211 7f6125946780  2 journal read_entry 7052627968 : seq 16765382 260 bytes
  -189> 2013-05-13 07:49:08.003228 7f6125946780  2 journal read_entry 7052632064 : seq 16765383 260 bytes
  -188> 2013-05-13 07:49:08.003239 7f6125946780  2 journal read_entry 7052636160 : seq 16765384 260 bytes
  -187> 2013-05-13 07:49:08.003247 7f6125946780  2 journal read_entry 7052640256 : seq 16765385 260 bytes
  -186> 2013-05-13 07:49:08.003256 7f6125946780  2 journal read_entry 7052644352 : seq 16765386 260 bytes
  -185> 2013-05-13 07:49:08.003264 7f6125946780  2 journal read_entry 7052648448 : seq 16765387 260 bytes
  -184> 2013-05-13 07:49:08.003273 7f6125946780  2 journal read_entry 7052652544 : seq 16765388 260 bytes
  -183> 2013-05-13 07:49:08.003281 7f6125946780  2 journal read_entry 7052656640 : seq 16765389 260 bytes
  -182> 2013-05-13 07:49:08.003290 7f6125946780  2 journal read_entry 7052660736 : seq 16765390 260 bytes
  -181> 2013-05-13 07:49:08.003301 7f6125946780  2 journal read_entry 7052664832 : seq 16765391 260 bytes
  -180> 2013-05-13 07:49:08.003309 7f6125946780  2 journal read_entry 7052668928 : seq 16765392 260 bytes
  -179> 2013-05-13 07:49:08.003317 7f6125946780  2 journal read_entry 7052673024 : seq 16765393 260 bytes
  -178> 2013-05-13 07:49:08.003326 7f6125946780  2 journal read_entry 7052677120 : seq 16765394 254 bytes
  -177> 2013-05-13 07:49:08.003334 7f6125946780  2 journal read_entry 7052681216 : seq 16765395 260 bytes
  -176> 2013-05-13 07:49:08.003343 7f6125946780  2 journal read_entry 7052685312 : seq 16765396 260 bytes
  -175> 2013-05-13 07:49:08.003351 7f6125946780  2 journal read_entry 7052689408 : seq 16765397 260 bytes
  -174> 2013-05-13 07:49:08.003360 7f6125946780  2 journal read_entry 7052693504 : seq 16765398 260 bytes
  -173> 2013-05-13 07:49:08.003368 7f6125946780  2 journal read_entry 7052697600 : seq 16765399 260 bytes
  -172> 2013-05-13 07:49:08.003377 7f6125946780  2 journal read_entry 7052701696 : seq 16765400 260 bytes
  -171> 2013-05-13 07:49:08.003385 7f6125946780  2 journal read_entry 7052705792 : seq 16765401 260 bytes
  -170> 2013-05-13 07:49:08.003394 7f6125946780  2 journal read_entry 7052709888 : seq 16765402 260 bytes
  -169> 2013-05-13 07:49:08.003402 7f6125946780  2 journal read_entry 7052713984 : seq 16765403 260 bytes
  -168> 2013-05-13 07:49:08.003411 7f6125946780  2 journal read_entry 7052718080 : seq 16765404 70 bytes
  -167> 2013-05-13 07:49:08.003425 7f6125946780  2 journal read_entry 7052722176 : seq 16765405 3869 bytes
  -166> 2013-05-13 07:49:08.003578 7f6125946780  2 journal read_entry 7052726272 : seq 16765406 3845 bytes
  -165> 2013-05-13 07:49:08.003591 7f6125946780  2 journal read_entry 7052730368 : seq 16765407 3824 bytes
  -164> 2013-05-13 07:49:08.003604 7f6125946780  2 journal read_entry 7052734464 : seq 16765408 3830 bytes
  -163> 2013-05-13 07:49:08.003627 7f6125946780  2 journal read_entry 7052738560 : seq 16765409 1434 bytes
  -162> 2013-05-13 07:49:08.003636 7f6125946780  2 journal read_entry 7052742656 : seq 16765410 69 bytes
  -161> 2013-05-13 07:49:08.003651 7f6125946780  2 journal read_entry 7052742656 : seq 16765410 69 bytes
  -160> 2013-05-13 07:49:08.003657 7f6125946780  3 journal journal_replay: applying op seq 16765410
  -159> 2013-05-13 07:49:08.003702 7f6125946780  3 journal journal_replay: r = 0, op_seq now 16765410
  -158> 2013-05-13 07:49:08.003713 7f6125946780  2 journal No further valid entries found, journal is most likely valid
  -157> 2013-05-13 07:49:08.003722 7f6125946780  3 journal journal_replay: end of journal, done.
  -156> 2013-05-13 07:49:08.009260 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (2) No such file or directory
  -155> 2013-05-13 07:49:08.009294 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 18: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
  -154> 2013-05-13 07:49:08.010994 7f611df8e700  1 FileStore::op_tp worker finish
  -153> 2013-05-13 07:49:08.011014 7f611e78f700  1 FileStore::op_tp worker finish
  -152> 2013-05-13 07:49:08.011071 7f6125946780  1 journal close /var/lib/ceph/osd/ceph-45/journal
  -151> 2013-05-13 07:49:08.012044 7f6125946780 10 monclient(hunting): build_initial_monmap
  -150> 2013-05-13 07:49:08.012107 7f6125946780  5 adding auth protocol: cephx
  -149> 2013-05-13 07:49:08.012115 7f6125946780  5 adding auth protocol: cephx
  -148> 2013-05-13 07:49:08.012199 7f6125946780  1 -- 10.81.30.104:6810/6424 messenger.start
  -147> 2013-05-13 07:49:08.012222 7f6125946780  1 -- :/0 messenger.start
  -146> 2013-05-13 07:49:08.012240 7f6125946780  1 -- 10.81.158.104:6809/6424 messenger.start
  -145> 2013-05-13 07:49:08.012256 7f6125946780  1 -- 10.81.158.104:6808/6424 messenger.start
  -144> 2013-05-13 07:49:08.012360 7f6125946780  2 osd.45 0 mounting /var/lib/ceph/osd/ceph-45 /var/lib/ceph/osd/ceph-45/journal
  -143> 2013-05-13 07:49:08.014964 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is supported and appears to work
  -142> 2013-05-13 07:49:08.014972 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
  -141> 2013-05-13 07:49:08.015378 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount did NOT detect btrfs
  -140> 2013-05-13 07:49:08.016282 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount syscall(SYS_syncfs, fd) fully supported
  -139> 2013-05-13 07:49:08.016323 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount found snaps <>
  -138> 2013-05-13 07:49:08.026707 7f6125946780  0 filestore(/var/lib/ceph/osd/ceph-45) mount: enabling WRITEAHEAD journal mode: btrfs not detected
  -137> 2013-05-13 07:49:08.048193 7f6125946780  2 journal open /var/lib/ceph/osd/ceph-45/journal fsid 73f8e233-53b3-45a5-86d1-3de8d8cba825 fs_op_seq 16765410
  -136> 2013-05-13 07:49:08.049621 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
  -135> 2013-05-13 07:49:08.049668 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 26: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
  -134> 2013-05-13 07:49:08.060474 7f6125946780  2 journal read_entry 7052476416 : seq 16765345 260 bytes
  -133> 2013-05-13 07:49:08.060849 7f6125946780  2 journal read_entry 7052480512 : seq 16765346 260 bytes
  -132> 2013-05-13 07:49:08.060905 7f6125946780  2 journal read_entry 7052484608 : seq 16765347 260 bytes
  -131> 2013-05-13 07:49:08.060915 7f6125946780  2 journal read_entry 7052488704 : seq 16765348 260 bytes
  -130> 2013-05-13 07:49:08.060924 7f6125946780  2 journal read_entry 7052492800 : seq 16765349 254 bytes
  -129> 2013-05-13 07:49:08.061005 7f6125946780  2 journal read_entry 7052496896 : seq 16765350 260 bytes
  -128> 2013-05-13 07:49:08.061015 7f6125946780  2 journal read_entry 7052500992 : seq 16765351 254 bytes
  -127> 2013-05-13 07:49:08.061023 7f6125946780  2 journal read_entry 7052505088 : seq 16765352 260 bytes
  -126> 2013-05-13 07:49:08.061043 7f6125946780  2 journal read_entry 7052509184 : seq 16765353 3777 bytes
  -125> 2013-05-13 07:49:08.061053 7f6125946780  2 journal read_entry 7052513280 : seq 16765354 260 bytes
  -124> 2013-05-13 07:49:08.061062 7f6125946780  2 journal read_entry 7052517376 : seq 16765355 260 bytes
  -123> 2013-05-13 07:49:08.061070 7f6125946780  2 journal read_entry 7052521472 : seq 16765356 260 bytes
  -122> 2013-05-13 07:49:08.061079 7f6125946780  2 journal read_entry 7052525568 : seq 16765357 260 bytes
  -121> 2013-05-13 07:49:08.061220 7f6125946780  2 journal read_entry 7052529664 : seq 16765358 260 bytes
  -120> 2013-05-13 07:49:08.061229 7f6125946780  2 journal read_entry 7052533760 : seq 16765359 254 bytes
  -119> 2013-05-13 07:49:08.061238 7f6125946780  2 journal read_entry 7052537856 : seq 16765360 260 bytes
  -118> 2013-05-13 07:49:08.061259 7f6125946780  2 journal read_entry 7052541952 : seq 16765361 260 bytes
  -117> 2013-05-13 07:49:08.061268 7f6125946780  2 journal read_entry 7052546048 : seq 16765362 254 bytes
  -116> 2013-05-13 07:49:08.061279 7f6125946780  2 journal read_entry 7052550144 : seq 16765363 260 bytes
  -115> 2013-05-13 07:49:08.061287 7f6125946780  2 journal read_entry 7052554240 : seq 16765364 260 bytes
  -114> 2013-05-13 07:49:08.061296 7f6125946780  2 journal read_entry 7052558336 : seq 16765365 260 bytes
  -113> 2013-05-13 07:49:08.061305 7f6125946780  2 journal read_entry 7052562432 : seq 16765366 260 bytes
  -112> 2013-05-13 07:49:08.061313 7f6125946780  2 journal read_entry 7052566528 : seq 16765367 260 bytes
  -111> 2013-05-13 07:49:08.061326 7f6125946780  2 journal read_entry 7052570624 : seq 16765368 260 bytes
  -110> 2013-05-13 07:49:08.061336 7f6125946780  2 journal read_entry 7052574720 : seq 16765369 260 bytes
  -109> 2013-05-13 07:49:08.061346 7f6125946780  2 journal read_entry 7052578816 : seq 16765370 254 bytes
  -108> 2013-05-13 07:49:08.061356 7f6125946780  2 journal read_entry 7052582912 : seq 16765371 260 bytes
  -107> 2013-05-13 07:49:08.061366 7f6125946780  2 journal read_entry 7052587008 : seq 16765372 260 bytes
  -106> 2013-05-13 07:49:08.061375 7f6125946780  2 journal read_entry 7052591104 : seq 16765373 260 bytes
  -105> 2013-05-13 07:49:08.061519 7f6125946780  2 journal read_entry 7052595200 : seq 16765374 260 bytes
  -104> 2013-05-13 07:49:08.061529 7f6125946780  2 journal read_entry 7052599296 : seq 16765375 260 bytes
  -103> 2013-05-13 07:49:08.061538 7f6125946780  2 journal read_entry 7052603392 : seq 16765376 260 bytes
  -102> 2013-05-13 07:49:08.061552 7f6125946780  2 journal read_entry 7052607488 : seq 16765377 254 bytes
  -101> 2013-05-13 07:49:08.061583 7f6125946780  2 journal read_entry 7052611584 : seq 16765378 260 bytes
  -100> 2013-05-13 07:49:08.061593 7f6125946780  2 journal read_entry 7052615680 : seq 16765379 254 bytes
   -99> 2013-05-13 07:49:08.061601 7f6125946780  2 journal read_entry 7052619776 : seq 16765380 260 bytes
   -98> 2013-05-13 07:49:08.061610 7f6125946780  2 journal read_entry 7052623872 : seq 16765381 260 bytes
   -97> 2013-05-13 07:49:08.061619 7f6125946780  2 journal read_entry 7052627968 : seq 16765382 260 bytes
   -96> 2013-05-13 07:49:08.061718 7f6125946780  2 journal read_entry 7052632064 : seq 16765383 260 bytes
   -95> 2013-05-13 07:49:08.061727 7f6125946780  2 journal read_entry 7052636160 : seq 16765384 260 bytes
   -94> 2013-05-13 07:49:08.061736 7f6125946780  2 journal read_entry 7052640256 : seq 16765385 260 bytes
   -93> 2013-05-13 07:49:08.061744 7f6125946780  2 journal read_entry 7052644352 : seq 16765386 260 bytes
   -92> 2013-05-13 07:49:08.061753 7f6125946780  2 journal read_entry 7052648448 : seq 16765387 260 bytes
   -91> 2013-05-13 07:49:08.061761 7f6125946780  2 journal read_entry 7052652544 : seq 16765388 260 bytes
   -90> 2013-05-13 07:49:08.061771 7f6125946780  2 journal read_entry 7052656640 : seq 16765389 260 bytes
   -89> 2013-05-13 07:49:08.061779 7f6125946780  2 journal read_entry 7052660736 : seq 16765390 260 bytes
   -88> 2013-05-13 07:49:08.061790 7f6125946780  2 journal read_entry 7052664832 : seq 16765391 260 bytes
   -87> 2013-05-13 07:49:08.061799 7f6125946780  2 journal read_entry 7052668928 : seq 16765392 260 bytes
   -86> 2013-05-13 07:49:08.061807 7f6125946780  2 journal read_entry 7052673024 : seq 16765393 260 bytes
   -85> 2013-05-13 07:49:08.061816 7f6125946780  2 journal read_entry 7052677120 : seq 16765394 254 bytes
   -84> 2013-05-13 07:49:08.061825 7f6125946780  2 journal read_entry 7052681216 : seq 16765395 260 bytes
   -83> 2013-05-13 07:49:08.061833 7f6125946780  2 journal read_entry 7052685312 : seq 16765396 260 bytes
   -82> 2013-05-13 07:49:08.061842 7f6125946780  2 journal read_entry 7052689408 : seq 16765397 260 bytes
   -81> 2013-05-13 07:49:08.061850 7f6125946780  2 journal read_entry 7052693504 : seq 16765398 260 bytes
   -80> 2013-05-13 07:49:08.061859 7f6125946780  2 journal read_entry 7052697600 : seq 16765399 260 bytes
   -79> 2013-05-13 07:49:08.061877 7f6125946780  2 journal read_entry 7052701696 : seq 16765400 260 bytes
   -78> 2013-05-13 07:49:08.061885 7f6125946780  2 journal read_entry 7052705792 : seq 16765401 260 bytes
   -77> 2013-05-13 07:49:08.061894 7f6125946780  2 journal read_entry 7052709888 : seq 16765402 260 bytes
   -76> 2013-05-13 07:49:08.061902 7f6125946780  2 journal read_entry 7052713984 : seq 16765403 260 bytes
   -75> 2013-05-13 07:49:08.061911 7f6125946780  2 journal read_entry 7052718080 : seq 16765404 70 bytes
   -74> 2013-05-13 07:49:08.061925 7f6125946780  2 journal read_entry 7052722176 : seq 16765405 3869 bytes
   -73> 2013-05-13 07:49:08.062070 7f6125946780  2 journal read_entry 7052726272 : seq 16765406 3845 bytes
   -72> 2013-05-13 07:49:08.062083 7f6125946780  2 journal read_entry 7052730368 : seq 16765407 3824 bytes
   -71> 2013-05-13 07:49:08.062095 7f6125946780  2 journal read_entry 7052734464 : seq 16765408 3830 bytes
   -70> 2013-05-13 07:49:08.062115 7f6125946780  2 journal read_entry 7052738560 : seq 16765409 1434 bytes
   -69> 2013-05-13 07:49:08.062124 7f6125946780  2 journal read_entry 7052742656 : seq 16765410 69 bytes
   -68> 2013-05-13 07:49:08.062133 7f6125946780  2 journal No further valid entries found, journal is most likely valid
   -67> 2013-05-13 07:49:08.062143 7f6125946780  2 journal No further valid entries found, journal is most likely valid
   -66> 2013-05-13 07:49:08.062146 7f6125946780  3 journal journal_replay: end of journal, done.
   -65> 2013-05-13 07:49:08.067961 7f6125946780 -1 journal _check_disk_write_cache: fclose error: (61) No data available
   -64> 2013-05-13 07:49:08.067996 7f6125946780  1 journal _open /var/lib/ceph/osd/ceph-45/journal fd 26: 10486788096 bytes, block size 4096 bytes, directio = 1, aio = 1
   -63> 2013-05-13 07:49:08.068269 7f6125946780  2 osd.45 0 boot
   -62> 2013-05-13 07:49:14.951892 7f6125946780  2 osd.45 19267 superblock: i am osd.45
   -61> 2013-05-13 07:49:14.951969 7f6125946780  1 accepter.accepter.start
   -60> 2013-05-13 07:49:14.952035 7f6125946780  1 accepter.accepter.start
   -59> 2013-05-13 07:49:14.952099 7f6125946780  1 accepter.accepter.start
   -58> 2013-05-13 07:49:14.952129 7f6125946780 10 monclient(hunting): init
   -57> 2013-05-13 07:49:14.952138 7f6125946780  5 adding auth protocol: cephx
   -56> 2013-05-13 07:49:14.952141 7f6125946780 10 monclient(hunting): auth_supported 2 method cephx
   -55> 2013-05-13 07:49:14.952303 7f6125946780  2 auth: KeyRing::load: loaded key file /var/lib/ceph/osd/ceph-45/keyring
   -54> 2013-05-13 07:49:14.952523 7f6125946780  5 asok(0x2090000) register_command dump_ops_in_flight hook 0xc4cf770
   -53> 2013-05-13 07:49:14.952532 7f6125946780  5 asok(0x2090000) register_command dump_historic_ops hook 0xc4cf770
   -52> 2013-05-13 07:49:14.952536 7f6125946780  5 asok(0x2090000) register_command dump_op_pq_state hook 0xc4cf770
   -51> 2013-05-13 07:49:14.952542 7f6125946780  5 asok(0x2090000) register_command setomapval hook 0x39de460
   -50> 2013-05-13 07:49:14.952546 7f6125946780  5 asok(0x2090000) register_command rmomapkey hook 0x39de460
   -49> 2013-05-13 07:49:14.952550 7f6125946780  5 asok(0x2090000) register_command setomapheader hook 0x39de460
   -48> 2013-05-13 07:49:14.952554 7f6125946780  5 asok(0x2090000) register_command getomap hook 0x39de460
   -47> 2013-05-13 07:49:14.952558 7f6125946780  5 asok(0x2090000) register_command truncobj hook 0x39de460
   -46> 2013-05-13 07:49:14.952565 7f6125946780  5 asok(0x2090000) register_command injectdataerr hook 0x39de460
   -45> 2013-05-13 07:49:14.952568 7f6125946780  5 asok(0x2090000) register_command injectmdataerr hook 0x39de460
   -44> 2013-05-13 07:49:14.952581 7f609b969700  5 osd.45 19267 heartbeat: osd_stat(187 GB used, 3526 GB avail, 3713 GB total, peers []/[])
   -43> 2013-05-13 07:49:14.952638 7f6125946780 10 monclient(hunting): _reopen_session
   -42> 2013-05-13 07:49:14.952701 7f6125946780 10 monclient(hunting): _pick_new_mon picked mon.ceph1-cph1f11-mon1 con 0x20bb4a0 addr 10.81.30.11:6789/0
   -41> 2013-05-13 07:49:14.952716 7f6125946780 10 monclient(hunting): _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -40> 2013-05-13 07:49:14.952721 7f6125946780  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- auth(proto 0 27 bytes epoch 0) v1 -- ?+0 0x208eb40 con 0x20bb4a0
   -39> 2013-05-13 07:49:14.952734 7f6125946780 10 monclient(hunting): renew_subs
   -38> 2013-05-13 07:49:14.953590 7f60a2977700 10 monclient(hunting): renew_subs
   -37> 2013-05-13 07:49:14.954245 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 1 ==== mon_map v1 ==== 208+0+0 (2484705230 0 0) 0x215c3c0 con 0x20bb4a0
   -36> 2013-05-13 07:49:14.954264 7f60a2977700 10 monclient(hunting): handle_monmap mon_map v1
   -35> 2013-05-13 07:49:14.954271 7f60a2977700 10 monclient(hunting):  got monmap 1, mon.ceph1-cph1f11-mon1 is now rank 0
   -34> 2013-05-13 07:49:14.954275 7f60a2977700 10 monclient(hunting): dump:
epoch 1
fsid ab804c03-24c1-4532-9fad-f7c1a2606aa5
last_changed 0.000000
created 0.000000
0: 10.81.30.11:6789/0 mon.ceph1-cph1f11-mon1

   -33> 2013-05-13 07:49:14.954291 7f60a2977700  1 monclient(hunting): found mon.ceph1-cph1f11-mon1
   -32> 2013-05-13 07:49:14.954300 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ==== 33+0+0 (760704699 0 0) 0xc62c000 con 0x20bb4a0
   -31> 2013-05-13 07:49:14.954324 7f60a2977700 10 monclient: my global_id is 3193723
   -30> 2013-05-13 07:49:14.954496 7f60a2977700 10 monclient: _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -29> 2013-05-13 07:49:14.954502 7f60a2977700  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x208fb00 con 0x20bb4a0
   -28> 2013-05-13 07:49:14.955309 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ==== 206+0+0 (1405081643 0 0) 0xc62c400 con 0x20bb4a0
   -27> 2013-05-13 07:49:14.955413 7f60a2977700 10 monclient: _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -26> 2013-05-13 07:49:14.955420 7f60a2977700  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x208fd40 con 0x20bb4a0
   -25> 2013-05-13 07:49:14.956448 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ==== 393+0+0 (1681636399 0 0) 0xc62c200 con 0x20bb4a0
   -24> 2013-05-13 07:49:14.956523 7f60a2977700 10 monclient: _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -23> 2013-05-13 07:49:14.956530 7f60a2977700  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x226a1c0 con 0x20bb4a0
   -22> 2013-05-13 07:49:14.956552 7f60a2977700 10 monclient: _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -21> 2013-05-13 07:49:14.956557 7f60a2977700  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- mon_subscribe({monmap=0+,osd_pg_creates=0}) v2 -- ?+0 0x226a540 con 0x20bb4a0
   -20> 2013-05-13 07:49:14.956569 7f60a2977700 10 monclient: _check_auth_rotating renewing rotating keys (they expired before 2013-05-13 07:48:44.956569)
   -19> 2013-05-13 07:49:14.956578 7f60a2977700 10 monclient: _send_mon_message to mon.ceph1-cph1f11-mon1 at 10.81.30.11:6789/0
   -18> 2013-05-13 07:49:14.956588 7f60a2977700  1 -- 10.81.30.104:6810/6424 --> 10.81.30.11:6789/0 -- auth(proto 2 2 bytes epoch 0) v1 -- ?+0 0x208fb00 con 0x20bb4a0
   -17> 2013-05-13 07:49:14.956604 7f6125946780  5 monclient: authenticate success, global_id 3193723
   -16> 2013-05-13 07:49:14.956616 7f6125946780 10 monclient: wait_auth_rotating waiting (until 2013-05-13 07:49:44.956615)
   -15> 2013-05-13 07:49:14.957147 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 5 ==== mon_map v1 ==== 208+0+0 (2484705230 0 0) 0x215c780 con 0x20bb4a0
   -14> 2013-05-13 07:49:14.957165 7f60a2977700 10 monclient: handle_monmap mon_map v1
   -13> 2013-05-13 07:49:14.957175 7f60a2977700 10 monclient:  got monmap 1, mon.ceph1-cph1f11-mon1 is now rank 0
   -12> 2013-05-13 07:49:14.957179 7f60a2977700 10 monclient: dump:
epoch 1
fsid ab804c03-24c1-4532-9fad-f7c1a2606aa5
last_changed 0.000000
created 0.000000
0: 10.81.30.11:6789/0 mon.ceph1-cph1f11-mon1

   -11> 2013-05-13 07:49:14.957195 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (4046684742 0 0) 0x226a1c0 con 0x20bb4a0
   -10> 2013-05-13 07:49:14.957204 7f60a2977700 10 monclient: handle_subscribe_ack sent 2013-05-13 07:49:14.952735 renew after 2013-05-13 07:51:44.952735
    -9> 2013-05-13 07:49:14.957213 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 7 ==== mon_map v1 ==== 208+0+0 (2484705230 0 0) 0x215c5a0 con 0x20bb4a0
    -8> 2013-05-13 07:49:14.957223 7f60a2977700 10 monclient: handle_monmap mon_map v1
    -7> 2013-05-13 07:49:14.957226 7f60a2977700 10 monclient:  got monmap 1, mon.ceph1-cph1f11-mon1 is now rank 0
    -6> 2013-05-13 07:49:14.957230 7f60a2977700 10 monclient: dump:
epoch 1
fsid ab804c03-24c1-4532-9fad-f7c1a2606aa5
last_changed 0.000000
created 0.000000
0: 10.81.30.11:6789/0 mon.ceph1-cph1f11-mon1

    -5> 2013-05-13 07:49:14.957241 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 8 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (4046684742 0 0) 0x226a700 con 0x20bb4a0
    -4> 2013-05-13 07:49:14.957249 7f60a2977700 10 monclient: handle_subscribe_ack sent 0.000000, ignoring
    -3> 2013-05-13 07:49:14.957442 7f60a2977700  1 -- 10.81.30.104:6810/6424 <== mon.0 10.81.30.11:6789/0 9 ==== auth_reply(proto 2 0 Success) v1 ==== 194+0+0 (873629679 0 0) 0xc62c600 con 0x20bb4a0
    -2> 2013-05-13 07:49:14.957494 7f60a2977700 10 monclient: _check_auth_rotating have uptodate secrets (they expire after 2013-05-13 07:48:44.957494)
    -1> 2013-05-13 07:49:14.957507 7f6125946780 10 monclient: wait_auth_rotating done
     0> 2013-05-13 07:49:14.959361 7f609d96d700 -1 osd/OSD.cc: In function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f609d96d700 time 2013-05-13 07:49:14.957770
osd/OSD.cc: 4838: FAILED assert(_get_map_bl(epoch, bl))

 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
 1: (OSDService::get_map(unsigned int)+0x44b) [0x6f4d9b]
 2: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x3c8) [0x6f6da8]
 3: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x31f) [0x6f75bf]
 4: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x14) [0x7382d4]
 5: (ThreadPool::worker(ThreadPool::WorkThread*)+0x68a) [0x8f52ea]
 6: (ThreadPool::WorkThread::entry()+0x10) [0x8f6590]
 7: (()+0x6b50) [0x7f612530eb50]
 8: (clone()+0x6d) [0x7f612384aa7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.45.log
--- end dump of recent events ---
2013-05-13 07:49:14.963410 7f609d96d700 -1 *** Caught signal (Aborted) **
 in thread 7f609d96d700

 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
 1: /usr/bin/ceph-osd() [0x8539e2]
 2: (()+0xf030) [0x7f6125317030]
 3: (gsignal()+0x35) [0x7f61237a2475]
 4: (abort()+0x180) [0x7f61237a56f0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f612400589d]
 6: (()+0x63996) [0x7f6124003996]
 7: (()+0x639c3) [0x7f61240039c3]
 8: (()+0x63bee) [0x7f6124003bee]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x40a) [0x8fe79a]
 10: (OSDService::get_map(unsigned int)+0x44b) [0x6f4d9b]
 11: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x3c8) [0x6f6da8]
 12: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x31f) [0x6f75bf]
 13: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x14) [0x7382d4]
 14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x68a) [0x8f52ea]
 15: (ThreadPool::WorkThread::entry()+0x10) [0x8f6590]
 16: (()+0x6b50) [0x7f612530eb50]
 17: (clone()+0x6d) [0x7f612384aa7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
     0> 2013-05-13 07:49:14.963410 7f609d96d700 -1 *** Caught signal (Aborted) **
 in thread 7f609d96d700

 ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
 1: /usr/bin/ceph-osd() [0x8539e2]
 2: (()+0xf030) [0x7f6125317030]
 3: (gsignal()+0x35) [0x7f61237a2475]
 4: (abort()+0x180) [0x7f61237a56f0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f612400589d]
 6: (()+0x63996) [0x7f6124003996]
 7: (()+0x639c3) [0x7f61240039c3]
 8: (()+0x63bee) [0x7f6124003bee]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x40a) [0x8fe79a]
 10: (OSDService::get_map(unsigned int)+0x44b) [0x6f4d9b]
 11: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x3c8) [0x6f6da8]
 12: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x31f) [0x6f75bf]
 13: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x14) [0x7382d4]
 14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x68a) [0x8f52ea]
 15: (ThreadPool::WorkThread::entry()+0x10) [0x8f6590]
 16: (()+0x6b50) [0x7f612530eb50]
 17: (clone()+0x6d) [0x7f612384aa7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.45.log
--- end dump of recent events ---

--------------010204070709050800000901--
