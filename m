From: huang jun <hjwsm1989@gmail.com>
Subject: Re: OSD questions
Date: Fri, 29 Jul 2011 08:44:45 +0800
Message-ID: <CABAwU-bd7vNpTNN0tvhEe09=2n9Dov6QfdW0dC3wcBkXnMPzgQ@mail.gmail.com>
References: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
	<CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
	<CAF3hT9BSbO3o6vBy0E3XPVJQz6X=W9VFVuWqjvdeyNR5x+j-Ng@mail.gmail.com>
	<CABAwU-Y5B2Fmy0J=6q3vn9_O0WGMy0PEV-QiwWXp0o12_CD8dg@mail.gmail.com>
	<Pine.LNX.4.64.1107280850250.13306@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60538 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1G2Aor convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 20:44:47 -0400
Received: by wwe5 with SMTP id 5so3014949wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 17:44:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107280850250.13306@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

2011/7/28 Sage Weil <sage@newdream.net>:
> On Thu, 28 Jul 2011, huang jun wrote:
>> 2011/7/28 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> > On Wed, Jul 27, 2011 at 9:05 AM, Gregory Farnum
>> > <gregory.farnum@dreamhost.com> wrote:
>> >> The doubled writes can be annoying, but it's really the only safe
>> >> thing to do. Perhaps we could do something with btrfs and snapsho=
ts to
>> >> avoid using a journal, but I'd have to look into it some more.
>> > Actually this already works -- you are data safe if you run btrfs
>> > without a journal. Apparently it's even slower, though -- you need=
 to
>> > go through a lot more syncs to guarantee your data safety.
>> >
>> we use btrfs and without journal, it turns out that :
>> the performance of big write(10GB) is good, but the rm dir ops goes =
slow.
>> So we reset the value of "filestore max sync interval =3D 0.1", the =
rm
>> dirs rate increased.
>
> Do you mean the rate that the rm operations completed, or the lag bef=
ore
> the space became available? =A0In general, a longer sync interval sho=
uld
> perform better (less fs commit overhead).
>
yes, the rm operation rate increased. we need 100s to remove 100 dirs
if we set the value filestore max sync interval =3D 1.But now, we just
need 13s to do the same.
>> Does this related to version of ceph kernel Client and kernel ? Can =
we
>> promote the DIR ops
>> performance on OSD end?
>
> There shouldn't be any synchronous IO in the namespace operation path=
s
> (except in odd situations involving multiple client interactions).
> (Unless you fsync(dirfd), that is!) =A0What latencies are you seeing?
>
> sage
>
>
>
>> > So your best bet if it's a real problem is to add a fast disk to u=
se
>> > as your journaling device.
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
