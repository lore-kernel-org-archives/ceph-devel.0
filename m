From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: The relationship between the number of cosd and memory cache
Date: Fri, 13 May 2011 09:14:05 -0700
Message-ID: <BANLkTi=FUUq7AEuha5RxFLYmUuXJfh+vbg@mail.gmail.com>
References: <BANLkTik4ZkyWzWNKCt2LqOgy9cqjELaw2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46707 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759536Ab1EMQOI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 12:14:08 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 452E0C065
	for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 09:14:07 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id E7B9AC062
	for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 09:14:06 -0700 (PDT)
Received: by eyx24 with SMTP id 24so751443eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 09:14:05 -0700 (PDT)
In-Reply-To: <BANLkTik4ZkyWzWNKCt2LqOgy9cqjELaw2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 13, 2011 at 1:00 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi developers,
> I have a question between the numbers of cosd and memory cache in a server.
> Here is my environment....
> I got 15 servers as OSDes and each one has 8 cores CPU, 16GB RAM and
> 1TB*12 Disks.
> I only have 1 MDS and 3 MONs(4 servers as total) and the
> specifications are the same as OSDes.
>
> I know that each cosd process would consume some memories and so does
> data transmission.
> In my environment, I set 10 cosd processes on each server.
> My assumption is that based on my scenario, the buffer used by each
> cosd would be (Total RAM-N*cosd used)/N .....(N is the number of cosd)
> That is,if I assume each cosd would use 200MB RAM, so each cosd would
> have about (16GB-10*200MB)/10 = 1.4GB RAM to use as buffer.
> I don't know if my assumption is right or not. Please correct me if it's wrong.
> "IF" my theory is right, would it be better if I set the number of
> cosd to be less?
> What I mean is that when I get less cosd process, each cosd would have
> more memories to use as buffer and it's better?
>
> In other words, based on my environment with 12 disks in a server, how
> many numbers of cosd should I set to get the best usage of memories?
> I know the more RAM, the better performance. But are there some kind
> of formulas to calculate the proportions between cosd and RAM?
> Thanks in advance!
Well, as you correctly note each cosd takes up some RAM to run, and
whatever's left over can be used by the page cache (the cosd doesn't
implement any of its own caching). In this sense, you only want one
daemon per machine, because that maximizes your ability to cache.

The reason you might want to run more than one daemon per machine is
to handle failure conditions better. If you have a daemon per disk,
then recovery becomes much faster in the case of a daemon failure; you
don't need to RAID your disks (losing space) or unify them with btrfs
(risking an entire node if one disk fails).

It's a tradeoff and you should evaluate it for yourself, basically --
unfortunately there's not enough experience yet to give you a rule of
thumb about which is "better".

I will say that you might want to turn your monitor machines into
OSD+mon machines -- the monitors don't use many resources and that's a
lot of memory going to waste! :)
-Greg
