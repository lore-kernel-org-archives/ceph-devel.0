From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 1 Dec 2015 14:02:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr> <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net> <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com> <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52025 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbbLAWCq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 17:02:46 -0500
In-Reply-To: <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi David,

On Tue, 1 Dec 2015, David Casier wrote:
> Hi Sage,
> With a standard disk (4 to 6 TB), and a small flash drive, it's easy
> to create an ext4 FS with metadata on flash
> 
> Example with sdg1 on flash and sdb on hdd :
> 
> size_of() {
>   blockdev --getsize $1
> }
> 
> mkdmsetup() {
>   _ssd=/dev/$1
>   _hdd=/dev/$2
>   _size_of_ssd=$(size_of $_ssd)
>   echo """0 $_size_of_ssd linear $_ssd 0
>   $_size_of_ssd $(size_of $_hdd) linear $_hdd 0" | dmsetup create dm-${1}-${2}
> }
> 
> mkdmsetup sdg1 sdb
> 
> mkfs.ext4 -O ^has_journal,flex_bg,^uninit_bg,^sparse_super,sparse_super2,^extra_isize,^dir_nlink,^resize_inode
> -E packed_meta_blocks=1,lazy_itable_init=0 -G 32768 -I 128 -i
> $((1024*512)) /dev/mapper/dm-sdg1-sdb
> 
> With that, all meta_blocks are on the SSD
> 
> If omap are on SSD, there are almost no metadata on HDD
> 
> Consequence : performance Ceph (with hack on filestore without journal
> and directIO) are almost same that performance of the HDD.
> 
> With cache-tier, it's very cool !

Cool!  I know XFS lets you do that with the journal, but I'm not sure if 
you can push the fs metadata onto a different device too.. I'm guessing 
not?

> That is why we are working on a hybrid approach HDD / Flash on ARM or Intel
> 
> With newstore, it's much more difficult to control the I/O profil.
> Because rocksDB embedded its own intelligence

This is coincidentally what I've been working on today.  So far I've just 
added the ability to put the rocksdb WAL on a second device, but it's 
super easy to push rocksdb data there as well (and have it spill over onto 
the larger, slower device if it fills up).  Or to put the rocksdb WAL on a 
third device (e.g., expensive NVMe or NVRAM).

See this ticket for the ceph-disk tooling that's needed:

	http://tracker.ceph.com/issues/13942

I expect this will be more flexible and perform better than the ext4 
metadata option, but we'll need to test on your hardware to confirm!

sage
