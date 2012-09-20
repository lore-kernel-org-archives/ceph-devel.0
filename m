From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Why does mkcephfs take approximately 30 seconds per osd on ceph 0.51?
Date: Thu, 20 Sep 2012 13:26:29 -0700
Message-ID: <CANLRBoxSHF_x44XhXK8+joTtrcB6ATFvcUtieuPXbTWBCaEXEA@mail.gmail.com>
References: <CANLRBoy-rNWadmVt=ZcCZNLWFG-oaH2bsZp6Yvjd9DUqtn4xOA@mail.gmail.com>
	<alpine.DEB.2.00.1209181358270.23570@cobra.newdream.net>
	<CANLRBoy599tgAjqPKBhuEBGdkysXTYUsc80qMrZ_NdOe5qyGmA@mail.gmail.com>
	<CANLRBowJs_qx7UcAUJLd41nwF95XSc-Z5ibTt-pedT161qxebg@mail.gmail.com>
	<505904A3.70804@inktank.com>
	<CANLRBoxMNCQompM1C0pLs6xUPWmCt64XvYJLqm-tkcTFcrXTyA@mail.gmail.com>
	<505A4972.8000709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43728 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2ITU0a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Sep 2012 16:26:30 -0400
Received: by vcbfo13 with SMTP id fo13so3124892vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Sep 2012 13:26:29 -0700 (PDT)
In-Reply-To: <505A4972.8000709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 3:38 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 09/18/2012 04:47 PM, Tren Blackburn wrote:
>>
>> On Tue, Sep 18, 2012 at 4:32 PM, Josh Durgin <josh.durgin@inktank.com>
>> wrote:
>>>
>>> On 09/18/2012 02:23 PM, Tren Blackburn wrote:
>>>>
>>>>
>>>> On Tue, Sep 18, 2012 at 2:11 PM, Tren Blackburn <tren@eotnetworks.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On Tue, Sep 18, 2012 at 1:58 PM, Sage Weil <sage@inktank.com> wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, 18 Sep 2012, Tren Blackburn wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi List;
>>>>>>>
>>>>>>> I've been working with ceph 0.51 lately, and have noticed this for a
>>>>>>> while now, but it hasn't been a big enough issue for me to report.
>>>>>>> However today I'm turning up a 192 OSD cluster, and 30 seconds per
>>>>>>> OSD
>>>>>>> adds up pretty quick. For some reason it's taking 30 seconds between
>>>>>>> checking the OSD for a pre-existing store:
>>>>>>>
>>>>>>> 2012-09-18 13:53:28.400590 7fe895d25780 -1
>>>>>>> filestore(/var/ceph/disk11)
>>>>>>> could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
>>>>>>> file or directory
>>>>>>>
>>>>>>> And then actually creating the new store:
>>>>>>>
>>>>>>> 2012-09-18 13:53:57.371396 7fe895d25780 -1 created object store
>>>>>>> /var/ceph/disk11 journal /dev/mapper/vg-journal.disk11 for osd.34
>>>>>>> fsid
>>>>>>> bca82801-04d7-402e-917f-8023a4b161a8
>>>>>>> 2012-09-18 13:53:57.371449 7fe895d25780 -1 auth: error reading file:
>>>>>>> /var/ceph/disk11/keyring: can't open /var/ceph/disk11/keyring: (2) No
>>>>>>> such file or directory
>>>>>>> 2012-09-18 13:53:57.371527 7fe895d25780 -1 created new key in keyring
>>>>>>> /var/ceph/disk11/keyring
>>>>>>>
>>>>>>> I can provide many examples as I'm watching it slowly plod through
>>>>>>> currently. Also, the horse power of the server makes no difference.
>>>>>>> The servers in question here are dual E5-2600's with 96GB ram and
>>>>>>> 12x2TB drives.
>>>>>>>
>>>>>>> What information can I provide to help debug this? Or is this an
>>>>>>> already known issue?
>>>>>>
>>>>>>
>>>>>>
>>>>>> If you add -x to the #!/bin/bash line in mkcephfs we can see exactly
>>>>>> which
>>>>>> command(s) are going slow...
>>>>>
>>>>>
>>>>>
>>>>> It looks like it's the ceph-osd command taking the time:
>>>>>
>>>>> + /usr/bin/ceph-osd -c /tmp/mkfs.ceph.9006/conf --monmap
>>>>> /tmp/mkfs.ceph.9006/monmap -i 000 --mkfs --mkkey
>>>>>    HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>>> 2012-09-18 14:08:11.265921 7fb41bd04780 -1 journal check: ondisk fsid
>>>>> 00000000-0000-0000-0000-000000000000 doesn't match expected
>>>>> aa1f859e-4d3c-4b02-87c5-0190bb51dd48, invalid (someone else's?)
>>>>> journal
>>>>>    HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>>>    HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>>>    HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>>> 2012-09-18 14:08:11.440522 7fb41bd04780 -1 filestore(/var/ceph/disk01)
>>>>> could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
>>>>> file or directory
>>>>> 2012-09-18 14:08:40.424981 7fb41bd04780 -1 created object store
>>>>> /var/ceph/disk01 journal /dev/mapper/vg-journal.disk01 for osd.0 fsid
>>>>> ad1bcd15-081a-4d6b-abf1-2fcf79764c9b
>>>>> 2012-09-18 14:08:40.425032 7fb41bd04780 -1 auth: error reading file:
>>>>> /var/ceph/disk01/keyring: can't open /var/ceph/disk01/keyring: (2) No
>>>>> such file or directory
>>>>> 2012-09-18 14:08:40.425109 7fb41bd04780 -1 created new key in keyring
>>>>> /var/ceph/disk01/keyring
>>>>>
>>>> I managed to attach a strace to the ceph-osd process. Please find it at:
>>>>
>>>> http://pastebin.com/Tdm2t3jT
>>>>
>>>> Hopefully it's useful. Please let me know what else I can do to help
>>>> with this, as having to wait 1.5 hours for mkcephfs to complete is a
>>>> little excessive... ;)
>>>>
>>>> t.
>>>
>>>
>>>
>>> Could you do an strace -tt? That'll tell us where the slowness is.
>>>
>> Done. http://pastebin.com/Ba9xHZyJ
>>
>> Please let me know if you need anything else. I've had to re-run the
>> mkcephfs anyway...
>>
>> t.
>>
>
> I haven't looked into this in more detail yet, but there are two long
> pauses where it's waiting for locks:
>
> Process 20669 attached
> 16:42:20.994765 futex(0x7fffd339ee7c, FUTEX_WAIT_PRIVATE, 1, NULL) = 0
> 16:42:43.177930 futex(0x7fffd339ee30, FUTEX_WAKE_PRIVATE, 1) = 0
> 16:42:43.177989 open("/var/ceph/disk08/magic", O_RDONLY) = -1 ENOENT (No
> such file or directory)
> 16:42:43.178065 open("/var/ceph/disk08/magic.tmp", O_WRONLY|O_CREAT|O_TRUNC,
> 0644) = 17
> ...
> 16:42:43.199460 futex(0x7f3b5457a9d0, FUTEX_WAIT, 20691, NULL) = 0
> 16:43:12.199531 futex(0x337a92c, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647,
> 0x337a8e8, 118) = 2
>
Hi Josh;

