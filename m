From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 21:32:01 +0100
Message-ID: <50903941.90805@profihost.ag>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com> <508EE540.5060303@inktank.com> <CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com> <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com> <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com> <508FD83F.9020308@profihost.ag> <CAPYLRzh3AV41CnY5VMPAtuggZxr6NidDrYF0ODYL6H64vEBVeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37723 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934369Ab2J3UcE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 16:32:04 -0400
In-Reply-To: <CAPYLRzh3AV41CnY5VMPAtuggZxr6NidDrYF0ODYL6H64vEBVeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

Am 30.10.2012 14:45, schrieb Gregory Farnum:
>> But there's still the problem of slow random write IOP/s. At least i=
 haven't
>> seen any good benchmarks.
>
> It's not magic =97 I haven't done extensive testing but I believe peo=
ple
> see aggregate IOPs of about what you can calculate:
> (number of storage disks * IOPS per disks) / (replication level)
> The journaling bumps that up a little bit for bursts, of course;
> similarly if you're doing it on a brand new RBD image it can be a bit
> slower since you need to create all the objects as well as write data
> to them. You need to architect your storage system to match your
> requirements. If you want to run write-heavy databases on RBD, there
> are people doing that. They're using SSDs and are very pleased with
> its performance. *shrug*

My last test was with 0.49 so i can't talk about 0.52 but as far as i=20
know nothing has changed in this case.

I had 6 Dedicated servers running each with 4x Intel 520series SSDs=20
running 4 OSDs (one OSD per disk). I had the journal running in tmpfs=20
1GB size to be sure it isn't the bottleneck. Replication was set to 2.

Each SSD is capable of doing 30.000 IOP/s random 4k.

But with RBD i wasn't able to get more than 20.000 IOP/s but overall i =
had:
6 ded. servers * 4 SSDS =3D> 24 OSDs/SSDs * 30.000 IOP/s / Replication =
2=20
=3D> 360.000 iop/s theoretical overall performance

But i didn't get more than 20.000 while using 3.6Ghz Xeon CPUs and Dual=
=20
10GBE.

Greets,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
