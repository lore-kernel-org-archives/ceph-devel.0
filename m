From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 14:30:09 -0700
Message-ID: <CAPYLRzhAR7namvfZ18X-BFLBt9da8bjLztpwtzFSKpO-z26i_w@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
	<CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
	<CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
	<CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
	<CAMsVa3vMBh6MoMS1pHc6HzNgJUhLp8Dyr5GzVYE9BKGFye2pBQ@mail.gmail.com>
	<CAPYLRzjiD+2dQ=C=VRbVa=3T4=05LD_WRvj0tJygfpqdZoYJ-g@mail.gmail.com>
	<CAMsVa3vN_MKtSbYhitYEhNNn-WO5LJW135TJ7S1yUnt56_oSQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60592 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab2F2VaL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 17:30:11 -0400
Received: by lbbgm6 with SMTP id gm6so5192913lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 14:30:09 -0700 (PDT)
In-Reply-To: <CAMsVa3vN_MKtSbYhitYEhNNn-WO5LJW135TJ7S1yUnt56_oSQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Edmonds <mornir@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 2:18 PM, Brian Edmonds <mornir@gmail.com> wrote=
:
> On Fri, Jun 29, 2012 at 2:11 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>> Well, actually this depends on the filesystem you're using. With
>> btrfs, the OSD will roll back to a consistent state, but you don't
>> know how out-of-date that state is.
>
> Ok, so assuming btrfs, then a single machine failure with a ramdisk
> journal should not result in any data loss, assuming replication is
> working? =A0The cluster would then be at risk of data loss primarily
> from a full power outage. =A0(In practice I'd expect either one machi=
ne
> to die, or a power loss to take out all of them, and smaller but
> non-unitary losses would be uncommon.)

That's correct. And replication will be working =97 it's all
synchronous, so if the replication isn't working, you won't be able to
write. :) There are some edge cases here =97=A0if an OSD is "down" but =
not
"out" then you might not have the same number of data copies as
normal, but that's all configurable.

>
> Something to play with, perhaps.
>
> Brian.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
