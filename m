From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Thu, 3 Sep 2015 09:12:54 -0400 (EDT)
Message-ID: <354274899.12128337.1441285974829.JavaMail.zimbra@redhat.com>
References: <55D409F0.3050802@redhat.com> <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com> <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1DC70@SACMBXIP01.sdcorp.global.sandisk.com> <2058625694.43353019.1440262638523.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1FD73@SACMBXIP01.sdcorp.global.sandisk.com> <2128037732.12045835.1441271638443.JavaMail.zimbra@redhat.com> <CAL-2WbEJbOrT9a_7rWT-Mv8VeDn5HVWk+ca55sGO7S98wqQnxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:57788 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbICNMz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 09:12:55 -0400
In-Reply-To: <CAL-2WbEJbOrT9a_7rWT-Mv8VeDn5HVWk+ca55sGO7S98wqQnxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We've frequently run fio + libosd (cohort ceph-osd linked as a library)=
 with jemalloc preloaded, without problems.

Matt

--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309

----- Original Message -----
> From: "Daniel Gryniewicz" <dang@redhat.com>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Thursday, September 3, 2015 9:06:47 AM
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> I believe preloading should work fine.  It has been a common way to
> debug buffer overruns using electric fence and similar tools for
> years, and I have used it in large applications of similar size to
> Ceph.
>=20
> Daniel
>=20
> On Thu, Sep 3, 2015 at 5:13 AM, Shinobu Kinjo <skinjo@redhat.com> wro=
te:
> >
> > Pre loading jemalloc after compiling with malloc
> >
> > $ cat hoge.c
> > #include <stdlib.h>
> >
> > int main()
> > {
> >     int *ptr =3D malloc(sizeof(int) * 10);
> >
> >     if (ptr =3D=3D NULL)
> >         exit(EXIT_FAILURE);
> >     free(ptr);
> > }
> >
> >
> > $ gcc ./hoge.c
> >
> >
> > $ ldd ./a.out
> >         linux-vdso.so.1 (0x00007fffe17e5000)
> >         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fc989c5f000)
> >         /lib64/ld-linux-x86-64.so.2 (0x000055a718762000)
> >
> >
> > $ nm ./a.out | grep malloc
> >                  U malloc@@GLIBC_2.2.5                       // mal=
loc
> >                  loaded
> >
> >
> > $ LD_PRELOAD=3D/usr/lib64/libjemalloc.so.1 \
> > > ldd a.out
> >         linux-vdso.so.1 (0x00007fff7fd36000)
> >         /usr/lib64/libjemalloc.so.1 (0x00007fe6ffe39000)    // jema=
llo
> >         loaded
> >         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fe6ffa61000)
> >         libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007fe6ff84=
4000)
> >         /lib64/ld-linux-x86-64.so.2 (0x0000560342ddf000)
> >
> >
> > Logically it could work, but in real world I'm not 100% sure if it =
works
> > for large scale application.
> >
> > Shinobu
> >
> > ----- Original Message -----
> > From: "Somnath Roy" <Somnath.Roy@sandisk.com>
> > To: "Alexandre DERUMIER" <aderumier@odiso.com>
> > Cc: "Sage Weil" <sage@newdream.net>, "Milosz Tanski" <milosz@adfin.=
com>,
> > "Shishir Gowda" <Shishir.Gowda@sandisk.com>, "Stefan Priebe"
> > <s.priebe@profihost.ag>, "Mark Nelson" <mnelson@redhat.com>, "ceph-=
devel"
> > <ceph-devel@vger.kernel.org>
> > Sent: Sunday, August 23, 2015 2:03:41 AM
> > Subject: RE: Ceph Hackathon: More Memory Allocator Testing
> >
> > Need to see if client is overriding the libraries built with differ=
ent
> > malloc libraries I guess..
> > I am not sure in your case the benefit you are seeing is because of=
 qemu is
> > more efficient with tcmalloc/jemalloc or the entire client stack ?
> >
> > -----Original Message-----
> > From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
> > Sent: Saturday, August 22, 2015 9:57 AM
> > To: Somnath Roy
> > Cc: Sage Weil; Milosz Tanski; Shishir Gowda; Stefan Priebe; Mark Ne=
lson;
> > ceph-devel
> > Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >
> > >>Wanted to know is there any reason we didn't link client librarie=
s with
> > >>tcmalloc at the first place (but did link only OSDs/mon/RGW) ?
> >
> > Do we need to link client librairies ?
> >
> > I'm building qemu with jemalloc , and it's seem to be enough.
> >
> >
> >
> > ----- Mail original -----
> > De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> > =C3=80: "Sage Weil" <sage@newdream.net>, "Milosz Tanski" <milosz@ad=
fin.com>
> > Cc: "Shishir Gowda" <Shishir.Gowda@sandisk.com>, "Stefan Priebe"
> > <s.priebe@profihost.ag>, "aderumier" <aderumier@odiso.com>, "Mark N=
elson"
> > <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> > Envoy=C3=A9: Samedi 22 Ao=C3=BBt 2015 18:15:36
> > Objet: RE: Ceph Hackathon: More Memory Allocator Testing
> >
> > Yes, even today rocksdb also linked with tcmalloc. It doesn't mean =
all the
> > application using rocksdb needs to be built with tcmalloc.
> > Sage,
> > Wanted to know is there any reason we didn't link client libraries =
with
> > tcmalloc at the first place (but did link only OSDs/mon/RGW) ?
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Saturday, August 22, 2015 6:56 AM
> > To: Milosz Tanski
> > Cc: Shishir Gowda; Somnath Roy; Stefan Priebe; Alexandre DERUMIER; =
Mark
> > Nelson; ceph-devel
> > Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >
> > On Fri, 21 Aug 2015, Milosz Tanski wrote:
> > > On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
> > > <Shishir.Gowda@sandisk.com> wrote:
> > > > Hi All,
> > > >
> > > > Have sent out a pull request which enables building librados/li=
brbd
> > > > with either tcmalloc(as default) or jemalloc.
> > > >
> > > > Please find the pull request @
> > > > https://github.com/ceph/ceph/pull/5628
> > > >
> > > > With regards,
> > > > Shishir
> > >
> > > Unless I'm missing something here, this seams like the wrong thin=
g to.
> > > Libraries that will be linked in by other external applications s=
hould
> > > not have a 3rd party malloc linked in there. That seams like an
> > > application choice. At the very least the default should not be t=
o
> > > link in a 3rd party malloc.
> >
> > Yeah, I think you're right.
> >
> > Note that this isn't/wasn't always the case, though.. on precise, f=
or
> > instance, libleveldb links libtcmalloc. They stopped doing this som=
etime
> > before trusty.
> >
> > sage
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail mess=
age is
> > intended only for the use of the designated recipient(s) named abov=
e. If
> > the reader of this message is not the intended recipient, you are h=
ereby
> > notified that you have received this message in error and that any =
review,
> > dissemination, distribution, or copying of this message is strictly
> > prohibited. If you have received this communication in error, pleas=
e
> > notify the sender by telephone or e-mail (as shown above) immediate=
ly and
> > destroy any and all copies of this message in your possession (whet=
her
> > hard copies or electronically stored copies).
> >
> > N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
