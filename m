From: John Axel Eriksson <john@insane.se>
Subject: Possible filesystem corruption or something else?
Date: Sat, 9 Feb 2013 15:23:23 +0100
Message-ID: <CAMmJxt++bSc0n5U1Xs2TH6PLYb_oL9qXS_4JOSbtWAs_t23o=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:61688 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757574Ab3BIOXY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Feb 2013 09:23:24 -0500
Received: by mail-ve0-f181.google.com with SMTP id d10so4049642vea.26
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 06:23:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Three times now, twice on one osd, once on another we've had the osd
crash. Restarting it wouldn't help - it would crash with the same
error. The only way I found to get it up again was to reformat both
the journal disk and the disk ceph is using for storage... basically
recreating the osd.
This has got me thinking it's some sort of filesystem corruption going
on but I can't be sure.

Thing is, the first two times this happended on 0.48.3 (argonaut) and
this last time it happened on 0.56.2 - I upgraded hoping this issue
was fixed.

There is another possibility than ceph itself - we're using btrfs on
the ceph disks. We're using it because in general we haven't seen any
problems. We've been running ceph on these for six months without
issue. We also really need the compression btrfs can do (we're saving
vast amounts of space this way because of the nature of the data we're
storing).

Kernel is, and has been 3.6.2-030602-generic for a long time now, I
think we started out on 3.5.x but pretty quickly went to 3.6.2. The
disks are formatted like so:
mkfs.btrfs -l 32k -n 32k /dev/xvdf

Otherwise the nodes are running on Ubuntu 12.04.1 LTS. This is all
running on EC2. Thanks for any help I can get!

I know it may not be verbose enough but this is the log I got from
this last crash:

2013-02-09 13:18:08.685989 7f3f92949780  1 journal _open
/mnt/osd.2.journal fd 7: 1048576000 bytes, block size 4096 bytes,
directio = 1, aio = 0
2013-02-09 13:18:08.693418 7f3f92949780  0
filestore(/var/lib/ceph/osd/ceph-2) mkjournal created journal on
/mnt/osd.2.journal
2013-02-09 13:18:08.693481 7f3f92949780 -1 created new journal
/mnt/osd.2.journal for object store /var/lib/ceph/osd/ceph-2
2013-02-09 13:18:21.926143 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount FIEMAP ioctl is supported
and appears to work
2013-02-09 13:18:21.926214 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount FIEMAP ioctl is disabled via
'filestore fiemap' config option
2013-02-09 13:18:21.926704 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount detected btrfs
2013-02-09 13:18:21.926881 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs CLONE_RANGE ioctl is
supported
2013-02-09 13:18:21.996613 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_CREATE is
supported
2013-02-09 13:18:21.998330 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_DESTROY is
supported
2013-02-09 13:18:21.999840 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs START_SYNC is
supported (transid 549552)
2013-02-09 13:18:22.032267 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs WAIT_SYNC is supported
2013-02-09 13:18:22.045994 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_CREATE_V2 is
supported
2013-02-09 13:18:22.104523 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount syncfs(2) syscall fully
supported (by glibc and kernel)
2013-02-09 13:18:22.104811 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount found snaps
<4282852,4282856>
2013-02-09 13:18:22.323175 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount: enabling PARALLEL journal
mode: btrfs, SNAP_CREATE_V2 detected and 'filestore btrfs snap' mode
is enabled
2013-02-09 13:18:23.041769 7f09b4dc7700 -1 *** Caught signal (Aborted) **
 in thread 7f09b4dc7700

 ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
 1: /usr/bin/ceph-osd() [0x7828da]
 2: (()+0xfcb0) [0x7f09b8bc8cb0]
 3: (gsignal()+0x35) [0x7f09b7587425]
 4: (abort()+0x17b) [0x7f09b758ab8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f09b7ed969d]
 6: (()+0xb5846) [0x7f09b7ed7846]
 7: (()+0xb5873) [0x7f09b7ed7873]
 8: (()+0xb596e) [0x7f09b7ed796e]
 9: (std::__throw_length_error(char const*)+0x57) [0x7f09b7e84907]
 10: (()+0x9eaa2) [0x7f09b7ec0aa2]
 11: (char* std::string::_S_construct<char const*>(char const*, char
const*, std::allocator<char> const&, std::forward_iterator_tag)+0x35)
[0x7f09b7ec2495]
 12: (std::basic_string<char, std::char_traits<char>,
std::allocator<char> >::basic_string(char const*, unsigned long,
std::allocator<char> const&)+0x1d) [0x7f09b7ec261d]
 13: (leveldb::InternalKeyComparator::FindShortestSeparator(std::string*,
leveldb::Slice const&) const+0x47) [0x769137]
 14: (leveldb::TableBuilder::Add(leveldb::Slice const&, leveldb::Slice
const&)+0x92) [0x777b62]
 15: (leveldb::DBImpl::DoCompactionWork(leveldb::DBImpl::CompactionState*)+0x482)
