From: "Anton VG." <anton.vazir@gmail.com>
Subject: Re: Best way to store billions of files
Date: Tue, 24 Aug 2010 13:53:17 +0500
Message-ID: <201008241353.17557.anton.vazir@gmail.com>
References: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.eastera.tj ([62.122.137.85]:52065 "EHLO mail.eastera.tj"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220Ab0HXIyX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Aug 2010 04:54:23 -0400
In-Reply-To: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

Just got reed of the sh... named Gluster after a 1.5 years of being nervious 
with it's glitches, and switched to linux software raid6 array for the time 
being... while ceph stabilizes...

On Sunday 01 August 2010 17:08:49 Roland Rabben wrote:
> I am researching alternatives to GlusterFS that I am currently using.
> My need is to store billions of files (big and small), and I am trying
> to find out if there are any considerations I should make when
> planning folder structure and server config using Ceph.
> 
> On my GlusterFS system things seems to slow down dramatically as I
> grow the number of files. A simple ls takes forever. So I am looking
> for alternatives.
> 
> Right now my folder structrure looks like this:
> 
> Users are grouped into folders, named /000, /001, ... /999 , using a hash.
> Each user has its own folder inside the numbered folders
> Inside each user-folder the users files are stored in folders named
> /000, /001, ... /999, also using a hash.
> 
> Would this folder structure or the ammount of files become a problem using
> Ceph?
> 
> I generally use 4U storage nodes with 36 x 1,5 TB or 2 TB SATA drives,
> 8 core CPU and 6 GB RAM. My application is write once and read many.
> What recommendations would you give with regards to setting up the
> filesystem on the storage nodes? ext3? ext4? lvm? RAID?
> 
> Today I am mounting all disks as individual ext3 partitions and tying
> them together with GlusterFS. Would this work with Ceph or would you
> recommend making one large LVM volume on each storage node that you
> expose to Ceph?
> 
> I know Ceph is not production ready yet, but from the activity on this
> mailing list things looks promising.
> 
> Best regards
> Roland Rabben
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
