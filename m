From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Autotest results from 2011-03-21
Date: Mon, 21 Mar 2011 13:41:21 -0700
Message-ID: <20110321204121.GD17804@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51876 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab1CUUlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 16:41:24 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 53A9D2C173
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 13:41:24 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So, we have 10 filesystem tests plugged into Autotest. I scheduled
them for execution, with 6-node clusters (because that's easy for me
to do, and there's only one client creating load anyway), before I
left work last Friday. Summary of results is at the end of this email.

The DNS errors are probably related to the network outage we had on
that LAN.

Note for non-staff readers, sorry but you won't have access to
Autotest.

** ceph_blogbench (job 249) TRANSIENT FAILURE
DNS errors, rerunning test as job 264
** ceph_dbench (job 251) TRANSIENT FAILURE
DNS errors, rerunning test as job 262
** ceph_direct_io_test (job 252) TRANSIENT FAILURE
DNS errors, rerunning test as job 261
** ceph_ffsb (job 253) SUCCESS
captures performance info but does not analyze it
http://autotest.ceph.newdream.net/results/253-tv/group0/sepia23.ceph.dreamhost.com/ffsb/debug/ffsb.DEBUG
** ceph_fsstress (job 254) SUCCESS
** ceph_fsx (job 255) SUCCESS
** ceph_iozone (job 256) SUCCESS
captures & analyzes performance info
http://autotest.ceph.newdream.net/results/256-tv/group0/sepia82.ceph.dreamhost.com/iozone/results/keyval
** ceph_pjd_fstest (job 257) FAILURE
http://tracker.newdream.net/issues/906
** ceph_tiobench (job 258) FAILURE, TRANSIENT?
failure on client node
test software exited 255 after 488 seconds
http://autotest.ceph.newdream.net/results/258-tv/group0/sepia81.ceph.dreamhost.com/status
Run #1: ./tiotest -t 10 -f 102 -r 400 -b 4096 -d /usr/local/autotest/tmp/tmpno6nA__ceph_tiobench.cluster0/mnt.0 -T
Run #2: ./tiotest -t 10 -f 102 -r 400 -b 4096 -d /usr/local/autotest/tmp/tmpno6nA__ceph_tiobench.cluster0/mnt.0 -T
Illegal division by zero at ./tiobench.pl line 170.
*** debugging
sed -n '170,172p' < tiobench.pl
               $stat_data{$identifier}{$thread}{$size}{$block}{$field}{'cpueff'} =
                  ($stat_data{$identifier}{$thread}{$size}{$block}{$field}{'rate'} /
                  ($stat_data{$identifier}{$thread}{$size}{$block}{$field}{'cpu'}/100));
*** conclusion
tiobench internal bug? re-running test as job 260
** ceph_bonnie (job 259) TRANSIENT FAILURE
DNS errors, rerunning test as job 263

-- 
:(){ :|:&};:
