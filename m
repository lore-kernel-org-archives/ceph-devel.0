From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: HEALTH_WARNING
Date: Sat, 2 Apr 2011 12:55:38 +0200 (CEST)
Message-ID: <718796783.13438.1301741738011.JavaMail.root@mail.linserv.se>
References: <1463999357.13436.1301740919511.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:34917 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab1DBLCX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2011 07:02:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 7B3AE1204E1
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 12:55:38 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yH0Cm1Gy99pt for <ceph-devel@vger.kernel.org>;
	Sat,  2 Apr 2011 12:55:38 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 1FA29120034
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 12:55:38 +0200 (CEST)
In-Reply-To: <1463999357.13436.1301740919511.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have seperate partitions for my osd and the btrfs file system.
I also use SSD-disk for journaling.

But I got problem when the root system was filled up with logfiles on o=
ne host,
the file system reported out of diskspace.

But the osd's were not filled to 100%. Later I realised that the root s=
ystem on one of the osd hosts (osd2 and osd3) had no space left, to muc=
h logging.

The only way I know to recover is to create a new filesystem in the clu=
ster :-)
But it's bad fot the data :-)

When i get problems with one osd it seems as if they are crashing one b=
y one.
And i dont know how to get them up again whitout deleting all the data.
=C2=A0=C2=A0
Hi,=20

On Sat, 2011-04-02 at 05:59 +0200, Martin Wilderoth wrote:=20
> Hello,=20
>=20
> One of my hosts run out of diskspace on the root file system (logfile=
s)=20
> So I restared ceph. Discoverd the low diskspace during the restart. o=
sd2 and osd3=20
>=20

Do you have separate partitions for your OSD data? Or do you have one=20
big / partition? I'd recommend a separate partition for your OSD's.=20

> ceph health gives a message like this=20
>=20
> HEALTH_WARN osdmonitor: num_osds =3D 6, num_up_osds =3D 4, num_in_osd=
s =3D 4 Some PGs are: degraded,peering=20
>=20
> now osd.1 is dead all the other are running=20
>=20
> How do I get the running one up and in ? and how do I know which ods =
it is ?=20
>=20

$ ceph osd dump -o -=20

That should tell you which OSD is down/out.=20

> how do I recover the dead one ?=20
>=20

Normally starting the OSD would be enough. Look closely though, you=20
might have hit a bug which caused the OSD to crash. If so, there should=
=20
be a file called "core" in / which has a core-dump and could tell why=20
the OSD crashed:=20

$ gdb /usr/bin/cosd /core=20

Make sure you have the debug symbols (-dbg packages) installed when=20
doing so.=20

If you monitor 'ceph -w' then, you should see the cluster recover and=20
all OSD's should be up & in.=20

Wido=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
