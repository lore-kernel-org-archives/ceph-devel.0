From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new host to my cluster
Date: Fri, 25 Jan 2013 09:51:13 -0800 (PST)
Message-ID: <1359136273.17901.YahooMailNeo@web121903.mail.ne1.yahoo.com>
References: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com> <4428CF82A82E485B81CB865DFBE92465@inktank.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm20.bullet.mail.ne1.yahoo.com ([98.138.90.83]:34796 "EHLO
	nm20.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932108Ab3AYRvP convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Jan 2013 12:51:15 -0500
In-Reply-To: <4428CF82A82E485B81CB865DFBE92465@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Gregory, the network physical layout is simple, the two networks are=20
separate. the 192.168.0 and the 192.168.1 are not subnets within a=20
network.

Isaac=A0=20




----- Original Message -----
=46rom: Gregory Farnum <greg@inktank.com>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Sent: Thursday, January 24, 2013 1:28 PM
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new =
host to my cluster

What's the physical layout of your networking? This additional log may =
prove helpful as well, but I really need a bit more context in evaluati=
ng the messages I see from the first one. :)=20
-Greg


On Thursday, January 24, 2013 at 9:24 AM, Isaac Otsiabah wrote:

>=20
>=20
> Gregory, i tried send the the attached debug output several times and=
=20
> the mail server rejected them all probably becauseof the file size so=
 i cut the log file size down and it is attached. You will see the=20
> reconnection failures by the error message line below. The ceph versi=
on=20
> is 0.56
>=20
>=20
> it appears to be a timing issue because with the flag (debug ms=3D1) =
turned on, the system ran slower and became harder to fail.
> I
> ran it several times and finally got it to fail on (osd.0) using=20
> default crush map. The attached tar file contains log files for all=20
> components on g8ct plus the ceph.conf. By the way, the log file conta=
in only the last 1384 lines where the error occurs.
>=20
>=20
> I started with a 1-node cluster on host g8ct (osd.0, osd.1, osd.2) an=
d then added host g13ct (osd.3, osd.4, osd.5)
>=20
>=20
> id weight type name up/down reweight
> -1 6 root default
> -3 6 rack unknownrack
> -2 3 host g8ct
> 0 1 osd.0 down 1
> 1 1 osd.1 up 1
> 2 1 osd.2 up 1
> -4 3 host g13ct
> 3 1 osd.3 up 1
> 4 1 osd.4 up 1
> 5 1 osd.5 up 1
>=20
>=20
>=20
> The error messages are in ceph.log and ceph-osd.0.log:
>=20
> ceph.log:2013-01-08
> 05:41:38.080470 osd.0 192.168.0.124:6801/25571 3 : [ERR] map e15 had=20
> wrong cluster addr (192.168.0.124:6802/25571 !=3D my=20
> 192.168.1.124:6802/25571)
> ceph-osd.0.log:2013-01-08 05:41:38.080458 7f06757fa710 0 log [ERR] : =
map e15 had wrong cluster addr=20
> (192.168.0.124:6802/25571 !=3D my 192.168.1.124:6802/25571)
>=20
>=20
>=20
> [root@g8ct ceph]# ceph -v
> ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
>=20
>=20
> Isaac
>=20
>=20
> ----- Original Message -----
> From: Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>
> To: Isaac Otsiabah <zmoo76b@yahoo.com (mailto:zmoo76b@yahoo.com)>
> Cc: "ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)" =
<ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>
> Sent: Monday, January 7, 2013 1:27 PM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a ne=
w host to my cluster
>=20
> On Monday, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:
>=20
>=20
> When i add a new host (with osd's) to my existing cluster, 1 or 2=20
> previous osd(s) goes down for about 2 minutes and then they come back=
=20
> up.=20
> >=20
> >=20
> > [root@h1ct ~]# ceph osd tree
> >=20
> > # id weight type name up/down reweight
> > -1=20
> > 3 root default
> > -3 3 rack unknownrack
> > -2 3 host h1
> > 0 1 osd.0 up 1
> > 1 1 osd.1 up 1
> > 2=20
> > 1 osd.2 up 1
>=20
>=20
> For example, after adding host h2 (with 3 new osd) to the above clust=
er
> and running the "ceph osd tree" command, i see this:=20
> >=20
> >=20
> > [root@h1 ~]# ceph osd tree
> >=20
> > # id weight type name up/down reweight
> > -1 6 root default
> > -3=20
> > 6 rack unknownrack
> > -2 3 host h1
> > 0 1 osd.0 up 1
> > 1 1 osd.1 down 1
> > 2=20
> > 1 osd.2 up 1
> > -4 3 host h2
> > 3 1 osd.3 up 1
> > 4 1 osd.4 up=20
> > 1
> > 5 1 osd.5 up 1
>=20
>=20
> The down osd always come back up after 2 minutes or less andi see the=
=20
> following error message in the respective osd log file:=20
> > 2013-01-07 04:40:17.613028 7fec7f092760 1 journal _open=20
> > /ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block siz=
e=20
> > 4096 bytes, directio =3D 1, aio =3D 0
> > 2013-01-07 04:40:17.613122=20
> > 7fec7f092760 1 journal _open /ceph_journal/journals/journal_2 fd 26=
:=20
> > 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> > 2013-01-07
> > 04:42:10.006533 7fec746f7710 0 -- 192.168.0.124:6808/19449 >>=20
> > 192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=3D31 :6808 pgs=3D0 =
cs=3D0=20
> > l=3D0).accept connect_seq 0 vs existing 0 state connecting
> > 2013-01-07=20
> > 04:45:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>=20
> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45438 pgs=3D7=
 cs=3D1=20
> > l=3D0).fault, initiating reconnect
> > 2013-01-07 04:45:29.835748=20
> > 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>=20
> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45439 pgs=3D1=
5 cs=3D3=20
> > l=3D0).fault, initiating reconnect
> > 2013-01-07 04:45:30.835219 7fec743f4710 0 --=20
> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072=20
> > pipe(0x7fec5402f320 sd=3D28 :45894 pgs=3D482 cs=3D903 l=3D0).fault,=
 initiating=20
> > reconnect
> > 2013-01-07 04:45:30.837318 7fec743f4710 0 --=20
> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072=20
> > pipe(0x7fec5402f320 sd=3D28 :45895 pgs=3D483 cs=3D905 l=3D0).fault,=
 initiating=20
> > reconnect
> > 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map=20
> > e27 had wrong cluster addr (192.168.0.124:6808/19449 !=3D my=20
> > 192.168.1.124:6808/19449)
> >=20
> > Also, this only happens only when the cluster ip address and the pu=
blic ip address are different for example
> > ....
> > ....
> > ....
> > [osd.0]
> > host =3D g8ct
> > public address =3D 192.168.0.124
> > cluster address =3D 192.168.1.124
> > btrfs devs =3D /dev/sdb
> >=20
> > ....
> > ....
> >=20
> > but does not happen when they are the same. Any idea what may be th=
e issue?
> This isn't familiar to me at first glance. What version of Ceph are y=
ou using?
>=20
> If
> this is easy to reproduce, can you pastebin your ceph.conf and then a=
dd
> "debug ms =3D 1" to your global config and gather up the logs from ea=
ch=20
> daemon?
> -Greg
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo
>=20
>=20
> Attachments:=20
> - ceph-osd.0.log.tar.gz
>=20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
