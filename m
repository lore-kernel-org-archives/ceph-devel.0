From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: HEALTH_WARNING
Date: Tue, 5 Apr 2011 21:07:52 +0200 (CEST)
Message-ID: <617102443.13876.1302030472004.JavaMail.root@mail.linserv.se>
References: <290366553.13874.1302029956409.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:59498 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab1DETOl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 15:14:41 -0400
In-Reply-To: <290366553.13874.1302029956409.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

I did clear some data and the restart but the osd didn't go online agai=
n. Instead The osd was running for some time and then they became dead =
one by one.

I was re-creating the filesystem and transfering data again with a simi=
lar result. This time the filesystem was not filled up.
It seems as the filesystem is hanginging and I can't get any respons fr=
om it.

I have done same process again, during the creation it complained on jo=
urnaling
hdparm -W 0 /dev/sda2. This time I made sure it didn't complain on the =
hdparam of the SSD disks, while I was creating the filesystem

on my host where the filesystem is mounted i have seen some dmesg conec=
tion filed

[16143.534936] libceph: client4428 fsid 19be9ae7-cdf8-cb03-4178-568342d=
30fa5
[16143.535092] libceph: mon0 10.0.6.10:6789 session established
[16224.427969] libceph: mon0 10.0.6.10:6789 socket closed
[16224.427975] libceph: mon0 10.0.6.10:6789 session lost, hunting for n=
ew mon
[16224.429637] libceph: mon0 10.0.6.10:6789 connection failed
[16233.700478] libceph: mon1 10.0.6.11:6789 connection failed
[16243.716405] libceph: mon2 10.0.6.12:6789 connection failed
[16253.728529] libceph: mon2 10.0.6.12:6789 connection failed
[17008.794981] libceph: client4107 fsid 2c3fefe7-3362-f541-27b4-64176ad=
b3f22
[17008.795127] libceph: mon0 10.0.6.10:6789 session established

Not sure I have everything configured corectly ?

Regards Martin

----- Ursprungligt meddelande -----=20
=46r=C3=A5n: "Gregory Farnum" <gregf@hq.newdream.net>=20
Till: "Martin Wilderoth" <martin.wilderoth@linserv.se>=20
Kopia: ceph-devel@vger.kernel.org=20
Skickat: m=C3=A5ndag, 4 apr 2011 1:38:48=20
=C3=84mne: Re: HEALTH_WARNING=20

On Sat, Apr 2, 2011 at 3:55 AM, Martin Wilderoth=20
<martin.wilderoth@linserv.se> wrote:=20
> Hello,=20
>=20
> I have seperate partitions for my osd and the btrfs file system.=20
> I also use SSD-disk for journaling.=20
>=20
> But I got problem when the root system was filled up with logfiles on=
 one host,=20
> the file system reported out of diskspace.=20
>=20
> But the osd's were not filled to 100%. Later I realised that the root=
 system on one of the osd hosts (osd2 and osd3) had no space left, to m=
uch logging.=20
>=20
> The only way I know to recover is to create a new filesystem in the c=
luster :-)=20
> But it's bad fot the data :-)=20
>=20
> When i get problems with one osd it seems as if they are crashing one=
 by one.=20
> And i dont know how to get them up again whitout deleting all the dat=
a.=20
You should be able to simply clear up some space (don't remove any of=20
the actual OSD data though!) and then start up the OSD daemon, at=20
which point it ought to automatically rejoin the cluster.=20
Is this not working? If not, please start up the daemon with higher=20
levels of debug logging and put the logs somewhere accessible.=20
-Greg=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
