From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: reads while 100% write
Date: Wed, 30 Mar 2016 15:59:08 -0400 (EDT)
Message-ID: <1158336864.45671768.1459367948629.JavaMail.zimbra@redhat.com>
References: <D320896C.C4F8%evgeniy.firsov@sandisk.com> <alpine.DEB.2.11.1603300714580.22014@cpach.fuggernut.com> <D3216565.C534%evgeniy.firsov@sandisk.com> <1920245628.45592204.1459363024441.JavaMail.zimbra@redhat.com> <D3216CC1.C53E%evgeniy.firsov@sandisk.com> <725823729.45650339.1459365047004.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1603301554480.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47928 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcC3T7L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 15:59:11 -0400
In-Reply-To: <alpine.DEB.2.11.1603301554480.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, ceph-devel@vger.kernel.org

This IO is being performed within an OSD class method.  I can add a new=
 cls_cxx_read2 method to accept cache hints and update the associated o=
bject map methods.  Would this apply to writes as well?

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>, ceph-devel@vger.ke=
rnel.org
> Sent: Wednesday, March 30, 2016 3:55:14 PM
> Subject: Re: reads while 100% write
>=20
> On Wed, 30 Mar 2016, Jason Dillaman wrote:
> > Are you using the RBD default of 4MB object sizes or are you using
> > something much smaller like 64KB?  An object map of that size shoul=
d be
> > tracking up to 24,576,000 objects.  When you ran your test before, =
did
> > you have the RBD object map disabled?  This definitely seems to be =
a use
> > case where the lack of a cache in front of BlueStore is hurting sma=
ll
> > IO.
>=20
> Using the rados cache hint WILLNEED is probably appropriate here..
>=20
> sage
>=20
> >=20
> > --
> >=20
> > Jason Dillaman
> >=20
> >=20
> > ----- Original Message -----
> > > From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> > > To: "Jason Dillaman" <dillaman@redhat.com>
> > > Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> > > Sent: Wednesday, March 30, 2016 3:00:47 PM
> > > Subject: Re: reads while 100% write
> > >=20
> > > 1.5T in that run.
> > > With 150G behavior is the same. Except it says "_do_read 0~18 siz=
e
> > > 615030=E2=80=9D
> > > instead of 6M.
> > >=20
> > > Also when random 4k write starts there are more reads then writes=
:
> > >=20
> > > Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
> > > avgrq-sz
> > > avgqu-sz   await r_await w_await  svctm  %util
> > >=20
> > > sdd               0.00  1887.00    0.00  344.00     0.00  8924.00
> > > 51.88
> > >     0.36    1.06    0.00    1.06   0.91  31.20
> > > sde              30.00     0.00   30.00  957.00 18120.00  3828.00
> > > 44.47
> > >     0.25    0.26    3.87    0.14   0.17  16.40
> > >=20
> > > Logs: http://pastebin.com/gGzfR5ez
> > >=20
> > >=20
> > > On 3/30/16, 11:37 AM, "Jason Dillaman" <dillaman@redhat.com> wrot=
e:
> > >=20
> > > >How large is your RBD image?  100 terabytes?
> > > >
> > > >--
> > > >
> > > >Jason Dillaman
> > > >
> > > >
> > > >----- Original Message -----
> > > >> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> > > >> To: "Sage Weil" <sage@newdream.net>
> > > >> Cc: ceph-devel@vger.kernel.org
> > > >> Sent: Wednesday, March 30, 2016 2:14:12 PM
> > > >> Subject: Re: reads while 100% write
> > > >>
> > > >> These are suspicious lines:
> > > >>
> > > >> 2016-03-30 10:54:23.142205 7f2e933ff700 10 bluestore(src/dev/o=
sd0)
> > > >> read
> > > >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 61440=
18~6012
> > > >> =3D
> > > >> 6012
> > > >> 2016-03-30 10:54:23.142252 7f2e933ff700 15 bluestore(src/dev/o=
sd0)
> > > >> read
> > > >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~=
4096
> > > >> 2016-03-30 10:54:23.142260 7f2e933ff700 20 bluestore(src/dev/o=
sd0)
> > > >> _do_read 8210~4096 size 6150030
> > > >> 2016-03-30 10:54:23.142267 7f2e933ff700  5 bdev(src/dev/osd0/b=
lock)
> > > >> read
> > > >> 8003854336~8192
> > > >> 2016-03-30 10:54:23.142609 7f2e933ff700 10 bluestore(src/dev/o=
sd0)
> > > >> read
> > > >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~=
4096 =3D
> > > >>4096
> > > >> 2016-03-30 10:54:23.142882 7f2e933ff700 15 bluestore(src/dev/o=
sd0)
> > > >>_write
> > > >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~=
4096
> > > >> 2016-03-30 10:54:23.142888 7f2e933ff700 20 bluestore(src/dev/o=
sd0)
> > > >> _do_write #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210=
~4096 -
> > > >>have
> > > >> 6150030 bytes in 1 extents
> > > >>
> > > >> More logs here: http://pastebin.com/74WLzFYw
> > > >>
> > > >>
> > > >>
> > > >> On 3/30/16, 4:19 AM, "Sage Weil" <sage@newdream.net> wrote:
> > > >>
> > > >> >On Wed, 30 Mar 2016, Evgeniy Firsov wrote:
> > > >> >> After pulling master branch on Friday I start seeing odd fi=
o
> > > >>behavior, I
> > > >> >> see a lot of reads while writing and very low performance n=
o matter
> > > >> >> whether it read or write workload.
> > > >> >>
> > > >> >> Output from sequential 1M write:
> > > >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s   =
 wkB/s
