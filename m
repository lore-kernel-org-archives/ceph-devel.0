From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Bug #563 - osd: btrfs, warning at inode.c (
 btrfs_orphan_commit_root )
Date: Mon, 7 Feb 2011 17:23:06 +1100
Message-ID: <20110207062306.GB25062@onthe.net.au>
References: <20110204084808.GA3814@onthe.net.au>
 <1296830292.2408.0.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:33054 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab1BGGXJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 01:23:09 -0500
Content-Disposition: inline
In-Reply-To: <1296830292.2408.0.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 04, 2011 at 03:38:12PM +0100, Wido den Hollander wrote:
> On Fri, 2011-02-04 at 19:48 +1100, Chris Dunlop wrote:
>> 
>> http://tracker.newdream.net/issues/563
>> 
>> I see this bug was closed 5 days ago. Which commit[s] closed it? I'm
>> getting it on ceph-client 9aae8fa + btrfs-work bacae12 when I do a
>> mkcephfs on 3 x 2 GB OSDs, e.g.:
> 
> From what I've heard they are working on it upstream (btrfs). Not sure
> what the state is though.

They're not waiting still for Sage?

From your initial report at the top of the ticket:

#btrfs
20:00 < widodh> I've just upgraded to 2.6.37-rc1 to test Ceph, but I'm seeing this right now in my dmesg: 
                http://pastebin.com/3HiGiNgy ( inode.c / btrfs_orphan_commit_root )
20:01 < josef> hrm looks like sage screwed something up with async commit
20:02 < widodh> aha, file it over there then?
20:03 < josef> well tell sage about it, he's the one who wrote the code so he'll probably be able to fix it quicker
20:03 < widodh> yes, sure. I thought it was a btrfs bug, that's why I came along here
20:03 < widodh> thanks!
20:05 < josef> well it is a bug in btrfs, but he will be able to fix it quicker than i will


I'll see what the linux-btrfs mailing list has to say about it...

Cheers,

Chris.
