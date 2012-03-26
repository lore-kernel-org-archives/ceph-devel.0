From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 13:05:46 -0700
Message-ID: <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com> <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35819 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab2CZUGH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 16:06:07 -0400
Received: by yenl12 with SMTP id l12so4167710yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 13:06:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 26, 2012 at 12:52, Sage Weil <sage@newdream.net> wrote:
>> For daemon crashes, perhaps the next run, after upstart/etc restarts
>> the daemon, can somehow convince others proactively that the new
>> osd.42 is better than the old osd.42. That sounds like a good feature
>> to have..
>
> That much we already have, but startup/restart can take a while.
> sysvinit doesn't do auto-restart, though, and it would be nice not to rely
> on it in upstart/whatever.

I think daemon restarting is just something you can assume to exist in
the modern world.

> I can also imagine a scenario where we don't have auto-restart but do want
> fast failure notification...

Perhaps a separate executable that sends "osd.42 is now definitely
down" will be good enough? Hopefully you don't have two osd.42's
around, anyway. And if you want that, instead of execing ceph-osd, you
do a fork & exec, wait in the parent, then exec that thing that marks
it down. For upstart (and often for others too), there's a "after the
service exits" hook where we could also plug that in, if we wanted to.
