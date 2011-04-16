From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Sun, 17 Apr 2011 01:50:16 +0200
Message-ID: <4DAA2B38.1090706@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com> <4DA8D4EF.8090006@provocation.net> <25103BE141804650A169B6444F0D6D21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:42069 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab1DPXuV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Apr 2011 19:50:21 -0400
In-Reply-To: <25103BE141804650A169B6444F0D6D21@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/16/2011 02:00 AM, Gregory Farnum wrote:

> If you want to try to reproduce it for us in a useful fashion we'd 
> love that. 

I think I reproduced it, kind of. I got the hang and "error 5" on mount,
but not the journal corruption. This is the timeline:

ca 19:19: Restarted ceph, mounted it, started rsync. There were already
          a few hundred thousand files on the ceph mount, forcing rsync
          to do a read/compare for them all for about 20 minutes while
          ceph was producing gigabytes of useless logs.

ca 19:50: rsync begun copying new files at full speed.

ca 19:56: rsync hung; node01 load 6+, node02 load 0.15, osd partitions
          (i.e. the underlying ext4 partitions) stuck at differing sizes
          and not growing.

ca 20:01: rsync still hanging, node01 load 7.80, node02 load 0.08, osd
          partitions still different and not growing.

ca 20:07: rsync still hanging, node01 load 8.00, node02 load 0.00, osd
          partitions still different and not growing. Killed rsync:

feednews/time-00/40/05/7bb1-4696
        1697 100%    3.61kB/s    0:00:00 (xfer#3469, to-check=2515/339251)
feednews/time-00/40/05/7bb2-4696
        1691 100%    3.59kB/s    0:00:00 (xfer#3470, to-check=2514/339251)
feednews/time-00/40/05/7bb3-4696
        3476 100%    7.38kB/s    0:00:00 (xfer#3471, to-check=2513/339251)
feednews/time-00/40/05/7bb4-4696
^CKilled by signal 2.


ca 20:09: umount /ceph: device busy; lsof |grep /ceph stuck, not even
          responding to ^C.

ca 20:11: ca 20:09: umount /ceph OK, service stop -a ceph OK, osd partitions
          still at the same size as at 19:56.

ca 20:12: service ceph -a start OK, both osd partitions now started growing,
          mount mon:port /ceph gives error 5.

A couple of minutes later the osd partitions stabilized at the same size
and mounting ceph succeeded without problems.

I'm speculating that something deadlocked unrecoverably at 19:56, leaving
different data in the journals. Restarting ceph removed the deadlock and
allowed the journals to flush, restoring proper operation.

I no longer remember exactly what I did last time, but it's very likely
that I unmounted and stopped ceph before switching off the machines on
Thursday night, but kept restarting it on Friday when I couldn't mount it,
not giving it enough time to flush its journals between each failed mount
attempt and the next restart, until somehow the journals got corrupted.

You see above that the last file that appeared to be successfully transferred
by rsync this evening was feednews/time-00/40/05/7bb3-4696, which shows up
in the logs at 19:55:45.746146. However, the logs also say that another ~4000
files were transferred between rsync's apparent hang and my ^C. Those must be
the ones that ended up lingering in the journal. If they were written to the
journal but not to the OSD, I believe rsync should still have gotten a "write
OK" back from ceph, but it seems it didn't.

Anyway, trying to read and understand huge logs when you don't even know
what the log entries mean or what you're looking for, is very tiring and
not very efficient, so I'll call it a day for now.  I'd appreciate it if
you could give me some hints on what to look for, so I can go hunting again
in a more focused manner. In the meanwhile I've put the new logs at
http://www.provocation.net/tmp/logs_take_2.tar.bz2 for you.

Z


