From: chandrashekhar <chandubigc@gmail.com>
Subject: Re: OSD per disk.
Date: Mon, 28 May 2012 09:25:36 +0000 (UTC)
Message-ID: <loom.20120528T111434-469@post.gmane.org>
References: <loom.20120528T080903-621@post.gmane.org> <1c048abb-0cbb-4d69-9922-419c16019887@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50242 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2E1JZs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 May 2012 05:25:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SYwCv-0003IP-Us
	for ceph-devel@vger.kernel.org; Mon, 28 May 2012 11:25:46 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 11:25:45 +0200
Received: from chandubigc by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 11:25:45 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Alexandre DERUMIER <aderumier <at> odiso.com> writes:

>=20
> Hi, just defined osds in ceph.conf, they mount each disk in correct m=
ountpoint.
>=20
> this example :=20
> 1st server :
>   /dev/sdb1 -> /data/osd0
>   /dev/sdc1 -> /data/osd1
>   /dev/sdd1 -> /data/osd2
>   ....
> same for journal.(you can use differents disk for journal or use anot=
her
partition on same disk)
>=20
> ceph.conf
> [osd]=20
>=20
> osd data =3D /data/osd$id=20
> osd journal =3D /data/osd$id/journal=20
> osd journal size =3D 512=20
>=20
> [osd.0]=20
> host =3D ceph-node-1=20
>=20
> [osd.1]=20
> host =3D ceph-node-1=20
>=20
> [osd.2]=20
> host =3D ceph-node-1=20
>=20
> [osd.3]=20
> host =3D ceph-node-2=20
>=20
> [osd.4]=20
> host =3D ceph-node-2=20
>=20
> ----- Mail original -----=20
>=20
> De: "chandrashekhar" <chandubigc <at> gmail.com>=20
> =C3=80: ceph-devel <at> vger.kernel.org=20
> Envoy=C3=A9: Lundi 28 Mai 2012 08:19:17=20
> Objet: OSD per disk.=20
>=20
> Hi,=20
>=20
> I want to setup a ceph cluster with 4 osds ( one OSD per disk), 2 mon=
s, 1=20
> mds. Please help me to configure this.=20
>=20
> I have a machine with following hardware:=20
>=20
> 4 hard disks ( each 500GB).=20
>=20
> /dev/sda - 500G ( OS )=20
> /dev/sdb - 500G=20
> /dev/sdc - 500G=20
> /dev/sdd - 500G=20
>=20
> OS: ubuntu 12.O4 server ( 64 bit )=20
>=20
> Thanks,=20
> Chandra.=20
>=20

Thanks Alexandre,  I created four directories in /data  (osd0,osd1,osd2=
,osd3)=20
and mounted as below:

/dev/sdb1 -> /data/osd1
/dev/sdc1 -> /data/osd2
/dev/sdd1 -> /data/osd3


But when I start ceph its starting mons and md daemons but not osds. Pl=
ease help
me to get this working.

>ceph -w
2012-05-28 14:43:23.756895    pg v2: 792 pgs: 792 creating; 0 bytes dat=
a, 0 KB
used, 0 KB / 0 KB avail
2012-05-28 14:43:23.762160   mds e1: 0/0/1 up
2012-05-28 14:43:23.762296   osd e1: 0 osds: 0 up, 0 in
2012-05-28 14:43:23.762586   log 2012-05-28 14:24:15.391671 mon.0
192.168.7.10:6789/0 4 : [INF] mon.a@0 won leader election with quorum 0=
,1
2012-05-28 14:43:23.762741   mon e1: 2 mons at
{a=3D192.168.7.10:6789/0,b=3D192.168.7.10:6790/0}




Here is my ceph.conf:
-------------------------------------------------
[global]
   auth supported =3D cephx
   keyring =3D /etc/ceph/keyring.admin

[mon]
   mon data =3D /data/mon.$id

[mds]

[osd]
   osd data =3D /data/osd$id
   osd journal =3D /data/osd$id/osd.$id.journal
   osd journal size =3D 1000



[mon.a]
   host =3D testnode
   mon addr =3D 192.168.7.10:6789
[mon.b]
  host =3D testnode
  mon addr =3D 192.168.7.10:6790

[osd.0]
   host =3D testnode

[osd.1]
   host =3D testnode

[osd.2]
   host =3D testnode

[osd.3]
   host =3D testnode
[mds.a]
   host =3D testnode




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
