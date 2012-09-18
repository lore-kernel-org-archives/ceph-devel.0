From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Why does mkcephfs take approximately 30 seconds per osd on ceph 0.51?
Date: Tue, 18 Sep 2012 16:47:37 -0700
Message-ID: <CANLRBoxMNCQompM1C0pLs6xUPWmCt64XvYJLqm-tkcTFcrXTyA@mail.gmail.com>
References: <CANLRBoy-rNWadmVt=ZcCZNLWFG-oaH2bsZp6Yvjd9DUqtn4xOA@mail.gmail.com>
	<alpine.DEB.2.00.1209181358270.23570@cobra.newdream.net>
	<CANLRBoy599tgAjqPKBhuEBGdkysXTYUsc80qMrZ_NdOe5qyGmA@mail.gmail.com>
	<CANLRBowJs_qx7UcAUJLd41nwF95XSc-Z5ibTt-pedT161qxebg@mail.gmail.com>
	<505904A3.70804@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48143 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2IRXri (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 19:47:38 -0400
Received: by vbbff1 with SMTP id ff1so551711vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 16:47:38 -0700 (PDT)
In-Reply-To: <505904A3.70804@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Sep 18, 2012 at 4:32 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 09/18/2012 02:23 PM, Tren Blackburn wrote:
>>
>> On Tue, Sep 18, 2012 at 2:11 PM, Tren Blackburn <tren@eotnetworks.com>
>> wrote:
>>>
>>> On Tue, Sep 18, 2012 at 1:58 PM, Sage Weil <sage@inktank.com> wrote:
>>>>
>>>> On Tue, 18 Sep 2012, Tren Blackburn wrote:
>>>>>
>>>>> Hi List;
>>>>>
>>>>> I've been working with ceph 0.51 lately, and have noticed this for a
>>>>> while now, but it hasn't been a big enough issue for me to report.
>>>>> However today I'm turning up a 192 OSD cluster, and 30 seconds per OSD
>>>>> adds up pretty quick. For some reason it's taking 30 seconds between
>>>>> checking the OSD for a pre-existing store:
>>>>>
>>>>> 2012-09-18 13:53:28.400590 7fe895d25780 -1 filestore(/var/ceph/disk11)
>>>>> could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
>>>>> file or directory
>>>>>
>>>>> And then actually creating the new store:
>>>>>
>>>>> 2012-09-18 13:53:57.371396 7fe895d25780 -1 created object store
>>>>> /var/ceph/disk11 journal /dev/mapper/vg-journal.disk11 for osd.34 fsid
>>>>> bca82801-04d7-402e-917f-8023a4b161a8
>>>>> 2012-09-18 13:53:57.371449 7fe895d25780 -1 auth: error reading file:
>>>>> /var/ceph/disk11/keyring: can't open /var/ceph/disk11/keyring: (2) No
>>>>> such file or directory
>>>>> 2012-09-18 13:53:57.371527 7fe895d25780 -1 created new key in keyring
>>>>> /var/ceph/disk11/keyring
>>>>>
>>>>> I can provide many examples as I'm watching it slowly plod through
>>>>> currently. Also, the horse power of the server makes no difference.
>>>>> The servers in question here are dual E5-2600's with 96GB ram and
>>>>> 12x2TB drives.
>>>>>
>>>>> What information can I provide to help debug this? Or is this an
>>>>> already known issue?
>>>>
>>>>
>>>> If you add -x to the #!/bin/bash line in mkcephfs we can see exactly
>>>> which
>>>> command(s) are going slow...
>>>
>>>
>>> It looks like it's the ceph-osd command taking the time:
>>>
>>> + /usr/bin/ceph-osd -c /tmp/mkfs.ceph.9006/conf --monmap
>>> /tmp/mkfs.ceph.9006/monmap -i 000 --mkfs --mkkey
>>>   HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>> 2012-09-18 14:08:11.265921 7fb41bd04780 -1 journal check: ondisk fsid
>>> 00000000-0000-0000-0000-000000000000 doesn't match expected
>>> aa1f859e-4d3c-4b02-87c5-0190bb51dd48, invalid (someone else's?)
>>> journal
>>>   HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>   HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>>   HDIO_DRIVE_CMD(identify) failed: Invalid argument
>>> 2012-09-18 14:08:11.440522 7fb41bd04780 -1 filestore(/var/ceph/disk01)
>>> could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
>>> file or directory
>>> 2012-09-18 14:08:40.424981 7fb41bd04780 -1 created object store
>>> /var/ceph/disk01 journal /dev/mapper/vg-journal.disk01 for osd.0 fsid
>>> ad1bcd15-081a-4d6b-abf1-2fcf79764c9b
>>> 2012-09-18 14:08:40.425032 7fb41bd04780 -1 auth: error reading file:
>>> /var/ceph/disk01/keyring: can't open /var/ceph/disk01/keyring: (2) No
>>> such file or directory
>>> 2012-09-18 14:08:40.425109 7fb41bd04780 -1 created new key in keyring
>>> /var/ceph/disk01/keyring
>>>
>> I managed to attach a strace to the ceph-osd process. Please find it at:
>>
>> http://pastebin.com/Tdm2t3jT
>>
>> Hopefully it's useful. Please let me know what else I can do to help
>> with this, as having to wait 1.5 hours for mkcephfs to complete is a
>> little excessive... ;)
>>
>> t.
>
>
> Could you do an strace -tt? That'll tell us where the slowness is.
>
Done. http://pastebin.com/Ba9xHZyJ

Please let me know if you need anything else. I've had to re-run the
mkcephfs anyway...

t.