[0x7639a2]
 16: (leveldb::DBImpl::BackgroundCompaction()+0x2b0) [0x7641a0]
 17: (leveldb::DBImpl::BackgroundCall()+0x68) [0x764c48]
 18: /usr/bin/ceph-osd() [0x77dbef]
 19: (()+0x7e9a) [0x7f09b8bc0e9a]
 20: (clone()+0x6d) [0x7f09b7644cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
   -35> 2013-02-09 13:18:21.898622 7f09b972d780  5 asok(0x1c4d000)
register_command perfcounters_dump hook 0x1c42010
   -34> 2013-02-09 13:18:21.898746 7f09b972d780  5 asok(0x1c4d000)
register_command 1 hook 0x1c42010
   -33> 2013-02-09 13:18:21.898765 7f09b972d780  5 asok(0x1c4d000)
register_command perf dump hook 0x1c42010
   -32> 2013-02-09 13:18:21.898789 7f09b972d780  5 asok(0x1c4d000)
register_command perfcounters_schema hook 0x1c42010
   -31> 2013-02-09 13:18:21.898799 7f09b972d780  5 asok(0x1c4d000)
register_command 2 hook 0x1c42010
   -30> 2013-02-09 13:18:21.898807 7f09b972d780  5 asok(0x1c4d000)
register_command perf schema hook 0x1c42010
   -29> 2013-02-09 13:18:21.898812 7f09b972d780  5 asok(0x1c4d000)
register_command config show hook 0x1c42010
   -28> 2013-02-09 13:18:21.898820 7f09b972d780  5 asok(0x1c4d000)
register_command config set hook 0x1c42010
   -27> 2013-02-09 13:18:21.898824 7f09b972d780  5 asok(0x1c4d000)
register_command log flush hook 0x1c42010
   -26> 2013-02-09 13:18:21.898826 7f09b972d780  5 asok(0x1c4d000)
register_command log dump hook 0x1c42010
   -25> 2013-02-09 13:18:21.898833 7f09b972d780  5 asok(0x1c4d000)
register_command log reopen hook 0x1c42010
   -24> 2013-02-09 13:18:21.900486 7f09b972d780  0 ceph version 0.56.2
(586538e22afba85c59beda49789ec42024e7a061), process ceph-osd, pid 3948
   -23> 2013-02-09 13:18:21.901111 7f09b972d780  1
accepter.accepter.bind my_inst.addr is 0.0.0.0:6800/3948 need_addr=1
   -22> 2013-02-09 13:18:21.901159 7f09b972d780  1
accepter.accepter.bind my_inst.addr is 0.0.0.0:6801/3948 need_addr=1
   -21> 2013-02-09 13:18:21.901179 7f09b972d780  1
accepter.accepter.bind my_inst.addr is 0.0.0.0:6802/3948 need_addr=1
   -20> 2013-02-09 13:18:21.902977 7f09b972d780  1 finished
global_init_daemonize
   -19> 2013-02-09 13:18:21.907341 7f09b972d780  5 asok(0x1c4d000)
init /var/run/ceph/ceph-osd.2.asok
   -18> 2013-02-09 13:18:21.907404 7f09b972d780  5 asok(0x1c4d000)
bind_and_listen /var/run/ceph/ceph-osd.2.asok
   -17> 2013-02-09 13:18:21.907470 7f09b972d780  5 asok(0x1c4d000)
register_command 0 hook 0x1c410b0
   -16> 2013-02-09 13:18:21.907487 7f09b972d780  5 asok(0x1c4d000)
register_command version hook 0x1c410b0
   -15> 2013-02-09 13:18:21.907499 7f09b972d780  5 asok(0x1c4d000)
register_command git_version hook 0x1c410b0
   -14> 2013-02-09 13:18:21.907508 7f09b972d780  5 asok(0x1c4d000)
register_command help hook 0x1c420c0
   -13> 2013-02-09 13:18:21.907581 7f09b55c8700  5 asok(0x1c4d000) entry start
   -12> 2013-02-09 13:18:21.926143 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount FIEMAP ioctl is supported
and appears to work
   -11> 2013-02-09 13:18:21.926214 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount FIEMAP ioctl is disabled via
'filestore fiemap' config option
   -10> 2013-02-09 13:18:21.926704 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount detected btrfs
    -9> 2013-02-09 13:18:21.926881 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs CLONE_RANGE ioctl is
supported
    -8> 2013-02-09 13:18:21.996613 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_CREATE is
supported
    -7> 2013-02-09 13:18:21.998330 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_DESTROY is
supported
    -6> 2013-02-09 13:18:21.999840 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs START_SYNC is
supported (transid 549552)
    -5> 2013-02-09 13:18:22.032267 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs WAIT_SYNC is supported
    -4> 2013-02-09 13:18:22.045994 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount btrfs SNAP_CREATE_V2 is
supported
    -3> 2013-02-09 13:18:22.104523 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount syncfs(2) syscall fully
supported (by glibc and kernel)
    -2> 2013-02-09 13:18:22.104811 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount found snaps
<4282852,4282856>
    -1> 2013-02-09 13:18:22.323175 7f09b972d780  0
filestore(/var/lib/ceph/osd/ceph-2) mount: enabling PARALLEL journal
mode: btrfs, SNAP_CREATE_V2 detected and 'filestore btrfs snap' mode
is enabled
     0> 2013-02-09 13:18:23.041769 7f09b4dc7700 -1 *** Caught signal
(Aborted) **
 in thread 7f09b4dc7700

 ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
 1: /usr/bin/ceph-osd() [0x7828da]
 2: (()+0xfcb0) [0x7f09b8bc8cb0]
 3: (gsignal()+0x35) [0x7f09b7587425]
 4: (abort()+0x17b) [0x7f09b758ab8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f09b7ed969d]
 6: (()+0xb5846) [0x7f09b7ed7846]
 7: (()+0xb5873) [0x7f09b7ed7873]
 8: (()+0xb596e) [0x7f09b7ed796e]
 9: (std::__throw_length_error(char const*)+0x57) [0x7f09b7e84907]
 10: (()+0x9eaa2) [0x7f09b7ec0aa2]
 11: (char* std::string::_S_construct<char const*>(char const*, char
const*, std::allocator<char> const&, std::forward_iterator_tag)+0x35)
[0x7f09b7ec2495]
 12: (std::basic_string<char, std::char_traits<char>,
std::allocator<char> >::basic_string(char const*, unsigned long,
std::allocator<char> const&)+0x1d) [0x7f09b7ec261d]
 13: (leveldb::InternalKeyComparator::FindShortestSeparator(std::string*,
leveldb::Slice const&) const+0x47) [0x769137]
 14: (leveldb::TableBuilder::Add(leveldb::Slice const&, leveldb::Slice
const&)+0x92) [0x777b62]
 15: (leveldb::DBImpl::DoCompactionWork(leveldb::DBImpl::CompactionState*)+0x482)
[0x7639a2]
 16: (leveldb::DBImpl::BackgroundCompaction()+0x2b0) [0x7641a0]
 17: (leveldb::DBImpl::BackgroundCall()+0x68) [0x764c48]
 18: /usr/bin/ceph-osd() [0x77dbef]
 19: (()+0x7e9a) [0x7f09b8bc0e9a]
 20: (clone()+0x6d) [0x7f09b7644cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

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
  max_recent    100000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.2.log
--- end dump of recent events ---
