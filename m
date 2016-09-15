From: Sage Weil <sage@newdream.net>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Thu, 15 Sep 2016 18:54:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609151850330.19761@piezo.us.to>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com> <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com> <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com> <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
 <alpine.DEB.2.11.1609151833290.19761@piezo.us.to> <BC30B826-3E63-4002-9436-60222C606E9F@Teradata.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2102609233-1473965649=:19761"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42389 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbcIOSyK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 14:54:10 -0400
In-Reply-To: <BC30B826-3E63-4002-9436-60222C606E9F@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2102609233-1473965649=:19761
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Sep 2016, Kamble, Nitin A wrote:
> > On Sep 15, 2016, at 11:34 AM, Sage Weil <sage@newdream.net> wrote:
> > 
> > On Thu, 15 Sep 2016, Kamble, Nitin A wrote:
> >> Can I use ceph-disk to prepare a bluestore OSD now?
> >> 
> >> I would like to know proper command line parameters for ceph-disk .
> >> 
> >> The following related issue tracker has closed, does it mean it is ready 
> >> to use for creation of bluestore OSDs?
> >> 
> >> From: http://tracker.ceph.com/issues/13942
> >> 
> >>> 
> >>> Updated by Sage Weil 9 months ago
> >>> 	• Status changed from In Progress to Verified
> >>> 	• Assignee deleted (Loic Dachary)
> >>> For the 'ceph-disk prepare' part, I think we should keep it simple initially:
> >>> 
> >>> ceph-disk --osd-objectstore bluestore maindev[:dbdev[:waldev]]
> >>> and teach ceph-disk how to do the partitioning for bluestore (no generic way to ask ceph-osd that). We can leave off the db/wal devices initially, and then make activate work, so that there is something functional. Then add dbdev and waldev support last.
> > 
> > You just need to pass --bluestore to ceph-disk for a single-disk setup. 
> > The multi-device PR is still pending, but close:
> > 
> > 	https://github.com/ceph/ceph/pull/10135
> > 
> > sage
> >
> > sudo ceph-disk prepare --bluestore /dev/sdb --block.db /dev/sdc --block.wal /dev/sdc
> > 
> > This will create 2 partitions on sdb and 2 partitions on sdc, then 'block.db' will symlink to partition 1 of sdc, 'block.wal' will symlink to partition 2 of sdc, 'block' will symlink to partition 2 of sdb.
> >
> 
> Nice!  I am eager to see it go into the master branch, and try it out. 
> Any approximate ETA for merging this PR?
> 
> Looks like the WAL size is of fixed 128MB irrespective of the block 
> store size. How to determine the metadata db size? It needs to 
> proportional to the block store size. Is there any recommended ratio?

The 128MB figure is mostly pulled out of a hat.  I suspect it will be 
reasonable, but a proper recommendation is going to depend on how we end 
up tuning rocksdb, and we've put that off until the metadata format is 
finalized and any rocksdb tuning we do will be meaningful.  We're pretty 
much at that point now...

Whatever it is, it should be related to the request rate, and perhaps the 
relative speed of the wal device and the db or main device.  The size of 
the slower devices shouldn't matter, though.

There are some bluefs perf counters that let you monitor what the wal 
device utilization is.  See 

  b.add_u64(l_bluefs_wal_total_bytes, "wal_total_bytes",
	    "Total bytes (wal device)");
  b.add_u64(l_bluefs_wal_free_bytes, "wal_free_bytes",
	    "Free bytes (wal device)");

which you can monitor via 'ceph daemon osd.N perf dump'.  If you 
discover anything interesting, let us know!

Thanks-
sage
--8323329-2102609233-1473965649=:19761--
