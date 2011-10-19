From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Space not freed when removing files
Date: Wed, 19 Oct 2011 08:34:07 -0700
Message-ID: <CAORUGqADQVixB4kXKaoh0Tzpsb2QHJAqnV-ZBYKfGXPUWCzrsg@mail.gmail.com>
References: <1300330817.383946.1319031737311.JavaMail.root@zmbs4.inria.fr> <240272892.383967.1319031822299.JavaMail.root@zmbs4.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36119 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1JSPe2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2011 11:34:28 -0400
Received: by wyg36 with SMTP id 36so1860470wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2011 08:34:27 -0700 (PDT)
In-Reply-To: <240272892.383967.1319031822299.JavaMail.root@zmbs4.inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cedric Morandin <cedric.morandin@inria.fr>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 19, 2011 at 06:43, Cedric Morandin <cedric.morandin@inria.fr> wrote:
> If I stop, then start everything /etc/init.d/ceph -a [stop,start], the space is freed:
>
> 2011-10-19 15:29:23.189312 pg v6407: 792 pgs: 792 active+clean; 210 GB data, 211 GB used, 105 GB / 334 GB avail

Instead of restarting, try waiting for a while.

Quoting an earlier email from Greg:

When you delete a file, it doesn't actually clear out the data right
away for a couple reasons[1]. Instead, it's marked as deleted on the
MDS and the MDS goes through and removes the objects storing it as
time is available. If you clear out the whole FS, this can naturally
take awhile since it requires a number of messages proportional to
amount of data in the cluster. If you look at your data usage again
you'll probably see it's lower now.
Some of the space is also used by the MDS journals (generally 100MB
for each MDS), and depending on how your storage is set up you might
also be seeing OSD journals in that space used (along with any other
files you have on the same partition as your OSD data store). This
should explain why you've got a bit of extra used space that isn't
just for replicating the FS data. :)
-Greg
[1] Two important reasons. First one is that there might be other
references to the objects in question due to snapshots, in which case
you don't want to erase the data -- especially since the client doing
the erasing might not know about these snapshots.
Second one is that to delete the data you need to send out a message
for each object -- ie, for every file you get one object and for every
file >4MB you get an object for each 4MB (and it's replicated, so
multiply by two or three for everything!). On a large tree this can
take awhile and you might not want the client to be spending its time
and bandwidth on such a user-useless activity.
