From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: reads while 100% write
Date: Wed, 30 Mar 2016 15:10:47 -0400 (EDT)
Message-ID: <725823729.45650339.1459365047004.JavaMail.zimbra@redhat.com>
References: <D320896C.C4F8%evgeniy.firsov@sandisk.com> <alpine.DEB.2.11.1603300714580.22014@cpach.fuggernut.com> <D3216565.C534%evgeniy.firsov@sandisk.com> <1920245628.45592204.1459363024441.JavaMail.zimbra@redhat.com> <D3216CC1.C53E%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:42004 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbcC3TKw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 15:10:52 -0400
In-Reply-To: <D3216CC1.C53E%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Are you using the RBD default of 4MB object sizes or are you using some=
thing much smaller like 64KB?  An object map of that size should be tra=
cking up to 24,576,000 objects.  When you ran your test before, did you=
 have the RBD object map disabled?  This definitely seems to be a use c=
ase where the lack of a cache in front of BlueStore is hurting small IO=
=2E

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> Sent: Wednesday, March 30, 2016 3:00:47 PM
> Subject: Re: reads while 100% write
>=20
> 1.5T in that run.
> With 150G behavior is the same. Except it says "_do_read 0~18 size 61=
5030=E2=80=9D
> instead of 6M.
>=20
> Also when random 4k write starts there are more reads then writes:
>=20
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avg=
rq-sz
> avgqu-sz   await r_await w_await  svctm  %util
>=20
> sdd               0.00  1887.00    0.00  344.00     0.00  8924.00    =
51.88
>     0.36    1.06    0.00    1.06   0.91  31.20
> sde              30.00     0.00   30.00  957.00 18120.00  3828.00    =
44.47
>     0.25    0.26    3.87    0.14   0.17  16.40
>=20
> Logs: http://pastebin.com/gGzfR5ez
>=20
>=20
> On 3/30/16, 11:37 AM, "Jason Dillaman" <dillaman@redhat.com> wrote:
>=20
> >How large is your RBD image?  100 terabytes?
> >
> >--
> >
> >Jason Dillaman
> >
> >
> >----- Original Message -----
> >> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> >> To: "Sage Weil" <sage@newdream.net>
> >> Cc: ceph-devel@vger.kernel.org
> >> Sent: Wednesday, March 30, 2016 2:14:12 PM
> >> Subject: Re: reads while 100% write
> >>
> >> These are suspicious lines:
> >>
> >> 2016-03-30 10:54:23.142205 7f2e933ff700 10 bluestore(src/dev/osd0)=
 read
> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 6144018~6=
012 =3D
> >> 6012
> >> 2016-03-30 10:54:23.142252 7f2e933ff700 15 bluestore(src/dev/osd0)=
 read
> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4096
> >> 2016-03-30 10:54:23.142260 7f2e933ff700 20 bluestore(src/dev/osd0)
> >> _do_read 8210~4096 size 6150030
> >> 2016-03-30 10:54:23.142267 7f2e933ff700  5 bdev(src/dev/osd0/block=
) read
> >> 8003854336~8192
> >> 2016-03-30 10:54:23.142609 7f2e933ff700 10 bluestore(src/dev/osd0)=
 read
> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4096=
 =3D
