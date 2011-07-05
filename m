From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Servers with 40+ disks : to group or not to group ?
Date: Tue, 5 Jul 2011 08:06:38 -0700
Message-ID: <CAF3hT9BgT16+Bdex9BD5PwDjfN2SoDtcOXig9oizyu+QHuCo9w@mail.gmail.com>
References: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53980 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1GEPGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 11:06:40 -0400
Received: by yxi11 with SMTP id 11so1919930yxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2011 08:06:39 -0700 (PDT)
In-Reply-To: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jul 2, 2011 at 6:30 AM, Wilfrid Allembrand
<wilfrid.allembrand@gmail.com> wrote:
> Hi everyone,
>
> I'm trying to figure out what is the best OSD solution with an
> infrastructure made up of servers with a lot a disks in each. Say, for
> exemple you have 4+ nodes like Sun Fire X4500 (code-named Thumper).
> Each node is 48 disks.
>
> What are the pros and cons to build a ceph cluster with btrfs on that
> kind of high density hardware, considering the different scenarios for
> each server :
> - 1 OSD daemon per disk, so 48 osd daemons per server
> - make 3 btrfs pools of 16 disks, so 3 osd daemons per server
> - make 3 raid 5 or 6 volumes, so 3 osd daemons per server
As Wido said, you certainly can run in groups. I think what we're
seeing so far is that you want more on the order of a half-core per
cosd (it will usually take much more than that, but CPU usage can get
higher during group recovery situations) than a tenth of a core. :)
More generally though, there just aren't enough large long-lived
clusters for us to have the relevant experience to know what's best.
:(

> But as the data will be replicated to another node, we can run the
> recovery in background, isn't it ? Does the recovery occurs when we
> replace the failed node with a new valid one or does it occur on the
> "surviving nodes of the cluster" immediatly after the failure ?
> Perhaps we could be able to set the recovery/smartfail process with a
> priority (low/normal/high) and thus controlling the CPU+IO impact ?
Yes, recovery does run in the background, but he's talking about the
sheer amount of data to transfer. If you have 48 OSDs/node (which I
think is probably too many) and you lose a disk, that's 1 disk that
needs to be transferred across the network. If you lose 2, that's 2
disks. If you're running a btrfs pool of 12 disks and you lose a disk,
that's 12 disks that need to be transferred. If you're running a
12-disk RAID and lose 2 disks (or 3 for RAID6, I guess), that's 12
disks that need to be transferred.

How you judge these risks versus the cost of running more daemons is
up to you. I think right now I'd create 2 OSDs/core you have and split
the disks up evenly between them on either a RAID array or btrfs pool,
depending on how cutting-edge you want to be. :) But that's my
judgement and isn't based on any risk calculations or whatever.
-Greg
