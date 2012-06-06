From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Fwd: mount: 10.0.6.10:/: can't read superblock
Date: Wed, 06 Jun 2012 00:37:32 -0400 (EDT)
Message-ID: <bca9b4eb-f8b0-4366-874a-1c7fcad64835@mail.linserv.se>
References: <d5061f6f-3671-4eb1-9718-fb78752459f1@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:60568 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2FFEhw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 00:37:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id F2FFDDA032
	for <ceph-devel@vger.kernel.org>; Wed,  6 Jun 2012 00:37:33 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pTghz4RStpoE for <ceph-devel@vger.kernel.org>;
	Wed,  6 Jun 2012 00:37:32 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 8C379DA031
	for <ceph-devel@vger.kernel.org>; Wed,  6 Jun 2012 00:37:32 -0400 (EDT)
In-Reply-To: <d5061f6f-3671-4eb1-9718-fb78752459f1@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Trying to remove one of the folders made the mds.a and mds.b to stop. s=
o somting is wrong in my mds.=20
ceph -s gives=20

2012-06-06 06:19:19.899973 pg v1220573: 1152 pgs: 1152 active+clean; 19=
1 GB data, 393 GB used, 973 GB / 1379 GB avail=20
2012-06-06 06:19:19.905097 mds e78: 1/1/1 up {0=3Dc=3Dup:active}=20
2012-06-06 06:19:19.905200 osd e1114: 8 osds: 8 up, 8 in=20
2012-06-06 06:19:19.905400 log 2012-06-06 05:51:31.499366 osd.3 10.0.6.=
11:6804/2933 804 : [INF] 0.c scrub ok=20
2012-06-06 06:19:19.905598 mon e1: 3 mons at {a=3D10.0.6.10:6789/0,b=3D=
10.0.6.11:6789/0,c=3D10.0.6.12:6789/0}=20

i checked the log files on ceph1 and 2 where I have my mon.=20

