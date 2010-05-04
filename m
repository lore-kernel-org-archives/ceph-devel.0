From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Multiple disks per server.
Date: Tue, 04 May 2010 14:34:26 +0200
Message-ID: <1272976466.1935.13.camel@wido-desktop>
References: <4BE01091.7040103@embl.fr>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:44589 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0EDMe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 May 2010 08:34:29 -0400
In-Reply-To: <4BE01091.7040103@embl.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Cc: ceph-devel@vger.kernel.org

Hi Micka=C3=ABl,

I was wondering the same.

When i was reading the Wiki, i found:
http://ceph.newdream.net/wiki/Librados

"Each pool also has a few parameters that define how the object is
stored, namely a replication level (2x, 3x, etc.) and a mapping rule
describing how replicas should be distributed across the storage cluste=
r
(e.g., each replica in a separate rack)."

So there should be a possibility, but i haven't found any configuration
references.

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


On Tue, 2010-05-04 at 12:18 +0000, Micka=C3=ABl Can=C3=A9vet wrote:
> Hi,
>=20
> I'm testing ceph on 4 old servers.
>=20
> As there is more then one disk per server available for data (2 with =
6=20
> disks and 2 with 10 disks for a total of 32 disks over 4 nodes), I wa=
s=20
> wondering how to define OSDs.
>=20
> I have choice between one OSD per disk (32 OSDs on the cluster) or on=
e=20
> OSD per server with one btrfs filesystem over all disks of the server=
 (4=20
> OSDs on the cluster). Which one is the best solution ?
>=20
> In the first case, if I lose one disk, I lose only a small part of=20
> available space. In the other case, if I lose one disk, I lose the wh=
ole=20
> server (as btrfs filesystem is in stripping) much more space.
>=20
> On the other hand, if I lose the whole server in the first case, I ca=
n=20
> lose all replicates of a data because they may be on two different OS=
D=20
> on the same server.
>=20
> Is there a way to define OSD groups so that we can be sure that 2=20
> replicates are not on OSDs of the same group (could be usefull for=20
> multiple OSDs per server, but also mutliple server per computing room=
 -=20
> if I lose one whole room, a lot of server, I will be sure that I have=
=20
> not lost every replicates).
>=20
> Thanks a lot.
> Micka=C3=ABl
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
