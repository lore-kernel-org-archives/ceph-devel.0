From: Tren Blackburn <tren@eotnetworks.com>
Subject: mds stuck in replay state
Date: Thu, 20 Sep 2012 09:42:52 -0700
Message-ID: <CANLRBoxaESrraRaQibJbuS3y27Md=GpRpVb_7GCAFvD5EkXrOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45708 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2ITQmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Sep 2012 12:42:53 -0400
Received: by vcbfo13 with SMTP id fo13so2825500vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Sep 2012 09:42:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List;

Still rsyncing the same data as the last ticket. However the mds for
some reason is stuck in "replay" state. I've tried restarting the mds
process to get it to fail over to another node, but regardless of
which node is the active mds, it still is in replay state. Not sure
how to diagnose this further. This is what I see in the logs:

2012-09-20 09:34:46.366127 7f749fade780  0 ceph version 0.51
(commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30), process ceph-mds,
pid 11115
2012-09-20 09:34:46.368248 7f749aaec700  0 mds.-1.0 ms_handle_connect
on 10.87.1.104:6789/0
2012-09-20 09:34:46.505150 7f749aaec700  1 mds.-1.0 handle_mds_map standby
2012-09-20 09:38:57.987721 7f749aaec700  1 mds.0.14 handle_mds_map i
am now mds.0.14
2012-09-20 09:38:57.987724 7f749aaec700  1 mds.0.14 handle_mds_map
state change up:standby --> up:replay
2012-09-20 09:38:57.987727 7f749aaec700  1 mds.0.14 replay_start
2012-09-20 09:38:57.987736 7f749aaec700  1 mds.0.14  recovery set is
2012-09-20 09:38:57.987741 7f749aaec700  1 mds.0.14  need osdmap epoch
356, have 310
2012-09-20 09:38:57.987743 7f749aaec700  1 mds.0.14  waiting for
osdmap 356 (which blacklists prior instance)
2012-09-20 09:38:57.987783 7f749aaec700  1 mds.0.cache
handle_mds_failure mds.0 : recovery peers are
2012-09-20 09:38:58.282446 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.104:6852/32172
2012-09-20 09:38:58.282495 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.96:6809/12082
2012-09-20 09:38:58.282562 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.103:6854/24256
2012-09-20 09:38:58.282661 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.93:6800/2661
2012-09-20 09:38:58.284226 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.95:6812/17871
2012-09-20 09:38:58.284258 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.90:6815/8616
2012-09-20 09:38:58.304331 7f749aaec700  0 mds.0.14 ms_handle_connect
on 10.87.1.100:6848/16139
2012-09-20 09:38:58.314442 7f749aaec700  0 mds.0.cache creating system
inode with ino:100
2012-09-20 09:38:58.314695 7f749aaec700  0 mds.0.cache creating system
inode with ino:1

The cluster is currently IO locked. Looks like the mds server isn't
that stable yet. I haven't managed to have a single failover between
mds's go smoothly yet.

Thanks in advance for your help!

t.
