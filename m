From: norbi <norbi@rocknob.de>
Subject: Re: v0.56 released
Date: Thu, 03 Jan 2013 09:28:00 +0100
Message-ID: <50E54110.8090203@rocknob.de>
References: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:57824 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3ACI2G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 03:28:06 -0500
Received: from [80.67.16.214] (helo=[192.168.10.165])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <norbi@rocknob.de>)
	id 1Tqg9i-0000iB-1q
	for ceph-devel@vger.kernel.org; Thu, 03 Jan 2013 09:28:02 +0100
In-Reply-To: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

after upgrading from 0.55.1 to 0.56 some MONs are crashing during the 
upgrade.

I have 3 MONs with 0.55.1, mon.a, mon.b. and mon.c

So now i am upgrading mon.a to 0.56, i restarted mon.a and see that 
mon.c is crashed... so i restarted mon.c and see, now mon.b is crashed, 
after restart all mons are running ?

The Log from mon.b


     -7> 2013-01-03 09:09:02.011229 7fc4d1d00700 -1 mon/PaxosService.cc: 
In function 'void PaxosService::propose_pending()' thread 7fc4d1d00700 
time 2013-01-03 09:09:01.900100
mon/PaxosService.cc: 110: FAILED assert(have_pending)

  ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
  1: /usr/local/bin/ceph-mon() [0x4a6e94]
  2: (MDSMonitor::tick()+0x1a45) [0x4e1245]
  3: (MDSMonitor::on_active()+0x1f) [0x4d67ef]
  4: (PaxosService::_active()+0x245) [0x4a7a95]
  5: (Context::complete(int)+0xa) [0x48bbda]
  6: (finish_contexts(CephContext*, std::list<Context*, 
std::allocator<Context*> >&, int)+0x122) [0x496d72]
  7: (Monitor::recovered_leader(int)+0x378) [0x478ed8]
  8: (Paxos::handle_last(MMonPaxos*)+0xb19) [0x4a3919]
  9: (Paxos::dispatch(PaxosServiceMessage*)+0x27b) [0x4a40fb]
  10: (Monitor::_ms_dispatch(Message*)+0x1298) [0x48ae78]
  11: (Monitor::ms_dispatch(Message*)+0x32) [0x49a932]
  12: (DispatchQueue::entry()+0x2d9) [0x620c19]
  13: (DispatchQueue::DispatchThread::entry()+0xd) [0x5c3a8d]
  14: (()+0x7851) [0x7fc4d65e6851]
  15: (clone()+0x6d) [0x7fc4d4df011d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

     -6> 2013-01-03 09:09:02.044710 7fc4cf7e9700  1 -- 
46.252.23.110:6789/0 >> :/0 pipe(0x477e540 sd=26 :6789 pgs=0 cs=0 
l=0).accept sd=26
     -5> 2013-01-03 09:09:02.219117 7fc4cf4e6700  1 -- 
46.252.23.110:6789/0 >> :/0 pipe(0x4778480 sd=28 :6789 pgs=0 cs=0 
l=0).accept sd=28
     -4> 2013-01-03 09:09:02.462884 7fc4cf3e5700  1 -- 
46.252.23.110:6789/0 >> :/0 pipe(0x4718240 sd=29 :6789 pgs=0 cs=0 
l=0).accept sd=29
     -3> 2013-01-03 09:09:02.848348 7fc4cfcee700  1 -- 
46.252.23.110:6789/0 >> :/0 pipe(0x4718000 sd=30 :6789 pgs=0 cs=0 
l=0).accept sd=30
     -2> 2013-01-03 09:09:02.924980 7fc4ceddf700  2 -- 
46.252.23.110:6789/0 >> 80.67.16.129:6800/31582 pipe(0x471a640 sd=17 
:6789 pgs=22 cs=1 l=1).reader couldn't read tag, Success
     -1> 2013-01-03 09:09:02.925020 7fc4ceddf700  2 -- 
46.252.23.110:6789/0 >> 80.67.16.129:6800/31582 pipe(0x471a640 sd=17 
:6789 pgs=22 cs=1 l=1).fault 0: Success
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
   log_file /var/log/ceph/mon.b.log
--- end dump of recent events ---
2013-01-03 09:09:03.039368 7fc4d1d00700 -1 *** Caught signal (Aborted) **
  in thread 7fc4d1d00700

  ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
  1: /usr/local/bin/ceph-mon() [0x537729]
  2: (()+0xf500) [0x7fc4d65ee500]
  3: (gsignal()+0x35) [0x7fc4d4d3a8a5]
  4: (abort()+0x175) [0x7fc4d4d3c085]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fc4d55f3a5d]
  6: (()+0xbcbe6) [0x7fc4d55f1be6]
  7: (()+0xbcc13) [0x7fc4d55f1c13]
  8: (()+0xbcd0e) [0x7fc4d55f1d0e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x7c9) [0x5cfe39]
  10: /usr/local/bin/ceph-mon() [0x4a6e94]
  11: (MDSMonitor::tick()+0x1a45) [0x4e1245]
  12: (MDSMonitor::on_active()+0x1f) [0x4d67ef]
  13: (PaxosService::_active()+0x245) [0x4a7a95]
  14: (Context::complete(int)+0xa) [0x48bbda]
  15: (finish_contexts(CephContext*, std::list<Context*, 
std::allocator<Context*> >&, int)+0x122) [0x496d72]
  16: (Monitor::recovered_leader(int)+0x378) [0x478ed8]
  17: (Paxos::handle_last(MMonPaxos*)+0xb19) [0x4a3919]
  18: (Paxos::dispatch(PaxosServiceMessage*)+0x27b) [0x4a40fb]
  19: (Monitor::_ms_dispatch(Message*)+0x1298) [0x48ae78]
  20: (Monitor::ms_dispatch(Message*)+0x32) [0x49a932]
  21: (DispatchQueue::entry()+0x2d9) [0x620c19]
  22: (DispatchQueue::DispatchThread::entry()+0xd) [0x5c3a8d]
  23: (()+0x7851) [0x7fc4d65e6851]
  24: (clone()+0x6d) [0x7fc4d4df011d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
     -1> 2013-01-03 09:09:03.039368 7fc4d1d00700 -1 *** Caught signal 
(Aborted) **
  in thread 7fc4d1d00700

  ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
  1: /usr/local/bin/ceph-mon() [0x537729]
  2: (()+0xf500) [0x7fc4d65ee500]
  3: (gsignal()+0x35) [0x7fc4d4d3a8a5]
  4: (abort()+0x175) [0x7fc4d4d3c085]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fc4d55f3a5d]
  6: (()+0xbcbe6) [0x7fc4d55f1be6]
  7: (()+0xbcc13) [0x7fc4d55f1c13]
  8: (()+0xbcd0e) [0x7fc4d55f1d0e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x7c9) [0x5cfe39]
  10: /usr/local/bin/ceph-mon() [0x4a6e94]
  11: (MDSMonitor::tick()+0x1a45) [0x4e1245]
  12: (MDSMonitor::on_active()+0x1f) [0x4d67ef]
  13: (PaxosService::_active()+0x245) [0x4a7a95]
  14: (Context::complete(int)+0xa) [0x48bbda]
  15: (finish_contexts(CephContext*, std::list<Context*, 
std::allocator<Context*> >&, int)+0x122) [0x496d72]
  16: (Monitor::recovered_leader(int)+0x378) [0x478ed8]
  17: (Paxos::handle_last(MMonPaxos*)+0xb19) [0x4a3919]
  18: (Paxos::dispatch(PaxosServiceMessage*)+0x27b) [0x4a40fb]
  19: (Monitor::_ms_dispatch(Message*)+0x1298) [0x48ae78]
  20: (Monitor::ms_dispatch(Message*)+0x32) [0x49a932]
  21: (DispatchQueue::entry()+0x2d9) [0x620c19]
  22: (DispatchQueue::DispatchThread::entry()+0xd) [0x5c3a8d]
  23: (()+0x7851) [0x7fc4d65e6851]
  24: (clone()+0x6d) [0x7fc4d4df011d]
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
   log_file /var/log/ceph/mon.b.log
