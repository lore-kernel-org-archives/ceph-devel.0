From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] Ceph Zfs
Date: Thu, 25 Oct 2012 08:36:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210250834010.25762@cobra.newdream.net>
References: <441865dbf9e127f0b85193c512878a76@iihtcloudsolutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59201 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758453Ab2JYPgm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 11:36:42 -0400
In-Reply-To: <441865dbf9e127f0b85193c512878a76@iihtcloudsolutions.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Raghunandhan <raghunandhan.g@iihtcloudsolutions.com>
Cc: ceph-devel@vger.kernel.org

[moved to ceph-devel]

On Thu, 25 Oct 2012, Raghunandhan wrote:
> Hi All,
> 
> I have been working around ceph quite a long and trying to stitch zfs with
> ceph. I was able to do it to certain extent as follows:
> 1. zpool creation
> 2. set dedup
> 3. create a mountable volume of zfs (zfs create)
> 4. format the volume with ext4 and enabling xattr
> 5. mkcephfs on the volume
> 
> This actually works and dedup is perfect. But i need to avoid multiple layers
> on the storage since the performance is very slow and the kernel timeout
> occurs often for a 8GB RAM. I want to test the performance between btrfs and
> zfs. I want to avoid the above multiple layering on storage and make the ceph
> cluster aware of zfs. Let me know if anyone has workaround this.

I'm not familiar enough with zfs to know what 'mountable volume' means.. 
is that a block device/lun that you're putting ext4 on?  Probably the best 
results will come from creating a zfs *file system* (using the ZPL or 
whatever it is) and running ceph-osd on top of that.

There is at least one open bug from someone having problems there, but 
we'd very much like to sort out the problem.

sage
