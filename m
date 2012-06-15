From: Stefan Priebe <s.priebe@profihost.ag>
Subject: osd dies / crahes directly after mkcephfs
Date: Fri, 15 Jun 2012 23:22:20 +0200
Message-ID: <4FDBA78C.4050401@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070301070500060706030506"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45970 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2FOVWT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 17:22:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070301070500060706030506
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

i've seen several osd crashes on one of my machines directly after 
creating the ceph fs.

Attached is the osd log. I also have a core dump file. Do you need it?

Stefan

--------------070301070500060706030506
Content-Type: text/plain; charset=windows-1252;
 name="ceph-osd.13.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-osd.13.log"

2012-06-15 23:02:43.208835 7f683338c780  1 filestore(/srv/osd.13) mkfs in /srv/osd.13
2012-06-15 23:02:43.208891 7f683338c780  1 filestore(/srv/osd.13) mkfs generated fsid 94066f35-1048-469c-adc2-fbf87f6a77cc
2012-06-15 23:02:43.213411 7f683338c780  1 filestore(/srv/osd.13) leveldb db exists/created
2012-06-15 23:02:43.213454 7f683338c780 -1 journal FileJournal::_open: unable to open journal: open() failed: (2) No such file or directory
2012-06-15 23:02:43.773095 7f683338c780  1 journal _open /journal/osd.13.journal fd 10: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
2012-06-15 23:02:43.773158 7f683338c780  0 filestore(/srv/osd.13) mkjournal created journal on /journal/osd.13.journal
2012-06-15 23:02:43.773175 7f683338c780  1 filestore(/srv/osd.13) mkfs done in /srv/osd.13
2012-06-15 23:02:43.824313 7f683338c780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is supported and appears to work
2012-06-15 23:02:43.824320 7f683338c780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-06-15 23:02:43.824581 7f683338c780  0 filestore(/srv/osd.13) mount did NOT detect btrfs
2012-06-15 23:02:43.865403 7f683338c780  0 filestore(/srv/osd.13) mount syncfs(2) syscall fully supported (by glibc and kernel)
2012-06-15 23:02:43.865516 7f683338c780  0 filestore(/srv/osd.13) mount found snaps <>
2012-06-15 23:02:43.867990 7f683338c780  0 filestore(/srv/osd.13) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2012-06-15 23:02:43.868146 7f683338c780  1 journal _open /journal/osd.13.journal fd 17: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
2012-06-15 23:02:43.868223 7f683338c780  1 journal _open /journal/osd.13.journal fd 17: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
2012-06-15 23:02:43.868589 7f683338c780 -1 filestore(/srv/osd.13) could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
2012-06-15 23:02:43.935230 7f683338c780  1 journal close /journal/osd.13.journal
2012-06-15 23:02:43.935564 7f683338c780 -1 created object store /srv/osd.13 journal /journal/osd.13.journal for osd.13 fsid 4b3747ba-e892-47c7-8219-fd9d7ba0dabb
2012-06-15 23:05:59.723008 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is supported and appears to work
2012-06-15 23:05:59.723043 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-06-15 23:05:59.723406 7f520ba39780  0 filestore(/srv/osd.13) mount did NOT detect btrfs
2012-06-15 23:05:59.764036 7f520ba39780  0 filestore(/srv/osd.13) mount syncfs(2) syscall fully supported (by glibc and kernel)
2012-06-15 23:05:59.764157 7f520ba39780  0 filestore(/srv/osd.13) mount found snaps <>
2012-06-15 23:07:15.272570 7f520ba39780  0 filestore(/srv/osd.13) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2012-06-15 23:07:15.272731 7f520ba39780  1 journal _open /journal/osd.13.journal fd 28: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
2012-06-15 23:07:15.272774 7f520ba39780  1 journal _open /journal/osd.13.journal fd 28: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
2012-06-15 23:09:30.074747 7f51f7e93700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.145371 7f51f7c91700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.151393 7f51f778c700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.155450 7f51f7489700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.157220 7f51f7186700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.164053 7f51f6c81700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.167753 7f51f677c700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.168746 7f51f6479700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:09:30.169257 7f51f6277700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-06-15 23:10:34.674674 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:34.674705 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:10:39.674850 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:39.674869 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:10:44.675015 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:44.675038 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:10:49.675192 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:49.675212 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:10:54.675350 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:54.675371 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:10:59.675516 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:10:59.675535 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:04.675650 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:04.675670 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:09.675842 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:09.675863 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:14.675978 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:14.675998 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:19.676113 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:19.676133 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:24.676312 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:24.676334 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:29.676479 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:29.676498 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:34.676638 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:34.676662 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:39.676803 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:39.676830 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:44.676973 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:44.676997 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:49.677146 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:49.677175 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:54.677285 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:54.677314 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:11:59.677468 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:11:59.677494 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:04.677572 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:04.677603 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:09.677687 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:09.677714 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:14.677789 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:14.677818 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:19.677942 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:19.677971 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:24.678074 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:24.678103 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:29.678274 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:29.678302 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
2012-06-15 23:12:34.678415 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
2012-06-15 23:12:34.678447 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had suicide timed out after 180
2012-06-15 23:12:34.680198 7f52047ad700 -1 common/HeartbeatMap.cc: In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, time_t)' thread 7f52047ad700 time 2012-06-15 23:12:34.678486
common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")

 ceph version  (commit:)
 1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, long)+0x270) [0x74eb70]
 2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x74ed87]
 3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74efd8]
 4: (CephContextServiceThread::entry()+0x5c) [0x72365c]
 5: (()+0x68ca) [0x7f520b41b8ca]
 6: (clone()+0x6d) [0x7f5209a9fc0d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
   -77> 2012-06-15 23:05:59.498647 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is supported and appears to work
   -76> 2012-06-15 23:05:59.498709 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
   -75> 2012-06-15 23:05:59.499168 7f520ba39780  0 filestore(/srv/osd.13) mount did NOT detect btrfs
   -74> 2012-06-15 23:05:59.653853 7f520ba39780  0 filestore(/srv/osd.13) mount syncfs(2) syscall fully supported (by glibc and kernel)
   -73> 2012-06-15 23:05:59.653968 7f520ba39780  0 filestore(/srv/osd.13) mount found snaps <>
   -72> 2012-06-15 23:05:59.663878 7f520ba39780  0 filestore(/srv/osd.13) mount: enabling WRITEAHEAD journal mode: btrfs not detected
   -71> 2012-06-15 23:05:59.664106 7f520ba39780  1 journal _open /journal/osd.13.journal fd 12: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
   -70> 2012-06-15 23:05:59.664230 7f520ba39780  1 journal _open /journal/osd.13.journal fd 12: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
   -69> 2012-06-15 23:05:59.664798 7f520ba39780  1 journal close /journal/osd.13.journal
   -68> 2012-06-15 23:05:59.665660 7f520ba39780  0 ceph version  (commit:), process ceph-osd, pid 8703
   -67> 2012-06-15 23:05:59.723008 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is supported and appears to work
   -66> 2012-06-15 23:05:59.723043 7f520ba39780  0 filestore(/srv/osd.13) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
   -65> 2012-06-15 23:05:59.723406 7f520ba39780  0 filestore(/srv/osd.13) mount did NOT detect btrfs
   -64> 2012-06-15 23:05:59.764036 7f520ba39780  0 filestore(/srv/osd.13) mount syncfs(2) syscall fully supported (by glibc and kernel)
   -63> 2012-06-15 23:05:59.764157 7f520ba39780  0 filestore(/srv/osd.13) mount found snaps <>
   -62> 2012-06-15 23:07:15.272570 7f520ba39780  0 filestore(/srv/osd.13) mount: enabling WRITEAHEAD journal mode: btrfs not detected
   -61> 2012-06-15 23:07:15.272731 7f520ba39780  1 journal _open /journal/osd.13.journal fd 28: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
   -60> 2012-06-15 23:07:15.272774 7f520ba39780  1 journal _open /journal/osd.13.journal fd 28: 2097152000 bytes, block size 4096 bytes, directio = 0, aio = 0
   -59> 2012-06-15 23:09:30.074747 7f51f7e93700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -58> 2012-06-15 23:09:30.145371 7f51f7c91700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -57> 2012-06-15 23:09:30.151393 7f51f778c700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -56> 2012-06-15 23:09:30.155450 7f51f7489700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -55> 2012-06-15 23:09:30.157220 7f51f7186700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -54> 2012-06-15 23:09:30.164053 7f51f6c81700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -53> 2012-06-15 23:09:30.167753 7f51f677c700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -52> 2012-06-15 23:09:30.168746 7f51f6479700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -51> 2012-06-15 23:09:30.169257 7f51f6277700  1 CephxAuthorizeHandler::verify_authorizer isvalid=1
   -50> 2012-06-15 23:10:34.674674 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -49> 2012-06-15 23:10:34.674705 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -48> 2012-06-15 23:10:39.674850 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -47> 2012-06-15 23:10:39.674869 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -46> 2012-06-15 23:10:44.675015 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -45> 2012-06-15 23:10:44.675038 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -44> 2012-06-15 23:10:49.675192 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -43> 2012-06-15 23:10:49.675212 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -42> 2012-06-15 23:10:54.675350 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -41> 2012-06-15 23:10:54.675371 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -40> 2012-06-15 23:10:59.675516 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -39> 2012-06-15 23:10:59.675535 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -38> 2012-06-15 23:11:04.675650 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -37> 2012-06-15 23:11:04.675670 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -36> 2012-06-15 23:11:09.675842 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -35> 2012-06-15 23:11:09.675863 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -34> 2012-06-15 23:11:14.675978 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -33> 2012-06-15 23:11:14.675998 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -32> 2012-06-15 23:11:19.676113 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -31> 2012-06-15 23:11:19.676133 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -30> 2012-06-15 23:11:24.676312 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -29> 2012-06-15 23:11:24.676334 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -28> 2012-06-15 23:11:29.676479 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -27> 2012-06-15 23:11:29.676498 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -26> 2012-06-15 23:11:34.676638 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -25> 2012-06-15 23:11:34.676662 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -24> 2012-06-15 23:11:39.676803 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -23> 2012-06-15 23:11:39.676830 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -22> 2012-06-15 23:11:44.676973 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -21> 2012-06-15 23:11:44.676997 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -20> 2012-06-15 23:11:49.677146 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -19> 2012-06-15 23:11:49.677175 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -18> 2012-06-15 23:11:54.677285 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -17> 2012-06-15 23:11:54.677314 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -16> 2012-06-15 23:11:59.677468 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -15> 2012-06-15 23:11:59.677494 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -14> 2012-06-15 23:12:04.677572 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -13> 2012-06-15 23:12:04.677603 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -12> 2012-06-15 23:12:09.677687 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
   -11> 2012-06-15 23:12:09.677714 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
   -10> 2012-06-15 23:12:14.677789 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
    -9> 2012-06-15 23:12:14.677818 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
    -8> 2012-06-15 23:12:19.677942 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
    -7> 2012-06-15 23:12:19.677971 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
    -6> 2012-06-15 23:12:24.678074 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
    -5> 2012-06-15 23:12:24.678103 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
    -4> 2012-06-15 23:12:29.678274 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
    -3> 2012-06-15 23:12:29.678302 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f5200fa6700' had timed out after 60
    -2> 2012-06-15 23:12:34.678415 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had timed out after 60
    -1> 2012-06-15 23:12:34.678447 7f52047ad700  1 heartbeat_map is_healthy 'FileStore::op_tp thread 0x7f52007a5700' had suicide timed out after 180
     0> 2012-06-15 23:12:34.680198 7f52047ad700 -1 common/HeartbeatMap.cc: In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, time_t)' thread 7f52047ad700 time 2012-06-15 23:12:34.678486
