From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: RBD Crash if libs not found
Date: Thu, 24 Apr 2014 10:35:54 -0500
Message-ID: <d388a6f64e416ed0ba015bbd30fac96a@pl1.haspere.com>
Reply-To: YS3fpFE2ykfB@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:49280 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbaDXPfy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Apr 2014 11:35:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I found that RBD will crash horribly if some libraries are not found 
when pulled in dynamically.  These were not listed in the ldd output, 
but were reported missing by strace.  While I know the packaging 
software (rpm, apt, ebuild, etc) normally takes care of this, I wanted 
to see what happens when the binaries were manually transferred to 
another system.  I would think that RBD would handle this gracefully and 
report the missing library name.  What do you think?



Here's the crash report (if /usr/lib/libsoftokn3.so and 
/usr/lib/libsoftokn3.so can't be found):





common/ceph_crypto.cc: In function 'void 
ceph::crypto::init(CephContext*)' thread f664a980 time 2014-04-24 
15:27:43.931225
common/ceph_crypto.cc: 54: FAILED assert(s == SECSuccess)
  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: (()+0x34305e) [0xf6f0005e]
  2: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  3: (main()+0x53b) [0x805731b]
  4: (__libc_start_main()+0xf5) [0xf68c4cc5]
  5: /bin/rbd() [0x805da51]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.
2014-04-24 15:27:43.931631 f664a980 -1 common/ceph_crypto.cc: In 
function 'void ceph::crypto::init(CephContext*)' thread f664a980 time 
2014-04-24 15:27:43.931225
common/ceph_crypto.cc: 54: FAILED assert(s == SECSuccess)

  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: (()+0x34305e) [0xf6f0005e]
  2: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  3: (main()+0x53b) [0x805731b]
  4: (__libc_start_main()+0xf5) [0xf68c4cc5]
  5: /bin/rbd() [0x805da51]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
    -13> 2014-04-24 15:27:43.930734 f664a980  5 asok(0x888d9c8) 
register_command perfcounters_dump hook 0x888f260
    -12> 2014-04-24 15:27:43.930756 f664a980  5 asok(0x888d9c8) 
register_command 1 hook 0x888f260
    -11> 2014-04-24 15:27:43.930761 f664a980  5 asok(0x888d9c8) 
register_command perf dump hook 0x888f260
    -10> 2014-04-24 15:27:43.930766 f664a980  5 asok(0x888d9c8) 
register_command perfcounters_schema hook 0x888f260
     -9> 2014-04-24 15:27:43.930772 f664a980  5 asok(0x888d9c8) 
register_command 2 hook 0x888f260
     -8> 2014-04-24 15:27:43.930778 f664a980  5 asok(0x888d9c8) 
register_command perf schema hook 0x888f260
     -7> 2014-04-24 15:27:43.930782 f664a980  5 asok(0x888d9c8) 
register_command config show hook 0x888f260
     -6> 2014-04-24 15:27:43.930786 f664a980  5 asok(0x888d9c8) 
register_command config set hook 0x888f260
     -5> 2014-04-24 15:27:43.930790 f664a980  5 asok(0x888d9c8) 
register_command config get hook 0x888f260
     -4> 2014-04-24 15:27:43.930794 f664a980  5 asok(0x888d9c8) 
register_command log flush hook 0x888f260
     -3> 2014-04-24 15:27:43.930798 f664a980  5 asok(0x888d9c8) 
register_command log dump hook 0x888f260
     -2> 2014-04-24 15:27:43.930803 f664a980  5 asok(0x888d9c8) 
register_command log reopen hook 0x888f260
     -1> 2014-04-24 15:27:43.930895 f664a980 -1 did not load config file, 
using default settings.
      0> 2014-04-24 15:27:43.931631 f664a980 -1 common/ceph_crypto.cc: In 
