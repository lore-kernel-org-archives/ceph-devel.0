From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: I can't ceph file system in writing on file
Date: Wed, 1 Jun 2011 15:48:27 +0000
Message-ID: <1306943307.1527.23.camel@localhost>
References: <BANLkTik4K1we2z85ob-2Bmx1zNETkTj5Jw@mail.gmail.com>
	 <BANLkTikho0M2BS3SztA=BN5i3gY=yBq0-A@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:24467 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933031Ab1FAHsP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 03:48:15 -0400
In-Reply-To: <BANLkTikho0M2BS3SztA=BN5i3gY=yBq0-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

Are the other write commands also printf "Permission denied" ?

Could you try to run:

dd if=3D/dev/zero of=3D/1/512M bs=3D1M count=3D512=20

If you detect a bug ,you can file it at

http://tracker.newdream.net

Jeff ,Wu


On Wed, 2011-06-01 at 15:19 +0800, biyan chen wrote:
> 2011-06-01 15:20:23.258669 7fee67a8c710 -- 192.168.0.211:6789/0 <=3D=3D
> mds0 192.168.0.207:6800/7272 193 =3D=3D=3D=3D mdsbeacon(4297/alpha up=
:active
> seq 180 v14) v2 =3D=3D=3D=3D 244+0+0 (3951961624 0 0) 0x8e1a00 con 0x=
8efb40
> 2011-06-01 15:20:23.258706 7fee67a8c710 mon.0@0(leader) e1 have conne=
ction
> 2011-06-01 15:20:23.258720 7fee67a8c710 mon.0@0(leader) e1 ms_dispatc=
h
> existing session MonSession: mds? 192.168.0.207:6800/7272 is openallo=
w
> rwx for mds? 192.168.0.207:6800/7272
> 2011-06-01 15:20:23.258728 7fee67a8c710 mon.0@0(leader) e1  caps allo=
w rwx
> 2011-06-01 15:20:23.258748 7fee67a8c710
> mon.0@0(leader).paxosservice(mdsmap) dispatch mdsbeacon(4297/alpha
> up:active seq 180 v14) v2 from mds0 192.168.0.207:6800/7272
> 2011-06-01 15:20:23.258763 7fee67a8c710 mon.0@0(leader).paxos(mdsmap
> active lc 14) is_readable now=3D2011-06-01 15:20:23.258758
> lease_expire=3D0.000000 has v14 lc 14
> 2011-06-01 15:20:23.258777 7fee67a8c710 mon.0@0(leader).mds e14
> preprocess_query mdsbeacon(4297/alpha up:active seq 180 v14) v2 from
> mds0 192.168.0.207:6800/7272
> 2011-06-01 15:20:23.258792 7fee67a8c710 mon.0@0(leader).mds e14
> preprocess_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 from
> mds0 192.168.0.207:6800/7272 compat=3D{},rocompat=3D{},incompat=3D{1=3D=
base
> v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=3D=
dir
> inode in separate object}
> 2011-06-01 15:20:23.258806 7fee67a8c710 mon.0@0(leader).mds e14
> _note_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 noting
> time
> 2011-06-01 15:20:23.258821 7fee67a8c710 -- 192.168.0.211:6789/0 -->
> 192.168.0.207:6800/7272 -- mdsbeacon(4297/alpha up:active seq 180 v14=
)
> v1 -- ?+0 0x9b4c80 con 0x8efb40
> ^C
>=20
> [root@ceph_mon0 ceph]# tail /var/log/ceph/mon.0.log -f
> Display the above information =EF=BC=81
>=20
> Thanks!
>=20
> 2011/6/1 biyan chen <riby.chen@gmail.com>:
> > When I mount ceph after the file system. I want to go to create a
> > file, but hint permissions problem, cannot write
> >
> > In /var/log/ceph log information inside, didn't see more informatio=
n
> >
> > [root@ceph_client /]# df
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > /dev/sda1            472658192  20199408 428449108   5% /
> > tmpfs                  1984548         0   1984548   0% /dev/shm
> > /dev/loop0             3351190   3351190         0 100% /mnt/cdrom
> > 192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
> > [root@ceph_client /]# cd /1
> > [root@ceph_client 1]# echo "1">>1.txt
> > -bash: 1.txt: Permission denied
> > [root@ceph_client 1]# cd ..
> > [root@ceph_client /]# ll
> > total 112
> > drwxr-xr-x.  1 root root     0 Jun  1 20:05 1
> >
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
