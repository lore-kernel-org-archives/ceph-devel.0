From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: Ceph watchdog-like thing to reduce IO block during process goes down
 by abort()
Date: Thu, 24 Mar 2016 07:00:31 +0000
Message-ID: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.153]:12491 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109AbcCXHIA convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Mar 2016 03:08:00 -0400
Received: from R01UKEXCASM226.r01.fujitsu.local (ex2k13_226.fs.fujitsu.com [10.182.185.124])
	by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id u2O6sxks010068
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 06:55:08 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers!

Currently when we had a disk failure, assert() and then abort() was triggered and process was killed (ABRT). Other osds will eventually mark dead one as down, but it depends of heartbeat settings and monitor settings (mon_osd_min_down_reporters/mon_osd_min_down_reports). During dead-not-marked-as-down osd you can see blocked IO during writes and reads.

Recently I've made https://github.com/ceph/ceph/pull/7740 which is about sending MakrMeDown msg to monitor just before osd is going bye-bye. It prevents blocked IO in above case, and any other assert that is not on message sending path, so I need messenger/pipes/connections working for this. I've made some test and it looks good, when I pull out drive from my cluster during rados bench, IO blocks for less than 1 second or not at all, previously it was > 10 sec (on my cluster settings).

Sage pointed me that some time ago was similar PR https://github.com/ceph/ceph/pull/6514 and there was a thought about ceph-watchdog process, that could monitor osd's and send info directly to monitor when they disappear. This would prevent all assert() cases, and other ones like kill -9 or similar.

I have a few ideas how such functionality could be implemented, so my question is - does any of you started already doing something similar?

Let's have a brain storm about it!

Ideas about improving 7740/6514 MarkMeDown internal mechanism:
- I think, I could send message with MarkMeDown payload, but in a raw way, not through Messenger path. This could be as good as bad in this case.
- I could poke osd-neighbor through signal and neighbor will send Mark(SignalSender)Down message (this won't work If whole hdd controller will be down, all osd will be dead in narrow time window). So it's like instant bad-health heartbeat message. Still depends of Messenger send path of osd-neighbor.

External ceph-watchdog:
Just like Sage wrote https://github.com/ceph/ceph/pull/6514#issuecomment-159372845 Or similar: each osd, during start passes its own PID to ceph-watchdog process through shared memory/socket/named pipe (whatever). Ceph-watchdog checks if current PID exists, by checking changes in /proc/PID or /proc/PID/cmd directory/file (maybe Inotify could handle this). When file or folder is changed(missing) it sends MarkThisOsdDown to monitor and that's all. But this won't be watchdog strict, rather process down notify. 

Or maybe both ways PR7740 + external ?

Regards,
Igor.
