From: Sage Weil <sage@newdream.net>
Subject: Re: client released lease on dn which does not exist
Date: Wed, 28 Jul 2010 09:37:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007280936140.4541@cobra.newdream.net>
References: <AANLkTikmuytto8kwi4fNN1xUtNkAR_cIDPhd65xrLwkZ@mail.gmail.com>
 <AANLkTimMK22DcnrFO7LwSBqQbGkEDKdSzeOF3WSx4Hzj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-326236342-1280335054=:4541"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34411 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab0G1QfE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 12:35:04 -0400
In-Reply-To: <AANLkTimMK22DcnrFO7LwSBqQbGkEDKdSzeOF3WSx4Hzj@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-326236342-1280335054=:4541
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jul 2010, S=E9bastien Paolacci wrote:
> FYI, the same test pass without any warning now (unstable from yesterday)=
=2E

Yeah, sorry I missed this email.  I fixed a few different lease related=20
problems on Monday.  There may still be (rare) cases where that warning=20
comes up which need some additional scrutity, so if you do see it again,=20
please let me know.

Thanks!
sage


 >=20
> Sebastien
>=20
> 2010/7/17 S=E9bastien Paolacci <sebastien.paolacci@gmail.com>:
> > Hello all,
> >
> > I'm getting some warnings that I've not been able to find informations
> > for when running dbench on a newly setup box (nettop, atom dual core
> > 2.5" very low-end hdd). Seems however to be easily reproducible
> > (unstable server and kernel client from yesterday) :
> >
> > srv:# mkcephfs -c ceph.conf --allhosts --mkbtrfs
> > srv:# for srv in cosd cmon cmds; do $srv -c ceph.conf -i 0; done
> >
> > client:# mount -t ceph srv:/ /mnt/
> > client:# dbench -D /mnt/ 1
> >
> > Few seconds later:
> > srv:# ceph -w
> > 10.07.17_18:40:12.797372 =A0 =A0pg v7: 264 pgs: 264 active+clean+degrad=
ed;
> > 69 KB data, 508 KB used, 450 GB / 450 GB avail; 10/20 degraded
> > (50.000%)
> > 10.07.17_18:40:12.800218 =A0 mds e4: 1/1/1 up {0=3Dup:active}
> > 10.07.17_18:40:12.800303 =A0 osd e3: 1 osds: 1 up, 1 in
> > 10.07.17_18:40:12.800448 =A0 log 10.07.17_18:39:56.072957 mon0
> > 192.168.0.3:6789/0 4 : [INF] mds0 192.168.0.3:6802/6754 up:active
> > 10.07.17_18:40:12.800598 =A0 mon e1: 1 mons at 192.168.0.3:6789/0
> > 10.07.17_18:40:14.234588 =A0 =A0pg v8: 264 pgs: 264 active+clean+degrad=
ed;
> > 1166 KB data, 1280 KB used, 450 GB / 450 GB avail; 28/56 degraded
> > (50.000%)
> > 10.07.17_18:40:18.159014 =A0 log 10.07.17_18:40:12.067141 mds0
> > 192.168.0.3:6802/6754 1 : [WRN] client4099 released lease on dn
> > 1000000000c/RESULTS3.PRN which dne
> > 10.07.17_18:40:19.199284 =A0 =A0pg v9: 264 pgs: 264 active+clean+degrad=
ed;
> > 2103 KB data, 2536 KB used, 450 GB / 450 GB avail; 33/66 degraded
> > (50.000%)
> >
> > Does anyone know how "severe" the warning is and what could I
> > undertake to get rid of it?
> >
> > Thanks,
> > Sebastien
> >
> > ps: I can (separately) provide the 90MB mds log file should it be neede=
d.
> >
> > [global]
> > [mon]
> > =A0 =A0 =A0 =A0mon data =3D /data/mon$id
> > [mon0]
> > =A0 =A0 =A0 =A0host =3D srv
> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.3:6789
> > [mds]
> > =A0 =A0 =A0 =A0debug ms =3D 1
> > =A0 =A0 =A0 =A0debug mds =3D 20
> > [mds0]
> > =A0 =A0 =A0 =A0host =3D srv
> > [osd]
> > =A0 =A0 =A0 =A0osd data =3D /data/osd$id
> > =A0 =A0 =A0 =A0osd journal =3D /dev/sda3
> > [osd0]
> > =A0 =A0 =A0 =A0host =3D srv
> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sda4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-326236342-1280335054=:4541--
