From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph crash after creating a fresh ceph cluster
Date: Thu, 14 Jun 2012 11:54:02 +0200
Message-ID: <4FD9B4BA.8010700@profihost.ag>
References: <4FD9B41E.3050501@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57982 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2FNJyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 05:54:08 -0400
In-Reply-To: <4FD9B41E.3050501@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Even an OSD is crashed so OSD 11 is not running anymore.

The log of OSD 11 shows:
    -26> 2012-06-14 11:48:23.487160 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -25> 2012-06-14 11:48:28.487343 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -24> 2012-06-14 11:48:33.487516 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -23> 2012-06-14 11:48:38.487682 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -22> 2012-06-14 11:48:43.487808 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -21> 2012-06-14 11:48:48.487973 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -20> 2012-06-14 11:48:53.488138 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -19> 2012-06-14 11:48:58.488299 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -18> 2012-06-14 11:49:03.488458 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -17> 2012-06-14 11:49:08.488565 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -16> 2012-06-14 11:49:13.488658 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -15> 2012-06-14 11:49:18.488798 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -14> 2012-06-14 11:49:23.488954 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -13> 2012-06-14 11:49:28.489071 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -12> 2012-06-14 11:49:33.489220 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -11> 2012-06-14 11:49:38.489381 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
    -10> 2012-06-14 11:49:43.489522 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -9> 2012-06-14 11:49:48.489675 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -8> 2012-06-14 11:49:53.489829 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -7> 2012-06-14 11:49:58.489992 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -6> 2012-06-14 11:50:03.490161 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -5> 2012-06-14 11:50:08.490325 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -4> 2012-06-14 11:50:13.490479 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -3> 2012-06-14 11:50:18.490614 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -2> 2012-06-14 11:50:23.490775 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had timed out after 60
     -1> 2012-06-14 11:50:23.490796 7fc9eee4f700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7fc9e663e700' had suicide timed 
out after 180
      0> 2012-06-14 11:50:23.492292 7fc9eee4f700 -1 
common/HeartbeatMap.cc: In function 'bool 
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, 
time_t)' thread 7fc9eee4f700 time 2012-06-14 11:50:23.490813
common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")

  ceph version 0.47.2-4-ge868b44 
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, 
long)+0x270) [0x749d70]
  2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x749f87]
  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74a1d8]
  4: (CephContextServiceThread::entry()+0x5c) [0x71dc2c]
  5: (()+0x68ca) [0x7fc9f12b48ca]
  6: (clone()+0x6d) [0x7fc9ef938c0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- end dump of recent events ---
2012-06-14 11:51:22.902432 7fc9eee4f700 -1 *** Caught signal (Aborted) **
  in thread 7fc9eee4f700

  ceph version 0.47.2-4-ge868b44 
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: /usr/bin/ceph-osd() [0x708f79]
  2: (()+0xeff0) [0x7fc9f12bcff0]
  3: (gsignal()+0x35) [0x7fc9ef89b225]
  4: (abort()+0x180) [0x7fc9ef89e030]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fc9f012fdc5]
  6: (()+0xcb166) [0x7fc9f012e166]
  7: (()+0xcb193) [0x7fc9f012e193]
  8: (()+0xcb28e) [0x7fc9f012e28e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x940) [0x787460]
  10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char 
const*, long)+0x270) [0x749d70]
  11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x749f87]
  12: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74a1d8]
  13: (CephContextServiceThread::entry()+0x5c) [0x71dc2c]
  14: (()+0x68ca) [0x7fc9f12b48ca]
  15: (clone()+0x6d) [0x7fc9ef938c0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
      0> 2012-06-14 11:51:22.902432 7fc9eee4f700 -1 *** Caught signal 
(Aborted) **
  in thread 7fc9eee4f700

  ceph version 0.47.2-4-ge868b44 
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: /usr/bin/ceph-osd() [0x708f79]
  2: (()+0xeff0) [0x7fc9f12bcff0]
  3: (gsignal()+0x35) [0x7fc9ef89b225]
  4: (abort()+0x180) [0x7fc9ef89e030]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fc9f012fdc5]
  6: (()+0xcb166) [0x7fc9f012e166]
  7: (()+0xcb193) [0x7fc9f012e193]
  8: (()+0xcb28e) [0x7fc9f012e28e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x940) [0x787460]
  10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char 
