From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Suicide
Date: Fri, 15 Apr 2011 13:21:20 -0700
Message-ID: <3704E18884CB47E081E09984151ACC7B@gmail.com>
References: <4DA85AA6.8050707@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55242 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1DOUVY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 16:21:24 -0400
Received: by pwi15 with SMTP id 15so1261531pwi.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 13:21:23 -0700 (PDT)
In-Reply-To: <4DA85AA6.8050707@provocation.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

I looked at your logs and they're very interesting. I suspect the reason your journal broke is because your logging partition filled up, although I can't be sure.
We have seen a similar error once before but were unable to diagnose it because there wasn't enough logging, and it looks like we don't have enough here either. The real problem isn't the failure to finish replay (that's a symptom), but the crash on node01 at 4:35:16.

Can you give me more details about how your cluster was behaving at that time? I can't quite match up what I'm seeing in the logs with your description -- looks like node02 ran out of disk space for logging at ~4:06:30 but I can't see from the logs why they were passing leadership back and forth, or why nothing happened between 4:06 and 4:33.

I'll take a look at the documentation bits later today, too.
-Greg
On Friday, April 15, 2011 at 7:48 AM, Zenon Panoussis wrote:

> Hello again.
> 
> A new day, a new problem:
> 
> ceph version 0.26.commit: 9981ff90968398da43c63106694d661f5e3d07d5. process: cmds. pid: 8613
> 2011-04-15 15:50:11.945105 7fd081c07700 mds-1.0 ms_handle_connect on 192.168.178.100:6789/0
> 2011-04-15 15:50:16.277166 7fd081c07700 mds-1.0 handle_mds_map standby
> 2011-04-15 15:50:17.662254 7fd081c07700 mds-1.0 handle_mds_map standby
> 2011-04-15 15:50:33.050509 7fd081c07700 mds0.41 handle_mds_map i am now mds0.41
> 2011-04-15 15:50:33.050614 7fd081c07700 mds0.41 handle_mds_map state change up:standby --> up:replay
> 2011-04-15 15:50:33.050812 7fd081c07700 mds0.41 replay_start
> 2011-04-15 15:50:33.050908 7fd081c07700 mds0.41 recovery set is
> 2011-04-15 15:50:33.050962 7fd081c07700 mds0.41 need osdmap epoch 184, have 178
> 2011-04-15 15:50:33.051143 7fd081c07700 mds0.cache handle_mds_failure mds0 : recovery peers are
> 2011-04-15 15:50:33.057263 7fd081c07700 mds0.41 ms_handle_connect on 192.168.178.100:6801/8729
> 2011-04-15 15:50:33.071290 7fd081c07700 mds0.41 ms_handle_connect on 192.168.178.101:6801/4572
> 2011-04-15 15:50:33.972268 7fd081c07700 mds0.cache creating system inode with ino:100
> 2011-04-15 15:50:33.972783 7fd081c07700 mds0.cache creating system inode with ino:1
> 2011-04-15 15:50:44.568883 7fd0735fc700 mds0.journaler try_read_entry got 0 len entry at offset 390071095
> 2011-04-15 15:50:44.569039 7fd0735fc700 mds0.log _replay journaler got error -22, aborting
> 2011-04-15 15:50:44.576781 7fd0735fc700 mds0.41 boot_start encountered an error, failing
> 2011-04-15 15:50:44.576871 7fd0735fc700 mds0.41 suicide. wanted up:replay, now down:dne
> 2011-04-15 15:50:44.580226 7fd082c0a720 stopped.
> 
> Last night I mounted the ceph file system OK and started copying data to it.
> Logging was at the sample.ceph.conf defaults, so pretty hefty. The logs go
> to /var/log and the journal is in /var, which in this case are on different
> partitions. At some point copying hung. It was really very late, so instead
> of troubleshooting I switched off the machines and went to bed.
> 
> Today I tried to mount the ceph file system and failed, several times. I then
> found that /var/log was full to the last byte on (only) one of my two nodes.
> I cleaned up and restarted ceph, but trying to mount the file system continued
> giving me "error 5" and the mds log entries above. It looks very much like issue
> 451 reproduced, but I don't grasp the logic of it. It would make more sense if
> the journal had been on the full partition, but it wasn't.
> 
> cmds [-i node01|mds.node01|0] -c /etc/ceph/ceph.conf --journal_check -f
> returns a usage message and no error, no matter if/how I specify the name
> and/or -m IP:6789. What's the correct syntax for it?
> 
> The full logs (what's now left of them) are at
> http://www.provocation.net/tmp/mds_logs.tar.bz2 . Is there anything I can do
> to solve this, apart from re-creating the file system?
> 
> ceph 0.26, kernel 2.38.2, ext4, ceph.conf as posted yesterday in the "Mounting"
> thread but without auth.
> 
> Z
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