> > > >> >>avgrq-sz
> > > >> >> avgqu-sz   await r_await w_await  svctm  %util
> > > >> >>
> > > >> >> sdd               0.00   409.00    0.00  364.00     0.00  3=
092.00
> > > >> >>16.99
> > > >> >>     0.28    0.78    0.00    0.78   0.76  27.60
> > > >> >> sde               0.00   242.00  365.00  363.00  2436.00  9=
680.00
> > > >> >>33.29
> > > >> >>     0.18    0.24    0.42    0.07   0.23  16.80
> > > >> >>
> > > >> >>
> > > >> >>
> > > >> >> block.db -> /dev/sdd
> > > >> >> block -> /dev/sde
> > > >> >>
> > > >> >> health HEALTH_OK
> > > >> >> monmap e1: 1 mons at {a=3D127.0.0.1:6789/0}
> > > >> >>        election epoch 3, quorum 0 a
> > > >> >> osdmap e7: 1 osds: 1 up, 1 in
> > > >> >>        flags sortbitwise
> > > >> >> pgmap v24: 64 pgs, 1 pools, 577 MB data, 9152 objects
> > > >> >>        8210 MB used, 178 GB / 186 GB avail
> > > >> >>              64 active+clean
> > > >> >> client io 1550 kB/s rd, 9559 kB/s wr, 645 op/s rd, 387 op/s=
 wr
> > > >> >>
> > > >> >>
> > > >> >> While on earlier revision(c1e41af) everything looks as expe=
cted:
> > > >> >>
> > > >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s   =
 wkB/s
> > > >> >>avgrq-sz
> > > >> >> avgqu-sz   await r_await w_await  svctm  %util
> > > >> >> sdd               0.00  4910.00    0.00  680.00     0.00 22=
416.00
> > > >> >>65.93
> > > >> >>     1.05    1.55    0.00    1.55   1.18  80.00
> > > >> >> sde               0.00     0.00    0.00 3418.00     0.00 21=
7612.00
> > > >> >> 127.33    63.78   18.18    0.00   18.18   0.25  86.40
> > > >> >>
> > > >> >> Other observation, may be related to the issue, is that CPU=
 load is
> > > >> >> imbalanced. Single =C2=B3tp_osd_tp=C2=B2 thread is 100% bus=
y, while the rest
> > > >> >> is
> > > >> >>idle.
> > > >> >> Looks like all load goes to single thread pool shard, earli=
er CPU
> > > >> >> was
> > > >> >>well
> > > >> >> balanced.
> > > >> >
> > > >> >Hmm.  Can you capture a log with debug bluestore =3D 20 and d=
ebug bdev
> > > >> >=3D
> > > >>20?
> > > >> >
> > > >> >Thanks!
> > > >> >sage
> > > >> >
> > > >> >
> > > >> >>
> > > >> >>
> > > >> >> =E2=80=B9
> > > >> >> Evgeniy
> > > >> >>
> > > >> >>
> > > >> >>
> > > >> >> PLEASE NOTE: The information contained in this electronic m=
ail
> > > >>message
> > > >> >>is intended only for the use of the designated recipient(s) =
named
> > > >>above.
> > > >> >>If the reader of this message is not the intended recipient,=
 you are
> > > >> >>hereby notified that you have received this message in error=
 and
> > > >> >>that
> > > >> >>any review, dissemination, distribution, or copying of this =
message
> > > >> >>is
> > > >> >>strictly prohibited. If you have received this communication=
 in
> > > >> >>error,
> > > >> >>please notify the sender by telephone or e-mail (as shown ab=
ove)
> > > >> >>immediately and destroy any and all copies of this message i=
n your
> > > >> >>possession (whether hard copies or electronically stored cop=
ies).
> > > >> >> --
> > > >> >> To unsubscribe from this list: send the line "unsubscribe
> > > >>ceph-devel" in
> > > >> >> the body of a message to majordomo@vger.kernel.org
> > > >> >> More majordomo info at  http://vger.kernel.org/majordomo-in=
fo.html
> > > >> >>
> > > >> >>
> > > >>
> > > >> PLEASE NOTE: The information contained in this electronic mail=
 message
> > > >>is
> > > >> intended only for the use of the designated recipient(s) named=
 above.
> > > >>If the
> > > >> reader of this message is not the intended recipient, you are =
hereby
> > > >> notified that you have received this message in error and that=
 any
> > > >>review,
> > > >> dissemination, distribution, or copying of this message is str=
ictly
> > > >> prohibited. If you have received this communication in error, =
please
> > > >>notify
> > > >> the sender by telephone or e-mail (as shown above) immediately=
 and
> > > >>destroy
> > > >> any and all copies of this message in your possession (whether=
 hard
> > > >>copies
> > > >> or electronically stored copies).
> > > >>
> > > >>N???????????????r??????y?????????b???X??????=C7=A7v???^???)=DE=BA=
{.n???+?????????z???]z?????????{ay???=CA=87=DA=99???,j??????f?????????h=
?????????z??????w??????????????????j:+v
> > > >>?????????w???j???m????????????????????????zZ+??????=DD=A2j"????=
??
> > >=20
> > > PLEASE NOTE: The information contained in this electronic mail me=
ssage is
> > > intended only for the use of the designated recipient(s) named ab=
ove. If
> > > the
> > > reader of this message is not the intended recipient, you are her=
eby
> > > notified that you have received this message in error and that an=
y
> > > review,
> > > dissemination, distribution, or copying of this message is strict=
ly
> > > prohibited. If you have received this communication in error, ple=
ase
> > > notify
> > > the sender by telephone or e-mail (as shown above) immediately an=
d
> > > destroy
> > > any and all copies of this message in your possession (whether ha=
rd
> > > copies
> > > or electronically stored copies).
> > > N???????????????r??????y?????????b???X??????=C7=A7v???^???)=DE=BA=
{.n???+?????????z???]z?????????{ay???=CA=87=DA=99???,j??????f?????????h=
?????????z??????w??????????????????j:+v?????????w???j???m??????????????=
??????????zZ+??????=DD=A2j"??????
> >=20
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
