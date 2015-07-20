From: Sage Weil <sage@newdream.net>
Subject: Re: dmcrypt with luks keys in hammer
Date: Mon, 20 Jul 2015 15:21:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507201521000.8878@cobra.newdream.net>
References: <CAGbvivJH4UJtkcHmgvA7c88YJ6hgmm86fArqJJOszrtBh=kgrg@mail.gmail.com> <alpine.DEB.2.00.1507201419330.8878@cobra.newdream.net> <CAGbviv+2O1z-=9WWSFAFzox=B5dgsASNpYpi5jinmgPW=VTVVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46570 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbGTWVv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 18:21:51 -0400
In-Reply-To: <CAGbviv+2O1z-=9WWSFAFzox=B5dgsASNpYpi5jinmgPW=VTVVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 20 Jul 2015, Wyllys Ingersoll wrote:
> No luck with ceph-disk-activate (all or just one device).
> 
> $ sudo ceph-disk-activate /dev/sdv1
> mount: unknown filesystem type 'crypto_LUKS'
> ceph-disk: Mounting filesystem failed: Command '['/bin/mount', '-t',
> 'crypto_LUKS', '-o', '', '--', '/dev/sdv1',
> '/var/lib/ceph/tmp/mnt.QHe3zK']' returned non-zero exit status 32
> 
> 
> Its odd that it should complain about the "crypto_LUKS" filesystem not
> being recognized, because it did mount some of the LUKS systems
> successfully, though not sometimes just the data and not the journal
> (or vice versa).
> 
> $ lsblk /dev/sdb
> NAME                                            MAJ:MIN RM   SIZE RO
> TYPE  MOUNTPOINT
> sdb                                               8:16   0   3.7T  0 disk
> ??sdb1                                            8:17   0   3.6T  0 part
> ? ??e8bc1531-a187-4fd2-9e3f-cf90255f89d0 (dm-0) 252:0    0   3.6T  0
> crypt /var/lib/ceph/osd/ceph-54
> ??sdb2                                            8:18   0    10G  0 part
>   ??temporary-cryptsetup-1235 (dm-6)            252:6    0   125K  1 crypt
> 
> 
> $ blkid /dev/sdb1
> /dev/sdb1: UUID="d6194096-a219-4732-8d61-d0c125c49393" TYPE="crypto_LUKS"
> 
> 
> A race condition (or other issue) with udev seems likely given that
> its rather random which ones come up and which ones don't.

A race condition during creation or activation?  If it's activation I 
would expect ceph-disk activate ... to work reasonably reliably when 
called manually (on a single device at a time).

sage

