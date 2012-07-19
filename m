From: Andreas Kurz <andreas@hastexo.com>
Subject: Re: Ceph doesn't update the block device size while a rbd image is
 mounted
Date: Thu, 19 Jul 2012 22:35:18 +0200
Message-ID: <50086F86.9010100@hastexo.com>
References: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com> <CAOLwVUm-31QzWb2fnZP+tsntunXEJOcaFLRenqJtAQ9nYPmLyA@mail.gmail.com> <50082476.4020109@widodh.nl> <CAOLwVUm+NnB-ooMiCDx+rkHJhn7tCE7xM67wY6mmMckG87CrQQ@mail.gmail.com> <50082BFB.9000605@widodh.nl> <CAOLwVU=dJ3r5V+_3bSF=-tHf_2pq8_0GA2g2L6zVv1s2mVV_BA@mail.gmail.com> <CAOLwVU=d+tMB1d-sfd4PThM_piE=+8c--msija6NSrhxa548xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig4DE9EC0704A7D4E11CD7B680"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52098 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2GSUfY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 16:35:24 -0400
Received: by bkwj10 with SMTP id j10so2841611bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 13:35:21 -0700 (PDT)
In-Reply-To: <CAOLwVU=d+tMB1d-sfd4PThM_piE=+8c--msija6NSrhxa548xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: han.sebastien@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DE9EC0704A7D4E11CD7B680
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 09:44 PM, S=E9bastien Han wrote:
> With LVM, you can re-scan the scsi bus to extend a physical drive and
> then run a pvextend.
>=20
> @Calvin: I tried your solution
>=20
> # partprobe /dev/rbd1

Did you try blockdev?

# blockdev --rereadpt /dev/rbd1

Regards,
Andreas

>=20
> Unfortunatly nothing changed.
>=20
> Did you make it working?
>=20
> Cheers!
>=20
>=20
> On Thu, Jul 19, 2012 at 5:50 PM, S=E9bastien Han <han.sebastien@gmail.c=
om> wrote:
>> Hum ok, I see. Thanks!
>>
>> But if you have any clue to force the kernel to re-read without
>> unmont/mounting :)
>>
>> On Thu, Jul 19, 2012 at 5:47 PM, Wido den Hollander <wido@widodh.nl> w=
rote:
>>>
>>>
>>> On 19-07-12 17:26, S=E9bastien Han wrote:
>>>>
>>>> Ok I got your point seems logic, but why is this possible with LVM f=
or
>>>> example?
>>>>
>>>> You can easily do this with LVM without un-mounting the device.
>>>>
>>>
>>>
>>> LVM runs through the device mapper and are not regular block devices.=

>>>
>>> If you resize the disk underneath LVM you won't see an increased VG o=
r PV
>>> size unless you change the availability of the VG to unavailable and =
back to
>>> available again.
>>>
>>> I'm not a 100% sure what the exact root cause is, but the kernel won'=
t read
>>> the new size of a block device as long as it is in use.
>>>
>>> Wido
>>>
>>>
>>>
>>>> Cheers.
>>>>
>>>>
>>>> On Thu, Jul 19, 2012 at 5:15 PM, Wido den Hollander <wido@widodh.nl>=

>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> On 19-07-12 16:55, S=E9bastien Han wrote:
>>>>>>
>>>>>>
>>>>>> Hi Cephers!
>>>>>>
>>>>>> I'm working with rbd mapping. I figured out that the block device =
size
>>>>>> of the rbd device is not update while the device is mounted. Here =
my
>>>>>> tests:
>>>>>>
>>>>>
>>>>> iirc this is not something RBD specific, but since the device is in=
 use
>>>>> it
>>>>> can't be re-read by the kernel.
>>>>>
>>>>> So when you unmount it the kernel can re-read the header and resize=
 the
