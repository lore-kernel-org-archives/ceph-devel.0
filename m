From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Thu, 3 Sep 2015 09:06:47 -0400
Message-ID: <CAL-2WbEJbOrT9a_7rWT-Mv8VeDn5HVWk+ca55sGO7S98wqQnxQ@mail.gmail.com>
References: <55D409F0.3050802@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
 <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com>
 <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
 <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1DC70@SACMBXIP01.sdcorp.global.sandisk.com>
 <2058625694.43353019.1440262638523.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1FD73@SACMBXIP01.sdcorp.global.sandisk.com>
 <2128037732.12045835.1441271638443.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35323 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbICNHK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 09:07:10 -0400
Received: by lagj9 with SMTP id j9so28476756lag.2
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 06:07:08 -0700 (PDT)
In-Reply-To: <2128037732.12045835.1441271638443.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I believe preloading should work fine.  It has been a common way to
debug buffer overruns using electric fence and similar tools for
years, and I have used it in large applications of similar size to
Ceph.

Daniel

On Thu, Sep 3, 2015 at 5:13 AM, Shinobu Kinjo <skinjo@redhat.com> wrote=
:
>
> Pre loading jemalloc after compiling with malloc
>
> $ cat hoge.c
> #include <stdlib.h>
>
> int main()
> {
>     int *ptr =3D malloc(sizeof(int) * 10);
>
>     if (ptr =3D=3D NULL)
>         exit(EXIT_FAILURE);
>     free(ptr);
> }
>
>
> $ gcc ./hoge.c
>
>
> $ ldd ./a.out
>         linux-vdso.so.1 (0x00007fffe17e5000)
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fc989c5f000)
>         /lib64/ld-linux-x86-64.so.2 (0x000055a718762000)
>
>
> $ nm ./a.out | grep malloc
>                  U malloc@@GLIBC_2.2.5                       // mallo=
c loaded
>
>
> $ LD_PRELOAD=3D/usr/lib64/libjemalloc.so.1 \
> > ldd a.out
>         linux-vdso.so.1 (0x00007fff7fd36000)
>         /usr/lib64/libjemalloc.so.1 (0x00007fe6ffe39000)    // jemall=
o loaded
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fe6ffa61000)
>         libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007fe6ff8440=
00)
>         /lib64/ld-linux-x86-64.so.2 (0x0000560342ddf000)
>
>
> Logically it could work, but in real world I'm not 100% sure if it wo=
rks for large scale application.
>
> Shinobu
>
> ----- Original Message -----
> From: "Somnath Roy" <Somnath.Roy@sandisk.com>
> To: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Sage Weil" <sage@newdream.net>, "Milosz Tanski" <milosz@adfin.co=
m>, "Shishir Gowda" <Shishir.Gowda@sandisk.com>, "Stefan Priebe" <s.pri=
ebe@profihost.ag>, "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ce=
ph-devel@vger.kernel.org>
> Sent: Sunday, August 23, 2015 2:03:41 AM
> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
>
> Need to see if client is overriding the libraries built with differen=
t malloc libraries I guess..
> I am not sure in your case the benefit you are seeing is because of q=
emu is more efficient with tcmalloc/jemalloc or the entire client stack=
 ?
>
> -----Original Message-----
> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
> Sent: Saturday, August 22, 2015 9:57 AM
> To: Somnath Roy
> Cc: Sage Weil; Milosz Tanski; Shishir Gowda; Stefan Priebe; Mark Nels=
on; ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
> >>Wanted to know is there any reason we didn't link client libraries =
with tcmalloc at the first place (but did link only OSDs/mon/RGW) ?
>
> Do we need to link client librairies ?
>
> I'm building qemu with jemalloc , and it's seem to be enough.
>
>
>
> ----- Mail original -----
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> =C3=80: "Sage Weil" <sage@newdream.net>, "Milosz Tanski" <milosz@adfi=
n.com>
> Cc: "Shishir Gowda" <Shishir.Gowda@sandisk.com>, "Stefan Priebe" <s.p=
riebe@profihost.ag>, "aderumier" <aderumier@odiso.com>, "Mark Nelson" <=
mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Samedi 22 Ao=C3=BBt 2015 18:15:36
> Objet: RE: Ceph Hackathon: More Memory Allocator Testing
>
> Yes, even today rocksdb also linked with tcmalloc. It doesn't mean al=
l the application using rocksdb needs to be built with tcmalloc.
> Sage,
> Wanted to know is there any reason we didn't link client libraries wi=
th tcmalloc at the first place (but did link only OSDs/mon/RGW) ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Saturday, August 22, 2015 6:56 AM
> To: Milosz Tanski
> Cc: Shishir Gowda; Somnath Roy; Stefan Priebe; Alexandre DERUMIER; Ma=
rk Nelson; ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
> On Fri, 21 Aug 2015, Milosz Tanski wrote:
> > On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
> > <Shishir.Gowda@sandisk.com> wrote:
> > > Hi All,
> > >
> > > Have sent out a pull request which enables building librados/libr=
bd with either tcmalloc(as default) or jemalloc.
> > >
> > > Please find the pull request @
> > > https://github.com/ceph/ceph/pull/5628
> > >
> > > With regards,
> > > Shishir
> >
> > Unless I'm missing something here, this seams like the wrong thing =
to.
> > Libraries that will be linked in by other external applications sho=
uld
> > not have a 3rd party malloc linked in there. That seams like an
> > application choice. At the very least the default should not be to
> > link in a 3rd party malloc.
>
> Yeah, I think you're right.
>
> Note that this isn't/wasn't always the case, though.. on precise, for=
 instance, libleveldb links libtcmalloc. They stopped doing this someti=
me before trusty.
>
> sage
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
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
