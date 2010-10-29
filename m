From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-client-standalone bug update ,make,WARNING: "task_dirty_inc"
 ,ubuntu10.10 Linux-2.6.35-22-generic
Date: Fri, 29 Oct 2010 10:29:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010291018120.17302@cobra.newdream.net>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
 <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
 <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
 <Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net> <1288259734.2621.23.camel@osd1>
 <AANLkTikwQG6EWdr_kqmCGHR0iBnsQFWXZ8V+r7Vy+EjM@mail.gmail.com>
 <AANLkTinS72oaJK4GLkFC675PkV40EsFjCeJPRuLwJ_7J@mail.gmail.com>
 <AANLkTik5J8KAAnV67U4gkgEC9E8_C+z8ivaz2vB8Hg-4@mail.gmail.com>
 <1288318077.2332.3.camel@osd1>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-656080416-1288373341=:17302"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33901 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934246Ab0J2RZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 13:25:42 -0400
In-Reply-To: <1288318077.2332.3.camel@osd1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: Yonggang Liu <myidpt@gmail.com>, Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-656080416-1288373341=:17302
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Oct 2010, Jeff Wu wrote:
> Thank you Gregory and Yonggang,i git rbd-backport , make sucessfully.

A word of caution: the rbd-backport branch is really old and out of date. =
=20
The reason it compiles is because it doesn't have the task_dirty_inc call=
=20
at all.  And looking at it more closely, it looks like task_dirty_inc was=
=20
never exported to modules.  Whoops!  I'm not sure what the implications of=
=20
not calling it are (presumably the VMs space accounting gets out of=20
whack), but it was also missing from the upstream version until 2.6.36, so=
=20
I'll just drop it from the -backport branches.  (I suspect I added it when=
=20
the account_page_dirtied() call was added in 2.6.36 and noticed it was=20
doing it.)

In any case, the ceph-client-standalone.git is fixed up, and you should=20
now be able to use either master-backport or unstable-backport.

sage


>=20
> Regards,
> Jeff.Wu
> Transoft.inc=20
> Senior software Engineer
>=20
> =FF=FF 2010-10-29=FF=FF=FF=FF 00:54 +0800=FF=FFYonggang Liu=FF=FF=FF=FF=
=FF=FF
> > Solved. Thank you Gregory!
> > I used the branck rbd-backport and it works perfectly.
> >=20
> > Regards,
> >=20
> > On Thu, Oct 28, 2010 at 11:55 AM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> > > The ceph-client tree is always maintained against the latest rc from
> > > Linus. For any other kernel you need to use the -backports branches.
> > > It looks like this is what's causing both your troubles. :)
> > > -Greg
> > >
> > > On Thu, Oct 28, 2010 at 8:20 AM, Yonggang Liu <myidpt@gmail.com> wrot=
e:
> > >> The same thing happens here, I was using Debian 5.0 with kernel 2.6.=
32-5-686.
> > >> I had the following error message:
> > >> client:~/ceph-client-standalone# insmod ceph.ko
> > >> insmod: error inserting 'ceph.ko': -1 Unknown symbol in module
> > >> client:~/ceph-client-standalone# dmesg -c
> > >> [ 4295.877555] ceph: Unknown symbol task_dirty_inc
> > >>
> > >> Any ideas?
> > >>
> > >> On Thu, Oct 28, 2010 at 5:55 AM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > >>> Hi ,all
> > >>>
> > >>> At Ubuntu 10.10 x86_64 , kernel : Linux-2.6.35-22-generic ,
> > >>>
> > >>> I git Lastest ceph-client-standalone source codes from
> > >>> git://ceph.newdream.net/ceph-client-standalone.git
> > >>>
> > >>> it make fail, get the warning messages: "account_page_dirtied"
> > >>>
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Logs =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>>
> > >>> jeff@cephserver:~/work/ceph-client-standalone$ make
> > >>>
> > >>>  ...................................
> > >>>
> > >>> CC [M]  /home/jeff/work/ceph-client-standalone/ceph_hash.o
> > >>>  CC [M]  /home/jeff/work/ceph-client-standalone/ceph_frag.o
> > >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
> > >>>  Building modules, stage 2.
> > >>>  MODPOST 1 modules
> > >>> WARNING:
> > >>> "account_page_dirtied" [/home/jeff/work/ceph-client-standalone/ceph=
=2Eko]
> > >>> undefined!
> > >>>  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
> > >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
> > >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generi=
c'
> > >>> jeff@cephserver:~/work/ceph-client-standalone$
> > >>>
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >>>
> > >>> then  i change to master-backport, to make it ,
> > >>> still get a warning messages : "task_dirty_inc" .
> > >>>
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlogs=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >>>
> > >>> jeff@cephserver:~/work/ceph-client-standalone$ git checkout -b
> > >>> master-backport origin/master-backport
> > >>> Branch master-backport set up to track remote branch master-backpor=
t
> > >>> from origin.
> > >>> Switched to a new branch 'master-backport'
> > >>> jeff@cephserver:~/work/ceph-client-standalone$ git pull
> > >>> Already up-to-date.
> > >>>
> > >>> jeff@cephserver:~/work/ceph-client-standalone$ make
> > >>>
> > >>> .........................................
> > >>>
> > >>>  CC [M]  /home/jeff/work/ceph-client-standalone/osdmap.o
> > >>>  CC [M]  /home/jeff/work/ceph-client-standalone/debugfs.o
> > >>>  CC [M]  /home/jeff/work/ceph-client-standalone/auth.o
> > >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
> > >>>  Building modules, stage 2.
> > >>>  MODPOST 1 modules
> > >>> WARNING:
> > >>> "task_dirty_inc" [/home/jeff/work/ceph-client-standalone/ceph.ko]
> > >>> undefined!
> > >>>  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
> > >>>  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
> > >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generi=
c'
> > >>> jeff@cephserver:~/work/ceph-client-standalone$
> > >>>
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>>
> > >>> Is it a bug ? or i git wrong source package ?
> > >>>
> > >>> Thanks,
> > >>> Jeff,Wu
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > >>> the body of a message to majordomo@vger.kernel.org
> > >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>>
> > >>
> > >>
> > >>
> > >> --
> > >> Yonggang Liu
> > >> Advanced Computing and Information Systems Laboratory
> > >> University of Florida
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>
> > >
> >=20
> >=20
> >=20
> > --=20
> > Yonggang Liu
> > Advanced Computing and Information Systems Laboratory
> > University of Florida
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-656080416-1288373341=:17302--
