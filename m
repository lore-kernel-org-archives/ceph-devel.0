From: Zenon Panoussis <oracle@provocation.net>
Subject: Suicide
Date: Fri, 15 Apr 2011 16:48:06 +0200
Message-ID: <4DA85AA6.8050707@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:47948 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1DOOsN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 10:48:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hello again.

A new day, a new problem:

ceph version 0.26.commit: 9981ff90968398da43c63106694d661f5e3d07d5. process: cmds. pid: 8613
2011-04-15 15:50:11.945105 7fd081c07700 mds-1.0 ms_handle_connect on 192.168.178.100:6789/0
2011-04-15 15:50:16.277166 7fd081c07700 mds-1.0 handle_mds_map standby
2011-04-15 15:50:17.662254 7fd081c07700 mds-1.0 handle_mds_map standby
2011-04-15 15:50:33.050509 7fd081c07700 mds0.41 handle_mds_map i am now mds0.41
2011-04-15 15:50:33.050614 7fd081c07700 mds0.41 handle_mds_map state change up:standby --> up:replay
2011-04-15 15:50:33.050812 7fd081c07700 mds0.41 replay_start
2011-04-15 15:50:33.050908 7fd081c07700 mds0.41  recovery set is
2011-04-15 15:50:33.050962 7fd081c07700 mds0.41  need osdmap epoch 184, have 178
2011-04-15 15:50:33.051143 7fd081c07700 mds0.cache handle_mds_failure mds0 : recovery peers are
2011-04-15 15:50:33.057263 7fd081c07700 mds0.41 ms_handle_connect on 192.168.178.100:6801/8729
2011-04-15 15:50:33.071290 7fd081c07700 mds0.41 ms_handle_connect on 192.168.178.101:6801/4572
2011-04-15 15:50:33.972268 7fd081c07700 mds0.cache creating system inode with ino:100
2011-04-15 15:50:33.972783 7fd081c07700 mds0.cache creating system inode with ino:1
2011-04-15 15:50:44.568883 7fd0735fc700 mds0.journaler try_read_entry got 0 len entry at offset 390071095
2011-04-15 15:50:44.569039 7fd0735fc700 mds0.log _replay journaler got error -22, aborting
2011-04-15 15:50:44.576781 7fd0735fc700 mds0.41 boot_start encountered an error, failing
2011-04-15 15:50:44.576871 7fd0735fc700 mds0.41 suicide.  wanted up:replay, now down:dne
2011-04-15 15:50:44.580226 7fd082c0a720 stopped.

Last night I mounted the ceph file system OK and started copying data to it.
Logging was at the sample.ceph.conf defaults, so pretty hefty. The logs go
to /var/log and the journal is in /var, which in this case are on different
partitions. At some point copying hung. It was really very late, so instead
of troubleshooting I switched off the machines and went to bed.

Today I tried to mount the ceph file system and failed, several times. I then
found that /var/log was full to the last byte on (only) one of my two nodes.
I cleaned up and restarted ceph, but trying to mount the file system continued
giving me "error 5" and the mds log entries above. It looks very much like issue
451 reproduced, but I don't grasp the logic of it. It would make more sense if
the journal had been on the full partition, but it wasn't.

cmds [-i node01|mds.node01|0] -c /etc/ceph/ceph.conf --journal_check -f
returns a usage message and no error, no matter if/how I specify the name
and/or -m IP:6789. What's the correct syntax for it?

The full logs (what's now left of them) are at
http://www.provocation.net/tmp/mds_logs.tar.bz2 . Is there anything I can do
to solve this, apart from re-creating the file system?

ceph 0.26, kernel 2.38.2, ext4, ceph.conf as posted yesterday in the "Mounting"
thread but without auth.

Z



