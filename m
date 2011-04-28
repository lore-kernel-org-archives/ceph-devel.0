From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Object size
Date: Fri, 29 Apr 2011 01:55:47 +0200
Message-ID: <4DB9FE83.4090102@provocation.net>
References: <4DB9B74A.10806@provocation.net> <1C8C3185A0EB4376832E44733D45DD77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:37948 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147Ab1D1Xzv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 19:55:51 -0400
In-Reply-To: <1C8C3185A0EB4376832E44733D45DD77@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/28/2011 10:02 PM, Gregory Farnum wrote:

[various explanations]

Thanks Greg, that's very helpful towards graspings ceph's workings. I'll
put it in the wiki.

> The relation between these reports and your data can be a bit fuzzy, 
> though. When looking at the disk space used the OSD is just relying on 
> a df for the mount it's on -- if it's sharing that mount with anything 
> else (eg, the node OS) then it's not distinguishing between OSD data, 
> and data on the disk. Something like that must be going on if you've 
> got a 4.4x ratio. (An example is below. [1]) Based on what you're giving 
> us here:

> 1) You have 9791 MB of data in the filesystem.
> 2) You have (12222MB - 9791 MB=) 2431MB of metadata maintaining the Ceph tree.
> 3) RADOS is using 24444MB of disk space amongst all your OSDs to store this.
> 4) Your nodes have other stuff installed to the tune of (29135MB/2=)14567MB or (29135/3=)9711MB per OSD.

1 and 3 are correct. 2 is presumably correct; it makes perfect sense and
there's no reason to question it. 4 is not correct:

# df -m
[...]
/dev/mapper/sda6        232003     26913    191832  13% /mnt/osd

# grep /mnt/osd /etc/ceph/ceph.conf
	osd data = /mnt/osd

# ls -a /mnt/osd/
.  ..  ceph_fsid  current  fsid  lost+found  magic  whoami

So the OSD lives in its own exclusive partition and nothing else uses that
partition. The other node is done the same way. The "53579 MB used" reported
by ceph matches the aggregated "Used" output of df -m on both nodes. And
I checked, lost+found is empty on both. Something here is trying to be elusive
(and is succeeding).

Z