common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")

 ceph version  (commit:)
 1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, long)+0x270) [0x74eb70]
 2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x74ed87]
 3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74efd8]
 4: (CephContextServiceThread::entry()+0x5c) [0x72365c]
 5: (()+0x68ca) [0x7f520b41b8ca]
 6: (clone()+0x6d) [0x7f5209a9fc0d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- end dump of recent events ---
2012-06-15 23:12:34.683038 7f52047ad700 -1 *** Caught signal (Aborted) **
 in thread 7f52047ad700

 ceph version  (commit:)
 1: /usr/bin/ceph-osd() [0x70e4b9]
 2: (()+0xeff0) [0x7f520b423ff0]
 3: (gsignal()+0x35) [0x7f5209a02225]
 4: (abort()+0x180) [0x7f5209a05030]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f520a296dc5]
 6: (()+0xcb166) [0x7f520a295166]
 7: (()+0xcb193) [0x7f520a295193]
 8: (()+0xcb28e) [0x7f520a29528e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940) [0x78af20]
 10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, long)+0x270) [0x74eb70]
 11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x74ed87]
 12: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74efd8]
 13: (CephContextServiceThread::entry()+0x5c) [0x72365c]
 14: (()+0x68ca) [0x7f520b41b8ca]
 15: (clone()+0x6d) [0x7f5209a9fc0d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
     0> 2012-06-15 23:12:34.683038 7f52047ad700 -1 *** Caught signal (Aborted) **
 in thread 7f52047ad700

 ceph version  (commit:)
 1: /usr/bin/ceph-osd() [0x70e4b9]
 2: (()+0xeff0) [0x7f520b423ff0]
 3: (gsignal()+0x35) [0x7f5209a02225]
 4: (abort()+0x180) [0x7f5209a05030]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f520a296dc5]
 6: (()+0xcb166) [0x7f520a295166]
 7: (()+0xcb193) [0x7f520a295193]
 8: (()+0xcb28e) [0x7f520a29528e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940) [0x78af20]
 10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, long)+0x270) [0x74eb70]
 11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x74ed87]
 12: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74efd8]
 13: (CephContextServiceThread::entry()+0x5c) [0x72365c]
 14: (()+0x68ca) [0x7f520b41b8ca]
 15: (clone()+0x6d) [0x7f5209a9fc0d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- end dump of recent events ---

--------------070301070500060706030506--
