From: Samuel Just <sam.just@inktank.com>
Subject: Re: domino-style OSD crash
Date: Mon, 9 Jul 2012 10:14:03 -0700
Message-ID: <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com>
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
	<CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
	<4FF7F120.3040708@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42898 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GIROF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 13:14:05 -0400
Received: by ghrr11 with SMTP id r11so10323895ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 10:14:04 -0700 (PDT)
In-Reply-To: <4FF7F120.3040708@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Can you restart the node that failed to complete the upgrade with

debug filestore =3D 20
debug osd =3D 20

and post the log after an hour or so of running?  The upgrade process
might legitimately take a while.
-Sam

On Sat, Jul 7, 2012 at 1:19 AM, Yann Dupont <Yann.Dupont@univ-nantes.fr=
> wrote:
> Le 06/07/2012 19:01, Gregory Farnum a =E9crit :
>
>> On Fri, Jul 6, 2012 at 12:19 AM, Yann Dupont <Yann.Dupont@univ-nante=
s.fr>
>> wrote:
>>>
>>> Le 05/07/2012 23:32, Gregory Farnum a =E9crit :
>>>
>>> [...]
>>>
>>>>> ok, so as all nodes were identical, I probably have hit a btrfs b=
ug
>>>>> (like
>>>>> a
>>>>> erroneous out of space ) in more or less the same time. And when =
1 osd
>>>>> was
>>>>> out,
>>>
>>>
>>> OH , I didn't finish the sentence... When 1 osd was out, missing da=
ta was
>>> copied on another nodes, probably speeding btrfs problem on those n=
odes
>>> (I
>>> suspect erroneous out of space conditions)
>>
>> Ah. How full are/were the disks?
>
>
> The OSD nodes were below 50 % (all are 5 To volumes):
>
> osd.0 : 31%
> osd.1 : 31%
> osd.2 : 39%
> osd.3 : 65%
> no osd.4 :)
> osd.5 : 35%
> osd.6 : 60%
> osd.7 : 42%
> osd.8 : 34%
>
> all the volumes were using btrfs with lzo compress.
>
> [...]
>
>>
>> Oh, interesting. Are the broken nodes all on the same set of arrays?
>>>
>>>
>>> No. There are 4 completely independant raid arrays, in 4 different
>>> locations. They are similar (same brand & model, but slighltly diff=
erent
>>> disks, and 1 different firmware), all arrays are multipathed. I don=
't
>>> think
>>> the raid array is the problem. We use those particular models since=
 2/3
>>> years, and in the logs I don't see any problem that can be caused b=
y the
>>> storage itself (like scsi or multipath errors)
>>
>> I must have misunderstood then. What did you mean by "1 Array for 2 =
OSD
>> nodes"?
>
>
> I have 8 osd nodes, in 4 different locations (several km away). In ea=
ch
> location I have 2 nodes and 1 raid Array.
> On each location, each raid array has 16 2To disks, 2 controllers wit=
h 4x 8
> Gb FC channels each. The 16 disks are organized in Raid 5 (8 disks fo=
r one,
> 7 disks for the orher). Each raid set is primary attached to 1 contro=
ller,
> and each osd node on the location has acces to the controller with 2
> distinct paths.
>
> There were no correlation between failed nodes & raid array.
>
>
> Cheers,
>
> --
> Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
> Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
