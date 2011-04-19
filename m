From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Logging
Date: Tue, 19 Apr 2011 02:10:44 +0200
Message-ID: <4DACD304.4010000@provocation.net>
References: <4DAB77FD.4010804@provocation.net>	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>	<4DAC0EE7.4080001@provocation.net>	<BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>	<4DAC8021.6000701@provocation.net>	<BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>	<4DACA57E.2040609@provocation.net> <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:45617 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1DSAKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 20:10:48 -0400
In-Reply-To: <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/19/2011 12:25 AM, Colin McCabe wrote:

> I'm curious how much you saved by disabling logging. 

To be honest, I have no idea.

> Also, how are you measuring performance?

My measuring is very primitive and un-scientific (which is why I couldn't
answer your previous question). I have a two-node cluster with rule data
{ min_size 2 } and rule metadata { min_size 2 }. My ceph.conf says
osd data = /mnt/osd and the latter is an ext4 partition of its own on
each node. One monitor is running on one of the nodes and one client is
running on my workstation.

So what I do is mount the monitor, run 'watch "df -m; echo; uptime"' on both
nodes and start copying files to ceph with rsync. I have a news spool of just
over a million small (1-3 KB) files which is perfect for the task. The rsync
command is

 rsync -vva --progress --bwlimit=N newsspool 127.0.0.1:/mnt/ceph/

where N is a number in KBps ranging from max 500 all the way down to 5. This
gives me something like

===
Every 2.0s: df -m; echo; uptime                        Tue Apr 19 01:19:12 2011

Filesystem           1M-blocks      Used Available Use% Mounted on
/dev/sda1                15019      3768     10489  27% /
tmpfs                      993         0       993   0% /dev/shm
/dev/sda2                 7510      1342      5787  19% /var
/dev/sda5                15019      1777     12480  13% /var/log
/dev/mapper/sda6        232003      5571    213174   3% /mnt/osd

 01:19:12 up 1 day,  2:25,  1 user,  load average: 0.91, 1.12, 1.75
===

on each node and a fair idea of what the client is doing at the same time.
The reason for using 127.0.0.1 as the target is that delta transfers and
bwlimit do not apply to local tagets, so

rsync -vva --progress --bwlimit=N newsspool /mnt/ceph/

which in principle is equivalent, would just run full speed and re-copy
everything that's not already on the target.

The load is the prime measure. When I see load 16 on a dual-CPU system,
I know that things are getting out of hand before anything even breaks.
Then I lower bwlimit and start again.

The relation between OSD partitions (/dev/mapper/sda6 in the example above)
is another interesting factor. As long as the load is under 100%, the
partitions on both nodes grow in almost perfect sync. When the load exceeds
100%, one node starts lagging behind the other. If that continues long enough,
the lagging node falls out completely while the other node keeps growing.
I've seen differences of almost 300% (11 GB on node02 and 4 GB on node01)
which won't go away until a full ceph restart followed by a few hours of
replaying patience.

Interestingly, the node with the monitor that actually receives the data
(node01) is the one unable to write them to its own disk, while the other
node (node02) grows way ahead. I'm not sure yet, but the likely cause of
this is that the network speed of node01 and the disk speed of node02 both
exceed the disk speed of node01. In any case, a load above 100% is not a
reason for concern all and by itself, but the node storages growing out of
sync is. If that goes far enough, the nodes are unable to synchronise again
without an unmount and full restart of ceph and in the worst case scenario
the data is corrupted.

Now, having run rsync for a while, I kill it and start it again. This will
cause it to compare all files that are already on the target, skip those
that have identical size and near-identical mtime, and only copy files that
are either missing or different. Assuming for example that I successfully
copied 200.000 files in the first run, the second run will compare 200.000
files and start copying again from the 200.001:st file on.

This is where I could really see the difference between atime and noatime on
the OSD underlying partition. bwlimit is meaningless on size and mtime reads,
so the client would read file attributes at full blast. With atime on the
underlying partition this caused the nodes to jump to loads of 5 or more. With
noatime, they displayed a load of 0.1 or so and the whole compare opration
completed in a small fraction of the time previously required.

Z

