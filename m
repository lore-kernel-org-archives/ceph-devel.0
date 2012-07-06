From: Gregory Farnum <greg@inktank.com>
Subject: Re: domino-style OSD crash
Date: Fri, 6 Jul 2012 10:01:28 -0700
Message-ID: <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr>
	<CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
	<CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
	<4FF2AFEB.1010403@univ-nantes.fr>
	<CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
	<4FF35C01.4070400@univ-nantes.fr>
	<CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
	<4FF3F98C.30602@univ-nantes.fr>
	<A1B0B821610446B587EA459CA7D88ECF@inktank.com>
	<4FF48317.5030802@univ-nantes.fr>
	<CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
	<4FF6919C.8080201@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34278 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2GFRBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 13:01:30 -0400
Received: by lbbgm6 with SMTP id gm6so15584700lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 10:01:28 -0700 (PDT)
In-Reply-To: <4FF6919C.8080201@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 6, 2012 at 12:19 AM, Yann Dupont <Yann.Dupont@univ-nantes.f=
r> wrote:
> Le 05/07/2012 23:32, Gregory Farnum a =E9crit :
>
> [...]
>
>>> ok, so as all nodes were identical, I probably have hit a btrfs bug=
 (like
>>> a
>>> erroneous out of space ) in more or less the same time. And when 1 =
osd
>>> was
>>> out,
>
>
> OH , I didn't finish the sentence... When 1 osd was out, missing data=
 was
> copied on another nodes, probably speeding btrfs problem on those nod=
es (I
> suspect erroneous out of space conditions)

Ah. How full are/were the disks?

>
> I've reformatted OSD with xfs. Performance is slightly worse for the =
moment
> (well, depend on the workload, and maybe lack of syncfs is to blame),=
 but at
> least I hope to have the storage layer rock-solid. BTW, I've managed =
to keep
> the faulty btrfs volumes .
>
> [...]
>
>
>>>> I wonder if maybe there's a confounding factor here =97 are all yo=
ur nodes
>>>> similar to each other,
>>>
>>> Yes. I designed the cluster that way. All nodes are identical hardw=
are
>>> (powerEdge M610, 10G intel ethernet + emulex fibre channel attached=
 to
>>> storage (1 Array for 2 OSD nodes, 1 controller dedicated for each O=
SD)
>>
>> Oh, interesting. Are the broken nodes all on the same set of arrays?
>
>
> No. There are 4 completely independant raid arrays, in 4 different
> locations. They are similar (same brand & model, but slighltly differ=
ent
> disks, and 1 different firmware), all arrays are multipathed. I don't=
 think
> the raid array is the problem. We use those particular models since 2=
/3
> years, and in the logs I don't see any problem that can be caused by =
the
> storage itself (like scsi or multipath errors)

I must have misunderstood then. What did you mean by "1 Array for 2 OSD=
 nodes"?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
