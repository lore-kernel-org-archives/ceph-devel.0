From: Sage Weil <sage@newdream.net>
Subject: Re: Multiple disks per server.
Date: Tue, 4 May 2010 10:37:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005040947230.11433@cobra.newdream.net>
References: <4BE01091.7040103@embl.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-385837958-1272994626=:11433"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51445 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757792Ab0EDReU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 May 2010 13:34:20 -0400
In-Reply-To: <4BE01091.7040103@embl.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-385837958-1272994626=:11433
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 4 May 2010, Micka=EBl Can=E9vet wrote:
> As there is more then one disk per server available for data (2 with 6 di=
sks
> and 2 with 10 disks for a total of 32 disks over 4 nodes), I was wonderin=
g how
> to define OSDs.
>=20
> I have choice between one OSD per disk (32 OSDs on the cluster) or one OS=
D per
> server with one btrfs filesystem over all disks of the server (4 OSDs on =
the
> cluster). Which one is the best solution ?
>=20
> In the first case, if I lose one disk, I lose only a small part of availa=
ble
> space. In the other case, if I lose one disk, I lose the whole server (as
> btrfs filesystem is in stripping) much more space.
>=20
> On the other hand, if I lose the whole server in the first case, I can lo=
se
> all replicates of a data because they may be on two different OSD on the =
same
> server.

Right.  You can make btrfs do some replication (e.g. 2x metadata, 1x data)=
=20
to mitigate the risk somewhat, but it'll use more disk space.  raid[56]=20
in btrfs is still a ways off.

> Is there a way to define OSD groups so that we can be sure that 2 replica=
tes
> are not on OSDs of the same group (could be usefull for multiple OSDs per
> server, but also mutliple server per computing room - if I lose one whole
> room, a lot of server, I will be sure that I have not lost every replicat=
es).

This is probably the best route.  The process isn't streamlined, however. =
=20
It involves constructing an appropriate CRUSH rule that includes a=20
hierarchy of disks and hosts, and distributes replicas across hosts. =20

I threw together a wiki article at

=09http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH

Please let me know if you have questions or run into problems.

sage
--557981400-385837958-1272994626=:11433--
