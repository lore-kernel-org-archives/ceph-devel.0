From: Gregory Farnum <greg@inktank.com>
Subject: Re: Osd load and timeout when recovering
Date: Mon, 22 Oct 2012 07:26:15 -0700
Message-ID: <CAPYLRzjqaZCJPEHyGAbYv-=GManKL8PgRrXtdJQXjWBkSMs7KA@mail.gmail.com>
References: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46004 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab2JVO0Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 10:26:16 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3639718iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 07:26:16 -0700 (PDT)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 22, 2012 at 3:27 AM, Yann ROBIN <yann.robin@youscribe.com> =
wrote:
> Hi,
>
> We use ceph to store small file (lot of them) on different servers an=
d access it using rados gateway.
> Our data size is 380Go (very small). We have two host with 5 osd each=
=2E
> We use small config for ceph : 2Go RAM server with 5 x 2To Disk (one =
OSD on each disk).
> This is a very cheap config that allow us to keep our storing cost un=
der control and it's enough to get the read performance we need.
> (We use this config with mogilefs to store 150To of data)

These node sizes are one of your problems =97=A0while the OSDs in norma=
l
operation are only using 100-200MBs of memory, they can spike quite a
lot during recovery. We generally recommend 1GB of RAM per daemon.

> This week-end we had an alert saying ceph was down.
>
> After looking at the osd, we saw a very high load on osd (450 of load=
), some were down.
> Ceph -s displayed that we were having down pg, peering+down pg, remap=
ped pg. etc.
>
> So we started to see that when we were peering and stuff like that, t=
he load was very high.
> OSD stop responding and we could see in the log message like :
> FileStore timeout and Abort Signal

Right. That means the OSD was sending operations down to disk that
were taking so long to complete it timed them out. Default on a
=46ileStore operation is 60 seconds, and if it was actually suiciding
the OSD that requires the disk to be nonresponsive for 180 seconds.

> So basically the cluster was under load because we was recovering... =
but because it was under load recovering could not complete.
>
> We change this params to get a longer timeout :
> filestore op thread suicide timeout =3D 360
> filestore op thread timeout =3D 180
> osd default notify timeout =3D 360

Okay, the first two of those are fine. The third one is actually
related to the "notify" OSD operation, and isn't helping you here.


> The cluster was still under heavy load, osd was still timeouting (les=
s timeouting but still)
>
> So we test param to "throttle" the "recovery" process :
> filestore op threads =3D 6
> filestore queue max ops =3D 24
> osd recovery max active =3D 1

Okay, so now you've increased the number of simultaneous disk
operations the FileStore will dispatch from 2 to 6. That probably
didn't help. Decreasing the "filestore queue max ops" from 500 to
24...probably didn't do anything. But it might have; I'll defer to
others on that.
The one thing here that definitely did help is bringing down the "osd
recovery max active"...that's the number of PGs to try and recover
simultaneously; by dropping it from 5 to 1 you've reduced the total
number of recovery operations going on across the cluster.


> Load was better, but still very high (30).
>
> We also try to put the journal in a tmpfs with zram.

So, you took away RAM from the system? Ouch, but okay, maybe it's
reducing disk usage overall...

> We set noout so it won't copy files to satisfy the replicate count be=
cause osd were out.
>
> We then updated to kernel 3.5 to get last xfs optim.
>
> In the end nothing was working we were in the same infinite death loo=
p of recovering =3D> load =3D> timeout =3D> recovering.
> So we updated from ceph 0.48.2 to 0.53, load was better and recovery =
finally worked.

Right. You've run into a problem we call "cluster thrashing", in which
a problem with one OSD causes it to go out, and then the subsequent
map changes and data movement cause other OSDs to fall over as well.
This is a problem in argonaut which has been smoothed out a great deal
in subsequent development releases by greatly reducing the cost of OSD
map updates.


> As we don't want to be in the position again (24h downtime), I have s=
ome questions on ceph/rados.
>
> 1/ Even when we switch to ceph 0.53, the rados gateway was still not =
responding, Log was displaying Initalization timeout.
> Is it normal that the "recovering" process kill the fact that we can =
read data from ceph ?
> The data is here, it is just moving, why can't we access it ?

You had PGs that were in a "down" state, meaning that the OSD which is
supposed to be primary for them wasn't servicing requests yet. It
takes some time to establish who has the newest version of data in a
PG and gather up an active set.

> 2/ In case of very high load because ceph is moving data, is there a =
way to tell ceph to go slowly ?

There are a lot of switches you can throw to do this. You threw a
number of them. I'm not aware of any others off the top of my head,
but Sam or Sage might have more.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