--- end dump of recent events ---


Norbert

On 01.01.2013 07:02, Sage Weil wrote:
> We're bringing in the new year with a new release, v0.56, which will form
> the basis of the next stable series "bobtail." There is little in the way
> of new functionality since v0.55, as we've been focusing primarily on
> stability, performance, and upgradability from the previous argonaut
> stable series (v0.48.x). If you are a current argonaut user, you can
> either upgrade now, or watch the Inktank blog for the bobtail announcement
> after some additional testing has been completed. If you are a v0.55 or
> v0.55.1 user, we recommend upgrading now.
>
> Notable changes since v0.55 include:
>
>   * librbd: fixes for read-only pools for image cloning
>   * osd: fix for mixing argonaut and post-v0.54 OSDs
>   * osd: some recovery tuning
>   * osd: fix for several scrub, recovery, and watch/notify races/bugs
>   * osd: fix pool_stat_t backwawrd compatibility with pre-v0.41 clients
>   * osd: experimental split support
>   * mkcephfs: misc fixes for fs initialization, mounting
>   * radosgw: usage and op logs off by default
>   * radosgw: keystone authentication off by default
>   * upstart: only enabled with 'upstart' file exists in daemon data
>     directory
>   * mount.fuse.ceph: allow mounting of ceph-fuse via /etc/fstab
>   * config: always complain about config parsing errors
>   * mon: fixed memory leaks, misc bugs
>   * mds: many misc fixes
>
> Notable changes since v0.48.2 ("argonaut"):
>
>   * auth: authentication is now on by default; see release notes!
>   * osd: improved threading, small io performance
>   * osd: deep scrubbing (verify object data)
>   * osd: chunky scrubs (more efficient)
>   * osd: improved performance during recovery
>   * librbd: cloning support
>   * librbd: fine-grained striping support
>   * librbd: better caching
>   * radosgw: improved Swift and S3 API coverage (POST, multi-object delete,
>     striping)
>   * radosgw: OpenStack Keystone integration
>   * radosgw: efficient usage stats aggregation (for billing)
>   * crush: improvements in distribution (still off by default; see CRUSH
>     tunables)
>   * ceph-fuse, mds: general stability improvements
>   * release RPMs for OpenSUSE, SLES, Fedora, RHEL, CentOS
>   * tons and bug fixes and small improvements across the board
>
> If you are upgrading from v0.55, there are no special upgrade
> instructions. If you are upgrading from an older version, please read the
> release notes. Authentication is now enabled by default, and if you do not
> adjust your ceph.conf accordingly before upgrading the system will not
> come up by itself.
>
> You can get this release from the usual locations:
>
>   * Git at git://github.com/ceph/ceph.git
>   * Tarball at http://ceph.com/download/ceph-0.56.tar.gz
>   * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>   * For RPMs, see http://ceph.com/docs/master/install/rpm
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