>>>>> device.
>>>>>
>>>>> Wido
>>>>>
>>>>>> 1. Pick up a device and check his size
>>>>>>
>>>>>> # rbd ls
>>>>>> size
>>>>>>
>>>>>> # rbd info test
>>>>>> rbd image 'test':
>>>>>> size 10000 MB in 2500 objects
>>>>>> order 22 (4096 KB objects)
>>>>>> block_name_prefix: rb.0.6
>>>>>> parent:  (pool -1)
>>>>>>
>>>>>> 2. Map the device
>>>>>>
>>>>>> # rbd map --secret /etc/ceph/secret test
>>>>>> # rbd showmapped
>>>>>> id pool image snap device
>>>>>> 1 rbd test - /dev/rbd1
>>>>>>
>>>>>> 3. Put a fs on it and check the block device size
>>>>>>
>>>>>> # mkfs.ext4 /dev/rdb1
>>>>>> ...
>>>>>> ...
>>>>>>
>>>>>> # fdisk -l /dev/rbd1
>>>>>>
>>>>>> Disk /dev/rbd1: 10.5 GB, 10485760000 bytes
>>>>>>
>>>>>> 4. Mount it
>>>>>>
>>>>>> # mount /dev/rbd1 /mnt
>>>>>> # df -h
>>>>>> /dev/rbd1                   9.8G  277M  9.0G   3% /mnt
>>>>>>
>>>>>>
>>>>>> 5. Change the image size
>>>>>>
>>>>>> # rbd resize --size 11000 test
>>>>>> Resizing image: 100% complete...done.
>>>>>>
>>>>>> # rbd info test
>>>>>> rbd image 'test':
>>>>>> size 11000 MB in 2750 objects
>>>>>> order 22 (4096 KB objects)
>>>>>> block_name_prefix: rb.0.6
>>>>>> parent:  (pool -1)
>>>>>>
>>>>>> At this point of time, if you perform the fdisk -l /dev/rbd1, the
>>>>>> block device size will remain the same.
>>>>>>
>>>>>> 6. Unmount the device:
>>>>>>
>>>>>> # umount /media
>>>>>>
>>>>>> # fdisk -l /dev/rbd1
>>>>>> Disk /dev/rbd1: 11.5 GB, 11534336000 bytes
>>>>>>
>>>>>> Unmounting the directory did update the block device size.
>>>>>>
>>>>>> Of course you can do something really fast like:
>>>>>>
>>>>>> # umount /media && mount /dev/rbd1 /media
>>>>>>
>>>>>> That will work, it's a valid solution as long as there is no opene=
d
>>>>>> file. I won't use this trick in production...
>>>>>>
>>>>>> I also tried to "mount -o remount" and it didn't work.
>>>>>>
>>>>>> 7. Resize the fs (this can be performed while the fs is mounted):
>>>>>>
>>>>>> # e2fsck -f /dev/rbd1
>>>>>> e2fsck 1.42 (29-Nov-2011)
>>>>>> Pass 1: Checking inodes, blocks, and sizes
>>>>>> Pass 2: Checking directory structure
>>>>>> Pass 3: Checking directory connectivity
>>>>>> Pass 4: Checking reference counts
>>>>>> Pass 5: Checking group summary information
>>>>>> /dev/rbd1: 11/644640 files (0.0% non-contiguous), 77173/2560000 bl=
ocks
>>>>>>
>>>>>> # resize2fs /dev/rbd1
>>>>>> resize2fs 1.42 (29-Nov-2011)
>>>>>> Resizing the filesystem on /dev/rbd1 to 2816000 (4k) blocks.
>>>>>> The filesystem on /dev/rbd1 is now 2816000 blocks long.
>>>>>>
>>>>>>
>>>>>> Did I miss something?
>>>>>> Is this feature coming?
>>>>>>
>>>>>> Thank you in advance :)
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=

>>>>>>
>>>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--------------enig4DE9EC0704A7D4E11CD7B680
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iFcDBQFQCG+GvbRMOVM2Q/IRCL0UAQDBZMoDB0kyzb5wDQYqxJOWhjTL6cDUNoc3
SspNSq3FewD9FltpxHMamfcVSlbaXEdGo5euFSDpO6Px5pA9eb3VPqo=
=Vu19
-----END PGP SIGNATURE-----

--------------enig4DE9EC0704A7D4E11CD7B680--
