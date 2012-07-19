From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph doesn't update the block device size while a rbd image is mounted
Date: Thu, 19 Jul 2012 17:26:31 +0200
Message-ID: <CAOLwVUm+NnB-ooMiCDx+rkHJhn7tCE7xM67wY6mmMckG87CrQQ@mail.gmail.com>
References: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com>
 <CAOLwVUm-31QzWb2fnZP+tsntunXEJOcaFLRenqJtAQ9nYPmLyA@mail.gmail.com> <50082476.4020109@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36005 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab2GSP0x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 11:26:53 -0400
Received: by bkwj10 with SMTP id j10so2542833bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 08:26:52 -0700 (PDT)
In-Reply-To: <50082476.4020109@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ok I got your point seems logic, but why is this possible with LVM for =
example?

You can easily do this with LVM without un-mounting the device.

Cheers.


On Thu, Jul 19, 2012 at 5:15 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
>
> On 19-07-12 16:55, S=E9bastien Han wrote:
>>
>> Hi Cephers!
>>
>> I'm working with rbd mapping. I figured out that the block device si=
ze
>> of the rbd device is not update while the device is mounted. Here my
>> tests:
>>
>
> iirc this is not something RBD specific, but since the device is in u=
se it
> can't be re-read by the kernel.
>
> So when you unmount it the kernel can re-read the header and resize t=
he
> device.
>
> Wido
>
>> 1. Pick up a device and check his size
>>
>> # rbd ls
>> size
>>
>> # rbd info test
>> rbd image 'test':
>> size 10000 MB in 2500 objects
>> order 22 (4096 KB objects)
>> block_name_prefix: rb.0.6
>> parent:  (pool -1)
>>
>> 2. Map the device
>>
>> # rbd map --secret /etc/ceph/secret test
>> # rbd showmapped
>> id pool image snap device
>> 1 rbd test - /dev/rbd1
>>
>> 3. Put a fs on it and check the block device size
>>
>> # mkfs.ext4 /dev/rdb1
>> ...
>> ...
>>
>> # fdisk -l /dev/rbd1
>>
>> Disk /dev/rbd1: 10.5 GB, 10485760000 bytes
>>
>> 4. Mount it
>>
>> # mount /dev/rbd1 /mnt
>> # df -h
>> /dev/rbd1                   9.8G  277M  9.0G   3% /mnt
>>
>>
>> 5. Change the image size
>>
>> # rbd resize --size 11000 test
>> Resizing image: 100% complete...done.
>>
>> # rbd info test
>> rbd image 'test':
>> size 11000 MB in 2750 objects
>> order 22 (4096 KB objects)
>> block_name_prefix: rb.0.6
>> parent:  (pool -1)
>>
>> At this point of time, if you perform the fdisk -l /dev/rbd1, the
>> block device size will remain the same.
>>
>> 6. Unmount the device:
>>
>> # umount /media
>>
>> # fdisk -l /dev/rbd1
>> Disk /dev/rbd1: 11.5 GB, 11534336000 bytes
>>
>> Unmounting the directory did update the block device size.
>>
>> Of course you can do something really fast like:
>>
>> # umount /media && mount /dev/rbd1 /media
>>
>> That will work, it's a valid solution as long as there is no opened
>> file. I won't use this trick in production...
>>
>> I also tried to "mount -o remount" and it didn't work.
>>
>> 7. Resize the fs (this can be performed while the fs is mounted):
>>
>> # e2fsck -f /dev/rbd1
>> e2fsck 1.42 (29-Nov-2011)
>> Pass 1: Checking inodes, blocks, and sizes
>> Pass 2: Checking directory structure
>> Pass 3: Checking directory connectivity
>> Pass 4: Checking reference counts
>> Pass 5: Checking group summary information
>> /dev/rbd1: 11/644640 files (0.0% non-contiguous), 77173/2560000 bloc=
ks
>>
>> # resize2fs /dev/rbd1
>> resize2fs 1.42 (29-Nov-2011)
>> Resizing the filesystem on /dev/rbd1 to 2816000 (4k) blocks.
>> The filesystem on /dev/rbd1 is now 2816000 blocks long.
>>
>>
>> Did I miss something?
>> Is this feature coming?
>>
>> Thank you in advance :)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
