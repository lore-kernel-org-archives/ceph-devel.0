From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Re: Ceph Bug #2563
Date: Fri, 12 Oct 2012 13:07:00 +0100
Message-ID: <507807E4.90708@bob-the-boat.me.uk>
References: <50747E47.1010408@bob-the-boat.me.uk> <CAPYLRzjyjvdPsAa3Z+9N4=RNna=J5fvSTBZx81SnLuVE454PXQ@mail.gmail.com> <50747FF9.5090306@bob-the-boat.me.uk> <CAPYLRzjgsX5n9tDxzTVNM4XFNaZn9Tu0iJ+jqNQOYDQb5RYm0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from i01.ip.uk.com ([86.54.60.3]:52271 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759066Ab2JLMHI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Oct 2012 08:07:08 -0400
In-Reply-To: <CAPYLRzjgsX5n9tDxzTVNM4XFNaZn9Tu0iJ+jqNQOYDQb5RYm0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, Samuel Just <sam.just@inktank.com>, John Wilkins <john.wilkins@inktank.com>

Since my last messages, I have made new btrfs filesystems on my osd
partitions, and completely re-initialised my ceph, without the
compression on the osds.

The ceph is on a single machine with an intel core i7 processor and 8G
RAM. There are four 3Tb seagate disk drives.

I have the drives partitioned with most of the space dedicated to osd
use, with the remaining used for a raid configured btrfs that is the
root filesystem.

The root of the ceph is on the root filesystem, with the four (actually
only three in use at the moment) osd partitions mounted within this
(/ceph/osd.0 etc). So the journal is on the root filesystem, which is
btrfs mirrored and striped over four drives.

Linux is 3.6.0, ceph is 0.52.

I mount the ceph filesystem on a second machine and start rsync to copy
a lot of data (maybe 1 Tb) to ceph over a 1Gb/s network.

The mds, mon, and osds are all running on the one (first) machine.

I have had problems in which the disk activity is 'bursty' with the
machine hanging whilst bursts of activity are underway, so I have set
'dirty_background_ ratio' to 1 and 'dirty_ratio' to 50.

I think that this may be improving things a bit.

Everything starts off swimmingly, with data flowing well to the ceph
machine. Over time, the ceph machine slows down, and the osds start to
complain about 'slow response'. The response of the machine to any user
interaction is very slow, and there is much evidence of processes in the
'disk sleep' state, and staying that way for fairly extended times -
occasionally at these times there isn't a lot of disk light activity.

Dmesg shows that a couple of times there have been crashes of
'btrfs_cleaner' kernel thread. Also several crashes of the osd's (init
respawns them when they go down).

Eventually it is evident that things seem more than just slow; more like
jammed up and broken.  I am not getting the 'bug #2563' corruption now,
without the compression.

It seems to me that ceph stresses linux-btrfs more than anything else
does (I have no problems apart from the ceph experiments); and the
result is a steadily worsening log-jam that eventually causes crashing
of both kernel processes and osd's. I suspect that the 'bug #2563' issue
is a symptom of this that causes the compression mechanism to produce
corruption. Without compression, I don't get that particular fault, but
things still do not work well.

My next experiment is to start again, but with the osds using xfs, not
btrfs. My understanding is that ceph is designed to work best with
btrfs, so I don't want to go this way long term, but if everything works
significantly better, it would localise the issue to btrfs.

(By the way, the root filesystem is still compressed btrfs - I wonder
whether that is a problem; with the journal i/o going this way...)


David

On 09/10/2012 20:59, Gregory Farnum wrote:
> Okay, thanks for the information.
>
> Sam has walked through trying to fix this before and I don't know if
> he came up with anything, but the use of btrfs compression has been a
> common theme among those who have reproduced this bug. I updated the
> ticket, but for now I'd recommend leaving it off with the rest of your
> machines.
>
> John, can you add a warning to whatever install/configuration/whatever
> docs are appropriate?
> -Greg
>
> On Tue, Oct 9, 2012 at 12:50 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
>> Greg,
>>
>> Thank you very much for your prompt rely.
>>
>> Yes, I am using lzo compression, and autodefrag.
>>
>> David
>>
>>
>> On 09/10/2012 20:45, Gregory Farnum wrote:
>>> I'm going to have to leave most of these questions for somebody else,
>>> but I do have one question. Are you using btrfs compression on your
>>> OSD backing filesystems?
>>> -Greg
>>>
>>> On Tue, Oct 9, 2012 at 12:43 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
>>>> I have a problem with this leveldb corruption issue. My logs show the
>>>> same failure as is shown in Ceph's redmine as bug #2563.
>>>>
>>>> I am using linux-3.6.0 (x86_64) and ceph-0.52.
>>>>
>>>> I am using btrfs on my 4 osd's. Each osd is using a partition on a disk drive,
>>>> there are 4 disk drives, all on the same machine.
>>>>
>>>> Each of these osd partitions is the bulk of the disk. There are also
>>>> partitions that provide for booting and a root filesystem from which
>>>> linux runs.
>>>>
>>>> The mon and mds are running on the same machine.
>>>>
>>>> I have been tracking Ceph releases for about a year, this is my ceph
>>>> test machine.
>>>>
>>>> Ceph clearly hammers the disk system; btrfs; and linux. Things have
>>>> moved so far over the past six months, from a time when things would
>>>> crash horribly in a short time to the point where it almost works.
>>>>
>>>> I have had a lot of trouble with the 'slow response' messages associated
>>>> with the osd's, but linux-3.6.0 seems to have brought about improvements
>>>> in btrfs that are noticeable. I am also tuning the
>>>> 'dirty_background_ratio' and I think that this will help.
>>>>
>>>> With my current configuration, I can leave ceph and my osds churning
>>>> data for days on end, and the only errors that I get are the leveldb
>>>> 'std::__throw_length_error' pattern. The osd's go down and can't be
>>>> brought back up.
>>>>
>>>> I have compiled the 'check.cc' program that I found following the bug
>>>> #2563 links. I copy the omap directory from my broken osd (current or
>>>> snaps) and run the check on it and get:
>>>>
>>>> terminate called after throwing an instance of 'std::length_error'
>>>>
>>>> In the past, I've had only one osd at a time go down in this way, and
>>>> I've re-created a btrfs filesystem and allowed ceph to regenerate. Now I
>>>> have been working with only 3 osds and two have gone down
>>>> simultaneously. I've been amazed at ceph's ability to repair itself, but
>>>> I think that this is not going to be recoverable.
>>>>
>>>> On the ceph redmine, it says:
>>>>
>>>>   * *Status* changed from /New/ to /Can't reproduce/
>>>>
>>>> I can reproduce this time and time again. From my perspective it looks
>>>> like the final block to my being confident that all I have to do is
>>>> optimise my hardware and configuration to make things faster.
>>>>
>>>> What can we do to fix this problem?
>>>>
>>>> Is there anything that I can do to recover my broken osd's without
>>>> recreating them afresh and loosing the data?
>>>>
>>>> David Humphreys
>>>> Datatone Ltd
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

