From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Ceph doesn't update the block device size while a rbd image is mounted
Date: Thu, 19 Jul 2012 16:55:48 +0200
Message-ID: <CAOLwVUm-31QzWb2fnZP+tsntunXEJOcaFLRenqJtAQ9nYPmLyA@mail.gmail.com>
References: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53868 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2GSO4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 10:56:10 -0400
Received: by lbbgm6 with SMTP id gm6so3695860lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 07:56:09 -0700 (PDT)
In-Reply-To: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers!

I'm working with rbd mapping. I figured out that the block device size
of the rbd device is not update while the device is mounted. Here my
tests:

1. Pick up a device and check his size

# rbd ls
size

# rbd info test
rbd image 'test':
size 10000 MB in 2500 objects
order 22 (4096 KB objects)
block_name_prefix: rb.0.6
parent:  (pool -1)

2. Map the device

# rbd map --secret /etc/ceph/secret test
# rbd showmapped
id pool image snap device
1 rbd test - /dev/rbd1

3. Put a fs on it and check the block device size

# mkfs.ext4 /dev/rdb1
...
...

# fdisk -l /dev/rbd1

Disk /dev/rbd1: 10.5 GB, 10485760000 bytes

4. Mount it

# mount /dev/rbd1 /mnt
# df -h
/dev/rbd1                   9.8G  277M  9.0G   3% /mnt


5. Change the image size

# rbd resize --size 11000 test
Resizing image: 100% complete...done.

# rbd info test
rbd image 'test':
size 11000 MB in 2750 objects
order 22 (4096 KB objects)
block_name_prefix: rb.0.6
parent:  (pool -1)

At this point of time, if you perform the fdisk -l /dev/rbd1, the
block device size will remain the same.

6. Unmount the device:

# umount /media

# fdisk -l /dev/rbd1
Disk /dev/rbd1: 11.5 GB, 11534336000 bytes

Unmounting the directory did update the block device size.

Of course you can do something really fast like:

# umount /media && mount /dev/rbd1 /media

That will work, it's a valid solution as long as there is no opened
file. I won't use this trick in production...

I also tried to "mount -o remount" and it didn't work.

7. Resize the fs (this can be performed while the fs is mounted):

# e2fsck -f /dev/rbd1
e2fsck 1.42 (29-Nov-2011)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/rbd1: 11/644640 files (0.0% non-contiguous), 77173/2560000 blocks

# resize2fs /dev/rbd1
resize2fs 1.42 (29-Nov-2011)
Resizing the filesystem on /dev/rbd1 to 2816000 (4k) blocks.
The filesystem on /dev/rbd1 is now 2816000 blocks long.


Did I miss something?
Is this feature coming?

Thank you in advance :)
