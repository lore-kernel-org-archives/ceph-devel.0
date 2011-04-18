From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Suicide
Date: Mon, 18 Apr 2011 09:40:00 -0700
Message-ID: <BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com>
References: <4DA85AA6.8050707@provocation.net>
	<3704E18884CB47E081E09984151ACC7B@gmail.com>
	<4DA8C8FB.5050106@provocation.net>
	<161F0A2E50F1465996C6A9075A508C85@gmail.com>
	<4DA8D4EF.8090006@provocation.net>
	<25103BE141804650A169B6444F0D6D21@gmail.com>
	<4DAA2B38.1090706@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34292 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab1DRQkF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 12:40:05 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7B4B5C066
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 09:40:02 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id E5447C063
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 09:40:01 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1427443eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 09:40:00 -0700 (PDT)
In-Reply-To: <4DAA2B38.1090706@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Sat, Apr 16, 2011 at 2:53 AM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
> http://ceph.newdream.net/wiki/Debugging puts "debug journal" in the o=
sd
> section and "debug journaler" in the userspace clients section, but I=
 don't
> have any userspace clients; only the kernel modules. Just to make 100=
% sure
> that I get it right, which debug levels should I put in which section=
(s)?
In this case it's referring to the client for the OSD, and the MDS is
an OSD client like any other. So it goes in the MDS section. :)

> The two most probable causes of death were (a) irresponsivness becaus=
e of
> the load and (b) the filling up of the log partition.
>
> Now, if it was the filling up of the logs and I now put them where th=
ey won't
> fill up, then the error won't be reproduced. Then again, if I put the=
m where
> they will fill up, we won't have any node02 logs after they fill up, =
which is
> precisely those we need.
>
> On the other hand, if it was irresponsiveness that caused it, more lo=
gging
> will lead to more I/O, more trashing of that poor 2,5" drive and yet =
higher
> load, so we might run into the error before the logs fill up.
You're right, but if the cause of the problem was the disk filling up
then we're basically screwed anyway. Also, the debug output is done
well enough that that's not really possible. So I don't think
providing enough space for the debug output will change anything in
those terms. :)



On Sat, Apr 16, 2011 at 4:50 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
>
>
> On 04/16/2011 02:00 AM, Gregory Farnum wrote:
>
>> If you want to try to reproduce it for us in a useful fashion we'd
>> love that.
>
> I think I reproduced it, kind of. I got the hang and "error 5" on mou=
nt,
> but not the journal corruption. This is the timeline:
Okay. I don't think you'll get the journal corruption again as it
really is quite rare. Though we still want to handle all the other
problems too, of course! ;)


> A couple of minutes later the osd partitions stabilized at the same s=
ize
> and mounting ceph succeeded without problems.
>
> I'm speculating that something deadlocked unrecoverably at 19:56, lea=
ving
> different data in the journals. Restarting ceph removed the deadlock =
and
> allowed the journals to flush, restoring proper operation.
Some operations got hung for some reason. I'll check out your logs to
see if I can figure out what. That's why you couldn't umount -- due to
the hanging request the client couldn't flush out all its data so it
couldn't umount safely. It's also why you saw that some of the rsync
didn't complete -- you probably lost everything that was cached in
client-side buffers.

> I no longer remember exactly what I did last time, but it's very like=
ly
> that I unmounted and stopped ceph before switching off the machines o=
n
> Thursday night, but kept restarting it on Friday when I couldn't moun=
t it,
> not giving it enough time to flush its journals between each failed m=
ount
> attempt and the next restart, until somehow the journals got corrupte=
d.
That's probably basically correct -- we have no idea how the invariant
got broken but unsuccessful restarts are the most likely scenario in
terms of what modifies the appropriate data.

> You see above that the last file that appeared to be successfully tra=
nsferred
> by rsync this evening was feednews/time-00/40/05/7bb3-4696, which sho=
ws up
> in the logs at 19:55:45.746146. However, the logs also say that anoth=
er ~4000
> files were transferred between rsync's apparent hang and my ^C. Those=
 must be
> the ones that ended up lingering in the journal. If they were written=
 to the
> journal but not to the OSD, I believe rsync should still have gotten =
a "write
> OK" back from ceph, but it seems it didn't.
I think you're misunderstanding the journal here -- there is an OSD
journal which is part of the OSD, and there's an MDS log which records
metadata changes but not full file data.
Anyway, if what you mean is you see 4k files transferred in the Ceph
logs then that's probably data being flushed out from client-side
buffers.

> Anyway, trying to read and understand huge logs when you don't even k=
now
> what the log entries mean or what you're looking for, is very tiring =
and
> not very efficient, so I'll call it a day for now. =A0I'd appreciate =
it if
> you could give me some hints on what to look for, so I can go hunting=
 again
> in a more focused manner. In the meanwhile I've put the new logs at
> http://www.provocation.net/tmp/logs_take_2.tar.bz2 for you.
Yep, I'm checking these out today. :)
Thanks!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
