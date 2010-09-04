From: "FWDF" <fwdflywl@gmail.com>
Subject: some questions about ceph deployment
Date: Sat, 4 Sep 2010 21:45:27 +0800
Message-ID: <000d01cb4c37$71fadf90$55f09eb0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37983 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab0IDNpn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Sep 2010 09:45:43 -0400
Received: by pvg2 with SMTP id 2so875503pvg.19
        for <ceph-devel@vger.kernel.org>; Sat, 04 Sep 2010 06:45:42 -0700 (PDT)
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

=E3=80=80=E3=80=80We use 3 servers to build a test system of ceph, conf=
igured as below:
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Host                          IP     =20
=E3=80=80=E3=80=80client01            192.168.1.10  =20
=E3=80=80=E3=80=80ceph01              192.168.2.50
=E3=80=80=E3=80=80ceph02              192.168.2.51  =20
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80The OS is unbuntu 10.04 LTS and the version of ceph i=
s v0.21.1
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80ceph.conf:
=E3=80=80=E3=80=80[global]
=E3=80=80=E3=80=80        auth supported =3D cephx
=E3=80=80=E3=80=80        pid file =3D /var/run/ceph/$name.pid
=E3=80=80=E3=80=80        debug ms =3D 0
=E3=80=80=E3=80=80        keyring =3D /etc/ceph/keyring.bin
=E3=80=80=E3=80=80 [mon]
=E3=80=80=E3=80=80        mon data =3D /mnt/ceph/data/mon$id
=E3=80=80=E3=80=80        debug ms =3D 1
=E3=80=80=E3=80=80[mon0]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80        mon addr =3D 192.168.2.50:6789
=E3=80=80=E3=80=80 [mds]
=E3=80=80=E3=80=80        keyring =3D /etc/ceph/keyring.$name
debug ms =3D 1
=E3=80=80=E3=80=80[mds.ceph01]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80[mds.ceph02]
=E3=80=80=E3=80=80        host =3D ceph02
=E3=80=80=E3=80=80[osd]
=E3=80=80=E3=80=80        sudo =3D true
=E3=80=80=E3=80=80        osd data =3D /mnt/ceph/osd$id/data
=E3=80=80=E3=80=80        keyring =3D /etc/ceph/keyring.$name
=E3=80=80=E3=80=80        osd journal =3D /mnt/ceph/osd$id/data/journal
=E3=80=80=E3=80=80        osd journal size =3D 100
=E3=80=80=E3=80=80[osd0]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80[osd1]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80[osd2]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80[osd3]
=E3=80=80=E3=80=80        host =3D ceph01
=E3=80=80=E3=80=80[osd10]
=E3=80=80=E3=80=80        host =3D ceph02
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80There are 4 HDDs in the ceph01 and every HDD has a OS=
D named as osd0, osd1, osd2,osd3; there is 1 HDD in the ceph02 named as=
 osd10. All these HDDs are made as btrfs and mounted on the mount point=
 as listed below:
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80ceph01
=E3=80=80=E3=80=80         /dev/sdc1         /mnt/ceph/osd0/data       =
        btrfs
=E3=80=80=E3=80=80         /dev/sdd1         /mnt/ceph/osd1/data       =
        btrfs
=E3=80=80=E3=80=80         /dev/sde1         /mnt/ceph/osd2/data       =
        btrfs
=E3=80=80=E3=80=80         /dev/sdf1          /mnt/ceph/osd3/data      =
         btrfs
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80ceph02
=E3=80=80=E3=80=80         /dev/sdb1         /mnt.ceph/osd10/data      =
       btrfs
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Make ceph FileSystem:
=E3=80=80=E3=80=80root@ceph01:~#  mkcephfs  -c /etc/cepf/ceph.conf -a -=
k /etc/ceph/keyring.bin
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Startup ceph:
=E3=80=80=E3=80=80root@ceph01:~#  /etc/init.d/ceph =E2=80=93a  start

         Then
