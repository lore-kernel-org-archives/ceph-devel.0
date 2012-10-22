From: Yann ROBIN <yann.robin@youscribe.com>
Subject: Osd load and timeout when recovering
Date: Mon, 22 Oct 2012 10:27:29 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:42074
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab2JVK1e convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Oct 2012 06:27:34 -0400
Received: from mail71-co1 (localhost [127.0.0.1])	by mail71-co1-R.bigfish.com
 (Postfix) with ESMTP id D6D63B400FC	for <ceph-devel@vger.kernel.org>; Mon, 22
 Oct 2012 10:27:33 +0000 (UTC)
Received: from CO1EHSMHS012.bigfish.com (unknown [10.243.78.248])	by
 mail71-co1.bigfish.com (Postfix) with ESMTP id DCB3BB80055	for
 <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 10:27:30 +0000 (UTC)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We use ceph to store small file (lot of them) on different servers and =
access it using rados gateway.
Our data size is 380Go (very small). We have two host with 5 osd each.
We use small config for ceph : 2Go RAM server with 5 x 2To Disk (one OS=
D on each disk).
This is a very cheap config that allow us to keep our storing cost unde=
r control and it's enough to get the read performance we need.
(We use this config with mogilefs to store 150To of data)

This week-end we had an alert saying ceph was down.

After looking at the osd, we saw a very high load on osd (450 of load),=
 some were down.
Ceph -s displayed that we were having down pg, peering+down pg, remappe=
d pg. etc.

So we started to see that when we were peering and stuff like that, the=
 load was very high.
OSD stop responding and we could see in the log message like :
=46ileStore timeout and Abort Signal

So basically the cluster was under load because we was recovering... bu=
t because it was under load recovering could not complete.

We change this params to get a longer timeout :
filestore op thread suicide timeout =3D 360=20
filestore op thread timeout =3D 180=20
osd default notify timeout =3D 360

The cluster was still under heavy load, osd was still timeouting (less =
timeouting but still)

So we test param to "throttle" the "recovery" process :
filestore op threads =3D 6
filestore queue max ops =3D 24
osd recovery max active =3D 1

Load was better, but still very high (30).=20

We also try to put the journal in a tmpfs with zram.
We set noout so it won't copy files to satisfy the replicate count beca=
use osd were out.

We then updated to kernel 3.5 to get last xfs optim.

In the end nothing was working we were in the same infinite death loop =
of recovering =3D> load =3D> timeout =3D> recovering.
So we updated from ceph 0.48.2 to 0.53, load was better and recovery fi=
nally worked.

As we don't want to be in the position again (24h downtime), I have som=
e questions on ceph/rados.

1/ Even when we switch to ceph 0.53, the rados gateway was still not re=
sponding, Log was displaying Initalization timeout.
Is it normal that the "recovering" process kill the fact that we can re=
ad data from ceph ?=20
The data is here, it is just moving, why can't we access it ?

2/ In case of very high load because ceph is moving data, is there a wa=
y to tell ceph to go slowly ?


Thanks,

--
Yann ROBIN
Soci=E9t=E9 Publica
www.YouScribe.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
