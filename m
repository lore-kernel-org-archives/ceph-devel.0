From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: Disk allocation
Date: Mon, 21 Mar 2011 22:24:28 +0100 (CET)
Message-ID: <780926689.12925.1300742668677.JavaMail.root@mail.linserv.se>
References: <277330787.12923.1300742455040.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:42186 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab1CUVbA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 17:31:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id DFFE5E800F
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 22:24:29 +0100 (CET)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuGwEohnbcMu for <ceph-devel@vger.kernel.org>;
	Mon, 21 Mar 2011 22:24:28 +0100 (CET)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id B8D1C12002E
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 22:24:28 +0100 (CET)
In-Reply-To: <277330787.12923.1300742455040.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One was removed the other one is still there. When ls the snapshot it s=
toped working. Now I get can't read superblock while trying to mount th=
e ceph file system. I have restarted all servers.

But it looked like one snapshot was not correctly removed.

ceph helth is reporting
2011-03-21 22:13:53.581270 7fa2db738720 -- :/1813 messenger.start
2011-03-21 22:13:53.582765 7fa2db738720 -- :/1813 --> mon0 10.0.6.10:67=
89/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x11b04c0
2011-03-21 22:13:53.583276 7fa2db737700 -- 10.0.6.11:0/1813 learned my =
addr 10.0.6.11:0/1813
2011-03-21 22:13:53.586034 7fa2d90c1700 -- 10.0.6.11:0/1813 <=3D=3D mon=
0 10.0.6.10:6789/0 1 =3D=3D=3D=3D auth_reply(proto 1 0 Success) v1 =3D=3D=
=3D=3D 24+0+0 (3548204067 0 0) 0x11b04c0 con 0x11b2280
2011-03-21 22:13:53.586077 7fa2d90c1700 -- 10.0.6.11:0/1813 --> mon0 10=
=2E0.6.10:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x11b25d0
2011-03-21 22:13:53.586490 7fa2d90c1700 -- 10.0.6.11:0/1813 <=3D=3D mon=
0 10.0.6.10:6789/0 2 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0+0 (4038=
329719 0 0) 0x11b04c0 con 0x11b2280
2011-03-21 22:13:53.586563 7fa2d90c1700 -- 10.0.6.11:0/1813 <=3D=3D mon=
0 10.0.6.10:6789/0 3 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D=
 20+0+0 (3131629013 0 0) 0x11b25d0 con 0x11b2280
2011-03-21 22:13:53.586558 mon <- [health]
2011-03-21 22:13:53.586626 7fa2db738720 -- 10.0.6.11:0/1813 --> mon0 10=
=2E0.6.10:6789/0 -- mon_command(health v 0) v1 -- ?+0 0x11b04c0
2011-03-21 22:13:53.587216 7fa2d90c1700 -- 10.0.6.11:0/1813 <=3D=3D mon=
0 10.0.6.10:6789/0 4 =3D=3D=3D=3D mon_command_ack([health]=3D0 HEALTH_W=
ARN osdmonitor: num_osds =3D 4, num_up_osds =3D 2, num_in_osds =3D 4 So=
me PGs are: crashed,down,degraded,peering v1) v1 =3D=3D=3D=3D 154+0+0 (=
2262019121 0 0) 0x11b04c0 con 0x11b2280
2011-03-21 22:13:53.587244 mon0 -> 'HEALTH_WARN osdmonitor: num_osds =3D=
 4, num_up_osds =3D 2, num_in_osds =3D 4 Some PGs are: crashed,down,deg=
raded,peering' (0)
2011-03-21 22:13:53.587421 7fa2db738720 -- 10.0.6.11:0/1813 shutdown co=
mplete.

the ods3 is not reducing any more data 24 G is still left. Not sure wha=
t logs you would like to see ?.

I could try to create the problem again.
I have been creating big files using dd if=3D/dev/zero of=3Dtest.iso bs=
=3D1024k count=3D10k ( 10GB ). This has created heavy load on the osd d=
aemons in my system.
I have also coped some other bis iso images. I have removed and added f=
iles like this.

The snapshot was just some textfiles to play with the snaphost function=
ality.

I have been using ceph 0.25 and 0.25.1 on a debian 6.0 system. The file=
system is mounted on an opensuse server 11.3, Linux linxen1 2.6.34.7-0.=
7-xen.

-Martin

Unfortunately we haven't developed our fsck tools yet, although they ar=
e coming. However, we'd like to work out what happened to break your cl=
uster so that we can fix it!=20
Do you have any remaining logs from when your OSDs crashed? Have you co=
nfirmed that the snapshots are gone? Are the OSDs continuing to reduce =
their data used numbers?=20
-Greg=20
On Monday, March 21, 2011 at 12:51 PM, Martin Wilderoth wrote:=20
> The disks are on seperate partition and I'm using the btrfs file syst=
em.=20
> They are mounted under /data/osd0 osd1.....=20
>=20
> I remove the snapshots and the the system was reporting HEALTH WARNIN=
G.=20
> two of the osd went down=20
>=20
> ceph ods stat reports:=20
> 2011-03-21 19:14:00.122945 7f8c1d83e720 -- :/26712 messenger.start=20
> 2011-03-21 19:14:00.123344 7f8c1d83e720 -- :/26712 --> mon0 10.0.6.10=
:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x242d4c0=20
> 2011-03-21 19:14:00.123701 7f8c1d83d700 -- 10.0.6.10:0/26712 learned =
my addr 10.0.6.10:0/26712=20
> 2011-03-21 19:14:00.124305 7f8c1b1c7700 -- 10.0.6.10:0/26712 <=3D=3D =
mon0 10.0.6.10:6789/0 1 =3D=3D=3D=3D auth_reply(proto 1 0 Success) v1 =3D=
=3D=3D=3D 24+0+0 (709083268 0 0) 0x242d4c0 con 0x242f280=20
> 2011-03-21 19:14:00.124349 7f8c1b1c7700 -- 10.0.6.10:0/26712 --> mon0=
 10.0.6.10:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x242f5d0=20
