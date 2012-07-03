From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Updated guide for chef installs, from where the docs stop onward
Date: Tue, 3 Jul 2012 15:34:27 -0700
Message-ID: <CADvuQRHetBF+rvadqoiXrEKdS07GVU36yp4Nzw_6g=OkjNXyfg@mail.gmail.com>
References: <CADvuQRH=pfvhWWTzuXt_LqiyAwc3bxoRAM_sK4vUX3RWnqw2CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55366 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2GCWes (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 18:34:48 -0400
Received: by yhmm54 with SMTP id m54so6670618yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 15:34:48 -0700 (PDT)
In-Reply-To: <CADvuQRH=pfvhWWTzuXt_LqiyAwc3bxoRAM_sK4vUX3RWnqw2CQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>
Cc: Juan Jose Galvez <juanjose.galvez@inktank.com>, Tamil Muthamizhan <tamil.muthamizhan@inktank.com>, Ken Franklin <ken.franklin@inktank.com>

On Wed, Jun 20, 2012 at 1:57 PM, Tommi Virtanen <tv@inktank.com> wrote:
> sudo apt-get install gdisk
> sudo sgdisk /dev/sdb --zap-all --clear --mbrtogpt --largest-new=1
> --change-name=1:'ceph data' --typecode=1:{fsid}
> # mkfs and allocate disk to cluster; any filesystem is ok, adjust for
> xfs/btrfs etc
> sudo mkfs -t ext4 /dev/sdb1
> sudo mount -o user_xattr /dev/sdb1 /mnt
> sudo ceph-disk-prepare --cluster-uuid={fsid} /mnt
> sudo umount /mnt

I just pushed commit ad97415ef72b55934adfa5024fd9af8fd1f0f82d to
master. With that, the above becomes just

sudo apt-get install gdisk
sudo ceph-disk-prepare /dev/sdb

Beware, it'll erase any and all disks you point it at. Do not stare
into laser with remaining eye.
