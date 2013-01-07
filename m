From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: osd down (for 2 about 2 minutes) error after adding a new host  to my cluster
Date: Mon, 7 Jan 2013 13:00:21 -0800 (PST)
Message-ID: <1357592421.16299.YahooMailNeo@web121902.mail.ne1.yahoo.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com> <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net> <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com> <50B80600.1000304@inktank.com> <1354237947.86472.YahooMailNeo@web121901.mail.ne1.yahoo.com> <1354238575.90788.YahooMailNeo@web121904.mail.ne1.yahoo.com> <1357591756.80653.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm37-vm6.bullet.mail.ne1.yahoo.com ([98.138.229.134]:28071 "EHLO
	nm37-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753974Ab3AGVFx convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jan 2013 16:05:53 -0500
In-Reply-To: <1357591756.80653.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



When i add a new host (with osd's) to my existing cluster, 1 or 2 previ=
ous osd(s) goes down for about 2 minutes and then they=A0 come back up.=
=A0=20


[root@h1ct ~]# ceph osd tree

# id=A0=A0=A0 weight=A0 type name=A0=A0=A0=A0=A0=A0 up/down reweight
-1=A0=A0=A0=A0=A0
3=A0=A0=A0=A0=A0=A0 root default
-3=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rack unkn=
ownrack
-2=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 host h1
0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1
1=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.1=A0=A0 up=A0=A0=A0=A0=A0 1
2=A0=A0=A0=A0=A0=A0
1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 osd.2=A0=A0 up=A0=A0=A0=A0=A0 1


=46or example, after adding host h2 (with 3 new osd) to the above clust=
er and running the "ceph osd tree" command, i see this:=20


[root@h1 ~]# ceph osd tree

# id=A0=A0=A0 weight=A0 type name=A0=A0=A0=A0=A0=A0 up/down reweight
-1=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=A0=A0 root default
-3=A0=A0=A0=A0=A0
6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rack unknownrack
-2=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 host h1
0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1
1=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.1=A0=A0 down=A0=A0=A0 1
2=A0=A0=A0=A0=A0=A0
1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 osd.2=A0=A0 up=A0=A0=A0=A0=A0 1
-4=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 host h2
3=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.3=A0=A0 up=A0=A0=A0=A0=A0 1
4=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.4=A0=A0 up=A0=A0=A0=A0=A0
1
5=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.5=A0=A0 up=A0=A0=A0=A0=A0 1


The down osd always come back up after 2 minutes or less andi see the f=
ollowing error message in the respective osd log file:=A0=20
2013-01-07 04:40:17.613028 7fec7f092760=A0 1 journal _open=20
/ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block size=20
4096 bytes, directio =3D 1, aio =3D 0
2013-01-07 04:40:17.613122=20
7fec7f092760=A0 1 journal _open /ceph_journal/journals/journal_2 fd 26:=
=20
1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-07
04:42:10.006533 7fec746f7710=A0 0 -- 192.168.0.124:6808/19449 >>=20
192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=3D31 :6808 pgs=3D0 cs=3D=
0=20
l=3D0).accept connect_seq 0 vs existing 0 state connecting
2013-01-07=20
04:45:29.834341 7fec743f4710=A0 0 -- 192.168.1.124:6808/19449 >>=20
192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45438 pgs=3D7 cs=3D=
1=20
l=3D0).fault, initiating reconnect
2013-01-07 04:45:29.835748=20
7fec743f4710=A0 0 -- 192.168.1.124:6808/19449 >>=20
192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45439 pgs=3D15 cs=
=3D3=20
l=3D0).fault, initiating reconnect
2013-01-07 04:45:30.835219 7fec743f4710=A0 0 --=20
192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072=20
pipe(0x7fec5402f320 sd=3D28 :45894 pgs=3D482 cs=3D903 l=3D0).fault, ini=
tiating=20
reconnect
2013-01-07 04:45:30.837318 7fec743f4710=A0 0 --=20
192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072=20
pipe(0x7fec5402f320 sd=3D28 :45895 pgs=3D483 cs=3D905 l=3D0).fault, ini=
tiating=20
reconnect
2013-01-07 04:45:30.851984 7fec637fe710=A0 0 log [ERR] : map=20
e27 had wrong cluster addr (192.168.0.124:6808/19449 !=3D my=20
192.168.1.124:6808/19449)

Also, this only happens=A0 only when the cluster ip address and the pub=
lic ip address are different for example
=2E...
=2E...
=2E...
[osd.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D g8ct
=A0=A0=A0=A0=A0=A0=A0 public address =3D 192.168.0.124
=A0=A0=A0=A0=A0=A0=A0 cluster address =3D 192.168.1.124
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sdb

=2E...
=2E...

but does not happen when they are the same.=A0 Any idea what may be the=
 issue?

Isaac
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
