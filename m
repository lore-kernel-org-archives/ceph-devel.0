From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-users] monitor upgrade from 0.56.6 to 0.61.1 on squeeze
 failed!
Date: Mon, 13 May 2013 12:05:32 +0100
Message-ID: <5190C8FC.7060206@inktank.com>
References: <518F0517.7060601@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:33556 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3EMLF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 07:05:28 -0400
Received: by mail-bk0-f49.google.com with SMTP id na10so173296bkb.36
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 04:05:27 -0700 (PDT)
In-Reply-To: <518F0517.7060601@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-users@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On 05/12/2013 03:57 AM, Smart Weblications GmbH - Florian Wiessner wrote:
> Hi,
>
> i upgraded from 0.56.6 to 0.61.1 and tried to restart one monitor:


Hello Florian,


We are aware and actively working on a fix for this.

Ticket: http://tracker.ceph.com/issues/4974

Thanks!

   -Joao

>
> /etc/init.d/ceph start mon
> === mon.4 ===
> Starting Ceph mon.4 on node05...
> [16366]: (33) Numerical argument out of domain
> failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i 4 --pid-file
> /var/run/ceph/mon.4.pid -c /etc/ceph/ceph.conf '
> root@node05:/data/ceph/mon# ps aux|grep ceph-mon
> root     16568  0.0  0.0   7596   840 pts/1    S+   04:16   0:00 grep ceph-mon
>
>
> I read the log and found out that conversion seemed to have failed, so i removed
> store.db and tried again, without success, always saying:
>
> 0 _convert_machines mdsmap gv 31535406 already exists
>
>
> Full log:
>
> 2013-05-12 04:04:54.266783 7fa95a3a6780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 11398
> 2013-05-12 04:04:54.339686 7fa95a3a6780  1 unable to open monitor store at
> /data/ceph/mon
> 2013-05-12 04:04:54.339698 7fa95a3a6780  1 check for old monitor store format
> 2013-05-12 04:04:54.339700 7fa95a3a6780  1 store(/data/ceph/mon) mount
> 2013-05-12 04:04:54.347528 7fa95a3a6780  1 found old GV monitor store format --
> should convert!
> 2013-05-12 04:04:54.353621 7fa95a3a6780  1 store(/data/ceph/mon) mount
> 2013-05-12 04:06:51.530091 7fa95a3a6780  0 _convert_machines mdsmap gv 31535406
> already exists
> 2013-05-12 04:06:51.547889 7fa95a3a6780 -1 mon/Monitor.cc: In function 'void
> Monitor::StoreConverter::_convert_machines(std::string)' thread 7fa95a3a6780
> time 2013-05-12 04:06:51.530115
> mon/Monitor.cc: 4413: FAILED assert(0 == "Duplicate GV -- something is wrong!")
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   2: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   3: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   4: (main()+0x7ca) [0x47593a]
>   5: (__libc_start_main()+0xfd) [0x7fa95b00dc8d]
>   6: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- begin dump of recent events ---
>     -26> 2013-05-12 04:04:54.263903 7fa95a3a6780  5 asok(0x13f3000)
> register_command perfcounters_dump hook 0x13e7010
>     -25> 2013-05-12 04:04:54.263925 7fa95a3a6780  5 asok(0x13f3000)
> register_command 1 hook 0x13e7010
>     -24> 2013-05-12 04:04:54.263928 7fa95a3a6780  5 asok(0x13f3000)
> register_command perf dump hook 0x13e7010
>     -23> 2013-05-12 04:04:54.263935 7fa95a3a6780  5 asok(0x13f3000)
> register_command perfcounters_schema hook 0x13e7010
>     -22> 2013-05-12 04:04:54.263939 7fa95a3a6780  5 asok(0x13f3000)
> register_command 2 hook 0x13e7010
>     -21> 2013-05-12 04:04:54.263941 7fa95a3a6780  5 asok(0x13f3000)
> register_command perf schema hook 0x13e7010
>     -20> 2013-05-12 04:04:54.263946 7fa95a3a6780  5 asok(0x13f3000)
> register_command config show hook 0x13e7010
>     -19> 2013-05-12 04:04:54.263951 7fa95a3a6780  5 asok(0x13f3000)
> register_command config set hook 0x13e7010
>     -18> 2013-05-12 04:04:54.263956 7fa95a3a6780  5 asok(0x13f3000)
> register_command log flush hook 0x13e7010
>     -17> 2013-05-12 04:04:54.263961 7fa95a3a6780  5 asok(0x13f3000)
> register_command log dump hook 0x13e7010
>     -16> 2013-05-12 04:04:54.263966 7fa95a3a6780  5 asok(0x13f3000)
> register_command log reopen hook 0x13e7010
>     -15> 2013-05-12 04:04:54.266783 7fa95a3a6780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 11398
>     -14> 2013-05-12 04:04:54.267348 7fa95a3a6780  1 finished global_init_daemonize
>     -13> 2013-05-12 04:04:54.322995 7fa95a3a6780  5 asok(0x13f3000) init
> /var/run/ceph/ceph-mon.4.asok
>     -12> 2013-05-12 04:04:54.323018 7fa95a3a6780  5 asok(0x13f3000)
> bind_and_listen /var/run/ceph/ceph-mon.4.asok
>     -11> 2013-05-12 04:04:54.323059 7fa95a3a6780  5 asok(0x13f3000)
> register_command 0 hook 0x13e60b8
>     -10> 2013-05-12 04:04:54.323065 7fa95a3a6780  5 asok(0x13f3000)
> register_command version hook 0x13e60b8
>      -9> 2013-05-12 04:04:54.323070 7fa95a3a6780  5 asok(0x13f3000)
> register_command git_version hook 0x13e60b8
>      -8> 2013-05-12 04:04:54.323072 7fa95a3a6780  5 asok(0x13f3000)
> register_command help hook 0x13e70b0
>      -7> 2013-05-12 04:04:54.323105 7fa958c79700  5 asok(0x13f3000) entry start
>      -6> 2013-05-12 04:04:54.339686 7fa95a3a6780  1 unable to open monitor store
> at /data/ceph/mon
>      -5> 2013-05-12 04:04:54.339698 7fa95a3a6780  1 check for old monitor store
> format
>      -4> 2013-05-12 04:04:54.339700 7fa95a3a6780  1 store(/data/ceph/mon) mount
>      -3> 2013-05-12 04:04:54.347528 7fa95a3a6780  1 found old GV monitor store
> format -- should convert!
>      -2> 2013-05-12 04:04:54.353621 7fa95a3a6780  1 store(/data/ceph/mon) mount
>      -1> 2013-05-12 04:06:51.530091 7fa95a3a6780  0 _convert_machines mdsmap gv
> 31535406 already exists
>       0> 2013-05-12 04:06:51.547889 7fa95a3a6780 -1 mon/Monitor.cc: In function
> 'void Monitor::StoreConverter::_convert_machines(std::string)' thread
> 7fa95a3a6780 time 2013-05-12 04:06:51.530115
> mon/Monitor.cc: 4413: FAILED assert(0 == "Duplicate GV -- something is wrong!")
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   2: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   3: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   4: (main()+0x7ca) [0x47593a]
>   5: (__libc_start_main()+0xfd) [0x7fa95b00dc8d]
>   6: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent     10000
>    max_new         1000
>    log_file /var/log/ceph/ceph-mon.4.log
> --- end dump of recent events ---
> 2013-05-12 04:06:51.628590 7fa95a3a6780 -1 *** Caught signal (Aborted) **
>   in thread 7fa95a3a6780
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: /usr/bin/ceph-mon() [0x593939]
>   2: (()+0xeff0) [0x7fa95c3cfff0]
>   3: (gsignal()+0x35) [0x7fa95b0211b5]
>   4: (abort()+0x180) [0x7fa95b023fc0]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fa95b8b5dc5]
>   6: (()+0xcb166) [0x7fa95b8b4166]
>   7: (()+0xcb193) [0x7fa95b8b4193]
>   8: (()+0xcb28e) [0x7fa95b8b428e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9)
> [0x5b9439]
>   10: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   11: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   12: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   13: (main()+0x7ca) [0x47593a]
>   14: (__libc_start_main()+0xfd) [0x7fa95b00dc8d]
>   15: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- begin dump of recent events ---
>       0> 2013-05-12 04:06:51.628590 7fa95a3a6780 -1 *** Caught signal (Aborted) **
>   in thread 7fa95a3a6780
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: /usr/bin/ceph-mon() [0x593939]
>   2: (()+0xeff0) [0x7fa95c3cfff0]
>   3: (gsignal()+0x35) [0x7fa95b0211b5]
>   4: (abort()+0x180) [0x7fa95b023fc0]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fa95b8b5dc5]
>   6: (()+0xcb166) [0x7fa95b8b4166]
>   7: (()+0xcb193) [0x7fa95b8b4193]
>   8: (()+0xcb28e) [0x7fa95b8b428e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9)
> [0x5b9439]
>   10: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   11: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   12: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   13: (main()+0x7ca) [0x47593a]
>   14: (__libc_start_main()+0xfd) [0x7fa95b00dc8d]
>   15: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent     10000
>    max_new         1000
>    log_file /var/log/ceph/ceph-mon.4.log
> --- end dump of recent events ---
> 2013-05-12 04:07:39.810663 7fa768024780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 12619
> 2013-05-12 04:07:40.495728 7fa768024780 -1 there is an on-going (maybe aborted?)
> conversion.
> 2013-05-12 04:07:40.495799 7fa768024780 -1 you should check what happened
> 2013-05-12 04:07:40.495881 7fa768024780 -1 found errors while attempting to
> convert the monitor store: (17) File exists
> 2013-05-12 04:08:46.941045 7f100844f780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 13220
> 2013-05-12 04:08:46.948838 7f100844f780 -1 there is an on-going (maybe aborted?)
> conversion.
> 2013-05-12 04:08:46.948870 7f100844f780 -1 you should check what happened
> 2013-05-12 04:08:46.948939 7f100844f780 -1 found errors while attempting to
> convert the monitor store: (17) File exists
> 2013-05-12 04:08:56.611068 7ff5f5a1a780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 13299
> 2013-05-12 04:08:56.618116 7ff5f5a1a780 -1 there is an on-going (maybe aborted?)
> conversion.
> 2013-05-12 04:08:56.618168 7ff5f5a1a780 -1 you should check what happened
> 2013-05-12 04:08:56.618410 7ff5f5a1a780 -1 found errors while attempting to
> convert the monitor store: (17) File exists
> 2013-05-12 04:16:18.371051 7f13aedc2780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 16366
> 2013-05-12 04:16:18.432357 7f13aedc2780  1 unable to open monitor store at
> /data/ceph/mon
> 2013-05-12 04:16:18.432447 7f13aedc2780  1 check for old monitor store format
> 2013-05-12 04:16:18.592858 7f13aedc2780  1 store(/data/ceph/mon) mount
> 2013-05-12 04:16:18.682615 7f13aedc2780  1 found old GV monitor store format --
> should convert!
> 2013-05-12 04:16:18.748504 7f13aedc2780  1 store(/data/ceph/mon) mount
> 2013-05-12 04:16:30.422238 7f13aedc2780  0 _convert_machines mdsmap gv 31535406
> already exists
> 2013-05-12 04:16:30.476963 7f13aedc2780 -1 mon/Monitor.cc: In function 'void
> Monitor::StoreConverter::_convert_machines(std::string)' thread 7f13aedc2780
> time 2013-05-12 04:16:30.422295
> mon/Monitor.cc: 4413: FAILED assert(0 == "Duplicate GV -- something is wrong!")
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   2: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   3: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   4: (main()+0x7ca) [0x47593a]
>   5: (__libc_start_main()+0xfd) [0x7f13afa29c8d]
>   6: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- begin dump of recent events ---
>     -26> 2013-05-12 04:16:18.369105 7f13aedc2780  5 asok(0x1f6c000)
> register_command perfcounters_dump hook 0x1f60010
>     -25> 2013-05-12 04:16:18.369126 7f13aedc2780  5 asok(0x1f6c000)
> register_command 1 hook 0x1f60010
>     -24> 2013-05-12 04:16:18.369128 7f13aedc2780  5 asok(0x1f6c000)
> register_command perf dump hook 0x1f60010
>     -23> 2013-05-12 04:16:18.369135 7f13aedc2780  5 asok(0x1f6c000)
> register_command perfcounters_schema hook 0x1f60010
>     -22> 2013-05-12 04:16:18.369242 7f13aedc2780  5 asok(0x1f6c000)
> register_command 2 hook 0x1f60010
>     -21> 2013-05-12 04:16:18.369247 7f13aedc2780  5 asok(0x1f6c000)
> register_command perf schema hook 0x1f60010
>     -20> 2013-05-12 04:16:18.369249 7f13aedc2780  5 asok(0x1f6c000)
> register_command config show hook 0x1f60010
>     -19> 2013-05-12 04:16:18.369251 7f13aedc2780  5 asok(0x1f6c000)
> register_command config set hook 0x1f60010
>     -18> 2013-05-12 04:16:18.369253 7f13aedc2780  5 asok(0x1f6c000)
> register_command log flush hook 0x1f60010
>     -17> 2013-05-12 04:16:18.369255 7f13aedc2780  5 asok(0x1f6c000)
> register_command log dump hook 0x1f60010
>     -16> 2013-05-12 04:16:18.369257 7f13aedc2780  5 asok(0x1f6c000)
> register_command log reopen hook 0x1f60010
>     -15> 2013-05-12 04:16:18.371051 7f13aedc2780  0 ceph version 0.61.1
> (56c4847ba82a92023700e2d4920b59cdaf23428d), process ceph-mon, pid 16366
>     -14> 2013-05-12 04:16:18.371980 7f13aedc2780  1 finished global_init_daemonize
>     -13> 2013-05-12 04:16:18.431919 7f13aedc2780  5 asok(0x1f6c000) init
> /var/run/ceph/ceph-mon.4.asok
>     -12> 2013-05-12 04:16:18.431948 7f13aedc2780  5 asok(0x1f6c000)
> bind_and_listen /var/run/ceph/ceph-mon.4.asok
>     -11> 2013-05-12 04:16:18.431997 7f13aedc2780  5 asok(0x1f6c000)
> register_command 0 hook 0x1f5f0b8
>     -10> 2013-05-12 04:16:18.432004 7f13aedc2780  5 asok(0x1f6c000)
> register_command version hook 0x1f5f0b8
>      -9> 2013-05-12 04:16:18.432009 7f13aedc2780  5 asok(0x1f6c000)
> register_command git_version hook 0x1f5f0b8
>      -8> 2013-05-12 04:16:18.432014 7f13aedc2780  5 asok(0x1f6c000)
> register_command help hook 0x1f600b0
>      -7> 2013-05-12 04:16:18.432043 7f13ad695700  5 asok(0x1f6c000) entry start
>      -6> 2013-05-12 04:16:18.432357 7f13aedc2780  1 unable to open monitor store
> at /data/ceph/mon
>      -5> 2013-05-12 04:16:18.432447 7f13aedc2780  1 check for old monitor store
> format
>      -4> 2013-05-12 04:16:18.592858 7f13aedc2780  1 store(/data/ceph/mon) mount
>      -3> 2013-05-12 04:16:18.682615 7f13aedc2780  1 found old GV monitor store
> format -- should convert!
>      -2> 2013-05-12 04:16:18.748504 7f13aedc2780  1 store(/data/ceph/mon) mount
>      -1> 2013-05-12 04:16:30.422238 7f13aedc2780  0 _convert_machines mdsmap gv
> 31535406 already exists
>       0> 2013-05-12 04:16:30.476963 7f13aedc2780 -1 mon/Monitor.cc: In function
> 'void Monitor::StoreConverter::_convert_machines(std::string)' thread
> 7f13aedc2780 time 2013-05-12 04:16:30.422295
> mon/Monitor.cc: 4413: FAILED assert(0 == "Duplicate GV -- something is wrong!")
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   2: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   3: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   4: (main()+0x7ca) [0x47593a]
>   5: (__libc_start_main()+0xfd) [0x7f13afa29c8d]
>   6: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent     10000
>    max_new         1000
>    log_file /var/log/ceph/ceph-mon.4.log
> --- end dump of recent events ---
> 2013-05-12 04:16:30.501642 7f13aedc2780 -1 *** Caught signal (Aborted) **
>   in thread 7f13aedc2780
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: /usr/bin/ceph-mon() [0x593939]
>   2: (()+0xeff0) [0x7f13b0debff0]
>   3: (gsignal()+0x35) [0x7f13afa3d1b5]
>   4: (abort()+0x180) [0x7f13afa3ffc0]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f13b02d1dc5]
>   6: (()+0xcb166) [0x7f13b02d0166]
>   7: (()+0xcb193) [0x7f13b02d0193]
>   8: (()+0xcb28e) [0x7f13b02d028e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9)
> [0x5b9439]
>   10: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   11: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   12: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   13: (main()+0x7ca) [0x47593a]
>   14: (__libc_start_main()+0xfd) [0x7f13afa29c8d]
>   15: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- begin dump of recent events ---
>       0> 2013-05-12 04:16:30.501642 7f13aedc2780 -1 *** Caught signal (Aborted) **
>   in thread 7f13aedc2780
>
>   ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>   1: /usr/bin/ceph-mon() [0x593939]
>   2: (()+0xeff0) [0x7f13b0debff0]
>   3: (gsignal()+0x35) [0x7f13afa3d1b5]
>   4: (abort()+0x180) [0x7f13afa3ffc0]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f13b02d1dc5]
>   6: (()+0xcb166) [0x7f13b02d0166]
>   7: (()+0xcb193) [0x7f13b02d0193]
>   8: (()+0xcb28e) [0x7f13b02d028e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9)
> [0x5b9439]
>   10: (Monitor::StoreConverter::_convert_machines(std::string)+0xcad) [0x49b0ed]
>   11: (Monitor::StoreConverter::_convert_machines()+0xd7) [0x49be17]
>   12: (Monitor::StoreConverter::convert()+0x2e0) [0x49c210]
>   13: (main()+0x7ca) [0x47593a]
>   14: (__libc_start_main()+0xfd) [0x7f13afa29c8d]
>   15: /usr/bin/ceph-mon() [0x473e39]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent     10000
>    max_new         1000
>    log_file /var/log/ceph/ceph-mon.4.log
> --- end dump of recent events ---
>
>
>
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
