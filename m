From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: OSD per disk.
Date: Mon, 28 May 2012 08:37:55 +0200 (CEST)
Message-ID: <1c048abb-0cbb-4d69-9922-419c16019887@mailpro>
References: <loom.20120528T080903-621@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44707 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2E1GiS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 02:38:18 -0400
In-Reply-To: <loom.20120528T080903-621@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chandrashekhar <chandubigc@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi, just defined osds in ceph.conf, they mount each disk in correct mou=
ntpoint.

this example :=20
1st server :
  /dev/sdb1 -> /data/osd0
  /dev/sdc1 -> /data/osd1
  /dev/sdd1 -> /data/osd2
  ....
same for journal.(you can use differents disk for journal or use anothe=
r partition on same disk)



ceph.conf
[osd]=20

osd data =3D /data/osd$id=20
osd journal =3D /data/osd$id/journal=20
osd journal size =3D 512=20

[osd.0]=20
host =3D ceph-node-1=20


[osd.1]=20
host =3D ceph-node-1=20


[osd.2]=20
host =3D ceph-node-1=20



[osd.3]=20
host =3D ceph-node-2=20


[osd.4]=20
host =3D ceph-node-2=20


----- Mail original -----=20

De: "chandrashekhar" <chandubigc@gmail.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 28 Mai 2012 08:19:17=20
Objet: OSD per disk.=20

Hi,=20

I want to setup a ceph cluster with 4 osds ( one OSD per disk), 2 mons,=
 1=20
mds. Please help me to configure this.=20

I have a machine with following hardware:=20

4 hard disks ( each 500GB).=20

/dev/sda - 500G ( OS )=20
/dev/sdb - 500G=20
/dev/sdc - 500G=20
/dev/sdd - 500G=20


OS: ubuntu 12.O4 server ( 64 bit )=20




Thanks,=20
Chandra.=20

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
