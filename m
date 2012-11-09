From: Andrey Korolyov <andrey@xdel.ru>
Subject: ``rbd mv'' crash when no destination issued
Date: Fri, 9 Nov 2012 19:57:14 +0300
Message-ID: <CABYiri_uQc0qRcg6ByhAO+dbt9+1=pAZ+pQPuB1XXgZBxgcd3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58917 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab2KIQ5h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 11:57:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4239238oag.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 08:57:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Please take a look, seems harmless:


$ rbd mv vm0
terminate called after throwing an instance of 'std::logic_error'
  what():  basic_string::_S_construct null not valid
*** Caught signal (Aborted) **
 in thread 7f85f5981780
 ceph version 0.53 (commit:2528b5ee105b16352c91af064af5c0b5a7d45d7c)
 1: rbd() [0x431a92]
 2: (()+0xfcb0) [0x7f85f451fcb0]
 3: (gsignal()+0x35) [0x7f85f2c63405]
 4: (abort()+0x17b) [0x7f85f2c66b5b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f85f35616dd]
 6: (()+0x637e6) [0x7f85f355f7e6]
 7: (()+0x63813) [0x7f85f355f813]
 8: (()+0x63a3e) [0x7f85f355fa3e]
 9: (std::__throw_logic_error(char const*)+0x5d) [0x7f85f35b133d]
 10: (char* std::string::_S_construct<char const*>(char const*, char
const*, std::allocator<char> const&, std::forward_iterator_tag)+0xa9)
[0x7f85f35bd3e9]
 11: (std::basic_string<char, std::char_traits<char>,
std::allocator<char> >::basic_string(char const*, std::allocator<char>
const&)+0x43) [0x7f85f35bd453]
 12: (librbd::rename(librados::IoCtx&, char const*, char
const*)+0x119) [0x7f85f5528099]
 13: (main()+0x2ba5) [0x42aff5]
 14: (__libc_start_main()+0xed) [0x7f85f2c4e76d]
 15: rbd() [0x42d599]
2012-11-09 20:51:50.082452 7f85f5981780 -1 *** Caught signal (Aborted) **
 in thread 7f85f5981780

 ceph version 0.53 (commit:2528b5ee105b16352c91af064af5c0b5a7d45d7c)
 1: rbd() [0x431a92]
 2: (()+0xfcb0) [0x7f85f451fcb0]
 3: (gsignal()+0x35) [0x7f85f2c63405]
 4: (abort()+0x17b) [0x7f85f2c66b5b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f85f35616dd]
 6: (()+0x637e6) [0x7f85f355f7e6]
 7: (()+0x63813) [0x7f85f355f813]
 8: (()+0x63a3e) [0x7f85f355fa3e]
 9: (std::__throw_logic_error(char const*)+0x5d) [0x7f85f35b133d]
 10: (char* std::string::_S_construct<char const*>(char const*, char
const*, std::allocator<char> const&, std::forward_iterator_tag)+0xa9)
[0x7f85f35bd3e9]
 11: (std::basic_string<char, std::char_traits<char>,
std::allocator<char> >::basic_string(char const*, std::allocator<char>
const&)+0x43) [0x7f85f35bd453]
 12: (librbd::rename(librados::IoCtx&, char const*, char
const*)+0x119) [0x7f85f5528099]
 13: (main()+0x2ba5) [0x42aff5]
 14: (__libc_start_main()+0xed) [0x7f85f2c4e76d]
 15: rbd() [0x42d599]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
   -47> 2012-11-09 20:51:50.060811 7f85f5981780  5 asok(0x208ba50)
register_command perfcounters_dump hook 0x208b9b0
   -46> 2012-11-09 20:51:50.060838 7f85f5981780  5 asok(0x208ba50)
register_command 1 hook 0x208b9b0
   -45> 2012-11-09 20:51:50.060843 7f85f5981780  5 asok(0x208ba50)
register_command perf dump hook 0x208b9b0
   -44> 2012-11-09 20:51:50.060858 7f85f5981780  5 asok(0x208ba50)
register_command perfcounters_schema hook 0x208b9b0
   -43> 2012-11-09 20:51:50.060864 7f85f5981780  5 asok(0x208ba50)
register_command 2 hook 0x208b9b0
   -42> 2012-11-09 20:51:50.060866 7f85f5981780  5 asok(0x208ba50)
register_command perf schema hook 0x208b9b0
   -41> 2012-11-09 20:51:50.060868 7f85f5981780  5 asok(0x208ba50)
register_command config show hook 0x208b9b0
   -40> 2012-11-09 20:51:50.060874 7f85f5981780  5 asok(0x208ba50)
register_command config set hook 0x208b9b0
   -39> 2012-11-09 20:51:50.060877 7f85f5981780  5 asok(0x208ba50)
register_command log flush hook 0x208b9b0
   -38> 2012-11-09 20:51:50.060880 7f85f5981780  5 asok(0x208ba50)
register_command log dump hook 0x208b9b0
   -37> 2012-11-09 20:51:50.060886 7f85f5981780  5 asok(0x208ba50)
register_command log reopen hook 0x208b9b0
   -36> 2012-11-09 20:51:50.063300 7f85f5981780  1 librados: starting
msgr at :/0
   -35> 2012-11-09 20:51:50.063317 7f85f5981780  1 librados: starting objecter
   -34> 2012-11-09 20:51:50.063399 7f85f5981780  1 librados: setting wanted keys
   -33> 2012-11-09 20:51:50.063406 7f85f5981780  1 librados: calling