mds.a -------------------=20
cessful recovery!=20
-2> 2012-06-06 05:38:35.956195 7f2d5ea08700 1 mds.0.12 active_start=20
-1> 2012-06-06 05:38:35.967760 7f2d5ea08700 1 mds.0.12 cluster recovere=
d.=20
0> 2012-06-06 05:38:37.200297 7f2d5ea08700 -1 mds/AnchorServer.cc: In f=
unction 'virtual void AnchorServer::handle_query(MMDSTableRequest*)' th=
read 7f2d5ea08700 time 2012-06-06 05:38:37.198981=20
mds/AnchorServer.cc: 249: FAILED assert(anchor_map.count(curino) =3D=3D=
 1)=20

ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)=20
1: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6bdc95]=20
2: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b0474]=20
3: (MDS::_dispatch(Message*)+0xaf8) [0x4c50b8]=20
4: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c628b]=20
5: (SimpleMessenger::dispatch_entry()+0x979) [0x7acb49]=20
6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7336ed]=20
7: (()+0x68ca) [0x7f2d6346e8ca]=20
8: (clone()+0x6d) [0x7f2d61cf692d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- end dump of recent events ---=20
2012-06-06 05:38:37.203277 7f2d5ea08700 -1 *** Caught signal (Aborted) =
**=20
in thread 7f2d5ea08700=20

ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)=20
1: /usr/bin/ceph-mds() [0x814279]=20
2: (()+0xeff0) [0x7f2d63476ff0]=20
3: (gsignal()+0x35) [0x7f2d61c591b5]=20
4: (abort()+0x180) [0x7f2d61c5bfc0]=20
5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f2d624eddc5]=20
6: (()+0xcb166) [0x7f2d624ec166]=20
7: (()+0xcb193) [0x7f2d624ec193]=20
8: (()+0xcb28e) [0x7f2d624ec28e]=20
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*=
)+0x940) [0x74f9b0]=20
10: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6bdc95]=20
11: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b0474]=20
12: (MDS::_dispatch(Message*)+0xaf8) [0x4c50b8]=20
13: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c628b]=20
14: (SimpleMessenger::dispatch_entry()+0x979) [0x7acb49]=20
15: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7336ed]=20
16: (()+0x68ca) [0x7f2d6346e8ca]=20
17: (clone()+0x6d) [0x7f2d61cf692d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- begin dump of recent events ---=20
0> 2012-06-06 05:38:37.203277 7f2d5ea08700 -1 *** Caught signal (Aborte=
d) **=20
in thread 7f2d5ea08700=20

ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)=20
1: /usr/bin/ceph-mds() [0x814279]=20
2: (()+0xeff0) [0x7f2d63476ff0]=20
3: (gsignal()+0x35) [0x7f2d61c591b5]=20
4: (abort()+0x180) [0x7f2d61c5bfc0]=20
5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f2d624eddc5]=20
6: (()+0xcb166) [0x7f2d624ec166]=20
7: (()+0xcb193) [0x7f2d624ec193]=20
8: (()+0xcb28e) [0x7f2d624ec28e]=20
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*=
)+0x940) [0x74f9b0]=20
10: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6bdc95]=20
11: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b0474]=20
12: (MDS::_dispatch(Message*)+0xaf8) [0x4c50b8]=20
13: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c628b]=20
14: (SimpleMessenger::dispatch_entry()+0x979) [0x7acb49]=20
15: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7336ed]=20
16: (()+0x68ca) [0x7f2d6346e8ca]=20
17: (clone()+0x6d) [0x7f2d61cf692d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- end dump of recent events ---=20

the ceph -v reports on my diffrent servers=20

root@ceph1:~# ceph -v=20
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
root@ceph1:~# ssh ceph2 ceph -v=20
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
root@ceph1:~# ssh ceph3 ceph -v=20
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
root@ceph1:~# ssh ceph4 ceph -v=20
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20

is the 0.46 above reporting when the error occurred or am I running the=
 wrong binaries=20
i use the debian packages ?=20

mds.b=20

0> 2012-06-06 05:38:17.533743 7fae49945700 -1 mds/AnchorServer.cc: In f=
unction 'virtual void AnchorServer::handle_query(MMDSTableRequest*)' th=
read 7fae49945700 time 2012-06-06 05:38:17.523498=20
mds/AnchorServer.cc: 249: FAILED assert(anchor_map.count(curino) =3D=3D=
 1)=20

ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
1: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6c1125]=20
2: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984]=20
3: (MDS::_dispatch(Message*)+0xafa) [0x4c61da]=20
4: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab]=20
5: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729]=20
6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd]=20
7: (()+0x68ca) [0x7fae4e3ab8ca]=20
8: (clone()+0x6d) [0x7fae4cc3392d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- end dump of recent events ---=20
2012-06-06 05:38:17.711889 7fae49945700 -1 *** Caught signal (Aborted) =
**=20
in thread 7fae49945700=20

ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
1: /usr/bin/ceph-mds() [0x81da89]=20
2: (()+0xeff0) [0x7fae4e3b3ff0]=20
3: (gsignal()+0x35) [0x7fae4cb961b5]=20
4: (abort()+0x180) [0x7fae4cb98fc0]=20
5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fae4d42adc5]=20
6: (()+0xcb166) [0x7fae4d429166]=20
7: (()+0xcb193) [0x7fae4d429193]=20
8: (()+0xcb28e) [0x7fae4d42928e]=20
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*=
)+0x940) [0x7555f0]=20
10: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6c1125]=20
11: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984]=20
12: (MDS::_dispatch(Message*)+0xafa) [0x4c61da]=20
13: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab]=20
14: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729]=20
15: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd]=20
16: (()+0x68ca) [0x7fae4e3ab8ca]=20
17: (clone()+0x6d) [0x7fae4cc3392d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- begin dump of recent events ---=20
0> 2012-06-06 05:38:17.711889 7fae49945700 -1 *** Caught signal (Aborte=
d) **=20
in thread 7fae49945700=20

ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)=20
1: /usr/bin/ceph-mds() [0x81da89]=20
2: (()+0xeff0) [0x7fae4e3b3ff0]=20
3: (gsignal()+0x35) [0x7fae4cb961b5]=20
4: (abort()+0x180) [0x7fae4cb98fc0]=20
5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fae4d42adc5]=20
6: (()+0xcb166) [0x7fae4d429166]=20
7: (()+0xcb193) [0x7fae4d429193]=20
8: (()+0xcb28e) [0x7fae4d42928e]=20
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*=
)+0x940) [0x7555f0]=20
10: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6c1125]=20
11: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984]=20
12: (MDS::_dispatch(Message*)+0xafa) [0x4c61da]=20
13: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab]=20
14: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729]=20
15: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd]=20
16: (()+0x68ca) [0x7fae4e3ab8ca]=20
17: (clone()+0x6d) [0x7fae4cc3392d]=20
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.=20

--- end dump of recent events ---=20





> For future reference, that error was because the active MDS server wa=
s in replay. I can't tell why it didn't move on to active from what you=
 posted, but I imagine it just got a little stuck since restarting made=
 it work out.=20
