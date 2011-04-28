From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Object size
Date: Thu, 28 Apr 2011 13:02:39 -0700
Message-ID: <1C8C3185A0EB4376832E44733D45DD77@gmail.com>
References: <4DB9B74A.10806@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39948 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933316Ab1D1UCm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 16:02:42 -0400
Received: by pzk9 with SMTP id 9so1829873pzk.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 13:02:42 -0700 (PDT)
In-Reply-To: <4DB9B74A.10806@provocation.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Thursday, April 28, 2011 at 11:51 AM, Zenon Panoussis wrote:
> What is the current default object size? A paper from 2004 by Sage
> et al speaks of 1 MB, a later one of 8 MB and
> http://diaspora.gen.nz/~rodgerd/archives/1219-Ceph.html says 4 MB.
> Is there a way to configure it? And is there any point in configuring
> it (I am using ceph to store millions of small files) or would it
> make no difference?

The default at this point is 4MB objects, but it's configurable during mkcephfs, and you can change it on new subtrees and files by using the cephfs tool. However, those objects will only be as large as the actual disk space used on them -- if you've got a 2KB file, it will take up 2 KB on disk.

> I'm trying to understand the relation between data size and actual
> disk usage. With replication x2 I am seeing a 1:4.4 ratio according
> to ceph (12222 MB data, 53579 MB used) and even more according to
> 'du -m' on the ext3 source of the ceph data (9791 MB instead of
> 12222 MB).

The relation between these reports and your data can be a bit fuzzy, though. When looking at the disk space used the OSD is just relying on a df for the mount it's on -- if it's sharing that mount with anything else (eg, the node OS) then it's not distinguishing between OSD data, and data on the disk. Something like that must be going on if you've got a 4.4x ratio. (An example is below. [1]) Based on what you're giving us here:
1) You have 9791 MB of data in the filesystem.
2) You have (12222MB - 9791 MB=) 2431MB of metadata maintaining the Ceph tree.
3) RADOS is using 24444MB of disk space amongst all your OSDs to store this.
4) Your nodes have other stuff installed to the tune of (29135MB/2=)14567MB or (29135/3=)9711MB per OSD.

-Greg

[1]: If I use the vstart script to start up a 1-mon, 1-MDS, 1-OSD cluster on my dev machine, ceph -s on a clean tree gives me the following output:
2011-04-28 13:24:29.669534 pg v5: 18 pgs: 18 active+clean+degraded; 43 KB data, 12149 MB used, 919 GB / 931 GB avail; 37/74 degraded (50.000%))




