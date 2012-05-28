From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: OSD per disk.
Date: Mon, 28 May 2012 11:34:32 +0200 (CEST)
Message-ID: <7b7fb8cc-28f2-4504-80a8-67678f70aa7d@mailpro>
References: <loom.20120528T111434-469@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38135 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2E1Jey convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 05:34:54 -0400
In-Reply-To: <loom.20120528T111434-469@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chandrashekhar <chandubigc@gmail.com>
Cc: ceph-devel@vger.kernel.org

maybe try=20

[osd.0]=20
host =3D testnode=20
osd data =3D /data/osd0=20
osd journal =3D /data/osd0/osd0journal=20
osd journal size =3D 1000=20

[osd.1]=20
host =3D testnode=20
osd data =3D /data/osd1=20
osd journal =3D /data/osd1/osd1journal=20
osd journal size =3D 1000=20
[osd.2]=20
host =3D testnode=20
osd data =3D /data/osd2=20
osd journal =3D /data/osd2/osd2journal=20
osd journal size =3D 1000=20
[osd.3]=20
host =3D testnode=20
osd data =3D /data/osd3=20
osd journal =3D /data/osd3/osd3journal=20
osd journal size =3D 1000=20



you can start osd with

/etc/init.d/ceph start osd0
/etc/init.d/ceph start osd1
/etc/init.d/ceph start osd2
/etc/init.d/ceph start osd3

----- Mail original -----=20

De: "chandrashekhar" <chandubigc@gmail.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 28 Mai 2012 11:25:36=20
Objet: Re: OSD per disk.=20


Alexandre DERUMIER <aderumier <at> odiso.com> writes:=20

>=20
> Hi, just defined osds in ceph.conf, they mount each disk in correct m=
ountpoint.=20
>=20
> this example :=20
> 1st server :=20
> /dev/sdb1 -> /data/osd0=20
> /dev/sdc1 -> /data/osd1=20
> /dev/sdd1 -> /data/osd2=20
> ....=20
> same for journal.(you can use differents disk for journal or use anot=
her=20
partition on same disk)=20
>=20
> ceph.conf=20
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

Thanks Alexandre, I created four directories in /data (osd0,osd1,osd2,o=
sd3)=20
and mounted as below:=20

/dev/sdb1 -> /data/osd1=20
/dev/sdc1 -> /data/osd2=20
/dev/sdd1 -> /data/osd3=20


But when I start ceph its starting mons and md daemons but not osds. Pl=
ease help=20
me to get this working.=20

>ceph -w=20
2012-05-28 14:43:23.756895 pg v2: 792 pgs: 792 creating; 0 bytes data, =
0 KB=20
used, 0 KB / 0 KB avail=20
2012-05-28 14:43:23.762160 mds e1: 0/0/1 up=20
2012-05-28 14:43:23.762296 osd e1: 0 osds: 0 up, 0 in=20
2012-05-28 14:43:23.762586 log 2012-05-28 14:24:15.391671 mon.0=20
192.168.7.10:6789/0 4 : [INF] mon.a@0 won leader election with quorum 0=
,1=20
2012-05-28 14:43:23.762741 mon e1: 2 mons at=20
{a=3D192.168.7.10:6789/0,b=3D192.168.7.10:6790/0}=20




Here is my ceph.conf:=20
-------------------------------------------------=20
[global]=20
auth supported =3D cephx=20
keyring =3D /etc/ceph/keyring.admin=20

[mon]=20
mon data =3D /data/mon.$id=20

[mds]=20

[osd]=20
osd data =3D /data/osd$id=20
osd journal =3D /data/osd$id/osd.$id.journal=20
osd journal size =3D 1000=20



[mon.a]=20
host =3D testnode=20
mon addr =3D 192.168.7.10:6789=20
[mon.b]=20
host =3D testnode=20
mon addr =3D 192.168.7.10:6790=20

[osd.0]=20
host =3D testnode=20

[osd.1]=20
host =3D testnode=20

[osd.2]=20
host =3D testnode=20

[osd.3]=20
host =3D testnode=20
[mds.a]=20
host =3D testnode=20




--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
