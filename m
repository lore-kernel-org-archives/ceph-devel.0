From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph Bug #2563
Date: Tue, 9 Oct 2012 13:02:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210091301070.11453@cobra.newdream.net>
References: <50747E47.1010408@bob-the-boat.me.uk> <CAPYLRzjyjvdPsAa3Z+9N4=RNna=J5fvSTBZx81SnLuVE454PXQ@mail.gmail.com> <50747FF9.5090306@bob-the-boat.me.uk> <CAPYLRzjgsX5n9tDxzTVNM4XFNaZn9Tu0iJ+jqNQOYDQb5RYm0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58604 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab2JIUCp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 16:02:45 -0400
In-Reply-To: <CAPYLRzjgsX5n9tDxzTVNM4XFNaZn9Tu0iJ+jqNQOYDQb5RYm0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Dave (Bob)" <dave@bob-the-boat.me.uk>, ceph-devel@vger.kernel.org, Samuel Just <sam.just@inktank.com>, John Wilkins <john.wilkins@inktank.com>

On Tue, 9 Oct 2012, Gregory Farnum wrote:
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

Let's confirm first that the problem (which is reproducible for David, 
yay!) goes away with lzo turned off before we document this. 

Ideally, we would like to come up with something sensible to report to 
linux-btrfs about what the corruption looks like and how it can be 
reproduced.

Thanks!
sage


> -Greg
> 
> On Tue, Oct 9, 2012 at 12:50 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
> > Greg,
> >
> > Thank you very much for your prompt rely.
> >
> > Yes, I am using lzo compression, and autodefrag.
> >
> > David
> >
> >
> > On 09/10/2012 20:45, Gregory Farnum wrote:
> >> I'm going to have to leave most of these questions for somebody else,
> >> but I do have one question. Are you using btrfs compression on your
> >> OSD backing filesystems?
> >> -Greg
> >>
> >> On Tue, Oct 9, 2012 at 12:43 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
> >>> I have a problem with this leveldb corruption issue. My logs show the
> >>> same failure as is shown in Ceph's redmine as bug #2563.
> >>>
> >>> I am using linux-3.6.0 (x86_64) and ceph-0.52.
> >>>
> >>> I am using btrfs on my 4 osd's. Each osd is using a partition on a disk drive,
> >>> there are 4 disk drives, all on the same machine.
> >>>
> >>> Each of these osd partitions is the bulk of the disk. There are also
> >>> partitions that provide for booting and a root filesystem from which
> >>> linux runs.
> >>>
> >>> The mon and mds are running on the same machine.
> >>>
> >>> I have been tracking Ceph releases for about a year, this is my ceph
> >>> test machine.
> >>>
> >>> Ceph clearly hammers the disk system; btrfs; and linux. Things have
> >>> moved so far over the past six months, from a time when things would
> >>> crash horribly in a short time to the point where it almost works.
> >>>
> >>> I have had a lot of trouble with the 'slow response' messages associated
> >>> with the osd's, but linux-3.6.0 seems to have brought about improvements
> >>> in btrfs that are noticeable. I am also tuning the
> >>> 'dirty_background_ratio' and I think that this will help.
> >>>
> >>> With my current configuration, I can leave ceph and my osds churning
> >>> data for days on end, and the only errors that I get are the leveldb
> >>> 'std::__throw_length_error' pattern. The osd's go down and can't be
> >>> brought back up.
> >>>
> >>> I have compiled the 'check.cc' program that I found following the bug
> >>> #2563 links. I copy the omap directory from my broken osd (current or
> >>> snaps) and run the check on it and get:
> >>>
> >>> terminate called after throwing an instance of 'std::length_error'
> >>>
> >>> In the past, I've had only one osd at a time go down in this way, and
> >>> I've re-created a btrfs filesystem and allowed ceph to regenerate. Now I
> >>> have been working with only 3 osds and two have gone down
> >>> simultaneously. I've been amazed at ceph's ability to repair itself, but
> >>> I think that this is not going to be recoverable.
> >>>
> >>> On the ceph redmine, it says:
> >>>
> >>>   * *Status* changed from /New/ to /Can't reproduce/
> >>>
> >>> I can reproduce this time and time again. From my perspective it looks
> >>> like the final block to my being confident that all I have to do is
> >>> optimise my hardware and configuration to make things faster.
> >>>
> >>> What can we do to fix this problem?
> >>>
> >>> Is there anything that I can do to recover my broken osd's without
> >>> recreating them afresh and loosing the data?
> >>>
> >>> David Humphreys
> >>> Datatone Ltd
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
