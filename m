From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Logging
Date: Tue, 19 Apr 2011 13:19:41 +0200
Message-ID: <4DAD6FCD.5070105@provocation.net>
References: <4DAB77FD.4010804@provocation.net> <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com> <4DAC0EE7.4080001@provocation.net> <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com> <4DAC8021.6000701@provocation.net> <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com> <4DACA57E.2040609@provocation.net> <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com> <4DACD304.4010000@provocation.net> <Pine.LNX.4.64.1104182154160.13931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:43747 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab1DSLTo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 07:19:44 -0400
In-Reply-To: <Pine.LNX.4.64.1104182154160.13931@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/19/2011 07:02 AM, Sage Weil wrote:

>> The relation between OSD partitions (/dev/mapper/sda6 in the example above)
>> is another interesting factor. As long as the load is under 100%, the
>> partitions on both nodes grow in almost perfect sync. When the load exceeds
>> 100%, one node starts lagging behind the other. If that continues long enough,
>> the lagging node falls out completely while the other node keeps growing.

> This is really interesting.  This is on the partitions that have _just_ 
> the OSD data? 

Yes, with a couple of extra layers. node01 keeps its OSD data on an ext4
filesystem on top of a dm-crypt encrypted native disk partition. node02
on the other hand has an mdadm RAID0 of two partitions on separate disks
with dm-crypt and ext4 on top of that. This layering - in particular the
encryption - consumes CPU and can slow down things, but for the rest it's
rock-solid; I've been running systems with these setups for years and
never had a problem with them even once.

Here's an example from this morning:

node01:
/dev/mapper/sda6        232003      5914    212830   3% /mnt/osd

node02:
/dev/mapper/md4         225716      5704    207112   3% /mnt/osd

client:
192.168.178.100:6789:/
                        232002      5913    212829   3% /mnt/n01

You can see that the total space on the client corresponds to that of node01,
so the osd of node02 has gone belly up. The load on node01 is creeping upwards
of 200% while rsync on the client keeps smiling and pushing data.

node01 top:
PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
24793 root      20   0 1679m 510m 1756 S  9.2 25.7  29:23.11 cosd
30235 root      20   0     0    0    0 S  1.0  0.0   0:01.10 kworker/0:1
  637 root      20   0     0    0    0 S  0.7  0.0   4:56.26 jbd2/sda2-8
30468 root      20   0 14988 1152  864 R  0.7  0.1   0:00.14 top
21748 root      20   0  104m  796  504 S  0.3  0.0   1:04.27 watch
29418 root      20   0     0    0    0 S  0.3  0.0   0:02.12 kworker/0:2

node01 iotop:
  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    COMMAND
24933 be/4 root      109.97 K/s    7.12 K/s  0.00 % 95.49 % cosd -i 0 -c ~ceph/ceph.conf
24934 be/4 root       94.15 K/s    7.12 K/s  0.00 % 92.45 % cosd -i 0 -c ~ceph/ceph.conf
24830 be/4 root        0.00 B/s   36.39 K/s  0.00 % 81.10 % cosd -i 0 -c ~ceph/ceph.conf
  637 be/3 root        0.00 B/s    0.00 B/s  0.00 % 80.27 % [jbd2/sda2-8]
  256 be/3 root        0.00 B/s    2.37 K/s  0.00 % 72.93 % [jbd2/sda1-8]
24831 be/4 root        0.00 B/s    0.00 B/s  0.00 % 27.85 % cosd -i 0 -c ~ceph/ceph.conf
24826 be/4 root        0.00 B/s  272.94 K/s  0.00 % 19.28 % cosd -i 0 -c ~ceph/ceph.conf
24829 be/4 root        0.00 B/s   45.89 K/s  0.00 % 18.03 % cosd -i 0 -c ~ceph/ceph.conf
24632 be/4 root        0.00 B/s   26.90 K/s  0.00 %  5.99 % cmon -i 0 -c ~ceph/ceph.conf
24556 be/3 root        0.00 B/s    5.54 K/s  0.00 %  2.95 % [jbd2/dm-0-8]
  639 be/3 root        0.00 B/s    0.00 B/s  0.00 %  2.32 % [jbd2/sda5-8]
24833 be/4 root        0.00 B/s   10.28 K/s  0.00 %  0.00 % cosd -i 0 -c ~ceph/ceph.conf


At this point I unmounted ceph on the client and restarted ceph. A few minutes
later I see this:

node01:
/dev/mapper/sda6        232003      5907    212837   3% /mnt/osd

node02:
/dev/mapper/md4         225716      5626    207190   3% /mnt/osd

Note how disk usage went down on both nodes, considerably on node02.

Then they start exchanging data and an hour later or so they're back in sync:

node01:
/dev/mapper/sda6        232003      5906    212838   3% /mnt/osd

node02:
/dev/mapper/md4         225716      5906    206910   3% /mnt/osd


> Do you see any OSD flapping (down/up cycles) during this 
> period?

I've been running without logs since yesterday, but my experience is that
they don't flap; once an OSD goes down it stays down until ceph is restarted.

> It's possible that the MDS is getting ahead of the OSDs, as there isn't 
> currently any throttling of metadata request processing when the 
> journaling is slow.  (We should fix this.)  I don't see how that would 
> explain the variance in disk usage, though, unless you are also seeing the 
> difference in disk usage reflected in the cosd memory usage on the 
> less-disk-used node?

I didn't pay attention to memory usage, but I think I can rule this out
anyway. node01 has 2 GB RAM and 2 GB swap, node02 has 4 GB RAM and no
swap. Since I saw 11 GB on the node02 OSD the other day and 4 GB on the
node01 OSD, the difference could not have been in memory.

Z