I'm in the process of wiping the cluster and converting over to XFS
based OSD's and I wanted to let you know that this delay doesn't
happen on XFS, it only seems to happen on btrfs.

=== osd.000 ===
pushing conf and monmap to ocr31-ire:/tmp/mkfs.ceph.10373
 HDIO_DRIVE_CMD(identify) failed: Invalid argument
2012-09-20 13:24:12.649837 7f7360886780 -1 journal check: ondisk fsid
00000000-0000-0000-0000-000000000000 doesn't match expected
fd211791-812d-4f5a-a3c9-059b06e87db4, invalid (someone else's?)
journal
 HDIO_DRIVE_CMD(identify) failed: Invalid argument
 HDIO_DRIVE_CMD(identify) failed: Invalid argument
 HDIO_DRIVE_CMD(identify) failed: Invalid argument
2012-09-20 13:24:12.697840 7f7360886780 -1 filestore(/var/ceph/disk01)
could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
file or directory
2012-09-20 13:24:12.733505 7f7360886780 -1 created object store
/var/ceph/disk01 journal /dev/mapper/vg-journal.disk01 for osd.0 fsid
fcde16cb-d97d-485b-8294-68f37def2634
2012-09-20 13:24:12.733546 7f7360886780 -1 auth: error reading file:
/var/ceph/disk01/keyring: can't open /var/ceph/disk01/keyring: (2) No
such file or directory
2012-09-20 13:24:12.733761 7f7360886780 -1 created new key in keyring
/var/ceph/disk01/keyring
collecting osd.000 key

hopefully that helps you narrow down the issue. If there's any other
information I can provide about my setup that would help, please let
me know.

t.
