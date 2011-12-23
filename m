From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Bug #1047 reproduced
Date: Thu, 22 Dec 2011 16:27:14 -0800
Message-ID: <CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com>
References: <201112010937.37642.a.ott@m-privacy.de>
	<201112211337.44363.a.ott@m-privacy.de>
	<CAF3hT9AHa_7WNx+x5qf0iHwmphWu1LLfR-9NUvFjVScZy94JqA@mail.gmail.com>
	<201112211736.25725.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60147 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab1LWA1O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 19:27:14 -0500
Received: by iaeh11 with SMTP id h11so14226780iae.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 16:27:14 -0800 (PST)
In-Reply-To: <201112211736.25725.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 21, 2011 at 8:36 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> On Wednesday 21 December 2011 wrote Gregory Farnum:
>> On Wed, Dec 21, 2011 at 4:37 AM, Amon Ott <a.ott@m-privacy.de> wrote=
:
>> > On Friday 02 December 2011 wrote Sage Weil:
>> >> On Fri, 2 Dec 2011, Amon Ott wrote:
>> >> > On Thursday 01 December 2011 you wrote:
>> >> > > On all four nodes of my test cluster, MDS crashes with a trac=
e like
>> >> > > that in bug #1047. Example and ceph.conf attached. Ceph serve=
r side
>> >> > > is from git master, last commit
>> >> > > ce6572273943ffdca4b7dc5344152d6c35106a2d.
>> >> > >
>> >> > > MDS does not start on any node here, it reliably crashes with=
 that
>> >> > > assert.
>> >> >
>> >> > Does it makes sense for you to keep the cluster in that broken =
state,
>> >> > so that we can reproduce that bug or test a potential fix? Othe=
rwise,
>> >> > I would recreate the Ceph filesystem to make more tests. I also=
 have a
>> >> > full log of one mds from start to crash here.
>> >>
>> >> Can you attach the log to #1047 for posterity? =A0I'll take a qui=
ck look
>> >> and see if there is any further info to gain from the log. =A0I'm=
 guessing
>> >> the actual bug occured before the crash, when the anchor table wa=
sn't
>> >> updated properly, but there may be clues here.
>> >
>> > Did you find some time to look into this? The bug makes Ceph unusa=
ble for
>> > us even with moderate load. All mds instances die with the same as=
sert,
>> > the only way to recover in that state is to recreate the complete =
ceph fs
>> > and restore backups.
>>
>> Sage is gone on vacation right now (unless he decides not to be for =
a
>> while), but we've been focusing our efforts on the OSDs lately so I
>> don't think he's looked at it. I'll see if I can carve out some time
>> tomorrow or Friday, but I can't promise anything.
>>
>> Alexandre, can you check this bug and make sure it looks like the sa=
me
>> one you reported as #1850?
>
> Thank you for looking into it. The behaviour in #1850 looks quite sim=
ilar to
> our bug, apart from the hardlinks. We copy many files here in our tes=
ts, too.
> Last time I hit the bug I had really restarted the master mds.

Unfortunately there's not enough info in this log either. If you can
reproduce it with "mds debug =3D 20" and put that log somewhere, it
ought to be enough to work out what's going on, though. Sorry. :(
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
