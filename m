From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph stability
Date: Wed, 19 Dec 2012 07:26:54 -0600
Message-ID: <50D1C09E.9000504@inktank.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34365 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2LSN0x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 08:26:53 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so2709946iea.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 05:26:53 -0800 (PST)
In-Reply-To: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/19/2012 03:03 AM, Roman Hlynovskiy wrote:
> Hello,
>
> I have 2 issues with ceph stability and looking for help to resolve them.
> My setup is pretty simple - 3 debian 32bit stable systems each running
> osd, mon and mds.
> the conf is the following:
> --------------------
> [global]
>      auth cluster required = none
>      auth service required = none
>      auth client required = none
>
> [osd]
>      osd journal size = 1000
>      filestore xattr use omap = true
>
> [mon.a]
>      host = ceph-node01
>      mon addr = 192.168.7.11:6789
>
> [mon.b]
>      host = ceph-node02
>      mon addr = 192.168.7.12:6789
>
> [mon.c]
>          host = ceph-node03
>          mon addr = 192.168.7.13:6789
>
> [mds.a]
>          host = ceph-node01
>
> [mds.b]
>          host = ceph-node02
>
> [mds.c]
>          host = ceph-node03

A quicky side-node:  multi-mds solutions aren't being supported in 
production right now.  Not sure if your stat problems below are related, 
but you may want to try starting out with a single mds and see if the 
problem goes away.  If so, there may be some hints in the mds logs 
regarding what's going on.  Bug reports are welcome!

>
> [osd.0]
>      host = ceph-node01
>
> [osd.1]
>      host = ceph-node02
>
> [osd.2]
>      host = ceph-node03
> --------------------
> ceph -s is:
>     health HEALTH_OK
>     monmap e4: 3 mons at
> {a=192.168.7.11:6789/0,b=192.168.7.12:6789/0,c=192.168.7.13:6789/0},
> election epoch 118, quorum 0,1,2 a,b,c
>     osdmap e197: 3 osds: 3 up, 3 in
>      pgmap v43305: 384 pgs: 384 active+clean; 72351 MB data, 144 GB
> used, 105 GB / 249 GB avail
>     mdsmap e4439: 1/1/1 up {0=a=up:active}, 2 up:standby
> --------------------
>
> My first problem - I am getting spurious mon's deaths, which usually
> looks like this:
>
> --- begin dump of recent events ---
>       0> 2012-12-19 10:35:58.912119 b41eab70 -1 *** Caught signal (Aborted) **
>   in thread b41eab70
>
>   ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
>   1: /usr/bin/ceph-mon() [0x8183a11]
>   2: [0xb7714400]
>   3: (gsignal()+0x47) [0xb7337577]
>   4: (abort()+0x182) [0xb733a962]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x14f) [0xb755653f]
>   6: (()+0xbd405) [0xb7554405]
>   7: (()+0xbd442) [0xb7554442]
>   8: (()+0xbd581) [0xb7554581]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x80f) [0x824cabf]
>   10: /usr/bin/ceph-mon() [0x80e3c1d]
>   11: (MDSMonitor::tick()+0x1e3b) [0x811ea0b]
>   12: (MDSMonitor::on_active()+0x1d) [0x81188dd]
>   13: (PaxosService::_active()+0x212) [0x80e4b02]
>   14: (Context::complete(int)+0x19) [0x80c4cf9]
>   15: (finish_contexts(CephContext*, std::list<Context*,
> std::allocator<Context*> >&, int)+0x13f) [0x80d208f]
>   16: (Monitor::recovered_leader(int)+0x3ac) [0x80ac5ac]
>   17: (Paxos::handle_last(MMonPaxos*)+0xb02) [0x80e0572]
>   18: (Paxos::dispatch(PaxosServiceMessage*)+0x2c4) [0x80e0e94]
>   19: (Monitor::_ms_dispatch(Message*)+0x1181) [0x80c3b11]
>   20: (Monitor::ms_dispatch(Message*)+0x31) [0x80d5021]
>   21: (DispatchQueue::entry()+0x337) [0x82afa47]
>   22: (DispatchQueue::DispatchThread::entry()+0x20) [0x823eec0]
>   23: (Thread::_entry_func(void*)+0x11) [0x824be41]
>   24: (()+0x57b0) [0xb75ef7b0]
>   25: (clone()+0x5e) [0xb73d8cde]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
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
>    max_recent    100000
>    max_new         1000
>    log_file /var/log/ceph/ceph-mon.a.log
> --- end dump of recent events ---
>
> the binaries are coming from ceph.com debian-testing repo.
>
> My second problem - I have 2 systems which mount ceph. Whenever I
> mount ceph on any other system it usually mounts but get stuck on
> stat* operations (i.e. simple ls -al will hang with read( from the
> ceph-mounted directory for ages). This kind of client stuck also
> affects two working clients. they also start to stuck on the stat*
> even after shutdown of the third client. so usually umount/mount or
> even reboot for existing clients solves the issue)
>
>
> --
> ...WBR, Roman Hlynovskiy
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