function 'void ceph::crypto::init(CephContext*)' thread f664a980 time 
2014-04-24 15:27:43.931225
common/ceph_crypto.cc: 54: FAILED assert(s == SECSuccess)

  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: (()+0x34305e) [0xf6f0005e]
  2: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  3: (main()+0x53b) [0x805731b]
  4: (__libc_start_main()+0xf5) [0xf68c4cc5]
  5: /bin/rbd() [0x805da51]
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
    1/ 3 keyvaluestore
    1/ 3 journal
    0/ 5 ms
    1/ 5 mon
    0/10 monc
    1/ 5 paxos
    0/ 5 tp
    1/ 5 auth
    1/ 5 crypto
    1/ 1 finisher
    1/ 5 heartbeatmap
    1/ 5 perfcounter
    1/ 5 rgw
    1/ 5 javaclient
    1/ 5 asok
    1/ 1 throttle
   -2/-2 (syslog threshold)
   99/99 (stderr threshold)
   max_recent       500
   max_new         1000
   log_file
--- end dump of recent events ---
terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (Aborted) **
  in thread f664a980
  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: /bin/rbd() [0x806a05a]
  2: (__kernel_sigreturn()+0) [0xf7733400]
  3: (__kernel_vsyscall()+0x5) [0xf7733425]
  4: (gsignal()+0x4f) [0xf68d998f]
  5: (abort()+0x143) [0xf68db1a3]
  6: (__gnu_cxx::__verbose_terminate_handler()+0x14d) [0xf6ac332d]
  7: (()+0x4ef73) [0xf6ac0f73]
  8: (()+0x4efaf) [0xf6ac0faf]
  9: (()+0x4f24e) [0xf6ac124e]
  10: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x464) [0xf6ebf864]
  11: (()+0x34305e) [0xf6f0005e]
  12: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  13: (main()+0x53b) [0x805731b]
  14: (__libc_start_main()+0xf5) [0xf68c4cc5]
  15: /bin/rbd() [0x805da51]
2014-04-24 15:27:43.932443 f664a980 -1 *** Caught signal (Aborted) **
  in thread f664a980

  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: /bin/rbd() [0x806a05a]
  2: (__kernel_sigreturn()+0) [0xf7733400]
  3: (__kernel_vsyscall()+0x5) [0xf7733425]
  4: (gsignal()+0x4f) [0xf68d998f]
  5: (abort()+0x143) [0xf68db1a3]
  6: (__gnu_cxx::__verbose_terminate_handler()+0x14d) [0xf6ac332d]
  7: (()+0x4ef73) [0xf6ac0f73]
  8: (()+0x4efaf) [0xf6ac0faf]
  9: (()+0x4f24e) [0xf6ac124e]
  10: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x464) [0xf6ebf864]
  11: (()+0x34305e) [0xf6f0005e]
  12: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  13: (main()+0x53b) [0x805731b]
  14: (__libc_start_main()+0xf5) [0xf68c4cc5]
  15: /bin/rbd() [0x805da51]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
      0> 2014-04-24 15:27:43.932443 f664a980 -1 *** Caught signal 
(Aborted) **
  in thread f664a980

  ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
  1: /bin/rbd() [0x806a05a]
  2: (__kernel_sigreturn()+0) [0xf7733400]
  3: (__kernel_vsyscall()+0x5) [0xf7733425]
  4: (gsignal()+0x4f) [0xf68d998f]
  5: (abort()+0x143) [0xf68db1a3]
  6: (__gnu_cxx::__verbose_terminate_handler()+0x14d) [0xf6ac332d]
  7: (()+0x4ef73) [0xf6ac0f73]
  8: (()+0x4efaf) [0xf6ac0faf]
  9: (()+0x4f24e) [0xf6ac124e]
  10: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x464) [0xf6ebf864]
  11: (()+0x34305e) [0xf6f0005e]
  12: (common_init_finish(CephContext*, int)+0x3c) [0xf6ed227c]
  13: (main()+0x53b) [0x805731b]
  14: (__libc_start_main()+0xf5) [0xf68c4cc5]
  15: /bin/rbd() [0x805da51]
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
    1/ 3 keyvaluestore
    1/ 3 journal
    0/ 5 ms
    1/ 5 mon
    0/10 monc
    1/ 5 paxos
    0/ 5 tp
    1/ 5 auth
    1/ 5 crypto
    1/ 1 finisher
    1/ 5 heartbeatmap
    1/ 5 perfcounter
    1/ 5 rgw
    1/ 5 javaclient
    1/ 5 asok
    1/ 1 throttle
   -2/-2 (syslog threshold)
   99/99 (stderr threshold)
   max_recent       500
   max_new         1000
   log_file
--- end dump of recent events ---








-- 
Thanks,
Dyweni
