From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Ceph Bug #2563
Date: Tue, 09 Oct 2012 20:43:03 +0100
Message-ID: <50747E47.1010408@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from i01.ip.uk.com ([86.54.60.3]:50744 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2JITnF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Oct 2012 15:43:05 -0400
Received: from [194.164.232.154] (helo=[10.0.1.129])
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1TLfhn-0002Qr-N1
	for ceph-devel@vger.kernel.org; Tue, 09 Oct 2012 20:43:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a problem with this leveldb corruption issue. My logs show the
same failure as is shown in Ceph's redmine as bug #2563.

I am using linux-3.6.0 (x86_64) and ceph-0.52.

I am using btrfs on my 4 osd's. Each osd is using a partition on a disk drive,
there are 4 disk drives, all on the same machine.

Each of these osd partitions is the bulk of the disk. There are also
partitions that provide for booting and a root filesystem from which
linux runs.

The mon and mds are running on the same machine.

I have been tracking Ceph releases for about a year, this is my ceph
test machine.

Ceph clearly hammers the disk system; btrfs; and linux. Things have
moved so far over the past six months, from a time when things would
crash horribly in a short time to the point where it almost works.

I have had a lot of trouble with the 'slow response' messages associated
with the osd's, but linux-3.6.0 seems to have brought about improvements
in btrfs that are noticeable. I am also tuning the
'dirty_background_ratio' and I think that this will help.

With my current configuration, I can leave ceph and my osds churning
data for days on end, and the only errors that I get are the leveldb
'std::__throw_length_error' pattern. The osd's go down and can't be
brought back up.

I have compiled the 'check.cc' program that I found following the bug
#2563 links. I copy the omap directory from my broken osd (current or
snaps) and run the check on it and get:

terminate called after throwing an instance of 'std::length_error'

In the past, I've had only one osd at a time go down in this way, and
I've re-created a btrfs filesystem and allowed ceph to regenerate. Now I
have been working with only 3 osds and two have gone down
simultaneously. I've been amazed at ceph's ability to repair itself, but
I think that this is not going to be recoverable.

On the ceph redmine, it says:

  * *Status* changed from /New/ to /Can't reproduce/

I can reproduce this time and time again. From my perspective it looks
like the final block to my being confident that all I have to do is
optimise my hardware and configuration to make things faster.

What can we do to fix this problem?

Is there anything that I can do to recover my broken osd's without
recreating them afresh and loosing the data?

David Humphreys
Datatone Ltd