monclient init
   -32> 2012-11-09 20:51:50.063589 7f85f5981780  2 auth:
KeyRing::load: loaded key file /etc/ceph/keyring.bin
   -31> 2012-11-09 20:51:50.064794 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 473 (0 ->
473)
   -30> 2012-11-09 20:51:50.064953 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 33 (473 ->
506)
   -29> 2012-11-09 20:51:50.065026 7f85f1c2a700  1 monclient(hunting):
found mon.2
   -28> 2012-11-09 20:51:50.065055 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 473
(0x6a9d28 -> 33)
   -27> 2012-11-09 20:51:50.065332 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 33
(0x6a9d28 -> 0)
   -26> 2012-11-09 20:51:50.065627 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 206 (0 ->
206)
   -25> 2012-11-09 20:51:50.065798 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 206
(0x6a9d28 -> 0)
   -24> 2012-11-09 20:51:50.066082 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 393 (0 ->
393)
   -23> 2012-11-09 20:51:50.066177 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 393
(0x6a9d28 -> 0)
   -22> 2012-11-09 20:51:50.066183 7f85f5981780  5 monclient:
authenticate success, global_id 9874339
   -21> 2012-11-09 20:51:50.066271 7f85f5981780  5 asok(0x208ba50)
register_command objecter_requests hook 0x2097b10
   -20> 2012-11-09 20:51:50.066300 7f85f5981780  1 librados: waiting for osdmap
   -19> 2012-11-09 20:51:50.066362 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 473 (0 ->
473)
   -18> 2012-11-09 20:51:50.066428 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 20 (473 ->
493)
   -17> 2012-11-09 20:51:50.066445 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 473
(0x6a9d28 -> 20)
   -16> 2012-11-09 20:51:50.066481 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 20
(0x6a9d28 -> 0)
   -15> 2012-11-09 20:51:50.066684 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 26196 (0
-> 26196)
   -14> 2012-11-09 20:51:50.066845 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 20 (26196
-> 26216)
   -13> 2012-11-09 20:51:50.066882 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 26196
(26216 -> 52412)
   -12> 2012-11-09 20:51:50.066960 7f85efc26700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 20 (52412
-> 52432)
   -11> 2012-11-09 20:51:50.067236 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 26196
(0x6a9d28 -> 26236)
   -10> 2012-11-09 20:51:50.067250 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 20
(0x6a9d28 -> 26216)
    -9> 2012-11-09 20:51:50.067279 7f85f5981780  1 librados: init done
    -8> 2012-11-09 20:51:50.067292 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 26196
(0x6a9d28 -> 20)
    -7> 2012-11-09 20:51:50.067307 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 20
(0x6a9d28 -> 0)
    -6> 2012-11-09 20:51:50.067363 7f85f5981780  5
throttle(objecter_bytes 0x2096588) get_or_fail 0 success (0 -> 0)
    -5> 2012-11-09 20:51:50.067371 7f85f5981780  5
throttle(objecter_ops 0x2096608) get_or_fail 1 success (0 -> 1)
    -4> 2012-11-09 20:51:50.069029 7f85efa24700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) get 122 (0 ->
122)
    -3> 2012-11-09 20:51:50.069146 7f85f1c2a700  5
throttle(objecter_bytes 0x2096588) put 0 (0x6a9d28 -> 0)
    -2> 2012-11-09 20:51:50.069155 7f85f1c2a700  5
throttle(objecter_ops 0x2096608) put 1 (0x6a9d28 -> 0)
    -1> 2012-11-09 20:51:50.069181 7f85f1c2a700  5
throttle(msgr_dispatch_throttler-radosclient 0x2095a08) put 122
(0x6a9d28 -> 0)
     0> 2012-11-09 20:51:50.082452 7f85f5981780 -1 *** Caught signal
(Aborted) **
 in thread 7f85f5981780

 ceph version 0.53 (commit:2528b5ee105b16352c91af064af5c0b5a7d45d7c)
 1: rbd() [0x431a92]
 2: (()+0xfcb0) [0x7f85f451fcb0]
 3: (gsignal()+0x35) [0x7f85f2c63405]
 4: (abort()+0x17b) [0x7f85f2c66b5b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f85f35616dd]
 6: (()+0x637e6) [0x7f85f355f7e6]
 7: (()+0x63813) [0x7f85f355f813]
 8: (()+0x63a3e) [0x7f85f355fa3e]
 9: (std::__throw_logic_error(char const*)+0x5d) [0x7f85f35b133d]
 10: (char* std::string::_S_construct<char const*>(char const*, char
const*, std::allocator<char> const&, std::forward_iterator_tag)+0xa9)
[0x7f85f35bd3e9]
 11: (std::basic_string<char, std::char_traits<char>,
std::allocator<char> >::basic_string(char const*, std::allocator<char>
const&)+0x43) [0x7f85f35bd453]
 12: (librbd::rename(librados::IoCtx&, char const*, char
const*)+0x119) [0x7f85f5528099]
 13: (main()+0x2ba5) [0x42aff5]
 14: (__libc_start_main()+0xed) [0x7f85f2c4e76d]
 15: rbd() [0x42d599]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 5 lockdep
   0/ 5 context
   1/ 5 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 0 buffer
   0/ 5 timer
   0/ 5 filer
   0/ 0 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 5 filestore
   1/ 5 journal
   0/ 0 ms
   1/ 5 mon
   0/ 5 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 asok
   1/ 5 throttle
  -2/-2 (syslog threshold)
  99/99 (stderr threshold)
  max_recent     10000
  max_new      1000000
  log_file
--- end dump of recent events ---
Aborted
