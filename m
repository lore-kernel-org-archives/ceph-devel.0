From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: reads while 100% write
Date: Wed, 30 Mar 2016 16:47:23 -0400 (EDT)
Message-ID: <1305567074.45693522.1459370843526.JavaMail.zimbra@redhat.com>
References: <D320896C.C4F8%evgeniy.firsov@sandisk.com> <alpine.DEB.2.11.1603300714580.22014@cpach.fuggernut.com> <D3216565.C534%evgeniy.firsov@sandisk.com> <1920245628.45592204.1459363024441.JavaMail.zimbra@redhat.com> <D3216CC1.C53E%evgeniy.firsov@sandisk.com> <725823729.45650339.1459365047004.JavaMail.zimbra@redhat.com> <D3217463.C566%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:50689 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbcC3Ur0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 16:47:26 -0400
In-Reply-To: <D3217463.C566%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Correct, the change for the default RBD features actually merged on Mar=
ch 1 as well (a7470c8), albeit a few hours after the commit you last te=
sted against (c1e41af).  You can revert to pre-Jewel RBD features on an=
 existing image by running the following:

# rbd feature disable <image name> exclusive-lock,object-map,fast-diff,=
deep-flatten

Hopefully the new PR to add the WILLNEED fadvise flag helps.=20

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> Sent: Wednesday, March 30, 2016 4:39:09 PM
> Subject: Re: reads while 100% write
>=20
> I use 64K.
> Explicit settings are identical for both revisions.
>=20
> Looks like the following change slows down performance 10 times:
>=20
> -OPTION(rbd_default_features, OPT_INT, 3) // only applies to format 2
> images
> -                                        // +1 for layering, +2 for
> stripingv2,
> -                                        // +4 for exclusive lock, +8=
 for
> object map
> +OPTION(rbd_default_features, OPT_INT, 61)   // only applies to forma=
t 2
> images
> +                                           // +1 for layering, +2 fo=
r
> stripingv2,
> +                                           // +4 for exclusive lock,=
 +8
> for object map
> +                                           // +16 for fast-diff, +32=
 for
> deep-flatten,
> +                                           // +64 for journaling
>=20
>=20
>=20
> On 3/30/16, 12:10 PM, "Jason Dillaman" <dillaman@redhat.com> wrote:
>=20
> >Are you using the RBD default of 4MB object sizes or are you using
> >something much smaller like 64KB?  An object map of that size should=
 be
> >tracking up to 24,576,000 objects.  When you ran your test before, d=
id
> >you have the RBD object map disabled?  This definitely seems to be a=
 use
