From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Osd load and timeout when recovering
Date: Mon, 22 Oct 2012 14:02:36 +0200
Message-ID: <508535DC.5070506@widodh.nl>
References: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40865 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab2JVMCi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 08:02:38 -0400
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/22/2012 12:27 PM, Yann ROBIN wrote:
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
>
> This week-end we had an alert saying ceph was down.
>
> After looking at the osd, we saw a very high load on osd (450 of load=
), some were down.
> Ceph -s displayed that we were having down pg, peering+down pg, remap=
ped pg. etc.
>

Could you tell us a bit more?

When the load was 450, was this mainly due to disk I/O wait?
Did the machines start to swap?

Could it be that the swapping was actually causing the machines to die=20
even more?

Although a OSD could run with 100M of memory, during recovery it can=20
grow quite fast.

> So we started to see that when we were peering and stuff like that, t=
he load was very high.
> OSD stop responding and we could see in the log message like :
> FileStore timeout and Abort Signal
>
> So basically the cluster was under load because we was recovering... =
but because it was under load recovering could not complete.
>

=46ileStore aborts indicate that it couldn't get the work done quickly=20
enough. I've seen this with btrfs, but you say you are using XFS.

You say you are storing small files. What exactly is "small"?

Wido

> We change this params to get a longer timeout :
> filestore op thread suicide timeout =3D 360
> filestore op thread timeout =3D 180
> osd default notify timeout =3D 360
>
> The cluster was still under heavy load, osd was still timeouting (les=
s timeouting but still)
>
> So we test param to "throttle" the "recovery" process :
> filestore op threads =3D 6
> filestore queue max ops =3D 24
> osd recovery max active =3D 1
>
> Load was better, but still very high (30).
>
> We also try to put the journal in a tmpfs with zram.
> We set noout so it won't copy files to satisfy the replicate count be=
cause osd were out.
>
> We then updated to kernel 3.5 to get last xfs optim.
>
> In the end nothing was working we were in the same infinite death loo=
p of recovering =3D> load =3D> timeout =3D> recovering.
> So we updated from ceph 0.48.2 to 0.53, load was better and recovery =
finally worked.
>
> As we don't want to be in the position again (24h downtime), I have s=
ome questions on ceph/rados.
>
> 1/ Even when we switch to ceph 0.53, the rados gateway was still not =
responding, Log was displaying Initalization timeout.
> Is it normal that the "recovering" process kill the fact that we can =
read data from ceph ?
> The data is here, it is just moving, why can't we access it ?
>
> 2/ In case of very high load because ceph is moving data, is there a =
way to tell ceph to go slowly ?
>
>
> Thanks,
>
> --
> Yann ROBIN
> Soci=E9t=E9 Publica
> www.YouScribe.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
