From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Struggling with mds. It seems very fragile.
Date: Mon, 11 Jul 2011 09:24:59 -0700
Message-ID: <CAORUGqD-jfn6uJe8sa6e-GRzxWA5XkAh75+OMMOzCYjd8Y9wnQ@mail.gmail.com>
References: <CAG_bnfw72QOihdK9UWg5wbVht2dmO7-dJQCsFUAuESo=YNbrTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43363 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945Ab1GKQZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 12:25:20 -0400
Received: by ewy4 with SMTP id 4so1417190ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 09:25:19 -0700 (PDT)
In-Reply-To: <CAG_bnfw72QOihdK9UWg5wbVht2dmO7-dJQCsFUAuESo=YNbrTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vineet Jain <vinjvinj@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 8, 2011 at 20:39, Vineet Jain <vinjvinj@gmail.com> wrote:
> Using ceph version 0.3 and the ceph kernel that comes with ubuntu 11.04.
>
> I've setup 5 osds and one one mon and mds on one machine. When I first
> started, without writing any data to the ceph fs my mds would keep
> crashing. I fixed that problem by deleting the mod data directory and
> the ceph data directories and restarting ceph. I then started copying
> test data from a 2tb external drive to my ceph fs. I left my computer
> and came back and could not login to my machine. I saw that the
> external drive light was blinking so something was going on. I did a
> hard power off thinking I would just delete the last file that was
> copied over and start over.
>
> As expected, I could not start up ceph again. I had to delete all the
> data directories again to get ceph up again. Is there any way to flush
> whatever to get ceph back to some sort of stage where you can enter
> back into the fs without having to purge everything a start over?

Can you please provide core dumps and log messages from those MDS
crashes? Getting tickets filed at
http://tracker.newdream.net/projects/ceph with the relevant
information is what will help us fix your problems.

Recovery, where not automatic, depends very much on the crash you saw.
We'd be glad to help, but need more information to do so.
