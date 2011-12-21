From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Bug #1047 reproduced
Date: Wed, 21 Dec 2011 08:18:51 -0800
Message-ID: <CAF3hT9AHa_7WNx+x5qf0iHwmphWu1LLfR-9NUvFjVScZy94JqA@mail.gmail.com>
References: <201112010937.37642.a.ott@m-privacy.de>
	<201112021217.10054.a.ott@m-privacy.de>
	<Pine.LNX.4.64.1112020855440.10925@cobra.newdream.net>
	<201112211337.44363.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49377 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab1LUQSv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 11:18:51 -0500
Received: by iaeh11 with SMTP id h11so12086668iae.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2011 08:18:51 -0800 (PST)
In-Reply-To: <201112211337.44363.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Alexandre Oliva <oliva@lsd.ic.unicamp.br>

On Wed, Dec 21, 2011 at 4:37 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> On Friday 02 December 2011 wrote Sage Weil:
>> On Fri, 2 Dec 2011, Amon Ott wrote:
>> > On Thursday 01 December 2011 you wrote:
>> > > On all four nodes of my test cluster, MDS crashes with a trace l=
ike
>> > > that in bug #1047. Example and ceph.conf attached. Ceph server s=
ide is
>> > > from git master, last commit ce6572273943ffdca4b7dc5344152d6c351=
06a2d.
>> > >
>> > > MDS does not start on any node here, it reliably crashes with th=
at
>> > > assert.
>> >
>> > Does it makes sense for you to keep the cluster in that broken sta=
te, so
>> > that we can reproduce that bug or test a potential fix? Otherwise,=
 I
>> > would recreate the Ceph filesystem to make more tests. I also have=
 a full
>> > log of one mds from start to crash here.
>>
>> Can you attach the log to #1047 for posterity? =A0I'll take a quick =
look and
>> see if there is any further info to gain from the log. =A0I'm guessi=
ng the
>> actual bug occured before the crash, when the anchor table wasn't up=
dated
>> properly, but there may be clues here.
>
> Did you find some time to look into this? The bug makes Ceph unusable=
 for us
> even with moderate load. All mds instances die with the same assert, =
the only
> way to recover in that state is to recreate the complete ceph fs and =
restore
> backups.

Sage is gone on vacation right now (unless he decides not to be for a
while), but we've been focusing our efforts on the OSDs lately so I
don't think he's looked at it. I'll see if I can carve out some time
tomorrow or Friday, but I can't promise anything.

Alexandre, can you check this bug and make sure it looks like the same
one you reported as #1850?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
