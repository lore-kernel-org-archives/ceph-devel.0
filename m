From: Mark Nigh <mnigh@netelligent.com>
Subject: MDS Replay Issues
Date: Thu, 30 Jun 2011 16:41:34 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C65@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:2690 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752597Ab1F3Vlk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jun 2011 17:41:40 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I build a new cluster today with the latest commit

ceph version 0.30-222-g310032e (commit:310032ee8128f6417ac302c0f5ecd27c691cbcc7)

I had a working file system until I created another mds on my second node. At that time, both mds were in active (which I think is incorrect) so I rebooted the second mds in the hopes it would go to standby, but it went into replay. I rebooted the first mds and that is now in replay.

root@ceph00:/var/log/ceph# ceph -s
2011-06-30 16:40:10.000802    pg v613: 1188 pgs: 1188 active+clean; 43 KB data, 22160 KB used, 33442 GB / 33466 GB avail
2011-06-30 16:40:10.003563   mds e22: 2/2/2 up {0=0=up:replay,1=1=up:replay}
2011-06-30 16:40:10.003602   osd e44: 12 osds: 12 up, 12 in
2011-06-30 16:40:10.003686   log 2011-06-30 16:13:54.782061 mon0 10.6.1.80:6789/0 5 : [INF] mds? 10.6.1.80:6800/6886 up:boot
2011-06-30 16:40:10.003770   mon e1: 1 mons at {0=10.6.1.80:6789/0}

The replay has been happening a lot lately so I expect I am doing something wrong. Here is the end of the mds logs.

2011-06-30 16:13:50.650812 7f199aa27760 ceph version 0.30-222-g310032e.commit: 310032ee8128f6417ac302c0f5ecd27c691cbcc7. process: cmds. pid: 6886
2011-06-30 16:13:50.652738 7f199774a700 mds-1.0 ms_handle_connect on 10.6.1.80:6789/0
2011-06-30 16:13:54.782292 7f199774a700 mds-1.0 handle_mds_map standby
2011-06-30 16:14:02.580014 7f199774a700 mds0.3 handle_mds_map i am now mds0.3
2011-06-30 16:14:02.580035 7f199774a700 mds0.3 handle_mds_map state change up:standby --> up:replay
2011-06-30 16:14:02.580042 7f199774a700 mds0.3 replay_start
2011-06-30 16:14:02.580055 7f199774a700 mds0.3  recovery set is 1
2011-06-30 16:14:02.580063 7f199774a700 mds0.3  need osdmap epoch 43, have 42
2011-06-30 16:14:02.580070 7f199774a700 mds0.3  waiting for osdmap 43 (which blacklists prior instance)
2011-06-30 16:14:02.580100 7f199774a700 mds0.cache handle_mds_failure mds0 : recovery peers are 1

Thanks for your help.

Mark Nigh
Systems Architect
mnigh@netelligent.com
 (p) 314.392.6926



This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