> 
> 
> 
> 
> On Mon, Jul 20, 2015 at 5:22 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 20 Jul 2015, Wyllys Ingersoll wrote:
> >> Were running a cluster with Hammer v94.2 and are running into issues
> >> with the Luks encrypted OSD data and journal partitions.  The
> >> installation goes smoothly and everything runs OK, but we've had to
> >> reboot a couple of the storage nodes for various reasons and when they
> >> come back online, a large number of OSD processes fail to start
> >> because the LUKS encrypted partitions are not getting mounted
> >> correctly.
> >>
> >> I'm not sure if it is a udev issue or a problem with the OSD process
> >> itself, but the encrypted partitions end up getting mounted as
> >> "temporary-cryptsetup-PID" and they never recover.  From below, you
> >> can see that some of the OSDs did come up correctly, but the majority
> >> do not.   We've seen this problem now on several storage nodes, and it
> >> only occurs for those OSDs that used luks (the new default).  The only
> >> recovery that we've found is to wipe them all out and rebuild them
> >> using "plain" dmcrypt (as it used to be).
> >>
> >> Using "blkid" on a partition that is in the "temporary-cryptsetup"
> >> state, does show that it has the right ID_PART_ENTRY_UUID and TYPE
> >> values and I can confirm that there is an associated key in
> >> /etc/ceph/dmcrypt-keys, but it still isn't mounting correctly.
> >>
> >> $ sudo blkid -p -o udev /dev/sdv2
> >> ID_FS_UUID=87008c17-9e57-487d-8f8b-160f8f803d8b
> >> ID_FS_UUID_ENC=87008c17-9e57-487d-8f8b-160f8f803d8b
> >> ID_FS_VERSION=1
> >> ID_FS_TYPE=crypto_LUKS
> >> ID_FS_USAGE=crypto
> >> ID_PART_ENTRY_SCHEME=gpt
> >> ID_PART_ENTRY_NAME=ceph\x20journal
> >> ID_PART_ENTRY_UUID=e3eda67b-a2e0-4d22-a62e-d9bda5ecf8b1
> >> ID_PART_ENTRY_TYPE=45b0969e-9b03-4f30-b4c6-35865ceff106
> >> ID_PART_ENTRY_NUMBER=2
> >> ID_PART_ENTRY_OFFSET=2048
> >> ID_PART_ENTRY_SIZE=20969473
> >> ID_PART_ENTRY_DISK=65:80
> >>
> >> So Im checking to see if this is a known issue or if we are missing
> >> something in the installation or configuration that would fix this
> >> problem.
> >
> > This isn't a known issue, although I think we have seen problems in
> > general with hosts with lots of OSDs not always coming up on boot.  If it
> > is specifically a problem with luks+dmcrypt that would be interesting!
> >
> > Does an explicit 'ceph-disk activate /dev/...' on one of the devices make
> > it come up?  And/or a 'ceph-disk activate-all'?  If so that would indicate
> > a race issue in udev.
> >
> > Thanks-
> > sage
> >
> >
> >>
> >> -Wyllys Ingersoll
> >>
> >>
> >> Ex:
> >> $ lsblk -l
> >> NAME                                         MAJ:MIN RM   SIZE RO TYPE
> >>  MOUNTPOINT
> >> sda                                            8:0    0 111.8G  0 disk
> >> sda1                                           8:1    0  15.3G  0 part  [SWAP]
> >> sda2                                           8:2    0     1K  0 part
> >> sda5                                           8:5    0  96.5G  0 part  /
> >> sdb                                            8:16   0   3.7T  0 disk
> >> sdb1                                           8:17   0   3.6T  0 part
> >> e8bc1531-a187-4fd2-9e3f-cf90255f89d0 (dm-0)  252:0    0   3.6T  0 crypt
> >> sdb2                                           8:18   0    10G  0 part
> >> temporary-cryptsetup-1235 (dm-6)             252:6    0   125K  1 crypt
> >> sdc                                            8:32   0   3.7T  0 disk
> >> sdc1                                           8:33   0   3.6T  0 part
> >> temporary-cryptsetup-1788 (dm-37)            252:37   0   125K  1 crypt
> >> sdc2                                           8:34   0    10G  0 part
> >> temporary-cryptsetup-1789 (dm-36)            252:36   0   125K  1 crypt
> >> sdd                                            8:48   0   3.7T  0 disk
> >> sdd1                                           8:49   0   3.6T  0 part
> >> temporary-cryptsetup-1252 (dm-1)             252:1    0   125K  1 crypt
> >> sdd2                                           8:50   0    10G  0 part
> >> temporary-cryptsetup-1246 (dm-3)             252:3    0   125K  1 crypt
> >> sde                                            8:64   0   3.7T  0 disk
> >> sde1                                           8:65   0   3.6T  0 part
> >> temporary-cryptsetup-1260 (dm-14)            252:14   0   125K  1 crypt
> >> sde2                                           8:66   0    10G  0 part
> >> temporary-cryptsetup-1255 (dm-12)            252:12   0   125K  1 crypt
> >> sdf                                            8:80   0   3.7T  0 disk
> >> sdf1                                           8:81   0   3.6T  0 part
> >> temporary-cryptsetup-1268 (dm-15)            252:15   0   125K  1 crypt
> >> sdf2                                           8:82   0    10G  0 part
> >> temporary-cryptsetup-1245 (dm-5)             252:5    0   125K  1 crypt
> >> sdg                                            8:96   0   3.7T  0 disk
> >> sdg1                                           8:97   0   3.6T  0 part
> >> temporary-cryptsetup-1271 (dm-17)            252:17   0   125K  1 crypt
> >> sdg2                                           8:98   0    10G  0 part
> >> temporary-cryptsetup-1278 (dm-2)             252:2    0   125K  1 crypt
> >> sdh                                            8:112  0   3.7T  0 disk
> >> sdh1                                           8:113  0   3.6T  0 part
> >> 69dcd1e1-6e11-41ec-af19-1e0d90013957 (dm-43) 252:43   0   3.6T  0
> >> crypt /var/lib/ceph/osd/ceph-42
> >> sdh2                                           8:114  0    10G  0 part
> >> 3382723d-b0d9-4b50-affe-fb9f5df78d6f (dm-45) 252:45   0    10G  0 crypt
> >> sdi                                            8:128  0   3.7T  0 disk
> >> sdi1                                           8:129  0   3.6T  0 part
> >> temporary-cryptsetup-1265 (dm-20)            252:20   0   125K  1 crypt
> >> sdi2                                           8:130  0    10G  0 part
> >> temporary-cryptsetup-1277 (dm-16)            252:16   0   125K  1 crypt
> >> sdj                                            8:144  0   3.7T  0 disk
> >> sdj1                                           8:145  0   3.6T  0 part
> >> temporary-cryptsetup-1359 (dm-13)            252:13   0   125K  1 crypt
> >> sdj2                                           8:146  0    10G  0 part
> >> temporary-cryptsetup-1280 (dm-4)             252:4    0   125K  1 crypt
> >> sdk                                            8:160  0   3.7T  0 disk
> >> sdk1                                           8:161  0   3.6T  0 part
> >> temporary-cryptsetup-1760 (dm-34)            252:34   0   125K  1 crypt
> >> sdk2                                           8:162  0    10G  0 part
> >> temporary-cryptsetup-1761 (dm-31)            252:31   0   125K  1 crypt
> >> sdl                                            8:176  0   3.7T  0 disk
> >> sdl1                                           8:177  0   3.6T  0 part
> >> c3175d9f-ae12-4852-bbbc-b1d2c344c4ac (dm-38) 252:38   0   3.6T  0
> >> crypt /var/lib/ceph/osd/ceph-32
> >> sdl2                                           8:178  0    10G  0 part
> >> e4e10521-985a-4d94-a766-56d6de26443a (dm-41) 252:41   0    10G  0 crypt
> >> sdm                                            8:192  0   3.7T  0 disk
> >> sdm1                                           8:193  0   3.6T  0 part
> >> temporary-cryptsetup-1407 (dm-9)             252:9    0   125K  1 crypt
> >> sdm2                                           8:194  0    10G  0 part
> >> temporary-cryptsetup-1423 (dm-19)            252:19   0   125K  1 crypt
> >> sdn                                            8:208  0   3.7T  0 disk
> >> sdn1                                           8:209  0   3.6T  0 part
> >> temporary-cryptsetup-1442 (dm-11)            252:11   0   125K  1 crypt
> >> sdn2                                           8:210  0    10G  0 part
> >> temporary-cryptsetup-1433 (dm-7)             252:7    0   125K  1 crypt
> >> sdo                                            8:224  0   3.7T  0 disk
> >> sdo1                                           8:225  0   3.6T  0 part
> >> temporary-cryptsetup-1600 (dm-23)            252:23   0   125K  1 crypt
> >> sdo2                                           8:226  0    10G  0 part
> >> temporary-cryptsetup-1602 (dm-24)            252:24   0   125K  1 crypt
> >> sdp                                            8:240  0   3.7T  0 disk
> >> sdp1                                           8:241  0   3.6T  0 part
> >> temporary-cryptsetup-1634 (dm-27)            252:27   0   125K  1 crypt
> >> sdp2                                           8:242  0    10G  0 part
> >> temporary-cryptsetup-1638 (dm-25)            252:25   0   125K  1 crypt
> >> sdq                                           65:0    0   3.7T  0 disk
> >> sdq1                                          65:1    0   3.6T  0 part
> >> temporary-cryptsetup-1428 (dm-18)            252:18   0   125K  1 crypt
> >> sdq2                                          65:2    0    10G  0 part
> >> temporary-cryptsetup-1430 (dm-10)            252:10   0   125K  1 crypt
> >> sdr                                           65:16   0   3.7T  0 disk
> >> sdr1                                          65:17   0   3.6T  0 part
> >> temporary-cryptsetup-1727 (dm-29)            252:29   0   125K  1 crypt
> >> sdr2                                          65:18   0    10G  0 part
> >> temporary-cryptsetup-1728 (dm-32)            252:32   0   125K  1 crypt
> >> sds                                           65:32   0   3.7T  0 disk
> >> sds1                                          65:33   0   3.6T  0 part
> >> temporary-cryptsetup-1366 (dm-8)             252:8    0   125K  1 crypt
> >> sds2                                          65:34   0    10G  0 part
> >> temporary-cryptsetup-1611 (dm-21)            252:21   0   125K  1 crypt
> >> sdt                                           65:48   0   3.7T  0 disk
> >> sdt1                                          65:49   0   3.6T  0 part
> >> temporary-cryptsetup-1734 (dm-30)            252:30   0   125K  1 crypt
> >> sdt2                                          65:50   0    10G  0 part
> >> temporary-cryptsetup-1735 (dm-28)            252:28   0   125K  1 crypt
> >> sdu                                           65:64   0   3.7T  0 disk
> >> sdu1                                          65:65   0   3.6T  0 part
> >> temporary-cryptsetup-1605 (dm-22)            252:22   0   125K  1 crypt
> >> sdu2                                          65:66   0    10G  0 part
> >> temporary-cryptsetup-1607 (dm-26)            252:26   0   125K  1 crypt
> >> sdv                                           65:80   0   3.7T  0 disk
> >> sdv1                                          65:81   0   3.6T  0 part
> >> temporary-cryptsetup-1739 (dm-33)            252:33   0   125K  1 crypt
> >> sdv2                                          65:82   0    10G  0 part
> >> temporary-cryptsetup-1772 (dm-35)            252:35   0   125K  1 crypt
> >> sdw                                           65:96   0   3.7T  0 disk
> >> sdw1                                          65:97   0   3.6T  0 part
> >> 3171a1b9-e0f8-4521-a31a-821fcb549731 (dm-46) 252:46   0   3.6T  0
> >> crypt /var/lib/ceph/osd/ceph-14
> >> sdw2                                          65:98   0    10G  0 part
> >> 8c5882fd-21ef-4d9c-b62b-676248236514 (dm-47) 252:47   0    10G  0 crypt
> >> sdx                                           65:112  0   3.7T  0 disk
> >> sdx1                                          65:113  0   3.6T  0 part
> >> a576166d-07c4-468c-a704-c4080290a12e (dm-40) 252:40   0   3.6T  0
> >> crypt /var/lib/ceph/osd/ceph-7
> >> sdx2                                          65:114  0    10G  0 part
> >> 1a93e588-dbd4-4ce4-9955-e2f450576314 (dm-42) 252:42   0    10G  0 crypt
> >> sdy                                           65:128  0   3.7T  0 disk
> >> sdy1                                          65:129  0   3.6T  0 part
> >> da2f4e17-f2ba-49ce-bc11-fa699fbf0ba2 (dm-39) 252:39   0   3.6T  0
> >> crypt /var/lib/ceph/osd/ceph-2
> >> sdy2                                          65:130  0    10G  0 part
> >> 14422a1f-083c-44a8-ac6d-d2b4fe20650e (dm-44) 252:44   0    10G  0 crypt
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
