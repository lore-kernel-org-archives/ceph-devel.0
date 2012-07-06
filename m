From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Fri, 06 Jul 2012 09:19:56 +0200
Message-ID: <4FF6919C.8080201@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com> <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:59605 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750802Ab2GFIMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 04:12:15 -0400
In-Reply-To: <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 05/07/2012 23:32, Gregory Farnum a =E9crit :

[...]
>> ok, so as all nodes were identical, I probably have hit a btrfs bug =
(like a
>> erroneous out of space ) in more or less the same time. And when 1 o=
sd was
>> out,

OH , I didn't finish the sentence... When 1 osd was out, missing data=20
was copied on another nodes, probably speeding btrfs problem on those=20
nodes (I suspect erroneous out of space conditions)

I've reformatted OSD with xfs. Performance is slightly worse for the=20
moment (well, depend on the workload, and maybe lack of syncfs is to=20
blame), but at least I hope to have the storage layer rock-solid. BTW,=20
I've managed to keep the faulty btrfs volumes .

[...]

>>> I wonder if maybe there's a confounding factor here =97 are all you=
r nodes
>>> similar to each other,
>> Yes. I designed the cluster that way. All nodes are identical hardwa=
re
>> (powerEdge M610, 10G intel ethernet + emulex fibre channel attached =
to
>> storage (1 Array for 2 OSD nodes, 1 controller dedicated for each OS=
D)
> Oh, interesting. Are the broken nodes all on the same set of arrays?

No. There are 4 completely independant raid arrays, in 4 different=20
locations. They are similar (same brand & model, but slighltly differen=
t=20
disks, and 1 different firmware), all arrays are multipathed. I don't=20
think the raid array is the problem. We use those particular models=20
since 2/3 years, and in the logs I don't see any problem that can be=20
caused by the storage itself (like scsi or multipath errors)

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
