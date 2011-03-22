From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Autotest results from 2011-03-22
Date: Tue, 22 Mar 2011 10:24:19 -0700
Message-ID: <20110322172419.GB8083@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49788 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab1CVRYU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2011 13:24:20 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 81A3C2C173
	for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2011 10:24:20 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These are the reruns of the DNS-related failures from yesterday.

* autotest summary 2011-03-22
** ceph_tiobench (job 260) FAIL
03/21 13:22:36 DEBUG|base_utils:0074| Running '/usr/local/autotest/tests/download/ceph_newdream_net_8116_tarball_master/ceph_tiobench/usr/local/sbin/mount.ceph 10.3.14.140:6789,10.3.14.142:6790,10.3.14.148:6791:/ /usr/local/autotest/tmp/tmpwkTP5q_ceph_tiobench.cluster0/mnt.0 -v -o name=0,secret=AQA7s4dN2B3mBRAAnL8OJOzsSXNm6djT2Wq0kw=='
03/21 13:23:36 DEBUG|base_utils:0106| [stdout] parsing options: name=0,secret=AQA7s4dN2B3mBRAAnL8OJOzsSXNm6djT2Wq0kw==
03/21 13:23:36 DEBUG|base_utils:0106| [stdout] ceph: Unknown mount option name
03/21 13:23:36 DEBUG|base_utils:0106| [stdout] ceph: Unknown mount option secret
03/21 13:23:36 DEBUG|base_utils:0106| [stdout] mount error 5 = Input/output error
*** mount.ceph should silently ignore name, secret
http://tracker.newdream.net/issues/914
*** TODO why did mount fail with EIO? hard to tell without debug messages, but timeouts could cause it
rerunning as job 265
** ceph_direct_io_test (job 261)
14:08:37 DEBUG| Running '/usr/local/autotest/tests/direct_io_test/src/direct_io_test'
14:08:48 DEBUG| [stdout] ..........
14:08:48 DEBUG| [stdout] do_o_direct_reads: SUCCESS
14:08:48 INFO | Test finished after 1 iterations.

but

14:08:48 INFO | CmdError: Command <grep MemTotal /proc/meminfo> failed, rc=-11, Command returned non-zero exit status

grep segfaulting? ssh closes connections early. serial console fails too!

sepia63 login: ubuntu
Segmentation fault (core dumped)
Segmentation fault (core dumped)
Segmentation fault (core dumped)
Linux sepia63 2.6.35-27-generic #48-Ubuntu SMP Tue Feb 22 20:25:46 UTC 2011 x86_64 GNU/Linux


Welcome to Ubuntu!
 * Documentation:  https://help.ubuntu.com/

Ubuntu 10.10 sepia63 ttyS0

sepia63 login: 

i have seen this before, cause is still unclear.. powercycling
rerunning as job 266
** ceph_dbench (job 262) SUCCESS
captures & analyzes performance info
http://autotest.ceph.newdream.net/results/262-tv/group0/sepia69.ceph.dreamhost.com/dbench/results/keyval
** ceph_bonnie (job 263) HUNG?
hanging in kclient?
kernel doesn't have CONFIG_DYNAMIC_DEBUG
*** TODO left running in case we come up with how to debug
** ceph_blogbench (job 264) HUNG
osd threads in poll() of pthread_condwait()
sjust is on it
not in issue tracker yet

-- 
:(){ :|:&};:
