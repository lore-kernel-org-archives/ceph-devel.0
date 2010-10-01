From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: error during mds replay
Date: Fri, 1 Oct 2010 12:50:19 +0800
Message-ID: <AANLkTikptuMyEH0fV4qJ9=cu3yALSjieYrAPiNgyzLyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52619 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0JAEuV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Oct 2010 00:50:21 -0400
Received: by qyk36 with SMTP id 36so2726631qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Sep 2010 21:50:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Today I found that all my ceph clients are not able to 'ls' the ceph
mount point.
Since all ceph daemons are alive, I decided to restart the MDS to see
if it helps.
Unfortunately, MDS is never coming back again. It got an error during
replay every time.

The last few lines of MDS log shows:

2010-10-01 03:30:59.816017 7f991dcf7710 mds0.journaler try_read_entry
at 822192580 reading 822192580~4 (have 160437)
2010-10-01 03:30:59.816022 7f991dcf7710 mds0.journaler try_read_entry
got 0 len entry at offset 822192580
2010-10-01 03:30:59.816026 7f991dcf7710 mds0.log _replay journaler got
error -22, aborting
2010-10-01 03:30:59.816030 7f991dcf7710 mds0.log _replay_thread kicking waiters
2010-10-01 03:30:59.816034 7f991dcf7710 mds0.18 boot_start encountered
an error, failing
2010-10-01 03:30:59.816038 7f991dcf7710 mds0.18 suicide.  wanted
up:replay, now down:dne
2010-10-01 03:30:59.816047 7f991dcf7710 mds0.cache WARNING: mdcache
shutdown with non-empty cache
2010-10-01 03:30:59.816052 7f991dcf7710 mds0.cache show_subtrees
2010-10-01 03:30:59.816059 7f991dcf7710 mds0.cache |__ 0    auth [dir
1 / [2,head] auth v=327474 cv=0/0 dir_auth=0 state=1610612736 f(v5
m2010-09-30 10:42:48.462366 5=0+5) n(v5922 rc2010-10-01
02:32:18.156019 b129532745664 784=23+761)/n(v5922 rc2010-10-01
02:32:18.156019 b129521095616 784=23+761) hs=1+0,ss=0+0 dirty=1 |
child subtree dirty 0x7f98e8006ae0]
2010-10-01 03:30:59.816078 7f991dcf7710 mds0.cache |__ 0    auth [dir
100 ~mds0/ [2,head] auth v=795 cv=0/0 dir_auth=0 state=1610612736 f(v0
2=1+1) n(v54 rc2010-10-01 02:07:56.696257 b1883380490265 372=365+7)
hs=1+0,ss=0+0 dirty=1 | child subtree dirty 0x7f98e80070f0]
2010-10-01 03:30:59.816094 7f991dcf7710 mds0.log _replay_thread finish
2010-10-01 03:30:59.816129 7f992d903710 mds0.18 handle_mds_beacon
up:replay seq 3 rtt 7.483578
2010-10-01 03:30:59.816571 7f9930405720 7f9930405720 stopped.

I am wondering if there is a way to recover back from this situation.
Thanks,

Henry
