From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Degraded PGs blocking open()?
Date: Mon, 6 Jun 2011 19:15:31 -0700
Message-ID: <BANLkTimt0MKyd9ZOqxYm=z91HNS+5B=a1g@mail.gmail.com>
References: <201106070237.34854.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53464 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1FGCPd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2011 22:15:33 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8BB84C2C8
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2011 19:15:33 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3A21BC2C6
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2011 19:15:33 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1571529eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jun 2011 19:15:31 -0700 (PDT)
In-Reply-To: <201106070237.34854.szekelyi@niif.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2011/6/6 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> Hi all,
>
> I have a three node ceph setup, two nodes playing all three roles (OS=
D, MDS,
> MON), and one being just a monitor (which happens to be the client I'=
m using
> the filesystem from).
>
> I want to achieve high availablity by mirroring all data between the =
OSDs and
> being able to still access everything even if one of them goes down. =
The
> mirroring works fine, I see the space being consumed on both nodes as=
 I copy
> data on the file system. According to `ceph -s`, all PGs are in activ=
e+clean
> state. If I start reading a big file and shut down one of the (OSD+MD=
S+MON)
> nodes, the file can still be read until the end, that's fine. Moreove=
r, the
> contents read back seem correct when compared to the original file. V=
ery nice.
> But if I start reading the file while one of the nodes is down, it bl=
ocks until
> the node comes up again. I can't even kill the reading process with K=
ILL,
> TERM, or INT.
>
> Am I doing something wrong, or was not careful enough reading the doc=
s, or may
> this be a bug? My ceph.conf is attached.
The problem isn't in the OSD, it's the MDS. :)

The MDS system is *slightly* less resilient than the OSD system is.
You can set up "standby" MDSes that will take over if the system
detects that an MDS has died; you can even set up "standby-replay"
MDSes that follow a specific MDS and keep all its data cached in
memory so they can take over right when a failure is detected. But if
you lose one MDS its data won't automatically be imported into the
remaining MDSes. (Because the MDS keeps all its data on the OSDs,
there's no danger of losing data -- it's a matter of how the data is
segregated that requires a new daemon. And generally the process is
dominated by the timeout, not the time it takes the new MDS to take
over.)
So in your case, you're trying to open a file that is controlled by
the MDS that you killed, and the client can't get the "capability"
bits that it needs in order to look at the file. So you've got a few
options:
1) Kill the OSD, but not the MDS.
2) Create an extra MDS daemon, perhaps on your monitor node. When the
system detects that one of your MDSes has died (a configurable
timeout, IIRC in the neighborhood of 30-60 seconds), this extra daemon
will take over.
(Or you can just start up the new daemon after you kill the old one,
doesn't matter.)
3) Create a new system with only one MDS and don't kill that one.
(Eventually you will be able to shrink the number of MDSes, but this
isn't well-tested or documented so I'm not sure what state it's in
right now.)

I recommend option 2 for maximum wow. ;)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
