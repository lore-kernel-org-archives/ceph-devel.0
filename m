From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: ceph-client-standalone bug update ,make,WARNING:
 "task_dirty_inc" ,ubuntu10.10 Linux-2.6.35-22-generic
Date: Fri, 29 Oct 2010 10:07:57 +0800
Message-ID: <1288318077.2332.3.camel@osd1>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	 <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	 <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	 <Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
	 <1288259734.2621.23.camel@osd1>
	 <AANLkTikwQG6EWdr_kqmCGHR0iBnsQFWXZ8V+r7Vy+EjM@mail.gmail.com>
	 <AANLkTinS72oaJK4GLkFC675PkV40EsFjCeJPRuLwJ_7J@mail.gmail.com>
	 <AANLkTik5J8KAAnV67U4gkgEC9E8_C+z8ivaz2vB8Hg-4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:39887 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751802Ab0J2CHy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 22:07:54 -0400
In-Reply-To: <AANLkTik5J8KAAnV67U4gkgEC9E8_C+z8ivaz2vB8Hg-4@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yonggang Liu <myidpt@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thank you Gregory and Yonggang,i git rbd-backport , make sucessfully.

Regards,
Jeff.Wu
Transoft.inc=20
Senior software Engineer

=E5=9C=A8 2010-10-29=E4=BA=94=E7=9A=84 00:54 +0800=EF=BC=8CYonggang Liu=
=E5=86=99=E9=81=93=EF=BC=9A
> Solved. Thank you Gregory!
> I used the branck rbd-backport and it works perfectly.
>=20
> Regards,
>=20
> On Thu, Oct 28, 2010 at 11:55 AM, Gregory Farnum <gregf@hq.newdream.n=
et> wrote:
> > The ceph-client tree is always maintained against the latest rc fro=
m
> > Linus. For any other kernel you need to use the -backports branches=
=2E
> > It looks like this is what's causing both your troubles. :)
> > -Greg
> >
> > On Thu, Oct 28, 2010 at 8:20 AM, Yonggang Liu <myidpt@gmail.com> wr=
ote:
> >> The same thing happens here, I was using Debian 5.0 with kernel 2.=
6.32-5-686.
> >> I had the following error message:
> >> client:~/ceph-client-standalone# insmod ceph.ko
> >> insmod: error inserting 'ceph.ko': -1 Unknown symbol in module
> >> client:~/ceph-client-standalone# dmesg -c
> >> [ 4295.877555] ceph: Unknown symbol task_dirty_inc
> >>
> >> Any ideas?
> >>
> >> On Thu, Oct 28, 2010 at 5:55 AM, Jeff Wu <cpwu@tnsoft.com.cn> wrot=
e:
> >>> Hi ,all
> >>>
> >>> At Ubuntu 10.10 x86_64 , kernel : Linux-2.6.35-22-generic ,
> >>>
> >>> I git Lastest ceph-client-standalone source codes from
> >>> git://ceph.newdream.net/ceph-client-standalone.git
> >>>
> >>> it make fail, get the warning messages: "account_page_dirtied"
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Logs =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> jeff@cephserver:~/work/ceph-client-standalone$ make
> >>>
> >>>  ...................................
> >>>
> >>> CC [M]  /home/jeff/work/ceph-client-standalone/ceph_hash.o
> >>>  CC [M]  /home/jeff/work/ceph-client-standalone/ceph_frag.o
> >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
> >>>  Building modules, stage 2.
> >>>  MODPOST 1 modules
> >>> WARNING:
> >>> "account_page_dirtied" [/home/jeff/work/ceph-client-standalone/ce=
ph.ko]
> >>> undefined!
> >>>  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
> >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
> >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-gene=
ric'
> >>> jeff@cephserver:~/work/ceph-client-standalone$
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> then  i change to master-backport, to make it ,
> >>> still get a warning messages : "task_dirty_inc" .
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlogs=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>>
> >>> jeff@cephserver:~/work/ceph-client-standalone$ git checkout -b
> >>> master-backport origin/master-backport
> >>> Branch master-backport set up to track remote branch master-backp=
ort
> >>> from origin.
> >>> Switched to a new branch 'master-backport'
> >>> jeff@cephserver:~/work/ceph-client-standalone$ git pull
> >>> Already up-to-date.
> >>>
> >>> jeff@cephserver:~/work/ceph-client-standalone$ make
> >>>
> >>> .........................................
> >>>
> >>>  CC [M]  /home/jeff/work/ceph-client-standalone/osdmap.o
> >>>  CC [M]  /home/jeff/work/ceph-client-standalone/debugfs.o
> >>>  CC [M]  /home/jeff/work/ceph-client-standalone/auth.o
> >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
> >>>  Building modules, stage 2.
> >>>  MODPOST 1 modules
> >>> WARNING:
> >>> "task_dirty_inc" [/home/jeff/work/ceph-client-standalone/ceph.ko]
> >>> undefined!
> >>>  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
> >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
> >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-gene=
ric'
> >>> jeff@cephserver:~/work/ceph-client-standalone$
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> Is it a bug ? or i git wrong source package ?
> >>>
> >>> Thanks,
> >>> Jeff,Wu
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >>>
> >>
> >>
> >>
> >> --
> >> Yonggang Liu
> >> Advanced Computing and Information Systems Laboratory
> >> University of Florida
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
>=20
>=20
>=20
> --=20
> Yonggang Liu
> Advanced Computing and Information Systems Laboratory
> University of Florida
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
