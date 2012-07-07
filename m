From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Sat, 07 Jul 2012 10:19:44 +0200
Message-ID: <4FF7F120.3040708@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com> <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com> <4FF6919C.8080201@univ-nantes.fr> <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:46114 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751720Ab2GGITu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jul 2012 04:19:50 -0400
In-Reply-To: <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 06/07/2012 19:01, Gregory Farnum a =E9crit :
> On Fri, Jul 6, 2012 at 12:19 AM, Yann Dupont <Yann.Dupont@univ-nantes=
=2Efr> wrote:
>> Le 05/07/2012 23:32, Gregory Farnum a =E9crit :
>>
>> [...]
>>
>>>> ok, so as all nodes were identical, I probably have hit a btrfs bu=
g (like
>>>> a
>>>> erroneous out of space ) in more or less the same time. And when 1=
 osd
>>>> was
>>>> out,
>>
>> OH , I didn't finish the sentence... When 1 osd was out, missing dat=
a was
>> copied on another nodes, probably speeding btrfs problem on those no=
des (I
>> suspect erroneous out of space conditions)
> Ah. How full are/were the disks?

The OSD nodes were below 50 % (all are 5 To volumes):

osd.0 : 31%
osd.1 : 31%
osd.2 : 39%
osd.3 : 65%
no osd.4 :)
osd.5 : 35%
osd.6 : 60%
osd.7 : 42%
osd.8 : 34%

all the volumes were using btrfs with lzo compress.

[...]
>
> Oh, interesting. Are the broken nodes all on the same set of arrays?
>>
>> No. There are 4 completely independant raid arrays, in 4 different
>> locations. They are similar (same brand & model, but slighltly diffe=
rent
>> disks, and 1 different firmware), all arrays are multipathed. I don'=
t think
>> the raid array is the problem. We use those particular models since =
2/3
>> years, and in the logs I don't see any problem that can be caused by=
 the
>> storage itself (like scsi or multipath errors)
> I must have misunderstood then. What did you mean by "1 Array for 2 O=
SD nodes"?

I have 8 osd nodes, in 4 different locations (several km away). In each=
=20
location I have 2 nodes and 1 raid Array.
On each location, each raid array has 16 2To disks, 2 controllers with=20
4x 8 Gb FC channels each. The 16 disks are organized in Raid 5 (8 disks=
=20
for one, 7 disks for the orher). Each raid set is primary attached to 1=
=20
controller, and each osd node on the location has acces to the=20
controller with 2 distinct paths.

There were no correlation between failed nodes & raid array.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
