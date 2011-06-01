From: biyan chen <riby.chen@gmail.com>
Subject: Re: I can't ceph file system in writing on file
Date: Wed, 1 Jun 2011 15:19:32 +0800
Message-ID: <BANLkTikho0M2BS3SztA=BN5i3gY=yBq0-A@mail.gmail.com>
References: <BANLkTik4K1we2z85ob-2Bmx1zNETkTj5Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41746 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab1FAHTd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 03:19:33 -0400
Received: by yxs7 with SMTP id 7so2101053yxs.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 00:19:32 -0700 (PDT)
In-Reply-To: <BANLkTik4K1we2z85ob-2Bmx1zNETkTj5Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2011-06-01 15:20:23.258669 7fee67a8c710 -- 192.168.0.211:6789/0 <=3D=3D
mds0 192.168.0.207:6800/7272 193 =3D=3D=3D=3D mdsbeacon(4297/alpha up:a=
ctive
seq 180 v14) v2 =3D=3D=3D=3D 244+0+0 (3951961624 0 0) 0x8e1a00 con 0x8e=
fb40
2011-06-01 15:20:23.258706 7fee67a8c710 mon.0@0(leader) e1 have connect=
ion
2011-06-01 15:20:23.258720 7fee67a8c710 mon.0@0(leader) e1 ms_dispatch
existing session MonSession: mds? 192.168.0.207:6800/7272 is openallow
rwx for mds? 192.168.0.207:6800/7272
2011-06-01 15:20:23.258728 7fee67a8c710 mon.0@0(leader) e1  caps allow =
rwx
2011-06-01 15:20:23.258748 7fee67a8c710
mon.0@0(leader).paxosservice(mdsmap) dispatch mdsbeacon(4297/alpha
up:active seq 180 v14) v2 from mds0 192.168.0.207:6800/7272
2011-06-01 15:20:23.258763 7fee67a8c710 mon.0@0(leader).paxos(mdsmap
active lc 14) is_readable now=3D2011-06-01 15:20:23.258758
lease_expire=3D0.000000 has v14 lc 14
2011-06-01 15:20:23.258777 7fee67a8c710 mon.0@0(leader).mds e14
preprocess_query mdsbeacon(4297/alpha up:active seq 180 v14) v2 from
mds0 192.168.0.207:6800/7272
2011-06-01 15:20:23.258792 7fee67a8c710 mon.0@0(leader).mds e14
preprocess_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 from
mds0 192.168.0.207:6800/7272 compat=3D{},rocompat=3D{},incompat=3D{1=3D=
base
v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=3D=
dir
inode in separate object}
2011-06-01 15:20:23.258806 7fee67a8c710 mon.0@0(leader).mds e14
_note_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 noting
time
2011-06-01 15:20:23.258821 7fee67a8c710 -- 192.168.0.211:6789/0 -->
192.168.0.207:6800/7272 -- mdsbeacon(4297/alpha up:active seq 180 v14)
v1 -- ?+0 0x9b4c80 con 0x8efb40
^C

[root@ceph_mon0 ceph]# tail /var/log/ceph/mon.0.log -f
Display the above information =A3=A1

Thanks!

2011/6/1 biyan chen <riby.chen@gmail.com>:
> When I mount ceph after the file system. I want to go to create a
> file, but hint permissions problem, cannot write
>
> In /var/log/ceph log information inside, didn't see more information
>
> [root@ceph_client /]# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda1            472658192  20199408 428449108   5% /
> tmpfs                  1984548         0   1984548   0% /dev/shm
> /dev/loop0             3351190   3351190         0 100% /mnt/cdrom
> 192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
> [root@ceph_client /]# cd /1
> [root@ceph_client 1]# echo "1">>1.txt
> -bash: 1.txt: Permission denied
> [root@ceph_client 1]# cd ..
> [root@ceph_client /]# ll
> total 112
> drwxr-xr-x.  1 root root     0 Jun  1 20:05 1
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