> >case where the lack of a cache in front of BlueStore is hurting smal=
l IO.
> >
> >--
> >
> >Jason Dillaman
> >
> >
> >----- Original Message -----
> >> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> >> To: "Jason Dillaman" <dillaman@redhat.com>
> >> Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> >> Sent: Wednesday, March 30, 2016 3:00:47 PM
> >> Subject: Re: reads while 100% write
> >>
> >> 1.5T in that run.
> >> With 150G behavior is the same. Except it says "_do_read 0~18 size
> >>615030=E2=80=9D
> >> instead of 6M.
> >>
> >> Also when random 4k write starts there are more reads then writes:
> >>
> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
> >>avgrq-sz
> >> avgqu-sz   await r_await w_await  svctm  %util
> >>
> >> sdd               0.00  1887.00    0.00  344.00     0.00  8924.00
> >>51.88
> >>     0.36    1.06    0.00    1.06   0.91  31.20
> >> sde              30.00     0.00   30.00  957.00 18120.00  3828.00
> >>44.47
> >>     0.25    0.26    3.87    0.14   0.17  16.40
> >>
> >> Logs: http://pastebin.com/gGzfR5ez
> >>
> >>
> >> On 3/30/16, 11:37 AM, "Jason Dillaman" <dillaman@redhat.com> wrote=
:
> >>
> >> >How large is your RBD image?  100 terabytes?
> >> >
> >> >--
> >> >
> >> >Jason Dillaman
> >> >
> >> >
> >> >----- Original Message -----
> >> >> From: "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com>
> >> >> To: "Sage Weil" <sage@newdream.net>
> >> >> Cc: ceph-devel@vger.kernel.org
> >> >> Sent: Wednesday, March 30, 2016 2:14:12 PM
> >> >> Subject: Re: reads while 100% write
> >> >>
> >> >> These are suspicious lines:
> >> >>
> >> >> 2016-03-30 10:54:23.142205 7f2e933ff700 10 bluestore(src/dev/os=
d0)
> >>read
> >> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head#
> >>6144018~6012 =3D
> >> >> 6012
> >> >> 2016-03-30 10:54:23.142252 7f2e933ff700 15 bluestore(src/dev/os=
d0)
> >>read
> >> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4=
096
> >> >> 2016-03-30 10:54:23.142260 7f2e933ff700 20 bluestore(src/dev/os=
d0)
> >> >> _do_read 8210~4096 size 6150030
> >> >> 2016-03-30 10:54:23.142267 7f2e933ff700  5 bdev(src/dev/osd0/bl=
ock)
> >>read
> >> >> 8003854336~8192
> >> >> 2016-03-30 10:54:23.142609 7f2e933ff700 10 bluestore(src/dev/os=
d0)
> >>read
> >> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4=
096 =3D
> >> >>4096
> >> >> 2016-03-30 10:54:23.142882 7f2e933ff700 15 bluestore(src/dev/os=
d0)
> >> >>_write
> >> >> 0.d_head #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~4=
096
> >> >> 2016-03-30 10:54:23.142888 7f2e933ff700 20 bluestore(src/dev/os=
d0)
> >> >> _do_write #0:b06b5e8e:::rbd_object_map.10046b8b4567:head# 8210~=
4096 -
> >> >>have
> >> >> 6150030 bytes in 1 extents
> >> >>
> >> >> More logs here: http://pastebin.com/74WLzFYw
> >> >>
> >> >>
> >> >>
> >> >> On 3/30/16, 4:19 AM, "Sage Weil" <sage@newdream.net> wrote:
> >> >>
> >> >> >On Wed, 30 Mar 2016, Evgeniy Firsov wrote:
> >> >> >> After pulling master branch on Friday I start seeing odd fio
> >> >>behavior, I
> >> >> >> see a lot of reads while writing and very low performance no
> >>matter
> >> >> >> whether it read or write workload.
> >> >> >>
> >> >> >> Output from sequential 1M write:
> >> >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    =
wkB/s
> >> >> >>avgrq-sz
> >> >> >> avgqu-sz   await r_await w_await  svctm  %util
> >> >> >>
> >> >> >> sdd               0.00   409.00    0.00  364.00     0.00  30=
92.00
> >> >> >>16.99
> >> >> >>     0.28    0.78    0.00    0.78   0.76  27.60
> >> >> >> sde               0.00   242.00  365.00  363.00  2436.00  96=
80.00
> >> >> >>33.29
> >> >> >>     0.18    0.24    0.42    0.07   0.23  16.80
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> block.db -> /dev/sdd
> >> >> >> block -> /dev/sde
> >> >> >>
> >> >> >> health HEALTH_OK
> >> >> >> monmap e1: 1 mons at {a=3D127.0.0.1:6789/0}
> >> >> >>        election epoch 3, quorum 0 a
> >> >> >> osdmap e7: 1 osds: 1 up, 1 in
> >> >> >>        flags sortbitwise
> >> >> >> pgmap v24: 64 pgs, 1 pools, 577 MB data, 9152 objects
> >> >> >>        8210 MB used, 178 GB / 186 GB avail
> >> >> >>              64 active+clean
> >> >> >> client io 1550 kB/s rd, 9559 kB/s wr, 645 op/s rd, 387 op/s =
wr
> >> >> >>
> >> >> >>
> >> >> >> While on earlier revision(c1e41af) everything looks as expec=
ted:
> >> >> >>
> >> >> >> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    =
wkB/s
> >> >> >>avgrq-sz
> >> >> >> avgqu-sz   await r_await w_await  svctm  %util
> >> >> >> sdd               0.00  4910.00    0.00  680.00     0.00 224=
16.00
> >> >> >>65.93
> >> >> >>     1.05    1.55    0.00    1.55   1.18  80.00
> >> >> >> sde               0.00     0.00    0.00 3418.00     0.00 217=
612.00
> >> >> >> 127.33    63.78   18.18    0.00   18.18   0.25  86.40
> >> >> >>
> >> >> >> Other observation, may be related to the issue, is that CPU =
load
> >>is
> >> >> >> imbalanced. Single =C2=B3tp_osd_tp=C2=B2 thread is 100% busy=
, while the
> >>rest is
> >> >> >>idle.
> >> >> >> Looks like all load goes to single thread pool shard, earlie=
r CPU
> >>was
> >> >> >>well
> >> >> >> balanced.
> >> >> >
> >> >> >Hmm.  Can you capture a log with debug bluestore =3D 20 and de=
bug
> >>bdev =3D
> >> >>20?
> >> >> >
> >> >> >Thanks!
> >> >> >sage
> >> >> >
> >> >> >
> >> >> >>
> >> >> >>
> >> >> >> =E2=80=B9
> >> >> >> Evgeniy
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> PLEASE NOTE: The information contained in this electronic ma=
il
> >> >>message
> >> >> >>is intended only for the use of the designated recipient(s) n=
amed
> >> >>above.
> >> >> >>If the reader of this message is not the intended recipient, =
you
> >>are
> >> >> >>hereby notified that you have received this message in error =
and
> >>that
> >> >> >>any review, dissemination, distribution, or copying of this
> >>message is
> >> >> >>strictly prohibited. If you have received this communication =
in
> >>error,
> >> >> >>please notify the sender by telephone or e-mail (as shown abo=
ve)
> >> >> >>immediately and destroy any and all copies of this message in=
 your
> >> >> >>possession (whether hard copies or electronically stored copi=
es).
> >> >> >> --
> >> >> >> To unsubscribe from this list: send the line "unsubscribe
> >> >>ceph-devel" in
> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> More majordomo info at  http://vger.kernel.org/majordomo-inf=
o.html
> >> >> >>
> >> >> >>
> >> >>
> >> >> PLEASE NOTE: The information contained in this electronic mail
> >>message
> >> >>is
> >> >> intended only for the use of the designated recipient(s) named =
above.
> >> >>If the
> >> >> reader of this message is not the intended recipient, you are h=
ereby
> >> >> notified that you have received this message in error and that =
any
> >> >>review,
> >> >> dissemination, distribution, or copying of this message is stri=
ctly
> >> >> prohibited. If you have received this communication in error, p=
lease
> >> >>notify
> >> >> the sender by telephone or e-mail (as shown above) immediately =
and
> >> >>destroy
> >> >> any and all copies of this message in your possession (whether =
hard
> >> >>copies
> >> >> or electronically stored copies).
> >> >>
> >>
> >>>>N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BD=
y=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD=
^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=
=BF=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:
> >>>>+v
> >> >>=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=DD=A2j"=EF=BF=BD=EF=BF=BD
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