> >>4096
> >> 2016-03-30 10:54:23.142882 7f2e933ff700 15 bluestore(src/dev/osd0)
> >>_write
> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4096
> >> 2016-03-30 10:54:23.142888 7f2e933ff700 20 bluestore(src/dev/osd0)
> >> _do_write #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~409=
6 -
> >>have
> >> 6150030 bytes in 1 extents
> >>
> >> More logs here: http://pastebin.com/74WLzFYw
> >>
> >>
> >>
> >> On 3/30/16, 4:19 AM, "Sage Weil" <sage@newdream.net> wrote:
> >>
> >> >On Wed, 30 Mar 2016, Evgeniy Firsov wrote:
> >> >> After pulling master branch on Friday I start seeing odd fio
> >>behavior, I
> >> >> see a lot of reads while writing and very low performance no ma=
tter
> >> >> whether it read or write workload.
> >> >>
> >> >> Output from sequential 1M write:
> >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB=
/s
> >> >>avgrq-sz
> >> >> avgqu-sz   await r_await w_await  svctm  %util
> >> >>
> >> >> sdd               0.00   409.00    0.00  364.00     0.00  3092.=
00
> >> >>16.99
> >> >>     0.28    0.78    0.00    0.78   0.76  27.60
> >> >> sde               0.00   242.00  365.00  363.00  2436.00  9680.=
00
> >> >>33.29
> >> >>     0.18    0.24    0.42    0.07   0.23  16.80
> >> >>
> >> >>
> >> >>
> >> >> block.db -> /dev/sdd
> >> >> block -> /dev/sde
> >> >>
> >> >> health HEALTH_OK
> >> >> monmap e1: 1 mons at {a=3D127.0.0.1:6789/0}
> >> >>        election epoch 3, quorum 0 a
> >> >> osdmap e7: 1 osds: 1 up, 1 in
> >> >>        flags sortbitwise
> >> >> pgmap v24: 64 pgs, 1 pools, 577 MB data, 9152 objects
> >> >>        8210 MB used, 178 GB / 186 GB avail
> >> >>              64 active+clean
> >> >> client io 1550 kB/s rd, 9559 kB/s wr, 645 op/s rd, 387 op/s wr
> >> >>
> >> >>
> >> >> While on earlier revision(c1e41af) everything looks as expected=
:
> >> >>
> >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB=
/s
> >> >>avgrq-sz
> >> >> avgqu-sz   await r_await w_await  svctm  %util
> >> >> sdd               0.00  4910.00    0.00  680.00     0.00 22416.=
00
> >> >>65.93
> >> >>     1.05    1.55    0.00    1.55   1.18  80.00
> >> >> sde               0.00     0.00    0.00 3418.00     0.00 217612=
=2E00
> >> >> 127.33    63.78   18.18    0.00   18.18   0.25  86.40
> >> >>
> >> >> Other observation, may be related to the issue, is that CPU loa=
d is
> >> >> imbalanced. Single =C2=B3tp_osd_tp=C2=B2 thread is 100% busy, w=
hile the rest is
> >> >>idle.
> >> >> Looks like all load goes to single thread pool shard, earlier C=
PU was
> >> >>well
> >> >> balanced.
> >> >
> >> >Hmm.  Can you capture a log with debug bluestore =3D 20 and debug=
 bdev =3D
> >>20?
> >> >
> >> >Thanks!
> >> >sage
> >> >
> >> >
> >> >>
> >> >>
> >> >> =E2=80=B9
> >> >> Evgeniy
> >> >>
> >> >>
> >> >>
> >> >> PLEASE NOTE: The information contained in this electronic mail
> >>message
> >> >>is intended only for the use of the designated recipient(s) name=
d
> >>above.
> >> >>If the reader of this message is not the intended recipient, you=
 are
> >> >>hereby notified that you have received this message in error and=
 that
> >> >>any review, dissemination, distribution, or copying of this mess=
age is
> >> >>strictly prohibited. If you have received this communication in =
error,
> >> >>please notify the sender by telephone or e-mail (as shown above)
> >> >>immediately and destroy any and all copies of this message in yo=
ur
> >> >>possession (whether hard copies or electronically stored copies)=
=2E
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe
> >>ceph-devel" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >> >>
> >> >>
> >>
> >> PLEASE NOTE: The information contained in this electronic mail mes=
sage
> >>is
> >> intended only for the use of the designated recipient(s) named abo=
ve.
> >>If the
> >> reader of this message is not the intended recipient, you are here=
by
> >> notified that you have received this message in error and that any
> >>review,
> >> dissemination, distribution, or copying of this message is strictl=
y
> >> prohibited. If you have received this communication in error, plea=
se
> >>notify
> >> the sender by telephone or e-mail (as shown above) immediately and
> >>destroy
> >> any and all copies of this message in your possession (whether har=
d
> >>copies
> >> or electronically stored copies).
> >>
> >>N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=
=DD=A2j"=EF=BF=BD=EF=BF=BD
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is
> intended only for the use of the designated recipient(s) named above.=
 If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any re=
view,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please =
notify
> the sender by telephone or e-mail (as shown above) immediately and de=
stroy
> any and all copies of this message in your possession (whether hard c=
opies
> or electronically stored copies).
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