=E3=80=80=E3=80=80root@ceph01:~#  ceph -w
=E3=80=80=E3=80=8010.09.01_17:56:19.337895   mds e17: 1/1/1 up {0=3Dup:=
active}, 1 up:standby
=E3=80=80=E3=80=8010.09.01_17:56:19.347184   osd e27: 5 osds: 5 up, 5 i=
n
=E3=80=80=E3=80=8010.09.01_17:56:19.349447     log =E2=80=A6=20
=E3=80=80=E3=80=8010.09.01_17:56:19.373773   mon e1: 1 mons at 192.168.=
2.50:6789/0
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80The ceph file system is mounted to client01(192.168.1=
=2E10), ceph01(192.168.2.50), ceph02=EF=BC=88192.168.2.51=EF=BC=89at /d=
ata/ceph. It works fine at the beginning, I can use ls and the write an=
d read of file is ok. After some files are wrote , I find I can=E2=80=99=
t use ls =E2=80=93l /data/ceph until I umount ceph from ceph02, but one=
 day later the same problem occurred again, then I umount ceph from cep=
h01 the system and everything is ok.

=E3=80=80=E3=80=80Q1:
         Can the ceph filesystem be mounted to a member of ceph cluster=
?

         When I follow the instruction of http://ceph.newdream.net/wiki=
/Monitor_cluster_expansion to expand a monitor to ceph02, the following=
 error occurred:
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80root@ceph02:~#  /etc/init.d/ceph start mon1
=E3=80=80=E3=80=80[/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] =
ceph.conf 100%  2565  2.5KB/s  00:00=20
=E3=80=80=E3=80=80=3D=3D=3D mon.1 =3D=3D=3D
=E3=80=80=E3=80=80Starting Ceph mon1 on ceph02...
=E3=80=80=E3=80=80 ** WARNING: Ceph is still under heavy development, a=
nd is only suitable for **
=E3=80=80=E3=80=80 ** testing and review.  Do not trust it with importa=
nt data.  **
=E3=80=80=E3=80=80terminate called after throwing an instance of 'std::=
logic_error'
=E3=80=80=E3=80=80  what():  basic_string::_S_construct NULL not valid
=E3=80=80=E3=80=80Aborted (core dumped)
=E3=80=80=E3=80=80failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.con=
f.14210 '

=E3=80=80=E3=80=80Q2:
=E3=80=80=E3=80=80How to expand a monitor to a running ceph system?
  =20
=E3=80=80=E3=80=80Q3
=E3=80=80=E3=80=80    Is it possible to add mds when the ceph system is=
 running? how?
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80I fdisked a HDD into two partition, one for journal, =
other one for data like this:
=E3=80=80=E3=80=80/dev/sdc1=EF=BC=88180GB=EF=BC=89as data
=E3=80=80=E3=80=80/dev/sdc2=EF=BC=8810GB=EF=BC=89as journal
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80/dev/sdc1 made as btrfs, mount to /mnt/osd0/data
=E3=80=80=E3=80=80/dev/sdc2 made as btrfs, mount to /mnt/osd0/journal
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80ceph.conf:
=E3=80=80=E3=80=80=E2=80=A6
=E3=80=80=E3=80=80[osd]
=E3=80=80=E3=80=80        osd data =3D /mnt/ceph/osd$id/data
=E3=80=80=E3=80=80        osd journal =3D /mnt/ceph/osd$id/journal
=E3=80=80=E3=80=80        ; osd journal size =3D 100
=E3=80=80=E3=80=80=E2=80=A6
=E3=80=80=E3=80=80When I use mkcephfs command, I can't build osd until =
I edited ceph.conf like this:
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80[osd]
=E3=80=80=E3=80=80        osd data =3D /mnt/ceph/osd$id/data
=E3=80=80=E3=80=80        osd journal =3D /mnt/ceph/osd$id/data/journal
=E3=80=80=E3=80=80        osd journal size =3D 100
=E3=80=80=E3=80=80=E2=80=A6
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Q4.
=E3=80=80=E3=80=80  How to set the journal path to a device or patition=
?
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Thanks for all help and reply , sorry for my lame Eng=
lish.
=E3=80=80=E3=80=80
=E3=80=80=E3=80=80Lin


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