> 2011-03-21 19:14:00.124667 7f8c1b1c7700 -- 10.0.6.10:0/26712 <=3D=3D =
mon0 10.0.6.10:6789/0 2 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0+0 (4=
038329719 0 0) 0x242d4c0 con 0x242f280=20
> 2011-03-21 19:14:00.124746 7f8c1b1c7700 -- 10.0.6.10:0/26712 <=3D=3D =
mon0 10.0.6.10:6789/0 3 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=
=3D 20+0+0 (3131629013 0 0) 0x242f5d0 con 0x242f280=20
> 2011-03-21 19:14:00.124744 mon <- [osd,stat]=20
> 2011-03-21 19:14:00.124824 7f8c1d83e720 -- 10.0.6.10:0/26712 --> mon0=
 10.0.6.10:6789/0 -- mon_command(osd stat v 0) v1 -- ?+0 0x242d4c0=20
> 2011-03-21 19:14:00.125131 7f8c1b1c7700 -- 10.0.6.10:0/26712 <=3D=3D =
mon0 10.0.6.10:6789/0 4 =3D=3D=3D=3D mon_command_ack([osd,stat]=3D0 e42=
6: 4 osds: 2 up, 2 in v426) v1 =3D=3D=3D=3D 69+0+0 (3071290324 0 0) 0x2=
42d4c0 con 0x242f280=20
> 2011-03-21 19:14:00.125155 mon0 -> 'e426: 4 osds: 2 up, 2 in' (0)=20
> 2011-03-21 19:14:00.125559 7f8c1d83e720 -- 10.0.6.10:0/26712 shutdown=
 complete.=20
>=20
> I restarted the cluser and it seemd ok again. The data is accessable.=
=20
> Now ods2 has also cleared some data.=20
>=20
> osd0 1.1GB=20
> osd1 1.1GB=20
> osd2 1.2GB=20
> osd3 24GB=20
>=20
> But du is reporting 110MB on the mounted filesystem.=20
>=20
> Is there a way to recover as it seems as if something is corupt in my=
 system.=20
> It also seems as some of my ods has difficulties to stay up, not sure=
 what I have done wrong.=20
> Maybe the best is to restart with a new file system :-)=20
>=20
> ----- Ursprungligt meddelande -----=20
> Fr=C3=A5n: "Ben De Luca" <bdeluca@gmail.com>=20
> Till: "Gregory Farnum" <gregory.farnum@dreamhost.com>=20
> Kopia: "Martin Wilderoth" <martin.wilderoth@linserv.se>, ceph-devel@v=
ger.kernel.org=20
> Skickat: m=C3=A5ndag, 21 mar 2011 18:32:46=20
> =C3=84mne: Re: Disk allocation=20
>=20
> Sorry to jump into the converstation, how slow can the deletion of=20
> files actually be?=20
>=20
> One of the tests I ran a few weeks ago had me generating files,=20
> deleting them and then writing them again from a number of clients. I=
=20
> noticed that the space would never freed up again. I have my OSD's an=
d=20
> their journals on dedicated partions.=20
>=20
> I had planned on asking more on this once I had a stable system again=
=2E=20
>=20
>=20
>=20
> On Mon, Mar 21, 2011 at 3:17 PM, Gregory Farnum=20
> <gregory.farnum@dreamhost.com> wrote:=20
> > On Sat, Mar 19, 2011 at 11:43 PM, Martin Wilderoth=20
> > <martin.wilderoth@linserv.se> wrote:=20
> > > I have a small ceph cluster with 4 osd ( 2 disks on 2 hosts).=20
> > >=20
> > > I have been adding and removing files from the file system, mount=
ed as ceph on an other host.=20
> > >=20
> > > Now I have removed most of the data on the file system, so I only=
 have 300 MB left plus two snapshots.=20
> > >=20
> > > The problem is that looking at the disks the are allocating 88G o=
f data=20
> > > on the ceph filesystem.=20
> > There are a few possibilities:=20
> > 1) You've hosted your OSDs on a partition that's shared with the re=
st=20
> > of the computer. In that case the reported used space will include=20
> > whatever else is on the partition, not just the Ceph files. (This c=
an=20
> > include Ceph debug logs, so even if nothing used to be there but yo=
u=20
> > were logging on that partition that can build up pretty quickly.)=20
> > 2) You deleted the files quickly and just haven't given enough time=
=20
> > for the file deletion to propagate to the OSDs. Because the POSIX=20
> > filesystem is layered over an object store, this can take some time=
=2E=20
> > 3) Your snapshots contain a lot of files, so nothing (or very littl=
e)=20
> > actually got deleted. Snapshots are pretty cool but they aren't=20
> > miraculous disk space!=20
> > Given the uneven distribution of disk space I suspect option #2, bu=
t I=20
> > could be mistaken. :) Let us know!=20
> > -Greg=20
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
> > the body of a message to majordomo@vger.kernel.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
