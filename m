From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to deal with a single host with several harddisks
Date: Wed, 04 May 2011 12:10:40 +0200
Message-ID: <1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37550 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab1EDKKm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 06:10:42 -0400
In-Reply-To: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-05-04 at 17:37 +0800, tsk wrote:
> Hi folks,
> 
> 
> May I know that,  if there is 6 harddisk available for btrfs in just a
> single host,  there should be 6 cosd process in the host when the
> disks are all working?

Yes, that is the way common way.

> 
> A single cosd process can not manage several disks?
> 

Yes and no. A single cosd process simply wants a mount point. If you
look closer, the init script simply mounts the device specified by
'btrfs devs' in the configuration.

You could run LVM, mdadm or even a btrfs multi-disk volume under a
mountpoint, this way you could have on cosd process per disk.

I would recommend running one cosd process per disk, it takes a bit more
memory (about 800M per cosd), but this way Ceph can take the full
advantage of all the available diskspace.

If you have multiple hosts I would recommend making a CRUSH map which
makes sure your data replicas are not stored within the same physical
machine: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH

The newer versions of Ceph will make a basic CRUSH map based on the
ceph.conf, as far as I know it will prevent saving replicas on the same
node. However, I would recommended checking your CRUSH map to make sure
it does.

> How should the ceph.conf be configured for this scenario?

For example:

[osd.0]
   host = node01
   btrfs devs = /dev/sda

[osd.1]
   host = node01
   btrfs devs = /dev/sdb

[osd.2]
   host = node01
   btrfs devs = /dev/sdc

etc, etc

The init script and mkcephfs will then format the specified drives with
btrfs and mount it when the OSD starts.

I would also recommend running your journal on a separate drive:
http://ceph.newdream.net/wiki/Troubleshooting#Performance

Wido

> 
> 
> Thx!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


