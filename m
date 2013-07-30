From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: krbd & live resize
Date: Tue, 30 Jul 2013 11:55:00 +0200
Message-ID: <51F78D74.803@ksperis.com>
References: <51F6E389.1040607@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:44639 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758679Ab3G3JzF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 05:55:05 -0400
Received: by mail-bk0-f54.google.com with SMTP id it19so2311106bkc.41
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 02:55:04 -0700 (PDT)
In-Reply-To: <51F6E389.1040607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello Loic,

which version of kernel do you use for krbd ?

Laurent


Le 29/07/2013 23:50, Loic Dachary a =E9crit :
> Hi,
>
> This works:
>
> lvcreate --name tmp --size 10G all
>    Logical volume "tmp" created
> mkfs.ext4 /dev/all/tmp
> mount /dev/all/tmp /mnt
> blockdev --getsize64 /dev/all/tmp
> 10737418240
> lvextend -L+1G /dev/all/tmp
>    Extending logical volume tmp to 11,00 GiB
>    Logical volume tmp successfully resized
> blockdev --getsize64 /dev/all/tmp
> 11811160064
> resize2fs /dev/all/tmp
> resize2fs 1.41.12 (17-May-2010)
> Filesystem at /dev/all/tmp is mounted on /mnt; on-line resizing requi=
red
> old desc_blocks =3D 1, new_desc_blocks =3D 1
> Performing an on-line resize of /dev/all/tmp to 2883584 (4k) blocks.
> The filesystem on /dev/all/tmp is now 2883584 blocks long.
>
> This does not work:
>
> rbd create --size 10240 tmp
> rbd info tmp
> rbd image 'tmp':
> 	size 10240 MB in 2560 objects
> 	order 22 (4096 KB objects)
> 	block_name_prefix: rb.0.12dd.238e1f29
> 	format: 1
> rbd map tmp
> mkfs.ext4 /dev/rbd1
> mount /dev/rbd1 /mnt
> blockdev --getsize64 /dev/rbd1
> 10737418240
> rbd resize --size 20000 tmp
> blockdev --getsize64 /dev/rbd1
> 10737418240
> resize2fs /dev/rbd1
> resize2fs 1.42 (29-Nov-2011)
> The filesystem is already 2621440 blocks long.  Nothing to do!
>
> It does work after umounting:
>
> umount /mnt
> blockdev --getsize64 /dev/rbd1
> fsck -f /dev/rbd1
> resize2fs /dev/rbd1
> resize2fs 1.42 (29-Nov-2011)
> Resizing the filesystem on /dev/rbd1 to 5120000 (4k) blocks.
> The filesystem on /dev/rbd1 is now 5120000 blocks long.
>
> I assume there should be "something" in KRBD to allow for the same be=
havior as with LVM but I don't know enough about the kernel to be more =
specific. Maybe something similar to ioctl BLKRRPART ?
>
> Cheers
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
