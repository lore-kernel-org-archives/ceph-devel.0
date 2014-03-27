From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Thu, 27 Mar 2014 09:49:35 +0100
Message-ID: <1395910175.18719.0.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
	 <1395780835.2076.15.camel@localhost> <1395781847.2076.21.camel@localhost>
	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	 <1395782577.2076.23.camel@localhost>
	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
	 <1395783675.2076.26.camel@localhost>
	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
	 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>
	 <5332075F.8080105@ieee.org> <1395788695.2076.35.camel@localhost>
	 <53321896.1080606@ieee.org> <1395797596.2076.43.camel@localhost>
	 <1395798658.2076.45.camel@localhost> <5332339A.8030000@ieee.org>
	 <1395801625.2076.52.camel@localhost> <53323EA5.6010506@ieee.org>
	 <1395801940.2076.54.camel@localhost> <53324F79.1080108@ieee.org>
	 <1395806447.2076.70.camel@localhost> <53325F09.7000306@ieee.org>
	 <5332B643.5040403@ieee.org>
	 <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
	 <53333F73.709@ieee.org> <1395906536.28805.9.camel@localhost>
	 <CALFYKtAE_akz72HW99h=HB8jsEOs84ERoftZzgLhunDz0HE8=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:43964 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbaC0Itk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 04:49:40 -0400
In-Reply-To: <CALFYKtAE_akz72HW99h=HB8jsEOs84ERoftZzgLhunDz0HE8=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>


Le jeudi 27 mars 2014 =C3=A0 10:45 +0200, Ilya Dryomov a =C3=A9crit :
> On Thu, Mar 27, 2014 at 9:48 AM, Olivier Bonvalet <ceph.list@daevel.f=
r> wrote:
> > Le mercredi 26 mars 2014 =C3=A0 15:58 -0500, Alex Elder a =C3=A9cri=
t :
> >> Olivier reports that with the simple patch I provided
> >> (which changed a "<" to a "!=3D" and removed an assertion)
> >> he is running successfully.
> >>
> >> To me this is fantastic news, and you can see I posted
> >> a patch with the fix.
> >>
> >> There remains a race condition though, one which I described
> >> in a separate message earlier today.  I don't think it will
> >> prove to be a problem in practice, but I agreed to work on
> >> a fix to ensure the race condition is eliminated.  It will
> >> require some work with reference counting image and object
> >> requests.
> >>
> >> The fix won't be coming today.  But I aim to provide it
> >> in a matter of several days.
> >>
> >>                                       -Alex
> >>
> >
> > One question from one of my customers : why am I the only one to
> > complain about that problem ?
> > I know that Ceph users often use qemu/librbd instead of kernel clie=
nt,
> > but what is the trigger of those =C2=ABrace condition=C2=BB ? Havin=
g "multiple
> > requests" per RBD image ? It should be a normal use, no ?
> >
> > If someone can help me give an explanation, thanks :)
>=20
> We've had a couple more, similar reports in the last few months.
> However you are the first reporter who was able to trigger this race
> often enough to track it down.  This race condition (read: bug) is
> kernel client specific, qemu/librbd is unaffected.  Having an rbd
> request that spans multiple RADOS objects and therefore results in
> multiple object requests is normal use, it's just that particular pie=
ce
> of code turned out to be prone to a subtle race.  You have to keep in
> mind that races are all about timing and relative order of events, so
> simply issuing a multi-object rbd request is not enough to trigger it=
,
> stars have to align too ;)
>=20
> Thanks,
>=20
>                 Ilya
>=20

Great, thanks !

Olivier

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
