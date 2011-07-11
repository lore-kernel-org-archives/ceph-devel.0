From: Vineet Jain <vinjvinj@gmail.com>
Subject: Re: Struggling with mds. It seems very fragile.
Date: Mon, 11 Jul 2011 19:43:49 -0400
Message-ID: <CAG_bnfzNhXTW5mkCq8+CVwGyCxfL-f+a5i=+7TtU48LVRrj6Yw@mail.gmail.com>
References: <CAG_bnfw72QOihdK9UWg5wbVht2dmO7-dJQCsFUAuESo=YNbrTg@mail.gmail.com>
	<CAORUGqD-jfn6uJe8sa6e-GRzxWA5XkAh75+OMMOzCYjd8Y9wnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32868 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab1GKXnv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 19:43:51 -0400
Received: by bwd5 with SMTP id 5so3633594bwd.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 16:43:50 -0700 (PDT)
In-Reply-To: <CAORUGqD-jfn6uJe8sa6e-GRzxWA5XkAh75+OMMOzCYjd8Y9wnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the offer to help. I have limited hardware at the moment
and am going with another solution.  My preference would be to have a
rock solid simple setup first. One MDS, One monitor, and a few OSD's
all on the same machine, but it should be very difficult to crash the
system in the most simple setup. And if you do there should be a fail
safe way to bring it back (I'm okay if I loose the last x hours of
changes). Unfortunately, I was able to crash the mds twice in a just a
few hours of use with no simple way to revert back my changes.

On trying moosefs, I got much further along (Ceph has a lot more
functionality than moosefs so this might not be a fair comparison. For
me, I'm willing to give up functionality for stability). I did crash
moosefs once but, they snapshot their meta data so I was able to
revert back to a file an hour back and was back and was back up and
running wit no help from outside. They also have a very cool web
interface.

I'll be watching ceph closely and will be back in a few months to try
it again. Thanks for all your hard work.

On Mon, Jul 11, 2011 at 12:24 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Jul 8, 2011 at 20:39, Vineet Jain <vinjvinj@gmail.com> wrote:
>> Using ceph version 0.3 and the ceph kernel that comes with ubuntu 11.04.
>>
>> I've setup 5 osds and one one mon and mds on one machine. When I first
>> started, without writing any data to the ceph fs my mds would keep
>> crashing. I fixed that problem by deleting the mod data directory and
>> the ceph data directories and restarting ceph. I then started copying
>> test data from a 2tb external drive to my ceph fs. I left my computer
>> and came back and could not login to my machine. I saw that the
>> external drive light was blinking so something was going on. I did a
>> hard power off thinking I would just delete the last file that was
>> copied over and start over.
>>
>> As expected, I could not start up ceph again. I had to delete all the
>> data directories again to get ceph up again. Is there any way to flush
>> whatever to get ceph back to some sort of stage where you can enter
>> back into the fs without having to purge everything a start over?
>
> Can you please provide core dumps and log messages from those MDS
> crashes? Getting tickets filed at
> http://tracker.newdream.net/projects/ceph with the relevant
> information is what will help us fix your problems.
>
> Recovery, where not automatic, depends very much on the crash you saw.
> We'd be glad to help, but need more information to do so.
>