const*, long)+0x270) [0x749d70]
  11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x749f87]
  12: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x74a1d8]
  13: (CephContextServiceThread::entry()+0x5c) [0x71dc2c]
  14: (()+0x68ca) [0x7fc9f12b48ca]
  15: (clone()+0x6d) [0x7fc9ef938c0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- end dump of recent events ---

Am 14.06.2012 11:51, schrieb Stefan Priebe - Profihost AG:
> Hello list,
>
> i've created a new ceph fs with:
> mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/client.admin.keyring
>
> I've then connected to ceph with ceph -w and got pretty immediatly this
> crash:
>
> 012-06-14 11:48:23.965577 7f548365c700 0 monclient: hunting for new mon
> ceph: mon/PGMap.cc:137: void PGMap::apply_incremental(const
> PGMap::Incremental&): Assertion `inc.version == version+1' failed.
> *** Caught signal (Aborted) **
> in thread 7f548365c700
> ceph version 0.47.2-4-ge868b44
> (commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
> 1: ceph() [0x478939]
> 2: (()+0xeff0) [0x7f5486cc3ff0]
> 3: (gsignal()+0x35) [0x7f54854e6225]
> 4: (abort()+0x180) [0x7f54854e9030]
> 5: (__assert_fail()+0xf1) [0x7f54854df361]
> 6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x471c26]
> 7: ceph() [0x45af75]
> 8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
> 9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
> 10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
> 11: (()+0x68ca) [0x7f5486cbb8ca]
> 12: (clone()+0x6d) [0x7f5485583c0d]
> 2012-06-14 11:48:50.822072 7f548365c700 -1 *** Caught signal (Aborted) **
> in thread 7f548365c700
>
> ceph version 0.47.2-4-ge868b44
> (commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
> 1: ceph() [0x478939]
> 2: (()+0xeff0) [0x7f5486cc3ff0]
> 3: (gsignal()+0x35) [0x7f54854e6225]
> 4: (abort()+0x180) [0x7f54854e9030]
> 5: (__assert_fail()+0xf1) [0x7f54854df361]
> 6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x471c26]
> 7: ceph() [0x45af75]
> 8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
> 9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
> 10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
> 11: (()+0x68ca) [0x7f5486cbb8ca]
> 12: (clone()+0x6d) [0x7f5485583c0d]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
>
> --- begin dump of recent events ---
> -2> 2012-06-14 11:47:42.886405 7f548365c700 0 monclient: hunting for new
> mon
> -1> 2012-06-14 11:48:23.965577 7f548365c700 0 monclient: hunting for new
> mon
> 0> 2012-06-14 11:48:50.822072 7f548365c700 -1 *** Caught signal
> (Aborted) **
> in thread 7f548365c700
>
> ceph version 0.47.2-4-ge868b44
> (commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
> 1: ceph() [0x478939]
> 2: (()+0xeff0) [0x7f5486cc3ff0]
> 3: (gsignal()+0x35) [0x7f54854e6225]
> 4: (abort()+0x180) [0x7f54854e9030]
> 5: (__assert_fail()+0xf1) [0x7f54854df361]
> 6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x471c26]
> 7: ceph() [0x45af75]
> 8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
> 9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
> 10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
> 11: (()+0x68ca) [0x7f5486cbb8ca]
> 12: (clone()+0x6d) [0x7f5485583c0d]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
>
> --- end dump of recent events ---
> Aborted
>