> -Greg=20
>=20
>=20
> On Tuesday, June 5, 2012 at 1:05 PM, Martin Wilderoth wrote:=20
>=20
> > Hello Again,=20
> >=20
> > I restarted the mds on all servers and then it worked again=20
> >=20
> > /Regards Martin=20
> >=20
> > > Hello=20
> > >=20
> > > > Hi Martin,=20
> > > >=20
> > > > On 06/05/2012 08:07 PM, Martin Wilderoth wrote:=20
> > > > > Hello=20
> > > > >=20
> > > > > Is there a way to recover this error.=20
> > > > >=20
> > > > > mount -t ceph 10.0.6.10:/ /mnt -vv -o name=3Dadmin,secret=3DX=
XXXXXXXXXXXXXXXXXXXXXX=20
> > > > > [ 506.640433] libceph: loaded (mon/osd proto 15/24, osdmap 5/=
6 5/6)=20
> > > > > [ 506.650594] ceph: loaded (mds proto 32)=20
> > > > > [ 506.652353] libceph: client0 fsid a9d5f9e1-4bb9-4fab-b79b-b=
a4457631b01=20
> > > > > [ 506.670876] Intel AES-NI instructions are not detected.=20
> > > > > [ 506.678861] libceph: mon0 10.0.6.10:6789 session establishe=
d=20
> > > > > mount: 10.0.6.10:/: can't read superblock=20
> > > >=20
> > > >=20
> > > >=20
> > > > Could you share some more information? For example the output f=
rom: ceph -s=20
> > >=20
> > > 2012-06-05 20:25:05.307914 pg v1189604: 1152 pgs: 1152 active+cle=
an; 191 GB data, 393 GB used, 973 GB / 1379 GB > avail=20
> > > 012-06-05 20:25:05.315871 mds e60: 1/1/1 up {0=3Dc=3Dup:replay}, =
2 up:standby=20
> > > 2012-06-05 20:25:05.315965 osd e1106: 8 osds: 8 up, 8 in=20
> > > 2012-06-05 20:25:05.316165 log 2012-06-05 20:24:50.425527 mon.0 1=
0.0.6.10:6789/0 75 : [INF] mds.? >10.0.6.11:6800/22974 up:boot=20
> > > 2012-06-05 20:25:05.316371 mon e1: 3 mons at {a=3D10.0.6.10:6789/=
0,b=3D10.0.6.11:6789/0,c=3D10.0.6.12:6789/0}=20
> > >=20
> > >=20
> > > >=20
> > > > Did you change anything to the cluster since it worked? And wha=
t version=20
> > > > are you running?=20
> > >=20
> > >=20
> > >=20
> > > I have not done any changes installed at version 0.46 upgraded ea=
rlier and have been testing with=20
> > > ceph and ceph-fuse and backuppc. It was during the ceph-fuse it h=
anged.=20
> > >=20
> > > Current version=20
> > > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad=
372)=20
> > >=20
> > > > > One of my mds logs has 24G of data.=20
> > > >=20
> > > > Is it still running?=20
> > > I have restarted mds.a and mds.b they seems to be running. But no=
t everything.=20
> > > mds.a was stoped not sure mds.b but it has a big logfile.=20
> > >=20
> > > >=20
> > > > >=20
> > > > > I have some rbd devices that I would like to keep.=20
> > > >=20
> > > > RBD doesn't use the MDS nor the POSIX filesystem, so you will p=
robably=20
> > > > be fine, but we need the output of "ceph -s" first.=20
> > > >=20
> > > > Does this work?=20
> > > > $ rbd ls=20
> > >=20
> > >=20
> > > this works I'm still using the rbd with no problem=20
> > > > $ rados -p rbd ls=20
> > >=20
> > >=20
> > > seems to work reports something simmilar to=20
> > > rb.0.2.00000000052e=20
> > > rb.0.0.0000000002f2=20
> > > rb.0.7.000000000345=20
> > > rb.0.7.000000000896=20
> > > rb.0.0.000000000102=20
> > > rb.0.9.000000000172=20
> > > rb.0.1.000000000350=20
> > > rb.0.4.000000000180=20
> > > rb.0.4.00000000068b=20
> > > rb.0.5.00000000054c=20
> > > rb.0.2.0000000001e1=20
> > >=20
> > > > Wido=20
> > > >=20
> > > > >=20
> > > > > /Regards Martin=20


Regards / Med V=C3=A4nlig H=C3=A4lsning Martin Wilderoth VD Linserv AB =
Enhagsslingan 4A SE-187 40 T=C3=A4by www.linserv.se Tel: +46(0)8-473 60=
 63 Fax: +46(0)70-969 09 19 Email: martin.wilderoth@linserv.se ,=20

Regards / Med V=C3=A4nlig H=C3=A4lsning=20
Martin Wilderoth=20
VD=20




=09

Linserv AB=20
Enhagsslingan 4A=20
SE-187 40 T=C3=A4by=20
www.linserv.se=20

=09
Tel: +46(0)8-473 60 63=20
=46ax: +46(0)70-969 09 19=20
Email: martin.wilderoth@linserv.se=20
,=20













--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
