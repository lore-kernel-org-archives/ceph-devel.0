From: Wido den Hollander <wido@pcextreme.nl>
Subject: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 14:47:30 +0200
Message-ID: <1274359650.1907.212.camel@wido-desktop>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:50533 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab0ETMrf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 08:47:35 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id 0669D232D8D
	for <ceph-devel@vger.kernel.org>; Thu, 20 May 2010 14:47:33 +0200 (CEST)
Received: from [192.168.6.32] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id 298F06000083
	for <ceph-devel@vger.kernel.org>; Thu, 20 May 2010 14:48:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When hanging around the mailinglist i noticed that there are a lot of
questions about Ceph and possible hardware setups.

After reading http://ceph.newdream.net/wiki/Designing_a_cluster i've
still got a lot of questions hanging around, so this is why i'm making
this post.

I in my situation i would like to run Ceph on the cheapest (best bang
for buck) hardware available.

Think about simple servers with 4 to 6 harddisks (desktop mainboards,
cpu's and disks) and building Ceph on top of that.

We want to skip the expensive RAID controllers, since they become
obsolute when using Ceph and setting the replication on the desired
level.

Now we get to the OSD topic:
* One cosd per disk?
* Btrfs stripe accross these disks?
* What about journaling?

With a custom CRUSH map
( http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH ) you
can place data on strategic locations, in my situation i would create 5
pools with each 4 OSD's, where these 4 pools are all located in seperat=
e
19" racks. In each rack i would hang:
* 1 MON
* 1 MDS
* 4 OSD's

Why 5 pools? This is because i would need a odd number of monitors. Yes=
,
i could choose to place 3 monitors, but i would like to create a pool
where al 6 machines are connected to the same switch. Is this
reasonable? Or is that many monitors really overdone?

Now, the OSD's all have 4 to 6 harddisks (but lets stick to 4), now i
have the option to run an OSD for each harddisk, which would give me
shorter recover times when a disk fails, but would give me extra
configuration / administration.

But i could also choose to make one btrfs stripe over these 4 disks and
run one OSD. This would give me a higher recover time when a disk fails
(since the whole stripe fails), but would keep my config smaller.

In the first setup i would only benefit if i could replace the failed
disk hot-swap. If not, i would have to bring the whole system down,
which would take the other 3 OSD's with it, thus leaving my cluster wit=
h
4 less OSD's.

I could buy more expensive hardware with hot-swap capabilities, but imh=
o
that is not really what i would like to do with Ceph.

I'd prefer the situation where i'd stripe over all 4 disks, giving me
and extra pro. In this situation i could configure my node to panic
whenever a disk is starting to give errors, so my cluster can take over
immediately.

Am i right? Is this "the way to go"?

Then there is the journaling topic.

When creating a filesystem you get a big warning if the drive cache is
enabled on the journaling partition. Imho you don't want to have a driv=
e
cache on your journal, but you do want to have one on your data
partition.

This forces you to use a seperate disk for your journaling. Assume that
i would have 4 disks in a btrfs stripe, would a fifth disk for
journaling only be sufficient? I assume so, since it only has to hold
data for a few seconds.

But how important is the journaling? If i choose to not use the journal=
,
how big will my penalty be, for lets say a situation where most of the
files will be small (webhosting / mailhosting usage).

I hope someone could give a answer on these questions, which would
clarify things for a lot of people. (And it would add an interesting
message to the ml ;-) )

Note: I've read http://marc.info/?l=3Dceph-devel&m=3D126990365515892&w=3D=
2
before, my post is based on that thread.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
