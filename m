From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: ceph 0.48.1 osd die
Date: Tue, 21 Aug 2012 20:25:49 +0200
Message-ID: <CAMwB3Tig2ZTk5sbesUE_Q+DvZYEmNFNgQjDvYZLFEreL9YbP6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36442 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab2HUSZu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 14:25:50 -0400
Received: by qcro28 with SMTP id o28so88436qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 11:25:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ubuntu precise, ceph 0.48.1

After crush change, whole cluster reorganize, but one machine get very
hight load, and 4 OSD on this machine die with this in log.

After that i reboot machine, and re-init this OSD (i left one to
diagnose if needed), for full stability. Now everything is ok, but
maybe this will be useful.

--- begin dump of recent events ---
   -36> 2012-08-21 20:18:52.286460 7f4c5785a780  5 asok(0x1e4c000)
register_command perfcounters_dump hook 0x1e3f010
   -35> 2012-08-21 20:18:52.286490 7f4c5785a780  5 asok(0x1e4c000)
register_command 1 hook 0x1e3f010
   -34> 2012-08-21 20:18:52.286493 7f4c5785a780  5 asok(0x1e4c000)
register_command perf dump hook 0x1e3f010
   -33> 2012-08-21 20:18:52.286502 7f4c5785a780  5 asok(0x1e4c000)
register_command perfcounters_schema hook 0x1e3f010
   -32> 2012-08-21 20:18:52.286506 7f4c5785a780  5 asok(0x1e4c000)
register_command 2 hook 0x1e3f010
   -31> 2012-08-21 20:18:52.286508 7f4c5785a780  5 asok(0x1e4c000)
register_command perf schema hook 0x1e3f010
   -30> 2012-08-21 20:18:52.286514 7f4c5785a780  5 asok(0x1e4c000)
register_command config show hook 0x1e3f010
   -29> 2012-08-21 20:18:52.286533 7f4c5785a780  5 asok(0x1e4c000)
register_command config set hook 0x1e3f010
   -28> 2012-08-21 20:18:52.286536 7f4c5785a780  5 asok(0x1e4c000)
register_command log flush hook 0x1e3f010
   -27> 2012-08-21 20:18:52.286538 7f4c5785a780  5 asok(0x1e4c000)
register_command log dump hook 0x1e3f010
   -26> 2012-08-21 20:18:52.286541 7f4c5785a780  5 asok(0x1e4c000)
register_command log reopen hook 0x1e3f010
   -25> 2012-08-21 20:18:52.289243 7f4c5785a780  0 ceph version
0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c),
process ceph-osd, pid 24314
   -24> 2012-08-21 20:18:52.290166 7f4c5785a780  1 finished
global_init_daemonize
   -23> 2012-08-21 20:18:52.293285 7f4c5785a780  5 asok(0x1e4c000)
init /var/run/ceph/ceph-osd.30.asok
   -22> 2012-08-21 20:18:52.293343 7f4c5785a780  5 asok(0x1e4c000)
bind_and_listen /var/run/ceph/ceph-osd.30.asok
   -21> 2012-08-21 20:18:52.293377 7f4c5785a780  5 asok(0x1e4c000)
register_command 0 hook 0x1e3e0a0
   -20> 2012-08-21 20:18:52.293401 7f4c5785a780  5 asok(0x1e4c000)
register_command version hook 0x1e3e0a0
   -19> 2012-08-21 20:18:52.293405 7f4c5785a780  5 asok(0x1e4c000)
register_command git_version hook 0x1e3e0a0
   -18> 2012-08-21 20:18:52.293412 7f4c5785a780  5 asok(0x1e4c000)
register_command help hook 0x1e3f0c0
   -17> 2012-08-21 20:18:52.293504 7f4c53914700  5 asok(0x1e4c000) entr=
y start
   -16> 2012-08-21 20:18:52.296295 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount FIEMAP ioctl is supported and
appears to work
   -15> 2012-08-21 20:18:52.296310 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount FIEMAP ioctl is disabled via
'filestore fiemap' config option
   -14> 2012-08-21 20:18:52.296575 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount did NOT detect btrfs
   -13> 2012-08-21 20:18:52.341323 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount syncfs(2) syscall fully supported
(by glibc and kernel)
   -12> 2012-08-21 20:18:52.341448 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount found snaps <>
   -11> 2012-08-21 20:18:52.344103 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount: WRITEAHEAD journal mode explicitly
enabled in conf
   -10> 2012-08-21 20:18:52.520247 7f4c5110f700  1 FileStore::op_tp
worker finish
    -9> 2012-08-21 20:18:52.520325 7f4c5010d700  1 FileStore::op_tp
worker finish
    -8> 2012-08-21 20:18:52.520399 7f4c4f90c700  1 FileStore::op_tp
worker finish
    -7> 2012-08-21 20:18:52.520458 7f4c5090e700  1 FileStore::op_tp
worker finish
    -6> 2012-08-21 20:18:52.535297 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount FIEMAP ioctl is supported and
appears to work
    -5> 2012-08-21 20:18:52.535316 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount FIEMAP ioctl is disabled via
'filestore fiemap' config option
    -4> 2012-08-21 20:18:52.535704 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount did NOT detect btrfs
    -3> 2012-08-21 20:18:52.538389 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount syncfs(2) syscall fully supported
(by glibc and kernel)
    -2> 2012-08-21 20:18:52.538459 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount found snaps <>
    -1> 2012-08-21 20:18:52.540296 7f4c5785a780  0
filestore(/vol0/data/osd.30) mount: WRITEAHEAD journal mode explicitly
enabled in conf
     0> 2012-08-21 20:18:52.805875 7f4c5785a780 -1 *** Caught signal
(Aborted) **
 in thread 7f4c5785a780

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca=
6bba7c)
 1: /usr/bin/ceph-osd() [0x6edaba]
 2: (()+0xfcb0) [0x7f4c56cf7cb0]
 3: (gsignal()+0x35) [0x7f4c558d3445]
 4: (abort()+0x17b) [0x7f4c558d6bab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4c5622169d]
 6: (()+0xb5846) [0x7f4c5621f846]
 7: (()+0xb5873) [0x7f4c5621f873]
 8: (()+0xb596e) [0x7f4c5621f96e]
 9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x127) [0x=
7a94f7]
 10: (void decode<unsigned int, pg_interval_t>(std::map<unsigned int,
pg_interval_t, std::less<unsigned int>,
std::allocator<std::pair<unsigned int const, pg_interval_t> > >&,
ceph::buffer::list::iterator&)+0x2e) [0x58b66e]
 11: (PG::read_state(ObjectStore*)+0x33b) [0x62e56b]
 12: (OSD::load_pgs()+0x71f) [0x5d1b2f]
 13: (OSD::init()+0x585) [0x5d26a5]
 14: (main()+0x2377) [0x518067]
 15: (__libc_start_main()+0xed) [0x7f4c558be76d]
 16: /usr/bin/ceph-osd() [0x51a239]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- end dump of recent events ---

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
